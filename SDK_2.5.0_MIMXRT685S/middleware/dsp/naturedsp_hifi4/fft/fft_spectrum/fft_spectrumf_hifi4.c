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
 * Power spectrum, floating point data
 * Code optimized for HiFi4 core
 */
/* Cross-platform data type definitions. */
#include "NatureDSP_types.h"
/* Common helper macros. */
#include "common.h"
/* Signal Processing Library API. */
#include "NatureDSP_Signal_fft.h"
#include "common_fpu.h"
/*-------------------------------------------------------------------------
  Power spectrum
  These functions compute a normalized power spectrum from the output signal 
  generated by an FFT function. The N argument specifies the size of the FFT 
  and must be a power of 2. The  mode argument is used to specify the type 
  of FFT function used to generate the x array. If the x array has been 
  generated from a frequency-domain complex input signal (output of complex 
  FFT function), the mode argument must be set to 0. Otherwise the mode 
  argument must be set to 1 to signify that the x array has been generated 
  from a frequency-domain real input signal (output of real FFT function).
  The block_exponent argument is used to control the normalization of the 
  power spectrum. It will usually be set to the block_exponent that is 
  returned by corresponding FFT functions.  If the input array was 
  generated by some other means, then the value specified for the 
  block_exponent argument will depend upon how the FFT was calculated. 
  If the function used to calculate the FFT did not scale the intermediate 
  results at any of the stages of the computation, then set block_exponent 
  to zero; if the FFT function scaled the intermediate results at each 
  stage of the computation, then set block_exponent to -1; otherwise set 
  block_exponent to the sum of negated base-2 logarithm of all scaling 
  factors applied to data at intermediate FFT stages. This value will be 
  in the range 0 to log2(N).
  fft_spectrum functions write the power spectrum to the output array y. 
  If mode is set to 0, then the length of the power spectrum will be N. If 
  mode is set to 1, then the length of the power spectrum will be (N/2+1)

  Precision:
  16x32   16-bit inputs, 32-bit outputs
  32x32   32-bit inputs/outputs
  f       floating point inputs/outputs. Requires VFPU/SFPU core option


  Input:
  for mode==0
  x[N]           input spectrum . Real and imaginary
                 data are interleaved and real data goes first:
  for mode==1
  x[N/2+1]       input spectrum (positive side). Real and imaginary
                 data are interleaved and real data goes first:
  block_exponent power spectrum normalization control
  N              FFT size
  mode           power spectrum mode:
                 0 � complex signal
                 1 � real signal

  twdstep               twiddle step
  scalingOpt            scaling option (see table above), not applicable 
                        to the floating point function
  Output:
  for mode==0
  y[N]           output power spectrum
  for mode==1
  y[N/2+1]       output power spectrum
  Returned value:  none

  Restrictions:
  x,y   should not overlap
  x,y   aligned on 8-bytes boundary
-------------------------------------------------------------------------*/
#if (HAVE_FPU==0 && HAVE_VFPU==0)
DISCARD_FUN(void,fft_spectrumf,(float32_t* y, const complex_float   * x, int N,int mode ))
#elif (HAVE_VFPU)
void fft_spectrumf     ( float32_t* y, const complex_float   * x, int N,                     int mode )
{
#define MAX_SCR_SZ ((MAX_ALLOCA_SZ/sizeof(float32_t))&~1)
    float32_t ALIGN(8) scr[MAX_SCR_SZ];
          xtfloatx2* restrict pScrWr;
    const xtfloatx2* restrict pScrRd;
    const xtfloatx2 *restrict X;
          xtfloatx2 *restrict Z;
    ae_valign X_va,Z_va;
    xtfloatx2 knorm; 
    int n, logN,M;
    NASSERT( x );
    NASSERT( y );

    if ( N<2 || 0 != (N&(N-1)) || ( mode != 0 && mode != 1 ) ) return;

    logN = 30 - NSA( N );
    knorm = XT_AE_MOVXTFLOATX2_FROMINT32X2(AE_MOVDA32((127+mode-logN)<<23));    /* 2^(mode-logN) */
    N=( mode ? N/2+1 : N );

    while(N>0)
    {
        M=XT_MIN(N,MAX_SCR_SZ);
        /* note: if N is odd, we have to make first iteration with 1 element 
           and all next iterations will be done with even number of elements 
           this does not cause reading above the upper bound of input array
           because number of input elements is always not less than 2
        */
        if (N&1) M=1; 
        /* first phase: normalize inputs to avoid under/overflows */
        __Pragma("no_reorder")
        X = (const xtfloatx2 *)x;
        X_va = AE_LA64_PP(X);
        Z = (xtfloatx2 *)y;
        Z_va = AE_ZALIGN64();
        pScrWr=(xtfloatx2*)scr;
        for ( n=0; n<(M); n+=2)
        {
            xtfloatx2 X0,X1,Xre, Xim, temp;
            ae_int32x2 temp0, exp_re, exp_im, exp_abs;
            xtbool2 b_cond;
            XT_LASX2IP(X0, X_va, X);
            XT_LASX2IP(X1, X_va, X);
            Xre=XT_SEL32_HH_SX2 (X0,X1);
            Xim=XT_SEL32_LL_SX2 (X0,X1);
            /* Get the exponent of x.re */
            temp0 = XT_AE_MOVINT32X2_FROMXTFLOATX2(Xre);
            exp_re = AE_SRLI32(temp0, 23);
            exp_re = AE_AND32(exp_re, 0xFF);
            exp_re = AE_SUB32(exp_re, 127);
            /*--------------------------*/
            /* Get the exponent of x.im */
            temp0 = XT_AE_MOVINT32X2_FROMXTFLOATX2(Xim);
            exp_im = AE_SRLI32(temp0, 23);
            exp_im = AE_AND32(exp_im, 0xFF);
            exp_im = AE_SUB32(exp_im, 127);
            /*--------------------------*/
            /* Select maximum exponent */
            exp_abs = AE_MAX32(exp_re, exp_im);
            b_cond = AE_LT32(127, exp_abs);
            AE_MOVT32X2(exp_abs,127,b_cond);
            /* Adjust range of input data using ldexpf */
            /* Xre = ldexpf(Xre, -exp_abs) */
            /* Xim = ldexpf(Xim, -exp_abs) */
            temp0 = AE_SUB32(127, exp_abs);
            b_cond = AE_EQ32(temp0, 0);
            temp0 = AE_SLLI32(temp0, 23);
            AE_MOVT32X2(temp0,0x00400000, b_cond);
            temp = XT_AE_MOVXTFLOATX2_FROMINT32X2(temp0);
            Xre = XT_MUL_SX2(Xre, temp);
            Xim = XT_MUL_SX2(Xim, temp);
            /*-----------------------------*/
            /* Zout = sqrt(Xre*Xre + Xim*Xim) */
            temp = XT_MUL_SX2(Xre, Xre);
            XT_MADD_SX2(temp, Xim, Xim);
            AE_SA32X2_IP(exp_abs, Z_va,castxcc(ae_int32x2, Z));
            XT_SSX2IP(temp,pScrWr,sizeof(xtfloatx2));
        }
        AE_SA64POS_FP(Z_va, Z);
        /* compute square root and renormalize output */
        __Pragma("no_reorder")
        X = (xtfloatx2 *)y;
        X_va = AE_LA64_PP(X);
        Z = (xtfloatx2 *)y;
        Z_va = AE_ZALIGN64();
        pScrRd=(xtfloatx2*)scr;
        for ( n=0; n<(M); n+=2)
        {
            ae_int32x2 exp_abs,temp0;
            xtfloatx2 temp,Zout;
            xtbool2 b_cond;
            AE_LA32X2_IP(exp_abs, X_va,castxcc(ae_int32x2, X));
            XT_LSX2IP(temp,pScrRd,sizeof(xtfloatx2));
            Zout = XT_SQRT_SX2(temp);

            /* Restore range of result      */
            /* Zout = ldexpf(Zout, exp_abs) */
           temp0 = AE_ADD32(127, exp_abs);
           b_cond = AE_EQ32(temp0, 0);
           temp0 = AE_SLLI32(temp0, 23);
           AE_MOVT32X2(temp0,0x00400000, b_cond);
           temp = XT_AE_MOVXTFLOATX2_FROMINT32X2(temp0);
           Zout = XT_MUL_SX2(Zout, temp);
           Zout = XT_MUL_SX2(Zout, knorm);
            /*------------------------------*/
            XT_SASX2IP(Zout, Z_va, Z);
        }
        AE_SA64POS_FP(Z_va, Z);

        N-=M;
        y+=M;
        x+=M;
    }

} /* fft_spectrumf() */
#else
/* version for scalar FPU */
void fft_spectrumf     ( float32_t* y, const complex_float   * x, int N,                     int mode )
{
#define MAX_SCR_SZ ((MAX_ALLOCA_SZ/sizeof(float32_t))&~1)
    float32_t ALIGN(8) scr[MAX_SCR_SZ];
          xtfloat* restrict pScrWr;
    const xtfloat* restrict pScrRd;
    const xtfloat *restrict X;
          xtfloat *restrict Z;
    xtfloat knorm; 
    int n, logN,M;
    NASSERT( x );
    NASSERT( y );

  if ( N<2 || 0 != (N&(N-1)) || ( mode != 0 && mode != 1 ) ) return;

    logN = 30 - NSA( N );
    knorm = XT_WFR((127+mode-logN)<<23);    /* 2^(mode-logN) */
    N=( mode ? N/2+1 : N );

    while(N>0)
    {
        M=XT_MIN(N,MAX_SCR_SZ);
        /* first phase: normalize inputs to avoid under/overflows */
        __Pragma("no_reorder")
        X = (const xtfloat *)x;
        Z = (xtfloat *)y;
        pScrWr=(xtfloat*)scr;
        for ( n=0; n<(M); n++)
        {
            xtfloat Xre, Xim, temp;
            int32_t temp0, exp_re, exp_im, exp_abs;
            int32_t b_cond;
            XT_LSIP(Xre, X, sizeof(float32_t));
            XT_LSIP(Xim, X, sizeof(float32_t));
            /* Get the exponent of x.re */
            temp0 = XT_RFR(Xre);
            exp_re = ((uint32_t)temp0)>>23;
            exp_re = (exp_re & 0xFF);
            exp_re = (exp_re - 127);
            /*--------------------------*/
            /* Get the exponent of x.im */
            temp0 = XT_RFR(Xim);
            exp_im = ((uint32_t)temp0)>>23;
            exp_im = (exp_im & 0xFF);
            exp_im = (exp_im - 127);
            /*--------------------------*/
            /* Select maximum exponent */
            exp_abs = XT_MAX(exp_re, exp_im);
            XT_MOVLTZ(exp_abs,127,127-exp_abs);
            /* Adjust range of input data using ldexpf */
            /* Xre = ldexpf(Xre, -exp_abs) */
            /* Xim = ldexpf(Xim, -exp_abs) */
            temp0 = (127- exp_abs);
            b_cond = temp0;
            temp0 = (temp0<<23);
            XT_MOVEQZ(temp0,0x00400000, b_cond);
            temp = XT_WFR(temp0);
            Xre = XT_MUL_S(Xre, temp);
            Xim = XT_MUL_S(Xim, temp);
            /*-----------------------------*/
            /* Zout = sqrt(Xre*Xre + Xim*Xim) */
            temp = XT_MUL_S(Xre, Xre);
            XT_MADD_S(temp, Xim, Xim);
            ((int32_t*)Z)[0]=exp_abs; Z++;
            XT_SSIP(temp,pScrWr,sizeof(float32_t));
        }
        /* compute square root and renormalize output */
        __Pragma("no_reorder")
        X = (xtfloat *)y;
        Z = (xtfloat *)y;
        pScrRd=(xtfloat*)scr;
        for ( n=0; n<(M); n++)
        {
            int32_t exp_abs,temp0;
            xtfloat temp,Zout;
            int32_t b_cond;
            exp_abs = ((const int32_t*)X)[0];X++;
            XT_LSIP(temp,pScrRd,sizeof(float32_t));
            Zout = XT_SQRT_S(temp);
 
            /* Restore range of result      */
            /* Zout = ldexpf(Zout, exp_abs) */
           temp0 = (127+exp_abs);
           b_cond = temp0;
           temp0 = (temp0<<23);
           XT_MOVEQZ(temp0,0x00400000, b_cond);
           temp = XT_WFR(temp0);
           Zout = XT_MUL_S(Zout, temp);
           Zout = XT_MUL_S(Zout, knorm);
            /*------------------------------*/
            XT_SSIP(Zout, Z, sizeof(float32_t));
        }

        N-=M;
        y+=M;
        x+=M;
    }
}
#endif
