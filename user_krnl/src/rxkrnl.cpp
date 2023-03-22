#include "ap_axi_sdata.h"
#include "ap_int.h"
#include "hls_stream.h"

#define DWIDTH 512
#define TDWIDTH 16

typedef ap_axiu<DWIDTH, 1, 1, TDWIDTH> pkt;

extern "C" {
void rxkrnl(ap_uint<DWIDTH> *out,   // Write only memory mapped
            hls::stream<pkt> &n2k,  // Internal Stream
            unsigned int size       // Size in bytes
) {
#pragma HLS INTERFACE m_axi port = out offset = slave bundle = gmem
#pragma HLS INTERFACE axis port = n2k
#pragma HLS INTERFACE s_axilite port = out bundle = control
#pragma HLS INTERFACE s_axilite port = size bundle = control
#pragma HLS INTERFACE s_axilite port = return bundle = control

unsigned int bytes_per_beat = (DWIDTH / 8);

data_mover:
  pkt v;
  ap_uint<512> tmp;
  // Auto-pipeline is going to apply pipeline to this loop
  for (unsigned int i = 0; i < (size / bytes_per_beat); i++) {
    n2k.read(v);
    // out[i] = v.data;
    tmp = v.data;
    out[i] = tmp;
  }
}
}
