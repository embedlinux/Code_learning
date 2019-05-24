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
#include "NatureDSP_Signal_fft.h"
#include "common.h"
#include "fft_x16_common.h"

/* Twiddles tables for fft_real32x16, ifft_real32x16, fft_real16x16, ifft_real16x16, N=256 */
ALIGN(8) static const int16_t __fft_real16_tw[] =
{
    (int16_t)0x0000,(int16_t)0x7fff,
    (int16_t)0x0324,(int16_t)0x7ff6,
    (int16_t)0x0648,(int16_t)0x7fd9,
    (int16_t)0x096b,(int16_t)0x7fa7,
    (int16_t)0x0c8c,(int16_t)0x7f62,
    (int16_t)0x0fab,(int16_t)0x7f0a,
    (int16_t)0x12c8,(int16_t)0x7e9d,
    (int16_t)0x15e2,(int16_t)0x7e1e,
    (int16_t)0x18f9,(int16_t)0x7d8a,
    (int16_t)0x1c0c,(int16_t)0x7ce4,
    (int16_t)0x1f1a,(int16_t)0x7c2a,
    (int16_t)0x2224,(int16_t)0x7b5d,
    (int16_t)0x2528,(int16_t)0x7a7d,
    (int16_t)0x2827,(int16_t)0x798a,
    (int16_t)0x2b1f,(int16_t)0x7885,
    (int16_t)0x2e11,(int16_t)0x776c,
    (int16_t)0x30fc,(int16_t)0x7642,
    (int16_t)0x33df,(int16_t)0x7505,
    (int16_t)0x36ba,(int16_t)0x73b6,
    (int16_t)0x398d,(int16_t)0x7255,
    (int16_t)0x3c57,(int16_t)0x70e3,
    (int16_t)0x3f17,(int16_t)0x6f5f,
    (int16_t)0x41ce,(int16_t)0x6dca,
    (int16_t)0x447b,(int16_t)0x6c24,
    (int16_t)0x471d,(int16_t)0x6a6e,
    (int16_t)0x49b4,(int16_t)0x68a7,
    (int16_t)0x4c40,(int16_t)0x66d0,
    (int16_t)0x4ec0,(int16_t)0x64e9,
    (int16_t)0x5134,(int16_t)0x62f2,
    (int16_t)0x539b,(int16_t)0x60ec,
    (int16_t)0x55f6,(int16_t)0x5ed7,
    (int16_t)0x5843,(int16_t)0x5cb4,
    (int16_t)0x5a82,(int16_t)0x5a82,
    (int16_t)0x5cb4,(int16_t)0x5843,
    (int16_t)0x5ed7,(int16_t)0x55f6,
    (int16_t)0x60ec,(int16_t)0x539b,
    (int16_t)0x62f2,(int16_t)0x5134,
    (int16_t)0x64e9,(int16_t)0x4ec0,
    (int16_t)0x66d0,(int16_t)0x4c40,
    (int16_t)0x68a7,(int16_t)0x49b4,
    (int16_t)0x6a6e,(int16_t)0x471d,
    (int16_t)0x6c24,(int16_t)0x447b,
    (int16_t)0x6dca,(int16_t)0x41ce,
    (int16_t)0x6f5f,(int16_t)0x3f17,
    (int16_t)0x70e3,(int16_t)0x3c57,
    (int16_t)0x7255,(int16_t)0x398d,
    (int16_t)0x73b6,(int16_t)0x36ba,
    (int16_t)0x7505,(int16_t)0x33df,
    (int16_t)0x7642,(int16_t)0x30fc,
    (int16_t)0x776c,(int16_t)0x2e11,
    (int16_t)0x7885,(int16_t)0x2b1f,
    (int16_t)0x798a,(int16_t)0x2827,
    (int16_t)0x7a7d,(int16_t)0x2528,
    (int16_t)0x7b5d,(int16_t)0x2224,
    (int16_t)0x7c2a,(int16_t)0x1f1a,
    (int16_t)0x7ce4,(int16_t)0x1c0c,
    (int16_t)0x7d8a,(int16_t)0x18f9,
    (int16_t)0x7e1e,(int16_t)0x15e2,
    (int16_t)0x7e9d,(int16_t)0x12c8,
    (int16_t)0x7f0a,(int16_t)0x0fab,
    (int16_t)0x7f62,(int16_t)0x0c8c,
    (int16_t)0x7fa7,(int16_t)0x096b,
    (int16_t)0x7fd9,(int16_t)0x0648,
    (int16_t)0x7ff6,(int16_t)0x0324
};

static const fft_real_x16_descr_t __rfft_descr =
{
    &__cfft_x16_descr128,
    __fft_real16_tw
};
static const fft_real_x16_descr_t __rifft_descr =
{
    &__cifft_x16_descr128,
    __fft_real16_tw
};
const fft_handle_t rfft16_256 = (const fft_handle_t)&__rfft_descr;
const fft_handle_t rifft16_256 = (const fft_handle_t)&__rifft_descr;
