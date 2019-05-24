/*
 * Copyright 2018 NXP
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 */

#include "fsl_debug_console.h"
#include "board.h"
#include "fsl_powerquad.h"
#include "math.h"

#include "pin_mux.h"
#include "clock_config.h"
/*******************************************************************************
 * Definitions
 ******************************************************************************/
#define DEMO_POWERQUAD POWERQUAD
#define MATH_EXAMPLE_LEN 32
#define MATH_PI 3.1415926535898
#define FLOAT_2_Q31(x) ((int32_t)((x)*2147483648.0f))
#define FLOAT_2_Q15(x) (int16_t) __SSAT(((int32_t)((x)*32768.0f)), 16)
#define EXAMPLE_ASSERT_TRUE(x)            \
    if (!(x))                             \
    {                                     \
        PRINTF("%s error\r\n", __func__); \
        while (1)                         \
        {                                 \
        }                                 \
    }

/*******************************************************************************
 * Prototypes
 ******************************************************************************/
static void PQ_MathLnFixedExample(void);
static void PQ_MathLnFloatExample(void);
static void PQ_MathInvFixedExample(void);
static void PQ_MathInvFloatExample(void);
static void PQ_MathSqrtFixedExample(void);
static void PQ_MathSqrtFloatExample(void);
static void PQ_MathInvSqrtFixedExample(void);
static void PQ_MathInvSqrtFloatExample(void);
static void PQ_MathEtoxFixedExample(void);
static void PQ_MathEtoxFloatExample(void);
static void PQ_MathEtonxFixedExample(void);
static void PQ_MathEtonxFloatExample(void);
static void PQ_MathSinQ31Example(void);
static void PQ_MathSinFloatExample(void);
static void PQ_MathCosQ31Example(void);
static void PQ_MathCosFloatExample(void);
static void PQ_MathDivFloatExample(void);
static void PQ_MathArctanFixedExample(void);
static void PQ_MathArctanhFixedExample(void);

/* Vector functions. */
static void PQ_VectorLnFloatExample(void);
static void PQ_VectorLnFixed32Example(void);
static void PQ_VectorLnFixed16Example(void);
static void PQ_VectorInvFloatExample(void);
static void PQ_VectorInvFixed32Example(void);
static void PQ_VectorInvFixed16Example(void);
static void PQ_VectorSqrtFloatExample(void);
static void PQ_VectorSqrtFixed32Example(void);
static void PQ_VectorSqrtFixed16Example(void);
static void PQ_VectorInvSqrtFloatExample(void);
static void PQ_VectorInvSqrtFixed32Example(void);
static void PQ_VectorInvSqrtFixed16Example(void);
static void PQ_VectorEtoxFloatExample(void);
static void PQ_VectorEtoxFixed32Example(void);
static void PQ_VectorEtoxFixed16Example(void);
static void PQ_VectorEtonxFloatExample(void);
static void PQ_VectorEtonxFixed32Example(void);
static void PQ_VectorEtonxFixed16Example(void);
static void PQ_VectorSinFloatExample(void);
static void PQ_VectorSinQ31Example(void);
static void PQ_VectorSinQ15Example(void);
static void PQ_VectorCosFloatExample(void);
static void PQ_VectorCosQ31Example(void);
static void PQ_VectorCosQ15Example(void);

/*******************************************************************************
 * Variables
 ******************************************************************************/

/*******************************************************************************
 * Code
 ******************************************************************************/

/*!
 * @brief Main function
 */
int main(void)
{
    /* Board pin, clock, debug console init */
    BOARD_InitPins();
    BOARD_BootClockRUN();
    BOARD_InitDebugConsole();

    /* Power up PQ RAM. */
    SYSCTL0->PDRUNCFG1_CLR = SYSCTL0_PDRUNCFG1_PQ_SRAM_APD_MASK | SYSCTL0_PDRUNCFG1_PQ_SRAM_PPD_MASK;
    /* Apply power setting. */
    PMC->CTRL |= PMC_CTRL_APPLYCFG_MASK;

    PRINTF("POWERQUAD math example started\r\n");

    PQ_Init(DEMO_POWERQUAD);

    PQ_MathLnFixedExample();
    PQ_MathLnFloatExample();
    PQ_MathInvFixedExample();
    PQ_MathInvFloatExample();
    PQ_MathSqrtFixedExample();
    PQ_MathSqrtFloatExample();
    PQ_MathInvSqrtFixedExample();
    PQ_MathInvSqrtFloatExample();
    PQ_MathEtoxFixedExample();
    PQ_MathEtoxFloatExample();
    PQ_MathEtonxFixedExample();
    PQ_MathEtonxFloatExample();
    PQ_MathSinQ31Example();
    PQ_MathSinFloatExample();
    PQ_MathCosQ31Example();
    PQ_MathCosFloatExample();
    PQ_MathDivFloatExample();
    PQ_MathArctanFixedExample();
    PQ_MathArctanhFixedExample();

    PQ_VectorLnFloatExample();
    PQ_VectorLnFixed32Example();
    PQ_VectorLnFixed16Example();
    PQ_VectorInvFloatExample();
    PQ_VectorInvFixed32Example();
    PQ_VectorInvFixed16Example();
    PQ_VectorSqrtFloatExample();
    PQ_VectorSqrtFixed32Example();
    PQ_VectorSqrtFixed16Example();
    PQ_VectorInvSqrtFloatExample();
    PQ_VectorInvSqrtFixed32Example();
    PQ_VectorInvSqrtFixed16Example();
    PQ_VectorEtoxFloatExample();
    PQ_VectorEtoxFixed32Example();
    PQ_VectorEtoxFixed16Example();
    PQ_VectorEtonxFloatExample();
    PQ_VectorEtonxFixed32Example();
    PQ_VectorEtonxFixed16Example();
    PQ_VectorSinFloatExample();
    PQ_VectorSinQ31Example();
    PQ_VectorSinQ15Example();
    PQ_VectorCosFloatExample();
    PQ_VectorCosQ31Example();
    PQ_VectorCosQ15Example();

    PRINTF("POWERQUAD math example successed\r\n");

    while (1)
    {
    }
}

/* Fixed Natural Log */
static void PQ_MathLnFixedExample(void)
{
    int32_t input;
    int32_t result;
    int32_t ref;
    uint32_t i;

    /*
     * The output scale is set to 16, so the output result is multiplied by 2^^16
     */
    const pq_prescale_t prescale = {
        .inputPrescale = 0, .outputPrescale = 16, .outputSaturate = 0,
    };

    PQ_SetCoprocessorScaler(DEMO_POWERQUAD, &prescale);

    for (i = 1; i <= MATH_EXAMPLE_LEN; i++)
    {
        input = i;
        ref = (int32_t)(log(input) * (float)(1 << 16));
        result = PQ_LnFixed(input);

        EXAMPLE_ASSERT_TRUE(abs(ref - result) <= 1);
    }
}

/* Float Natural Log */
static void PQ_MathLnFloatExample(void)
{
    float input;
    float result;
    float ref;
    uint32_t i;

    for (i = 1; i <= MATH_EXAMPLE_LEN; i++)
    {
        input = i;
        ref = (float)(log(input));
        PQ_LnF32(&input, &result);

        EXAMPLE_ASSERT_TRUE(fabs(ref - result) <= 0.000001);
    }
}

/* Fixed Reciprocal */
static void PQ_MathInvFixedExample(void)
{
    int32_t input;
    int32_t result;
    int32_t ref;
    uint32_t i;

    /*
     * The output scale is set to 16, so the output result is multiplied by 2^^16
     */
    const pq_prescale_t prescale = {
        .inputPrescale = 0, .outputPrescale = 16, .outputSaturate = 0,
    };

    PQ_SetCoprocessorScaler(DEMO_POWERQUAD, &prescale);

    for (i = 1; i <= MATH_EXAMPLE_LEN; i++)
    {
        input = i;
        ref = (int32_t)(1.0f / (float)input * (float)(1 << 16));
        result = PQ_InvFixed(input);

        EXAMPLE_ASSERT_TRUE(abs(ref - result) <= 1);
    }
}

/* Float Reciprocal */
static void PQ_MathInvFloatExample(void)
{
    float input;
    float result;
    float ref;
    uint32_t i;

    for (i = 1; i <= MATH_EXAMPLE_LEN; i++)
    {
        input = i;
        ref = 1.0f / (float)input;
        PQ_InvF32(&input, &result);

        EXAMPLE_ASSERT_TRUE(fabs(ref - result) <= 0.000001);
    }
}

/* Fixed Square-root */
static void PQ_MathSqrtFixedExample(void)
{
    int32_t input;
    int32_t result;
    int32_t ref;
    uint32_t i;

    /*
     * The output scale is set to 16, so the output result is multiplied by 2^^16
     */
    const pq_prescale_t prescale = {
        .inputPrescale = 0, .outputPrescale = 16, .outputSaturate = 0,
    };

    PQ_SetCoprocessorScaler(DEMO_POWERQUAD, &prescale);

    for (i = 1; i <= MATH_EXAMPLE_LEN; i++)
    {
        input = i;
        ref = (int32_t)(sqrt(input) * (float)(1 << 16));
        result = PQ_SqrtFixed(input);

        EXAMPLE_ASSERT_TRUE(abs(ref - result) <= 1);
    }
}

/* Float Square-root */
static void PQ_MathSqrtFloatExample(void)
{
    float input;
    float result;
    float ref;
    uint32_t i;

    for (i = 1; i <= MATH_EXAMPLE_LEN; i++)
    {
        input = i;
        ref = sqrt(input);
        PQ_SqrtF32(&input, &result);

        EXAMPLE_ASSERT_TRUE(fabs(ref - result) <= 0.000001);
    }
}

/* Fixed Inverse Square-root */
static void PQ_MathInvSqrtFixedExample(void)
{
    int32_t input;
    int32_t result;
    int32_t ref;
    uint32_t i;

    /*
     * The output scale is set to 16, so the output result is multiplied by 2^^16
     */
    const pq_prescale_t prescale = {
        .inputPrescale = 0, .outputPrescale = 16, .outputSaturate = 0,
    };

    PQ_SetCoprocessorScaler(DEMO_POWERQUAD, &prescale);

    for (i = 1; i <= MATH_EXAMPLE_LEN; i++)
    {
        input = i;
        ref = (int32_t)(1.0f / sqrt(input) * (float)(1 << 16));
        result = PQ_InvSqrtFixed(input);

        EXAMPLE_ASSERT_TRUE(abs(ref - result) <= 1);
    }
}

/* Float Inverse Square-root */
static void PQ_MathInvSqrtFloatExample(void)
{
    float input;
    float result;
    float ref;
    uint32_t i;

    for (i = 1; i <= MATH_EXAMPLE_LEN; i++)
    {
        input = i;
        ref = 1.0f / sqrt(input);
        PQ_InvSqrtF32(&input, &result);

        EXAMPLE_ASSERT_TRUE(fabs(ref - result) <= 0.000001);
    }
}

/* Fixed Natural Exponent */
static void PQ_MathEtoxFixedExample(void)
{
    int32_t input;
    int32_t result;
    int32_t ref;
    uint32_t i;

    /*
     * The output scale is set to 16, so the output result is multiplied by 2^^16
     */
    const pq_prescale_t prescale = {
        .inputPrescale = -3, .outputPrescale = 16, .outputSaturate = 0,
    };

    PQ_SetCoprocessorScaler(DEMO_POWERQUAD, &prescale);

    for (i = 1; i <= MATH_EXAMPLE_LEN; i++)
    {
        input = i;
        ref = (int32_t)(exp((float)input / 8.0f) * (float)(1 << 16));
        result = PQ_EtoxFixed(input);

        EXAMPLE_ASSERT_TRUE(abs(ref - result) <= 1);
    }
}

/* F32 Natural Exponent */
static void PQ_MathEtoxFloatExample(void)
{
    float input;
    float result;
    float ref;
    uint32_t i;

    for (i = 1; i <= MATH_EXAMPLE_LEN; i++)
    {
        input = i / 8.0f;
        ref = exp(input);
        PQ_EtoxF32(&input, &result);

        EXAMPLE_ASSERT_TRUE(fabs(ref - result) <= 0.0001);
    }
}

/* Fixed Natural Exponent with negative parameter*/
static void PQ_MathEtonxFixedExample(void)
{
    int32_t input;
    int32_t result;
    int32_t ref;
    uint32_t i;

    /*
     * The output scale is set to 16, so the output result is multiplied by 2^^16
     */
    const pq_prescale_t prescale = {
        .inputPrescale = -3, .outputPrescale = 16, .outputSaturate = 0,
    };

    PQ_SetCoprocessorScaler(DEMO_POWERQUAD, &prescale);

    for (i = 0; i <= MATH_EXAMPLE_LEN; i++)
    {
        input = i;
        ref = (int32_t)(1.0f / exp((float)i / 8.0f) * (float)(1 << 16));
        result = PQ_EtonxFixed(input);

        EXAMPLE_ASSERT_TRUE(abs(ref - result) <= 1);
    }
}

/* F32 Natural Exponent with negative parameter*/
static void PQ_MathEtonxFloatExample(void)
{
    float input;
    float result;
    float ref;
    uint32_t i;

    for (i = 0; i <= MATH_EXAMPLE_LEN; i++)
    {
        input = i / 8.0f;
        ref = 1.0f / exp(input);
        PQ_EtonxF32(&input, &result);

        EXAMPLE_ASSERT_TRUE(fabs(ref - result) <= 0.0001);
    }
}

/* Fixed sine */
static void PQ_MathSinQ31Example(void)
{
    float input;
    int32_t result;
    int32_t ref;
    uint32_t i;

    for (i = 1; i <= MATH_EXAMPLE_LEN; i++)
    {
        /*
         * The input value is in radians, input range -1 to 1 (Fixed) means -pi to pi.
         */
        input = ((float)(i * 2) / (float)MATH_EXAMPLE_LEN) - 1.0f;
        ref = FLOAT_2_Q31(sin(input * MATH_PI));
        result = PQ_SinQ31(FLOAT_2_Q31(input));

        EXAMPLE_ASSERT_TRUE(abs(ref - result) <= 400);
    }
}

/* Fixed sine */
static void PQ_MathSinFloatExample(void)
{
    float input;
    float result;
    float ref;
    uint32_t i;

    for (i = 1; i <= MATH_EXAMPLE_LEN; i++)
    {
        /*
         * The input value is in radians. This function calculates -pi to pi.
         */
        input = (((float)(i * 2) / (float)MATH_EXAMPLE_LEN) - 1.0f) * MATH_PI;
        ref = sin(input);
        PQ_SinF32(&input, &result);

        EXAMPLE_ASSERT_TRUE(fabs(ref - result) <= 0.000001);
    }
}

/* Fixed Cosine */
static void PQ_MathCosQ31Example(void)
{
    float input;
    int32_t result;
    int32_t ref;
    uint32_t i;

    for (i = 1; i <= MATH_EXAMPLE_LEN; i++)
    {
        /*
         * The input value is in radians, input range -1 to 1 (Fixed) means -pi to pi.
         */
        input = ((float)(i * 2) / (float)MATH_EXAMPLE_LEN) - 1.0f;
        ref = FLOAT_2_Q31(cos(input * MATH_PI));
        result = PQ_CosQ31(FLOAT_2_Q31(input));

        EXAMPLE_ASSERT_TRUE(abs(ref - result) <= 200);
    }
}

/* Fixed Cosine */
static void PQ_MathCosFloatExample(void)
{
    float input;
    float result;
    float ref;
    uint32_t i;

    for (i = 1; i <= MATH_EXAMPLE_LEN; i++)
    {
        /*
         * The input value is in radians. This function calculates -pi to pi.
         */
        input = (((float)(i * 2) / (float)MATH_EXAMPLE_LEN) - 1.0f) * MATH_PI;
        ref = cos(input);
        PQ_CosF32(&input, &result);

        EXAMPLE_ASSERT_TRUE(fabs(ref - result) <= 0.000001);
    }
}

/* Float Division */
static void PQ_MathDivFloatExample(void)
{
    float result;
    float ref;
    float x1, x2;
    uint32_t i, j;

    for (i = 0; i <= MATH_EXAMPLE_LEN; i++)
    {
        for (j = 1; j <= MATH_EXAMPLE_LEN; j++)
        {
            x1 = (float)i;
            x2 = (float)j;
            ref = x1 / x2;
            PQ_DivF32(&x1, &x2, &result);

            EXAMPLE_ASSERT_TRUE(fabs(ref - result) <= 0.00002);
        }
    }
}

/* Fixed Trigonometric */
static void PQ_MathArctanFixedExample(void)
{
    int32_t myres = 0;
    float arctanResult = 0;
    float arctanRef = atan(0.5); /* 0.4636476 */

    /* 2^27 means pi. */
    myres = PQ_ArctanFixed(DEMO_POWERQUAD, 20000000, 10000000, kPQ_Iteration_24);
    arctanResult = (float)(2 * MATH_PI * (myres) / (134217728.0 * 2));

    EXAMPLE_ASSERT_TRUE(fabs(arctanRef - arctanResult) < 0.001);
}

/* Fixed Inverse Trigonometric */
static void PQ_MathArctanhFixedExample(void)
{
    int32_t myres = 0;
    float arctanhResult = 0;
    float arctanhRef = atanh(0.5); /* 0.549306 */

    /* 2^27 means pi. */
    myres = PQ_ArctanhFixed(DEMO_POWERQUAD, 20000000, 10000000, kPQ_Iteration_24);
    arctanhResult = (float)(2 * (myres) / (134217728.0 * 2));

    EXAMPLE_ASSERT_TRUE(fabs(arctanhRef - arctanhResult) < 0.00001);
}

static void PQ_VectorLnFloatExample(void)
{
    float input[MATH_EXAMPLE_LEN];
    float result[MATH_EXAMPLE_LEN];
    float ref[MATH_EXAMPLE_LEN];
    uint32_t i;

    for (i = 1; i <= MATH_EXAMPLE_LEN; i++)
    {
        input[i - 1] = i;
        ref[i - 1] = log(i);
    }

    PQ_VectorLnF32(input, result, ARRAY_SIZE(result));

    for (i = 0; i < ARRAY_SIZE(result); i++)
    {
        EXAMPLE_ASSERT_TRUE(fabs(ref[i] - result[i]) <= 0.000001);
    }
}

static void PQ_VectorLnFixed32Example(void)
{
    int32_t input[MATH_EXAMPLE_LEN];
    int32_t result[MATH_EXAMPLE_LEN];
    int32_t ref[MATH_EXAMPLE_LEN];
    uint32_t i;

    /*
     * The output scale is set to 16, so the output result is multiplied by 2^^16
     */
    const pq_prescale_t prescale = {
        .inputPrescale = 0, .outputPrescale = 16, .outputSaturate = 0,
    };

    for (i = 1; i <= MATH_EXAMPLE_LEN; i++)
    {
        input[i - 1] = i;
        ref[i - 1] = (int32_t)(log(i) * (float)(1 << 16));
    }

    PQ_SetCoprocessorScaler(DEMO_POWERQUAD, &prescale);

    PQ_VectorLnFixed32(input, result, ARRAY_SIZE(input));

    for (i = 0; i < ARRAY_SIZE(input); i++)
    {
        EXAMPLE_ASSERT_TRUE(abs(ref[i] - result[i]) <= 1);
    }
}

static void PQ_VectorLnFixed16Example(void)
{
    int16_t input[MATH_EXAMPLE_LEN];
    int16_t result[MATH_EXAMPLE_LEN];
    int16_t ref[MATH_EXAMPLE_LEN];
    uint32_t i;

    /*
     * The output scale is set to 8, so the output result is multiplied by 2^^8
     */
    const pq_prescale_t prescale = {
        .inputPrescale = 0, .outputPrescale = 8, .outputSaturate = 0,
    };

    for (i = 1; i <= MATH_EXAMPLE_LEN; i++)
    {
        input[i - 1] = i;
        ref[i - 1] = (int16_t)(log(i) * (float)(1 << 8));
    }

    PQ_SetCoprocessorScaler(DEMO_POWERQUAD, &prescale);

    PQ_VectorLnFixed16(input, result, ARRAY_SIZE(input));

    for (i = 0; i < ARRAY_SIZE(input); i++)
    {
        EXAMPLE_ASSERT_TRUE(abs(ref[i] - result[i]) <= 1);
    }
}

static void PQ_VectorInvFloatExample(void)
{
    float input[MATH_EXAMPLE_LEN];
    float result[MATH_EXAMPLE_LEN];
    float ref[MATH_EXAMPLE_LEN];
    uint32_t i;

    for (i = 1; i <= MATH_EXAMPLE_LEN; i++)
    {
        input[i - 1] = i;
        ref[i - 1] = 1.0f / (float)i;
    }

    PQ_VectorInvF32(input, result, ARRAY_SIZE(input));

    for (i = 0; i < ARRAY_SIZE(input); i++)
    {
        EXAMPLE_ASSERT_TRUE(fabs(ref[i] - result[i]) <= 0.000001);
    }
}

static void PQ_VectorInvFixed32Example(void)
{
    int32_t input[MATH_EXAMPLE_LEN];
    int32_t result[MATH_EXAMPLE_LEN];
    int32_t ref[MATH_EXAMPLE_LEN];
    uint32_t i;

    /*
     * The output scale is set to 16, so the output result is multiplied by 2^^16
     */
    const pq_prescale_t prescale = {
        .inputPrescale = 0, .outputPrescale = 16, .outputSaturate = 0,
    };

    for (i = 1; i <= MATH_EXAMPLE_LEN; i++)
    {
        input[i - 1] = i;
        ref[i - 1] = (int32_t)(1.0f / (float)i * (float)(1 << 16));
    }

    PQ_SetCoprocessorScaler(DEMO_POWERQUAD, &prescale);

    PQ_VectorInvFixed32(input, result, ARRAY_SIZE(input));

    for (i = 0; i < ARRAY_SIZE(input); i++)
    {
        EXAMPLE_ASSERT_TRUE(abs(ref[i] - result[i]) <= 1);
    }
}

static void PQ_VectorInvFixed16Example(void)
{
    int16_t input[MATH_EXAMPLE_LEN];
    int16_t result[MATH_EXAMPLE_LEN];
    int16_t ref[MATH_EXAMPLE_LEN];
    uint32_t i;

    /*
     * The output scale is set to 8, so the output result is multiplied by 2^^8
     */
    const pq_prescale_t prescale = {
        .inputPrescale = 0, .outputPrescale = 8, .outputSaturate = 0,
    };

    for (i = 1; i <= MATH_EXAMPLE_LEN; i++)
    {
        input[i - 1] = i;
        ref[i - 1] = (int16_t)(1.0f / (float)i * (float)(1 << 8));
    }

    PQ_SetCoprocessorScaler(DEMO_POWERQUAD, &prescale);

    PQ_VectorInvFixed16(input, result, ARRAY_SIZE(input));

    for (i = 0; i < ARRAY_SIZE(input); i++)
    {
        EXAMPLE_ASSERT_TRUE(abs(ref[i] - result[i]) <= 1);
    }
}

/* Float Vector Sqrt */
static void PQ_VectorSqrtFloatExample(void)
{
    float input[MATH_EXAMPLE_LEN];
    float result[MATH_EXAMPLE_LEN];
    float ref[MATH_EXAMPLE_LEN];
    uint32_t i;

    for (i = 1; i <= MATH_EXAMPLE_LEN; i++)
    {
        input[i - 1] = i;
        ref[i - 1] = sqrt((float)i);
    }

    PQ_VectorSqrtF32(input, result, ARRAY_SIZE(input));

    for (i = 0; i < ARRAY_SIZE(input); i++)
    {
        EXAMPLE_ASSERT_TRUE(fabs(ref[i] - result[i]) <= 0.000001);
    }
}

static void PQ_VectorSqrtFixed32Example(void)
{
    int32_t input[MATH_EXAMPLE_LEN];
    int32_t result[MATH_EXAMPLE_LEN];
    int32_t ref[MATH_EXAMPLE_LEN];
    uint32_t i;

    /*
     * The output scale is set to 16, so the output result is multiplied by 2^^16
     */
    const pq_prescale_t prescale = {
        .inputPrescale = 0, .outputPrescale = 16, .outputSaturate = 0,
    };

    for (i = 1; i <= MATH_EXAMPLE_LEN; i++)
    {
        input[i - 1] = i;
        ref[i - 1] = (int32_t)(sqrt((float)i) * (float)(1 << 16));
    }

    PQ_SetCoprocessorScaler(DEMO_POWERQUAD, &prescale);

    PQ_VectorSqrtFixed32(input, result, ARRAY_SIZE(input));

    for (i = 0; i < ARRAY_SIZE(input); i++)
    {
        EXAMPLE_ASSERT_TRUE(abs(ref[i] - result[i]) <= 1);
    }
}

static void PQ_VectorSqrtFixed16Example(void)
{
    int16_t input[MATH_EXAMPLE_LEN];
    int16_t result[MATH_EXAMPLE_LEN];
    int16_t ref[MATH_EXAMPLE_LEN];
    uint32_t i;

    /*
     * The output scale is set to 8, so the output result is multiplied by 2^^8
     */
    const pq_prescale_t prescale = {
        .inputPrescale = 0, .outputPrescale = 8, .outputSaturate = 0,
    };

    for (i = 1; i <= MATH_EXAMPLE_LEN; i++)
    {
        input[i - 1] = i;
        ref[i - 1] = (int16_t)(sqrt((float)i) * (float)(1 << 8));
    }

    PQ_SetCoprocessorScaler(DEMO_POWERQUAD, &prescale);

    PQ_VectorSqrtFixed16(input, result, ARRAY_SIZE(input));

    for (i = 0; i < ARRAY_SIZE(input); i++)
    {
        EXAMPLE_ASSERT_TRUE(abs(ref[i] - result[i]) <= 1);
    }
}

static void PQ_VectorInvSqrtFloatExample(void)
{
    float input[MATH_EXAMPLE_LEN];
    float result[MATH_EXAMPLE_LEN];
    float ref[MATH_EXAMPLE_LEN];
    uint32_t i;

    for (i = 1; i <= MATH_EXAMPLE_LEN; i++)
    {
        input[i - 1] = i;
        ref[i - 1] = 1.0f / sqrt((float)i);
    }

    PQ_VectorInvSqrtF32(input, result, ARRAY_SIZE(input));

    for (i = 0; i < ARRAY_SIZE(input); i++)
    {
        EXAMPLE_ASSERT_TRUE(fabs(ref[i] - result[i]) <= 0.000001);
    }
}

static void PQ_VectorInvSqrtFixed32Example(void)
{
    int32_t input[MATH_EXAMPLE_LEN];
    int32_t result[MATH_EXAMPLE_LEN];
    int32_t ref[MATH_EXAMPLE_LEN];
    uint32_t i;

    /*
     * The output scale is set to 16, so the output result is multiplied by 2^^16
     */
    const pq_prescale_t prescale = {
        .inputPrescale = 0, .outputPrescale = 16, .outputSaturate = 0,
    };

    for (i = 1; i <= MATH_EXAMPLE_LEN; i++)
    {
        input[i - 1] = i;
        ref[i - 1] = (int32_t)(1.0f / sqrt((float)i) * (float)(1 << 16));
    }

    PQ_SetCoprocessorScaler(DEMO_POWERQUAD, &prescale);

    PQ_VectorInvSqrtFixed32(input, result, ARRAY_SIZE(input));

    for (i = 0; i < ARRAY_SIZE(input); i++)
    {
        EXAMPLE_ASSERT_TRUE(abs(ref[i] - result[i]) <= 1);
    }
}

static void PQ_VectorInvSqrtFixed16Example(void)
{
    int16_t input[MATH_EXAMPLE_LEN];
    int16_t result[MATH_EXAMPLE_LEN];
    int16_t ref[MATH_EXAMPLE_LEN];
    uint32_t i;

    /*
     * The output scale is set to 8, so the output result is multiplied by 2^^8
     */
    const pq_prescale_t prescale = {
        .inputPrescale = 0, .outputPrescale = 8, .outputSaturate = 0,
    };

    for (i = 1; i <= MATH_EXAMPLE_LEN; i++)
    {
        input[i - 1] = i;
        ref[i - 1] = (int16_t)(1.0f / sqrt((float)i) * (float)(1 << 8));
    }

    PQ_SetCoprocessorScaler(DEMO_POWERQUAD, &prescale);

    PQ_VectorInvSqrtFixed16(input, result, ARRAY_SIZE(input));

    for (i = 0; i < ARRAY_SIZE(input); i++)
    {
        EXAMPLE_ASSERT_TRUE(abs(ref[i] - result[i]) <= 1);
    }
}

static void PQ_VectorEtoxFloatExample(void)
{
    float input[MATH_EXAMPLE_LEN];
    float result[MATH_EXAMPLE_LEN];
    float ref[MATH_EXAMPLE_LEN];
    uint32_t i;

    for (i = 1; i <= MATH_EXAMPLE_LEN; i++)
    {
        input[i - 1] = i / 8.0f;
        ref[i - 1] = exp(i / 8.0f);
    }

    PQ_VectorEtoxF32(input, result, ARRAY_SIZE(input));

    for (i = 0; i < ARRAY_SIZE(input); i++)
    {
        EXAMPLE_ASSERT_TRUE(fabs(ref[i] - result[i]) <= 0.0001);
    }
}

static void PQ_VectorEtoxFixed32Example(void)
{
    int32_t input[MATH_EXAMPLE_LEN];
    int32_t result[MATH_EXAMPLE_LEN];
    int32_t ref[MATH_EXAMPLE_LEN];
    uint32_t i;

    /*
     * The output scale is set to 16, so the output result is multiplied by 2^^16
     */
    const pq_prescale_t prescale = {
        .inputPrescale = -3, .outputPrescale = 16, .outputSaturate = 0,
    };

    for (i = 1; i <= MATH_EXAMPLE_LEN; i++)
    {
        input[i - 1] = i;
        ref[i - 1] = (int32_t)(exp(((float)i / 8.0f)) * (float)(1 << 16));
    }

    PQ_SetCoprocessorScaler(DEMO_POWERQUAD, &prescale);

    PQ_VectorEtoxFixed32(input, result, ARRAY_SIZE(input));

    for (i = 0; i < ARRAY_SIZE(input); i++)
    {
        EXAMPLE_ASSERT_TRUE(abs(ref[i] - result[i]) <= 1);
    }
}

static void PQ_VectorEtoxFixed16Example(void)
{
    int16_t input[MATH_EXAMPLE_LEN];
    int16_t result[MATH_EXAMPLE_LEN];
    int16_t ref[MATH_EXAMPLE_LEN];
    uint32_t i;

    /*
     * The output scale is set to 8, so the output result is multiplied by 2^^8
     */
    const pq_prescale_t prescale = {
        .inputPrescale = -3, .outputPrescale = 8, .outputSaturate = 0,
    };

    for (i = 1; i <= MATH_EXAMPLE_LEN; i++)
    {
        input[i - 1] = i;
        ref[i - 1] = (int16_t)(exp((float)i / 8.0f) * (float)(1 << 8));
    }

    PQ_SetCoprocessorScaler(DEMO_POWERQUAD, &prescale);

    PQ_VectorEtoxFixed16(input, result, ARRAY_SIZE(input));

    for (i = 0; i < ARRAY_SIZE(input); i++)
    {
        EXAMPLE_ASSERT_TRUE(abs(ref[i] - result[i]) <= 1);
    }
}

static void PQ_VectorEtonxFloatExample(void)
{
    float input[MATH_EXAMPLE_LEN];
    float result[MATH_EXAMPLE_LEN];
    float ref[MATH_EXAMPLE_LEN];
    uint32_t i;

    for (i = 1; i <= MATH_EXAMPLE_LEN; i++)
    {
        input[i - 1] = i / 8.0f;
        ref[i - 1] = 1.0f / exp(i / 8.0f);
    }

    PQ_VectorEtonxF32(input, result, ARRAY_SIZE(input));

    for (i = 0; i < ARRAY_SIZE(input); i++)
    {
        EXAMPLE_ASSERT_TRUE(fabs(ref[i] - result[i]) <= 0.0001);
    }
}

static void PQ_VectorEtonxFixed32Example(void)
{
    int32_t input[MATH_EXAMPLE_LEN];
    int32_t result[MATH_EXAMPLE_LEN];
    int32_t ref[MATH_EXAMPLE_LEN];
    uint32_t i;

    /*
     * The output scale is set to 16, so the output result is multiplied by 2^^16
     */
    const pq_prescale_t prescale = {
        .inputPrescale = -3, .outputPrescale = 16, .outputSaturate = 0,
    };

    for (i = 1; i <= MATH_EXAMPLE_LEN; i++)
    {
        input[i - 1] = i;
        ref[i - 1] = (int32_t)(1.0f / exp((float)i / 8.0f) * (float)(1 << 16));
    }

    PQ_SetCoprocessorScaler(DEMO_POWERQUAD, &prescale);

    PQ_VectorEtonxFixed32(input, result, ARRAY_SIZE(input));

    for (i = 0; i < ARRAY_SIZE(input); i++)
    {
        EXAMPLE_ASSERT_TRUE(abs(ref[i] - result[i]) <= 1);
    }
}

static void PQ_VectorEtonxFixed16Example(void)
{
    int16_t input[MATH_EXAMPLE_LEN];
    int16_t result[MATH_EXAMPLE_LEN];
    int16_t ref[MATH_EXAMPLE_LEN];
    uint32_t i;

    /*
     * The output scale is set to 8, so the output result is multiplied by 2^^8
     */
    const pq_prescale_t prescale = {
        .inputPrescale = -3, .outputPrescale = 8, .outputSaturate = 0,
    };

    for (i = 1; i <= MATH_EXAMPLE_LEN; i++)
    {
        input[i - 1] = i;
        ref[i - 1] = (int16_t)(1.0f / exp((float)i / 8.0f) * (float)(1 << 8));
    }

    PQ_SetCoprocessorScaler(DEMO_POWERQUAD, &prescale);

    PQ_VectorEtonxFixed16(input, result, ARRAY_SIZE(input));

    for (i = 0; i < ARRAY_SIZE(input); i++)
    {
        EXAMPLE_ASSERT_TRUE(abs(ref[i] - result[i]) <= 1);
    }
}

static void PQ_VectorSinFloatExample(void)
{
    float input[MATH_EXAMPLE_LEN];
    float result[MATH_EXAMPLE_LEN];
    float ref[MATH_EXAMPLE_LEN];
    uint32_t i;

    for (i = 0; i < MATH_EXAMPLE_LEN; i++)
    {
        /*
         * The input value is in radians. This function calculates -pi to pi.
         */
        input[i] = (((float)(i * 2) / (float)MATH_EXAMPLE_LEN) - 1.0f) * MATH_PI;
        ref[i] = sin(input[i]);
    }

    PQ_VectorSinF32(input, result, ARRAY_SIZE(input));

    for (i = 0; i < ARRAY_SIZE(input); i++)
    {
        EXAMPLE_ASSERT_TRUE(fabs(ref[i] - result[i]) <= 0.000001);
    }

    for (; i < ARRAY_SIZE(input); i++)
    {
        EXAMPLE_ASSERT_TRUE(result[i] == 0.0f);
    }
}

static void PQ_VectorSinQ31Example(void)
{
    float inputFloat;
    int32_t input[MATH_EXAMPLE_LEN];
    int32_t result[MATH_EXAMPLE_LEN];
    int32_t ref[MATH_EXAMPLE_LEN];
    uint32_t i;

    for (i = 0; i < MATH_EXAMPLE_LEN; i++)
    {
        /*
         * The input value is in radians, input range -1 to 1 (Fixed) means -pi to pi.
         */
        inputFloat = ((float)(i * 2) / (float)MATH_EXAMPLE_LEN) - 1.0f;
        input[i] = FLOAT_2_Q31(inputFloat);
        ref[i] = FLOAT_2_Q31(sin(inputFloat * MATH_PI));
    }

    PQ_VectorSinQ31(input, result, ARRAY_SIZE(input));

    for (i = 0; i < ARRAY_SIZE(input); i++)
    {
        EXAMPLE_ASSERT_TRUE(abs(ref[i] - result[i]) <= 400);
    }
}

static void PQ_VectorSinQ15Example(void)
{
    float inputFloat;
    int16_t input[MATH_EXAMPLE_LEN];
    int16_t result[MATH_EXAMPLE_LEN];
    int16_t ref[MATH_EXAMPLE_LEN];
    uint32_t i;

    for (i = 0; i < MATH_EXAMPLE_LEN; i++)
    {
        /*
         * The input value is in radians, input range -1 to 1 (Q15) means -pi to pi.
         */
        inputFloat = ((float)(i * 2) / (float)MATH_EXAMPLE_LEN) - 1.0f;
        input[i] = FLOAT_2_Q15(inputFloat);
        ref[i] = FLOAT_2_Q15(sin(inputFloat * MATH_PI));
    }

    PQ_VectorSinQ15(input, result, ARRAY_SIZE(input));

    for (i = 0; i < ARRAY_SIZE(input); i++)
    {
        EXAMPLE_ASSERT_TRUE(abs(ref[i] - result[i]) <= 2);
    }
}

static void PQ_VectorCosFloatExample(void)
{
    float input[MATH_EXAMPLE_LEN];
    float result[MATH_EXAMPLE_LEN];
    float ref[MATH_EXAMPLE_LEN];
    uint32_t i;

    for (i = 0; i < MATH_EXAMPLE_LEN; i++)
    {
        /*
         * The input value is in radians. This function calculates -pi to pi.
         */
        input[i] = (((float)(i * 2) / (float)MATH_EXAMPLE_LEN) - 1.0f) * MATH_PI;
        ref[i] = cos(input[i]);
    }

    PQ_VectorCosF32(input, result, ARRAY_SIZE(input));

    for (i = 0; i < ARRAY_SIZE(input); i++)
    {
        EXAMPLE_ASSERT_TRUE(fabs(ref[i] - result[i]) <= 0.000001);
    }
}

static void PQ_VectorCosQ31Example(void)
{
    float inputFloat;
    int32_t input[MATH_EXAMPLE_LEN];
    int32_t result[MATH_EXAMPLE_LEN];
    int32_t ref[MATH_EXAMPLE_LEN];
    uint32_t i;

    for (i = 0; i < MATH_EXAMPLE_LEN; i++)
    {
        /*
         * The input value is in radians, input range -1 to 1 (Fixed) means -pi to pi.
         */
        inputFloat = ((float)(i * 2) / (float)MATH_EXAMPLE_LEN) - 1.0f;
        input[i] = FLOAT_2_Q31(inputFloat);
        ref[i] = FLOAT_2_Q31(cos(inputFloat * MATH_PI));
    }

    PQ_VectorCosQ31(input, result, ARRAY_SIZE(input));

    for (i = 0; i < ARRAY_SIZE(input); i++)
    {
        EXAMPLE_ASSERT_TRUE(abs(ref[i] - result[i]) <= 200);
    }
}

static void PQ_VectorCosQ15Example(void)
{
    float inputFloat;
    int16_t input[MATH_EXAMPLE_LEN];
    int16_t result[MATH_EXAMPLE_LEN];
    int16_t ref[MATH_EXAMPLE_LEN];
    uint32_t i;

    for (i = 0; i < MATH_EXAMPLE_LEN; i++)
    {
        /*
         * The input value is in radians, input range -1 to 1 (Q15) means -pi to pi.
         */
        inputFloat = ((float)(i * 2) / (float)MATH_EXAMPLE_LEN) - 1.0f;
        input[i] = FLOAT_2_Q15(inputFloat);
        ref[i] = FLOAT_2_Q15(cos(inputFloat * MATH_PI));
    }

    PQ_VectorCosQ15(input, result, ARRAY_SIZE(input));

    for (i = 0; i < ARRAY_SIZE(input); i++)
    {
        EXAMPLE_ASSERT_TRUE(abs(ref[i] - result[i]) <= 2);
    }
}
