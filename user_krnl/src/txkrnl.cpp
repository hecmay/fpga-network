#include "ap_axi_sdata.h"
#include "ap_int.h"
#include <ap_fixed.h>
#include "hls_stream.h"
#include "./aes/AESfunctions.h"
#include "./aes/AESfunctions.cpp"
#include "./aes/AEStables.h"

#define DWIDTH 512
#define TDWIDTH 16

typedef ap_axiu<DWIDTH, 1, 1, TDWIDTH> pkt;
void AES_Encrypt(unsigned char plaintext[stt_lng],
                unsigned char expandedKey[ExtdCipherKeyLenghth_max], unsigned short Nr,
                unsigned char ciphertext[stt_lng]);


// Rijndael key schedule
// https://en.wikipedia.org/wiki/Rijndael_key_schedule
const unsigned char rcon[256] = { 0x8d, 0x01, 0x02, 0x04, 0x08, 0x10, 0x20,
                0x40, 0x80, 0x1b, 0x36, 0x6c, 0xd8, 0xab, 0x4d, 0x9a, 0x2f, 0x5e, 0xbc,
                0x63, 0xc6, 0x97, 0x35, 0x6a, 0xd4, 0xb3, 0x7d, 0xfa, 0xef, 0xc5, 0x91,
                0x39, 0x72, 0xe4, 0xd3, 0xbd, 0x61, 0xc2, 0x9f, 0x25, 0x4a, 0x94, 0x33,
                0x66, 0xcc, 0x83, 0x1d, 0x3a, 0x74, 0xe8, 0xcb, 0x8d, 0x01, 0x02, 0x04,
                0x08, 0x10, 0x20, 0x40, 0x80, 0x1b, 0x36, 0x6c, 0xd8, 0xab, 0x4d, 0x9a,
                0x2f, 0x5e, 0xbc, 0x63, 0xc6, 0x97, 0x35, 0x6a, 0xd4, 0xb3, 0x7d, 0xfa,
                0xef, 0xc5, 0x91, 0x39, 0x72, 0xe4, 0xd3, 0xbd, 0x61, 0xc2, 0x9f, 0x25,
                0x4a, 0x94, 0x33, 0x66, 0xcc, 0x83, 0x1d, 0x3a, 0x74, 0xe8, 0xcb, 0x8d,
                0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80, 0x1b, 0x36, 0x6c, 0xd8,
                0xab, 0x4d, 0x9a, 0x2f, 0x5e, 0xbc, 0x63, 0xc6, 0x97, 0x35, 0x6a, 0xd4,
                0xb3, 0x7d, 0xfa, 0xef, 0xc5, 0x91, 0x39, 0x72, 0xe4, 0xd3, 0xbd, 0x61,
                0xc2, 0x9f, 0x25, 0x4a, 0x94, 0x33, 0x66, 0xcc, 0x83, 0x1d, 0x3a, 0x74,
                0xe8, 0xcb, 0x8d, 0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80, 0x1b,
                0x36, 0x6c, 0xd8, 0xab, 0x4d, 0x9a, 0x2f, 0x5e, 0xbc, 0x63, 0xc6, 0x97,
                0x35, 0x6a, 0xd4, 0xb3, 0x7d, 0xfa, 0xef, 0xc5, 0x91, 0x39, 0x72, 0xe4,
                0xd3, 0xbd, 0x61, 0xc2, 0x9f, 0x25, 0x4a, 0x94, 0x33, 0x66, 0xcc, 0x83,
                0x1d, 0x3a, 0x74, 0xe8, 0xcb, 0x8d, 0x01, 0x02, 0x04, 0x08, 0x10, 0x20,
                0x40, 0x80, 0x1b, 0x36, 0x6c, 0xd8, 0xab, 0x4d, 0x9a, 0x2f, 0x5e, 0xbc,
                0x63, 0xc6, 0x97, 0x35, 0x6a, 0xd4, 0xb3, 0x7d, 0xfa, 0xef, 0xc5, 0x91,
                0x39, 0x72, 0xe4, 0xd3, 0xbd, 0x61, 0xc2, 0x9f, 0x25, 0x4a, 0x94, 0x33,
                0x66, 0xcc, 0x83, 0x1d, 0x3a, 0x74, 0xe8, 0xcb, 0x8d };

void KeyExpansionCore(unsigned char* in4, unsigned char i) {
        // RotWord rotates left
        // SubWord substitutes with S - Box value
        unsigned char t = in4[0];
        in4[0] = s_box[in4[1]];
        in4[1] = s_box[in4[2]];
        in4[2] = s_box[in4[3]];
        in4[3] = s_box[t];
        // RCon (round constant) 1st byte XOR rcon
        in4[0] = in4[0] ^ rcon[i];
}

void SubWord(unsigned char* in4) {
        // SubWord substitutes with S - Box value
        in4[0] = s_box[in4[0]];
        in4[1] = s_box[in4[1]];
        in4[2] = s_box[in4[2]];
        in4[3] = s_box[in4[3]];
}

void KeyExpansion(unsigned char* inputKey, unsigned short Nk,
                unsigned char* expandedKey) {
        unsigned short Nr = (Nk > Nb) ? Nk + 6 : Nb + 6; // = 10, 12 or 14 rounds
        // Copy the inputKey at the beginning of expandedKey
        for (unsigned short i = 0; i < Nk * rows; i++) {
                expandedKey[i] = inputKey[i];
        }

        // Variables
        unsigned short byGen = Nk * rows;
        unsigned short rconIdx = 1;
        unsigned char temp[rows];

        // Generate expanded keys
        while (byGen < (Nr + 1) * stt_lng) {
                // Read previously generated last 4 bytes (last word)
                for (unsigned short i = 0; i < rows; i++) {
                        temp[i] = expandedKey[byGen - rows + i];
                }
                // Perform KeyExpansionCore once for each 16 byte key
                if (byGen % (Nk * rows) == 0) {
                        KeyExpansionCore(temp, rconIdx);
                        rconIdx++;
                } else if ((Nk > 6) && (byGen % (Nk * rows) == (4 * rows))) {
                        SubWord(temp);
                }
                // XOR temp with [bytesGenerated-16] and store in expandedKeys
                for (unsigned short i = 0; i < rows; i++) {
                        expandedKey[byGen] = expandedKey[byGen - Nk * rows] ^ temp[i];
                        byGen++;
                }
        }
}

extern "C" {
void txkrnl(ap_uint<DWIDTH>  *in,  // Read-Only Vector 1
               hls::stream<pkt> &k2n, // Internal Stream
               unsigned int     size, // Size in bytes
               unsigned int     dest,  // destination ID
	       unsigned int	enc   // encrypt
               ) {
#pragma HLS INTERFACE m_axi port = in offset = slave bundle = gmem
#pragma HLS INTERFACE axis port = k2n
#pragma HLS INTERFACE s_axilite port = in bundle = control
#pragma HLS INTERFACE s_axilite port = size bundle = control
#pragma HLS INTERFACE s_axilite port = dest bundle = control
#pragma HLS INTERFACE s_axilite port = enc bundle = control
#pragma HLS INTERFACE s_axilite port = return bundle = control

data_mover:
	unsigned short Nk = 4; // 4 or 6 or 8 [32-bit words] columns in cipher key
        unsigned short CipherKeyLength = Nk * rows; // bytes
        unsigned short Nr = max(Nb, Nk) + 6; // = 10, 12 or 14 rounds
        unsigned short ExtdCipherKeyLength = (Nr + 1) * stt_lng; // bytes in the expanded cipher key
        // create a dummy test cipher key
        unsigned char key[CipherKeyLength];
        for (unsigned short i = 0; i < CipherKeyLength; i++){
            key[i] = i;
        }
        // extend key
        unsigned char expandedKey[ExtdCipherKeyLength];
        KeyExpansion(key, Nk, expandedKey);	
  
	unsigned int bytes_per_beat = (DWIDTH / 8);
	pkt v;

  	// Auto-pipeline is going to apply pipeline to this loop
  	for (unsigned int i = 0; i < (size / bytes_per_beat); i++) {
		#pragma HLS LATENCY min=1 max=1000
		#pragma HLS PIPELINE II=1
    		ap_uint<512> tmp = in[i];
    		ap_uint<512> out;

		if (enc == 1){
                	for (int k = 0; k < (512/128); k++){
				#pragma HLS UNROLL
                        	unsigned char plaintext[stt_lng];
                        	for (int i=0;i<16;i++){
                                	plaintext[i] = tmp(128*k+i*8+7,128*k+i*8);
                        	}
                        	unsigned char ciphertext[stt_lng];
                        	AES_Encrypt(plaintext, expandedKey, Nr, ciphertext);
                        	for (int i = 0; i<16; i++){
                                	out(128*k+i*8+7,128*k+i*8) = ciphertext[i];
                       		}
                	}
        	}
        	else{
                	out = tmp;
        	}
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
