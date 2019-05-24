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
 * Complex Matrix Inversion, 32-bit fixed point API
 * Optimized code for HiFi4
 */

/* Cross-platform data type definitions. */
#include "NatureDSP_types.h"
/* Common helper macros. */
#include "common.h"
/* Matrix functions */
#include "NatureDSP_Signal_matinv.h"

/*-------------------------------------------------------------------------
  These functions implement in-place matrix inversion by Gauss elimination 
  with full pivoting
  NOTE: user may detect "invalid" or "divide-by-zero" exception in the CPU 
  flags which MAY indicate that inversion results are not accurate. Also 
  it's responsibility of the user to provide valid input matrix for 
  inversion.
  Fixed point version takes representation of input matrix and forms 
  representation of output matrix with proper scaling.

  Precision: 
  f     floating point
  32x32 32-bit input, 32-bit output

  Input:
  x[N*N]      input matrix
  qX          input matrix representation (for fixed point API only)
  Output:
  x[N*N]      result
  Temporary:
  pScr        scratch memory. Size in bytes is defined by corresponding 
              scratch allocation function 
  N is 2,3,4,6,8,10

  Returned value: floating functions return none, fixed point functions 
                  return fixed-point representation of inverted matrix
  Restrictions:
  none
-------------------------------------------------------------------------*/
int  cmtx_inv2x2_32x32  (void* pScr, complex_fract32 *x, int qX) 
{
    const int N=2;
    xtbool2 bnegim=AE_LT32(AE_MOVDA32X2(0,-1),AE_ZERO32());
    int k,n;
    ae_int32x2 *B; // [N][N]
    ae_int32x2 *C; // [N][N]
    ae_int32x2 *T; // [N]
    ae_int32x2 * restrict pB; // [N][N]
    ae_int32x2 * restrict pC; // [N][N]
    ae_int32x2 * restrict pT; // [N][N]
    ae_int32x2 * restrict pX;
    int qB,qC; // fixed point representations
    // allocate on scratch
    B=(ae_int32x2 *)pScr;
    C=B+N*N;
    T=C+N*N;
    // setup circular pointers for B and T
    WUR_AE_CBEGIN0((uintptr_t)B);    WUR_AE_CEND0((uintptr_t)(B+N*N));
    WUR_AE_CBEGIN1((uintptr_t)T);    WUR_AE_CEND1((uintptr_t)(T+N));
    // copy input
    pB=B;
    pC=C;
    pX=(ae_int32x2*)x;
    for (k=0; k<N*N; k++) 
    {
        ae_int32x2 b;
        AE_L32X2_IP(b,pX,sizeof(ae_int32x2));
        AE_S32X2_IP(b,pB,sizeof(ae_int32x2));
        AE_S32X2_IP(AE_ZERO32(),pC,sizeof(ae_int32x2));
    }
    pC=C;
    for (k=0; k<N; k++) 
    {
        ae_int32x2 cone=AE_MOVDA32X2(0x7fffffff,0);
        AE_S32X2_XP(cone,pC,sizeof(ae_int32x2)*(N+1));
    }
    qB=31;
    qC=31+(31-qX); // representation of inverted matrix

    for (k=0; k<N; k++)
    {
        int i,imax;
        int e,expB,expC;
        // find matrix normalization scale
        pB=(ae_int32x2 *)B;
        pC=(ae_int32x2 *)C;
        ae_int32x2 bmax2,cmax2;
        bmax2=cmax2=AE_ZERO32();
        for(n=0; n<N*N; n++) 
        {
            ae_int32x2 b,c;
            AE_L32X2_IP(b,pB,sizeof(ae_int32x2));
            AE_L32X2_IP(c,pC,sizeof(ae_int32x2));
            bmax2=AE_MAXABS32S(bmax2,b);
            cmax2=AE_MAXABS32S(cmax2,c);
        }
        bmax2=AE_MAX32(bmax2,AE_SEL32_LH(bmax2,bmax2));
        cmax2=AE_MAX32(cmax2,AE_SEL32_LH(cmax2,cmax2));
        expB=AE_NSAZ32_L(bmax2);
        expC=AE_NSAZ32_L(cmax2);
        // pivoting
        {
            ae_int64 bmax64;
            imax=k; bmax64=AE_ZERO64();
            pB=&B[k*N+k];
            for (n=k; n<N; n++)
            {
                ae_int32x2 bb;
                ae_int64 b;
                xtbool bbig;
                AE_L32X2_XP(bb,pB,sizeof(ae_int32x2)*N);
                b=AE_MULZAAD32_HH_LL(bb,bb);
                bbig=AE_LE64(bmax64,b);
                AE_MOVT64(bmax64,b,bbig);
                XT_MOVT(imax, n, bbig);
            }
        }
        int off=(int)((imax-k)*sizeof(ae_int32x2)*N);
        pB=&B[k*N];
        pC=&C[k*N];        
        for (n=0; n<N; n++) 
        {
            ae_int32x2 bk,bi,ck,ci;
            bk=AE_L32X2_I(pB,0);
            bi=AE_L32X2_X(pB,off);
            ck=AE_L32X2_I(pC,0);
            ci=AE_L32X2_X(pC,off);
            AE_S32X2_X (bk,pB,off);
            AE_S32X2_IP(bi,pB,sizeof(ae_int32x2));
            AE_S32X2_X (ck,pC,off);
            AE_S32X2_IP(ci,pC,sizeof(ae_int32x2));
        }
        // find normalization factor
        {
            ae_int32x2 Tk,Tn;
            int e_den,e_num,e_rden;
            ae_int64 d2,n2;
            ae_int32x2 rden;
            pT=T;
            pB=(B+k);
            for (n=0; n<N; n++)
            {
                ae_int32x2 b;
                AE_L32X2_XP(b,pB,sizeof(ae_int32x2)*N);
                AE_S32X2_IP(b,pT,sizeof(ae_int32x2));
            }
            pT=T;
            Tk=AE_L32X2_X(pT,k*sizeof(ae_int32x2));
            AE_S32X2_X(AE_SLAA32S(AE_MOVDA32X2(1,0),qB),pT,k*sizeof(ae_int32x2));
            d2=AE_MULZAAD32_HH_LL(Tk,Tk);
            n2=AE_ZERO64();
            for (n=0; n<N; n++) 
            {
                ae_int64 t;
                AE_L32X2_IP(Tn,pT,sizeof(ae_int32x2));
                t=AE_MULZAAD32_HH_LL(Tn,Tn);
                n2=AE_MAX64(n2,t);
            }
            n2=AE_ADD64S(AE_SRAI64(n2,1),AE_SRAI64(d2,1));
            e_num=AE_NSA64(n2);
            e_num=(e_num>>1)-1;
            e_den=AE_NSA64(d2);
            e_den=(e_den>>1);
            d2=AE_SLAA64(d2,(e_den<<1));
            rden=AE_TRUNCI32X2F64S(d2,d2,0);
            e_rden=AE_NSAZ32_L(rden);
            rden=AE_SLAA32S(rden,e_rden);
            {   // reciprocal: assume rden is positive!
                ae_int32x2 X,Y,E;
                X=rden;
                Y=AE_SUB32(0xBAEC0000,X);
                E=0x40000000; AE_MULSFP32X2RAS(E,X,Y); AE_MULAFP32X2RAS(Y,Y,AE_SLLI32(E,1));
                E=0x40000000; AE_MULSFP32X2RAS(E,X,Y); AE_MULAFP32X2RAS(Y,Y,AE_SLLI32(E,1));
                E=0x40000000; AE_MULSFP32X2RAS(E,X,Y); AE_MULAFP32X2RAS(Y,Y,AE_SLLI32(E,1));
                E=0x40000000; AE_MULSFP32X2RAS(E,X,Y); AE_MULAFP32X2RAS(Y,Y,AE_SLLI32(E,1));
                rden=Y;
            }
            Tk=AE_MULFP32X2RAS(Tk,rden);
            AE_MOVT32X2(Tk,AE_NEG32S(Tk),bnegim);
            Tk=AE_SLAA32S(Tk,e_den+e_rden-1);
            pT=T;
            for (n=0; n<N; n++)
            {
                Tn=AE_L32X2_I(pT,0);
                Tn=AE_SLAA32S(Tn,e_num);
                Tn=AE_MULFC32RAS(Tn,Tk);
                AE_S32X2_IP(Tn,pT,sizeof(ae_int32x2));
            }
           e=e_den-e_num+1;
        }
        // scale B and C (2-way shifts possible!)
        qB=qB+expB-e;
        qC=qC+expC-e;
        // Gauss-Jordan elimination: might be made using curcular addressing on B/C
        ae_int32x2 Ti;
        pB=(ae_int32x2 *)B;
        pC=(ae_int32x2 *)C;
        for (n=0; n<N*N; n++)
        {
            pB[n]=AE_SLAA32S(pB[n],expB);
            pC[n]=AE_SLAA32S(pC[n],expC);
       }
        pB=(B+k*N);
        pT=(T+k);
        AE_ADDCIRC32X2_XC (pB,sizeof(ae_int32x2)*N);
        AE_ADDCIRC32X2_XC1(pT,sizeof(ae_int32x2));

        for (i=0; i<N-1; i++)
        {
            AE_L32X2_XC1(Ti,pT,sizeof(ae_int32x2));
            Ti=AE_NEG32S(Ti);
            for (n=0; n<N; n++)
            {
                ae_int32x2 Bkn,Ckn,Bin,Cin;
                Bkn=B[k*N+n];
                Ckn=C[k*N+n];
                Bin=AE_L32X2_I(pB,0);
                Cin=AE_L32X2_X(pB,(int)((uintptr_t)C-(uintptr_t)B));
                Bin=AE_SLAA32S(Bin,-e);
                Cin=AE_SLAA32S(Cin,-e);
                AE_MULAFC32RAS(Bin,Bkn,Ti);
                AE_MULAFC32RAS(Cin,Ckn,Ti);
                AE_S32X2_X  (Cin,pB,(int)((uintptr_t)C-(uintptr_t)B));
                AE_S32X2_XC (Bin,pB,sizeof(ae_int32x2));
            }
        }
        AE_L32X2_XC1(Ti,pT,sizeof(ae_int32x2));
        for (n=0; n<N; n++)
        {
            ae_int32x2 Bin,Cin;
            Bin=AE_L32X2_I(pB,0);
            Cin=AE_L32X2_X(pB,(int)((uintptr_t)C-(uintptr_t)B));
            Bin=AE_MULFC32RAS(Bin,Ti);
            Cin=AE_MULFC32RAS(Cin,Ti);
            AE_S32X2_X  (Cin,pB,(int)((uintptr_t)C-(uintptr_t)B));
            AE_S32X2_XC (Bin,pB,sizeof(ae_int32x2));
        }
        pB=(B+k);
        for (i=0; i<N; i++)  AE_S32X2_XP(AE_ZERO32(),pB,N*sizeof(ae_int32x2));
    }
    // copy back to the output
    pC=(ae_int32x2 *)pC;
    pX=(ae_int32x2 *)x;
    for (k=0; k<N*N; k++) 
    {
        ae_int32x2 c;
        AE_L32X2_IP(c,pC,sizeof(ae_int32x2));
        AE_S32X2_IP(c,pX,sizeof(ae_int32x2));
    }
    return qC;
}
// scratch allocation
size_t cmtx_inv2x2_32x32_getScratchSize   () { return (2*2*2+3)*sizeof(complex_fract32);  }
