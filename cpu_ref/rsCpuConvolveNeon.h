#ifndef RSD_CPU_CONVOLVE_NEON_H
#define RSD_CPU_CONVOLVE_NEON_H

#include <stdint.h>

extern "C" {
void vp9_convolve_copy_neon(const uint8_t *src, ptrdiff_t src_stride,
                            uint8_t *dst, ptrdiff_t dst_stride,
                            const int16_t *filter_x, int x_step_q4,
                            const int16_t *filter_y, int y_step_q4,
                            int w, int h);

void vp9_convolve_avg_neon(const uint8_t *src, ptrdiff_t src_stride,
                           uint8_t *dst, ptrdiff_t dst_stride,
                           const int16_t *filter_x, int x_step_q4,
                           const int16_t *filter_y, int y_step_q4,
                           int w, int h);

void vp9_convolve8_vert_neon(const uint8_t *src, ptrdiff_t src_stride,
                             uint8_t *dst, ptrdiff_t dst_stride,
                             const int16_t *filter_x, int x_step_q4,
                             const int16_t *filter_y, int y_step_q4,
                             int w, int h);

void vp9_convolve8_avg_vert_neon(const uint8_t *src, ptrdiff_t src_stride,
                                 uint8_t *dst, ptrdiff_t dst_stride,
                                 const int16_t *filter_x, int x_step_q4,
                                 const int16_t *filter_y, int y_step_q4,
                                 int w, int h);

void vp9_convolve8_horiz_neon(const uint8_t *src, ptrdiff_t src_stride,
                              uint8_t *dst, ptrdiff_t dst_stride,
                              const int16_t *filter_x, int x_step_q4,
                              const int16_t *filter_y, int y_step_q4,
                              int w, int h);

void vp9_convolve8_avg_horiz_neon(const uint8_t *src, ptrdiff_t src_stride,
                                  uint8_t *dst, ptrdiff_t dst_stride,
                                  const int16_t *filter_x, int x_step_q4,
                                  const int16_t *filter_y, int y_step_q4,
                                  int w, int h);
void vp9_convolve8_neon(const uint8_t *src, ptrdiff_t src_stride,
                        uint8_t *dst, ptrdiff_t dst_stride,
                        const int16_t *filter_x, int x_step_q4,
                        const int16_t *filter_y, int y_step_q4,
                        int w, int h);
void vp9_convolve8_avg_neon(const uint8_t *src, ptrdiff_t src_stride,
                            uint8_t *dst, ptrdiff_t dst_stride,
                            const int16_t *filter_x, int x_step_q4,
                            const int16_t *filter_y, int y_step_q4,
                            int w, int h);
}
#endif
