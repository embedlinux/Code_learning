/* ------------------------------------------------------------------------ */
/* Copyright (c) 2018 by Cadence Design Systems, Inc. ALL RIGHTS RESERVED.  */
/* These coded instructions, statements, and computer programs (�Cadence    */
/* Libraries�) are the copyrighted works of Cadence Design Systems Inc.	    */
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
/*          Copyright (C) 2015-2016 IntegrIT, Limited.                      */
/*                      All Rights Reserved.                                */
/* ------------------------------------------------------------------------ */
/*
  NatureDSP Signal Processing Library. FFT part
    Complex-valued FFT stages with butterflies radix-2, radix-3, radix-5
    with dynamic data scaling: 32-bit data, 32-bit twiddle factors
    C code optimized for HiFi4
  IntegrIT, 2006-2014
*/
#include "NatureDSP_Signal_fft.h"
#include "fft_twiddles32x32.h"
#include "common.h"

inline_ void _cmult32x32(ae_int32x2 *result, ae_int32x2 *x, ae_int32x2 *y)
{
  ae_f32x2 z;

  z = AE_MULFC32RAS(AE_MOVF32X2_FROMINT32X2(*x), AE_MOVF32X2_FROMINT32X2(*y));
  *result = AE_MOVINT32X2_FROMF32X2(z);
}

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
    ae_int32x2 s0, s1, d0;            \
    ae_int32x2 c;                     \
    c = AE_MOVDA32X2(0x0,0x6ED9EBA1); \
    AE_ADDANDSUB32S(s0, d0, x1, x2);  \
    s1 = AE_ADD32S(x0, s0);           \
    s0 = AE_SRAI32(s0, 1);            \
    _cmult32x32(&d0, &d0, &c);        \
    s0 = AE_SUB32S(x0, s0);           \
    x0 = s1;                          \
    AE_ADDANDSUB32S(x2, x1, s0, d0);  \
}

/* radix-3 butterfly with data scaling using AE.SAR register & 'shift' value */
#define DFT3X1_RNG_shift(x0, x1, x2, shift)\
{\
    ae_int32x2 s0, s1, d0;            \
    ae_int32x2 c;                     \
    c = AE_MOVDA32X2(0x0,0x6ED9EBA1); \
    x0 = AE_SRAA32(x0, shift);        \
    AE_ADDANDSUBRNG32(s0, d0, x1, x2);\
    s1 = AE_ADD32S(x0, s0);           \
    s0 = AE_SRAI32(s0, 1);            \
    _cmult32x32(&d0, &d0, &c);        \
    s0 = AE_SUB32S(x0, s0);           \
    x0 = s1;                          \
    AE_ADDANDSUB32S(x2, x1, s0, d0);  \
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
  ae_int32x2 s1, s2, d1, d2;                                 \
  ae_int32x2 y0, y1, y2        ;                             \
  ae_int32x2 t0, t1, t2, t3;                                 \
  ae_int32x2 real_w1, jimag_w1, real_w2, jimag_w2;           \
  real_w1 = AE_MOVDA32X2(0x278DDE6E, 0x0);                   \
  jimag_w1 = AE_MOVDA32X2(0x0,0x8643C7B3);                   \
  real_w2 = AE_MOVDA32X2(0x98722192,0x0);                    \
  jimag_w2 = AE_MOVDA32X2(0x0,0xB4C373EE);                   \
  AE_ADDANDSUB32S(s1, d1, x1, x4);                           \
  AE_ADDANDSUB32S(s2, d2, x2, x3);                           \
  _cmult32x32(&t0, &s1, &real_w1);                           \
  _cmult32x32(&t1, &s2, &real_w2);                           \
  _cmult32x32(&t2, &s1, &real_w2);                           \
  _cmult32x32(&t3, &s2, &real_w1);                           \
  y0 = AE_ADD32S(x0, AE_ADD32S(s1, s2));                     \
  y1 = AE_ADD32S(x0, AE_ADD32S(t0, t1));                     \
  y2 = AE_ADD32S(x0, AE_ADD32S(t2, t3));                     \
  _cmult32x32(&t0, &d1, &jimag_w1);                          \
  _cmult32x32(&t1, &d2, &jimag_w2);                          \
  _cmult32x32(&t2, &d2, &jimag_w1);                          \
  _cmult32x32(&t3, &d1, &jimag_w2);                          \
  t0 = AE_ADD32S(t0, t1);                                    \
  t1 = AE_SUB32S(t3, t2);                                    \
  x0 = y0;                                                   \
  AE_ADDANDSUB32S(x1, x4, y1, t0);                           \
  AE_ADDANDSUB32S(x2, x3, y2, t1);                           \
}                                                       

/*
 *  32x32 FFT first stage Radix 2, scalingOption=2
 */
int fft_stageS2_DFT2_first_32x32(const int32_t *tw, const int32_t *x, int32_t *y, int N, int *v, int tw_step, int *bexp)
{
  const ae_int32x2 * restrict px0;
  const ae_int32x2 * restrict px1;
        ae_int32x2 * restrict py0;
  const ae_int32x2 * restrict ptwd;
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
  ptwd = (const ae_int32x2 *)tw;

  __Pragma("loop_count min=3");
  for (i = 0; i < stride; i++)
  {
    ae_int32x2 x0, x1, y0, y1;
    ae_int32x2 tw1;

    AE_L32X2_IP(tw1, ptwd, sizeof(ae_int32x2));

    AE_L32X2_IP(x0, px0, sizeof(ae_int32x2));
    AE_L32X2_IP(x1, px1, sizeof(ae_int32x2));
    x0 = AE_MULP32X2(x0, scl);
    x1 = AE_MULP32X2(x1, scl);
    AE_ADDANDSUBRNG32(y0, y1, x0, x1);
    _cmult32x32(&y1, &y1, &tw1);
    AE_S32X2RNG_IP(y0, py0, sizeof(ae_int32x2));
    AE_S32X2RNG_IP(y1, py0, sizeof(ae_int32x2));
  }

  AE_CALCRNG3();
  *bexp = 3 - RUR_AE_SAR();
  *v *= R;
  return shift;
} /* fft_stageS2_DFT2_first_32x32() */

/*
 *  32x32 FFT last stage Radix 2, scalingOption=2
 */
int fft_stageS2_DFT2_last_32x32(const int32_t *tw, const int32_t *x, int32_t *y, int N, int *v, int tw_step, int *bexp)
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
} /* fft_stageS2_DFT2_last_32x32() */

/*
 *  32x32 FFT/IFFT intermediate stage Radix 2, scalingOption=2
 */
int fft_stageS2_DFT2_32x32(const int32_t *tw, const int32_t *x, int32_t *y, int N, int *v, int tw_step, int *bexp)
{ 
  int i, j, _v;
  int shift;
  const ae_int32x2 * restrict px0;
        ae_int32x2 * restrict py0;
  const ae_int32x2 * restrict ptwd;
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
    ae_int32x2 tw1;
    ptwd = (const ae_int32x2 *)tw;
    px0 = (ae_int32x2 *)x + j;
    py0 = (ae_int32x2 *)y + j;
    __Pragma("loop_count min=1");
    for (i = 0; i < (stride / _v); i++)
    {
      AE_L32X2_XP(tw1, ptwd, tw_step*sizeof(ae_int32x2));

      x1 = AE_L32X2_X(px0, sizeof(ae_int32x2) * stride);
      AE_L32X2_XP(x0, px0, _v * sizeof(ae_int32x2));
      AE_ADDANDSUBRNG32(y0, y1, x0, x1);
      _cmult32x32(&y1, &y1, &tw1);
      AE_S32X2RNG_XP(y0, py0, _v * sizeof(ae_int32x2));
      AE_S32X2RNG_XP(y1, py0, _v * sizeof(ae_int32x2));
    }
  }
  AE_CALCRNG3();
  *bexp = 3 - RUR_AE_SAR();
  *v *= R;
  return shift;
} /* fft_stageS2_DFT2_32x32() */

/*
 *  32x32 FFT first stage Radix 3, scalingOption=2
 */
int fft_stageS2_DFT3_first_32x32(const int32_t *tw, const int32_t *x, int32_t *y, int N, int *v, int tw_step, int *bexp)
{
  const int R = 3; // stage radix
  const int stride = N / R;
  int shift;
  ae_int32x2 * restrict px0;
  ae_int32x2 * restrict px1;
  ae_int32x2 * restrict px2;
  ae_int32x2 * restrict py0;
  const ae_int32x2 * restrict ptwd;
  int min_shift = 3;
  int i;
  NASSERT_ALIGN8(x);
  NASSERT_ALIGN8(y);

  px0 = (ae_int32x2 *)x;
  px1 = px0 + stride;
  px2 = px1 + stride;
  py0 = (ae_int32x2 *)y;
  ptwd = (const ae_int32x2 *)tw;

  shift = min_shift - *bexp;
  NASSERT(shift>-32 && shift<32);
  WUR_AE_SAR(0);

  __Pragma("loop_count min=2");
  for (i = 0; i <stride; i++)
  {
    ae_int32x2 x0, x1, x2;
    ae_int32x2 tw1, tw2;

    AE_L32X2_IP(tw1, ptwd, sizeof(ae_int32x2));
    AE_L32X2_IP(tw2, ptwd, sizeof(ae_int32x2));

    AE_L32X2_IP(x0, px0, sizeof(ae_int32x2));
    AE_L32X2_IP(x1, px1, sizeof(ae_int32x2));
    AE_L32X2_IP(x2, px2, sizeof(ae_int32x2));
    x0 = AE_SRAA32RS(x0, shift);
    x1 = AE_SRAA32RS(x1, shift);
    x2 = AE_SRAA32RS(x2, shift);

    DFT3X1(x0, x1, x2);
    _cmult32x32(&x1, &x1, &tw1);
    _cmult32x32(&x2, &x2, &tw2);

    AE_S32X2RNG_IP(x0, py0, sizeof(ae_int32x2));
    AE_S32X2RNG_IP(x1, py0, sizeof(ae_int32x2));
    AE_S32X2RNG_IP(x2, py0, sizeof(ae_int32x2));
  }

  AE_CALCRNG3();
  *bexp = 3 - RUR_AE_SAR();
  *v *= R;
  return shift;
} /* fft_stageS2_DFT3_first_32x32() */

/*
 *  32x32 FFT last stage Radix 3, scalingOption=2
 */
int fft_stageS2_DFT3_last_32x32(const int32_t *tw, const int32_t *x, int32_t *y, int N, int *v, int tw_step, int *bexp)
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
} /* fft_stageS2_DFT3_last_32x32() */

/*
 *  32x32 FFT/IFFT intermediate stage Radix 3, scalingOption=2
 */
int fft_stageS2_DFT3_32x32(const int32_t *tw, const int32_t *x, int32_t *y, int N, int *v, int tw_step, int *bexp)
{ 
  const int R = 3; // stage radix
  const int stride = N / R;
  int min_shift = 3;
  int shift;
        ae_int32x2 * restrict px0;
        ae_int32x2 * restrict py0;
  const ae_int32x2 * restrict ptwd;

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
      ae_int32x2 tw1, tw2;
      ptwd = (const ae_int32x2 *)tw;
      px0 = (ae_int32x2 *)x + j;
      py0 = (ae_int32x2 *)y + j;
      __Pragma("loop_count min=2");
      __Pragma("no_unroll");
      for (i = 0; i < (stride / _v); i++)
      {
        AE_L32X2_IP(tw1, ptwd, sizeof(ae_int32x2));
        AE_L32X2_IP(tw2, ptwd, sizeof(ae_int32x2));

        AE_L32X2_XP(x0, px0, stride * sizeof(ae_int32x2));
        AE_L32X2_XP(x1, px0, stride * sizeof(ae_int32x2));
        AE_L32X2_XP(x2, px0, (_v-2*stride) * sizeof(ae_int32x2));

        DFT3X1_RNG_shift(x0, x1, x2, shift);
        _cmult32x32(&x1, &x1, &tw1);
        _cmult32x32(&x2, &x2, &tw2);

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
} /* fft_stageS2_DFT3_32x32() */

/*
 *  32x32 FFT first stage Radix 5, scalingOption=2
 */
int fft_stageS2_DFT5_first_32x32(const int32_t *tw, const int32_t *x, int32_t *y, int N, int *v, int tw_step, int *bexp)
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
  const ae_int32x2 * restrict ptwd;

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
  ptwd = (const ae_int32x2 *)tw;

  __Pragma("loop_count min=6");
  for (i = 0; i <stride; i++)
  {
    ae_int32x2 x0, x1, x2, x3, x4;
    ae_int32x2 tw1, tw2, tw3, tw4;

    AE_L32X2_IP(tw1, ptwd, sizeof(ae_int32x2));
    AE_L32X2_IP(tw2, ptwd, sizeof(ae_int32x2));
    AE_L32X2_IP(tw3, ptwd, sizeof(ae_int32x2));
    AE_L32X2_IP(tw4, ptwd, sizeof(ae_int32x2));

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
    _cmult32x32(&x1, &x1, &tw1);
    _cmult32x32(&x2, &x2, &tw2);
    _cmult32x32(&x3, &x3, &tw3);
    _cmult32x32(&x4, &x4, &tw4);

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
} /* fft_stageS2_DFT5_first_32x32() */

/*
 *  32x32 FFT last stage Radix 5, scalingOption=2
 */
int fft_stageS2_DFT5_last_32x32(const int32_t *tw, const int32_t *x, int32_t *y, int N, int *v, int tw_step, int *bexp)
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
} /* fft_stageS2_DFT5_last_32x32() */

/*
 *  32x32 FFT/IFFT intermediate stage Radix 5, scalingOption=2
 */
int fft_stageS2_DFT5_32x32(const int32_t *tw, const int32_t *x, int32_t *y, int N, int *v, int tw_step, int *bexp)
{
  const int R = 5; // stage radix
  const int stride = N / R;
  const int min_shift = 3;
  int shift;
  int i, j, _v;
        ae_int32x2 * restrict px0;
        ae_int32x2 * restrict py0;
  const ae_int32x2 * restrict ptwd;
  NASSERT_ALIGN8(x);
  NASSERT_ALIGN8(y);

  shift = min_shift - *bexp;
  NASSERT(shift>=0 && shift<5);
  WUR_AE_SAR(0);
  _v = *v;
  for (j = 0; j < _v; j++)
  {
    ae_int32x2 x0, x1, x2, x3, x4;
    ae_int32x2 tw1, tw2, tw3, tw4;
    ptwd = (const ae_int32x2 *)tw;
    px0 = (ae_int32x2 *)x + j;
    py0 = (ae_int32x2 *)y + j;

    for (i = 0; i < (stride / _v); i++)
    {
      AE_L32X2_IP(tw1, ptwd, sizeof(ae_int32x2));
      AE_L32X2_IP(tw2, ptwd, sizeof(ae_int32x2));
      AE_L32X2_IP(tw3, ptwd, sizeof(ae_int32x2));
      AE_L32X2_IP(tw4, ptwd, sizeof(ae_int32x2));

      x1 = AE_L32X2_X(px0, sizeof(ae_int32x2) * stride);
      x2 = AE_L32X2_X(px0, sizeof(ae_int32x2) * stride * 2);
      x3 = AE_L32X2_X(px0, sizeof(ae_int32x2) * stride * 3);
      x4 = AE_L32X2_X(px0, sizeof(ae_int32x2) * stride * 4);
      AE_L32X2_XP(x0, px0, _v * sizeof(ae_int32x2));

      x0 = AE_SRAA32RS(x0, shift);
      x1 = AE_SRAA32RS(x1, shift);
      x2 = AE_SRAA32RS(x2, shift);
      x3 = AE_SRAA32RS(x3, shift);
      x4 = AE_SRAA32RS(x4, shift);
      DFT5X1(x0, x1, x2, x3, x4);
      _cmult32x32(&x1, &x1, &tw1);
      _cmult32x32(&x2, &x2, &tw2);
      _cmult32x32(&x3, &x3, &tw3);
      _cmult32x32(&x4, &x4, &tw4);

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
} /* fft_stageS2_DFT5_32x32() */

/*
 *  32x32 IFFT first stage Radix 2, scalingOption=2
 */
int ifft_stageS2_DFT2_first_32x32(const int32_t *tw, const int32_t *x, int32_t *y, int N, int *v, int tw_step, int *bexp)
{ 
  int i;
  int shift, shiftl, shiftr;
        ae_int32x2 * restrict px0;
        ae_int32x2 * restrict py0;
  const ae_int32x2 * restrict ptwd;
  ae_int32x2 scl;
  ae_int32x2 x0, x1, y0, y1;
  ae_int32x2 tw1;
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

  ptwd = (const ae_int32x2 *)tw;
  px0 = (ae_int32x2*)x;
  py0 = (ae_int32x2 *)(y);
  {
    /* First butterfly radix 2 */
    AE_L32X2_IP(tw1, ptwd, sizeof(ae_int32x2));

    x0 = AE_L32X2_X(px0, 0);
    x1 = AE_L32X2_X(px0, (N-stride)*sizeof(ae_int32x2));

    x0 = AE_MULP32X2(x0, scl);
    x1 = AE_MULP32X2(x1, scl);
    AE_ADDANDSUBRNG32(y0, y1, x0, x1);
    _cmult32x32(&y1, &y1, &tw1);

    AE_S32X2RNG_IP(y0, py0, sizeof(ae_int32x2));
    AE_S32X2RNG_IP(y1, py0, sizeof(ae_int32x2));
  }
  px0 = (ae_int32x2*)x + N-stride-1;
  for (i = 1; i < stride; i++)
  { 

    AE_L32X2_IP(tw1, ptwd, sizeof(ae_int32x2));

    AE_L32X2_XP(x1, px0, 8 * stride);
    AE_L32X2_XP(x0, px0, (-1 * stride - 1) * 8);

    x0 = AE_MULP32X2(x0, scl);
    x1 = AE_MULP32X2(x1, scl);
    AE_ADDANDSUBRNG32(y0, y1, x0, x1);
    _cmult32x32(&y1, &y1, &tw1);

    AE_S32X2RNG_IP(y0, py0, sizeof(ae_int32x2));
    AE_S32X2RNG_IP(y1, py0, sizeof(ae_int32x2));
  }

  AE_CALCRNG3();
  *bexp = 3 - RUR_AE_SAR();
  *v *= R;
  return shift;
} /* ifft_stageS2_DFT2_first_32x32() */

/*
 *  32x32 IFFT first stage Radix 3, scalingOption=2
 */
int ifft_stageS2_DFT3_first_32x32(const int32_t *tw, const int32_t *x, int32_t *y, int N, int *v, int tw_step, int *bexp)
{ 

  int shift;
  int min_shift = 3;
  ae_int32x2 * restrict px0;
  ae_int32x2 * restrict py0;
  const ae_int32x2 * restrict ptwd;
  const int R = 3; // stage radix
  const int stride = N / R;
  NASSERT_ALIGN8(x);
  NASSERT_ALIGN8(y);
  int i;

  py0 = (ae_int32x2 *)y;
  px0 = (ae_int32x2 *)x + N - 2*stride;
  ptwd = (const ae_int32x2 *)tw;
  shift = min_shift - *bexp;
  NASSERT(shift>-32 && shift<32);
  WUR_AE_SAR(0);
  /*
  ifft(x) = fft( [ x(1), x(end:-1:2)] )
  */
  {
    /* First butterfly radix 3 */
    ae_int32x2 x0, x1, x2;
    ae_int32x2 tw1, tw2;

    AE_L32X2_IP(tw1, ptwd, sizeof(ae_int32x2));
    AE_L32X2_IP(tw2, ptwd, sizeof(ae_int32x2));

    AE_L32X2_XP(x2, px0, stride*sizeof(ae_int32x2));
    AE_L32X2_XP(x1, px0, stride*sizeof(ae_int32x2));
    x0 = AE_L32X2_X((ae_int32x2*)x, 0);

    x0 = AE_SRAA32RS(x0, shift);
    x1 = AE_SRAA32RS(x1, shift);
    x2 = AE_SRAA32RS(x2, shift);
    DFT3X1(x0, x1, x2);
    _cmult32x32(&x1, &x1, &tw1);
    _cmult32x32(&x2, &x2, &tw2);

    AE_S32X2RNG_IP(x0, py0, sizeof(ae_int32x2));
    AE_S32X2RNG_IP(x1, py0, sizeof(ae_int32x2));
    AE_S32X2RNG_IP(x2, py0, sizeof(ae_int32x2));
  }
  px0 = (ae_int32x2*)x + N - 2*stride - 1;
  __Pragma("loop_count min=1");
  for (i = 1; i <stride; i++)
  {
    ae_int32x2 x0, x1, x2;
    ae_int32x2 tw1, tw2;

    AE_L32X2_IP(tw1, ptwd, sizeof(ae_int32x2));
    AE_L32X2_IP(tw2, ptwd, sizeof(ae_int32x2));

    AE_L32X2_XP(x2, px0, stride*sizeof(ae_int32x2));
    AE_L32X2_XP(x1, px0, stride*sizeof(ae_int32x2));
    AE_L32X2_XP(x0, px0, (-2*stride - 1)*sizeof(ae_int32x2));

    x0 = AE_SRAA32RS(x0, shift);
    x1 = AE_SRAA32RS(x1, shift);
    x2 = AE_SRAA32RS(x2, shift);
    DFT3X1(x0, x1, x2);
    _cmult32x32(&x1, &x1, &tw1);
    _cmult32x32(&x2, &x2, &tw2);

    AE_S32X2RNG_IP(x0, py0, sizeof(ae_int32x2));
    AE_S32X2RNG_IP(x1, py0, sizeof(ae_int32x2));
    AE_S32X2RNG_IP(x2, py0, sizeof(ae_int32x2));
  }

  AE_CALCRNG3();
  *bexp = 3 - RUR_AE_SAR();
  *v *= R;
  return shift;
} /* ifft_stageS2_DFT3_first_32x32() */

/*
 *  32x32 IFFT first stage Radix 5, scalingOption=2
 */
int ifft_stageS2_DFT5_first_32x32(const int32_t *tw, const int32_t *x, int32_t *y, int N, int *v, int tw_step, int *bexp)
{ 
  int shift;
  const int min_shift = 3;
  const int R = 5; // stage radix
  ae_int32x2 * restrict px0;
  ae_int32x2 * restrict py0;
  const ae_int32x2 * restrict ptwd;
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
  ptwd = (const ae_int32x2 *)tw;
  {
    /* First butterfly radix 5 */
    ae_int32x2 x0, x1, x2, x3, x4;
    ae_int32x2 tw1, tw2, tw3, tw4;

    AE_L32X2_IP(tw1, ptwd, sizeof(ae_int32x2));
    AE_L32X2_IP(tw2, ptwd, sizeof(ae_int32x2));
    AE_L32X2_IP(tw3, ptwd, sizeof(ae_int32x2));
    AE_L32X2_IP(tw4, ptwd, sizeof(ae_int32x2));

    AE_L32X2_XP(x4, px0, 8 * stride);
    AE_L32X2_XP(x3, px0, 8 * stride);
    AE_L32X2_XP(x2, px0, 8 * stride);
    AE_L32X2_XP(x1, px0, 8 * stride);
    x0 = AE_L32X2_X((ae_int32x2*)x, 0);

    x0 = AE_SRAA32RS(x0, shift);
    x1 = AE_SRAA32RS(x1, shift);
    x2 = AE_SRAA32RS(x2, shift);
    x3 = AE_SRAA32RS(x3, shift);
    x4 = AE_SRAA32RS(x4, shift);
    DFT5X1(x0, x1, x2, x3, x4);
    _cmult32x32(&x1, &x1, &tw1);
    _cmult32x32(&x2, &x2, &tw2);
    _cmult32x32(&x3, &x3, &tw3);
    _cmult32x32(&x4, &x4, &tw4);

    AE_S32X2RNG_IP(x0, py0, sizeof(ae_int32x2));
    AE_S32X2RNG_IP(x1, py0, sizeof(ae_int32x2));
    AE_S32X2RNG_IP(x2, py0, sizeof(ae_int32x2));
    AE_S32X2RNG_IP(x3, py0, sizeof(ae_int32x2));
    AE_S32X2RNG_IP(x4, py0, sizeof(ae_int32x2));
  }
  px0 = (ae_int32x2*)x + N-1-4*stride;

  for (i = 1; i <stride; i++)
  {
    ae_int32x2 x0, x1, x2, x3, x4;
    ae_int32x2 tw1, tw2, tw3, tw4;

    AE_L32X2_IP(tw1, ptwd, sizeof(ae_int32x2));
    AE_L32X2_IP(tw2, ptwd, sizeof(ae_int32x2));
    AE_L32X2_IP(tw3, ptwd, sizeof(ae_int32x2));
    AE_L32X2_IP(tw4, ptwd, sizeof(ae_int32x2));

    AE_L32X2_XP(x4, px0, 8 * stride);
    AE_L32X2_XP(x3, px0, 8 * stride);
    AE_L32X2_XP(x2, px0, 8 * stride);
    AE_L32X2_XP(x1, px0, 8 * stride);
    AE_L32X2_XP(x0, px0, (-4 * stride - 1) * 8);

    x0 = AE_SRAA32RS(x0, shift);
    x1 = AE_SRAA32RS(x1, shift);
    x2 = AE_SRAA32RS(x2, shift);
    x3 = AE_SRAA32RS(x3, shift);
    x4 = AE_SRAA32RS(x4, shift);
    DFT5X1(x0, x1, x2, x3, x4);
    _cmult32x32(&x1, &x1, &tw1);
    _cmult32x32(&x2, &x2, &tw2);
    _cmult32x32(&x3, &x3, &tw3);
    _cmult32x32(&x4, &x4, &tw4);

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
} /* ifft_stageS2_DFT5_first_32x32() */

int ifft_stageS2_DFT2_32x32(const int32_t *tw, const int32_t *x, int32_t *y, int N, int *v, int tw_step, int *bexp){ return 0; }
int ifft_stageS2_DFT3_32x32(const int32_t *tw, const int32_t *x, int32_t *y, int N, int *v, int tw_step, int *bexp){ return 0; }
int ifft_stageS2_DFT5_32x32(const int32_t *tw, const int32_t *x, int32_t *y, int N, int *v, int tw_step, int *bexp){ return 0; }
