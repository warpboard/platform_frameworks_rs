#include "vp9_reconintra.h"
#include "vp9_idct.h"

static void inverse_transform_block_rs(INTRA_PARAM *param, int plane, int block,
                                    TX_SIZE tx_size, uint8_t *dst, int stride,
                                    uint8_t *token_cache) {
  const int eob = param->eobs[block];
  if (eob > 0) {
    TX_TYPE tx_type = 0;
    const int plane_type = param->plane_type;
    int16_t *const dqcoeff = BLOCK_OFFSET(param->dqcoeff, block);

    switch (tx_size) {
      case TX_4X4:
        tx_type = get_tx_type_4x4_rs(plane_type, param, block);

        if (tx_type == DCT_DCT) {
          if (param->lossless) vp9_iwht4x4_add(dqcoeff, dst, stride, eob);
          else vp9_idct4x4_add(dqcoeff, dst, stride, eob);
        } else
          vp9_iht4x4_16_add(dqcoeff, dst, stride, tx_type);

        break;
      case TX_8X8:
        tx_type = get_tx_type_8x8_rs(plane_type, param);
        vp9_iht8x8_add(tx_type, dqcoeff, dst, stride, eob);
        break;
      case TX_16X16:
        tx_type = get_tx_type_16x16_rs(plane_type, param);
        vp9_iht16x16_add(tx_type, dqcoeff, dst, stride, eob);
        break;
      case TX_32X32:
        tx_type = DCT_DCT;
        vp9_idct32x32_add(dqcoeff, dst, stride, eob);
        break;
      default:
        break;
    }

    if (eob == 1) {
      memset(dqcoeff, 0, 2 * sizeof(dqcoeff[0]));
      memset(token_cache, 0, 2 * sizeof(token_cache[0]));
    } else {
      if (tx_type == DCT_DCT && tx_size <= TX_16X16 && eob <= 10) {
        memset(dqcoeff, 0, 4 * (4 << tx_size) * sizeof(dqcoeff[0]));
        memset(token_cache, 0,
                   4 * (4 << tx_size) * sizeof(token_cache[0]));
      } else if (tx_size == TX_32X32 && eob <= 34) {
        memset(dqcoeff, 0, 256 * sizeof(dqcoeff[0]));
        memset(token_cache, 0, 256 * sizeof(token_cache[0]));
      } else {
        memset(dqcoeff, 0, (16 << (tx_size << 1)) * sizeof(dqcoeff[0]));
        memset(token_cache, 0,
                   (16 << (tx_size << 1)) * sizeof(token_cache[0]));
      }
    }
  }
}

void decode_block_intra_recon_rs(int plane, int block,
                                 BLOCK_SIZE plane_bsize,
                                 TX_SIZE tx_size, INTRA_PARAM *param) {
  const MB_PREDICTION_MODE mode = (MB_PREDICTION_MODE)((plane == 0)
      ? ((param->sb_type < BLOCK_8X8) ? param->as_mode[block]
      : param->mode) : param->uv_mode);
  int x, y;
  uint8_t *dst;

  txfrm_block_to_raster_xy(plane_bsize, tx_size, block, &x, &y);
  dst = &param->dst[4 * y * param->stride + 4 * x];

  if (param->mb_to_right_edge < 0 || param->mb_to_bottom_edge < 0)
    extend_for_intra_rs(param, plane_bsize, plane, x, y);

  vp9_predict_intra_block_rs(param, block >> (tx_size << 1),
                          b_width_log2(plane_bsize), tx_size, mode,
                          dst, param->stride, dst, param->stride,
                          x, y, plane);


  if (!param->skip_coeff)
    inverse_transform_block_rs(param, plane, block, tx_size, dst, param->stride,
                            param->token_cache);

}
