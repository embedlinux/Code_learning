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
    DCT-IV twiddles
    Integrit, 2006-2018
*/

#include "NatureDSP_Signal_fft.h"
#include "common.h"
#include "dct4_twd.h"


static const complex_fract16 ALIGN(8) dct4_twd_256[]=
{
    {{32767,-101  }},{{32767,-302  }},{{32764,-503  }},{{32760,-704  }},
    {{32756,-905  }},{{32749,-1106 }},{{32742,-1307 }},{{32733,-1507 }},
    {{32723,-1708 }},{{32712,-1909 }},{{32700,-2110 }},{{32686,-2310 }},
    {{32672,-2511 }},{{32656,-2711 }},{{32638,-2912 }},{{32620,-3112 }},
    {{32600,-3312 }},{{32579,-3512 }},{{32557,-3712 }},{{32534,-3911 }},
    {{32509,-4111 }},{{32483,-4310 }},{{32456,-4510 }},{{32428,-4709 }},
    {{32398,-4907 }},{{32368,-5106 }},{{32336,-5305 }},{{32303,-5503 }},
    {{32268,-5701 }},{{32233,-5899 }},{{32196,-6097 }},{{32158,-6294 }},
    {{32119,-6491 }},{{32078,-6688 }},{{32037,-6885 }},{{31994,-7081 }},
    {{31950,-7278 }},{{31904,-7473 }},{{31858,-7669 }},{{31810,-7864 }},
    {{31761,-8059 }},{{31711,-8254 }},{{31660,-8449 }},{{31608,-8643 }},
    {{31554,-8836 }},{{31499,-9030 }},{{31443,-9223 }},{{31386,-9416 }},
    {{31328,-9608 }},{{31268,-9800 }},{{31207,-9992 }},{{31146,-10183}},
    {{31082,-10374}},{{31018,-10565}},{{30953,-10755}},{{30886,-10945}},
    {{30819,-11134}},{{30750,-11323}},{{30680,-11511}},{{30608,-11699}},
    {{30536,-11887}},{{30462,-12074}},{{30388,-12261}},{{30312,-12447}},
    {{23099,-23241}},{{22956,-23383}},{{22812,-23523}},{{22668,-23663}},
    {{22522,-23801}},{{22375,-23939}},{{22228,-24076}},{{22080,-24212}},
    {{21931,-24347}},{{21781,-24481}},{{21631,-24614}},{{21479,-24746}},
    {{21327,-24878}},{{21174,-25008}},{{21020,-25138}},{{20865,-25266}},
    {{20710,-25394}},{{20554,-25520}},{{20397,-25646}},{{20239,-25771}},
    {{20081,-25894}},{{19921,-26017}},{{19761,-26139}},{{19601,-26259}},
    {{19439,-26379}},{{19277,-26498}},{{19114,-26616}},{{18950,-26733}},
    {{18786,-26848}},{{18621,-26963}},{{18455,-27077}},{{18288,-27190}},
    {{18121,-27301}},{{17953,-27412}},{{17785,-27522}},{{17616,-27630}},
    {{17446,-27738}},{{17275,-27844}},{{17104,-27950}},{{16932,-28054}},
    {{16760,-28158}},{{16587,-28260}},{{16413,-28361}},{{16239,-28461}},
    {{16064,-28560}},{{15888,-28658}},{{15712,-28755}},{{15535,-28851}},
    {{15358,-28946}},{{15180,-29040}},{{15002,-29132}},{{14823,-29224}},
    {{14643,-29314}},{{14463,-29404}},{{14282,-29492}},{{14101,-29579}},
    {{13919,-29665}},{{13737,-29750}},{{13554,-29833}},{{13371,-29916}},
    {{13187,-29997}},{{13003,-30078}},{{12818,-30157}},{{12633,-30235}}
};

static const complex_fract16 dct3_256[]=
{
    {{32767,0    }},{{32766,402  }},{{32758,804  }},{{32746,1206 }},
    {{32729,1608 }},{{32706,2009 }},{{32679,2411 }},{{32647,2811 }},
    {{32610,3212 }},{{32568,3612 }},{{32522,4011 }},{{32470,4410 }},
    {{32413,4808 }},{{32352,5205 }},{{32286,5602 }},{{32214,5998 }},
    {{32138,6393 }},{{32058,6787 }},{{31972,7180 }},{{31881,7571 }},
    {{31786,7962 }},{{31686,8351 }},{{31581,8740 }},{{31471,9127 }},
    {{31357,9512 }},{{31238,9896 }},{{31114,10279}},{{30986,10660}},
    {{30853,11039}},{{30715,11417}},{{30572,11793}},{{30425,12167}},
    {{30274,12540}},{{30118,12910}},{{29957,13279}},{{29792,13646}},
    {{29622,14010}},{{29448,14373}},{{29269,14733}},{{29086,15091}},
    {{28899,15447}},{{28707,15800}},{{28511,16151}},{{28311,16500}},
    {{28106,16846}},{{27897,17190}},{{27684,17531}},{{27467,17869}},
    {{27246,18205}},{{27020,18538}},{{26791,18868}},{{26557,19195}},
    {{26320,19520}},{{26078,19841}},{{25833,20160}},{{25583,20475}},
    {{25330,20788}},{{25073,21097}},{{24812,21403}},{{24548,21706}},
    {{24279,22006}},{{24008,22302}},{{23732,22595}},{{23453,22884}}
};

static const complex_fract16 rfft_128[]=
{
    {{32729,1608 }},
    {{32610,3212 }},
    {{32413,4808 }},
    {{32138,6393 }},
    {{31786,7962 }},
    {{31357,9512 }},
    {{30853,11039}},
    {{30274,12540}},
    {{29622,14010}},
    {{28899,15447}},
    {{28106,16846}},
    {{27246,18205}},
    {{26320,19520}},
    {{25330,20788}},
    {{24279,22006}},
    {{23170,23170}},
    {{22006,24279}},
    {{20788,25330}},
    {{19520,26320}},
    {{18205,27246}},
    {{16846,28106}},
    {{15447,28899}},
    {{14010,29622}},
    {{12540,30274}},
    {{11039,30853}},
    {{9512 ,31357}},
    {{7962 ,31786}},
    {{6393 ,32138}},
    {{4808 ,32413}},
    {{3212 ,32610}},
    {{1608 ,32729}}
};

static const complex_fract16 fft_64[]=
{
    {{ 32767, 0    }},
    {{ 32767, 0    }},
    {{ 32767, 0    }},
    {{ 32610,-3212 }},
    {{ 32138,-6393 }},
    {{ 31357,-9512 }},
    {{ 32138,-6393 }},
    {{ 30274,-12540}},
    {{ 27246,-18205}},
    {{ 31357,-9512 }},
    {{ 27246,-18205}},
    {{ 20788,-25330}},
    {{ 30274,-12540}},
    {{ 23170,-23170}},
    {{ 12540,-30274}},
    {{ 28899,-15447}},
    {{ 18205,-27246}},
    {{ 3212 ,-32610}},
    {{ 27246,-18205}},
    {{ 12540,-30274}},
    {{-6393 ,-32138}},
    {{ 25330,-20788}},
    {{ 6393 ,-32138}},
    {{-15447,-28899}},
    {{ 23170,-23170}},
    {{ 0    ,-32768}},
    {{-23170,-23170}},
    {{ 20788,-25330}},
    {{-6393 ,-32138}},
    {{-28899,-15447}},
    {{ 18205,-27246}},
    {{-12540,-30274}},
    {{-32138,-6393 }},
    {{ 15447,-28899}},
    {{-18205,-27246}},
    {{-32610, 3212 }},
    {{ 12540,-30274}},
    {{-23170,-23170}},
    {{-30274, 12540}},
    {{ 9512 ,-31357}},
    {{-27246,-18205}},
    {{-25330, 20788}},
    {{ 6393 ,-32138}},
    {{-30274,-12540}},
    {{-18205, 27246}},
    {{ 3212 ,-32610}},
    {{-32138,-6393 }},
    {{-9512 , 31357}}
};

static const tdct4_twd_fr16 descr = {256,dct4_twd_256,dct3_256,rfft_128,fft_64 };
const dct_handle_t dct4_16_256=(dct_handle_t)&descr;
const dct_handle_t mdct_16_256=(dct_handle_t)&descr;
