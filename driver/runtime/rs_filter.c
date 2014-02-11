#include "rs_types.rsh"
#include "rs_allocation.rsh"

static int compare(int value, int low, int high) {
    return value < low ? low : (value > high ? high : value);
}

#define ROUND_POWER_OF_TWO(value, n) \
    (((value) + (1 << ((n) - 1))) >> (n))

static int8_t signed_char_compare(int t) {
    return (int8_t)compare(t, -128, 127);
}

extern void rsFilter4_pixel(int8_t mask, uint8_t hev, rs_allocation input,
        rs_allocation output, int xoff, int yoff) {
    int i;
    int8_t filter1, filter2;
    uint8_t in[4];
    uint8_t out[4];
    uint8_t * src = in;
    for (i = 0; i < 4; i++) {
        in[i] = rsGetElementAt_uchar(input, xoff + i, yoff);
    }

    const int8_t ps1 = (int8_t)src[0] ^ 0x80;
    const int8_t ps0 = (int8_t)src[1] ^ 0x80;
    const int8_t qs0 = (int8_t)src[2] ^ 0x80;
    const int8_t qs1 = (int8_t)src[3] ^ 0x80;

    int8_t filter = signed_char_compare(ps1 - qs1) & hev;
    filter = signed_char_compare(filter + 3 * (qs0 - ps0)) & mask;
    filter1 = signed_char_compare(filter + 4) >> 3;
    filter2 = signed_char_compare(filter + 3) >> 3;
    out[2] = signed_char_compare(qs0 - filter1) ^ 0x80;
    out[1] = signed_char_compare(ps0 + filter2) ^ 0x80;
    filter = ROUND_POWER_OF_TWO(filter1, 1) & ~hev;
    out[3] = signed_char_compare(qs1 - filter) ^ 0x80;
    out[0] = signed_char_compare(ps1 + filter) ^ 0x80;

    for (i = 0; i < 4; i++) {
        rsSetElementAt_uchar(output, out[i], xoff + i, yoff);
    }

}

extern void rsFilter8_pixel(int8_t mask, uint8_t flat, uint8_t hev,
        rs_allocation input, rs_allocation output, int xoff, int yoff) {
    int i ;
    if (flat && mask) {
        uint8_t in[8];
        uint8_t * src = in;
        for (i = 0; i < 8; i++) {
            in[i] = rsGetElementAt_uchar(input, xoff + i, yoff);
        }

        const uint8_t p3 = src[0];
        const uint8_t p2 = src[1];
        const uint8_t p1 = src[2];
        const uint8_t p0 = src[3];
        const uint8_t q0 = src[4];
        const uint8_t q1 = src[5];
        const uint8_t q2 = src[6];
        const uint8_t q3 = src[7];
        uint8_t result0, result1, result2, result3, result4, result5;
        result0 = ROUND_POWER_OF_TWO(p3 + p3 + p3 + 2 * p2 + p1 + p0 + q0, 3);
        result1 = ROUND_POWER_OF_TWO(p3 + p3 + p2 + 2 * p1 + p0 + q0 + q1, 3);
        result2 = ROUND_POWER_OF_TWO(p3 + p2 + p1 + 2 * p0 + q0 + q1 + q2, 3);
        result3 = ROUND_POWER_OF_TWO(p2 + p1 + p0 + 2 * q0 + q1 + q2 + q3, 3);
        result4 = ROUND_POWER_OF_TWO(p1 + p0 + q0 + 2 * q1 + q2 + q3 + q3, 3);
        result5 = ROUND_POWER_OF_TWO(p0 + q0 + q1 + 2 * q2 + q3 + q3 + q3, 3);

        rsSetElementAt_uchar(output, result0, xoff + 1, yoff);
        rsSetElementAt_uchar(output, result1, xoff + 2, yoff);
        rsSetElementAt_uchar(output, result2, xoff + 3, yoff);
        rsSetElementAt_uchar(output, result3, xoff + 4, yoff);
        rsSetElementAt_uchar(output, result4, xoff + 5, yoff);
        rsSetElementAt_uchar(output, result5, xoff + 6, yoff);

    } else {
        rsFilter4_pixel(mask, hev, input, output, xoff + 2, yoff);
    }
}

extern void rsFilter16_pixel(int8_t mask, uint8_t flat, uint8_t flat2, uint8_t hev,
        rs_allocation input, rs_allocation output, int xoff, int yoff) {
    int i;
    uint8_t in[16];
    uint8_t * src = in;
    for (i = 0; i < 16; i++) {
        in[i] = rsGetElementAt_uchar(input, xoff + i, yoff);
    }

    if (flat2 && flat && mask) {
        const uint8_t p7 = src[0];
        const uint8_t p6 = src[1];
        const uint8_t p5 = src[2];
        const uint8_t p4 = src[3];
        const uint8_t p3 = src[4];
        const uint8_t p2 = src[5];
        const uint8_t p1 = src[6];
        const uint8_t p0 = src[7];
        const uint8_t q0 = src[8];
        const uint8_t q1 = src[9];
        const uint8_t q2 = src[10];
        const uint8_t q3 = src[11];
        const uint8_t q4 = src[12];
        const uint8_t q5 = src[13];
        const uint8_t q6 = src[14];
        const uint8_t q7 = src[15];

        uint8_t result1, result2, result3, result4, result5, result6, result7;
        uint8_t result8, result9, result10, result11, result12, result13, result14;

        result1 = ROUND_POWER_OF_TWO(p7 * 7 + p6 * 2 + p5 + p4 + p3 + p2 + p1
                + p0 + q0, 4);
        result2 = ROUND_POWER_OF_TWO(p7 * 6 + p6 + p5 * 2 + p4 + p3 + p2 + p1
                + p0 + q0 + q1, 4);
        result3 = ROUND_POWER_OF_TWO(p7 * 5 + p6 + p5 + p4 * 2 + p3 + p2 + p1
                + p0 + q0 + q1 + q2, 4);
        result4 = ROUND_POWER_OF_TWO(p7 * 4 + p6 + p5 + p4 + p3 * 2 + p2 + p1
                + p0 + q0 + q1 + q2 + q3, 4);
        result5 = ROUND_POWER_OF_TWO(p7 * 3 + p6 + p5 + p4 + p3 + p2 * 2 + p1
                + p0 + q0 + q1 + q2 + q3 + q4, 4);
        result6 = ROUND_POWER_OF_TWO(p7 * 2 + p6 + p5 + p4 + p3 + p2 + p1 * 2
                + p0 + q0 + q1 + q2 + q3 + q4 + q5, 4);
        result7 = ROUND_POWER_OF_TWO(p7 + p6 + p5 + p4 + p3 + p2 + p1 + p0 * 2
                + q0 + q1 + q2 + q3 + q4 + q5 + q6, 4);
        result8 = ROUND_POWER_OF_TWO(p6 + p5 + p4 + p3 + p2 + p1 + p0 + q0 * 2
                + q1 + q2 + q3 + q4 + q5 + q6 + q7, 4);
        result9 = ROUND_POWER_OF_TWO(p5 + p4 + p3 + p2 + p1 + p0 + q0 + q1 * 2
                + q2 + q3 + q4 + q5 + q6 + q7 * 2, 4);
        result10 = ROUND_POWER_OF_TWO(p4 + p3 + p2 + p1 + p0 + q0 + q1 + q2 * 2
                + q3 + q4 + q5 + q6 + q7 * 3, 4);
        result11 = ROUND_POWER_OF_TWO(p3 + p2 + p1 + p0 + q0 + q1 + q2 + q3 * 2
                + q4 + q5 + q6 + q7 * 4, 4);
        result12 = ROUND_POWER_OF_TWO(p2 + p1 + p0 + q0 + q1 + q2 + q3 + q4 * 2
                + q5 + q6 + q7 * 5, 4);
        result13 = ROUND_POWER_OF_TWO(p1 + p0 + q0 + q1 + q2 + q3 + q4 + q5 * 2
                + q6 + q7 * 6, 4);
        result14 = ROUND_POWER_OF_TWO(p0 + q0 + q1 + q2 + q3 + q4 + q5 + q6 * 2
                + q7 * 7, 4);

        rsSetElementAt_uchar(output, result1, xoff + 1, yoff);
        rsSetElementAt_uchar(output, result2, xoff + 2, yoff);
        rsSetElementAt_uchar(output, result3, xoff + 3, yoff);
        rsSetElementAt_uchar(output, result4, xoff + 4, yoff);
        rsSetElementAt_uchar(output, result5, xoff + 5, yoff);
        rsSetElementAt_uchar(output, result6, xoff + 6, yoff);
        rsSetElementAt_uchar(output, result7, xoff + 7, yoff);
        rsSetElementAt_uchar(output, result8, xoff + 8, yoff);
        rsSetElementAt_uchar(output, result9, xoff + 9, yoff);
        rsSetElementAt_uchar(output, result10, xoff + 10, yoff);
        rsSetElementAt_uchar(output, result11, xoff + 11, yoff);
        rsSetElementAt_uchar(output, result12, xoff + 12, yoff);
        rsSetElementAt_uchar(output, result13, xoff + 13, yoff);
        rsSetElementAt_uchar(output, result14, xoff + 14, yoff);

    } else {
        rsFilter8_pixel(mask, flat, hev, input, output, xoff + 4, yoff);
    }
}

extern void rsFilter_mask(uint8_t limit, uint8_t blimit, rs_allocation input,
        rs_allocation output, int xoff, int yoff) {
    int i;
    int8_t value;
    uint8_t result, result1;
    uint8_t flag, flag1;
    uint8_t in[8];
    for (i = 0; i < 8; i++) {
        in[i] = rsGetElementAt_uchar(input, xoff + i, yoff);
    }

    int8_t mask = 0;

    flag = in[0] - in[1];
    if (flag > 0) {
        result = flag;
    } else {
        result = -flag;
    }
    mask |= (result > limit) * -1;

    flag = in[1] - in[2];
    if (flag > 0) {
        result = flag;
    } else {
        result = -flag;
    }
    mask |= (result > limit) * -1;

    flag = in[2] - in[3];
    if (flag > 0) {
        result = flag;
    } else {
        result = -flag;
    }
    mask |= (result > limit) * -1;

    flag = in[5] - in[4];
    if (flag > 0) {
        result = flag;
    } else {
        result = -flag;
    }
    mask |= (result > limit) * -1;

    flag = in[6] - in[5];
    if (flag > 0) {
        result = flag;
    } else {
        result = -flag;
    }
    mask |= (result > limit) * -1;

    flag = in[7] - in[6];
    if (flag > 0) {
        result = flag;
    } else {
        result = -flag;
    }
    mask |= (result > limit) * -1;

    flag = in[3] - in[4];
    flag1 = in[2] - in[5];
    if (flag > 0) {
        result = flag * 2;
    } else {
        result = (-flag) * 2;
    }
    if (flag1 > 0) {
        result1 = flag1 / 2;
    } else {
        result1 = (-flag1) / 2;
    }
    mask |= ((result + result1) > blimit) * -1;

    value = ~mask;
    for (i = 0; i < 8; i++) {
        rsSetElementAt_uchar(output, value, xoff + i, yoff);
    }
}
