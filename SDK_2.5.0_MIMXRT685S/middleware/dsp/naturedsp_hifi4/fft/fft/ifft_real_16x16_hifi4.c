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
    Real-valued inverse FFT: 16-bit data, 16-bit twiddle factors
    C code optimized for HiFi4
  IntegrIT, 2006-2018
*/

/* Signal Processing Library API. */
#include "NatureDSP_Signal_fft.h"
/* Common utility macros. */
#include "common.h"
/* FFT descriptor structure and twiddle factor tables. */
#include "fft_x16_common.h"

/*
in-place inverse split part of FFT:
x[N+2]  input (N+2 samples)/output(N samples)
N       size of FFT
*/
static void isplitPart_x2(int16_t *x, const int16_t *twdSplit, int N)
{
  const ae_int16x4 *          X0;
  const ae_int16x4 *          X1;
        ae_int16x4 * restrict Y0;
        ae_int16x4 * restrict Y1;
  const ae_int16x4 *          SPC;

  ae_valign X1_va, Y1_va;
  int n, step;

  NASSERT_ALIGN8( x );
  NASSERT( (N&7)==0 );

  {
      step = 2*(int)sizeof(int16_t);
  }
  //----------------------------------------------------------------------------
  // Apply the in-place real-to-complex spectrum conversion
  //
  // MATLAB code:
  //  spc = -1j*exp(-2*pi*1j*(0:N/4-1)/N);
  //  a0 = y(1:N/4);
  //  a1 = [y(1),wrev(y(N/4+2:N/2))];
  //  b0 = 1/2*(a0+conj(a1));
  //  b1 = 1/2*(a0-conj(a1)).*spc;
  //  a0 = b0+b1;
  //  a1 = conj(b0-b1);
  //  y(1:N/2+1) = [a0,conj(y(N/4+1)),wrev(a1)];
  //
  {
    ae_f32x2   a00, a01, a10, a11;
    ae_f32x2   b00, b01, b10, b11;
    ae_int16x4 t0, t1;

    ae_int16x4 tw;
    ae_int16x4 scl;
    xtbool4 b4;

    const int shift = 2;
    scl = AE_MOVDA16( 1 << ( 15 - shift) );

    X0 = (const ae_int16x4*)( (uintptr_t)x +         0*2 );
    X1 = (const ae_int16x4*)( (uintptr_t)x + (2*N/2+1)*2 );
    Y0 = (      ae_int16x4*)( (uintptr_t)x +         0*2 );
    Y1 = (      ae_int16x4*)( (uintptr_t)x + (2*N/2+1)*2 );
    SPC = (const ae_int16x4*)twdSplit;

    b4 = AE_MOVBA4( 10 );

    X1_va = AE_LA64_PP( X1 );
    Y1_va = AE_ZALIGN64();

    __Pragma( "loop_count min=4, factor=4" );
    for ( n=0; n<N/(4*2); n++ )
    {
      ae_int32x2 vT32_0, vT32_1;
      // tw0, tw1
      AE_L32_XP( vT32_0, castxcc(ae_int32,SPC), step );
      AE_L32_XP( vT32_1, castxcc(ae_int32,SPC), step );
      vT32_0 = AE_SEL32_LL(vT32_1, vT32_0);
      tw = AE_MOVINT16X4_FROMINT32X2(vT32_0);
      tw = AE_SHORTSWAP(tw);

      t0 = AE_NEG16S( tw );
      // conj(tw0), conj(tw1)
      AE_MOVT16X4( tw, t0, b4 );

      // a00, a01
      AE_L16X4_IP( t0, X0, +2*4 );
      // 1j*conj(a10), 1j*conj(a11)
      AE_LA16X4_RIP( t1, X1_va, X1 );

      // Real and imaginary components are swapped, that is equivalent to
      // conjugation followed by multiplication by 1j:
      // a11, a10
      t1 = AE_SHORTSWAP( t1 );

      AE_MULF16X4SS( a00, a01, t0, scl );
      AE_MULF16X4SS( a11, a10, t1, scl );

      // b0x <- a0x + conj(a1x)
      b00 = AE_ADDSUB32S( a00, a10 );
      b01 = AE_ADDSUB32S( a01, a11 );
      // b1x <- a0x - conj(a1x)
      b10 = AE_SUBADD32S( a00, a10 );
      b11 = AE_SUBADD32S( a01, a11 );

      // b1x*conj(twx)
      b10 = AE_MULFC32X16RAS_H( b10, tw );
      b11 = AE_MULFC32X16RAS_L( b11, tw );

      // a0x <- b0x + b1x
      // a1x <- b0x - b1x
      AE_ADDANDSUB32S( a00, a10, b00, b10 );
      AE_ADDANDSUB32S( a01, a11, b01, b11 );

      // 1j*(b0x-b1x)
      a10 = AE_MUL32JS( a10 );
      a11 = AE_MUL32JS( a11 );

      // b00 + b10, b01 + b11
      t0 = AE_TRUNC16X4F32( a00, a01 );
      // conj(b00 - b10), conj(b01 - b11)
      t1 = AE_TRUNC16X4F32( a10, a11 );

      AE_S16X4_IP( t0, Y0, +2*4 );
      // conj(b01 - b11), conj(b00 - b10)
      AE_SA16X4_RIP( t1, Y1_va, Y1 );
    }

    AE_SA64NEG_FP( Y1_va, Y1 );

    __Pragma( "no_reorder" );

    //
    // x(N/4+1) = 2*conj(x(N/4+1));
    //

    t0 = AE_L16X4_I( X0, 0 );

    t0 = AE_SRAI16( t0, 1 );
    t1 = AE_SEL16_6543(t0, t0);
    t0 = AE_NEG16S(t0);
    t0 = AE_SEL16_5432(t0, t0);
    AE_S16_0_I( t1, (ae_int16*)Y0, 0 );
    AE_S16_0_I( t0, (ae_int16*)Y0, 2 );
  }
}

/*
    In-place inverse split part of FFT, with
    additional left shift:
    x[N+2]  input (N+2 samples)/output(N samples)
    N       size of FFT
*/
static void isplitPart_x2_lshift(int16_t *x, const int16_t *twdSplit, int N, int lshift)
{
  const ae_int16x4 *          X0;
  const ae_int16x4 *          X1;
        ae_int16x4 * restrict Y0;
        ae_int16x4 * restrict Y1;
  const ae_int16x4 *          SPC;

  ae_valign X1_va, Y1_va;
  int n, step;

  NASSERT_ALIGN8( x );
  NASSERT( (N&7)==0 );

  {
      step = 2*(int)sizeof(int16_t);
  }
  //----------------------------------------------------------------------------
  // Apply the in-place real-to-complex spectrum conversion
  //
  // MATLAB code:
  //  spc = -1j*exp(-2*pi*1j*(0:N/4-1)/N);
  //  a0 = y(1:N/4);
  //  a1 = [y(1),wrev(y(N/4+2:N/2))];
  //  b0 = 1/2*(a0+conj(a1));
  //  b1 = 1/2*(a0-conj(a1)).*spc;
  //  a0 = b0+b1;
  //  a1 = conj(b0-b1);
  //  y(1:N/2+1) = [a0,conj(y(N/4+1)),wrev(a1)];
  //
  {
    ae_f32x2   a00, a01, a10, a11;
    ae_f32x2   b00, b01, b10, b11;
    ae_int16x4 t0, t1;

    ae_int16x4 tw;
    ae_int16x4 scl;
    xtbool4 b4;

    const int shift = 2;
    scl = AE_MOVDA16( 1<<lshift );
    WUR_AE_SAR( shift );

    X0 = (const ae_int16x4*)( (uintptr_t)x +         0*2 );
    X1 = (const ae_int16x4*)( (uintptr_t)x + (2*N/2+1)*2 );
    Y0 = (      ae_int16x4*)( (uintptr_t)x +         0*2 );
    Y1 = (      ae_int16x4*)( (uintptr_t)x + (2*N/2+1)*2 );
    SPC = (const ae_int16x4*)twdSplit;

    b4 = AE_MOVBA4( 10 );

    X1_va = AE_LA64_PP( X1 );
    Y1_va = AE_ZALIGN64();

    __Pragma( "loop_count min=4, factor=4" );
    for ( n=0; n<N/(4*2); n++ )
    {
      ae_int32x2 vT32_0, vT32_1;
      // tw0, tw1
      AE_L32_XP( vT32_0, castxcc(ae_int32,SPC), step );
      AE_L32_XP( vT32_1, castxcc(ae_int32,SPC), step );
      vT32_0 = AE_SEL32_LL(vT32_1, vT32_0);
      tw = AE_MOVINT16X4_FROMINT32X2(vT32_0);
      tw = AE_SHORTSWAP(tw);

      t0 = AE_NEG16S( tw );
      // conj(tw0), conj(tw1)
      AE_MOVT16X4( tw, t0, b4 );

      // a00, a01
      AE_L16X4_IP( t0, X0, +2*4 );
      // 1j*conj(a10), 1j*conj(a11)
      AE_LA16X4_RIP( t1, X1_va, X1 );

      AE_MUL16X4( a00, a01, t0, scl );
      AE_MUL16X4( a10, a11, t1, scl );
      a10 = AE_MUL32JS(a10);
      a11 = AE_MUL32JS(a11);

      // b0x <- a0x + conj(a1x)
      // b1x <- a0x - conj(a1x)
      AE_ADDANDSUBRNG32( b10, b00, a00, a10 );
      AE_ADDANDSUBRNG32( b11, b01, a01, a11 );

      // b1x*conj(twx)
      b10 = AE_MULFC32X16RAS_H( b10, tw );
      b11 = AE_MULFC32X16RAS_L( b11, tw );

      // a0x <- b0x + b1x
      // a1x <- b0x - b1x
      AE_ADDANDSUB32S( a00, a10, b00, b10 );
      AE_ADDANDSUB32S( a01, a11, b01, b11 );

      // 1j*(b0x-b1x)
      a10 = AE_MUL32JS( a10 );
      a11 = AE_MUL32JS( a11 );

      // b00 + b10, b01 + b11
      t0 = AE_SAT16X4( a00, a01 );
      // conj(b00 - b10), conj(b01 - b11)
      t1 = AE_SAT16X4( a10, a11 );

      AE_S16X4_IP( t0, Y0, +2*4 );
      // conj(b01 - b11), conj(b00 - b10)
      AE_SA16X4_RIP( t1, Y1_va, Y1 );
    }

    AE_SA64NEG_FP( Y1_va, Y1 );

    __Pragma( "no_reorder" );

    //
    // x(N/4+1) = 2*conj(x(N/4+1));
    //

    t0 = AE_L16X4_I( X0, 0 );

    t0 = AE_SRAA16S( t0, 1-lshift );
    t1 = AE_SEL16_6543(t0, t0);
    t0 = AE_NEG16S(t0);
    t0 = AE_SEL16_5432(t0, t0);
    AE_S16_0_I( t1, (ae_int16*)Y0, 0 );
    AE_S16_0_I( t0, (ae_int16*)Y0, 2 );
  }
}

/*-------------------------------------------------------------------------
  Inverse FFT on Real Data
  These functions make inverse FFT on half spectral data forming real
  data samples.
      Scaling: 
      +-------------------+----------------------------------------+
      |      Function     |           Scaling options              |
      +-------------------+----------------------------------------+
      |  ifft_real16x16   |  2 - 16-bit dynamic scaling            | 
      |                   |  3 - fixed scaling before each stage   | 
      |  ifft_real32x32   |  2 - 32-bit dynamic scaling            | 
      |                   |  3 - fixed scaling before each stage   | 
      |  ifft_real32x16   |  2 - 32-bit dynamic scaling            | 
      |                   |  3 - fixed scaling before each stage   | 
      +-------------------+----------------------------------------+

  NOTES:
  1. Bit-reversing reordering is done here. 
  2. IFFT runs in-place algorithm so INPUT DATA WILL APPEAR DAMAGED after
     the call.
  3. Inverse FFT function for real signal transforms the input spectrum  
     and then calls ifft_cplx() with FFT size set to N/2.
  4. 32x32,32x16,16x16  FFTs support mixed radix transforms
  5. N - FFT size

  Precision:
  32x32  32-bit input/outputs, 32-bit twiddles
  32x16  32-bit input/outputs, 16-bit twiddles
  16x16  16-bit input/outputs, 16-bit twiddles

  Input:
  x[(N/2+1)*2]	input spectrum. Real and imaginary data are interleaved  
                and real data goes first
  scalingOpt	scaling option (see table above)

  Output:			
  y[N]	        real output signal

  Returned value: total number of right shifts occurred during scaling 
                  procedure

  Restrictions:
  x,y           should not overlap
  x,y           aligned on a 8-bytes boundary
-------------------------------------------------------------------------*/
int ifft_real16x16( int16_t* y, int16_t* x, fft_handle_t h, int scalingOpt )
{
  const int16_t * twdSplit;
  const fft_real_x16_descr_t * h_real;
  const fft_cplx_x16_descr_t * h_cplx;
  int scale = 2; /* Scaling inside isplitPart */
  int N;

  NASSERT_ALIGN8(x);
  NASSERT_ALIGN8(y);
  NASSERT(x != y);
  NASSERT(scalingOpt == 3 || scalingOpt == 2);

  h_real = (const fft_real_x16_descr_t*)h;
  h_cplx = h_real->cfft_hdl;
  twdSplit = h_real->twd;
  N=(h_cplx->N) << 1;

  if (scalingOpt == 3)
  {
    isplitPart_x2(x, twdSplit, N);
  }
  else
  {
    int bexp;
    {
      int i;
      ae_int16x4 * px;
      ae_int16x4 acc, tmp;
      px = (ae_int16x4*)x;
      acc = AE_ZERO16();
      /* 1 cycles per pipeline stage in steady state with unroll=1*/
      __Pragma("loop_count min=4 factor=4");
      for (i = 0; i < (N >> 2); i++)   
      {
        AE_L16X4_IP(tmp, px, sizeof(*px));
        tmp = AE_ABS16S(tmp); 
        acc = AE_OR16(acc, tmp);
      }
      /* last 2 samples */
      {
        ae_int32x2 tmp32;
        tmp32 = AE_L32_I((const ae_int32 *)px, 0);
        tmp = AE_MOVINT16X4_FROMINT32X2(tmp32);
        tmp = AE_ABS16S(tmp); 
        acc = AE_OR16(acc, tmp);
      }
      acc = AE_OR16(acc, AE_SEL16_5432(acc, acc));
      acc = AE_OR16(acc, AE_SHORTSWAP(acc));

      i = AE_MOVAD16_0(acc);
      bexp = NSA(i) - 16;
      XT_MOVEQZ(bexp, 0, i);
    }
    scale -= bexp;  
    isplitPart_x2_lshift(x, twdSplit, N, bexp);
  }
  
  scale += ifft_cplx16x16(y, x, (fft_handle_t)h_cplx, scalingOpt);

  return scale;
} // ifft_real16x16()
