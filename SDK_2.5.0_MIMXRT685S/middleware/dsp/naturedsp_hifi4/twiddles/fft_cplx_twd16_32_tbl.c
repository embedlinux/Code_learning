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

/* Twiddles tables for fft_cplx32x16, ifft_cplx32x16, fft_cplx16x16, ifft_cplx16x16, N=32 */
#define N 32

/****************** stage 1, stage 2 radix 4 ******************/
ALIGN(8) static const int16_t __fft16_tw1[] = 
{
    (int16_t)0x7fff,(int16_t)0x0000,(int16_t)0x7fff,(int16_t)0x0000,(int16_t)0x7fff,(int16_t)0x0000,
    (int16_t)0x7d8a,(int16_t)0xe707,(int16_t)0x7642,(int16_t)0xcf04,(int16_t)0x6a6e,(int16_t)0xb8e3,
    (int16_t)0x7642,(int16_t)0xcf04,(int16_t)0x5a82,(int16_t)0xa57e,(int16_t)0x30fc,(int16_t)0x89be,
    (int16_t)0x6a6e,(int16_t)0xb8e3,(int16_t)0x30fc,(int16_t)0x89be,(int16_t)0xe707,(int16_t)0x8276,
    (int16_t)0x5a82,(int16_t)0xa57e,(int16_t)0x0000,(int16_t)0x8000,(int16_t)0xa57e,(int16_t)0xa57e,
    (int16_t)0x471d,(int16_t)0x9592,(int16_t)0xcf04,(int16_t)0x89be,(int16_t)0x8276,(int16_t)0xe707,
    (int16_t)0x30fc,(int16_t)0x89be,(int16_t)0xa57e,(int16_t)0xa57e,(int16_t)0x89be,(int16_t)0x30fc,
    (int16_t)0x18f9,(int16_t)0x8276,(int16_t)0x89be,(int16_t)0xcf04,(int16_t)0xb8e3,(int16_t)0x6a6e
};
static const int tw_step_tab[] =
{
    1, 4
}; 
static const cint16ptr_t tw_tab[] = 
{
    __fft16_tw1, NULL
};

static const eFft_stage_type fft_stg_tab[] = 
{
    fft_stage_first_DFT4,
    fft_stage_last_DFT8
};
static const eFft_stage_type ifft_stg_tab[] =
{
    fft_stage_first_inv_DFT4,
    fft_stage_last_DFT8
};


const fft_cplx_x16_descr_t __cfft_x16_descr32 = 
{
    N, 
    fft_stg_tab,
    fft_stg_tab,
    fft_stg_tab, 
    fft_stg_tab,
    tw_step_tab,
    tw_tab
};     
const fft_cplx_x16_descr_t __cifft_x16_descr32 =
{
    N, 
    ifft_stg_tab, 
    ifft_stg_tab, 
    ifft_stg_tab, 
    ifft_stg_tab, 
    tw_step_tab,
    tw_tab
};     
const fft_handle_t cfft16_32 = (const fft_handle_t)&__cfft_x16_descr32;
const fft_handle_t cifft16_32 = (const fft_handle_t)&__cifft_x16_descr32;
