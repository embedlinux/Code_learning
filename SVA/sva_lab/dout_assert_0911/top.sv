
`timescale 1ns/10ps

 `include "./assertion.sv"

module top();
 reg          exp_ext;
 reg   [26:0] exp_time;

 reg          rst;
reg            dig_clk;
reg            sys_clk;
reg            frame_reg;
reg            t_exp;


reg rowdec_rd_en  ; 
reg rowdec_clk_rd ; 
reg rowdec_s2_rd  ; 
reg rowdec_rst    ; 
reg rowdec_tx     ; 
reg rowdec_pc     ; 
reg rowdec_s1     ; 
reg rowdec_s2_gl  ; 
reg pga_en_az     ; 
reg pga_c1        ; 
reg pga_c2        ; 
reg pga_rst       ; 
reg pga_ph_sr     ; 
reg pga_ph_ss     ; 
reg pga_en_blksun ; 
reg pga_ph_offset ; 
reg pixel_precharge ;
reg adc_r_ck      ; 
reg adc_ph_hr     ; 
reg adc_ph_hs     ; 
reg adc_en_ramp   ; 
reg adc_count_dn  ; 
reg adc_rst_count ; 
reg adc_store     ; 
reg adc_ready     ; 
reg csel_st       ; 
reg fval          ; 
reg lval          ; 
reg dval          ; 
reg slot          ; 
reg row           ; 
reg inte1         ; 
reg inte2         ; 
reg fot           ; 
reg row_st        ; 
reg row_addr      ; 


reg bit_mode;
reg sp_mode;

reg [1:0] lvds_out_m;





reg ext_clk1;
reg clk;
time clk48m=20.8ns;
initial begin
  clk = 1'b0;
  forever #2.5 clk = ~clk;
end
initial begin
  ext_clk1=1'b1;
  forever #10.4 ext_clk1=~ext_clk1;
end

assertion assertion_u(
               .exp_ext(exp_ext),
               .exp_time(exp_time),
               .bit_mode(bit_mode),
               .sp_mode(sp_mode),
               .lvds_out_m(lvds_out_m),

               .rst(rst),
               .dig_clk(ext_clk1),
               .sys_clk(clk),
               .frame_reg(frame_reg),
               .t_exp(t_exp),
               .rowdec_rd_en(rowdec_rd_en)      ,  
               .rowdec_clk_rd(rowdec_clk_rd)     ,  
               .rowdec_s2_rd(rowdec_s2_rd)      ,  
               .rowdec_rst(rowdec_rst)        ,  
               .rowdec_tx(rowdec_tx)         ,  
               .rowdec_pc(rowdec_pc)         ,  
               .rowdec_s1(rowdec_s1)         ,  
               .rowdec_s2_gl(rowdec_s2_gl)      ,  
               .pga_en_az(pga_en_az)         ,  
               .pga_c1(pga_c1)            ,  
               .pga_c2(pga_c2)            ,  
               .pga_rst(pga_rst)           ,  
               .pga_ph_sr(pga_ph_sr)         ,  
               .pga_ph_ss(pga_ph_ss)         ,  
               .pga_en_blksun(pga_en_blksun)     ,  
               .pga_ph_offset(pga_ph_offset)     ,  
               .pixel_precharge(pixel_precharge)   ,  
               .adc_r_ck(adc_r_ck)          ,  
               .adc_ph_hr(adc_ph_hr)         ,  
               .adc_ph_hs(adc_ph_hs)         ,  
               .adc_en_ramp(adc_en_ramp)       ,  
               .adc_count_dn(adc_count_dn)      ,  
               .adc_rst_count(adc_rst_count)     ,  
               .adc_store(adc_store)         ,  
               .adc_ready(adc_ready)         ,  
               .csel_st(csel_st)           ,  
               .fval(fval)              ,  
               .lval(lval)              ,  
               .dval(dval)              ,  
               .slot(slot)              ,  
               .row(row)               ,  
               .inte1(inte1)             ,  
               .inte2(inte2)             ,  
               .fot(fot)               ,  
               .row_st(row_st)            ,  
               .row_addr(row_addr)                 


);
                   
  string testname="";
  string dumppath="dump.fsdb";
  initial begin
 //   if ($value$plusargs("UVM_TESTNAME=%s", testname)) begin
 //   `uvm_info("configure TOP", $psprintf("UVM_TESTNAME =  %s",testname), UVM_NONE)
 //   dumppath = $psprintf("log/%s/%s.fsdb",testname,testname);
 // end
   $vcdpluson(0,top);

 //   $fsdbDumpfile(dumppath);
 //   $fsdbDumpvars() ;
 // //   $fsdbDumpSVA();
  end

initial begin
 rst = 1;
#10;
 rst = 0;
#50;
 rst = 1;
#10000;
 $finish;
end

initial begin
  frame_reg = 0;
  exp_ext = 0;
  exp_time = 140;
  t_exp  = 0;
  rowdec_tx = 1;
  inte1 = 0;
  inte2 = 0;
  bit_mode = 0;
  sp_mode = 0;
  rowdec_s1 = 0;
  fot =0;
  #200;
  frame_reg = 1;
  #19;
  rowdec_tx = 0;
  inte1 = 1;
  inte2 = 1;
  #40;
  frame_reg = 0;
  #100;
  inte1 = 0;
  inte2 = 0;
  #100;
  fot = 1;
  #(240*20.8);
  rowdec_s1 = 1;
#(1920*20.8);
  rowdec_s1 = 0;

end

endmodule


