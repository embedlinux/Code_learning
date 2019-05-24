/* ------------------------------------------------------------------------ */
/* Copyright (c) 2018 by Cadence Design Systems, Inc. ALL RIGHTS RESERVED.  */
/* These coded instructions, statements, and computer programs ("Cadence    */
/* Libraries") are the copyrighted works of Cadence Design Systems Inc.	    */
/* Cadence IP is licensed for use with Cadence processor cores only and     */
/* must not be used for any other processors and platforms. Your use of the */
/* Cadence Libraries is subject to the terms of the license agreement you   */
/* have entered into with Cadence Design Systems, or a sublicense granted   */
/* to you by a direct Cadence licensee.                                     */
/* ------------------------------------------------------------------------ */
/*  IntegrIT, Ltd.   www.integrIT.com, info@integrIT.com                    */
/*                                                                          */
/* DSP Library                                                              */
/*                                                                          */
/* This library contains copyrighted materials, trade secrets and other     */
/* proprietary information of IntegrIT, Ltd. This software is licensed for  */
/* use with Cadence processor cores only and must not be used for any other */
/* processors and platforms. The license to use these sources was given to  */
/* Cadence, Inc. under Terms and Condition of a Software License Agreement  */
/* between Cadence, Inc. and IntegrIT, Ltd.                                 */
/* ------------------------------------------------------------------------ */
/*          Copyright (C) 2015-2018 IntegrIT, Limited.                      */
/*                      All Rights Reserved.                                */
/* ------------------------------------------------------------------------ */
/*
  NatureDSP Signal Processing Library. FFT part
    Complex-valued FFT stages with butterflies radix-2, radix-3, radix-5
    with dynamic data scaling: 32-bit data, 16-bit twiddle factors
    C code optimized for HiFi4
  IntegrIT, 2006-2018
*/
#include "NatureDSP_types.h"
#include "common.h"
#include "fft_32x16_stages.h"

/*
DFT3 algorithm:
x - input complex vector
y - output complex vector
y = fft(x)
y = [ x(1) + x(2)  + x(3);
x(1) + (x(2) + x(3))*cos(2*pi/3) - 1j*(x(2) - x(3))*sin(2*pi/3);
x(1) + (x(2) + x(3))*cos(2*pi/3) + 1j*(x(2) - x(3))*sin(2*pi/3) ]

*/
#define DFT3X1(x0, x1, x2)\
{\
    ae_int32x2 s0, s1, d0, c32; \
    ae_int16x4 c;               \
    c32 = AE_MOVDA32X2(0x40004000,0x00006EDA); \
    c = AE_MOVINT16X4_FROMINT32X2(c32);        \
    AE_ADDANDSUB32S(s0, d0, x1, x2);           \
    s1 = AE_ADD32S(x0, s0);                    \
    AE_MULSFP32X16X2RAS_H(x0, s0, c);          \
    d0 = AE_MULFC32X16RAS_L(d0, c);            \
    s0 = x0;                                   \
    x0 = s1;                                   \
    AE_ADDANDSUB32S(x2, x1, s0, d0);           \
}

/* radix-3 butterfly with data scaling using AE.SAR register & 'shift' value */
#define DFT3X1_RNG_shift(x0, x1, x2, shift)\
{\
    ae_int32x2 s0, s1, d0, c32; \
    ae_int16x4 c;               \
    c32 = AE_MOVDA32X2(0x40004000,0x00006EDA); \
    c = AE_MOVINT16X4_FROMINT32X2(c32);        \
    x0 = AE_SRAA32(x0, shift);                 \
    AE_ADDANDSUBRNG32(s0, d0, x1, x2);         \
    s1 = AE_ADD32S(x0, s0);                    \
    AE_MULSFP32X16X2RAS_H(x0, s0, c);          \
    d0 = AE_MULFC32X16RAS_L(d0, c);            \
    s0 = x0;                                   \
    x0 = s1;                                   \
    AE_ADDANDSUB32S(x2, x1, s0, d0);           \
}

/*
DFT5 algorithm:
x - input complex vector
y - output complex vector
y = fft(x)
w1 =  exp(-1j*2*pi/5);
w2 =  exp(-1j*2*pi*2/5);

y = zeros(5,1);
s1 = (x1+x4);
s2 = (x2 + x3);
d1 = (x1-x4);
d2 = (x2-x3);

y(1) = x0 + s1 + s2;
y(2) = x0 + (s1*real(w1) + s2*real(w2)) + 1j*(d1*imag(w1) + d2*imag(w2));
y(5) = x0 + (s1*real(w1) + s2*real(w2)) - 1j*(d1*imag(w1) + d2*imag(w2));
y(3) = x0 + (s1*real(w2) + s2*real(w1)) + 1j*(d1*imag(w2)  - d2*imag(w1));
y(4) = x0 + (s1*real(w2) + s2*real(w1)) - 1j*(d1*imag(w2)  - d2*imag(w1));

*/
#define DFT5X1(x0, x1, x2, x3, x4)\
{ \
  ae_int32x2 s1, s2, d1, d2;       \
  ae_int32x2 y0, y1;               \
  ae_int32x2 t0, t1, t2, t3, wtmp; \
  ae_int16x4 w1, w2;               \
  wtmp = AE_MOVDA32X2(0x278E278E,0x00008644); \
  w1 = AE_MOVINT16X4_FROMINT32X2(wtmp);       \
  wtmp = AE_MOVDA32X2(0x98729872,0x0000B4C3); \
  w2 = AE_MOVINT16X4_FROMINT32X2(wtmp);       \
  AE_ADDANDSUB32S(s1, d1, x1, x4);            \
  AE_ADDANDSUB32S(s2, d2, x2, x3);            \
  t0 = AE_MULFP32X16X2RAS_H(s1, w1);          \
  t1 = AE_MULFP32X16X2RAS_H(s2, w2);          \
  t2 = AE_MULFP32X16X2RAS_H(s1, w2);          \
  t3 = AE_MULFP32X16X2RAS_H(s2, w1);          \
  y0 = AE_ADD32S(x0, AE_ADD32S(t0, t1));      \
  y1 = AE_ADD32S(x0, AE_ADD32S(t2, t3));      \
  t0 = AE_MULFC32X16RAS_L(d1, w1);            \
  t1 = AE_MULFC32X16RAS_L(d2, w2);            \
  t2 = AE_MULFC32X16RAS_L(d2, w1);            \
  t3 = AE_MULFC32X16RAS_L(d1, w2);            \
  t0 = AE_ADD32S(t0, t1);                     \
  t1 = AE_SUB32S(t3, t2);                     \
  x0 = AE_ADD32S(x0, AE_ADD32S(s1, s2));      \
  AE_ADDANDSUB32S(x1, x4, y0, t0);            \
  AE_ADDANDSUB32S(x2, x3, y1, t1);            \
}

/*
 *  32x16 FFT first stage Radix 2, scalingOption=2
 */
int fft_32x16_stage_first_scl2_DFT2(const int16_t *tw, const int32_t *x, int32_t *y, int N, int *v, int tw_step, int *bexp)
{
  const ae_int32x2 * restrict px0;
  const ae_int32x2 * restrict px1;
        ae_int32x2 * restrict py0;
  const ae_int32   * restrict ptwd;
  ae_int32x2 scl;
  const int stride = (N >> 1);
  int shift, shiftl, shiftr;
  const int R = 2; // stage radix
  const int min_shift = 2;
  int i;

  shift = min_shift - *bexp;
  shiftl = XT_MAX(0, -shift);
  shiftr = XT_MAX(0,  shift);

  NASSERT(shift>-32 && shift<4);
  NASSERT_ALIGN8(x);
  NASSERT_ALIGN8(y);

  scl = 1 << shiftl;
  WUR_AE_SAR(shiftr);

  px0 = (ae_int32x2 *)x;
  px1 = px0 + stride;
  py0 = (ae_int32x2 *)y;
  ptwd = (const ae_int32 *)tw;

  __Pragma("loop_count min=3");
  for (i = 0; i < stride; i++)
  {
    ae_int32x2 x0, x1, y0, y1;
    ae_int16x4 tw1;
    ae_int32x2 tw1_tmp;

    AE_L32_IP(tw1_tmp, ptwd, 2*sizeof(int16_t));
    tw1 = AE_SHORTSWAP(AE_MOVINT16X4_FROMINT32X2(tw1_tmp));

    AE_L32X2_IP(x0, px0, sizeof(ae_int32x2));
    AE_L32X2_IP(x1, px1, sizeof(ae_int32x2));
    x0 = AE_MULP32X2(x0, scl);
    x1 = AE_MULP32X2(x1, scl);
    AE_ADDANDSUBRNG32(y0, y1, x0, x1);
    y1 = AE_MULFC32X16RAS_L(y1, tw1);
    AE_S32X2RNG_IP(y0, py0, sizeof(ae_int32x2));
    AE_S32X2RNG_IP(y1, py0, sizeof(ae_int32x2));
  }

  AE_CALCRNG3();
  *bexp = 3 - RUR_AE_SAR();
  *v *= R;
  return shift;
} /* fft_32x16_stage_first_scl2_DFT2() */

/*
 *  32x16 FFT/IFFT last stage Radix 2, scalingOption=2
 */
int fft_32x16_stage_last_scl2_DFT2(const int16_t *tw, const int32_t *x, int32_t *y, int N, int *v, int tw_step, int *bexp)
{
  const int stride = (N >> 1);
  int shift;
  ae_int32x2 * restrict px0;
  ae_int32x2 * restrict py0;
  int j;

  NASSERT_ALIGN8(x);
  NASSERT_ALIGN8(y);
  NASSERT(*bexp >= 0);

  shift = XT_MAX( 0, 1 - *bexp );
  WUR_AE_SAR(shift);
  px0 = (ae_int32x2 *)(x);
  py0 = (ae_int32x2 *)(y);

  __Pragma("loop_count min=3");
  for (j = 0; j < stride; j++)
  {
    ae_int32x2 x0, x1, y0, y1;

    AE_L32X2_XP(x0, px0, stride*sizeof(ae_int32x2));
    AE_L32X2_XP(x1, px0, (1-stride)*sizeof(ae_int32x2));

    AE_ADDANDSUBRNG32(y0, y1, x0, x1);

    AE_S32X2RNG_XP(y0, py0, stride*sizeof(ae_int32x2));
    AE_S32X2RNG_XP(y1, py0, (1-stride)*sizeof(ae_int32x2));
  }

  return shift;
} /* fft_32x16_stage_last_scl2_DFT2() */

/*
 *  32x16 FFT/IFFT intermediate stage Radix 2, scalingOption=2
 */
int fft_32x16_stage_inner_scl2_DFT2(const int16_t *tw, const int32_t *x, int32_t *y, int N, int *v, int tw_step, int *bexp)
{ 
  int i, j, _v;
  int shift;
  const ae_int32x2 * restrict px0;
        ae_int32x2 * restrict py0;
  const ae_int32 * restrict ptwd;
  const int stride = (N >> 1);
  const int R = 2; // stage radix

  NASSERT_ALIGN8(x);
  NASSERT_ALIGN8(y);

  shift = XT_MAX( 0, 2 - *bexp );
  WUR_AE_SAR(shift);

  _v = *v;
  for (j = 0; j < _v; j++)
  {
    ae_int32x2 x0, x1, y0, y1;
    ptwd = (const ae_int32 *)tw;
    px0 = (ae_int32x2 *)x + j;
    py0 = (ae_int32x2 *)y + j;
    __Pragma("loop_count min=1");
    for (i = 0; i < (stride / _v); i++)
    {
      ae_int16x4 tw1;
      ae_int32x2 tw1_tmp;

      AE_L32_IP(tw1_tmp, ptwd, 2*sizeof(int16_t));
      tw1 = AE_SHORTSWAP(AE_MOVINT16X4_FROMINT32X2(tw1_tmp));

      x1 = AE_L32X2_X(px0, sizeof(ae_int32x2) * stride);
      AE_L32X2_XP(x0, px0, _v * sizeof(ae_int32x2));
      AE_ADDANDSUBRNG32(y0, y1, x0, x1);
      y1 = AE_MULFC32X16RAS_L(y1, tw1);
      AE_S32X2RNG_XP(y0, py0, _v * sizeof(ae_int32x2));
      AE_S32X2RNG_XP(y1, py0, _v * sizeof(ae_int32x2));
    }
  }
  AE_CALCRNG3();
  *bexp = 3 - RUR_AE_SAR();
  *v *= R;
  return shift;
} /* fft_32x16_stage_inner_scl2_DFT2() */

/*
 *  32x16 FFT first stage Radix 3, scalingOption=2
 */
int fft_32x16_stage_first_scl2_DFT3(const int16_t *tw, const int32_t *x, int32_t *y, int N, int *v, int tw_step, int *bexp)
{
  const int R = 3; // stage radix
  const int stride = N / R;
  int shift;
  ae_int32x2 * restrict px0;
  ae_int32x2 * restrict px1;
  ae_int32x2 * restrict px2;
  ae_int32x2 * restrict py0;
  const ae_int16x4 * restrict ptwd;
  int min_shift = 3;
  int i;
  NASSERT_ALIGN8(x);
  NASSERT_ALIGN8(y);

  px0 = (ae_int32x2 *)x;
  px1 = px0 + stride;
  px2 = px1 + stride;
  py0 = (ae_int32x2 *)y;
  ptwd = (const ae_int16x4 *)tw;

  shift = min_shift - *bexp;
  NASSERT(shift>-32 && shift<32);
  WUR_AE_SAR(0);

  __Pragma("loop_count min=2");
  for (i = 0; i <stride; i++)
  {
    ae_int32x2 x0, x1, x2;
    ae_int16x4 tw12;

    AE_L16X4_IP(tw12, ptwd, sizeof(ae_int16x4));

    AE_L32X2_IP(x0, px0, sizeof(ae_int32x2));
    AE_L32X2_IP(x1, px1, sizeof(ae_int32x2));
    AE_L32X2_IP(x2, px2, sizeof(ae_int32x2));
    x0 = AE_SRAA32RS(x0, shift);
    x1 = AE_SRAA32RS(x1, shift);
    x2 = AE_SRAA32RS(x2, shift);

    DFT3X1(x0, x1, x2);
    x1 = AE_MULFC32X16RAS_H(x1, tw12);
    x2 = AE_MULFC32X16RAS_L(x2, tw12);

    AE_S32X2RNG_IP(x0, py0, sizeof(ae_int32x2));
    AE_S32X2RNG_IP(x1, py0, sizeof(ae_int32x2));
    AE_S32X2RNG_IP(x2, py0, sizeof(ae_int32x2));
  }

  AE_CALCRNG3();
  *bexp = 3 - RUR_AE_SAR();
  *v *= R;
  return shift;
} /* fft_32x16_stage_first_scl2_DFT3() */

/*
 *  32x16 FFT last stage Radix 3, scalingOption=2
 */
int fft_32x16_stage_last_scl2_DFT3(const int16_t *tw, const int32_t *x, int32_t *y, int N, int *v, int tw_step, int *bexp)
{
  const int R = 3; // stage radix
  const int stride = N / R;
  int shift;
  int min_shift = 3;
  ae_int32x2 * restrict px0;
  ae_int32x2 * restrict py0;
  int j, _v;

  NASSERT_ALIGN8(x);
  NASSERT_ALIGN8(y);

  _v = *v;
  px0 = (ae_int32x2 *)x;
  py0 = (ae_int32x2 *)y;

  shift = min_shift - *bexp;
  NASSERT(shift>=0 && shift<4);
  WUR_AE_SAR(shift);

  __Pragma("loop_count min=2");
  for (j = 0; j < _v; j++)
  {
    ae_int32x2 x0, x1, x2;

    x1 = AE_L32X2_X(px0, sizeof(ae_int32x2) * stride);
    x2 = AE_L32X2_X(px0, sizeof(ae_int32x2) * stride * 2);
    AE_L32X2_IP(x0, px0, sizeof(ae_int32x2));

    DFT3X1_RNG_shift(x0, x1, x2, shift);

    AE_S32X2RNG_XP(x0, py0, stride * sizeof(ae_int32x2));
    AE_S32X2RNG_XP(x1, py0, stride * sizeof(ae_int32x2));
    AE_S32X2RNG_XP(x2, py0, (-2*stride+1) * sizeof(ae_int32x2));
  }

  return shift;
} /* fft_32x16_stage_last_scl2_DFT3() */

/*
 *  32x16 FFT/IFFT intermediate stage Radix 3, scalingOption=2
 */
int fft_32x16_stage_inner_scl2_DFT3(const int16_t *tw, const int32_t *x, int32_t *y, int N, int *v, int tw_step, int *bexp)
{
  const int R = 3; // stage radix
  const int stride = N / R;
  int min_shift = 3;
  int shift;
        ae_int32x2 * restrict px0;
        ae_int32x2 * restrict py0;
  const ae_int16x4 * restrict ptwd;

  NASSERT_ALIGN8(x);
  NASSERT_ALIGN8(y);

  shift = min_shift - *bexp;
  NASSERT(shift>=0 && shift<4);
  WUR_AE_SAR(shift);

  {
    int i, j;
    int _v;
    _v = *v;
    __Pragma("loop_count min=1");
    for (j = 0; j < _v; j++)
    {
      ae_int32x2 x0, x1, x2;
      ae_int16x4 tw12;
      ptwd = (const ae_int16x4 *)tw;
      px0 = (ae_int32x2 *)x + j;
      py0 = (ae_int32x2 *)y + j;
      __Pragma("loop_count min=2");
      __Pragma("no_unroll");
      for (i = 0; i < (stride / _v); i++)
      {
        AE_L16X4_XP(tw12, ptwd, tw_step*sizeof(ae_int16x4));

        AE_L32X2_XP(x0, px0, stride * sizeof(ae_int32x2));
        AE_L32X2_XP(x1, px0, stride * sizeof(ae_int32x2));
        AE_L32X2_XP(x2, px0, (_v-2*stride) * sizeof(ae_int32x2));

        DFT3X1_RNG_shift(x0, x1, x2, shift);
        x1 = AE_MULFC32X16RAS_H(x1, tw12);
        x2 = AE_MULFC32X16RAS_L(x2, tw12);

        AE_S32X2RNG_XP(x0, py0, _v * sizeof(ae_int32x2));
        AE_S32X2RNG_XP(x1, py0, _v * sizeof(ae_int32x2));
        AE_S32X2RNG_XP(x2, py0, _v * sizeof(ae_int32x2));
      }
    }
  }

  AE_CALCRNG3();
  *bexp = 3 - RUR_AE_SAR();
  *v *= R;
  return shift;
} /* fft_32x16_stage_inner_scl2_DFT3() */

/*
 *  32x16 FFT first stage Radix 5, scalingOption=2
 */
int fft_32x16_stage_first_scl2_DFT5(const int16_t *tw, const int32_t *x, int32_t *y, int N, int *v, int tw_step, int *bexp)
{
  int i;
  const int R = 5; // stage radix
  const int stride = N / R;
  int shift;
  const int min_shift = 3;
  const ae_int32x2 * restrict px0;
  const ae_int32x2 * restrict px1;
  const ae_int32x2 * restrict px2;
  const ae_int32x2 * restrict px3;
  const ae_int32x2 * restrict px4;
        ae_int32x2 * restrict py0;
  const ae_int16x4 * restrict ptwd;

  NASSERT_ALIGN8(x);
  NASSERT_ALIGN8(y);
  shift = min_shift - *bexp;
  NASSERT(shift>-32 && shift<32);
  WUR_AE_SAR(0);

  px0 = (ae_int32x2 *)x;
  px1 = px0 + stride;
  px2 = px1 + stride;
  px3 = px2 + stride;
  px4 = px3 + stride;
  py0 = (ae_int32x2 *)y;
  ptwd = (const ae_int16x4 *)tw;

  __Pragma("loop_count min=3");
  for (i = 0; i <stride; i++)
  {
    ae_int32x2 x0, x1, x2, x3, x4;
    ae_int16x4 tw12, tw34;

    AE_L16X4_IP(tw12, ptwd, sizeof(ae_int16x4));
    AE_L16X4_IP(tw34, ptwd, sizeof(ae_int16x4));

    AE_L32X2_IP(x0, px0, sizeof(ae_int32x2));
    AE_L32X2_IP(x1, px1, sizeof(ae_int32x2));
    AE_L32X2_IP(x2, px2, sizeof(ae_int32x2));
    AE_L32X2_IP(x3, px3, sizeof(ae_int32x2));
    AE_L32X2_IP(x4, px4, sizeof(ae_int32x2));

    x0 = AE_SRAA32RS(x0, shift);
    x1 = AE_SRAA32RS(x1, shift);
    x2 = AE_SRAA32RS(x2, shift);
    x3 = AE_SRAA32RS(x3, shift);
    x4 = AE_SRAA32RS(x4, shift);
    DFT5X1(x0, x1, x2, x3, x4);
    x1 = AE_MULFC32X16RAS_H(x1, tw12);
    x2 = AE_MULFC32X16RAS_L(x2, tw12);
    x3 = AE_MULFC32X16RAS_H(x3, tw34);
    x4 = AE_MULFC32X16RAS_L(x4, tw34);

    AE_S32X2RNG_IP(x0, py0, sizeof(ae_int32x2));
    AE_S32X2RNG_IP(x1, py0, sizeof(ae_int32x2));
    AE_S32X2RNG_IP(x2, py0, sizeof(ae_int32x2));
    AE_S32X2RNG_IP(x3, py0, sizeof(ae_int32x2));
    AE_S32X2RNG_IP(x4, py0, sizeof(ae_int32x2));
  }

  AE_CALCRNG3();
  *bexp = 3 - RUR_AE_SAR();
  *v *= R;
  return shift;
} /* fft_32x16_stage_first_scl2_DFT5() */

/*
 *  32x16 FFT last stage Radix 5, scalingOption=2
 */
int fft_32x16_stage_last_scl2_DFT5(const int16_t *tw, const int32_t *x, int32_t *y, int N, int *v, int tw_step, int *bexp)
{
  const int R = 5; // stage radix
  const int stride = N / R;
  const int min_shift = 3;
  int shift;
  ae_int32x2 * restrict px0;
  ae_int32x2 * restrict py0;
  int j, _v;

  NASSERT_ALIGN8(x);
  NASSERT_ALIGN8(y);

  _v = *v;
  shift = min_shift - *bexp;
  NASSERT(shift>=0 && shift<4);
  WUR_AE_SAR(0);
  px0 = (ae_int32x2 *)x;
  py0 = (ae_int32x2 *)y;

  __Pragma("loop_count min=2");
  for (j = 0; j < _v; j++)
  {
    ae_int32x2 x0, x1, x2, x3, x4;

    x1 = AE_L32X2_X(px0, sizeof(ae_int32x2) * stride);
    x2 = AE_L32X2_X(px0, sizeof(ae_int32x2) * stride * 2);
    x3 = AE_L32X2_X(px0, sizeof(ae_int32x2) * stride * 3);
    x4 = AE_L32X2_X(px0, sizeof(ae_int32x2) * stride * 4);
    AE_L32X2_IP(x0, px0, sizeof(ae_int32x2));

    x0 = AE_SRAA32RS(x0, shift);
    x1 = AE_SRAA32RS(x1, shift);
    x2 = AE_SRAA32RS(x2, shift);
    x3 = AE_SRAA32RS(x3, shift);
    x4 = AE_SRAA32RS(x4, shift);
    DFT5X1(x0, x1, x2, x3, x4);

    AE_S32X2RNG_XP(x0, py0, stride * sizeof(ae_int32x2));
    AE_S32X2RNG_XP(x1, py0, stride * sizeof(ae_int32x2));
    AE_S32X2RNG_XP(x2, py0, stride * sizeof(ae_int32x2));
    AE_S32X2RNG_XP(x3, py0, stride * sizeof(ae_int32x2));
    AE_S32X2RNG_XP(x4, py0, (-4*stride+1) * sizeof(ae_int32x2));
  }

  return shift;
} /* fft_32x16_stage_last_scl2_DFT5() */

/*
 *  32x16 FFT/IFFT intermediate stage Radix 5, scalingOption=2
 */
int fft_32x16_stage_inner_scl2_DFT5(const int16_t *tw, const int32_t *x, int32_t *y, int N, int *v, int tw_step, int *bexp)
{
  const int R = 5; // stage radix
  const int stride = N / R;
  const int min_shift = 3;
  int shift;
  int i, j, _v;
  const ae_int32x2 * restrict px0;
  const ae_int32x2 * restrict px1;
  const ae_int32x2 * restrict px2;
  const ae_int32x2 * restrict px3;
  const ae_int32x2 * restrict px4;
        ae_int32x2 * restrict py0;
  const ae_int16x4 * restrict ptwd;
  NASSERT_ALIGN8(x);
  NASSERT_ALIGN8(y);

  shift = min_shift - *bexp;
  NASSERT(shift>=0 && shift<5);
  WUR_AE_SAR(0);
  _v = *v;
  __Pragma("loop_count min=1");
  for (j = 0; j < _v; j++)
  {
    ae_int32x2 x0, x1, x2, x3, x4;
    ae_int16x4 tw12, tw34;
    ptwd = (const ae_int16x4 *)tw;
    px0 = (ae_int32x2 *)x + j;
    px1 = px0 + stride;
    px2 = px1 + stride;
    px3 = px2 + stride;
    px4 = px3 + stride;
    py0 = (ae_int32x2 *)y + j;

    __Pragma("loop_count min=2");
    for (i = 0; i < (stride / _v); i++)
    {
      AE_L16X4_IP(tw12, ptwd, sizeof(ae_int16x4));
      AE_L16X4_XP(tw34, ptwd, (2*tw_step-1)*sizeof(ae_int16x4));

      AE_L32X2_XP(x0, px0, _v * sizeof(ae_int32x2));
      AE_L32X2_XP(x1, px1, _v * sizeof(ae_int32x2));
      AE_L32X2_XP(x2, px2, _v * sizeof(ae_int32x2));
      AE_L32X2_XP(x3, px3, _v * sizeof(ae_int32x2));
      AE_L32X2_XP(x4, px4, _v * sizeof(ae_int32x2));

      x0 = AE_SRAA32RS(x0, shift);
      x1 = AE_SRAA32RS(x1, shift);
      x2 = AE_SRAA32RS(x2, shift);
      x3 = AE_SRAA32RS(x3, shift);
      x4 = AE_SRAA32RS(x4, shift);
      DFT5X1(x0, x1, x2, x3, x4);
      x1 = AE_MULFC32X16RAS_H(x1, tw12);
      x2 = AE_MULFC32X16RAS_L(x2, tw12);
      x3 = AE_MULFC32X16RAS_H(x3, tw34);
      x4 = AE_MULFC32X16RAS_L(x4, tw34);

      AE_S32X2RNG_XP(x0, py0, _v * sizeof(ae_int32x2));
      AE_S32X2RNG_XP(x1, py0, _v * sizeof(ae_int32x2));
      AE_S32X2RNG_XP(x2, py0, _v * sizeof(ae_int32x2));
      AE_S32X2RNG_XP(x3, py0, _v * sizeof(ae_int32x2));
      AE_S32X2RNG_XP(x4, py0, _v * sizeof(ae_int32x2));
    }
  }

  AE_CALCRNG3();
  *bexp = 3 - RUR_AE_SAR();
  *v *= R;
  return shift;
} /* fft_32x16_stage_inner_scl2_DFT5() */

/*
 *  32x16 IFFT first stage Radix 2, scalingOption=2
 */
int ifft_32x16_stage_first_scl2_DFT2(const int16_t *tw, const int32_t *x, int32_t *y, int N, int *v, int tw_step, int *bexp)
{ 
  int i;
  int shift, shiftl, shiftr;
        ae_int32x2 * restrict px0;
        ae_int32x2 * restrict py0;
  const ae_int32   * restrict ptwd;
  ae_int32x2 scl;
  ae_int32x2 x0, x1, y0, y1;
  const int R = 2; // stage radix
  const int stride = (N >> 1);
  const int min_shift = 2;

  NASSERT_ALIGN8(x);
  NASSERT_ALIGN8(y);
  shift = min_shift - *bexp;
  shiftl = XT_MAX(0, -shift);
  shiftr = XT_MAX(0,  shift);
  NASSERT(shift>-32 && shift<4);

  scl = 1 << shiftl;
  WUR_AE_SAR(shiftr);

  ptwd = (const ae_int32 *)tw;
  px0 = (ae_int32x2*)x;
  py0 = (ae_int32x2 *)(y);
  {
    /* First butterfly radix 2 */
    ae_int16x4 tw1;
    ae_int32x2 tw1_tmp;

    AE_L32_IP(tw1_tmp, ptwd, 2*sizeof(int16_t));
    tw1 = AE_SHORTSWAP(AE_MOVINT16X4_FROMINT32X2(tw1_tmp));

    x0 = AE_L32X2_I(px0, 0);
    x1 = AE_L32X2_X(px0, (N-stride)*sizeof(ae_int32x2));

    x0 = AE_MULP32X2(x0, scl);
    x1 = AE_MULP32X2(x1, scl);
    AE_ADDANDSUBRNG32(y0, y1, x0, x1);
    y1 = AE_MULFC32X16RAS_L(y1, tw1);

    AE_S32X2RNG_IP(y0, py0, sizeof(ae_int32x2));
    AE_S32X2RNG_IP(y1, py0, sizeof(ae_int32x2));
  }
  px0 = (ae_int32x2*)x + N-stride-1;
  for (i = 1; i < stride; i++)
  { 
    ae_int16x4 tw1;
    ae_int32x2 tw1_tmp;

    AE_L32_IP(tw1_tmp, ptwd, 2*sizeof(int16_t));
    tw1 = AE_SHORTSWAP(AE_MOVINT16X4_FROMINT32X2(tw1_tmp));

    AE_L32X2_XP(x1, px0, stride * sizeof(ae_int32x2));
    AE_L32X2_XP(x0, px0, (-stride - 1) * sizeof(ae_int32x2));

    x0 = AE_MULP32X2(x0, scl);
    x1 = AE_MULP32X2(x1, scl);
    AE_ADDANDSUBRNG32(y0, y1, x0, x1);
    y1 = AE_MULFC32X16RAS_L(y1, tw1);

    AE_S32X2RNG_IP(y0, py0, sizeof(ae_int32x2));
    AE_S32X2RNG_IP(y1, py0, sizeof(ae_int32x2));
  }

  AE_CALCRNG3();
  *bexp = 3 - RUR_AE_SAR();
  *v *= R;
  return shift;
} /* ifft_32x16_stage_first_scl2_DFT2() */

/*
 *  32x16 IFFT first stage Radix 3, scalingOption=2
 */
int ifft_32x16_stage_first_scl2_DFT3(const int16_t *tw, const int32_t *x, int32_t *y, int N, int *v, int tw_step, int *bexp)
{ 

  int shift;
  int min_shift = 3;
  ae_int32x2 * restrict px0;
  ae_int32x2 * restrict py0;
  const ae_int16x4 * restrict ptwd;
  const int R = 3; // stage radix
  const int stride = N / R;
  int i;
  NASSERT_ALIGN8(x);
  NASSERT_ALIGN8(y);

  py0 = (ae_int32x2 *)y;
  px0 = (ae_int32x2 *)x + N - 2*stride;
  ptwd = (const ae_int16x4 *)tw;
  shift = min_shift - *bexp;
  NASSERT(shift>-32 && shift<32);
  WUR_AE_SAR(0);
  /*
  ifft(x) = fft( [ x(1), x(end:-1:2)] )
  */
  {
    /* First butterfly radix 3 */
    ae_int32x2 x0, x1, x2;
    ae_int16x4 tw12;

    AE_L16X4_IP(tw12, ptwd, sizeof(ae_int16x4));

    AE_L32X2_XP(x2, px0, stride*sizeof(ae_int32x2));
    AE_L32X2_XP(x1, px0, stride*sizeof(ae_int32x2));
    x0 = AE_L32X2_X((ae_int32x2*)x, 0);

    x0 = AE_SRAA32RS(x0, shift);
    x1 = AE_SRAA32RS(x1, shift);
    x2 = AE_SRAA32RS(x2, shift);
    DFT3X1(x0, x1, x2);
    x1 = AE_MULFC32X16RAS_H(x1, tw12);
    x2 = AE_MULFC32X16RAS_L(x2, tw12);

    AE_S32X2RNG_IP(x0, py0, sizeof(ae_int32x2));
    AE_S32X2RNG_IP(x1, py0, sizeof(ae_int32x2));
    AE_S32X2RNG_IP(x2, py0, sizeof(ae_int32x2));
  }
  px0 = (ae_int32x2*)x + N - 2*stride - 1;
  __Pragma("loop_count min=1");
  for (i = 1; i <stride; i++)
  {
    ae_int32x2 x0, x1, x2;
    ae_int16x4 tw12;

    AE_L16X4_IP(tw12, ptwd, sizeof(ae_int16x4));

    AE_L32X2_XP(x2, px0, stride*sizeof(ae_int32x2));
    AE_L32X2_XP(x1, px0, stride*sizeof(ae_int32x2));
    AE_L32X2_XP(x0, px0, (-2*stride - 1)*sizeof(ae_int32x2));

    x0 = AE_SRAA32RS(x0, shift);
    x1 = AE_SRAA32RS(x1, shift);
    x2 = AE_SRAA32RS(x2, shift);
    DFT3X1(x0, x1, x2);
    x1 = AE_MULFC32X16RAS_H(x1, tw12);
    x2 = AE_MULFC32X16RAS_L(x2, tw12);

    AE_S32X2RNG_IP(x0, py0, sizeof(ae_int32x2));
    AE_S32X2RNG_IP(x1, py0, sizeof(ae_int32x2));
    AE_S32X2RNG_IP(x2, py0, sizeof(ae_int32x2));
  }

  AE_CALCRNG3();
  *bexp = 3 - RUR_AE_SAR();
  *v *= R;
  return shift;
} /* ifft_32x16_stage_first_scl2_DFT3() */

/*
 *  32x16 IFFT first stage Radix 5, scalingOption=2
 */
int ifft_32x16_stage_first_scl2_DFT5(const int16_t *tw, const int32_t *x, int32_t *y, int N, int *v, int tw_step, int *bexp)
{ 
  int shift;
  const int min_shift = 3;
  const int R = 5; // stage radix
  const ae_int32x2 * restrict px0;
  const ae_int32x2 * restrict px1;
  const ae_int32x2 * restrict px2;
  const ae_int32x2 * restrict px3;
  const ae_int32x2 * restrict px4;
        ae_int32x2 * restrict py0;
  const ae_int16x4 * restrict ptwd;
  const int stride = N / R;
  int i;

  NASSERT_ALIGN8(x);
  NASSERT_ALIGN8(y);
  shift = min_shift - *bexp;
  NASSERT(shift>-32 && shift<32);
  WUR_AE_SAR(0);

  /*
  ifft(x) = fft( [ x(1), x(end:-1:2)] )
  */
  px0 = (ae_int32x2 *)x + N-4*stride;
  py0 = (ae_int32x2 *)y;
  ptwd = (const ae_int16x4 *)tw;
  {
    /* First butterfly radix 5 */
    ae_int32x2 x0, x1, x2, x3, x4;
    ae_int16x4 tw12, tw34;

    AE_L16X4_IP(tw12, ptwd, sizeof(ae_int16x4));
    AE_L16X4_IP(tw34, ptwd, sizeof(ae_int16x4));

    AE_L32X2_XP(x4, px0, stride * sizeof(ae_int32x2));
    AE_L32X2_XP(x3, px0, stride * sizeof(ae_int32x2));
    AE_L32X2_XP(x2, px0, stride * sizeof(ae_int32x2));
    AE_L32X2_XP(x1, px0, stride * sizeof(ae_int32x2));
    x0 = AE_L32X2_X((ae_int32x2*)x, 0);

    x0 = AE_SRAA32RS(x0, shift);
    x1 = AE_SRAA32RS(x1, shift);
    x2 = AE_SRAA32RS(x2, shift);
    x3 = AE_SRAA32RS(x3, shift);
    x4 = AE_SRAA32RS(x4, shift);
    DFT5X1(x0, x1, x2, x3, x4);
    x1 = AE_MULFC32X16RAS_H(x1, tw12);
    x2 = AE_MULFC32X16RAS_L(x2, tw12);
    x3 = AE_MULFC32X16RAS_H(x3, tw34);
    x4 = AE_MULFC32X16RAS_L(x4, tw34);

    AE_S32X2RNG_IP(x0, py0, sizeof(ae_int32x2));
    AE_S32X2RNG_IP(x1, py0, sizeof(ae_int32x2));
    AE_S32X2RNG_IP(x2, py0, sizeof(ae_int32x2));
    AE_S32X2RNG_IP(x3, py0, sizeof(ae_int32x2));
    AE_S32X2RNG_IP(x4, py0, sizeof(ae_int32x2));
  }
  px4 = (ae_int32x2*)x + N-1;
  px3 = px4 - stride;
  px2 = px3 - stride;
  px1 = px2 - stride;
  px0 = px1 - stride;
  __Pragma("loop_count min=1");
  for (i = 1; i <stride; i++)
  {
    ae_int32x2 x0, x1, x2, x3, x4;
    ae_int16x4 tw12, tw34;

    AE_L16X4_IP(tw12, ptwd, sizeof(ae_int16x4));
    AE_L16X4_IP(tw34, ptwd, sizeof(ae_int16x4));

    AE_L32X2_XP(x4, px0, -1*(int)sizeof(ae_int32x2));
    AE_L32X2_XP(x3, px1, -1*(int)sizeof(ae_int32x2));
    AE_L32X2_XP(x2, px2, -1*(int)sizeof(ae_int32x2));
    AE_L32X2_XP(x1, px3, -1*(int)sizeof(ae_int32x2));
    AE_L32X2_XP(x0, px4, -1*(int)sizeof(ae_int32x2));

    x0 = AE_SRAA32RS(x0, shift);
    x1 = AE_SRAA32RS(x1, shift);
    x2 = AE_SRAA32RS(x2, shift);
    x3 = AE_SRAA32RS(x3, shift);
    x4 = AE_SRAA32RS(x4, shift);
    DFT5X1(x0, x1, x2, x3, x4);
    x1 = AE_MULFC32X16RAS_H(x1, tw12);
    x2 = AE_MULFC32X16RAS_L(x2, tw12);
    x3 = AE_MULFC32X16RAS_H(x3, tw34);
    x4 = AE_MULFC32X16RAS_L(x4, tw34);

    AE_S32X2RNG_IP(x0, py0, sizeof(ae_int32x2));
    AE_S32X2RNG_IP(x1, py0, sizeof(ae_int32x2));
    AE_S32X2RNG_IP(x2, py0, sizeof(ae_int32x2));
    AE_S32X2RNG_IP(x3, py0, sizeof(ae_int32x2));
    AE_S32X2RNG_IP(x4, py0, sizeof(ae_int32x2));
  }

  AE_CALCRNG3();
  *bexp = 3 - RUR_AE_SAR();
  *v *= R;
  return shift;
} /* ifft_32x16_stage_first_scl2_DFT5() */
