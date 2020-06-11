module assertion(
                  input exp_ext,
                  input [26:0] exp_time,
                  input bit_mode,
                  input sp_mode,
                  input [1:0] lvds_out_m,
                  input [7:0] dig_83,
                  
                  input rst,
                  input dig_clk,
                  input sys_clk,
                  input frame_reg,
                  input t_exp,

                  input rowdec_rd_en,
                  input rowdec_clk_rd,
                  input rowdec_s2_rd,
                  input rowdec_rst,
                  
                  input rowdec_tx,
                  input rowdec_pc,
                  input rowdec_s1,
                  input rowdec_s2_gl,

                  input pga_en_az,
                  input pga_c1,
                  input pga_c2,
                  input pga_rst,
                  input pga_ph_sr,
                  input pga_ph_ss,
                  input pga_en_blksun,
                  input pga_ph_offset,
                  input pixel_precharge,
                  
                  input adc_r_ck,
                  input adc_ph_hr,
                  input adc_ph_hs,
                  input adc_en_ramp,
                  input adc_count_dn,
                  input adc_rst_count,
                  input adc_store,
                  input adc_ready,

                  input csel_st,
                  input fval,
                  input lval,
                  input dval,
                  input slot,
                  input row,
                  input inte1,
                  input inte2,
                  input fot,

                  input row_st,
                  input row_addr



);

parameter FOT_SERIAL_T1 = 240;
parameter FOT_SERIAL_T2 = 1200;
parameter FOT_SERIAL_T3 = 1440;
parameter FOT_SERIAL_T4 = 1920;
parameter FOT_SERIAL_T5 = 2160;
parameter FOT_SERIAL_T6 = 2352;
parameter FOT_SERIAL_T7 = 2400;
parameter FOT_SERIAL_T8 = 2640;
parameter FOT_SERIAL_T9 = 2710;
parameter FOT_SERIAL_T10 = 2910;
parameter FOT_SERIAL_T11 = 3110;
parameter FOT_SERIAL_T12 = 3115;
parameter FOT_SERIAL_T13 = 3116;
parameter FOT_SERIAL_T14 = 3118;
parameter FOT_SERIAL_T15 = 3120;
parameter FOT_SERIAL_T16 = 1104;
parameter FOT_SERIAL_T17 = 3111;
parameter FOT_SERIAL_T18 = 3112;
parameter FOT_SERIAL_T19 = 3113;
parameter FOT_SERIAL_T20 = 3114;

parameter READ_OUT_SERIAL_16CH_T1 = 1;
parameter READ_OUT_SERIAL_16CH_T2 = 2;
parameter READ_OUT_SERIAL_16CH_T3 = 5;
parameter READ_OUT_SERIAL_16CH_T4 = 24;

parameter READ_OUT_SERIAL_10BIT_16CH_T6 = 14;
parameter READ_OUT_SERIAL_12BIT_16CH_T6 = 43;
parameter READ_OUT_SERIAL_10BIT_16CH_T7 = 15;
parameter READ_OUT_SERIAL_12BIT_16CH_T7 = 44;
parameter READ_OUT_SERIAL_10BIT_16CH_T8 = 38;
parameter READ_OUT_SERIAL_12BIT_16CH_T8 = 192;
parameter READ_OUT_SERIAL_10BIT_16CH_T9 = 43;
parameter READ_OUT_SERIAL_12BIT_16CH_T9 = 197;
parameter READ_OUT_SERIAL_10BIT_16CH_T10 = 45;
parameter READ_OUT_SERIAL_12BIT_16CH_T10 = 199;
parameter READ_OUT_SERIAL_10BIT_16CH_T11 = 48;
parameter READ_OUT_SERIAL_12BIT_16CH_T11 = 202;
parameter READ_OUT_SERIAL_10BIT_16CH_T14 = 124;
parameter READ_OUT_SERIAL_12BIT_16CH_T14 = 412;
parameter READ_OUT_SERIAL_10BIT_16CH_T15 = 126;
parameter READ_OUT_SERIAL_12BIT_16CH_T15 = 414;
parameter READ_OUT_SERIAL_10BIT_16CH_T16 = 127;
parameter READ_OUT_SERIAL_12BIT_16CH_T16 = 415;
parameter READ_OUT_SERIAL_10BIT_16CH_T17 = 128;
parameter READ_OUT_SERIAL_12BIT_16CH_T17 = 416;
parameter READ_OUT_SERIAL_10BIT_16CH_T18 = 129;
parameter READ_OUT_SERIAL_12BIT_16CH_T18 = 417;
parameter READ_OUT_SERIAL_10BIT_16CH_T19 = 1;
parameter READ_OUT_SERIAL_12BIT_16CH_T19 = 1;
parameter READ_OUT_SERIAL_10BIT_16CH_T20 = 122;
parameter READ_OUT_SERIAL_12BIT_16CH_T20 = 410;
parameter READ_OUT_SERIAL_10BIT_16CH_T21 = 123;
parameter READ_OUT_SERIAL_12BIT_16CH_T21 = 411;


int serial_10bit_16ch_t5,  serial_12bit_16ch_t5;
int serial_10bit_16ch_t12, serial_12bit_16ch_t12;
int serial_10bit_16ch_t13, serial_12bit_16ch_t13;
always @(posedge dig_clk) 
 if(~rst) begin 
                serial_10bit_16ch_t5 = 0;
                serial_12bit_16ch_t5 = 0;
                serial_10bit_16ch_t12 = 0;
                serial_12bit_16ch_t12 = 0;
                serial_10bit_16ch_t13 = 0;
                serial_12bit_16ch_t13 = 0;
          end
 else begin
                serial_10bit_16ch_t5 = (13-dig_83[3:0])*20.8;
                serial_12bit_16ch_t5 = (42-4*dig_83[3:0])*25;
                case(dig_83[5:4])
                  2'b00 : begin
                          serial_10bit_16ch_t12 = (48+24)*20.8;
                          serial_12bit_16ch_t12 = (202+24)*25;
                          serial_10bit_16ch_t13 = (53+24)*20.8;
                          serial_12bit_16ch_t13 = (207+24)*25;
                  end
                  2'b01 : begin
                          serial_10bit_16ch_t12 = (48+28)*20.8;
                          serial_12bit_16ch_t12 = (202+28)*25;
                          serial_10bit_16ch_t13 = (53+28)*20.8;
                          serial_12bit_16ch_t13 = (207+28)*25;
                  end
                  2'b10 : begin
                          serial_10bit_16ch_t12 = (48+32)*20.8;
                          serial_12bit_16ch_t12 = (202+32)*25;
                          serial_10bit_16ch_t13 = (53+32)*20.8;
                          serial_12bit_16ch_t13 = (207+32)*25;
                  end
                  2'b11 : begin
                          serial_10bit_16ch_t12 = (48+36)*20.8;
                          serial_12bit_16ch_t12 = (202+36)*25;
                          serial_10bit_16ch_t13 = (53+36)*20.8;
                          serial_12bit_16ch_t13 = (207+36)*25;
                  end
                endcase
 end


property POs_to_POs(mod,str,sig,delay);
  @(posedge dig_clk) disable iff(~rst || mod)
  $rose(str) |=> ##delay $rose(sig); 
endproperty
//1.0 inter exp
a_inter_exp_mod_rowdec_tx_Neg : assert property(POs_to_POs(exp_ext,frame_reg,~rowdec_tx,2))
  else $error("assert error: a_inter_exp_mod_rowdec_tx_Neg");
a_inter_exp_mod_inte1_Pos : assert property(POs_to_POs(exp_ext,frame_reg,inte1,2))
  else $error("assert error: a_inter_exp_mod_inte1_Pos");
a_inter_exp_mod_inte2_Pos : assert property(POs_to_POs(exp_ext,frame_reg,inte2,2))
  else $error("assert error: a_inter_exp_mod_inte2_Pos");

property unchange_time(mod,sig,period_min,period_max);
  time curr_time;
  @(posedge sig) disable iff(~rst || mod)
  (1, curr_time = $time) |=>  @(negedge sig) ((($time - curr_time)>=period_min) && (($time - curr_time)<=period_max)); 
  //(1 curr_time = $time) |=>  @(negedge sig) ((($time - curr_time)>=period_min)); 
endproperty

a_inter_exp_mod_inte1_Unchange : assert property(unchange_time(exp_ext,inte1,exp_time-1,exp_time+1))
  else $error("assert error: a_inter_exp_mod_inte1_Unchange");
a_inter_exp_mod_inte2_Unchange : assert property(unchange_time(exp_ext,inte2,exp_time-1,exp_time+1))
  else $error("assert error: a_inter_exp_mod_inte2_Unchange");

//1.1 ext exp  
a_ext_exp_mod_rowdec_tx_Neg : assert property(POs_to_POs(!exp_ext,t_exp,~rowdec_tx,2))
  else $error("assert error: a_ext_exp_mod_rowdec_tx_Neg");
a_ext_exp_mod_inte1_Pos : assert property(POs_to_POs(!exp_ext,t_exp,inte1,2))
  else $error("assert error: a_ext_exp_mod_inte1_Pos");
a_ext_exp_mod_inte2_Pos : assert property(POs_to_POs(!exp_ext,t_exp,inte2,2))
  else $error("assert error: a_ext_exp_mod_inte2_Pos");

a_ext_exp_mod_inte1_Neg : assert property(POs_to_POs(!exp_ext,frame_reg,~inte1,2))
  else $error("assert error: a_ext_exp_mod_inte1_Neg");
a_ext_exp_mod_inte2_Neg : assert property(POs_to_POs(!exp_ext,frame_reg,~inte2,2))
  else $error("assert error: a_ext_exp_mod_inte2_Neg");

//2.0 fot
property FOT_POs_to_POs_Period(mod,str,sig,period_min,period_max);
  time curr_time;
  @(posedge str) disable iff(~rst || ~mod)
  (1, curr_time = $time) |=> @(posedge sig)  ((($time - curr_time)>=period_min) && (($time - curr_time)<=period_max));
endproperty


property FOT_POs_to_POs_Count(mod,str,sig,count);
  time curr_time;
  @(posedge dig_clk) disable iff(~rst || ~mod)
  $rose(str) |-> ##count $rose(sig);
endproperty
//2.1 rowdec_rd_en
a_FOT_serial_mode_rowdec_rd_en_Pos : assert property(FOT_POs_to_POs_Count(({bit_mode,sp_mode}==2'b00)||({bit_mode,sp_mode}==2'b10),fot,rowdec_rd_en,FOT_SERIAL_T14))
  else $error("assert error: a_FOT_serial_mode_rowdec_rd_en_Pos");

//2.2 rowdec_rst
a_FOT_serial_mode_rowdec_rst_Neg : assert property(FOT_POs_to_POs_Count(({bit_mode,sp_mode}==2'b00)||({bit_mode,sp_mode}==2'b10),fot,~rowdec_rst,FOT_SERIAL_T16))
  else $error("assert error: a_FOT_serial_mode_rowdec_rst_Neg");
a_FOT_serial_mode_rowdec_rst_Pos : assert property(FOT_POs_to_POs_Count(({bit_mode,sp_mode}==2'b00)||({bit_mode,sp_mode}==2'b10),fot,rowdec_rd_en,FOT_SERIAL_T7))
  else $error("assert error: a_FOT_serial_mode_rowdec_rst_Pos");  
//2.3 rowdec_tx
a_FOT_serial_mode_rowdec_tx_Pos1 : assert property(FOT_POs_to_POs_Count(({bit_mode,sp_mode}==2'b00)||({bit_mode,sp_mode}==2'b10),fot,rowdec_tx,FOT_SERIAL_T3))
  else $error("assert error: a_FOT_serial_mode_rowdec_tx_Pos1");  
a_FOT_serial_mode_rowdec_tx_Pos2 : assert property(FOT_POs_to_POs_Count(({bit_mode,sp_mode}==2'b00)||({bit_mode,sp_mode}==2'b10),fot,rowdec_tx,FOT_SERIAL_T8))
  else $error("assert error: a_FOT_serial_mode_rowdec_tx_Pos2"); 
a_FOT_serial_mode_rowdec_tx_Neg : assert property(FOT_POs_to_POs_Count(({bit_mode,sp_mode}==2'b00)||({bit_mode,sp_mode}==2'b10),fot,~rowdec_tx,FOT_SERIAL_T4))
  else $error("assert error: a_FOT_serial_mode_rowdec_tx_Pos2"); 
//2.4 rowdec_pc
a_FOT_serial_mode_rowdec_pc_POs : assert property(FOT_POs_to_POs_Count(({bit_mode,sp_mode}==2'b00)||({bit_mode,sp_mode}==2'b10),fot,rowdec_pc,0))
  else $error("assert error: a_FOT_serial_mode_rowdec_pc_Pos"); 
a_FOT_serial_mode_rowdec_pc_Neg : assert property(FOT_POs_to_POs_Count(({bit_mode,sp_mode}==2'b00)||({bit_mode,sp_mode}==2'b10),fot,~rowdec_pc,FOT_SERIAL_T6))
  else $error("assert error: a_FOT_serial_mode_rowdec_pc_Neg"); 
//2.5 rowdec_s1, 
a_FOT_serial_mode_rowdec_s1_Pos : assert property(FOT_POs_to_POs_Count(({bit_mode,sp_mode}==2'b00)||({bit_mode,sp_mode}==2'b10),fot,rowdec_s1,FOT_SERIAL_T1))
  else $error("assert error: a_FOT_serial_mode_rowdec_s1_Pos");
a_FOT_serial_mode_rowdec_s1_Neg : assert property(FOT_POs_to_POs_Count(({bit_mode,sp_mode}==2'b00)||({bit_mode,sp_mode}==2'b10),fot,~rowdec_s1,FOT_SERIAL_T5))
  else $error("assert error: a_FOT_serial_mode_rowdec_s1_Neg");
//2.7 rowdec_s2_gl
a_FOT_serial_mode_rowdec_s2_gl_Pos : assert property(FOT_POs_to_POs_Count(({bit_mode,sp_mode}==2'b00)||({bit_mode,sp_mode}==2'b10),fot,rowdec_s2_gl,FOT_SERIAL_T1))
  else $error("assert error: a_FOT_serial_mode_rowdec_s2_gl_Pos");
a_FOT_serial_mode_rowdec_s2_gl_Neg : assert property(FOT_POs_to_POs_Count(({bit_mode,sp_mode}==2'b00)||({bit_mode,sp_mode}==2'b10),fot,~rowdec_s1,FOT_SERIAL_T2))
  else $error("assert error: a_FOT_serial_mode_rowdec_s2_gl_Neg");
//2.8 pga_en_az
a_FOT_serial_mode_pga_en_az_Pos : assert property(FOT_POs_to_POs_Count(({bit_mode,sp_mode}==2'b00)||({bit_mode,sp_mode}==2'b10),fot,pga_en_az,FOT_SERIAL_T10))
  else $error("assert error: a_FOT_serial_mode_pga_en_az_Pos");
a_FOT_serial_mode_pga_en_az_Neg : assert property(FOT_POs_to_POs_Count(({bit_mode,sp_mode}==2'b00)||({bit_mode,sp_mode}==2'b10),fot,~pga_en_az,FOT_SERIAL_T9))
  else $error("assert error: a_FOT_serial_mode_pga_en_az_Neg");
//2.9 pga_c1
a_FOT_serial_mode_pga_c1_Pos : assert property(FOT_POs_to_POs_Count(({bit_mode,sp_mode}==2'b00)||({bit_mode,sp_mode}==2'b10),fot,pga_c1,FOT_SERIAL_T10))
  else $error("assert error: a_FOT_serial_mode_pga_c1_Pos");
a_FOT_serial_mode_pga_c1_Neg : assert property(FOT_POs_to_POs_Count(({bit_mode,sp_mode}==2'b00)||({bit_mode,sp_mode}==2'b10),fot,~pga_c1,FOT_SERIAL_T12))
  else $error("assert error: a_FOT_serial_mode_pga_c1_Neg");
//2.10 pga_c2
a_FOT_serial_mode_pga_c2_Pos : assert property(FOT_POs_to_POs_Count(({bit_mode,sp_mode}==2'b00)||({bit_mode,sp_mode}==2'b10),fot,pga_c2,FOT_SERIAL_T10))
  else $error("assert error: a_FOT_serial_mode_pga_c2_Pos");
a_FOT_serial_mode_pga_c2_Neg : assert property(FOT_POs_to_POs_Count(({bit_mode,sp_mode}==2'b00)||({bit_mode,sp_mode}==2'b10),fot,~pga_c2,FOT_SERIAL_T11))
  else $error("assert error: a_FOT_serial_mode_pga_c2_Neg");  
//2.11 pga_rst
a_FOT_serial_mode_pga_rst_Pos : assert property(FOT_POs_to_POs_Count(({bit_mode,sp_mode}==2'b00)||({bit_mode,sp_mode}==2'b10),fot,pga_rst,FOT_SERIAL_T9))
  else $error("assert error: a_FOT_serial_mode_pga_rst_Pos");
a_FOT_serial_mode_pga_rst_Neg : assert property(FOT_POs_to_POs_Count(({bit_mode,sp_mode}==2'b00)||({bit_mode,sp_mode}==2'b10),fot,~pga_rst,FOT_SERIAL_T10))
  else $error("assert error: a_FOT_serial_mode_pga_rst_Neg");  
a_FOT_serial_mode_pga_rst_Pos2 : assert property(FOT_POs_to_POs_Count(({bit_mode,sp_mode}==2'b00)||({bit_mode,sp_mode}==2'b10),fot,pga_rst,FOT_SERIAL_T15))
  else $error("assert error: a_FOT_serial_mode_pga_rst_Pos2");  
//2.12 pga_ph_sr
a_FOT_serial_mode_pga_ph_sr_Pos : assert property(FOT_POs_to_POs_Count(({bit_mode,sp_mode}==2'b00)||({bit_mode,sp_mode}==2'b10),fot,pga_ph_sr,FOT_SERIAL_T15))
  else $error("assert error: a_FOT_serial_mode_pga_ph_sr_Pos2");  
//2.13 pga_en_blksun
a_FOT_serial_mode_pga_en_blksun_Pos : assert property(FOT_POs_to_POs_Count(({bit_mode,sp_mode}==2'b00)||({bit_mode,sp_mode}==2'b10),fot,pga_en_blksun,FOT_SERIAL_T15))
  else $error("assert error: a_FOT_serial_mode_pga_en_blksun_Pos");  
//2.14 adc_r_ck
a_FOT_serial_mode_adc_r_ck_Pos : assert property(FOT_POs_to_POs_Count(({bit_mode,sp_mode}==2'b00)||({bit_mode,sp_mode}==2'b10),fot,adc_r_ck,FOT_SERIAL_T15))
  else $error("assert error: a_FOT_serial_mode_adc_r_ck_Pos");  
//2.15 adc_ph_hr
a_FOT_serial_mode_adc_ph_hr_Pos : assert property(FOT_POs_to_POs_Count(({bit_mode,sp_mode}==2'b00)||({bit_mode,sp_mode}==2'b10),fot,adc_ph_hr,FOT_SERIAL_T15))
  else $error("assert error: a_FOT_serial_mode_adc_ph_hr_Pos");  
//2.16 fot
a_FOT_serial_mode_fot_Neg : assert property(FOT_POs_to_POs_Count(({bit_mode,sp_mode}==2'b00)||({bit_mode,sp_mode}==2'b10),fot,~fot,FOT_SERIAL_T15))
  else $error("assert error: a_FOT_serial_mode_fot_Neg"); 
//2.17 row_st
a_FOT_serial_mode_row_st_Pos : assert property(FOT_POs_to_POs_Count(({bit_mode,sp_mode}==2'b00)||({bit_mode,sp_mode}==2'b10),fot,row_st,FOT_SERIAL_T17))
  else $error("assert error: a_FOT_serial_mode_row_st_Pos");
a_FOT_serial_mode_row_st_Neg : assert property(FOT_POs_to_POs_Count(({bit_mode,sp_mode}==2'b00)||({bit_mode,sp_mode}==2'b10),fot,~row_st,FOT_SERIAL_T18))
  else $error("assert error: a_FOT_serial_mode_row_st_Neg"); 
//2.18 row_addr
a_FOT_serial_mode_row_addr_Pos : assert property(FOT_POs_to_POs_Count(({bit_mode,sp_mode}==2'b00)||({bit_mode,sp_mode}==2'b10),fot,row_addr,FOT_SERIAL_T19))
  else $error("assert error: a_FOT_serial_mode_row_addr_Pos");
a_FOT_serial_mode_row_addr_Neg : assert property(FOT_POs_to_POs_Count(({bit_mode,sp_mode}==2'b00)||({bit_mode,sp_mode}==2'b10),fot,~row_addr,FOT_SERIAL_T20))
  else $error("assert error: a_FOT_serial_mode_row_addr_Neg"); 

//3.0 read out 16 channel
property READ_OUT_POs_to_POs_Period(mod,sig,period_min,period_max);
  time curr_time;
  @(posedge rowdec_clk_rd) disable iff(~rst || ~mod || ~rowdec_rd_en)
  (1, curr_time = $time) |=> @(posedge sig)  ((($time - curr_time)>=period_min) && (($time - curr_time)<=period_max));
endproperty


property READ_OUT_POs_to_POs_Count(mod,sig,count);
  time curr_time;
  @(posedge dig_clk) disable iff(~rst || ~mod || ~rowdec_rd_en)
  $rose(rowdec_clk_rd) |-> ##count $rose(sig);
endproperty

//3.1 rowdec_clk_rd
a_read_out_serial_16ch_mode_row_clk_rd_Neg : assert property(READ_OUT_POs_to_POs_Count((({bit_mode,sp_mode}==2'b00)||({bit_mode,sp_mode}==2'b10)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),~rowdec_clk_rd,READ_OUT_SERIAL_16CH_T4))
  else $error("assert error: a_read_out_serial_16ch_mode_row_clk_rd_Neg");
//3.2 rowdec_s2_rd

a_read_out_serial_10bit_16ch_mode_rowdec_s2_rd_Pos : assert property(READ_OUT_POs_to_POs_Count((({bit_mode,sp_mode}==2'b00)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),rowdec_s2_rd,READ_OUT_SERIAL_10BIT_16CH_T11))
  else $error("assert error: a_read_out_serial_10bit_16ch_mode_rowdec_s2_rd_Pos");
a_read_out_serial_10bit_16ch_mode_rowdec_s2_rd_Neg : assert property(READ_OUT_POs_to_POs_Period((({bit_mode,sp_mode}==2'b00)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),~rowdec_s2_rd,serial_10bit_16ch_t12,serial_10bit_16ch_t12))
  else $error("assert error: a_read_out_serial_10bit_16ch_mode_rowdec_s2_rd_Neg");
a_read_out_serial_12bit_16ch_mode_rowdec_s2_rd_Pos : assert property(READ_OUT_POs_to_POs_Count((({bit_mode,sp_mode}==2'b10)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),rowdec_s2_rd,READ_OUT_SERIAL_12BIT_16CH_T11))
  else $error("assert error: a_read_out_serial_12bit_16ch_mode_rowdec_s2_rd_Pos");
a_read_out_serial_12bit_16ch_mode_rowdec_s2_rd_Neg : assert property(READ_OUT_POs_to_POs_Period((({bit_mode,sp_mode}==2'b10)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),~rowdec_s2_rd,serial_12bit_16ch_t12,serial_12bit_16ch_t12))
  else $error("assert error: a_read_out_serial_12bit_16ch_mode_rowdec_s2_rd_Neg");
//3.3 pga_rst
a_read_out_serial_10bit_16ch_mode_pga_rst_Pos : assert property(READ_OUT_POs_to_POs_Count((({bit_mode,sp_mode}==2'b00)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),pga_rst,0))
  else $error("assert error: a_read_out_serial_10bit_16ch_mode_pga_rst_Pos");
a_read_out_serial_10bit_16ch_mode_pga_rst_Neg : assert property(READ_OUT_POs_to_POs_Count((({bit_mode,sp_mode}==2'b00)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),~pga_rst,READ_OUT_SERIAL_10BIT_16CH_T8))
  else $error("assert error: a_read_out_serial_10bit_16ch_mode_pga_rst_Neg");
a_read_out_serial_12bit_16ch_mode_pga_rst_Pos : assert property(READ_OUT_POs_to_POs_Count((({bit_mode,sp_mode}==2'b10)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),pga_rst,0))
  else $error("assert error: a_read_out_serial_12bit_16ch_mode_pga_rst_Pos");
a_read_out_serial_12bit_16ch_mode_pga_rst_Neg : assert property(READ_OUT_POs_to_POs_Count((({bit_mode,sp_mode}==2'b10)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),~pga_rst,READ_OUT_SERIAL_12BIT_16CH_T8))
  else $error("assert error: a_read_out_serial_12bit_16ch_mode_pga_rst_Neg");
//3.4 pga_ph_sr
a_read_out_serial_10bit_16ch_mode_pga_ph_sr_Pos : assert property(READ_OUT_POs_to_POs_Count((({bit_mode,sp_mode}==2'b00)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),pga_ph_sr,0))
  else $error("assert error: a_read_out_serial_10bit_16ch_mode_pga_ph_sr_Pos");
a_read_out_serial_10bit_16ch_mode_pga_ph_sr_Neg : assert property(READ_OUT_POs_to_POs_Count((({bit_mode,sp_mode}==2'b00)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),~pga_ph_sr,READ_OUT_SERIAL_10BIT_16CH_T9))
  else $error("assert error: a_read_out_serial_10bit_16ch_mode_pga_ph_sr_Neg");
a_read_out_serial_12bit_16ch_mode_pga_ph_sr_Pos : assert property(READ_OUT_POs_to_POs_Count((({bit_mode,sp_mode}==2'b10)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),pga_ph_sr,0))
  else $error("assert error: a_read_out_serial_12bit_16ch_mode_pga_ph_sr_Pos");
a_read_out_serial_12bit_16ch_mode_pga_ph_sr_Neg : assert property(READ_OUT_POs_to_POs_Count((({bit_mode,sp_mode}==2'b10)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),~pga_ph_sr,READ_OUT_SERIAL_12BIT_16CH_T9))
  else $error("assert error: a_read_out_serial_12bit_16ch_mode_pga_ph_sr_Neg");
//3.5 pga_ph_ss
a_read_out_serial_10bit_16ch_mode_pga_ph_ss_Pos : assert property(READ_OUT_POs_to_POs_Count((({bit_mode,sp_mode}==2'b00)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),pga_ph_ss,READ_OUT_SERIAL_10BIT_16CH_T11))
  else $error("assert error: a_read_out_serial_10bit_16ch_mode_pga_ph_ss_Pos");
a_read_out_serial_10bit_16ch_mode_pga_ph_ss_Neg : assert property(READ_OUT_POs_to_POs_Count((({bit_mode,sp_mode}==2'b00)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),~pga_ph_ss,READ_OUT_SERIAL_10BIT_16CH_T14))
  else $error("assert error: a_read_out_serial_10bit_16ch_mode_pga_ph_ss_Neg");
a_read_out_serial_12bit_16ch_mode_pga_ph_ss_Pos : assert property(READ_OUT_POs_to_POs_Count((({bit_mode,sp_mode}==2'b10)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),pga_ph_ss,READ_OUT_SERIAL_12BIT_16CH_T11))
  else $error("assert error: a_read_out_serial_12bit_16ch_mode_pga_ph_ss_Pos");
a_read_out_serial_12bit_16ch_mode_pga_ph_ss_Neg : assert property(READ_OUT_POs_to_POs_Count((({bit_mode,sp_mode}==2'b10)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),~pga_ph_ss,READ_OUT_SERIAL_12BIT_16CH_T14))
  else $error("assert error: a_read_out_serial_12bit_16ch_mode_pga_ph_ss_Neg");
//3.6 pga_en_blksun
a_read_out_serial_10bit_16ch_mode_pga_en_blksun_Pos : assert property(READ_OUT_POs_to_POs_Count((({bit_mode,sp_mode}==2'b00)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),pga_en_blksun,0))
  else $error("assert error: a_read_out_serial_10bit_16ch_mode_pga_en_blksun_Pos");
a_read_out_serial_10bit_16ch_mode_pga_en_blksun_Neg : assert property(READ_OUT_POs_to_POs_Count((({bit_mode,sp_mode}==2'b00)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),~pga_en_blksun,READ_OUT_SERIAL_10BIT_16CH_T10))
  else $error("assert error: a_read_out_serial_10bit_16ch_mode_pga_en_blksun_Neg");
a_read_out_serial_12bit_16ch_mode_pga_en_blksun_Pos : assert property(READ_OUT_POs_to_POs_Count((({bit_mode,sp_mode}==2'b10)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),pga_en_blksun,0))
  else $error("assert error: a_read_out_serial_12bit_16ch_mode_pga_en_blksun_Pos");
a_read_out_serial_12bit_16ch_mode_pga_en_blksun_Neg : assert property(READ_OUT_POs_to_POs_Count((({bit_mode,sp_mode}==2'b10)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),~pga_en_blksun,READ_OUT_SERIAL_12BIT_16CH_T10))
  else $error("assert error: a_read_out_serial_12bit_16ch_mode_pga_en_blksun_Neg");
//3.7 pga_ph_offset
a_read_out_serial_10bit_16ch_mode_pga_ph_offset_Pos : assert property(READ_OUT_POs_to_POs_Count((({bit_mode,sp_mode}==2'b00)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),pga_ph_offset,READ_OUT_SERIAL_10BIT_16CH_T11))
  else $error("assert error: a_read_out_serial_10bit_16ch_mode_pga_ph_offset_Pos");
a_read_out_serial_10bit_16ch_mode_pga_ph_offset_Neg : assert property(READ_OUT_POs_to_POs_Count((({bit_mode,sp_mode}==2'b00)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),~pga_ph_offset,READ_OUT_SERIAL_10BIT_16CH_T18))
  else $error("assert error: a_read_out_serial_10bit_16ch_mode_pga_ph_offset_Neg");
a_read_out_serial_12bit_16ch_mode_pga_ph_offset_Pos : assert property(READ_OUT_POs_to_POs_Count((({bit_mode,sp_mode}==2'b10)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),pga_ph_offset,READ_OUT_SERIAL_12BIT_16CH_T11))
  else $error("assert error: a_read_out_serial_12bit_16ch_mode_pga_ph_offset_Pos");
a_read_out_serial_12bit_16ch_mode_pga_ph_offset_Neg : assert property(READ_OUT_POs_to_POs_Count((({bit_mode,sp_mode}==2'b10)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),~pga_ph_offset,READ_OUT_SERIAL_12BIT_16CH_T18))
  else $error("assert error: a_read_out_serial_12bit_16ch_mode_pga_ph_offset_Neg");
//3.8 pixel_precharge
a_read_out_serial_10bit_16ch_mode_pixel_precharge_Pos : assert property(READ_OUT_POs_to_POs_Count((({bit_mode,sp_mode}==2'b00)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),pixel_precharge,0))
  else $error("assert error: a_read_out_serial_10bit_16ch_mode_pixel_precharge_Pos");
a_read_out_serial_10bit_16ch_mode_pixel_precharge_Neg : assert property(READ_OUT_POs_to_POs_Count((({bit_mode,sp_mode}==2'b00)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),~pixel_precharge,READ_OUT_SERIAL_16CH_T3))
  else $error("assert error: a_read_out_serial_10bit_16ch_mode_pixel_precharge_Neg");
a_read_out_serial_12bit_16ch_mode_pixel_precharge_Pos : assert property(READ_OUT_POs_to_POs_Count((({bit_mode,sp_mode}==2'b10)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),pixel_precharge,0))
  else $error("assert error: a_read_out_serial_12bit_16ch_mode_pixel_precharge_Pos");
a_read_out_serial_12bit_16ch_mode_pixel_precharge_Neg : assert property(READ_OUT_POs_to_POs_Count((({bit_mode,sp_mode}==2'b10)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),~pixel_precharge,READ_OUT_SERIAL_16CH_T3))
  else $error("assert error: a_read_out_serial_12bit_16ch_mode_pixel_precharge_Neg");

a_read_out_serial_10bit_16ch_mode_pixel_precharge_Pos2 : assert property(READ_OUT_POs_to_POs_Period((({bit_mode,sp_mode}==2'b00)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),pixel_precharge,serial_10bit_16ch_t12,serial_10bit_16ch_t12))
  else $error("assert error: a_read_out_serial_10bit_16ch_mode_pixel_precharge_Pos2");
a_read_out_serial_10bit_16ch_mode_pixel_precharge_Neg2 : assert property(READ_OUT_POs_to_POs_Period((({bit_mode,sp_mode}==2'b00)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),~pixel_precharge,serial_10bit_16ch_t13,serial_10bit_16ch_t13))
  else $error("assert error: a_read_out_serial_10bit_16ch_mode_pixel_precharge_Neg2");
a_read_out_serial_12bit_16ch_mode_pixel_precharge_Pos2 : assert property(READ_OUT_POs_to_POs_Period((({bit_mode,sp_mode}==2'b00)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),pixel_precharge,serial_12bit_16ch_t12,serial_12bit_16ch_t12))
  else $error("assert error: a_read_out_serial_12bit_16ch_mode_pixel_precharge_Pos2");
a_read_out_serial_12bit_16ch_mode_pixel_precharge_Neg2 : assert property(READ_OUT_POs_to_POs_Period((({bit_mode,sp_mode}==2'b00)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),~pixel_precharge,serial_12bit_16ch_t13,serial_12bit_16ch_t13))
  else $error("assert error: a_read_out_serial_12bit_16ch_mode_pixel_precharge_Neg2");





//3.9 adc_r_ck
a_read_out_serial_10bit_16ch_mode_adc_r_ck_Pos : assert property(READ_OUT_POs_to_POs_Count((({bit_mode,sp_mode}==2'b00)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),adc_r_ck,0))
  else $error("assert error: a_read_out_serial_10bit_16ch_mode_adc_r_ck_Pos");
a_read_out_serial_10bit_16ch_mode_adc_r_ck_Neg : assert property(READ_OUT_POs_to_POs_Count((({bit_mode,sp_mode}==2'b00)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),~adc_r_ck,READ_OUT_SERIAL_10BIT_16CH_T18))
  else $error("assert error: a_read_out_serial_10bit_16ch_mode_adc_r_ck_Neg");
a_read_out_serial_12bit_16ch_mode_adc_r_ck_Pos : assert property(READ_OUT_POs_to_POs_Count((({bit_mode,sp_mode}==2'b10)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),adc_r_ck,0))
  else $error("assert error: a_read_out_serial_12bit_16ch_mode_adc_r_ck_Pos");
a_read_out_serial_12bit_16ch_mode_adc_r_ck_Neg : assert property(READ_OUT_POs_to_POs_Count((({bit_mode,sp_mode}==2'b10)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),~adc_r_ck,READ_OUT_SERIAL_12BIT_16CH_T18))
  else $error("assert error: a_read_out_serial_12bit_16ch_mode_adc_r_ck_Neg");
//3.10 adc_ph_hr
a_read_out_serial_10bit_16ch_mode_adc_ph_hr_Pos : assert property(READ_OUT_POs_to_POs_Count((({bit_mode,sp_mode}==2'b00)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),adc_ph_hr,0))
  else $error("assert error: a_read_out_serial_10bit_16ch_mode_adc_ph_hr_Pos");
a_read_out_serial_10bit_16ch_mode_adc_ph_hr_Neg : assert property(READ_OUT_POs_to_POs_Period((({bit_mode,sp_mode}==2'b00)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),~adc_ph_hr,serial_10bit_16ch_t5,serial_10bit_16ch_t5))
  else $error("assert error: a_read_out_serial_10bit_16ch_mode_adc_ph_hr_Neg");
a_read_out_serial_12bit_16ch_mode_adc_ph_hr_Pos : assert property(READ_OUT_POs_to_POs_Count((({bit_mode,sp_mode}==2'b10)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),adc_ph_hr,0))
  else $error("assert error: a_read_out_serial_12bit_16ch_mode_adc_ph_hr_Pos");
a_read_out_serial_12bit_16ch_mode_adc_ph_hr_Neg : assert property(READ_OUT_POs_to_POs_Period((({bit_mode,sp_mode}==2'b00)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),~adc_ph_hr,serial_12bit_16ch_t5,serial_12bit_16ch_t5))
  else $error("assert error: a_read_out_serial_12bit_16ch_mode_adc_ph_hr_Neg");

//3.11 adc_ph_hs
a_read_out_serial_10bit_16ch_mode_adc_ph_hs_Pos : assert property(READ_OUT_POs_to_POs_Count((({bit_mode,sp_mode}==2'b00)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),adc_ph_hs,READ_OUT_SERIAL_10BIT_16CH_T6))
  else $error("assert error: a_read_out_serial_10bit_16ch_mode_adc_ph_hs_Pos");
a_read_out_serial_10bit_16ch_mode_adc_ph_hs_Neg : assert property(READ_OUT_POs_to_POs_Count((({bit_mode,sp_mode}==2'b00)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),~adc_ph_hs,READ_OUT_SERIAL_10BIT_16CH_T17))
  else $error("assert error: a_read_out_serial_10bit_16ch_mode_adc_ph_hs_Neg");
a_read_out_serial_12bit_16ch_mode_adc_ph_hs_Pos : assert property(READ_OUT_POs_to_POs_Count((({bit_mode,sp_mode}==2'b10)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),adc_ph_hs,READ_OUT_SERIAL_12BIT_16CH_T6))
  else $error("assert error: a_read_out_serial_12bit_16ch_mode_adc_ph_hs_Pos");
a_read_out_serial_12bit_16ch_mode_adc_ph_hs_Neg : assert property(READ_OUT_POs_to_POs_Count((({bit_mode,sp_mode}==2'b10)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),~adc_ph_hs,READ_OUT_SERIAL_12BIT_16CH_T17))
  else $error("assert error: a_read_out_serial_12bit_16ch_mode_adc_ph_hs_Neg");

//3.12 adc_en_ramp
a_read_out_serial_10bit_16ch_mode_adc_en_ramp_Pos : assert property(READ_OUT_POs_to_POs_Count((({bit_mode,sp_mode}==2'b00)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),adc_en_ramp,READ_OUT_SERIAL_16CH_T2))
  else $error("assert error: a_read_out_serial_10bit_16ch_mode_adc_en_ramp_Pos");
a_read_out_serial_10bit_16ch_mode_adc_en_ramp_Neg : assert property(READ_OUT_POs_to_POs_Period((({bit_mode,sp_mode}==2'b00)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),~adc_en_ramp,serial_10bit_16ch_t5,serial_10bit_16ch_t5))
  else $error("assert error: a_read_out_serial_10bit_16ch_mode_adc_en_ramp_Neg");  
a_read_out_serial_12bit_16ch_mode_adc_en_ramp_Pos : assert property(READ_OUT_POs_to_POs_Count((({bit_mode,sp_mode}==2'b10)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),adc_en_ramp,READ_OUT_SERIAL_16CH_T2))
  else $error("assert error: a_read_out_serial_12bit_16ch_mode_adc_en_ramp_Pos");
a_read_out_serial_12bit_16ch_mode_adc_en_ramp_Neg : assert property(READ_OUT_POs_to_POs_Period((({bit_mode,sp_mode}==2'b00)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),~adc_en_ramp,serial_12bit_16ch_t5,serial_12bit_16ch_t5))
  else $error("assert error: a_read_out_serial_12bit_16ch_mode_adc_en_ramp_Neg");


a_read_out_serial_10bit_16ch_mode_adc_en_ramp_Pos2 : assert property(READ_OUT_POs_to_POs_Count((({bit_mode,sp_mode}==2'b00)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),adc_en_ramp,READ_OUT_SERIAL_10BIT_16CH_T7))
  else $error("assert error: a_read_out_serial_10bit_16ch_mode_adc_en_ramp_Pos2");
a_read_out_serial_10bit_16ch_mode_adc_en_ramp_Neg2 : assert property(READ_OUT_POs_to_POs_Count((({bit_mode,sp_mode}==2'b00)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),~adc_en_ramp,READ_OUT_SERIAL_10BIT_16CH_T15))
  else $error("assert error: a_read_out_serial_10bit_16ch_mode_adc_en_ramp_Neg2");
a_read_out_serial_12bit_16ch_mode_adc_en_ramp_Pos2 : assert property(READ_OUT_POs_to_POs_Count((({bit_mode,sp_mode}==2'b10)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),adc_en_ramp,READ_OUT_SERIAL_12BIT_16CH_T7))
  else $error("assert error: a_read_out_serial_12bit_16ch_mode_adc_en_ramp_Pos2");
a_read_out_serial_12bit_16ch_mode_adc_en_ramp_Neg2 : assert property(READ_OUT_POs_to_POs_Count((({bit_mode,sp_mode}==2'b10)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),~adc_en_ramp,READ_OUT_SERIAL_12BIT_16CH_T15))
  else $error("assert error: a_read_out_serial_12bit_16ch_mode_adc_en_ramp_Neg2");
//3.13 adc_count_dn
a_read_out_serial_10bit_16ch_mode_adc_count_dn_Pos : assert property(READ_OUT_POs_to_POs_Count((({bit_mode,sp_mode}==2'b00)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),adc_count_dn,READ_OUT_SERIAL_16CH_T1))
  else $error("assert error: a_read_out_serial_10bit_16ch_mode_adc_count_dn_Pos");
a_read_out_serial_10bit_16ch_mode_adc_count_dn_Neg : assert property(READ_OUT_POs_to_POs_Count((({bit_mode,sp_mode}==2'b00)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),~adc_count_dn,READ_OUT_SERIAL_10BIT_16CH_T6))
  else $error("assert error: a_read_out_serial_10bit_16ch_mode_adc_count_dn_Neg");
a_read_out_serial_12bit_16ch_mode_adc_count_dn_Pos : assert property(READ_OUT_POs_to_POs_Count((({bit_mode,sp_mode}==2'b10)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),adc_count_dn,READ_OUT_SERIAL_16CH_T1))
  else $error("assert error: a_read_out_serial_12bit_16ch_mode_adc_count_dn_Pos");
a_read_out_serial_12bit_16ch_mode_adc_count_dn_Neg : assert property(READ_OUT_POs_to_POs_Count((({bit_mode,sp_mode}==2'b10)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),~adc_count_dn,READ_OUT_SERIAL_12BIT_16CH_T6))
  else $error("assert error: a_read_out_serial_12bit_16ch_mode_adc_count_dn_Neg");

////3.14 adc_rst_count
a_read_out_serial_16ch_mode_adc_rst_count_Pos : assert property(READ_OUT_POs_to_POs_Count((({bit_mode,sp_mode}==2'b00)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),adc_rst_count,READ_OUT_SERIAL_16CH_T1))
  else $error("assert error: a_read_out_serial_10bit_16ch_mode_adc_rst_count_Pos");
a_read_out_serial_16ch_mode_adc_rst_count_Neg : assert property(READ_OUT_POs_to_POs_Count((({bit_mode,sp_mode}==2'b00)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),~adc_rst_count,READ_OUT_SERIAL_16CH_T2))
  else $error("assert error: a_read_out_serial_10bit_16ch_mode_adc_rst_counte_Neg");

//3.14 adc_store
a_read_out_serial_10bit_16ch_mode_adc_store_Pos : assert property(READ_OUT_POs_to_POs_Count((({bit_mode,sp_mode}==2'b00)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),adc_store,READ_OUT_SERIAL_10BIT_16CH_T16))
  else $error("assert error: a_read_out_serial_10bit_16ch_mode_adc_store_Pos");
a_read_out_serial_10bit_16ch_mode_adc_store_Neg : assert property(READ_OUT_POs_to_POs_Count((({bit_mode,sp_mode}==2'b00)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),~adc_store,READ_OUT_SERIAL_10BIT_16CH_T17))
  else $error("assert error: a_read_out_serial_10bit_16ch_mode_adc_store_Neg");
a_read_out_serial_12bit_16ch_mode_adc_store_Pos : assert property(READ_OUT_POs_to_POs_Count((({bit_mode,sp_mode}==2'b10)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),adc_store,READ_OUT_SERIAL_12BIT_16CH_T16))
  else $error("assert error: a_read_out_serial_12bit_16ch_mode_adc_store_Pos");
a_read_out_serial_12bit_16ch_mode_adc_store_Neg : assert property(READ_OUT_POs_to_POs_Count((({bit_mode,sp_mode}==2'b10)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),~adc_store,READ_OUT_SERIAL_12BIT_16CH_T17))
  else $error("assert error: a_read_out_serial_12bit_16ch_mode_adc_store_Neg");
//3.15 adc_ready
a_read_out_serial_10bit_16ch_mode_adc_ready_Pos : assert property(READ_OUT_POs_to_POs_Count((({bit_mode,sp_mode}==2'b00)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),adc_ready,0))
  else $error("assert error: a_read_out_serial_10bit_16ch_mode_adc_ready_Pos");
a_read_out_serial_10bit_16ch_mode_adc_ready_Neg : assert property(READ_OUT_POs_to_POs_Count((({bit_mode,sp_mode}==2'b00)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),~adc_ready,READ_OUT_SERIAL_10BIT_16CH_T17))
  else $error("assert error: a_read_out_serial_10bit_16ch_mode_adc_ready_Neg");
a_read_out_serial_12bit_16ch_mode_adc_ready_Pos : assert property(READ_OUT_POs_to_POs_Count((({bit_mode,sp_mode}==2'b10)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),adc_ready,0))
  else $error("assert error: a_read_out_serial_12bit_16ch_mode_adc_ready_Pos");
a_read_out_serial_12bit_16ch_mode_adc_ready_Neg : assert property(READ_OUT_POs_to_POs_Count((({bit_mode,sp_mode}==2'b10)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),~adc_ready,READ_OUT_SERIAL_12BIT_16CH_T17))
  else $error("assert error: a_read_out_serial_12bit_16ch_mode_adc_ready_Neg");

//3.16 csel_st
a_read_out_serial_16ch_mode_csel_st_Pos : assert property(READ_OUT_POs_to_POs_Count((({bit_mode,sp_mode}==2'b00)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),csel_st,0))
  else $error("assert error: a_read_out_serial_10bit_16ch_mode_csel_st_Pos");
a_read_out_serial_16ch_mode_csel_st_Neg : assert property(READ_OUT_POs_to_POs_Count((({bit_mode,sp_mode}==2'b00)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),~csel_st,READ_OUT_SERIAL_16CH_T1))
  else $error("assert error: a_read_out_serial_10bit_16ch_mode_csel_st_Neg");

//3.17 slot
a_read_out_serial_16ch_mode_slot_Pos : assert property(READ_OUT_POs_to_POs_Count((({bit_mode,sp_mode}==2'b00)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),slot,0))
  else $error("assert error: a_read_out_serial_10bit_16ch_mode_slot_Pos");
a_read_out_serial_16ch_mode_slot_Neg : assert property(READ_OUT_POs_to_POs_Count((({bit_mode,sp_mode}==2'b00)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),~slot,READ_OUT_SERIAL_16CH_T1))
  else $error("assert error: a_read_out_serial_10bit_16ch_mode_slot_Neg");

//3.18 row
a_read_out_serial_16ch_mode_row_Pos : assert property(READ_OUT_POs_to_POs_Count((({bit_mode,sp_mode}==2'b00)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),row,0))
  else $error("assert error: a_read_out_serial_10bit_16ch_mode_row_Pos");
a_read_out_serial_16ch_mode_row_Neg : assert property(READ_OUT_POs_to_POs_Count((({bit_mode,sp_mode}==2'b00)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),~row,READ_OUT_SERIAL_16CH_T1))
  else $error("assert error: a_read_out_serial_10bit_16ch_mode_row_Neg");

//3.19 fot
a_read_out_serial_16ch_mode_fot_Neg : assert property(READ_OUT_POs_to_POs_Count((({bit_mode,sp_mode}==2'b00)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),~fot,0))
  else $error("assert error: a_read_out_serial_10bit_16ch_mode_fot_Neg");

//3.20 row_addr
a_read_out_serial_10bit_16ch_mode_row_addr_Pos : assert property(READ_OUT_POs_to_POs_Count((({bit_mode,sp_mode}==2'b00)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),row_addr,READ_OUT_SERIAL_10BIT_16CH_T20))
  else $error("assert error: a_read_out_serial_10bit_16ch_mode_row_addr_Pos");
a_read_out_serial_10bit_16ch_mode_row_addr_Neg : assert property(READ_OUT_POs_to_POs_Count((({bit_mode,sp_mode}==2'b00)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),~row_addr,READ_OUT_SERIAL_10BIT_16CH_T21))
  else $error("assert error: a_read_out_serial_10bit_16ch_mode_row_addr_Neg");
a_read_out_serial_12bit_16ch_mode_row_addr_Pos : assert property(READ_OUT_POs_to_POs_Count((({bit_mode,sp_mode}==2'b10)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),row_addr,READ_OUT_SERIAL_12BIT_16CH_T20))
  else $error("assert error: a_read_out_serial_12bit_16ch_mode_row_addr_Pos");
a_read_out_serial_12bit_16ch_mode_row_addr_Neg : assert property(READ_OUT_POs_to_POs_Count((({bit_mode,sp_mode}==2'b10)&&(lvds_out_m==2'b00||lvds_out_m==2'b11)),~row_addr,READ_OUT_SERIAL_12BIT_16CH_T21))
  else $error("assert error: a_read_out_serial_12bit_16ch_mode_row_addr_Neg");













  endmodule
