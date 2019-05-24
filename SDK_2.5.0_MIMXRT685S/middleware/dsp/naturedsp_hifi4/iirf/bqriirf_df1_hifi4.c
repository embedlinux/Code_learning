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
  NatureDSP Signal Processing Library. IIR part
    Bi-quad Real Block IIR, floating point, Direct Form I
    Reference C code
  IntegrIT, 2006-2018
*/

/*-------------------------------------------------------------------------
  Bi-quad Real Block IIR
  Computes a real IIR filter (cascaded IIR direct form I or II using 5 
  coefficients per bi-quad + gain term). Real input data are stored
  in vector x. The filter output result is stored in vector r. The filter 
  calculates N output samples using SOS and G matrices.
  NOTE:
  1. Bi-quad coefficients may be derived from standard SOS and G matrices 
  generated by MATLAB. However, typically biquad stages have big peaks 
  in their step response which may cause undesirable overflows at the 
  intermediate outputs. To avoid that the additional scale factors 
  coef_g[M] may be applied. These per-section scale factors may require 
  some tuning to find a compromise between quantization noise and possible 
  overflows. Output of the last section is directed to an additional 
  multiplier, with the gain factor being a power of two, either negative 
  or non-negative. It is specified through the total gain shift amount 
  parameter gain of each filter initialization function.
  2. 16x16 filters may suffer more from accumulation of the roundoff errors,
  so filters should be properly designed to match noise requirements

  Precision: 
  16x16         16-bit data, 16-bit coefficients, 16-bit intermediate 
                stage outputs (DF1, DF1 stereo, DF II form)
  32x16         32-bit data, 16-bit coefficients, 32-bit intermediate 
                (DF1, DF1 stereo, DF II form) stage outputs
  32x32         32-bit data, 32-bit coefficients, 32-bit intermediate 
                (DF I, DF1 stereo,  DF II form) stage outputs 
  f             floating point (DF I, DF1 stereo, DF II and DF IIt)

  Input:
  N             length of input sample block
  M             number of bi-quad sections
  S             1 for mono, 2 for stereo API
  s[]           scratch memory area (for fixed-point functions only). 
                Minimum number of bytes depends on selected filter structure 
                and precision:
                  BQRIIR16X16_DF1_SCRATCH_SIZE( N,  M ), or
                  BQRIIR16X16_DF2_SCRATCH_SIZE( N,  M ), or
                  BQRIIR32X16_DF1_SCRATCH_SIZE( N,  M ), or
                  BQRIIR32X16_DF2_SCRATCH_SIZE( N,  M ), or
                  BQRIIR32X32_DF1_SCRATCH_SIZE( N,  M ), or
                  BQRIIR32X32_DF2_SCRATCH_SIZE( N,  M ),
                  STEREO_BQRIIR16X16_DF1_SCRATCH_SIZE( N, M ) , or
                  STEREO_BQRIIR32X32_DF1_SCRATCH_SIZE( N, M ) , or
                  STEREO_BQRIIRF_DF1_SCRATCH_SIZE    ( N, M )
                 If a particular macro returns zero, then the corresponding
                 IIR doesn't require a scratch area and parameter s may 
                 hold zero.
  coef_sos[M*5]  filter coefficients stored in blocks of 5 numbers: 
                 b0 b1 b2 a1 a2. 
                 For fixed-point funcions, fixed point format of filter 
                 coefficients is Q1.14 for 16x16 and 32x16, or Q1.30 for 32x32 
  coef_sosl[M*5] filter coefficients for the left channel (stereo filters only)
  coef_sosr[M*5] filter coefficients for the left channel (stereo filters only)
  coef_g[M]      scale factor for each section, Q15 (for fixed-point 
                 functions only)
  coef_gl[M]     scale factor for the left channel (stereo filters only)
  coef_gr[M]     scale factor for the right channel (stereo filters only)
  gain           total gain shift amount applied to output signal of the
                 last section, -48..15
  gainl          total gain shift amount  for the left channel (stereo filters 
                 only)
  gainr          total gain shift amount for the right channel (stereo filters 
                 only)

  x[N*S]         input samples, Q15, Q31 or floating point. Stereo samples 
                 go in interleaved order (left, right)
  Output:
  r[N*S]         output data, Q15, Q31 or floating point. Stereo samples go 
                 in interleaved order (left, right) 

  Restriction:
  x,r,s,coef_g,coef_sos should not overlap
  N   - must be a multiple of 2
  s[] - whenever supplied must be aligned on an 8-bytes boundary
-------------------------------------------------------------------------*/

/* Portable data types. */
#include "NatureDSP_types.h"
/* Signal Processing Library API. */
#include "NatureDSP_Signal_iir.h"
/* Common utility and macros declarations. */
#include "common.h"
#include "bqriirf_df1.h"
#include "common_fpu.h"

#if (HAVE_VFPU==0 && HAVE_FPU==0)
DISCARD_FUN(size_t,bqriirf_df1_alloc,( int M ))
DISCARD_FUN(bqriirf_df1_handle_t,bqriirf_df1_init,( void * objmem, int M,
                                               const float32_t     * coef_sos,
                                               int16_t         gain ))
#elif (HAVE_VFPU)
// Determine the memory area size for a filter instance.
size_t bqriirf_df1_alloc( int M )
{
  NASSERT( M >= 0 );
  return sizeof(bqriirf_df1_t)+9*M*sizeof(float32_t)+7;
} // bqriirf_df1_alloc()

// Given a memory area of sufficient size, initialize a filter instance and 
// return a handle to it.
bqriirf_df1_handle_t bqriirf_df1_init( void * objmem, int M,
                                               const float32_t     * coef_sos,
                                               int16_t         gain )
{
#define VLEN 4  /* vector length */
    bqriirf_df1_t* iir;
    float32_t      * cf; /* 5*M filter coefficients   */
    float32_t      * st; /* 4*M   delay elements      */
    int m;
    st = (float32_t*)((((uintptr_t)objmem)+7)&~7);
    cf = st+4*M;
    iir = (bqriirf_df1_t*)(cf+5*M);
    iir->M=M;
    iir->st=st;
    iir->cf=cf;
    iir->gain=gain;
    /* clean up and copy coefficients */
    for(m=0; m<4*M; m++) st[m]=0.f;
    for(m=0; m<M; m+=VLEN) 
    {
        int p,P = XT_MIN(VLEN,M-m);
        for(p=0;p<P;p++)
        {
            cf[0*P+p+m*5]=coef_sos[0+(p+m)*5]; //b0
            cf[1*P+p+m*5]=coef_sos[1+(p+m)*5]; //b1
            cf[2*P+p+m*5]=coef_sos[2+(p+m)*5]; //b2
            cf[3*P+p+m*5]=coef_sos[3+(p+m)*5]; //a1
            cf[4*P+p+m*5]=coef_sos[4+(p+m)*5]; //a2
        }
    }
    return iir;
#undef VLEN
} // bqriirf_df1_init()
#else
// for scalar FPU: use simpler layout for coefficients
size_t bqriirf_df1_alloc( int M )
{
  NASSERT( M >= 0 );
  return sizeof(bqriirf_df1_t)+9*M*sizeof(float32_t)+7;
} // bqriirf_df1_alloc()
bqriirf_df1_handle_t bqriirf_df1_init( void * objmem, int M,
                                               const float32_t     * coef_sos,
                                               int16_t         gain )
{
    bqriirf_df1_t* iir;
    float32_t      * cf; /* 5*M filter coefficients   */
    float32_t      * st; /* 4*M   delay elements      */
    int m;
    st = (float32_t*)((((uintptr_t)objmem)+7)&~7);
    cf = st+4*M;
    iir = (bqriirf_df1_t*)(cf+5*M);
    iir->M=M;
    iir->st=st;
    iir->cf=cf;
    iir->gain=gain;
    /* clean up and copy coefficients */
    for(m=0; m<4*M; m++) st[m]=0.f;
    for(m=0; m<5*M; m++) cf[m]=coef_sos[m]; //b0,b1,b2,a1,a2
    return iir;
#undef VLEN
}
#endif
