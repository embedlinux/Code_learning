/*
 * The Clear BSD License
 * Copyright (c) 2016, NXP Semiconductors.
 * All rights reserved.
 *
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted (subject to the limitations in the disclaimer below) provided
 *  that the following conditions are met:
 *
 * o Redistributions of source code must retain the above copyright notice, this list
 *   of conditions and the following disclaimer.
 *
 * o Redistributions in binary form must reproduce the above copyright notice, this
 *   list of conditions and the following disclaimer in the documentation and/or
 *   other materials provided with the distribution.
 *
 * o Neither the name of the copyright holder nor the names of its
 *   contributors may be used to endorse or promote products derived from this
 *   software without specific prior written permission.
 *
 * NO EXPRESS OR IMPLIED LICENSES TO ANY PARTY'S PATENT RIGHTS ARE GRANTED BY THIS LICENSE.
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
 * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
 * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>

//#include "FreeRTOS.h"

#include "fsl_common.h"
#include "fsl_debug_console.h"
#include "evk_fsl_tfa9894.h"
#include "evk_hal_registers.h"
#include "evk_TFA9894N1A1_Seltech_Demo.h"

//#define printf(...) configPRINTF((__VA_ARGS__))

/*
#ifndef PRINTF
#define PRINTF DbgConsole_Printf
#endif
#define TFA98XX_PRINT_DEBUG
#ifdef TFA98XX_PRINT_DEBUG
#define printf PRINTF
#endif
*/

#define TFA98XX_PATCH_EXTRA   6

uint8_t num_dev = TFA_MONO;

Tfa98xx_Registers_t OptimalSettingReg_Dev_prof0Reg[] =
{
#if 0 /* rev ID = 0x1a94 generated code start */
	{0x000f, 0xa245}, //POR=0x0245
	{0x020f, 0x5288}, //POR=0x83ca
	{0x520f, 0xbe17}, //POR=0x2828
	{0x560f, 0x05c3}, //POR=0x766a
	{0x570f, 0x0344}, //POR=0x545c
	{0x610f, 0x0032}, //POR=0x0010
	{0x710f, 0x00cf}, //POR=0x0080
	{0x720f, 0x34a9}, //POR=0x1afc
	{0x730f, 0x3808}, //POR=0x0018
	{0x760f, 0x0067},
	{0x800f, 0x0000}, //POR=0x0a9a
 	{0x810f, 0x5715}, //POR=0x0a8b
	{0x820f, 0x0104},
#else /* rev ID = 0x2a94 or 0x3a94 generated code start */
	{0x000f, 0xa245}, //POR=0x8245 
	{0x010f, 0x15da}, //POR=0x11ca 
	{0x020f, 0x51e8}, //POR=0x55c8 
	{0x520f, 0xbe17}, //POR=0xb617 
	{0x530f, 0x0dbe}, //POR=0x0d9e 
	{0x570f, 0x0344}, //POR=0x0366 
	{0x610f, 0x0033}, //POR=0x0073 
	{0x710f, 0x6ecf}, //POR=0x6f8d 
	{0x720f, 0x34a9}, //POR=0x44e8 
	{0x730f, 0x38c8}, //POR=0x3806 
	{0x760f, 0x0067}, //POR=0x0065 
	{0x800f, 0x0000}, //POR=0x0003 
	{0x810f, 0x5799}, //POR=0x561a 
	{0x820f, 0x0104}, //POR=0x0044 
#endif /* generated code end */
	{TFA2_BF_TDMNBCK,0},
	{TFA2_BF_TDMSLLN,15},
	{TFA2_BF_TDMSSIZE,15},
	{TFA2_BF_TDMSPKE,1},
	{TFA2_BF_TDMDCE,1},
	{TFA2_BF_TDMCSE,1},
	{TFA2_BF_TDMVSE,1},
	{TFA2_BF_TDMSPKS,0},
	{TFA2_BF_TDMDCS,1},
	{TFA2_BF_TDMCSS,0},
	{TFA2_BF_TDMVSS,1},
	{TFA2_BF_TDMCLINV, 1}, // Invert BCLK
	{TFA2_BF_FRACTDEL,20},
	{TFA2_BF_DCTRACK,1},
	{TFA2_BF_AMPGAIN,48},
	{TFA2_BF_DCHOLD,8},
	{ignore_flag_voutcomp86,0},
	{TFA2_BF_DCCV,3},
	{TFA2_BF_LVLCLPPWM,1},
	{cs_ktemp,21},
	{cs_ktemp2,28},
	{cs_adc_offset,4},
	{sel_clk_cs,0},
	{sel_pwm_delay_src,0},
	{TFA2_BF_DELCURCOMP,2},
	{TFA2_BF_HPFBYP,0},
	{volsense_pwm_sel,2},
	{cs_classd_tran_skip,1},
	{cs_adc_nortz,0},
	{TFA2_BF_TDMSPKG,4},
	{TFA2_BF_TDMDCG,4},
	{TFA2_BF_DCTRIP,9},
	{TFA2_BF_DCTRIP2,15},
	{TFA2_BF_DCTRIPT,13},
	{TFA2_BF_DCVOF,30},
	{TFA2_BF_DCVOS,63},
	{TFA2_BF_AUDFS,3},     // 3 = 16 KHz, default 8 = 48 KHz	
	{TFA2_BF_AMPE,1},
#ifdef FACTORY_CALIBRATION_ONLY
	{TFA2_BF_DCA,0},
	{TFA2_BF_AMPE,1},
	{TFA2_BF_TROS,1},
	{TFA2_BF_LPM1MODE,1},
	{TFA2_BF_LNMODE,1},
	{TFA2_BF_TROS,1},
	{TFA2_BF_EXTTS,25},
#endif //FACTORY_CALIBRATION_ONLY
	{TFA2_BF_CFE,1},
	{TFA2_BF_AMPC,1},
	{TFA2_BF_AMPINSEL,2},
	{TFA2_BF_DCINSEL,2},
	{TFA2_BF_EXTTS,25},
#ifdef BROWNOUT_DETECT_SUPPORT
	{TFA2_BF_BODE,1},
	{TFA2_BF_BODTHLVL,2},
	{TFA2_BF_MANROBOD,1},
#endif//BROWNOUT_DETECT_SUPPORT
	{0xffff, 0}
};

Tfa98xx_Registers_t OptimalSettingReg_Dev_bypassReg[] =
{
#if 0 /* rev ID = 0x1a94 generated code start */
	{0x000f, 0xa245}, //POR=0x0245
	{0x020f, 0x5288}, //POR=0x83ca
	{0x520f, 0xbe17}, //POR=0x2828
	{0x560f, 0x05c3}, //POR=0x766a
	{0x570f, 0x0344}, //POR=0x545c
 	{0x610f, 0x0032}, //POR=0x0010
	{0x710f, 0x00cf}, //POR=0x0080
	{0x720f, 0x34a9}, //POR=0x1afc
	{0x730f, 0x3808}, //POR=0x0018
	{0x760f, 0x0067},
	{0x800f, 0x0000}, //POR=0x0a9a
	{0x810f, 0x5715}, //POR=0x0a8b
	{0x820f, 0x0104},
#else /* rev ID = 0x2a94 or 0x3a94 generated code start */
	{0x000f, 0xa245}, //POR=0x8245 
	{0x010f, 0x15da}, //POR=0x11ca 
	{0x020f, 0x51e8}, //POR=0x55c8 
	{0x520f, 0xbe17}, //POR=0xb617 
	{0x530f, 0x0dbe}, //POR=0x0d9e 
	{0x570f, 0x0344}, //POR=0x0366 
	{0x610f, 0x0033}, //POR=0x0073 
	{0x710f, 0x6ecf}, //POR=0x6f8d 
	{0x720f, 0x34a9}, //POR=0x44e8 
	{0x730f, 0x38c8}, //POR=0x3806 
	{0x760f, 0x0067}, //POR=0x0065 
	{0x800f, 0x0000}, //POR=0x0003 
	{0x810f, 0x5799}, //POR=0x561a 
	{0x820f, 0x0104}, //POR=0x0044 
#endif /* generated code end */
	{TFA2_BF_TDMNBCK,0},
	{TFA2_BF_TDMSLLN,15},
	{TFA2_BF_TDMSSIZE,15},
	{TFA2_BF_TDMSPKE,1},
	{TFA2_BF_TDMDCE,1},
	{TFA2_BF_TDMCSE,1},
	{TFA2_BF_TDMVSE,1},
	{TFA2_BF_TDMSPKS,0},
	{TFA2_BF_TDMDCS,1},
	{TFA2_BF_TDMCSS,0},
	{TFA2_BF_TDMVSS,1},
	{TFA2_BF_TDMCLINV, 1}, // Invert BCLK
	{TFA2_BF_FRACTDEL,20},
	{TFA2_BF_DCTRACK,1},
	{TFA2_BF_AMPGAIN,48},
	{TFA2_BF_DCHOLD,8},
	{ignore_flag_voutcomp86,0},
	{TFA2_BF_DCCV,3},
	{TFA2_BF_LVLCLPPWM,1},
	{cs_ktemp,21},
	{cs_ktemp2,28},
	{cs_adc_offset,4},
	{sel_clk_cs,0},
	{sel_pwm_delay_src,0},
	{TFA2_BF_DELCURCOMP,2},
	{TFA2_BF_HPFBYP,0},
	{volsense_pwm_sel,2},
	{cs_classd_tran_skip,1},
	{cs_adc_nortz,0},
	{TFA2_BF_TDMSPKG,4},
	{TFA2_BF_TDMDCG,4},
	{TFA2_BF_DCTRIP,9},
	{TFA2_BF_DCTRIP2,15},
	{TFA2_BF_DCTRIPT,13},
	{TFA2_BF_DCVOF,30},
	{TFA2_BF_DCVOS,63},
	{TFA2_BF_AUDFS,3},     // 3 = 16 KHz, default 8 = 48 KHz	
	{TFA2_BF_AMPE,1},
	{TFA2_BF_DCA,1},
	{TFA2_BF_AMPINSEL,0},
	{TFA2_BF_DCINSEL,0},
	{TFA2_BF_HPFBYP,1},
	{TFA2_BF_CFE,0},
	{TFA2_BF_AMPC,0},
#ifdef BROWNOUT_DETECT_SUPPORT
	{TFA2_BF_BODE,1},
	{TFA2_BF_BODTHLVL,2},
	{TFA2_BF_MANROBOD,1},
#endif//BROWNOUT_DETECT_SUPPORT
	{0xffff, 0}
};

int TFA9894_Init_Bypass(void)
{
	uint8_t device_count = 0;
	const uint16_t devs[] ={LEFT_AMP,RIGHT_AMP};
	uint16_t regRead=0,xor = 0;
	Tfa9890_Error_t error = Error_Ok;
	Tfa98xx_Registers_t *pRegs = NULL;

	for (device_count = 0; device_count < num_dev; device_count++)
	{
#if 0
		/* Read Device ID TFA9894 == 0x1a94 */
		error = read_register(devs[device_count], 0x03, &regRead);
		if(regRead != 0x1a94)
			error = Error_I2C_Fatal;
#else
		/* Read Device ID TFA9894 == 0x3a94 */
		error = read_register(devs[device_count], 0x03, &regRead);
		if(regRead != 0x3a94)
			error = Error_I2C_Fatal;
#endif
		assert(error == Error_Ok);
		/* Write read test */
		error = write_register(devs[device_count], 0x0F, (uint16_t)0x5A6B);
		assert(error == Error_Ok);
		error = read_register(devs[device_count], 0x0f, &regRead);
		if(regRead != 0x5A6B)
			error = Error_I2C_Fatal;
		assert(error == Error_Ok);
		pRegs = OptimalSettingReg_Dev_bypassReg;
		/*************************/
		error=tfa98xx_set_bf_value(devs[device_count],TFA2_BF_I2CR,1,&regRead);
		error=tfa98xx_write_reg(devs[device_count],TFA2_BF_I2CR,regRead);
		assert(error == Error_Ok);
		error = tfa_set_bf_tfa98xx(devs[device_count],TFA2_BF_MANSCONF,0);
		assert(error == Error_Ok);
		error = tfa_set_bf_tfa98xx(devs[device_count],TFA2_BF_MANCOLD,1);
		assert(error == Error_Ok);
		error = tfa_set_bf_tfa98xx(devs[device_count],TFA2_BF_RST,1);
		assert(error == Error_Ok);

		/* Unlock keys to write settings */
		error = write_register(devs[device_count], 0x0F, (uint16_t)0x5A6B);
		assert(error == Error_Ok);
		error = read_register(devs[device_count], 0xFB,&regRead);
		assert(error == Error_Ok);
		xor = regRead ^ 0x005A;
		error = write_register(devs[device_count], 0xA0, xor);
		while(pRegs->reg != 0xffff) {
			error = tfa_set_bf_tfa98xx(devs[device_count], pRegs->reg, pRegs->val);
			assert(error == Error_Ok);
			pRegs += 1;
		}

		error = tfa_set_bf_tfa98xx(devs[device_count],TFA2_BF_PWDN,0);
		assert(error == Error_Ok);
		error = tfa_set_bf_tfa98xx(devs[device_count],TFA2_BF_MANSCONF,1);
		assert(error == Error_Ok);
		error = tfa_set_bf_tfa98xx(devs[device_count],TFA2_BF_SBSL,1);
		assert(error == Error_Ok);
	}
	return (int)error;
}

int TFA9894_Init_Generic(void)
{
	uint8_t trial = 10,device_count=0;
	const uint16_t devs[] ={LEFT_AMP,RIGHT_AMP};
	uint16_t regRead=0,xor = 0;
	uint32_t status;
	Tfa9890_Error_t error = Error_Ok;;
	int calibrateDone[] = {0};
	float re25;
	int i;
	Tfa98xx_Registers_t *pRegs = NULL;
#ifdef TFA_ENABLE_LIVEDATA_CAPTURE
	float live_data[150] = {0};
#endif
	for (device_count=0;device_count<1;device_count++)
	{
#if 0
		/* Read Device ID TFA9894 == 0x1a94 */
		error = read_register(devs[device_count], 0x03, &regRead);
		if(regRead != 0x1a94)
			error = Error_I2C_Fatal;
#else
		/* Read Device ID TFA9894 == 0x3a94 */
		error = read_register(devs[device_count], 0x03, &regRead);
		if(regRead != 0x3a94)
			error = Error_I2C_Fatal;
#endif
		assert(error == Error_Ok);

		pRegs = OptimalSettingReg_Dev_prof0Reg;
		/*************************/
		error=tfa98xx_set_bf_value(devs[device_count],TFA2_BF_I2CR,1,&regRead);
		error=tfa98xx_write_reg(devs[device_count],TFA2_BF_I2CR,regRead);
		assert(error == Error_Ok);
		error = tfa_set_bf_tfa98xx(devs[device_count],TFA2_BF_MANSCONF,0);
		assert(error == Error_Ok);
		error = tfa_set_bf_tfa98xx(devs[device_count],TFA2_BF_MANCOLD,1);
		assert(error == Error_Ok);
		error = tfa_set_bf_tfa98xx(devs[device_count],TFA2_BF_RST,1);
		assert(error == Error_Ok);

		/* Unlock keys to write settings */
		error = write_register(devs[device_count], 0x0F, (uint16_t)0x5A6B);
		assert(error == Error_Ok);
		error = read_register(devs[device_count], 0xFB,&regRead);
		assert(error == Error_Ok);
		xor = regRead ^ 0x005A;
		error = write_register(devs[device_count], 0xA0, xor);
		assert(error == Error_Ok);
		while(pRegs->reg != 0xffff) {
			error = tfa_set_bf_tfa98xx(devs[device_count], pRegs->reg, pRegs->val);
			assert(error == Error_Ok);
			pRegs += 1;
		}
		error = tfa_set_bf_tfa98xx(devs[device_count],TFA2_BF_MANSCONF,1);
		tfa_updown_tfa98xx(devs[device_count],0);
		/* Check the PLL is powered up from status register 10h*/
		read_register(devs[device_count], 0x10,&regRead);
		while ( (regRead & 0x2000) == 0)
		{
			read_register(devs[device_count], 0x10,&regRead);
		}

		/*************Force Coldstart*************/
		while (tfa_get_bf_tfa98xx(devs[device_count], TFA2_BF_ACS)!= 1) {
			/*******************************************/
			error = tfa98xx_dsp_write_mem_word_tfa98xx(devs[device_count], 0x8100, 1, DMEM_IOMEM);
			/*****************************************************/
			if (trial-- == 0) {
				return 1;
			}
		}
		assert(error == Error_Ok);
		for ( trial=1; trial < 10; trial++ ) {
			error = tfa98xx_dsp_stability_check(devs[device_count], &status);
			if ( status )
				break;
			else
				for(i=0;i<0xfff;i++);//	Sleep(10);
		}
		if (trial >=10)
		{
			printf("Timed out , exit, exit\r\n");
			return 1;
		}
		else {
			//printf(" OK (trial=%d)\r\n", trial);
                }

#ifdef FACTORY_CALIBRATION_ONLY
		ClearOneTimeCalibration(devs[device_count]);
		SetOneTimeCalibration(devs[device_count]);
#else
		ClearOneTimeCalibration(devs[device_count]);
#endif//
		error = checkICROMversion(devs[device_count], Patch_patch);
		assert(error == Error_Ok);
		//printf("SC:%x PATCH loading Start--length to be  loaded:%d\r\n",devs[device_count],Patch_patch_len - TFA98XX_PATCH_EXTRA );
		error = processPatchFile(devs[device_count], Patch_patch_len-6, Patch_patch + TFA98XX_PATCH_EXTRA);
		assert(error == Error_Ok);
		//printf("FRACTDEL_after211 :%d",tfa_get_bf_tfa98xx(devs[device_count], TFA2_BF_FRACTDEL));
		//printf(" PATCH OK \r\n");
		error = tfa98xx_dsp_write_mem_word_tfa98xx(devs[device_count], 512, 0, DMEM_XMEM);
		assert(error == Error_Ok);
		error = tfa_set_bf_tfa98xx(devs[device_count],TFA2_BF_RST,0);
		assert(error == Error_Ok);
		//printf("FRACTDEL_after222 :%d",tfa_get_bf_tfa98xx(devs[device_count], TFA2_BF_FRACTDEL));
		error = tfa_mute_tfa98xx(devs[device_count],Mute_Digital);
		assert(error == Error_Ok);
		//printf("SC:%x Message loading Start--length to be  loaded:%d\r\n",devs[device_count],Left_SetInputSelector_msg_len );
		error = tfa_dsp_msg_tfa98xxx(devs[device_count], Left_SetInputSelector_msg_len, (const char *)Left_SetInputSelector_msg);
		assert(error == Error_Ok);
		//printf("MessageOk1\r\n");

		//printf("SC:%x Message loading Start--length to be  loaded:%d\r\n",devs[device_count],SetOutputSelector_msg_len );
		error = tfa_dsp_msg_tfa98xxx(devs[device_count], SetOutputSelector_msg_len, (const char *)SetOutputSelector_msg);
		assert(error == Error_Ok);
		//printf("MessageOk2\r\n");

		//printf("SC:%x Message loading Start--length to be  loaded:%d\r\n",devs[device_count],SetProgramConfig_msg_len );
		error = tfa_dsp_msg_tfa98xxx(devs[device_count], SetProgramConfig_msg_len, (const char *)SetProgramConfig_msg);
		assert(error == Error_Ok);
		//printf("MessageOk3\r\n");

		//printf("SC:%x Message loading Start--length to be  loaded:%d\r\n",devs[device_count],SetLagW_msg_len );
		error = tfa_dsp_msg_tfa98xxx(devs[device_count], SetLagW_msg_len, (const char *)SetLagW_msg );
		assert(error == Error_Ok);
		//printf("MessageOk4\r\n");
		/*****************/
		//printf("SC:%x Speaker loading Start--length to be  loaded:%d\r\n",devs[device_count],Speaker_speaker_len);
		error = tfa_dsp_msg_tfa98xxx(devs[device_count], Speaker_speaker_len, (const char *)Speaker_speaker);
		assert(error == Error_Ok);
		//printf("SpeakerOk\r\n");
		/*********************/
#ifdef FACTORY_CALIBRATION_ONLY  
		error = tfaContWriteVstepMax2_tfa98xx(devs[device_count],(nxpTfaVolumeStepMax2FileTfa98xx_t *)Calibration_vstep,0, TFA_MAX_VSTEP_MSG_MARKER);
#else
		error = tfaContWriteVstepMax2_tfa98xx(devs[device_count],(nxpTfaVolumeStepMax2FileTfa98xx_t *)Left_vstep,0, TFA_MAX_VSTEP_MSG_MARKER);
#endif//
		assert(error == Error_Ok);
		//printf("VSTEPOk\r\n");
		/****************************/
		//printf("SC:%x Message loading Start--length to be  loaded:%d\r\n",devs[device_count],SetGains_msg_len );
		error = tfa_dsp_msg_tfa98xxx(devs[device_count], SetGains_msg_len, (const char *)SetGains_msg);
		assert(error == Error_Ok);
		//printf("MessageOk9\r\n");

		//printf("SC:%x Message loading Start--length to be  loaded:%d\r\n",devs[device_count],SetSensesDelay_msg_len );
		error = tfa_dsp_msg_tfa98xxx(devs[device_count], SetSensesDelay_msg_len, (const char *)SetSensesDelay_msg);
		assert(error == Error_Ok);
		//printf("MessageOk10\r\n");

		//printf("SC:%x Message loading Start--length to be  loaded:%d\r\n",devs[device_count],SetSensesCal_msg_len );
		error = tfa_dsp_msg_tfa98xxx(devs[device_count], SetSensesCal_msg_len, (const char *)SetSensesCal_msg );
		assert(error == Error_Ok);
		//printf("MessageOk11\r\n");

		//printf("SC:%x Message loading Start--length to be  loaded:%d\r\n",devs[device_count],SetvBatFactors_msg_len );
		error = tfa_dsp_msg_tfa98xxx(devs[device_count], SetvBatFactors_msg_len, (const char *)SetvBatFactors_msg);
		assert(error == Error_Ok);
		//printf("MessageOk12\r\n");

		//printf("SC:%x Message loading Start--length to be  loaded:%d\r\n",devs[device_count], Left_excursion_filter_msg_len );
		error = tfa_dsp_msg_tfa98xxx(devs[device_count], Left_excursion_filter_msg_len, (const char *)Left_excursion_filter_msg );
		assert(error == Error_Ok);
		//printf("MessageOk15\r\n");

		error = tfa_set_bf_tfa98xx(devs[device_count],TFA2_BF_PWDN,0);
		assert(error == Error_Ok);
		error = tfa_set_bf_tfa98xx(devs[device_count],TFA2_BF_MANSCONF,1);
		assert(error == Error_Ok);
		error = tfa_set_bf_tfa98xx(devs[device_count],TFA2_BF_SBSL,1);
		assert(error == Error_Ok);
		error = tfa_mute_tfa98xx(devs[device_count],Mute_Off);

#if defined(TFA98XX_PRINT_DEBUG)
		read_register(devs[device_count], 0x10, &regRead);
		PRINTF("Status reg 0x10 = 0x%04x\r\r\n", regRead);
		read_register(devs[device_count], 0x11, &regRead);
		PRINTF("Status reg 0x11 = 0x%04x\r\r\n", regRead);
		read_register(devs[device_count], 0x12, &regRead);
		PRINTF("Status reg 0x12 = 0x%04x\r\r\n", regRead);
		read_register(devs[device_count], 0x13, &regRead);
		PRINTF("Status reg 0x13 = 0x%04x\r\r\n", regRead);
#endif
		assert(error == Error_Ok);
		error = tfa98xxRunWaitCalibration(devs[device_count], calibrateDone + device_count);
		if(error != Error_Ok) {
			PRINTF("Calibration Fail [%x]\r\r\n", error);
			return 0;
		}
		assert(error == Error_Ok);
		
		if (calibrateDone[device_count])
		{
			error = tfa98xxdsp_get_calibration_impedance(devs[device_count],&re25);
			assert(error == Error_Ok);
		}
		else
		{
			re25 = 0;
		}
		printf("TFA9894 0x%02X Calibration value is %2.2f mohm\r\n", devs[device_count], re25);
		error = tfa_set_bf_tfa98xx(devs[device_count],TFA2_BF_OPENMTP,0);
		printf("MTPOTC :%d -- MTPEX:%d:--TFA2_BF_OPENMTP:%d\r\n", tfa_get_bf_tfa98xx(devs[device_count],TFA2_BF_MTPOTC),tfa_get_bf_tfa98xx(devs[device_count],TFA2_BF_MTPEX),tfa_get_bf_tfa98xx(devs[device_count],TFA2_BF_OPENMTP));
	}
#ifdef TFA_VERIFY_POWERDOWN_WARM_START
	Sleep(10000);
	for (device_count=0;device_count<2;device_count++)
		tfa_updown_tfa98xx(devs[device_count],1);
	Sleep(10000);
	for (device_count=0;device_count<2;device_count++)
		tfa_updown_tfa98xx(devs[device_count],0);
#endif//TFA_VERIFY_POWERDOWN_WARM_START
#ifdef TFA_ENABLE_LIVEDATA_CAPTURE
	for (device_count=0;device_count<2;device_count++)
		for (cnt=0;cnt<20;cnt++)
		{
			error = tfa_dsp_msg_tfa98xxx(devs[device_count], setmemtrack_mt_len, setmemtrack_mt);
			assert(error == Error_Ok);
			tfa98xxRetrieveLiveData(devs[device_count],live_data);
			Sleep(500);
		}
#endif//TFA_ENABLE_LIVEDATA_CAPTURE
	return (int)error;
}
