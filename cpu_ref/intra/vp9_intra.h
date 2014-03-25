#ifndef VP9_BLOCK_INTRA
#define VP9_BLOCK_INTRA
#include "vp9_blockd.h"

extern "C" {
void decode_block_intra_recon_rs(int plane, int block,
                                 BLOCK_SIZE plane_bsize,
                                 TX_SIZE tx_size, INTRA_PARAM *param);
TX_SIZE get_uv_tx_size_rs(int tx_size, int sb_type);
BLOCK_SIZE get_plane_block_size_rs(BLOCK_SIZE bsize,
                                   const INTRA_PARAM *param);
}

#endif
