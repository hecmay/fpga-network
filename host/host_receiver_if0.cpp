#include "xcl2.hpp"
#include <vector>
#include <chrono>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <fstream>
#include <iostream>
#include <iomanip>

#include "xclhal2.h"

#include <CL/cl2.hpp>
#include <CL/cl_ext_xilinx.h>
#include <unistd.h>
#include <uuid/uuid.h>
#include <limits.h>
#include <sys/stat.h>
#include "CL/cl_ext_xilinx.h"
#include "experimental/xclbin_util.h"

#include "fileops.h"

#define BYTES_PER_PACKET 1408
#define MY_IP_ADDR 0xC0A80102
#define THEIR_IP_ADDR 0xC0A80101

#define IP_GATEWAY 0xC0A801FF
#define ARP_DISCOVERY 0x1010
#define ARP_IP_ADDR_OFFSET 0x1400
#define ARP_MAC_ADDR_OFFSET 0x1800
#define ARP_VALID_OFFSET 0x1100

#define IP_ADDR_OFFSET 0x0018
#define IP_GATEWAY_OFFSET 0x001C
#define MAC_ADDR_OFFSET 0x0010
#define NUM_SOCKETS_HW 0x0A10

#define UDP_TI_OFFSET 0x0810
#define UDP_TP_OFFSET 0x0890
#define UDP_MP_OFFSET 0x0910
#define UDP_V_OFFSET 0x0990

typedef struct {
	uint32_t theirIP;
	uint16_t theirPort;
	uint16_t myPort;
	bool valid;
} socket_type;

int main(int argc, char **argv) {
	unsigned char *kernelBinary;
    	const char* xclbinFilename;
    	cl_int err;
    	if (argc < 2){
		std::cout << "Usage: " << argv[0] << " <XCLBIN File> [<#Rx Pkt>] [<decrypt>] [<My Ip>] [<Their IP>] [<IP Gateway>]" << std::endl;
        	return EXIT_FAILURE;
	}
	else{
		xclbinFilename = argv[1];
		std::cout <<"Using FPGA binary file specfied through the command line: " << xclbinFilename << std::endl;
	}



    	// Load xclbin 
    	std::cout << "Loading: '" << xclbinFilename << "'\n";
    	cl_uint num_platforms;
    	cl_uint deviceCount;
    	cl_platform_id *platform_id;
    	cl_device_id device_id; 
    	cl_program program;


    	cl_context context;
    	cl_command_queue q;
    	cl_int binaryStatus;
    	xclDeviceHandle handle;
    	xuid_t xclbinId;
    	cl_kernel nl;
    	cl_kernel cmac;
    	cl_kernel ul;
    	cl_uint nlidx;
    	cl_uint cmacidx;
   	socket_type sockets[16] = {0};
    	unsigned int packet_size_total; 
    	uint32_t rxPkt = 3200;
    	cl_mem buffer_packetdata;

    	if(argc >= 3){
		rxPkt = strtol(argv[2], NULL, 10);
		packet_size_total = BYTES_PER_PACKET*rxPkt; 
	}


    	err = clGetPlatformIDs(0, NULL, &num_platforms); 
    	printf("Number of available platforms = %d\n", num_platforms);
    	platform_id = (cl_platform_id *) malloc(sizeof(cl_platform_id) * num_platforms);
    	err = clGetPlatformIDs(num_platforms, platform_id, NULL); 
    	if (err != CL_SUCCESS) {
		printf("Error: clGetPlatformIDs failed!\n"); 
     		return EXIT_FAILURE;
	}
    	// Get characteristics for each platform
    	for (uint i = 0; i < num_platforms; i++){
		err = clGetDeviceIDs(platform_id[i], CL_DEVICE_TYPE_ALL, 1, &device_id, &deviceCount);
		if (err != CL_SUCCESS) {
			printf("Error: clGetDeviceIDs failed!\n"); 
      			return EXIT_FAILURE;
		}
		context = clCreateContext(0, 1, &device_id, NULL, NULL, &err);
       		q = clCreateCommandQueue(context, device_id, CL_QUEUE_PROFILING_ENABLE, &err);
       		printf("Device count %d\n",deviceCount); 
       		int size=load_file_to_memory(xclbinFilename, (char **) &kernelBinary);
       		printf("xclbin size: %d\n",size);
       		size_t size_var = size; 
		if (!(program = clCreateProgramWithBinary(context, 1, &device_id, &size_var, (const unsigned char **) &kernelBinary, &binaryStatus, &err))) return EXIT_FAILURE;
	}
   
	cmac = clCreateKernel(program, "cmac_0", &err);
    	nl = clCreateKernel(program, "networklayer",&err);
    	xclGetComputeUnitInfo(cmac, 0, XCL_COMPUTE_UNIT_INDEX, sizeof(cmacidx), &cmacidx, NULL);
    	xclGetComputeUnitInfo(nl, 0, XCL_COMPUTE_UNIT_INDEX, sizeof(nlidx), &nlidx, NULL);
    	clGetDeviceInfo(device_id, CL_DEVICE_HANDLE, sizeof(handle), &handle, NULL);
 
    	std::ifstream bin_file(xclbinFilename, std::ifstream::binary);
    	bin_file.seekg (0, bin_file.end);
    	unsigned nb = bin_file.tellg();
    	bin_file.seekg (0, bin_file.beg);
    	char *buf = new char [nb];
    	bin_file.read(buf, nb);
    
    	xclbin_uuid(buf, xclbinId);
    
    	xclOpenContext(handle, xclbinId, nlidx, false);
	
	unsigned int my_ip_address = argc>=5 ? (unsigned int)strtol(argv[4], NULL, 16) : (unsigned int)MY_IP_ADDR;
        unsigned int their_ip_address = argc>=6 ? (unsigned int)strtol(argv[5], NULL, 16) : (unsigned int)THEIR_IP_ADDR;
        unsigned int ip_gateway = argc>=7 ? (unsigned int)strtol(argv[6], NULL, 16) : (unsigned int)IP_GATEWAY;
        long mac_address = (0xf0f1f2f3f4f5 & 0xFFFFFFFFFF0) + (my_ip_address & 0xF);
    	xclRegWrite(handle, nlidx, MAC_ADDR_OFFSET, mac_address); 
    	xclRegWrite(handle, nlidx, MAC_ADDR_OFFSET + 4, mac_address >> 32);
    	xclRegWrite(handle, nlidx, IP_ADDR_OFFSET, my_ip_address); 
    	xclRegWrite(handle, nlidx, IP_GATEWAY_OFFSET, ip_gateway); 

	unsigned num_sockets_hw = 0, num_sockets_sw = sizeof(sockets) / sizeof(sockets[0]);
    	sockets[0].theirIP = their_ip_address;
    	sockets[0].theirPort = 50000;
    	sockets[0].myPort = 60000;
    	sockets[0].valid = true;
    	printf("My port %d\n", sockets[0].myPort);
    	printf("Their port %d\n", sockets[0].theirPort); 
    	printf("My IP address: %x\n", my_ip_address);
    	printf("Their IP address: %x\n", their_ip_address); 
    	printf("My MAC address: %lx\n", mac_address); 
    	xclRegRead(handle, nlidx, NUM_SOCKETS_HW, &num_sockets_hw);
    	printf("Number of sockets HW: %d\n", num_sockets_hw);

    	if (num_sockets_hw != num_sockets_sw) {
		printf("HW Socket list for device [0] should be [%d], is [%d]\n", num_sockets_sw, num_sockets_hw);
		fflush(stdout);
		xclCloseContext(handle, xclbinId, nlidx);
		return 1;
	}
    	for (unsigned int i = 0; i < num_sockets_hw; i++) {
		uint32_t TI_OFFSET = UDP_TI_OFFSET + i * 8;
		uint32_t TP_OFFSET = UDP_TP_OFFSET + i * 8;
		uint32_t MP_OFFSET = UDP_MP_OFFSET + i * 8;
		uint32_t V_OFFSET  = UDP_V_OFFSET + i * 8;

		xclRegWrite(handle, nlidx, TI_OFFSET, sockets[i].theirIP);
		xclRegWrite(handle, nlidx, TP_OFFSET, sockets[i].theirPort);
		xclRegWrite(handle, nlidx, MP_OFFSET, sockets[i].myPort);
		xclRegWrite(handle, nlidx, V_OFFSET, sockets[i].valid);
	}

    for(int i = 0; i < 256; i++) {
		xclRegWrite(handle, nlidx, ARP_VALID_OFFSET + (i / 4) * 4, 0);
	}

    xclRegWrite(handle, nlidx, ARP_DISCOVERY, 0);
    xclRegWrite(handle, nlidx, ARP_DISCOVERY, 1); 
    xclRegWrite(handle, nlidx, ARP_DISCOVERY, 0);

    //ARP
    for (int i = 0; i < 256; i++) {
            unsigned valid_entry;
            xclRegRead(handle, nlidx, ARP_VALID_OFFSET + (i / 4) * 4, &valid_entry);
            valid_entry = (valid_entry >> ((i % 4) * 8)) & 0x1; 
            if (valid_entry){
                printf("ARP valid entry found at %d\n", i);
	    }	
	}

    xclCloseContext(handle, xclbinId, nlidx);
    xclOpenContext(handle, xclbinId, cmacidx, false);
    unsigned tx_status = 0;
    unsigned rx_status = 0;
    xclRegRead(handle, cmacidx, 0x0200, &tx_status);
    xclRegRead(handle, cmacidx, 0x0200, &tx_status);
    xclRegRead(handle, cmacidx, 0x0204, &rx_status);
    xclRegRead(handle, cmacidx, 0x0204, &rx_status);
    xclCloseContext(handle, xclbinId, cmacidx);
    printf("TX status %d\n", tx_status);
    printf("RX status %d\n", rx_status);

    if (rx_status & 0x1){
	printf("Link is active\n");
    }
    else{
	printf("Link is not active\n"); 
        return EXIT_FAILURE;
    }

    // User logic stuff
    ul = clCreateKernel(program, "rxkrnl", &err);
    auto packet_size_bytes = sizeof(uint8_t) * packet_size_total; 
    buffer_packetdata = clCreateBuffer(context, CL_MEM_WRITE_ONLY, packet_size_bytes, NULL, &err);  
    cl_uint pst = (cl_uint)packet_size_bytes; 
    clSetKernelArg(ul, 0,  sizeof(cl_mem), &buffer_packetdata);
    clSetKernelArg(ul, 2,  sizeof(cl_uint), &pst); 

    uint8_t *ptr_packetdata = (uint8_t *)clEnqueueMapBuffer(q, buffer_packetdata, CL_TRUE, CL_MAP_READ, 0, packet_size_bytes, 0, NULL, NULL, &err);
    const cl_mem mems[1] = {buffer_packetdata}; 
    printf("Enqueue user kernel...\n");
    clEnqueueTask(q, ul, 0, NULL, NULL); 
    clEnqueueMigrateMemObjects(q, 1, mems, CL_MIGRATE_MEM_OBJECT_HOST, 0, NULL, NULL);
    clFinish(q); 
	auto now = std::chrono::high_resolution_clock::now();

    for (unsigned int i=0; i<packet_size_total; i++){
	    printf("%c",ptr_packetdata[i]); 
    }
    printf("\n");
    printf("Message received.\n");

  auto time = std::chrono::system_clock::to_time_t(now);
  auto tm = *std::gmtime(&time);

  auto epoch = now.time_since_epoch();
  auto ns = std::chrono::duration_cast<std::chrono::nanoseconds>(epoch).count() % 1000000000;

  std::cout << std::put_time(&tm, "%F %T.") << ns << std::put_time(&tm, " %Z\n");
    return 0;	
}
