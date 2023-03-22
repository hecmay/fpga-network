#include "ap_axi_sdata.h"
#include "ap_int.h"
#include "hls_stream.h"

#define DWIDTH 512
#define TDWIDTH 16

typedef ap_axiu<DWIDTH, 1, 1, TDWIDTH> pkt;

// write whatever recived from Rx(n2k) to Tx(k2n)
extern "C" {
void proxykrnl(hls::stream<pkt> &n2k,    // Internal Stream
               hls::stream<pkt> &k2n
               ) {
#pragma HLS interface ap_ctrl_none port=return
#pragma HLS INTERFACE axis port = n2k
#pragma HLS INTERFACE axis port = k2n

#pragma HLS PIPELINE II=1 style=flp
  	pkt v;
	n2k.read(v);
	k2n.write(v);
}
}