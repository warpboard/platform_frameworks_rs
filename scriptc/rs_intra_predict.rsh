#ifndef __RS_INTRA_PREDICT_RSH__
#define __RS_INTRA_PREDICT_RSH__

#if RS_VERSION > 19

extern void intra_predict_d207_predictor_4x4(rs_allocation data_alloc, int32_t xoff, int32_t yoff);
extern void intra_predict_d207_predictor_8x8(rs_allocation data_alloc, int32_t xoff, int32_t yoff);
extern void intra_predict_d207_predictor_16x16(rs_allocation data_alloc, int32_t xoff, int32_t yoff);
extern void intra_predict_d207_predictor_32x32(rs_allocation data_alloc, int32_t xoff, int32_t yoff);

extern void intra_predict_d63_predictor_4x4(rs_allocation data_alloc, int32_t xoff, int32_t yoff);
extern void intra_predict_d63_predictor_8x8(rs_allocation data_alloc, int32_t xoff, int32_t yoff);
extern void intra_predict_d63_predictor_16x16(rs_allocation data_alloc, int32_t xoff, int32_t yoff);
extern void intra_predict_d63_predictor_32x32(rs_allocation data_alloc, int32_t xoff, int32_t yoff);

extern void intra_predict_d45_predictor_4x4(rs_allocation data_alloc, int32_t xoff, int32_t yoff);
extern void intra_predict_d45_predictor_8x8(rs_allocation data_alloc, int32_t xoff, int32_t yoff);
extern void intra_predict_d45_predictor_16x16(rs_allocation data_alloc, int32_t xoff, int32_t yoff);
extern void intra_predict_d45_predictor_32x32(rs_allocation data_alloc, int32_t xoff, int32_t yoff);

extern void intra_predict_d117_predictor_4x4(rs_allocation data_alloc, int32_t xoff, int32_t yoff);
extern void intra_predict_d117_predictor_8x8(rs_allocation data_alloc, int32_t xoff, int32_t yoff);
extern void intra_predict_d117_predictor_16x16(rs_allocation data_alloc, int32_t xoff, int32_t yoff);
extern void intra_predict_d117_predictor_32x32(rs_allocation data_alloc, int32_t xoff, int32_t yoff);

extern void intra_predict_h_predictor_4x4(rs_allocation data_alloc, int32_t xoff, int32_t yoff);
extern void intra_predict_h_predictor_8x8(rs_allocation data_alloc, int32_t xoff, int32_t yoff);
extern void intra_predict_h_predictor_16x16(rs_allocation data_alloc, int32_t xoff, int32_t yoff);
extern void intra_predict_h_predictor_32x32(rs_allocation data_alloc, int32_t xoff, int32_t yoff);

extern void intra_predict_tm_predictor_4x4(rs_allocation data_alloc, int32_t xoff, int32_t yoff);
extern void intra_predict_tm_predictor_8x8(rs_allocation data_alloc, int32_t xoff, int32_t yoff);
extern void intra_predict_tm_predictor_16x16(rs_allocation data_alloc, int32_t xoff, int32_t yoff);
extern void intra_predict_tm_predictor_32x32(rs_allocation data_alloc, int32_t xoff, int32_t yoff);

extern void intra_predict_dc_left_predictor_4x4(rs_allocation data_alloc, int32_t xoff, int32_t yoff);
extern void intra_predict_dc_left_predictor_8x8(rs_allocation data_alloc, int32_t xoff, int32_t yoff);
extern void intra_predict_dc_left_predictor_16x16(rs_allocation data_alloc, int32_t xoff, int32_t yoff);
extern void intra_predict_dc_left_predictor_32x32(rs_allocation data_alloc, int32_t xoff, int32_t yoff);

extern void intra_predict_dc_top_predictor_4x4(rs_allocation data_alloc, int32_t xoff, int32_t yoff);
extern void intra_predict_dc_top_predictor_8x8(rs_allocation data_alloc, int32_t xoff, int32_t yoff);
extern void intra_predict_dc_top_predictor_16x16(rs_allocation data_alloc, int32_t xoff, int32_t yoff);
extern void intra_predict_dc_top_predictor_32x32(rs_allocation data_alloc, int32_t xoff, int32_t yoff);

extern void intra_predict_dc_predictor_4x4(rs_allocation data_alloc, int32_t xoff, int32_t yoff);
extern void intra_predict_dc_predictor_8x8(rs_allocation data_alloc, int32_t xoff, int32_t yoff);
extern void intra_predict_dc_predictor_16x16(rs_allocation data_alloc, int32_t xoff, int32_t yoff);
extern void intra_predict_dc_predictor_32x32(rs_allocation data_alloc, int32_t xoff, int32_t yoff);

extern void intra_predict_d135_predictor_4x4(rs_allocation data_alloc, int32_t xoff, int32_t yoff);
extern void intra_predict_d135_predictor_8x8(rs_allocation data_alloc, int32_t xoff, int32_t yoff);
extern void intra_predict_d135_predictor_16x16(rs_allocation data_alloc, int32_t xoff, int32_t yoff);
extern void intra_predict_d135_predictor_32x32(rs_allocation data_alloc, int32_t xoff, int32_t yoff);

extern void intra_predict_d153_predictor_4x4(rs_allocation data_alloc, int32_t xoff, int32_t yoff);
extern void intra_predict_d153_predictor_8x8(rs_allocation data_alloc, int32_t xoff, int32_t yoff);
extern void intra_predict_d153_predictor_16x16(rs_allocation data_alloc, int32_t xoff, int32_t yoff);
extern void intra_predict_d153_predictor_32x32(rs_allocation data_alloc, int32_t xoff, int32_t yoff);


extern void intra_predict_v_predictor_4x4(rs_allocation data_alloc, int32_t xoff, int32_t yoff);
extern void intra_predict_v_predictor_8x8(rs_allocation data_alloc, int32_t xoff, int32_t yoff);
extern void intra_predict_v_predictor_16x16(rs_allocation data_alloc, int32_t xoff, int32_t yoff);
extern void intra_predict_v_predictor_32x32(rs_allocation data_alloc, int32_t xoff, int32_t yoff);


extern void intra_predict_dc_128_predictor_4x4(rs_allocation data_alloc, int32_t xoff, int32_t yoff);
extern void intra_predict_dc_128_predictor_8x8(rs_allocation data_alloc, int32_t xoff, int32_t yoff);
extern void intra_predict_dc_128_predictor_16x16(rs_allocation data_alloc, int32_t xoff, int32_t yoff);
extern void intra_predict_dc_128_predictor_32x32(rs_allocation data_alloc, int32_t xoff, int32_t yoff);

#endif

#endif
