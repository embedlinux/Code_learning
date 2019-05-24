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
#include "sine_table32.h"
#include "common.h"
#include "NatureDSP_Signal_math.h"

/*===========================================================================
  Vector matematics:
  vec_cosine            Cosine    
===========================================================================*/

/*-------------------------------------------------------------------------
  Sine/Cosine 
  Fixed-point functions calculate sin(pi*x) or cos(pi*x) for numbers written 
  in Q31 or Q15 format. Return results in the same format. 
  Floating point functions compute sin(x) or cos(x)
  Two versions of functions available: regular version (vec_sine32x32, 
  vec_cosine32x32, , vec_sinef, vec_cosinef) 
  with arbitrary arguments and faster version (vec_sine32x32_fast, 
  vec_cosine32x32_fast) that apply some restrictions.
  NOTE:
  1.  Scalar floating point functions are compatible with standard ANSI C
      routines and set errno and exception flags accordingly
  2.  Floating point functions limit the range of allowable input values:
      [-102940.0, 102940.0] Whenever the input value does not belong to this
      range, the result is set to NaN.

  Precision: 
  32x32  32-bit inputs, 32-bit output. Accuracy: 1700 (7.9e-7)
  f      floating point. Accuracy 2 ULP

  Input:
  x[N]  input data,Q31 or floating point
  N     length of vectors
  Output:
  y[N]  output data,Q31 or floating point

  Restriction:
  Regular versions (vec_sine32x32, vec_cosine32x32, vec_sinef, 
  vec_cosinef):
  x,y - should not overlap

  Faster versions (vec_sine32x32_fast, vec_cosine32x32_fast):
  x,y - should not overlap
  x,y - aligned on 8-byte boundary
  N   - multiple of 2

  Scalar versions:
  ----------------
  return result in Q31 or floating point
-------------------------------------------------------------------------*/
void vec_cosine32x32_fast (  int32_t * restrict y, const int32_t * restrict x, int N)
{
  int n;
        ae_int32x2 * restrict py = (      ae_int32x2 *)y;
  const ae_int32x2 * restrict px = (const ae_int32x2 *)x;
  
  uint32_t off,offb;
  ae_int32x2 vsw,vaw,vxw,vnw,vlw,vkw,vxa,vxb,vxc,vxd, vdel,vcos,vsin,vww;
  ae_int32x2 vdw;
  ae_f32x2 vsf,vdf,vxf,vdelf;
  if(N<=0) return;
  vsw = AE_MOVDA32X2(0xc91000, 0xc91000); //pi,Q22
  vww = AE_MOVDA32X2(0xFFFFFFFC, 0xFFFFFFFC);
  vnw = AE_MOVDA32X2(0x400000, 0x400000); //1<<(22)
  vlw = AE_MOVDA32X2(0x200, 0x200); //1<<(9)/4
  vkw = AE_MOVDA32X2(0x7fc, 0x7fc); //1<<(9)-1
  NASSERT_ALIGN8(x);
  NASSERT_ALIGN8(y);
  NASSERT((N&1)==0);
  __Pragma("loop_count min=1")
  for (n=0; n<N; n+=2)
  {
    AE_L32X2_IP(vxw, px, +8); 
    vaw = AE_ADD32S(vxw,vnw);
    
    vaw = AE_SRLI32(vaw,21);
    vaw = AE_AND32(vaw, vww);

    off = AE_MOVAD32_H(vaw);
    offb = AE_MOVAD32_L(vaw);
    /*Load sine for next numbers*/
    vxa = AE_L32_X((const ae_int32 *)sine_table32, off); //sin
    vxb = AE_L32_X((const ae_int32 *)sine_table32, offb); //sin b
    vsin = AE_SEL32_HH(vxa, vxb); //sin

    vdw = AE_SLAI32(vaw,21);
    vdw = AE_SUB32(vxw, vdw);

    vdelf = AE_MULFP32X2RAS(vdw, vsw);//

    vaw = AE_ADD32S(vaw,vlw);
    vaw = AE_AND32(vaw, vkw);
    off = AE_MOVAD32_H(vaw);
    offb = AE_MOVAD32_L(vaw);
    /*Load cosine*/
    vxc = AE_L32_X((const ae_int32 *)sine_table32, off); //cos vxa
    vxd = AE_L32_X((const ae_int32 *)sine_table32, offb); //cos b
    vcos = AE_SEL32_HH(vxc, vxd); //cos

    vsf = (vsin);//sin
    vdel = AE_SLAI32(vdelf, 8); //
    vdf = (vdel);//delta
    vdel = AE_SLAI32(vdel, 1); //Q31

    vxf = (vcos);
    AE_MULAFP32X2RAS(vsf, vcos, vdf);

    AE_MULSFP32X2RAS(vxf, vsf, vdel); //y = cos(x0)-sin(x0)dx-1/2*cos(x0)*dx^2,Q31
    AE_S32X2_IP(vxf, py, +8);//put answer
  }
}
