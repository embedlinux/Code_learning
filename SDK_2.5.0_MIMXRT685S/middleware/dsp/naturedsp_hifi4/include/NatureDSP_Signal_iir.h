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
#ifndef __NATUREDSP_SIGNAL_IIR_H__
#define __NATUREDSP_SIGNAL_IIR_H__

#include "NatureDSP_types.h"

#ifdef __cplusplus
extern "C" {
#endif

/*===========================================================================
  IIR filters:
  bqriir     Biquad real block IIR
  latr       Lattice block Real IIR
===========================================================================*/

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
#define BQRIIR16X16_DF1_SCRATCH_SIZE( N, M )    ( 0 )
#define BQRIIR16X16_DF2_SCRATCH_SIZE( N, M )    ( 0 )
#define BQRIIR32X16_DF1_SCRATCH_SIZE( N, M )    ( 4*(N) )
#define BQRIIR32X16_DF2_SCRATCH_SIZE( N, M )    ( 4*(N) )
#define BQRIIR32X32_DF1_SCRATCH_SIZE( N, M )    ( 0 )
#define BQRIIR32X32_DF2_SCRATCH_SIZE( N, M )    ( 4*(N) )
#define STEREO_BQRIIR16X16_DF1_SCRATCH_SIZE( N, M )    ( 0 )
#define STEREO_BQRIIR32X16_DF1_SCRATCH_SIZE( N, M )    ( 0 )
#define STEREO_BQRIIR32X32_DF1_SCRATCH_SIZE( N, M )    ( 0 )
#define STEREO_BQRIIRF_DF1_SCRATCH_SIZE    ( N, M )    ( 0 )

typedef void* bqriir16x16_df1_handle_t;
typedef void* bqriir16x16_df2_handle_t;
typedef void* bqriir32x16_df1_handle_t;
typedef void* bqriir32x16_df2_handle_t;
typedef void* bqriir32x32_df1_handle_t;
typedef void* bqriir32x32_df2_handle_t;
typedef void* bqriirf_df1_handle_t;
typedef void* bqriirf_df2_handle_t;
typedef void* bqriirf_df2t_handle_t;
typedef void* bqciirf_df1_handle_t;
typedef void* stereo_bqriir16x16_df1_handle_t;
typedef void* stereo_bqriir32x16_df1_handle_t;
typedef void* stereo_bqriir32x32_df1_handle_t;
typedef void* stereo_bqriirf_df1_handle_t;

/* Returns: size of memory in bytes to be allocated */
size_t bqriir16x16_df1_alloc(int M);
size_t bqriir16x16_df2_alloc(int M);
size_t bqriir32x16_df1_alloc(int M);
size_t bqriir32x16_df2_alloc(int M);
size_t bqriir32x32_df1_alloc(int M);
size_t bqriir32x32_df2_alloc(int M);
size_t bqriirf_df1_alloc    (int M);
size_t bqriirf_df2_alloc    (int M);
size_t bqriirf_df2t_alloc   (int M);
size_t bqciirf_df1_alloc    (int M);
size_t stereo_bqriir16x16_df1_alloc(int M);
size_t stereo_bqriir32x16_df1_alloc(int M);
size_t stereo_bqriir32x32_df1_alloc(int M);
size_t stereo_bqriirf_df1_alloc    (int M);

/* Returns: handle to the object */
bqriir16x16_df1_handle_t bqriir16x16_df1_init(void * objmem, int M,
                                              const int16_t * coef_sos,
                                              const int16_t * coef_g, 
                                              int16_t         gain);
bqriir16x16_df2_handle_t bqriir16x16_df2_init(void * objmem, int M,
                                              const int16_t * coef_sos, 
                                              const int16_t * coef_g,  
                                              int16_t         gain);
bqriir32x16_df1_handle_t bqriir32x16_df1_init(void * objmem, int M, 
                                              const int16_t * coef_sos,
                                              const int16_t * coef_g,
                                              int16_t         gain);
bqriir32x16_df2_handle_t bqriir32x16_df2_init(void * objmem,  int M,
                                              const int16_t * coef_sos,
                                              const int16_t * coef_g,
                                              int16_t         gain);
bqriir32x32_df1_handle_t bqriir32x32_df1_init(void * objmem,  int M,
                                              const int32_t * coef_sos,
                                              const int16_t * coef_g,
                                              int16_t         gain);
bqriir32x32_df2_handle_t bqriir32x32_df2_init(void * objmem,  int M, 
                                              const int32_t * coef_sos,
                                              const int16_t * coef_g,
                                              int16_t         gain);
bqriirf_df1_handle_t bqriirf_df1_init        (void * objmem, int M,
                                              const float32_t * coef_sos, int16_t gain);
bqriirf_df2_handle_t bqriirf_df2_init        (void * objmem, int M,
                                              const float32_t * coef_sos, int16_t gain);
bqriirf_df2t_handle_t bqriirf_df2t_init      (void * objmem, int M, 
                                              const float32_t * coef_sos, int16_t gain);
bqciirf_df1_handle_t bqciirf_df1_init        (void * objmem, int M,
                                              const float32_t * coef_sos, int16_t gain);
stereo_bqriir16x16_df1_handle_t stereo_bqriir16x16_df1_init
          (void * objmem, int M,
           const int16_t * coef_sosl, const int16_t * coef_gl, int16_t gainl,
           const int16_t * coef_sosr, const int16_t * coef_gr, int16_t gainr );
stereo_bqriir32x16_df1_handle_t stereo_bqriir32x16_df1_init
          (void * objmem, int M, 
           const int16_t * coef_sosl, const int16_t * coef_gl, int16_t gainl,
           const int16_t * coef_sosr, const int16_t * coef_gr, int16_t gainr);
stereo_bqriir32x32_df1_handle_t stereo_bqriir32x32_df1_init
          (void * objmem, int M, 
           const int32_t * coef_sosl, const int16_t * coef_gl, int16_t gainl,
           const int32_t * coef_sosr, const int16_t * coef_gr, int16_t gainr);
stereo_bqriirf_df1_handle_t stereo_bqriirf_df1_init
          (void * objmem, int M,
           const float32_t* coef_sosl, int16_t gainl,
           const float32_t* coef_sosr, int16_t gainr );


/* Update the delay line and compute filter output */
void bqriir16x16_df1(bqriir16x16_df1_handle_t _bqriir, void * s, int16_t * r, const int16_t *x, int N);
void bqriir16x16_df2(bqriir16x16_df2_handle_t _bqriir, void * s, int16_t * r, const int16_t *x, int N);
void bqriir32x16_df1(bqriir32x16_df1_handle_t _bqriir, void * s, int32_t * r, const int32_t *x, int N);
void bqriir32x16_df2(bqriir32x16_df2_handle_t _bqriir, void * s, int32_t * r, const int32_t *x, int N);
void bqriir32x32_df1(bqriir32x32_df1_handle_t _bqriir, void * s, int32_t * r, const int32_t *x, int N);
void bqriir32x32_df2(bqriir32x32_df2_handle_t _bqriir, void * s, int32_t * r, const int32_t *x, int N);
void bqriirf_df1    (bqriirf_df1_handle_t  _bqriir, float32_t     * r, const float32_t     * x, int N);
void bqriirf_df2    (bqriirf_df2_handle_t  _bqriir, float32_t     * r, const float32_t     * x, int N);
void bqriirf_df2t   (bqriirf_df2t_handle_t _bqriir, float32_t     * r, const float32_t     * x, int N);
void bqciirf_df1    (bqciirf_df1_handle_t  _bqriir, complex_float * r, const complex_float * x, int N);
void stereo_bqriir16x16_df1(stereo_bqriir16x16_df1_handle_t _bqriir, void * s, int16_t * r, const int16_t *x, int N);
void stereo_bqriir32x16_df1(stereo_bqriir32x16_df1_handle_t _bqriir, void * s, int32_t * r, const int32_t *x, int N);
void stereo_bqriir32x32_df1(stereo_bqriir32x32_df1_handle_t _bqriir, void * s, int32_t * r, const int32_t *x, int N);
void stereo_bqriirf_df1    (stereo_bqriirf_df1_handle_t  _bqriir, float32_t     * r, const float32_t     * x, int N);

/*-------------------------------------------------------------------------
  Lattice Block Real IIR
  Computes a real cascaded lattice autoregressive IIR filter using reflection 
  coefficients stored in vector k. The real data input are stored in vector x.
  The filter output result is stored in vector r. Input scaling is done before 
  the first cascade for normalization and overflow protection.

  Precision: 
  16x16   16-bit data, 16-bit coefficients
  32x16   32-bit data, 16-bit coefficients
  32x32   32-bit data, 32-bit coefficients
  f       single precision floating point

  Input:
  N       length of input sample block
  M       number of reflection coefficients
  scale   input scale factor g, Q15, Q31 or floating point
  k[M]    reflection coefficients, Q15, Q31 or floating point
  x[N]    input samples, Q15, Q31 or floating point
  Output:
  r[N]    output data, Q15, Q31 or floating point

  Restriction:
  x,r,k   should not overlap

  PERFORMANCE NOTE:
  for optimum performance follow rules:
  M - from the range 1...8
-------------------------------------------------------------------------*/
typedef void* latr16x16_handle_t;
typedef void* latr32x16_handle_t;
typedef void* latr32x32_handle_t;
typedef void* latrf_handle_t;

/* Returns: size of memory in bytes to be allocated */
size_t latr16x16_alloc(int M);
size_t latr32x16_alloc(int M);
size_t latr32x32_alloc(int M);
size_t latrf_alloc    (int M);

/* Returns: handle to the object */
latr16x16_handle_t latr16x16_init(void * objmem, int M, const int16_t   * k, int16_t   scale);
latr32x16_handle_t latr32x16_init(void * objmem, int M, const int16_t   * k, int16_t   scale);
latr32x32_handle_t latr32x32_init(void * objmem, int M, const int32_t   * k, int32_t   scale);
latrf_handle_t     latrf_init    (void * objmem, int M, const float32_t * k, float32_t scale);

/* Update the delay line and compute filter output */
void latr16x16_process (latr16x16_handle_t handle, int16_t   * r, const int16_t   * x, int N);
void latr32x16_process (latr32x16_handle_t handle, int32_t   * r, const int32_t   * x, int N);
void latr32x32_process (latr32x32_handle_t handle, int32_t   * r, const int32_t   * x, int N);
void latrf_process     (latrf_handle_t     handle, float32_t * r, const float32_t * x, int N);

#ifdef __cplusplus
}
#endif

#endif/* __NATUREDSP_SIGNAL_IIR_H__ */
