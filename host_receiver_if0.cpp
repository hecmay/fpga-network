
#include "xcl2.hpp"

#include <vector>
#include <chrono>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <fstream>
#include <iostream>

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

#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <time.h>
#include <string.h>

#define BYTES_PER_PACKET 1408
#define MY_IP_ADDR 0xC0A80102
#define THEIR_IP_ADDR 0xC0A80101
#define IP_GATEWAY 0xC0A801FF
#define ARP_DISCOVERY 0x3010
#define ARP_IP_ADDR_OFFSET 0x3400
#define ARP_MAC_ADDR_OFFSET 0x3800
#define ARP_VALID_OFFSET 0x3100
#define IP_ADDR_OFFSET 0x0018
#define IP_GATEWAY_OFFSET 0x001C
#define MAC_ADDR_OFFSET 0x0010
#define NUM_SOCKETS_HW 0x2210
#define UDP_OFFSET 0x2000

typedef struct
{
	uint32_t theirIP;
	uint16_t theirPort;
	uint16_t myPort;
	bool valid;
} socket_type;

void ntpdate()
{
	// char *hostname=(char *)"163.117.202.33";
	// char *hostname=(char *)"pool.ntp.br";
	char *hostname = (char *)"200.20.186.76";
	int portno = 123;									   // NTP is port 123
	int maxlen = 1024;									   // check our buffers
	int i;												   // misc var i
	unsigned char msg[48] = {010, 0, 0, 0, 0, 0, 0, 0, 0}; // the packet we send
	unsigned long buf[maxlen];							   // the buffer we get back
	// struct in_addr ipaddr;        //
	struct protoent *proto; //
	struct sockaddr_in server_addr;
	int s;	   // socket
	long tmit; // the time -- This is a time_t sort of

	// use Socket;
	//
	// #we use the system call to open a UDP socket
	// socket(SOCKET, PF_INET, SOCK_DGRAM, getprotobyname("udp")) or die "socket: $!";
	proto = getprotobyname("udp");
	s = socket(PF_INET, SOCK_DGRAM, proto->p_proto);
	perror("socket");
	//
	// #convert hostname to ipaddress if needed
	//$ipaddr   = inet_aton($HOSTNAME);
	memset(&server_addr, 0, sizeof(server_addr));
	server_addr.sin_family = AF_INET;
	server_addr.sin_addr.s_addr = inet_addr(hostname);
	// argv[1] );
	// i   = inet_aton(hostname,&server_addr.sin_addr);
	server_addr.sin_port = htons(portno);
	// printf("ipaddr (in hex): %x\n",server_addr.sin_addr);

	/*
	 * build a message.  Our message is all zeros except for a one in the
	 * protocol version field
	 * msg[] in binary is 00 001 000 00000000
	 * it should be a total of 48 bytes long
	 */

	// send the data
	printf("sending data..\n");
	i = sendto(s, msg, sizeof(msg), 0, (struct sockaddr *)&server_addr, sizeof(server_addr));
	perror("sendto");
	// get the data back
	struct sockaddr saddr;
	socklen_t saddr_l = sizeof(saddr);
	i = recvfrom(s, buf, 48, 0, &saddr, &saddr_l);
	perror("recvfr:");
 
    // LONG WORD = 4 BYTES (32-bit)
	// WORD = 2 BYTES (16-bits)

	// We get 12 long words back in Network order (big-endian, MSB comes first)
	for(i=0;i<12;i++) {
		//printf("%d\t%-8x\n",i,ntohl(buf[i]));
		long tmit2=ntohl((time_t)buf[i]); // 32-bit data to time stamp
		std::cout << "Round number " << i << " time is " << ctime(&tmit2)  << std::endl;
	}

	/*
	 * The high word of transmit time is the 10th word we get back
	 * tmit is the time in seconds not accounting for network delays which
	 * should be way less than a second if this is a local NTP server
	 */

	// tmit=ntohl((time_t)buf[10]);    //# get transmit time
	tmit = ntohl((time_t)buf[4]); // # get transmit time
	long frac = ntohl((time_t)buf[5]); 

	uint64_t ns = ((frac * 1000000000ULL) / 4294967296ULL);
	auto ns_duration = std::chrono::nanoseconds(ns);

	// printf("tmit=%d\n",tmit);

	/*
	 * Convert time to unix standard time NTP is number of seconds since 0000
	 * UT on 1 January 1900 unix time is seconds since 0000 UT on 1 January
	 * 1970 There has been a trend to add a 2 leap seconds every 3 years.
	 * Leap seconds are only an issue the last second of the month in June and
	 * December if you don't try to set the clock then it can be ignored but
	 * this is importaint to people who coordinate times with GPS clock sources.
	 */

	tmit -= 2208988800U;
	// printf("tmit=%d\n",tmit);
	/* use unix library function to show me the local time (it takes care
	 * of timezone issues for both north and south of the equator and places
	 * that do Summer time/ Daylight savings time.
	 */

	// #compare to system time
	// printf("Time: %s",ctime(&tmit));
	std::cout << "time is " << ctime(&tmit) << "s, " << ns_duration.count() << " ns" << std::endl;

	i = time(0);
	// printf("%d-%d=%d\n",i,tmit,i-tmit);
	// printf("System time is %d seconds off\n",(i-tmit));
	std::cout << "System time is " << (i - tmit) << " seconds off" << std::endl;
}

int main(int argc, char **argv)
{
	unsigned char *kernelBinary;
	const char *xclbinFilename;
	cl_int err;
	if (argc < 2)
	{
		std::cout << "Usage: " << argv[0] << " <XCLBIN File> [<#Rx Pkt>] [<decrypt>] [<My Ip>] [<Their IP>] [<IP Gateway>]" << std::endl;
		return EXIT_FAILURE;
	}
	else
	{
		xclbinFilename = argv[1];
		std::cout << "Using FPGA binary file specfied through the command line: " << xclbinFilename << std::endl;
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
	unsigned int dec = 0;

	if (argc >= 3)
	{
		rxPkt = strtol(argv[2], NULL, 10);
		packet_size_total = BYTES_PER_PACKET * rxPkt;
	}

	if (argc >= 4)
	{
		if (strcmp(argv[3], "decrypt") == 0)
		{
			printf("decryption enabled...\n");
			dec = 1;
		}
		else if (strcmp(argv[3], "no-decrypt") == 0)
		{
			printf("decryption not enabled...\n");
			dec = 0;
		}
	}

	err = clGetPlatformIDs(0, NULL, &num_platforms);
	printf("Number of available platforms = %d\n", num_platforms);
	platform_id = (cl_platform_id *)malloc(sizeof(cl_platform_id) * num_platforms);
	err = clGetPlatformIDs(num_platforms, platform_id, NULL);
	if (err != CL_SUCCESS)
	{
		printf("Error: clGetPlatformIDs failed!\n");
		return EXIT_FAILURE;
	}
	// Get characteristics for each platform
	for (uint i = 0; i < num_platforms; i++)
	{
		err = clGetDeviceIDs(platform_id[i], CL_DEVICE_TYPE_ALL, 1, &device_id, &deviceCount);
		if (err != CL_SUCCESS)
		{
			printf("Error: clGetDeviceIDs failed!\n");
			return EXIT_FAILURE;
		}
		context = clCreateContext(0, 1, &device_id, NULL, NULL, &err);
		q = clCreateCommandQueue(context, device_id, CL_QUEUE_PROFILING_ENABLE, &err);
		printf("Device count %d\n", deviceCount);
		int size = load_file_to_memory(xclbinFilename, (char **)&kernelBinary);
		printf("xclbin size: %d\n", size);
		size_t size_var = size;
		if (!(program = clCreateProgramWithBinary(context, 1, &device_id, &size_var, (const unsigned char **)&kernelBinary, &binaryStatus, &err)))
			return EXIT_FAILURE;
	}

	cmac = clCreateKernel(program, "cmac_0", &err);
	nl = clCreateKernel(program, "networklayer", &err);
	xclGetComputeUnitInfo(cmac, 0, XCL_COMPUTE_UNIT_INDEX, sizeof(cmacidx), &cmacidx, NULL);
	xclGetComputeUnitInfo(nl, 0, XCL_COMPUTE_UNIT_INDEX, sizeof(nlidx), &nlidx, NULL);
	clGetDeviceInfo(device_id, CL_DEVICE_HANDLE, sizeof(handle), &handle, NULL);

	std::ifstream bin_file(xclbinFilename, std::ifstream::binary);
	bin_file.seekg(0, bin_file.end);
	unsigned nb = bin_file.tellg();
	bin_file.seekg(0, bin_file.beg);
	char *buf = new char[nb];
	bin_file.read(buf, nb);

	xclbin_uuid(buf, xclbinId);

	xclOpenContext(handle, xclbinId, nlidx, false);

	unsigned int my_ip_address = argc >= 5 ? (unsigned int)strtol(argv[4], NULL, 16) : (unsigned int)MY_IP_ADDR;
	unsigned int their_ip_address = argc >= 6 ? (unsigned int)strtol(argv[5], NULL, 16) : (unsigned int)THEIR_IP_ADDR;
	unsigned int ip_gateway = argc >= 7 ? (unsigned int)strtol(argv[6], NULL, 16) : (unsigned int)IP_GATEWAY;
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

	if (num_sockets_hw != num_sockets_sw)
	{
		printf("HW Socket list for device [0] should be [%d], is [%d]\n", num_sockets_sw, num_sockets_hw);
		fflush(stdout);
		xclCloseContext(handle, xclbinId, nlidx);
		return 1;
	}
	for (unsigned int i = 0; i < num_sockets_hw; i++)
	{
		uint32_t TI_OFFSET = 0x10 + i * 8;
		uint32_t TP_OFFSET = TI_OFFSET + 16 * 8;
		uint32_t MP_OFFSET = TI_OFFSET + 16 * 8 * 2;
		uint32_t V_OFFSET = TI_OFFSET + 16 * 8 * 3;

		xclRegWrite(handle, nlidx, UDP_OFFSET + TI_OFFSET, sockets[i].theirIP);
		xclRegWrite(handle, nlidx, UDP_OFFSET + TP_OFFSET, sockets[i].theirPort);
		xclRegWrite(handle, nlidx, UDP_OFFSET + MP_OFFSET, sockets[i].myPort);
		xclRegWrite(handle, nlidx, UDP_OFFSET + V_OFFSET, sockets[i].valid);
	}

	for (int i = 0; i < 256; i++)
	{
		xclRegWrite(handle, nlidx, ARP_VALID_OFFSET + (i / 4) * 4, 0);
	}

	xclRegWrite(handle, nlidx, ARP_DISCOVERY, 0);
	xclRegWrite(handle, nlidx, ARP_DISCOVERY, 1);
	xclRegWrite(handle, nlidx, ARP_DISCOVERY, 0);

	// ARP
	for (int i = 0; i < 256; i++)
	{
		unsigned valid_entry;
		xclRegRead(handle, nlidx, ARP_VALID_OFFSET + (i / 4) * 4, &valid_entry);
		valid_entry = (valid_entry >> ((i % 4) * 8)) & 0x1;
		if (valid_entry)
		{
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

	if (rx_status & 0x1)
	{
		printf("Link is active\n");
	}
	else
	{
		printf("Link is not active\n");
		return EXIT_FAILURE;
	}

	// User logic stuff
	ul = clCreateKernel(program, "rxkrnl", &err);
	auto packet_size_bytes = sizeof(uint8_t) * packet_size_total;
	buffer_packetdata = clCreateBuffer(context, CL_MEM_WRITE_ONLY, packet_size_bytes, NULL, &err);
	cl_uint pst = (cl_uint)packet_size_bytes;
	clSetKernelArg(ul, 0, sizeof(cl_mem), &buffer_packetdata);
	clSetKernelArg(ul, 2, sizeof(cl_uint), &pst);
	clSetKernelArg(ul, 3, sizeof(cl_uint), &dec);
	uint8_t *ptr_packetdata = (uint8_t *)clEnqueueMapBuffer(q, buffer_packetdata, CL_TRUE, CL_MAP_READ, 0, packet_size_bytes, 0, NULL, NULL, &err);
	const cl_mem mems[1] = {buffer_packetdata};
	printf("Enqueue user kernel...\n");

	clEnqueueTask(q, ul, 0, NULL, NULL);
	clEnqueueMigrateMemObjects(q, 1, mems, CL_MIGRATE_MEM_OBJECT_HOST, 0, NULL, NULL);
	clFinish(q);

	ntpdate();
	for (unsigned int i = 0; i < packet_size_total; i++)
	{
		printf("%c", ptr_packetdata[i]);
	}
	printf("\n");
	printf("Message received\n");
	return 0;
}
