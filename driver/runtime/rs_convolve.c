#include "rs_types.rsh"
#include "rs_allocation.rsh"

#define FILTER_BITS 7
#define SUBPEL_BITS 4
#define SUBPEL_MASK ((1 << SUBPEL_BITS) - 1)

#define ROUND_POWER_OF_TWO(value, n) \
    (((value) + (1 << ((n) - 1))) >> (n))

static uint8_t clip_pixel(int val) {
    return (val > 255) ? 255u : (val < 0) ? 0u : val;
}

extern void rsConvolve_copy(const rs_allocation src, rs_allocation dst,
                            int32_t src_xoff, int32_t src_yoff,
                            int32_t dst_xoff, int32_t dst_yoff,
                            int32_t w, int32_t h) {
    int r, c;
    for (r = 0; r < h; ++r) {
        for (c = 0; c < w; ++c) {
            uint8_t var = rsGetElementAt_uchar(src, src_xoff + c, src_yoff + r);
            rsSetElementAt_uchar(dst, var, dst_xoff + c, dst_yoff + r);
        }
    }
}

extern void rsConvolve_horiz(const rs_allocation src, rs_allocation dst,
                             int32_t src_xoff, int32_t src_yoff,
                             int32_t dst_xoff, int32_t dst_yoff,
                             int32_t w, int32_t h,
                             rs_allocation filter, int32_t filter_off,
                             int32_t x_step, int32_t taps) {
    int x, y, k;

    const int32_t filter_x_base = filter_off / 128 * 128;
    /* Adjust base offset for this source line */
    int x_base = taps / 2 - 1;

    int val;
    for (y = 0; y < h; ++y) {
        /* Initial phase offset */
        int x_q4 = (int)(filter_off - filter_x_base) / taps * 2;

        for (x = 0; x < w; ++x) {
            /* Per-pixel src offset */
            const int src_x = x_q4 >> SUBPEL_BITS;
            int sum = 0;

            /* Filter to use */
            const int32_t filter_x = filter_x_base + (x_q4 & SUBPEL_MASK) * taps / 2;

            for (k = 0; k < taps; ++k) {
                val = rsGetElementAt_uchar(src, src_x + k - x_base + src_xoff, y + src_yoff);
                val = val * rsGetElementAt_short(filter, k + filter_x);
                sum += val;
            }

            val = clip_pixel(ROUND_POWER_OF_TWO(sum, FILTER_BITS));
            rsSetElementAt_uchar(dst, val, x + dst_xoff, y + dst_yoff);

            /* Move to the next source pixel */
            x_q4 += x_step;
        }
    }
}

extern void rsConvolve_vert(const rs_allocation src, rs_allocation dst,
                            int32_t src_xoff, int32_t src_yoff,
                            int32_t dst_xoff, int32_t dst_yoff,
                            int32_t w, int32_t h,
                            rs_allocation filter, int32_t filter_off,
                            int32_t y_step, int32_t taps) {
    int x, y, k;

    const int32_t filter_y_base = filter_off / 128 * 128;
    /* Adjust base offset for this source column */
    int y_base = taps / 2 - 1;

    int val;
    for (x = 0; x < w; ++x) {
        /* Initial phase offset */
        int y_q4 = (int)(filter_off - filter_y_base) / taps * 2;

        for (y = 0; y < h; ++y) {
            /* Per-pixel src offset */
            const int src_y = y_q4 >> SUBPEL_BITS;
            int sum = 0;

            /* Filter to use */
            const int32_t filter_y = filter_y_base + (y_q4 & SUBPEL_MASK) * taps / 2;

            for (k = 0; k < taps; ++k) {
                val = rsGetElementAt_uchar(src, x + src_xoff, src_y + k - y_base + src_yoff);
                val = val * rsGetElementAt_short(filter, k + filter_y);
                sum += val;
            }

            val = clip_pixel(ROUND_POWER_OF_TWO(sum, FILTER_BITS));
            rsSetElementAt_uchar(dst, val, x + dst_xoff, y + dst_yoff);

            /* Move to the next source pixel */
            y_q4 += y_step;
        }
    }
}
