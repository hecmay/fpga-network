#include <CL/cl_ext_xilinx.h>
#include <limits.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <unistd.h>
#include <uuid/uuid.h>

#include <CL/cl2.hpp>
#include <chrono>
#include <fstream>
#include <iostream>
#include <vector>

#include "CL/cl_ext_xilinx.h"
#include "experimental/xclbin_util.h"
#include "fileops.h"
#include "xcl2.hpp"
#include "xclhal2.h"

#define BYTES_PER_PACKET 1408

#define MY_IP_ADDR0 0xC0A80101 // 192.168.1.1
#define THEIR_IP_ADDR0 0xC0A80102 // 192.168.1.2
#define MY_IP_ADDR1 0xC0A80103 // 192.168.1.3
#define THEIR_IP_ADDR1 0xC0A80104 // 192.168.1.4

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
  const char *xclbinFilename;
  cl_int err;
  if (argc < 2) {
    std::cout
        << "Usage: " << argv[0]
        << " <XCLBIN File> <#Tx Pkt> "
           "[<My IP 0> <My IP 1>] [<Their IP 0> <Their IP 1>] [<IP Gateway>]"
        << std::endl;
    return EXIT_FAILURE;

  } else {
    xclbinFilename = argv[1];
    std::cout << "Using FPGA binary file specfied through the command line: "
              << xclbinFilename << std::endl;
  }

  // Load xclbin
  std::cout << "Loading: '" << xclbinFilename << "'\n";
  cl_uint num_platforms;
  cl_uint deviceCount;
  cl_platform_id *platform_id;
  cl_device_id device_id;
  cl_program program;
  cl_context context;
  cl_command_queue q[2];
  cl_int binaryStatus;
  xclDeviceHandle handle;
  xuid_t xclbinId;

  cl_kernel nl;
  cl_kernel cmac[2];
  cl_kernel ul[2];
  cl_uint nlidx[2];
  cl_uint cmacidx[2];
  socket_type sockets[2][16] = {0};

  unsigned int packet_size_total_0;
  unsigned int packet_size_total_1;

  uint32_t txPkt = 3200;

  cl_mem buffer_packetdata0;
  cl_mem buffer_packetdata1;

  if (argc >= 3) {
    txPkt = strtol(argv[2], NULL, 10);
    packet_size_total_0 = BYTES_PER_PACKET * txPkt;
    packet_size_total_1 = BYTES_PER_PACKET * txPkt;
  }

  err = clGetPlatformIDs(0, NULL, &num_platforms);
  printf("Number of available platforms = %d\n", num_platforms);
  platform_id =
      (cl_platform_id *)malloc(sizeof(cl_platform_id) * num_platforms);
  err = clGetPlatformIDs(num_platforms, platform_id, NULL);
  if (err != CL_SUCCESS) {
    printf("Error: clGetPlatformIDs failed!\n");
    return EXIT_FAILURE;
  }
  // Get characteristics for each platform
  for (uint i = 0; i < num_platforms; i++) {
    err = clGetDeviceIDs(platform_id[i], CL_DEVICE_TYPE_ALL, 1, &device_id,
                         &deviceCount);
    if (err != CL_SUCCESS) {
      printf("Error: clGetDeviceIDs failed!\n");
      return EXIT_FAILURE;
    }
    context = clCreateContext(0, 1, &device_id, NULL, NULL, &err);
    q[0] = clCreateCommandQueue(context, device_id, CL_QUEUE_PROFILING_ENABLE,
                                &err);
    q[1] = clCreateCommandQueue(context, device_id, CL_QUEUE_PROFILING_ENABLE,
                                &err);
    printf("Device count %d\n", deviceCount);
    int size = load_file_to_memory(xclbinFilename, (char **)&kernelBinary);
    printf("xclbin size: %d\n", size);
    size_t size_var = size;
    if (!(program = clCreateProgramWithBinary(
              context, 1, &device_id, &size_var,
              (const unsigned char **)&kernelBinary, &binaryStatus, &err)))
      return EXIT_FAILURE;
  }

  cmac[0] = clCreateKernel(program, "cmac_0", &err);
  cmac[1] = clCreateKernel(program, "cmac_1", &err);
  nl = clCreateKernel(program, "networklayer", &err);
  xclGetComputeUnitInfo(cmac[0], 0, XCL_COMPUTE_UNIT_INDEX, sizeof(cmacidx[0]),
                        &cmacidx[0], NULL);
  xclGetComputeUnitInfo(cmac[1], 0, XCL_COMPUTE_UNIT_INDEX, sizeof(cmacidx[1]),
                        &cmacidx[1], NULL);
  xclGetComputeUnitInfo(nl, 0, XCL_COMPUTE_UNIT_INDEX, sizeof(nlidx[0]),
                        &nlidx[0], NULL);
  xclGetComputeUnitInfo(nl, 1, XCL_COMPUTE_UNIT_INDEX, sizeof(nlidx[1]),
                        &nlidx[1], NULL);
  clGetDeviceInfo(device_id, CL_DEVICE_HANDLE, sizeof(handle), &handle, NULL);

  std::ifstream bin_file(xclbinFilename, std::ifstream::binary);
  bin_file.seekg(0, bin_file.end);
  unsigned nb = bin_file.tellg();
  bin_file.seekg(0, bin_file.beg);
  char *buf = new char[nb];
  bin_file.read(buf, nb);
  xclbin_uuid(buf, xclbinId);

  unsigned num_sockets_hw = 0,
           num_sockets_sw = sizeof(sockets[0]) / sizeof(sockets[0][0]);
  unsigned int ip_gateway = argc >= 8
                                ? (unsigned int)strtol(argv[7], NULL, 16)
                                : (unsigned int)IP_GATEWAY;

  /*
   * ############################################################
   * DEV 0 (CMAC0 Tx) network setup
   * ############################################################
   */

  xclOpenContext(handle, xclbinId, nlidx[0], false);
  unsigned int my_ip_address0 = argc >= 4
                                    ? (unsigned int)strtol(argv[3], NULL, 16)
                                    : (unsigned int)MY_IP_ADDR0;
  unsigned int their_ip_address0 = argc >= 6
                                       ? (unsigned int)strtol(argv[5], NULL, 16)
                                       : (unsigned int)THEIR_IP_ADDR0;
  long mac_address0 = (0xf0f1f2f3f4f5 & 0xFFFFFFFFFF0) + (my_ip_address0 & 0xF);
  xclRegWrite(handle, nlidx[0], MAC_ADDR_OFFSET, mac_address0);
  xclRegWrite(handle, nlidx[0], MAC_ADDR_OFFSET + 4, mac_address0 >> 32);
  xclRegWrite(handle, nlidx[0], IP_ADDR_OFFSET, my_ip_address0);
  xclRegWrite(handle, nlidx[0], IP_GATEWAY_OFFSET, ip_gateway);

  sockets[0][0].theirIP = their_ip_address0;
  sockets[0][0].theirPort = 60000;
  sockets[0][0].myPort = 50000;
  sockets[0][0].valid = true;
  printf("My port 0: %d\n", sockets[0][0].myPort);
  printf("Their port 0: %d\n", sockets[0][0].theirPort);
  printf("My IP address 0: %x\n", my_ip_address0);
  printf("Their IP address 0: %x\n", their_ip_address0);
  printf("My MAC address 0: %lx\n", mac_address0);

  xclRegRead(handle, nlidx[0], NUM_SOCKETS_HW, &num_sockets_hw);
  printf("Number of sockets HW 0: %d\n", num_sockets_hw);

  if (num_sockets_hw != num_sockets_sw) {
    printf("HW Socket list for device [0] should be [%d], is [%d]\n",
           num_sockets_sw, num_sockets_hw);
    fflush(stdout);
    xclCloseContext(handle, xclbinId, nlidx[0]);
    return 1;
  }
  for (unsigned int i = 0; i < num_sockets_hw; i++) {
    uint32_t TI_OFFSET = UDP_TI_OFFSET + i * 8;
    uint32_t TP_OFFSET = UDP_TP_OFFSET + i * 8;
    uint32_t MP_OFFSET = UDP_MP_OFFSET + i * 8;
    uint32_t V_OFFSET = UDP_V_OFFSET + i * 8;

    xclRegWrite(handle, nlidx[0], TI_OFFSET, sockets[i][0].theirIP);
    xclRegWrite(handle, nlidx[0], TP_OFFSET, sockets[i][0].theirPort);
    xclRegWrite(handle, nlidx[0], MP_OFFSET, sockets[i][0].myPort);
    xclRegWrite(handle, nlidx[0], V_OFFSET, sockets[i][0].valid);
  }
  for (int i = 0; i < 256; i++) {
    xclRegWrite(handle, nlidx[0], ARP_VALID_OFFSET + (i / 4) * 4, 0);
  }

  xclRegWrite(handle, nlidx[0], ARP_DISCOVERY, 0);
  xclRegWrite(handle, nlidx[0], ARP_DISCOVERY, 1);
  xclRegWrite(handle, nlidx[0], ARP_DISCOVERY, 0);

  // ARP
  for (int i = 0; i < 256; i++) {
    unsigned valid_entry;
    xclRegRead(handle, nlidx[0], ARP_VALID_OFFSET + (i / 4) * 4, &valid_entry);
    valid_entry = (valid_entry >> ((i % 4) * 8)) & 0x1;
    if (valid_entry) {
      printf("Device 0: ARP valid entry found at %d\n", i);
    }
  }

  xclCloseContext(handle, xclbinId, nlidx[0]);
  xclOpenContext(handle, xclbinId, cmacidx[0], false);
  unsigned tx_status0 = 0;
  unsigned rx_status0 = 0;
  xclRegRead(handle, cmacidx[0], 0x0200, &tx_status0);
  xclRegRead(handle, cmacidx[0], 0x0200, &tx_status0);
  xclRegRead(handle, cmacidx[0], 0x0204, &rx_status0);
  xclRegRead(handle, cmacidx[0], 0x0204, &rx_status0);
  xclCloseContext(handle, xclbinId, cmacidx[0]);
  printf("Device 0: TX status %d\n", tx_status0);
  printf("Device 0: RX status %d\n", rx_status0);

  if (rx_status0 & 0x1) {
    printf("Device 0: Link is active\n");
  } else {
    printf("Device 0: Link is not active\n");
    return EXIT_FAILURE;
  }

  /*
   * ############################################################
   * DEV 1 (CMAC1 Rx) network setup
   * ############################################################
   */

  xclOpenContext(handle, xclbinId, nlidx[1], false);
  unsigned int my_ip_address1 = argc >= 5
                                    ? (unsigned int)strtol(argv[4], NULL, 16)
                                    : (unsigned int)MY_IP_ADDR1;
  unsigned int their_ip_address1 = argc >= 7
                                       ? (unsigned int)strtol(argv[6], NULL, 16)
                                       : (unsigned int)THEIR_IP_ADDR1;

  long mac_address1 = (0xf0f1f2f3f4f5 & 0xFFFFFFFFFF0) + (my_ip_address1 & 0xF);
  xclRegWrite(handle, nlidx[1], MAC_ADDR_OFFSET, mac_address1);
  xclRegWrite(handle, nlidx[1], MAC_ADDR_OFFSET + 4, mac_address1 >> 32);
  xclRegWrite(handle, nlidx[1], IP_ADDR_OFFSET, my_ip_address1);
  xclRegWrite(handle, nlidx[1], IP_GATEWAY_OFFSET, ip_gateway);

  sockets[0][1].theirIP = their_ip_address1;
  sockets[0][1].theirPort = 60000;
  sockets[0][1].myPort = 50000;
  sockets[0][1].valid = true;
  printf("My port 1: %d\n", sockets[0][1].myPort);
  printf("Their port 1: %d\n", sockets[0][1].theirPort);
  printf("My IP address 1: %x\n", my_ip_address1);
  printf("Their IP address 1: %x\n", their_ip_address1);
  printf("My MAC address 1: %lx\n", mac_address1);

  xclRegRead(handle, nlidx[1], NUM_SOCKETS_HW, &num_sockets_hw);
  printf("Number of sockets HW 1: %d\n", num_sockets_hw);

  if (num_sockets_hw != num_sockets_sw) {
    printf("HW Socket list for device [0] should be [%d], is [%d]\n",
           num_sockets_sw, num_sockets_hw);
    fflush(stdout);
    xclCloseContext(handle, xclbinId, nlidx[1]);
    return 1;
  }
  for (unsigned int i = 0; i < num_sockets_hw; i++) {
    uint32_t TI_OFFSET = UDP_TI_OFFSET + i * 8;
    uint32_t TP_OFFSET = UDP_TP_OFFSET + i * 8;
    uint32_t MP_OFFSET = UDP_MP_OFFSET + i * 8;
    uint32_t V_OFFSET = UDP_V_OFFSET + i * 8;

    xclRegWrite(handle, nlidx[1], TI_OFFSET, sockets[i][1].theirIP);
    xclRegWrite(handle, nlidx[1], TP_OFFSET, sockets[i][1].theirPort);
    xclRegWrite(handle, nlidx[1], MP_OFFSET, sockets[i][1].myPort);
    xclRegWrite(handle, nlidx[1], V_OFFSET, sockets[i][1].valid);
  }
  for (int i = 0; i < 256; i++) {
    xclRegWrite(handle, nlidx[1], ARP_VALID_OFFSET + (i / 4) * 4, 0);
  }

  xclRegWrite(handle, nlidx[1], ARP_DISCOVERY, 0);
  xclRegWrite(handle, nlidx[1], ARP_DISCOVERY, 1);
  xclRegWrite(handle, nlidx[1], ARP_DISCOVERY, 0);

  // ARP
  for (int i = 0; i < 256; i++) {
    unsigned valid_entry;
    xclRegRead(handle, nlidx[1], ARP_VALID_OFFSET + (i / 4) * 4, &valid_entry);
    valid_entry = (valid_entry >> ((i % 4) * 8)) & 0x1;
    if (valid_entry) {
      printf("Device 1: ARP valid entry found at %d\n", i);
    }
  }

  xclCloseContext(handle, xclbinId, nlidx[1]);
  xclOpenContext(handle, xclbinId, cmacidx[1], false);
  unsigned tx_status1 = 0;
  unsigned rx_status1 = 0;
  xclRegRead(handle, cmacidx[1], 0x0200, &tx_status1);
  xclRegRead(handle, cmacidx[1], 0x0200, &tx_status1);
  xclRegRead(handle, cmacidx[1], 0x0204, &rx_status1);
  xclRegRead(handle, cmacidx[1], 0x0204, &rx_status1);
  xclCloseContext(handle, xclbinId, cmacidx[1]);
  printf("Device 1: TX status %d\n", tx_status1);
  printf("Device 1: RX status %d\n", rx_status1);

  if (rx_status1 & 0x1) {
    printf("Device 1: Link is active\n");
  } else {
    printf("Device 1: Link is not active\n");
    return EXIT_FAILURE;
  }


  // -----------------------------------------
  // Device 0: User logic (Tx packets)
  // -----------------------------------------
  ul[0] = clCreateKernel(program, "txkrnl:{txkrnl_0}", &err);
  auto packet_size_bytes_0 = sizeof(uint8_t) * packet_size_total_0;
  buffer_packetdata0 = clCreateBuffer(context, CL_MEM_READ_ONLY,
                                      packet_size_bytes_0, NULL, &err);
  cl_uint pst0 = (cl_uint)packet_size_bytes_0;
  cl_uint desti0 = 0;
  clSetKernelArg(ul[0], 0, sizeof(cl_mem), &buffer_packetdata0);
  clSetKernelArg(ul[0], 2, sizeof(cl_uint), &pst0);
  clSetKernelArg(ul[0], 3, sizeof(cl_uint), &desti0);

  uint8_t *ptr_packetdata0 = (uint8_t *)clEnqueueMapBuffer(
      q[0], buffer_packetdata0, CL_TRUE, CL_MAP_WRITE, 0, packet_size_bytes_0,
      0, NULL, NULL, &err);
  // Read text file
  char *code0 = readFile("./alice29.txt");
  for (unsigned int i = 0; i < packet_size_total_0; i++) {
    ptr_packetdata0[i] = code0[i];
  }
  const cl_mem mems0[1] = {buffer_packetdata0};
  clEnqueueMigrateMemObjects(q[0], 1, mems0, 0, 0, NULL, NULL);
  printf("Enqueue user kernel 0...\n");
  clEnqueueTask(q[0], ul[0], 0, NULL, NULL);
  clFinish(q[0]);
  printf("Device 1: Message of size %d transmitted.\n", packet_size_total_0);
  printf("Device 1: Message at the transmitter:\n");

  for (unsigned int i = 0; i < packet_size_total_0; i++) {
    printf("%c", ptr_packetdata0[i]);
  }
  printf("\n");

  // -----------------------------------------
  // Device 1: User logic (Rx packets)
  // -----------------------------------------
  ul[1] = clCreateKernel(program, "rxkrnl:{rxkrnl_0}", &err);
  auto packet_size_bytes_1 = sizeof(uint8_t) * packet_size_total_1;
  buffer_packetdata1 = clCreateBuffer(context, CL_MEM_WRITE_ONLY,
                                      packet_size_bytes_1, NULL, &err);
  cl_uint pst1 = (cl_uint)packet_size_bytes_1;
  clSetKernelArg(ul[1], 0, sizeof(cl_mem), &buffer_packetdata1);   
  clSetKernelArg(ul[1], 2, sizeof(cl_uint), &pst1);

  uint8_t *ptr_packetdata1 = (uint8_t *)clEnqueueMapBuffer(
      q[1], buffer_packetdata1, CL_TRUE, CL_MAP_READ, 0, packet_size_bytes_1, 0,
      NULL, NULL, &err);
  const cl_mem mems1[1] = {buffer_packetdata1};
  printf("Enqueue user kernel 1...\n");
  clEnqueueTask(q[1], ul[1], 0, NULL, NULL);
  clEnqueueMigrateMemObjects(q[1], 1, mems1, CL_MIGRATE_MEM_OBJECT_HOST, 0,
                             NULL, NULL);
  clFinish(q[1]);
  for (unsigned int i = 0; i < packet_size_total_1; i++) {
    printf("%c", ptr_packetdata1[i]);
  }
  printf("\n");
  printf("Device 1: Message received.\n");

  return 0;

}
