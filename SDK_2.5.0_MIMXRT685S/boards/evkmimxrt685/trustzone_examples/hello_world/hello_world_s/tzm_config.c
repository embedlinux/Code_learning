/*
 * Copyright 2018 NXP
 *
 * SPDX-License-Identifier: BSD-3-Clause
 */

#include "fsl_common.h"
#include "tzm_config.h"

 /*******************************************************************************
 * Variables
 ******************************************************************************/
#if defined(__MCUXPRESSO)
extern unsigned char _start_sg[];
#endif
/*!
 * @brief TrustZone initialization
 *
 * SAU Configuration
 * This function configures 5 regions:
 * 0x000C0000 - 0x001BFFFF - non-secure SRAM for code execution
 * 0x08100000 - 0x08200000 - non-secure QSPI FLASH for code execution
 * 0x100BFE00 - 0x100BFFFF - secure, non-secure callable SRAM for veneer table
 * 0x180FFE00 - 0x180FFFFF - secure, non-secure callable QSPI FLASH for veneer table
 * 0x00200000 - 0x002FFFFF - non-secure SRAM for data
 *
 * AHB secure controller settings
 * After RESET all memories and peripherals are set to user:non-secure access
 * This function configures following memories and peripherals as secure:
 * 0x20080000 - 0x200BFFFF - SRAM memory for secure code execution
 * 0x201C0000 - 0x201FFFFF - SRAM memory for secure data
 * 0x08000000 - 0x08100000 - QSPI FLASH memory for secure code execution
 *
 * Secure peripherals: SYSCON, IOPCTL, FLEXCOMM0
 * NOTE: This example configures necessary peripherals for this example. 
 *       User should configure all peripherals, which shouldn't be accessible
 *       from normal world.
*/
void BOARD_InitTrustZone()
{
     /* Disable SAU */
    SAU->CTRL = 0U;
    
    /* Configure SAU region 0 - Non-secure RAM for CODE execution*/
    /* Set SAU region number */
    SAU->RNR = 0;
    /* Region base address */   
    SAU->RBAR = (CODE_START_NS & SAU_RBAR_BADDR_Msk);
    /* Region end address */
    SAU->RLAR = ((CODE_START_NS + CODE_SIZE_NS-1) & SAU_RLAR_LADDR_Msk) | 
                 /* Region memory attribute index */
                 ((0U << SAU_RLAR_NSC_Pos) & SAU_RLAR_NSC_Msk) |
                 /* Enable region */
                 ((1U << SAU_RLAR_ENABLE_Pos) & SAU_RLAR_ENABLE_Msk); 
    
    /* Configure SAU region 1 - Non-secure RAM for DATA */
    /* Set SAU region number */
    SAU->RNR = 1;
    /* Region base address */   
    SAU->RBAR = (DATA_START_NS & SAU_RBAR_BADDR_Msk);
    /* Region end address */
    SAU->RLAR = ((DATA_START_NS + DATA_SIZE_NS-1) & SAU_RLAR_LADDR_Msk) | 
                 /* Region memory attribute index */
                 ((0U << SAU_RLAR_NSC_Pos) & SAU_RLAR_NSC_Msk) |
                 /* Enable region */
                 ((1U << SAU_RLAR_ENABLE_Pos) & SAU_RLAR_ENABLE_Msk); 
    
    /* Configure SAU region 2 - Non-secure callable RAM for CODE veneer table*/
    /* Set SAU region number */
    SAU->RNR = 2;
    /* Region base address */   
    SAU->RBAR = (CODE_START_NSC & SAU_RBAR_BADDR_Msk);
    /* Region end address */
    SAU->RLAR = ((CODE_START_NSC + CODE_SIZE_NSC-1) & SAU_RLAR_LADDR_Msk) | 
                 /* Region memory attribute index */
                 ((1U << SAU_RLAR_NSC_Pos) & SAU_RLAR_NSC_Msk) |
                 /* Enable region */
                 ((1U << SAU_RLAR_ENABLE_Pos) & SAU_RLAR_ENABLE_Msk); 

    /* Configure SAU region 3 - Non-secure FLASH for CODE execution*/
    /* Set SAU region number */
    SAU->RNR = 3;
    /* Region base address */
    SAU->RBAR = (CODE_FLASH_START_NS & SAU_RBAR_BADDR_Msk);
    /* Region end address */
    SAU->RLAR = ((CODE_FLASH_START_NS + CODE_FLASH_SIZE_NS-1) & SAU_RLAR_LADDR_Msk) | 
                 /* Region memory attribute index */
                 ((0U << SAU_RLAR_NSC_Pos) & SAU_RLAR_NSC_Msk) |
                 /* Enable region */
                 ((1U << SAU_RLAR_ENABLE_Pos) & SAU_RLAR_ENABLE_Msk); 
    
    /* Configure SAU region 4 - Non-secure callable FLASH for CODE veneer table*/
    /* Set SAU region number */
    SAU->RNR = 4;
    /* Region base address */   
#if defined(__MCUXPRESSO)
    SAU->RBAR = ((uint32_t)&_start_sg & SAU_RBAR_BADDR_Msk);
#else
    SAU->RBAR = (CODE_FLASH_START_NSC & SAU_RBAR_BADDR_Msk);
#endif
    /* Region end address */
#if defined(__MCUXPRESSO)
    SAU->RLAR = (((uint32_t)&_start_sg + CODE_FLASH_SIZE_NSC-1) & SAU_RLAR_LADDR_Msk) |
                 /* Region memory attribute index */
                 ((1U << SAU_RLAR_NSC_Pos) & SAU_RLAR_NSC_Msk) |
                 /* Enable region */
                 ((1U << SAU_RLAR_ENABLE_Pos) & SAU_RLAR_ENABLE_Msk);
#else
    SAU->RLAR = ((CODE_FLASH_START_NSC + CODE_FLASH_SIZE_NSC-1) & SAU_RLAR_LADDR_Msk) | 
                 /* Region memory attribute index */
                 ((1U << SAU_RLAR_NSC_Pos) & SAU_RLAR_NSC_Msk) |
                 /* Enable region */
                 ((1U << SAU_RLAR_ENABLE_Pos) & SAU_RLAR_ENABLE_Msk); 
#endif
    
    /* Force memory writes before continuing */
    __DSB();
    /* Flush and refill pipeline with updated permissions */
    __ISB();     
    /* Enable SAU */
    SAU->CTRL = 1U;  

    /*Configuration of AHB Secure Controller 
     * Possible values for every memory sector or peripheral rule: 
     *  0b00    Non-secure and Non-priviledge user access allowed.
     *  0b01    Non-secure and Privilege access allowed.
     *  0b10    Secure and Non-priviledge user access allowed.
     *  0b11    Secure and Priviledge user access allowed. */
    
    /* Memory settings for user non-secure access (0x0U) is mentioned for completness only. It is default RESET value. */  
    /* QSPI FLASH memory configuration from 0x08000000 to 0x0FFFFFFF, sector size is 1MB */
    AHB_SECURE_CTRL->QSPI[0].QSPI0_MEM_RULE[0] = 0x00000003U;
    AHB_SECURE_CTRL->QSPI[0].QSPI0_MEM_RULE[1] = 0x00000000U;
    AHB_SECURE_CTRL->QSPI[0].QSPI0_MEM_RULE[2] = 0x00000000U;
    AHB_SECURE_CTRL->QSPI[0].QSPI0_MEM_RULE[3] = 0x00000000U;

    /* SRAM memory configuration from 0x20080000 to 0x200FFFFF, sector size is 4kB */ 
    AHB_SECURE_CTRL->RAM12_15[0].RAM12_MEM_RULE[0] = 0x33333333U;
    AHB_SECURE_CTRL->RAM12_15[0].RAM12_MEM_RULE[1] = 0x33333333U;
    AHB_SECURE_CTRL->RAM12_15[0].RAM12_MEM_RULE[2] = 0x33333333U;
    AHB_SECURE_CTRL->RAM12_15[0].RAM12_MEM_RULE[3] = 0x33333333U;
    AHB_SECURE_CTRL->RAM12_15[0].RAM13_MEM_RULE[0] = 0x33333333U;
    AHB_SECURE_CTRL->RAM12_15[0].RAM13_MEM_RULE[1] = 0x33333333U;
    AHB_SECURE_CTRL->RAM12_15[0].RAM13_MEM_RULE[2] = 0x33333333U;
    AHB_SECURE_CTRL->RAM12_15[0].RAM13_MEM_RULE[3] = 0x33333333U;
    AHB_SECURE_CTRL->RAM12_15[0].RAM14_MEM_RULE[0] = 0x00000000U;
    AHB_SECURE_CTRL->RAM12_15[0].RAM14_MEM_RULE[1] = 0x00000000U;
    AHB_SECURE_CTRL->RAM12_15[0].RAM14_MEM_RULE[2] = 0x00000000U;
    AHB_SECURE_CTRL->RAM12_15[0].RAM14_MEM_RULE[3] = 0x00000000U;
    AHB_SECURE_CTRL->RAM12_15[0].RAM15_MEM_RULE[0] = 0x00000000U;
    AHB_SECURE_CTRL->RAM12_15[0].RAM15_MEM_RULE[1] = 0x00000000U;
    AHB_SECURE_CTRL->RAM12_15[0].RAM15_MEM_RULE[2] = 0x00000000U;
    AHB_SECURE_CTRL->RAM12_15[0].RAM15_MEM_RULE[3] = 0x00000000U;
    
    /* SRAM memory configuration from 0x20100000 to 0x201FFFFF, sector size is 8kB */ 
    AHB_SECURE_CTRL->RAM16_19[0].RAM16_MEM_RULE[0] = 0x00000000U;
    AHB_SECURE_CTRL->RAM16_19[0].RAM16_MEM_RULE[1] = 0x00000000U;
    AHB_SECURE_CTRL->RAM16_19[0].RAM16_MEM_RULE[2] = 0x00000000U;
    AHB_SECURE_CTRL->RAM16_19[0].RAM16_MEM_RULE[3] = 0x00000000U;
    AHB_SECURE_CTRL->RAM16_19[0].RAM17_MEM_RULE[0] = 0x00000000U;
    AHB_SECURE_CTRL->RAM16_19[0].RAM17_MEM_RULE[1] = 0x00000000U;
    AHB_SECURE_CTRL->RAM16_19[0].RAM17_MEM_RULE[2] = 0x00000000U;
    AHB_SECURE_CTRL->RAM16_19[0].RAM17_MEM_RULE[3] = 0x00000000U;
    AHB_SECURE_CTRL->RAM16_19[0].RAM18_MEM_RULE[0] = 0x00000000U;
    AHB_SECURE_CTRL->RAM16_19[0].RAM18_MEM_RULE[1] = 0x00000000U;
    AHB_SECURE_CTRL->RAM16_19[0].RAM18_MEM_RULE[2] = 0x00000000U;
    AHB_SECURE_CTRL->RAM16_19[0].RAM18_MEM_RULE[3] = 0x00000000U;
    AHB_SECURE_CTRL->RAM16_19[0].RAM19_MEM_RULE[0] = 0x33333333U;
    AHB_SECURE_CTRL->RAM16_19[0].RAM19_MEM_RULE[1] = 0x33333333U;
    AHB_SECURE_CTRL->RAM16_19[0].RAM19_MEM_RULE[2] = 0x33333333U;
    AHB_SECURE_CTRL->RAM16_19[0].RAM19_MEM_RULE[3] = 0x33333333U;
    
    /* SRAM memory configuration from 0x20200000 to 0x202FFFFF, sector size is 8kB */ 
    AHB_SECURE_CTRL->RAM20_23[0].RAM20_MEM_RULE[0] = 0x00000000U;
    AHB_SECURE_CTRL->RAM20_23[0].RAM20_MEM_RULE[1] = 0x00000000U;
    AHB_SECURE_CTRL->RAM20_23[0].RAM20_MEM_RULE[2] = 0x00000000U;
    AHB_SECURE_CTRL->RAM20_23[0].RAM20_MEM_RULE[3] = 0x00000000U;
    AHB_SECURE_CTRL->RAM20_23[0].RAM21_MEM_RULE[0] = 0x00000000U;
    AHB_SECURE_CTRL->RAM20_23[0].RAM21_MEM_RULE[1] = 0x00000000U;
    AHB_SECURE_CTRL->RAM20_23[0].RAM21_MEM_RULE[2] = 0x00000000U;
    AHB_SECURE_CTRL->RAM20_23[0].RAM21_MEM_RULE[3] = 0x00000000U;
    AHB_SECURE_CTRL->RAM20_23[0].RAM22_MEM_RULE[0] = 0x00000000U;
    AHB_SECURE_CTRL->RAM20_23[0].RAM22_MEM_RULE[1] = 0x00000000U;
    AHB_SECURE_CTRL->RAM20_23[0].RAM22_MEM_RULE[2] = 0x00000000U;
    AHB_SECURE_CTRL->RAM20_23[0].RAM22_MEM_RULE[3] = 0x00000000U;
    AHB_SECURE_CTRL->RAM20_23[0].RAM23_MEM_RULE[0] = 0x00000000U;
    AHB_SECURE_CTRL->RAM20_23[0].RAM23_MEM_RULE[1] = 0x00000000U;
    AHB_SECURE_CTRL->RAM20_23[0].RAM23_MEM_RULE[2] = 0x00000000U;
    AHB_SECURE_CTRL->RAM20_23[0].RAM23_MEM_RULE[3] = 0x00000000U;
    
    /* Set SYSCTL0/1, CLKCTL0/1, RSTCTRL0/1 and IOPCTL as secure */
    AHB_SECURE_CTRL->APB_BRIDGE[0].APB_GRP0_MEM_RULE0 = AHB_SECURE_CTRL_APB_BRIDGE_APB_GRP0_MEM_RULE0_RSTCTL0_RULE0(0x3U) | AHB_SECURE_CTRL_APB_BRIDGE_APB_GRP0_MEM_RULE0_CLKCTL0_RULE1(0x3U) |
                                                                               AHB_SECURE_CTRL_APB_BRIDGE_APB_GRP0_MEM_RULE0_SYSCTL0_RULE2(0x3U) | AHB_SECURE_CTRL_APB_BRIDGE_APB_GRP0_MEM_RULE0_IOPCTL_RULE4(0x3U);
    AHB_SECURE_CTRL->APB_BRIDGE[0].APB_GRP1_MEM_RULE0 = AHB_SECURE_CTRL_APB_BRIDGE_APB_GRP1_MEM_RULE0_RSTCTL1_RULE0(0x3U) | AHB_SECURE_CTRL_APB_BRIDGE_APB_GRP1_MEM_RULE0_CLKCTL1_RULE1(0x3U) |
                                                                               AHB_SECURE_CTRL_APB_BRIDGE_APB_GRP1_MEM_RULE0_SYSCTL1_RULE2(0x3U);      
    /* Set FLEXCOMM0 as secure */
    AHB_SECURE_CTRL->AHB_PERIPH0[0].SLAVE_RULE0 = AHB_SECURE_CTRL_AHB_PERIPH0_SLAVE_RULE0_FLEXCOMM0_RULE3(0x3U);
    
    /* Enable AHB secure controller check and lock all rule registers */
    AHB_SECURE_CTRL->MISC_CTRL_DP_REG = (AHB_SECURE_CTRL->MISC_CTRL_DP_REG & ~(AHB_SECURE_CTRL_MISC_CTRL_DP_REG_WRITE_LOCK_MASK | 
                                                                               AHB_SECURE_CTRL_MISC_CTRL_DP_REG_ENABLE_SECURE_CHECKING_MASK)) |
                                        AHB_SECURE_CTRL_MISC_CTRL_DP_REG_WRITE_LOCK(0x1U) |
                                        AHB_SECURE_CTRL_MISC_CTRL_DP_REG_ENABLE_SECURE_CHECKING(0x1U);
}
