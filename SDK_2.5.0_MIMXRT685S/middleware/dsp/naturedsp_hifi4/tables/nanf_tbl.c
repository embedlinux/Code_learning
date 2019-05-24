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
	NaN values for single precision routines
*/

/* Portable data types. */
#include "NatureDSP_types.h"
/* Common utility macros. */
#include "common.h"
/* NaN values for single precision routines. */
#include "nanf_tbl.h"

const union ufloat32uint32 sNaNf       = { 0x7f800001 }; /* Signalling NaN          */
const union ufloat32uint32 qNaNf       = { 0x7fc00000 }; /* Quiet NaN               */
const union ufloat32uint32 minus_sNaNf = { 0xff800001 }; /* Negative Signalling NaN */
const union ufloat32uint32 minus_qNaNf = { 0xffc00000 }; /* Negative Quiet NaN      */
