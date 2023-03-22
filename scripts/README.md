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
