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
    Biquad Real Block IIR, 32x32-bit, Direct Form I
    C code optimized for HiFi4
    IntegrIT, 2006-2018
*/

/* Portable data types. */
#include "NatureDSP_types.h"
/* Signal Processing Library API. */
#include "NatureDSP_Signal_iir.h"
/* Common utility and macros declarations. */
#include "common.h"
/* Filter instance structure. */
#include "stereo_bqriir32x32_df1_common.h"

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

/* Reserve memory for alignment. */
#define ALIGNED_SIZE( size, align ) ( (size_t)(size) + (align) - 1 )

/* Align address on a specified boundary. */
#define ALIGNED_ADDR( addr, align ) (void*)( ( (uintptr_t)(addr) + ( (align) - 1 ) ) & ~( (align) - 1 ) )
 
static int32_t mpy32x16r( int32_t a, int16_t b )
{
  ae_f32x2 va, vres;
  ae_f16x4 vb;
  int32_t res;
  va = a;
  vb = b;
  vres = AE_MULFP32X16X2RAS_L(va, vb);
  res = AE_MOVAD32_L(vres);
  return res;
}

/* Allocation routine for iir filters. Returns: size of memory in bytes to be allocated */
size_t stereo_bqriir32x32_df1_alloc( int M )
{
  NASSERT( M > 0 );
  return ( ALIGNED_SIZE( sizeof(stereo_bqriir32x32_df1_t), 4 )
           + // 6 state elements for each pair of M DFI sections.
           ALIGNED_SIZE( 2*6*(M+1)/2*sizeof(int32_t), 8 )
           + // 6 SOS coefficients for each of M sections
           ALIGNED_SIZE( 2*6*M*sizeof(int32_t), 8 ));
} /* stereo_bqriir32x32_df1_alloc() */

/* Initialization routine for iir filters. Returns: handle to the object */
stereo_bqriir32x32_df1_handle_t stereo_bqriir32x32_df1_init( void * objmem, int M,
                                                             const int32_t * restrict coef_sosl,
                                                             const int16_t * restrict coef_gl,
                                                             int16_t         gainl,
                                                             const int32_t * restrict coef_sosr,
                                                             const int16_t * restrict coef_gr,
                                                             int16_t         gainr )
{
  stereo_bqriir32x32_df1_ptr_t stereo_bqriir;
  ae_int32x2 * restrict sectStatel;
  ae_int32x2 * restrict sectStater;
  int32_t * restrict sectCoef_gsosl;
  int32_t * restrict sectCoef_gsosr;
  void * ptr;
  int m;
  NASSERT( objmem && coef_sosl && coef_gl && coef_sosr && coef_gr );
  NASSERT( -48 <= gainl && gainl <= 15 && -48 <= gainr && gainr <= 15 );
  NASSERT( M > 0 );

  // Partition the memory block
  ptr = objmem;
  stereo_bqriir  = (stereo_bqriir32x32_df1_ptr_t)ALIGNED_ADDR( ptr, 4 );
  ptr            = stereo_bqriir + 1;
  sectStatel     = (ae_int32x2*)ALIGNED_ADDR( ptr, 8 );
  ptr            = sectStatel + 3*(M+1)/2;
  sectStater     = (ae_int32x2*)ptr;
  ptr            = sectStater + 3*(M+1)/2;
  sectCoef_gsosl = (int32_t*)ALIGNED_ADDR( ptr, 8 );
  ptr            = sectCoef_gsosl + 6*M;
  sectCoef_gsosr = (int32_t*)ptr;
  ptr            = sectCoef_gsosr + 6*M;

  NASSERT( (int8_t*)ptr - (int8_t*)objmem <= (int)stereo_bqriir32x32_df1_alloc( M ) );

  // Initialize the filter instance.
  stereo_bqriir->magic      = STEREO_BQRIIR32X32_DF1_MAGIC;
  stereo_bqriir->M          = M;
  stereo_bqriir->gainl      = gainl;
  stereo_bqriir->gainr      = gainr;
  stereo_bqriir->coef_gsosl = sectCoef_gsosl;
  stereo_bqriir->coef_gsosr = sectCoef_gsosr;
  stereo_bqriir->statel     = (int32_t*)sectStatel;
  stereo_bqriir->stater     = (int32_t*)sectStater;
  // Copy filter coefficients for M sections, zero the state elements.
  __Pragma("loop_count min=1")
  for ( m=0; m<M; m++ )
  {
    int16_t g = coef_gl[m];

    sectCoef_gsosl[6*m+0] = mpy32x16r( coef_sosl[5*m+2], g ); // b2 Q30
    sectCoef_gsosl[6*m+1] = mpy32x16r( coef_sosl[5*m+1], g ); // b1 Q30
    sectCoef_gsosl[6*m+2] =            coef_sosl[5*m+4];      // a2 Q30
    sectCoef_gsosl[6*m+3] =            coef_sosl[5*m+3];      // a1 Q30
    sectCoef_gsosl[6*m+4] = mpy32x16r( coef_sosl[5*m+1], g ); // b1 Q30
    sectCoef_gsosl[6*m+5] = mpy32x16r( coef_sosl[5*m+0], g ); // b0 Q30
  }
  __Pragma("loop_count min=1")
  for ( m=0; m<M; m++ )
  {
    int16_t g = coef_gr[m];

    sectCoef_gsosr[6*m+0] = mpy32x16r( coef_sosr[5*m+2], g ); // b2 Q30
    sectCoef_gsosr[6*m+1] = mpy32x16r( coef_sosr[5*m+1], g ); // b1 Q30
    sectCoef_gsosr[6*m+2] =            coef_sosr[5*m+4];      // a2 Q30
    sectCoef_gsosr[6*m+3] =            coef_sosr[5*m+3];      // a1 Q30
    sectCoef_gsosr[6*m+4] = mpy32x16r( coef_sosr[5*m+1], g ); // b1 Q30
    sectCoef_gsosr[6*m+5] = mpy32x16r( coef_sosr[5*m+0], g ); // b0 Q30
  }

  __Pragma("loop_count min=1")
  for ( m=0; m<(M+1)/2; m++ )
  {
    AE_S32X2_IP(AE_ZERO32(),sectStatel,8);
    AE_S32X2_IP(AE_ZERO32(),sectStatel,8);
    AE_S32X2_IP(AE_ZERO32(),sectStatel,8);
    AE_S32X2_IP(AE_ZERO32(),sectStater,8);
    AE_S32X2_IP(AE_ZERO32(),sectStater,8);
    AE_S32X2_IP(AE_ZERO32(),sectStater,8);
  }

  return (stereo_bqriir); 
} /* stereo_bqriir32x32_df1_init() */
