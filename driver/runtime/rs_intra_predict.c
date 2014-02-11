#include "rs_types.rsh"
#include "rs_allocation.rsh"

#define ROUND_POWER_OF_TWO(value, n) \
    (((value) + (1 << ((n) - 1))) >> (n))

static uint8_t clip_pixel(int val) {
    return (val > 255) ? 255u : (val < 0) ? 0u : val;
}

#define intra_pred_sized(type, b_size) \
    extern void intra_predict_##type##_predictor_##b_size##x##b_size( \
            rs_allocation data_alloc, \
            int32_t xoff, \
            int32_t yoff) { \
        type##_predictor(b_size, data_alloc, xoff, yoff); \
    }

#define intra_pred_allsizes(type) \
    intra_pred_sized(type, 4) \
    intra_pred_sized(type, 8) \
    intra_pred_sized(type, 16) \
    intra_pred_sized(type, 32)

static void d207_predictor(int32_t b_size, rs_allocation data_alloc, int32_t xoff, int32_t yoff) {
    int r, c, loff = xoff - b_size;

    // first column
    uint8_t val;
    int x_base = 0;
    for (r = 0; r < b_size - 1; ++r) {
        val = ROUND_POWER_OF_TWO(rsGetElementAt_uchar(data_alloc, r + loff, yoff) +
                                 rsGetElementAt_uchar(data_alloc, r + 1 + loff, yoff), 1);
        rsSetElementAt_uchar(data_alloc, val, xoff, r + yoff);
    }
    val = rsGetElementAt_uchar(data_alloc, b_size - 1 + loff, yoff);
    rsSetElementAt_uchar(data_alloc, val, xoff, b_size - 1 + yoff);
    x_base++;

    // second column
    for (r = 0; r < b_size - 2; ++r) {
        val = ROUND_POWER_OF_TWO(rsGetElementAt_uchar(data_alloc, r + loff, yoff) +
                                 rsGetElementAt_uchar(data_alloc, r + 1 + loff, yoff) * 2 +
                                 rsGetElementAt_uchar(data_alloc, r + 2 + loff, yoff), 2);
        rsSetElementAt_uchar(data_alloc, val, x_base + xoff, r + yoff);
    }
    val = ROUND_POWER_OF_TWO(rsGetElementAt_uchar(data_alloc, b_size - 2 + loff, yoff) +
                             rsGetElementAt_uchar(data_alloc, b_size - 1 + loff, yoff) * 3, 2);
    rsSetElementAt_uchar(data_alloc, val, x_base + xoff, b_size - 2 + yoff);
    val = rsGetElementAt_uchar(data_alloc, b_size - 1 + loff, yoff);
    rsSetElementAt_uchar(data_alloc, val, x_base + xoff, b_size - 1 + yoff);
    x_base++;

    // rest of last row
    for (c = 0; c < b_size - 2; ++c) {
        val = rsGetElementAt_uchar(data_alloc, b_size - 1 + loff, yoff);
        rsSetElementAt_uchar(data_alloc, val, c + x_base + xoff, b_size - 1 + yoff);
    }

    for (r = b_size - 2; r >= 0; --r) {
        for (c = 0; c < b_size - 2; ++c) {
            val = rsGetElementAt_uchar(data_alloc, c - 2 + x_base + xoff, r + 1 + yoff);
            rsSetElementAt_uchar(data_alloc, val, c + x_base + xoff, r + yoff);
        }
    }
}
intra_pred_allsizes(d207)

static void d63_predictor(int32_t b_size, rs_allocation data_alloc, int32_t xoff, int32_t yoff) {
    int r, c, aoff = yoff - b_size;
    uint8_t val;
    for (r = 0; r < b_size; ++r) {
        for (c = 0; c < b_size; ++c) {
            val = r & 1 ? ROUND_POWER_OF_TWO(
                    rsGetElementAt_uchar(data_alloc, r/2 + c + xoff, aoff) +
                    rsGetElementAt_uchar(data_alloc, r/2 + c + 1 + xoff, aoff) * 2 +
                    rsGetElementAt_uchar(data_alloc, r/2 + c + 2 + xoff, aoff), 2)
                        : ROUND_POWER_OF_TWO(
                    rsGetElementAt_uchar(data_alloc, r/2 + c + xoff, aoff) +
                    rsGetElementAt_uchar(data_alloc, r/2 + c + 1 + xoff, aoff), 1);
            rsSetElementAt_uchar(data_alloc, val, c + xoff, r + yoff);
        }
    }
}
intra_pred_allsizes(d63)

static void d45_predictor(int32_t b_size, rs_allocation data_alloc, int32_t xoff, int32_t yoff) {
    int r, c, aoff = yoff - b_size;
    uint8_t val;
    for (r = 0; r < b_size; ++r) {
        for (c = 0; c < b_size; ++c) {
            val = r + c + 2 < b_size * 2
                    ? ROUND_POWER_OF_TWO(
                            rsGetElementAt_uchar(data_alloc, r + c + xoff, aoff) +
                            rsGetElementAt_uchar(data_alloc, r + c + 1 + xoff, aoff) * 2 +
                            rsGetElementAt_uchar(data_alloc, r + c + 2 + xoff, aoff), 2)
                    : rsGetElementAt_uchar(data_alloc, b_size * 2 - 1 + xoff, aoff);
            rsSetElementAt_uchar(data_alloc, val, c + xoff, r + yoff);
        }
    }
}
intra_pred_allsizes(d45)

static void d117_predictor(int32_t b_size, rs_allocation data_alloc, int32_t xoff, int32_t yoff) {
    int r, c, aoff = yoff - b_size, loff = xoff - b_size;

    // first row
    uint8_t val;
    int y_base = 0;
    for (c = 0; c < b_size; ++c) {
        val = ROUND_POWER_OF_TWO(rsGetElementAt_uchar(data_alloc, c - 1 + xoff, aoff) +
                                 rsGetElementAt_uchar(data_alloc, c + xoff, aoff), 1);
        rsSetElementAt_uchar(data_alloc, val, c + xoff, yoff);
    }
    y_base += 1;

    // second row
    val = ROUND_POWER_OF_TWO(rsGetElementAt_uchar(data_alloc, 0 + loff, yoff) +
                             rsGetElementAt_uchar(data_alloc, -1 + xoff, aoff) * 2 +
                             rsGetElementAt_uchar(data_alloc, 0 + xoff, aoff), 2);
    rsSetElementAt_uchar(data_alloc, val, 0 + xoff, y_base + yoff);
    for (c = 1; c < b_size; ++c) {
        val = ROUND_POWER_OF_TWO(rsGetElementAt_uchar(data_alloc, c - 2 + xoff, aoff) +
                                 rsGetElementAt_uchar(data_alloc, c - 1 + xoff, aoff) * 2 +
                                 rsGetElementAt_uchar(data_alloc, c + xoff, aoff), 2);
        rsSetElementAt_uchar(data_alloc, val, c + xoff, y_base + yoff);
    }
    y_base += 1;

    // the rest of first col
    val = ROUND_POWER_OF_TWO(rsGetElementAt_uchar(data_alloc, -1 + xoff, aoff) +
                             rsGetElementAt_uchar(data_alloc, 0 + loff, yoff) * 2 +
                             rsGetElementAt_uchar(data_alloc, 1 + loff, yoff), 2);
    rsSetElementAt_uchar(data_alloc, val, 0 + xoff, y_base + yoff);
    for (r = 3; r < b_size; ++r) {
        val = ROUND_POWER_OF_TWO(rsGetElementAt_uchar(data_alloc, r - 3 + loff, yoff) +
                                 rsGetElementAt_uchar(data_alloc, r - 2 + loff, yoff) * 2 +
                                 rsGetElementAt_uchar(data_alloc, r - 1 + loff, yoff), 2);
        rsSetElementAt_uchar(data_alloc, val, 0 + xoff, r - 2 + y_base + yoff);
    }

    // the rest of the block
    for (r = 2; r < b_size; ++r) {
        for (c = 1; c < b_size; ++c) {
            val = rsGetElementAt_uchar(data_alloc, c - 1 + xoff, -2 + y_base + yoff);
            rsSetElementAt_uchar(data_alloc, val, c + xoff, y_base + yoff);
        }
        y_base += 1;
    }
}
intra_pred_allsizes(d117)

static void h_predictor(int32_t b_size, rs_allocation data_alloc, int32_t xoff, int32_t yoff) {
    int r, c, loff = xoff - b_size;

    uint8_t val;
    for (r = 0; r < b_size; ++r) {
        val = rsGetElementAt_uchar(data_alloc, r + loff, yoff);
        for (c = 0; c < b_size; ++c) {
            rsSetElementAt_uchar(data_alloc, val, c + xoff, r + yoff);
        }
    }
}
intra_pred_allsizes(h)

static void tm_predictor(int32_t b_size, rs_allocation data_alloc, int32_t xoff, int32_t yoff) {
    int r, c, aoff = yoff - b_size, loff = xoff - b_size;
    int ytop_l_alloc = rsGetElementAt_uchar(data_alloc, -1 + xoff, aoff);

    uint8_t val;
    for (r = 0; r < b_size; ++r) {
        for (c = 0; c < b_size; ++c) {
            val = clip_pixel(rsGetElementAt_uchar(data_alloc, r + loff, yoff) +
                             rsGetElementAt_uchar(data_alloc, c + xoff, aoff) -
                             ytop_l_alloc);
            rsSetElementAt_uchar(data_alloc, val, c + xoff, r + yoff);
        }
    }
}
intra_pred_allsizes(tm)

static void dc_left_predictor(int32_t b_size, rs_allocation data_alloc, int32_t xoff, int32_t yoff) {
    int i, r, c, loff = xoff - b_size, expected_dc, sum = 0;

    for (i = 0; i < b_size; ++i) {
        sum += rsGetElementAt_uchar(data_alloc, i + loff, yoff);
    }
    expected_dc = (sum + (b_size >> 1)) / b_size;

    for (r = 0; r < b_size; ++r) {
        for (c = 0; c < b_size; ++c) {
            rsSetElementAt_uchar(data_alloc, expected_dc, c + xoff, r + yoff);
        }
    }
}
intra_pred_allsizes(dc_left)

static void dc_top_predictor(int32_t b_size, rs_allocation data_alloc, int32_t xoff, int32_t yoff) {
    int i, r, c, aoff = yoff - b_size, expected_dc, sum = 0;

    for (i = 0; i < b_size; ++i) {
        sum += rsGetElementAt_uchar(data_alloc, i + xoff, aoff);
    }
    expected_dc = (sum + (b_size >> 1)) / b_size;

    for (r = 0; r < b_size; ++r) {
        for (c = 0; c < b_size; ++c) {
            rsSetElementAt_uchar(data_alloc, expected_dc, c + xoff, r + yoff);
        }
    }
}
intra_pred_allsizes(dc_top)

static void dc_predictor(int32_t b_size, rs_allocation data_alloc, int32_t xoff, int32_t yoff) {
    int i, r, c, aoff = yoff - b_size, loff = xoff - b_size, expected_dc, sum = 0;
    const int count = 2 * b_size;

    for (i = 0; i < b_size; ++i) {
        sum += rsGetElementAt_uchar(data_alloc, i + xoff, aoff);
        sum += rsGetElementAt_uchar(data_alloc, i + loff, yoff);
    }

    expected_dc = (sum + (count >> 1)) / count;

    for (r = 0; r < b_size; ++r) {
        for (c = 0; c < b_size; ++c) {
            rsSetElementAt_uchar(data_alloc, expected_dc, c + xoff, r + yoff);
        }
    }
}
intra_pred_allsizes(dc)

static void d135_predictor(int32_t b_size, rs_allocation data_alloc, int32_t xoff, int32_t yoff) {
    int r, c;
    int aXoff = xoff;
    int aYoff = yoff - b_size;
    int lXoff = xoff - b_size;
    int lYoff = yoff;

    uint8_t rpot = ROUND_POWER_OF_TWO(rsGetElementAt_uchar(data_alloc, lXoff, lYoff) +
                                      rsGetElementAt_uchar(data_alloc, aXoff -1, aYoff) * 2 +
                                      rsGetElementAt_uchar(data_alloc, aXoff, aYoff),
                                      2);
    rsSetElementAt_uchar(data_alloc, rpot, xoff, yoff);

    for (c = 1; c < b_size; c++) {
        rpot = ROUND_POWER_OF_TWO(rsGetElementAt_uchar(data_alloc, aXoff + c - 2, aYoff) +
                                  rsGetElementAt_uchar(data_alloc, aXoff + c - 1, aYoff) * 2 +
                                  rsGetElementAt_uchar(data_alloc, aXoff + c, aYoff),
                                  2);
        rsSetElementAt_uchar(data_alloc, rpot, xoff + c, yoff);
    }

    rpot = ROUND_POWER_OF_TWO(rsGetElementAt_uchar(data_alloc, aXoff - 1, aYoff) +
                              rsGetElementAt_uchar(data_alloc, lXoff, lYoff) * 2 +
                              rsGetElementAt_uchar(data_alloc, lXoff + 1, lYoff),
                              2);
    rsSetElementAt_uchar(data_alloc, rpot, xoff, yoff + 1);

    for (r = 2; r < b_size; ++r) {
        rpot = ROUND_POWER_OF_TWO(rsGetElementAt_uchar(data_alloc, lXoff + r - 2, lYoff) +
                                  rsGetElementAt_uchar(data_alloc, lXoff + r - 1, lYoff) * 2 +
                                  rsGetElementAt_uchar(data_alloc, lXoff + r, lYoff),
                              2);
        rsSetElementAt_uchar(data_alloc, rpot, xoff, yoff + r);
    }

    int yShift = 1;

    for (r = 1; r < b_size; ++r) {
        for (c = 1; c < b_size; c++) {
            uint8_t var = rsGetElementAt_uchar(data_alloc, xoff + c - 1, yoff + yShift - 1);
            rsSetElementAt_uchar(data_alloc, var, xoff + c, yoff + yShift);
        }
        yShift++;
    }
}
intra_pred_allsizes(d135)

static void d153_predictor(int32_t b_size, rs_allocation data_alloc, int32_t xoff, int32_t yoff) {
    int r, c;
    int aXoff = xoff;
    int aYoff = yoff - b_size;
    int lXoff = xoff - b_size;
    int lYoff = yoff;
    uint8_t rpot = ROUND_POWER_OF_TWO(rsGetElementAt_uchar(data_alloc, aXoff - 1, aYoff) +
                                      rsGetElementAt_uchar(data_alloc, lXoff, lYoff),
                                      1);
    rsSetElementAt_uchar(data_alloc, rpot, xoff, yoff);

    for (r = 1; r < b_size; r++) {
        rpot = ROUND_POWER_OF_TWO(rsGetElementAt_uchar(data_alloc, lXoff + r - 1, lYoff) +
                                  rsGetElementAt_uchar(data_alloc, lXoff + r, lYoff),
                                  1);
        rsSetElementAt_uchar(data_alloc, rpot, xoff, yoff + r);
    }

    int xShift = 1;

    rpot = ROUND_POWER_OF_TWO(rsGetElementAt_uchar(data_alloc, lXoff, lYoff) +
                              rsGetElementAt_uchar(data_alloc, aXoff - 1, aYoff) * 2 +
                              rsGetElementAt_uchar(data_alloc, aXoff, aYoff),
                              2);
    rsSetElementAt_uchar(data_alloc, rpot, xoff + xShift, yoff);

    rpot = ROUND_POWER_OF_TWO(rsGetElementAt_uchar(data_alloc, aXoff - 1, aYoff) +
                              rsGetElementAt_uchar(data_alloc, lXoff, lYoff) * 2 +
                              rsGetElementAt_uchar(data_alloc, lXoff + 1, lYoff),
                              2);
    rsSetElementAt_uchar(data_alloc, rpot, xoff + xShift, yoff + 1);

    for (r = 2; r < b_size; r++) {
        rpot = ROUND_POWER_OF_TWO(rsGetElementAt_uchar(data_alloc, lXoff + r - 2, lYoff) +
                                  rsGetElementAt_uchar(data_alloc, lXoff + r - 1, lYoff) * 2 +
                                  rsGetElementAt_uchar(data_alloc, lXoff + r, lYoff),
                                  2);
        rsSetElementAt_uchar(data_alloc, rpot, xoff + xShift, yoff + r);
    }

    xShift++;

    for (c = 0; c < b_size - 2; c++) {
        rpot = ROUND_POWER_OF_TWO(rsGetElementAt_uchar(data_alloc, aXoff + c - 1, aYoff) +
                                  rsGetElementAt_uchar(data_alloc, aXoff + c, aYoff) * 2 +
                                  rsGetElementAt_uchar(data_alloc, aXoff + c + 1, aYoff),
                                  2);
        rsSetElementAt_uchar(data_alloc, rpot, xoff + xShift + c, yoff);
    }

    int yShift = 1;

    for (r = 1; r < b_size; ++r) {
        for (c = 0; c < b_size - 2; c++) {
            uint8_t var = rsGetElementAt_uchar(data_alloc, xoff + xShift + c - 2, yoff + yShift - 1);
            rsSetElementAt_uchar(data_alloc, var, xoff + xShift + c, yoff + yShift);
        }
        yShift++;
    }
}
intra_pred_allsizes(d153)

static void v_predictor(int32_t b_size, rs_allocation data_alloc, int32_t xoff, int32_t yoff) {
    int r, c;
    for (c = 0; c < b_size; c++) {
        for (r = 0; r < b_size; ++r) {
            uint8_t rpot = rsGetElementAt_uchar(data_alloc, xoff + c, yoff - b_size);
            rsSetElementAt_uchar(data_alloc, rpot, xoff + c, yoff + r);
        }
    }
}
intra_pred_allsizes(v)

static void dc_128_predictor(int32_t b_size, rs_allocation data_alloc, int32_t xoff, int32_t yoff) {
    int r, c;
    for (r = 0; r < b_size; r++) {
        for (c = 0; c < b_size; ++c)
            rsSetElementAt_uchar(data_alloc, 128, xoff + c, yoff + r);
    }
}
intra_pred_allsizes(dc_128)
#undef intra_pred_allsizes