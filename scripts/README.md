## Deploy
- Copy binary and bitstream to cloud server after compilation on build server

```bash
export HEAD=155
export TAIL=156
export IF=3

# SSH private key is handled by ssh-agent
scp ./build_hw_if$IF/demo_if$IF.xclbin ./host/build_sw_if$IF/host_receiver_if$IF ./host/build_sw_if$IF/host_sender_if$IF ./host/alice29.txt sx233@pc$HEAD.cloudlab.umass.edu:~

scp ./build_hw_if$IF/demo_if$IF.xclbin ./host/build_sw_if$IF/host_receiver_if$IF ./host/build_sw_if$IF/host_sender_if$IF ./host/alice29.txt sx233@pc$TAIL.cloudlab.umass.edu:~

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

# receiver (without decrypting) expecting 1 pkt on both CMAC/Rx
./host_receiver_if3 demo_if3.xclbin

# sender sending 1 pkt on each Tx/CAMC
./host_sender_if3 demo_if3.xclbin 1

# Check txt file size
ls -l --block-size=M
```

### NTP-offset One-way Latency
- The timing offset (clock difference) between pc153 and pc155 is 36us. It seems that UMASS cloud have their internal NTP server to synchronize the time difference `ntp1.cloudlab.umass.edu (198.22.255.4)`

```bash
# https://superuser.com/a/408818
# On pc155 (198.22.255.166)
sx233@node1:~$ ntpdate -q pc153.cloudlab.umass.edu

server 198.22.255.164, stratum 4, offset 0.000036, delay 0.02570
20 Mar 17:46:13 ntpdate[14850]: adjust time server 198.22.255.164 offset 0.000036 sec
```

- However, the measured time difference is not very stable. E.g., it can be fluctuating from 20us to 200us. The measured transmission latency is larger than RTT we measured last time (45us)


### RTT
- [REPO](https://github.com/hecmay/fpga-network/tree/loop-back): removed all AES decryption related functions.

- [x] (CANCELLED) For simplicity, we only use on IF0 to measure the RTT. Specifically, we put two queues responsible for sending and receiving data through a HW kernel on FPGA, and thus forming a loopback.

```bash
| TAIL |      |HEAD|
# Rx1 is started before Tx0
  Rx1 (F1:dev0) <= NET <= Tx0 (F0:dev0)

# Once Rx1 is finished. start transmitting
     Tx1 (F1:dev1) => NET => Rx0 (F0:dev1)
```

- NB: each Rx/Tx kernel is considered as a device (and its ARP status needs to be verified separately before launching the actual kernel). 

- [x] IMPORTANT: FTF, we need to test if the UDP packet delivery is stable or not when the packet size increase. As of now it is good with up to 102400 * 1408 B = 145 MB.

- [ ] IMPORTANT: we need two CMAC/sockets on each FPGA to measure RTT (single-packet) so that inward/outward traffics won't be interfered with each other. The Rx/Tx relationships in dual-port UDP example. There are two sockets on each side. On the sender side, the Rx should be started early otherwise packet missing will cause Rx deadlock.

```bash
# CMAC0 is for Tx user kernel only (its Rx/n2k is connected to Proxy.in)
# CMAC1 for Rx user kernel only    (its Tx/k2n is connected from Proxy.out)
       | FPGA 0 | sender                | FPGA1 | receiver (freerunning) 
    Tx0  =>  CMAC0(01:50000) =>  NET  => CMAC0(02:60000) =>  Proxy0.in  \
    Rx0  <=  CMAC1(03:50000) <=  NET  <= CMAC1(04:60000) <=  Porxy0.out /
```

- DEBUG: The loopback does not work as expected. Here I try a simpler case to pinpoint the issue. 

```bash
       | FPGA 0 | sender                | FPGA1 | receiver
    Tx0  =>  CMAC0(01:50000) =>  NET  => CMAC1(04:60000) Rx0
    Rx0  <=  CMAC1(03:60000) <=  NET  <= CMAC0(04:50000) Tx0
```