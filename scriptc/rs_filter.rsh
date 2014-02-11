#ifndef __RS_FILTER_RSH__
#define __RS_FILTER_RSH__

#if RS_VERSION > 19

extern void rsFilter4_pixel(int8_t mask, uint8_t hev, rs_allocation input,
        rs_allocation output, int xoff, int yoff);

extern void rsFilter8_pixel(int8_t mask, uint8_t flat, uint8_t hev,
        rs_allocation input, rs_allocation output, int xoff, int yoff);

extern void rsFilter16_pixel(int8_t mask, uint8_t flat, uint8_t flat2, uint8_t hev,
        rs_allocation input, rs_allocation output, int xoff, int yoff);

extern void rsFilter_mask(uint8_t limit, uint8_t blimit, rs_allocation input,
        rs_allocation output, int xoff, int yoff);

#endif

#endif
