#include "ap_axi_sdata.h"
#include "ap_int.h"
#include "hls_stream.h"

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