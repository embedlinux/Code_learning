//************************************************************************************************
// File Name : reg_top.v
// Project   : ISA8201
// Author    : zhangxiaoliang
// Date      : 2015-08-19
// Description : 
//      This module is spi reg_top.
//
// Revision History:
//       Ver1.0   2015-08-19  Initial Version for ISA8201
//         v2.0   2015-8-21   change by reg map
//          v3    2015-9-8             add reg
//************************************************************************************************
`timescale 100ps/10ps

module reg_top (
                           
input                   rst                    ,
input                   cpol                   ,
input                   cpha                   ,         
input                   clk                    ,
input                   sys_idle               ,
input                   fval                   ,
input                   spi_clk                ,
input                   spi_en                 ,
input                   spi_in                 ,
output                  spi_out                ,            
//                                               ,
output  [7:0]           readonly_0             ,        
output  [7:0]           readonly_1             ,        
output  [7:0]           readonly_2             ,        
output  [7:0]           readonly_3             ,        
output  [7:0]           readonly_4             ,        
output                  PGA_PD                 ,              
output                  PGA_EN_AZ              ,              
output  [3:0]           PGA_GAIN               ,        
              
output                  PGA_EN_PH_OS    ,              
output                  PGA_EN_BLK_SUN_SPI         ,              
output  [2:0]           PGA_BLK_SUN_REF        ,        
output                  PIXEL_PD               ,              
output                  PIXEL_PRECH_EN         ,
output                  PIXEL_EN_VHVL          ,              
output  [7:0]           PGA_OFFSET_TRIM        ,        
output                  PLL_BYPASS             ,              
output  [2:0]           PLL_ICP                ,        
output  [1:0]           PLL_LOAD               ,        
output                  PLL_TE                 ,              
output                  PLL_PD                 ,              
output  [2:0]           PLL_REFDIV             ,        
output  [1:0]           PLL_RANGE              ,        
output  [7:0]           PLL_FBDIV              ,        
output  [7:0]           PLL_OUTDIV             ,
output                  PLL_COUNT_CLK          ,        
output                  LVDS_PD                ,              
output                  BIT_MODE               ,              
output                  SP_MODE                ,              
output                  LVDS_VCR_SEL           ,              
output                  LVSD_IBIAS_SEL         ,              
output                  LVDS_TRAINE            ,              
output                  LVDS_TSTE              ,              
output  [35:0]          LVDS_DLTRM             ,                                                                          
output  [1:0]           LVDS_CLK_SEL           ,        
output  [1:0]           LVDS_OUT_M             ,        
output  [17:0]          LVDS_CH_EN             ,                                            
output                  ADC_PD                 ,              
output                  ADC_COMP_RST_EN        ,              
output  [2:0]           ADC_I_COL_TRIM         ,        
output  [2:0]           ADC_I_PIX_TRIM         ,        
output  [1:0]           ADC_STORE_SEL          ,        
output  [12:0]          ADC_D_RST              ,                             
output                  ADC_DIG_TP             ,              
output                  ADC_VREF_EXT_EN        ,              
output                  ADC_I_EXT_EN           ,              
              
output  [6:0]           ADC_RGE_VCMCTRL        ,        
output                  ADC_RGE_PD             ,              
output  [1:0]           ADC_RGE_TESTCTRL       ,        
output  [11:0]          ADC_RGE_GAINCTRL       ,                                      
         
output  [1:0]           ADC_GAIN_TRIM          ,        
output                  ROWDEC_CS_SEL          ,              
output                  BG_PD                  ,              
output  [5:0]           BG_TRIM_CURVE          ,        
output  [3:0]           BG_TRIM_V              ,        
output  [3:0]           BG_TRIM_PPC            ,        
output  [3:0]           BG_TESTCTRL            ,        
             
output  [7:0]           TS_DINI                ,        
output  [2:0]           TS_IT                  ,        
output  [4:0]           TS_BGVT                ,        
output  [5:0]           TS_RAMP_TRIM           ,        
output                  TS_SEL_CHOP            ,
output                  TS_PD                  ,              
output  [1:0]           TS_TCTL                ,    
output                  CPNEG_TX_PD            ,
output  [1:0]           CPN_TEST_TX            ,
output  [2:0]           CPN_TX_TRIM            ,
output                  CPNEG_S1S2_PD          ,
output  [1:0]           CPN_TEST_S1S2          ,
output  [2:0]           CPN_S1S2_TRIM          ,
output                  CPPOS_PD               ,
output                  LDO_PD                 ,
output  [1:0]           CPPOS_TEST             ,
output  [2:0]           CPPOS_TRIM   ,
output  [3:0]           LDO_VREF_TRIM          ,
    
//                                               ,
output  [2:0]           sel_par_en             ,
output                  monitor_do_en          ,
output                  monitor_dig_en         ,
output                  frame_request          ,
output  [15:0]          nu_of_frame            ,
output                  exp_ext                ,
output  [26:0]          exp_time               ,
output  [1:0]           a_step                 ,
output  [26:0]          exp_step               ,
output  [2:0]           exp_seq                ,
output                  en_hdr_mode            ,
output                  en_hdr_gain_mode       ,
output  [12:0]          gain_2                 ,
output  [12:0]          gain_3                 ,
output  [12:0]          gain_4                 ,
output  [12:0]          gain_5                 ,
output  [12:0]          gain_6                 ,
output  [12:0]          gain_7                 ,
output  [12:0]          gain_8                 ,
output  [1:0]           size_ctrl              ,
output                  black_en               ,
output                  black_val_en           ,
output                  r_mirror               ,
output  [12:0]          num_lines              ,
output  [12:0]          start1                 ,
output  [12:0]          num_lines1             ,
output  [12:0]          start2                 ,
output  [12:0]          num_lines2             ,
output  [12:0]          start3                 ,
output  [12:0]          num_lines3             ,
output  [12:0]          start4                 ,
output  [12:0]          num_lines4             ,
output  [12:0]          start5                 ,
output  [12:0]          num_lines5             ,
output  [12:0]          start6                 ,
output  [12:0]          num_lines6             ,
output  [12:0]          start7                 ,
output  [12:0]          num_lines7             ,
output  [12:0]          start8                 ,
output  [12:0]          num_lines8             ,
output  [12:0]          sub_s                  ,
output  [12:0]          sub_a                  ,
output  [1:0]           ablc_manual            ,
output  [1:0]           ablc_channel           ,
output  [7:0]          ablc_m_r               ,
output  [7:0]          ablc_m_gr              ,
output  [7:0]          ablc_m_gb              ,
output  [7:0]          ablc_m_b               ,
output  [11:0]          ablc_dth               ,
output  [11:0]          ablc_diff              ,
output  [2:0]           ablc_fn                ,
output  [1:0]           s2_rd_ctrl             ,
output  [2:0]           g_k                    ,
output  [3:0]           adc_en_ramp_ctrl1      ,
output                  tpg_en                 ,
output                  isp_clk_sel            ,
output  [1:0]           rgb_sel                ,    
output  [1:0]           tpg_mode               );


        
wire [1023:0]  DOUT;


wire [7:0] SPI_REG_00; 
wire [7:0] SPI_REG_01; 
wire [7:0] SPI_REG_02; 
wire [7:0] SPI_REG_03; 
wire [7:0] SPI_REG_04; 
wire [7:0] SPI_REG_05; 
wire [7:0] SPI_REG_06; 
wire [7:0] SPI_REG_07; 
wire [7:0] SPI_REG_08; 
wire [7:0] SPI_REG_09; 
wire [7:0] SPI_REG_0A; 
wire [7:0] SPI_REG_0B; 
wire [7:0] SPI_REG_0C; 
wire [7:0] SPI_REG_0D; 
wire [7:0] SPI_REG_0E; 
wire [7:0] SPI_REG_0F; 
wire [7:0] SPI_REG_10; 
wire [7:0] SPI_REG_11; 
wire [7:0] SPI_REG_12; 
wire [7:0] SPI_REG_13; 
wire [7:0] SPI_REG_14; 
wire [7:0] SPI_REG_15; 
wire [7:0] SPI_REG_16; 
wire [7:0] SPI_REG_17; 
wire [7:0] SPI_REG_18; 
wire [7:0] SPI_REG_19; 
wire [7:0] SPI_REG_1A; 
wire [7:0] SPI_REG_1B; 
wire [7:0] SPI_REG_1C; 
wire [7:0] SPI_REG_1D; 
wire [7:0] SPI_REG_1E; 
wire [7:0] SPI_REG_1F; 
wire [7:0] SPI_REG_20; 
wire [7:0] SPI_REG_21; 
wire [7:0] SPI_REG_22; 
wire [7:0] SPI_REG_23; 
wire [7:0] SPI_REG_24; 
wire [7:0] SPI_REG_25; 
wire [7:0] SPI_REG_26; 
wire [7:0] SPI_REG_27; 
wire [7:0] SPI_REG_28; 
wire [7:0] SPI_REG_29; 
wire [7:0] SPI_REG_2A; 
wire [7:0] SPI_REG_2B; 
wire [7:0] SPI_REG_2C; 
wire [7:0] SPI_REG_2D; 
wire [7:0] SPI_REG_2E; 
wire [7:0] SPI_REG_2F; 
wire [7:0] SPI_REG_30; 
wire [7:0] SPI_REG_31; 
wire [7:0] SPI_REG_32; 
wire [7:0] SPI_REG_33; 
wire [7:0] SPI_REG_34; 
wire [7:0] SPI_REG_35; 
wire [7:0] SPI_REG_36; 
wire [7:0] SPI_REG_37; 
wire [7:0] SPI_REG_38; 
wire [7:0] SPI_REG_39; 
wire [7:0] SPI_REG_3A; 
wire [7:0] SPI_REG_3B; 
wire [7:0] SPI_REG_3C; 
wire [7:0] SPI_REG_3D; 
wire [7:0] SPI_REG_3E; 
wire [7:0] SPI_REG_3F; 
wire [7:0] SPI_REG_40; 
wire [7:0] SPI_REG_41; 
wire [7:0] SPI_REG_42; 
wire [7:0] SPI_REG_43; 
wire [7:0] SPI_REG_44; 
wire [7:0] SPI_REG_45; 
wire [7:0] SPI_REG_46; 
wire [7:0] SPI_REG_47; 
wire [7:0] SPI_REG_48; 
wire [7:0] SPI_REG_49; 
wire [7:0] SPI_REG_4A; 
wire [7:0] SPI_REG_4B; 
wire [7:0] SPI_REG_4C; 
wire [7:0] SPI_REG_4D; 
wire [7:0] SPI_REG_4E; 
wire [7:0] SPI_REG_4F; 
wire [7:0] SPI_REG_50; 
wire [7:0] SPI_REG_51; 
wire [7:0] SPI_REG_52; 
wire [7:0] SPI_REG_53; 
wire [7:0] SPI_REG_54; 
wire [7:0] SPI_REG_55; 
wire [7:0] SPI_REG_56; 
wire [7:0] SPI_REG_57; 
wire [7:0] SPI_REG_58; 
wire [7:0] SPI_REG_59; 
wire [7:0] SPI_REG_5A; 
wire [7:0] SPI_REG_5B; 
wire [7:0] SPI_REG_5C; 
wire [7:0] SPI_REG_5D; 
wire [7:0] SPI_REG_5E; 
wire [7:0] SPI_REG_5F; 
wire [7:0] SPI_REG_60; 
wire [7:0] SPI_REG_61; 
wire [7:0] SPI_REG_62; 
wire [7:0] SPI_REG_63; 
wire [7:0] SPI_REG_64; 
wire [7:0] SPI_REG_65; 
wire [7:0] SPI_REG_66; 
wire [7:0] SPI_REG_67; 
wire [7:0] SPI_REG_68; 
wire [7:0] SPI_REG_69; 
wire [7:0] SPI_REG_6A; 
wire [7:0] SPI_REG_6B; 
wire [7:0] SPI_REG_6C; 
wire [7:0] SPI_REG_6D; 
wire [7:0] SPI_REG_6E; 
wire [7:0] SPI_REG_6F; 
wire [7:0] SPI_REG_70; 
wire [7:0] SPI_REG_71; 
wire [7:0] SPI_REG_72; 
wire [7:0] SPI_REG_73; 
wire [7:0] SPI_REG_74; 
wire [7:0] SPI_REG_75; 
wire [7:0] SPI_REG_76; 
wire [7:0] SPI_REG_77; 
wire [7:0] SPI_REG_78; 
wire [7:0] SPI_REG_79;
wire [7:0] SPI_REG_7A;
wire [7:0] SPI_REG_7B;
wire [7:0] SPI_REG_7C;
wire [7:0] SPI_REG_7D;
wire [7:0] SPI_REG_7E;
wire [7:0] SPI_REG_7F;








reg_sync reg_sync_uut( 
.rst(rst),                     
.DOUT(DOUT),             
.sys_idle(sys_idle),                  
.fval(fval),     
.clk(clk), 
.SPI_REG_00({readonly_0[7:0]                                                                          }),                   
.SPI_REG_01({readonly_1[7:0]                                                                          }),                   
.SPI_REG_02({readonly_2[7:0]                                                                          }),                   
.SPI_REG_03({readonly_3[7:0]                                                                          }),                   
.SPI_REG_04({readonly_4[7:0]                                                                          }),                   
.SPI_REG_05({SPI_REG_05[7:6],PGA_EN_AZ,PGA_GAIN[3:0],PGA_PD                                           }),                   
.SPI_REG_06({PGA_EN_PH_OS,PGA_EN_BLK_SUN_SPI,PGA_BLK_SUN_REF[2:0],PIXEL_EN_VHVL,PIXEL_PD,PIXEL_PRECH_EN          }),                   
.SPI_REG_07({PGA_OFFSET_TRIM[7:0]                                                                     }),                   
.SPI_REG_08({SPI_REG_08[7:0]                                                                          }),                   
.SPI_REG_09({PLL_BYPASS,PLL_ICP[2:0],PLL_LOAD[1:0],PLL_TE,PLL_PD                                      }),                   
.SPI_REG_0A({SPI_REG_0A[7:6],PLL_COUNT_CLK,PLL_REFDIV[2:0],PLL_RANGE[1:0]                                           }),                   
.SPI_REG_0B({PLL_FBDIV[7:0]                                                                           }),                   
.SPI_REG_0C({PLL_OUTDIV[7:0]                                                                          }),                   
.SPI_REG_0D({SPI_REG_0D[7:0]                                                                          }),                   
.SPI_REG_0E({SPI_REG_0E[7],LVDS_PD,BIT_MODE,SP_MODE,LVDS_VCR_SEL,LVSD_IBIAS_SEL,LVDS_TRAINE,LVDS_TSTE }),                   
.SPI_REG_0F({SPI_REG_0F[7:4],LVDS_DLTRM[35:32]                                                        }),                   
.SPI_REG_10({LVDS_DLTRM[31:24]                                                                        }),                   
.SPI_REG_11({LVDS_DLTRM[23:16]                                                                        }),                   
.SPI_REG_12({LVDS_DLTRM[15:8]                                                                         }),                   
.SPI_REG_13({LVDS_DLTRM[7:0]                                                                          }),                   
.SPI_REG_14({SPI_REG_14[7:6],LVDS_CLK_SEL[1:0],LVDS_OUT_M[1:0],LVDS_CH_EN[17:16]                      }),                   
.SPI_REG_15({LVDS_CH_EN[15:8]                                                                         }),                   
.SPI_REG_16({LVDS_CH_EN[7:0]                                                                          }),                   
.SPI_REG_17({SPI_REG_17[7:0]                                                                          }),                   
.SPI_REG_18({ADC_PD,ADC_COMP_RST_EN,ADC_I_COL_TRIM[2:0],ADC_I_PIX_TRIM[2:0]                           }),                   
.SPI_REG_19({ADC_STORE_SEL[1:0],ADC_D_RST[12:7]                                                       }),                   
.SPI_REG_1A({ADC_D_RST[6:0],ADC_DIG_TP                                                                }),                   
.SPI_REG_1B({ADC_VREF_EXT_EN,ADC_RGE_VCMCTRL[6:0]                            }),                   
.SPI_REG_1C({ADC_RGE_PD,ADC_I_EXT_EN,ADC_RGE_TESTCTRL[1:0],ADC_RGE_GAINCTRL[11:8]                                  }),                   
.SPI_REG_1D({ADC_RGE_GAINCTRL[7:0]                                                                    }),                   
.SPI_REG_1E({SPI_REG_1E[7:2],ADC_GAIN_TRIM[1:0]                                                                       }),                   
.SPI_REG_1F({SPI_REG_1F[7:0]                                  }),                   
.SPI_REG_20({SPI_REG_20[7],CPNEG_S1S2_PD,CPNEG_TX_PD,CPN_TEST_TX[1:0],CPN_TX_TRIM[2:0]                            }),                   
.SPI_REG_21({CPPOS_TRIM[2:0],CPN_TEST_S1S2[1:0],CPN_S1S2_TRIM[2:0]                      }),                   
.SPI_REG_22({CPPOS_PD,LDO_PD,CPPOS_TEST[1:0],LDO_VREF_TRIM[3:0]	                                    }),                   
.SPI_REG_23({SPI_REG_21[7:1],ROWDEC_CS_SEL                                                            }),                   
.SPI_REG_24({SPI_REG_22[7],BG_PD,BG_TRIM_CURVE[5:0]                                                   }),                   
.SPI_REG_25({BG_TRIM_V[3:0],BG_TRIM_PPC[3:0]                                                          }),                   
.SPI_REG_26({SPI_REG_24[7:4],BG_TESTCTRL[3:0]                                                                                 }),                   
.SPI_REG_27({TS_DINI[7:0]                                                                             }),                   
.SPI_REG_28({TS_IT[2:0],TS_BGVT[4:0]                                                                  }),                   
.SPI_REG_29({TS_RAMP_TRIM[5:0],TS_TCTL[1:0]                                                           }),                   
.SPI_REG_2A({SPI_REG_2A[7:2],TS_PD,TS_SEL_CHOP                                                        }),                   
.SPI_REG_2B({SPI_REG_2B[7:5],monitor_dig_en,monitor_do_en,sel_par_en[2:0]                             }),                   
.SPI_REG_2C({nu_of_frame[15:8]                                                                        }),                   
.SPI_REG_2D({nu_of_frame[7:0]                                                                         }),                   
.SPI_REG_2E({SPI_REG_2E[7:1],frame_request                                                            }),                   
.SPI_REG_2F({SPI_REG_2F[7:4],exp_ext,exp_time[26:24]                                                  }),                   
.SPI_REG_30({exp_time[23:16]                                                                          }),                   
.SPI_REG_31({exp_time[15:8]                                                                           }),                   
.SPI_REG_32({exp_time[7:0]                                                                            }),                   
.SPI_REG_33({SPI_REG_33[7:0]                                                                          }),                   
.SPI_REG_34({exp_seq[2:0],a_step[1:0],exp_step[26:24]                                                 }),                   
.SPI_REG_35({exp_step[23:16]                                                                          }),                   
.SPI_REG_36({exp_step[15:8]                                                                           }),                   
.SPI_REG_37({exp_step[7:0]                                                                            }),                   
.SPI_REG_38({SPI_REG_38[7:0]                                                                          }),                   
.SPI_REG_39({SPI_REG_39[7:5],num_lines[12:8]                                                          }),                   
.SPI_REG_3A({num_lines[7:0]                                                                           }),                   
.SPI_REG_3B({SPI_REG_3B[7:5],start1[12:8]                                                             }),                      
.SPI_REG_3C({start1[7:0]                                                                              }),                      
.SPI_REG_3D({SPI_REG_3D[7:5],num_lines1[12:8]                                                         }),                   
.SPI_REG_3E({num_lines1[7:0]                                                                          }),                   
.SPI_REG_3F({SPI_REG_3F[7:5],start2[12:8]                                                             }),                      
.SPI_REG_40({start2[7:0]                                                                              }),                      
.SPI_REG_41({SPI_REG_41[7:5],num_lines2[12:8]                                                         }),                   
.SPI_REG_42({num_lines2[7:0]                                                                          }),                   
.SPI_REG_43({SPI_REG_43[7:5],start3[12:8]                                                             }),                      
.SPI_REG_44({start3[7:0]                                                                              }),                      
.SPI_REG_45({SPI_REG_45[7:5],num_lines3[12:8]                                                         }),                   
.SPI_REG_46({num_lines3[7:0]                                                                          }),                   
.SPI_REG_47({SPI_REG_47[7:5],start4[12:8]                                                             }),                      
.SPI_REG_48({start4[7:0]                                                                              }),                      
.SPI_REG_49({SPI_REG_49[7:5],num_lines4[12:8]                                                         }),                   
.SPI_REG_4A({num_lines4[7:0]                                                                          }),                   
.SPI_REG_4B({SPI_REG_4B[7:5],start5[12:8]                                                             }),                      
.SPI_REG_4C({start5[7:0]                                                                              }),                      
.SPI_REG_4D({SPI_REG_4D[7:5],num_lines5[12:8]                                                         }),                   
.SPI_REG_4E({num_lines5[7:0]                                                                          }),                   
.SPI_REG_4F({SPI_REG_4F[7:5],start6[12:8]                                                             }),                      
.SPI_REG_50({start6[7:0]                                                                              }),                      
.SPI_REG_51({SPI_REG_51[7:5],num_lines6[12:8]                                                         }),                   
.SPI_REG_52({num_lines6[7:0]                                                                          }),                   
.SPI_REG_53({SPI_REG_53[7:5],start7[12:8]                                                             }),                      
.SPI_REG_54({start7[7:0]                                                                              }),                      
.SPI_REG_55({SPI_REG_55[7:5],num_lines7[12:8]                                                         }),                   
.SPI_REG_56({num_lines7[7:0]                                                                          }),                   
.SPI_REG_57({SPI_REG_57[7:5],start8[12:8]                                                             }),                      
.SPI_REG_58({start8[7:0]                                                                              }),                      
.SPI_REG_59({SPI_REG_59[7:5],num_lines8[12:8]                                                         }),                   
.SPI_REG_5A({num_lines8[7:0]                                                                          }),                   
.SPI_REG_5B({SPI_REG_5B[7:5],sub_s[12:8]                                                              }),                   
.SPI_REG_5C({sub_s[7:0]                                                                               }),                   
.SPI_REG_5D({SPI_REG_5D[7:5],sub_a[12:8]                                                              }),                                                                                                 
.SPI_REG_5E({sub_a[7:0]                                                                               }),                                                                                                 
.SPI_REG_5F({SPI_REG_5F[7:0]                                                                          }),                   
.SPI_REG_60({SPI_REG_60[7:5],black_val_en,black_en,size_ctrl[1:0],r_mirror                            }),                   
.SPI_REG_61({SPI_REG_61[7],en_hdr_gain_mode,en_hdr_mode,gain_2[12:8]                                  }),                   
.SPI_REG_62({gain_2[7:0]                                                                              }),                   
.SPI_REG_63({SPI_REG_63[7:5],gain_3[12:8]                                                             }),                   
.SPI_REG_64({gain_3[7:0]                                                                              }),                   
.SPI_REG_65({SPI_REG_65[7:5],gain_4[12:8]                                                             }),                   
.SPI_REG_66({gain_4[7:0]                                                                              }),                   
.SPI_REG_67({SPI_REG_67[7:5],gain_5[12:8]                                                             }),                   
.SPI_REG_68({gain_5[7:0]                                                                              }),                   
.SPI_REG_69({SPI_REG_69[7:5],gain_6[12:8]                                                             }),                   
.SPI_REG_6A({gain_6[7:0]                                                                              }),                   
.SPI_REG_6B({SPI_REG_6B[7:5],gain_7[12:8]                                                             }),                   
.SPI_REG_6C({gain_7[7:0]                                                                              }),                   
.SPI_REG_6D({SPI_REG_6D[7:5],gain_8[12:8]                                                             }),                   
.SPI_REG_6E({gain_8[7:0]                                                                              }),                   
.SPI_REG_6F({SPI_REG_6F[7:0]                                                                          }),                   
.SPI_REG_70({SPI_REG_70[7],ablc_fn[2:0],ablc_channel[1:0],ablc_manual[1:0]                               }),                   
.SPI_REG_71({SPI_REG_71[7:0]                                                           }),                   
.SPI_REG_72({ablc_m_r[7:0]                                                                            }),                   
.SPI_REG_73({SPI_REG_73[7:0]                                                          }),                   
.SPI_REG_74({ablc_m_gr[7:0]                                                                           }),                   
.SPI_REG_75({SPI_REG_75[7:0]                                                          }),                   
.SPI_REG_76({ablc_m_gb[7:0]                                                                           }),                   
.SPI_REG_77({SPI_REG_77[7:0]                                                           }),                   
.SPI_REG_78({ablc_m_b[7:0]                                                                            }),                   
.SPI_REG_79({SPI_REG_79[7:4],ablc_dth[11:8]                                                           }),                   
.SPI_REG_7A({ablc_dth[7:0]                                                                            }),                   
.SPI_REG_7B({SPI_REG_7B[7:4],ablc_diff[11:8]                                                          }),                   
.SPI_REG_7C({ablc_diff[7:0]                                                                           }),                   
.SPI_REG_7D({rgb_sel[1:0],s2_rd_ctrl[1:0],adc_en_ramp_ctrl1[3:0]                                            }),                   
.SPI_REG_7E({SPI_REG_7E[7],isp_clk_sel,g_k[2:0],tpg_en,tpg_mode[1:0]                                                     }),                   
.SPI_REG_7F({SPI_REG_7F[7:0]                                                                          })            
);                                                                                                          
		                                                                                                            

spi_slave spi_slave_uut (         
.rst(rst),  
.CPOL(cpol),  
.CPHA(cpha),    
.spi_clk(spi_clk), 
.spi_en(spi_en),   
.spi_in(spi_in),   
.spi_out(spi_out),
.POUT(DOUT)					
);       


           
endmodule      
                           
