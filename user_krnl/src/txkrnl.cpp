#include "ap_axi_sdata.h"
#include "ap_int.h"
#include <ap_fixed.h>
#include "hls_stream.h"

#define DWIDTH 512
#define TDWIDTH 16

typedef ap_axiu<DWIDTH, 1, 1, TDWIDTH> pkt;

extern "C" {
void txkrnl(ap_uint<DWIDTH>  *in,  // Read-Only Vector 1
               hls::stream<pkt> &k2n, // Internal Stream
               unsigned int     size, // Size in bytes
               unsigned int     dest  // destination ID
               ) {
#pragma HLS INTERFACE m_axi port = in offset = slave bundle = gmem
#pragma HLS INTERFACE axis port = k2n
#pragma HLS INTERFACE s_axilite port = in bundle = control
#pragma HLS INTERFACE s_axilite port = size bundle = control
#pragma HLS INTERFACE s_axilite port = dest bundle = control
#pragma HLS INTERFACE s_axilite port = return bundle = control

data_mover:
	  
	unsigned int bytes_per_beat = (DWIDTH / 8);
	pkt v;

  	// Auto-pipeline is going to apply pipeline to this loop
  	for (unsigned int i = 0; i < (size / bytes_per_beat); i++) {
		#pragma HLS LATENCY min=1 max=1000
		#pragma HLS PIPELINE II=1
    		ap_uint<512> tmp = in[i];
    		ap_uint<512> out;
                out = tmp;

		v.data = out;
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
