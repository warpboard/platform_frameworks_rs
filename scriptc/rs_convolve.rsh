#ifndef __RS_CONVOLVE_RSH__
#define __RS_CONVOLVE_RSH__

#if RS_VERSION > 19

extern void convolve_copy(const rs_allocation src, rs_allocation dst,
                          int32_t src_xoff, int32_t src_yoff,
                          int32_t dst_xoff, int32_t dst_yoff,
                          int32_t w, int32_t h);

extern void convolve_horiz(const rs_allocation src, rs_allocation dst,
                           int32_t src_xoff, int32_t src_yoff,
                           int32_t dst_xoff, int32_t dst_yoff,
                           int32_t w, int32_t h,
                           rs_allocation filter, int32_t filter_off,
                           int32_t x_step, int32_t taps);

extern void convolve_vert(const rs_allocation src, rs_allocation dst,
                          int32_t src_xoff, int32_t src_yoff,
                          int32_t dst_xoff, int32_t dst_yoff,
                          int32_t w, int32_t h,
                          rs_allocation filter, int32_t filter_off,
                          int32_t y_step, int32_t taps);

#endif

#endif