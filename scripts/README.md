## Deploy
- Copy binary and bitstream to cloud server after compilation on build server

```bash
export HEAD=154
export TAIL=157

# SSH private key is handled by ssh-agent
scp ./build_hw_if3/demo_if3.xclbin ./host/build_sw_if3/host_receiver_if3 ./host/build_sw_if3/host_sender_if3 ./host/alice29.txt ./host/pg66489.txt sx233@pc$HEAD.cloudlab.umass.edu:~

scp ./build_hw_if3/demo_if3.xclbin ./host/build_sw_if3/host_receiver_if3 ./host/build_sw_if3/host_sender_if3 ./host/alice29.txt ./host/pg66489.txt sx233@pc$TAIL.cloudlab.umass.edu:~

# SSH to cloud (private key set up)
ssh sx233@pc$HEAD.cloudlab.umass.edu
ssh sx233@pc$TAIL.cloudlab.umass.edu

# reset device
xbutil reset -d 0000:3b:00.1
```

- Sample: UDP running example. Send encrypted packets using 2 HW sockets, and receive (on another node) through decryption kernels to 2 different receiver kernels

```bash
# Set up environment on cloud nodes
source /opt/xilinx/xrt/setup.sh

# receiver expecting 1 pkt on both CMAC/Rx
./host_receiver_if3 demo_if3.xclbin 1 1

# sender sending 1 pkt on each Tx/CAMC
./host_sender_if3 demo_if3.xclbin 1 1
```

## RTT
- TIP: the NL/CMAC layer seems to cache one UDP transmission with payload of multiple UDP packets (as a quick fix to the deadlock issue). So if you send one pack of packets to CMAC0 before the CMAC0's user kernel receiver is started, the communication is still able to finish.

- RTT measurement result. TD;DR. (1) OCL API may incur higher overhead than XRT native APIs. (2) if we deduct the pre-measured OCL runtime API overhead, the RTT should be around 8us. Not too bad

```bash
D1: 45us
  # XRT native APIs (faster than OpenCL host APIs?)
  CPU0(XRT) => FPGA0 => NET => FPGA1 (loopback)
            <=       <=     <=
D2: ~248us
  # Streaming (No SYNC bar)
  CPU0(OCL) => FPGA0 => NET => FPGA1 (loopback)
            <=       <=     <=     

D3: 14000us
  # 1. No streaming on CPU1. it receives all packets and then send all back
  # 2. OpenCL host API overhead on CPU1
  CPU0(OCL) => FPGA0 => NET => FPGA1 => CPU1(OCL)
            <=       <=     <=       <=

D4: ~240us
  # OpenCL host API overhead (dummy/empty Rx/Tx kernel)
  CPU0(OCL) 
 
```

## Throughput
- Since the implicit SYNC bar on CPU1 limits the throughput (especially when data size becomes larger), an FPGA-loopback (i.e., D1 with free running loopback kernel on FPGA) is used to measure the throughput

```bash

   | FPGA 0 | sender                | FPGA1 | receiver
Tx0  =>  CMAC0(01:50000) =>  NET  => CMAC0(02:60000) =>  Pin  \
Rx0  <=  CMAC1(03:50000) <=  NET  <= CMAC1(04:60000) <=  Pout /

```

- Merge Rx0 and Tx0 into a loopback kernel. The data is instantly forwarded from CMAC0 to CMAC1 (i.e. streaming without any explicit SYNC bar, and no H2D/D2H memory copy overhead)

```cpp
#define DWIDTH 512
#define TDWIDTH 16
typedef ap_axiu<DWIDTH, 1, 1, TDWIDTH> pkt;

extern "C" {
// Loop data from Rx to Tx directly
void proxy(hls::stream<pkt> &n2k, 
           hls::stream<pkt> &k2n,
           unsigned int size, unsigned int dest) {

// #pragma HLS interface ap_ctrl_none port=return
#pragma HLS INTERFACE axis port = k2n
#pragma HLS INTERFACE axis port = n2k
#pragma HLS INTERFACE s_axilite port = size bundle = control
#pragma HLS INTERFACE s_axilite port = dest bundle = control
#pragma HLS INTERFACE s_axilite port = return bundle = control

  unsigned int bytes_per_beat = (DWIDTH / 8); // 64bytes per packet
	pkt v_in, v;

  for (unsigned int i = 0; i < (size / bytes_per_beat); i++) {
		#pragma HLS LATENCY min=1 max=1000
		#pragma HLS PIPELINE II=1

        n2k.read(v_in);
		v.data = v_in.data;;
		v.keep = -1;
    
    		// set last signals when last piece of data or
    		// multiple of 1408 bytes, packetize the payload
    		if ( (((size / bytes_per_beat) - 1)==i) || ((((i + 1) * DWIDTH/8) % 1408) == 0))
      			v.last = 1;
    		else 
      			v.last = 0;

    		v.dest = dest;
    		k2n.write(v);
  	}
}
}

```