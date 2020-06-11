/************************************************************************\
|*                                                                      *|
|*    Copyright (c) 2005  Springer. All rights reserved.                *|
|*                                                                      *|
|*  This example code shouyld be used only for illustration purpose     *| 
|*  This material is not to reproduced,  copied,  or used  in any       *|
|*  manner without the authorization of the author's/publishers         *|
|*  written permission                                                  *|
|*                                                                      *|
\************************************************************************/

// Author: Srikanth Vijayaraghavan and Meyyappan Ramanathan


module sig_sva (a, b, clk);

`include "config.v" 

input logic a, b, clk;

// property for level sensitive signals (4)

property p_1_hh;
	@(posedge clk) a && b;
endproperty

property p_1_hl;
	@(posedge clk) a && !b;
endproperty

property p_1_lh;
	@(posedge clk) !a && b;
endproperty

property p_1_ll;
	@(posedge clk) !a && !b;
endproperty

// properties for edge sensitive signals (4)

property p2_ff;
	@(posedge clk) $fell(a) && $fell(b);
endproperty
	
property p2_fr;
	@(posedge clk) $fell(a) && $rose(b);
endproperty

property p2_rf;
	@(posedge clk) $rose(a) && $fell(b);
endproperty
	
property p2_rr;
	@(posedge clk) $rose(a) && $rose(b);
endproperty

// logical relationship between 2 level sensitive signals with
// overlapping implication (4)

property p4_oli_hh;
	@(posedge clk) a |-> b;
endproperty

property p4_oli_hl;
	@(posedge clk) a |-> !b;
endproperty

property p4_oli_lh;
	@(posedge clk) !a |-> b;
endproperty

property p4_oli_ll;
	@(posedge clk) !a |-> !b;
endproperty

// property for timing relationship between 2 level sensitive signals (8)

property p3_hh;
	@(posedge clk) a ##min_time b;
endproperty

property p3_hl;
	@(posedge clk) a ##min_time !b;
endproperty

property p3_lh;
	@(posedge clk) !a ##min_time b;
endproperty

property p3_ll;
	@(posedge clk) !a ##min_time !b;
endproperty

property p3_w1_hh;
	@(posedge clk) a ## [min_time : max_time] b;
endproperty

property p3_w2_hl;
	@(posedge clk) a ## [min_time : max_time] !b;
endproperty

property p3_w3_lh;
	@(posedge clk) !a ## [min_time : max_time] b;
endproperty

property p3_w4_ll;
	@(posedge clk) !a ## [min_time : max_time] !b;
endproperty

// properties for ovelapping implication with edge sensitive signals (4)

property p4_oei_ff;
	@(posedge clk) $fell(a) |-> $fell(b);
endproperty
	
property p4_oei_fr;
	@(posedge clk) $fell(a) |-> $rose(b);
endproperty

property p4_oei_rf;
	@(posedge clk) $rose(a) |-> $fell(b);
endproperty
	
property p4_oei_rr;
	@(posedge clk) $rose(a) |-> $rose(b);
endproperty

// property for timing relationship between 2 edge sensitive signals (8)

property p4_f_ff;
	@(posedge clk) $fell(a) ##min_time $fell(b);
endproperty
	
property p4_f_rr;
	@(posedge clk) $rose(a) ##min_time $rose(b);
endproperty

property p4_f_fr;
	@(posedge clk) $fell(a) ##min_time $rose(b);
endproperty

property p4_f_rf;
	@(posedge clk) $rose(a) ##min_time $fell(b);
endproperty

property p4_w_ff;
	@(posedge clk) $fell(a) ##[min_time : max_time] $fell(b);
endproperty
	
property p4_w_rr;
	@(posedge clk) $rose(a) ##[min_time : max_time] $rose(b);
endproperty

property p4_w_fr;
	@(posedge clk) $fell(a) ##[min_time : max_time] $rose(b);
endproperty

property p4_w_rf;
	@(posedge clk) $rose(a) ##[min_time : max_time] $fell(b);
endproperty

// property for timing relationship between 2 level sensitive signals
// with nonoverlapping implication and fixed time (4)

property p5_f_hh;
	@(posedge clk) a |-> ##min_time b;
endproperty

property p5_f_hl;
	@(posedge clk) a |-> ##min_time !b;
endproperty

property p5_f_lh;
	@(posedge clk) !a |-> ##min_time b;
endproperty

property p5_f_ll;
	@(posedge clk) !a |-> ##min_time !b;
endproperty

// property for timing relationship between 2 level sensitive signals
// with nonoverlapping implication and variable time (4)

property p5_w_hh;
	@(posedge clk) a |-> ##[min_time : max_time] b;
endproperty

property p5_w_hl;
	@(posedge clk) a |-> ##[min_time : max_time] !b;
endproperty

property p5_w_lh;
	@(posedge clk) !a |-> ##[min_time : max_time] b;
endproperty

property p5_w_ll;
	@(posedge clk) !a |-> ##[min_time : max_time] !b;
endproperty

// property for timing relationship between 2 edge sensitive signals
// with nonoverlapping implication (8)

property p6_f_ff;
	@(posedge clk) $fell(a) |-> ##min_time $fell(b);
endproperty
	
property p6_f_rr;
	@(posedge clk) $rose(a) |-> ##min_time $rose(b);
endproperty

property p6_f_fr;
	@(posedge clk) $fell(a) |-> ##min_time $rose(b);
endproperty

property p6_f_rf;
	@(posedge clk) $rose(a) |-> ##min_time $fell(b);
endproperty

property p6_w_ff;
	@(posedge clk) $fell(a) |-> ##[min_time : max_time] $fell(b);
endproperty
	
property p6_w_rr;
	@(posedge clk) $rose(a) |-> ##[min_time : max_time] $rose(b);
endproperty

property p6_w_fr;
	@(posedge clk) $fell(a) |-> ##[min_time : max_time] $rose(b);
endproperty

property p6_w_rf;
	@(posedge clk) $rose(a) |-> ##[min_time : max_time] $fell(b);
endproperty

// property with consecutive repetition
// repeat after and repeat until (8)

property p7_c_rpt_rh;
	@(posedge clk) $rose(a) ##start_wait b[*repetition];
endproperty

property p7_c_rpt_rl;
	@(posedge clk) $rose(a) ##start_wait !b[*repetition];
endproperty

property p7_c_rpt_fh;
	@(posedge clk) $fell(a) ##start_wait b[*repetition];
endproperty

property p7_c_rpt_fl;
	@(posedge clk) $fell(a) ##start_wait !b[*repetition];
endproperty

property p7_cu_rpt_rl;
	@(posedge clk) $rose(b) ##0 b[*1:$] ##1 !a;
endproperty

property p7_cu_rpt_fl;
	@(posedge clk) $fell(b) ##0 !b[*1:$] ##1 !a;
endproperty

property p7_cu_rpt_rh;
	@(posedge clk) $rose(b) ##0 b[*1:$] ##1 a;
endproperty

property p7_cu_rpt_fh;
	@(posedge clk) $fell(b) ##0 !b[*1:$] ##1 a;
endproperty

// code to selectively include assertions

always@(posedge clk)
begin

// logical relationship between 2 level sensitive signals

if(logic_op == 1 && timing == 0 && sig_edge == 0)
begin
a_1_hh : assert property(p_1_hh);
a_1_hl : assert property(p_1_hl);
a_1_lh : assert property(p_1_lh);
a_1_ll : assert property(p_1_ll);
end

// logical relationship between 2 edge sensitive signals FF,FR

if(logic_op == 1 && timing == 0 && sig_edge == 1 && sig1_edge == 0)
begin
a2_ff: assert property(p2_ff); 
a2_fr: assert property(p2_fr); 
end

// logical relationship between 2 edge sensitive signals RF,RR

if(logic_op == 1 && timing == 0 && sig_edge == 1 && sig1_edge == 1)
begin
a2_rf: assert property(p2_rf); 
a2_rr: assert property(p2_rr);
end

// timing relationship between 2 level sensitive signals

if(logic_op == 0 && timing == 1 && sig_edge == 0 && non_o_implication == 0)
begin
if(min_time == max_time)
begin
if(timing_level == 2'b11) 
	a3_hh: assert property(p3_hh);
if(timing_level == 2'b10) 
	a3_hl: assert property(p3_hl);
if(timing_level == 2'b01) 
	a3_lh: assert property(p3_lh);
if(timing_level == 2'b00) 
	a3_ll: assert property(p3_ll);
end
if(min_time != max_time)
begin
if(timing_level == 2'b11) 
	a3_w1_hh: assert property(p3_w1_hh);
if(timing_level == 2'b10) 
	a3_w2_hl: assert property(p3_w2_hl);
if(timing_level == 2'b01) 
	a3_w3_lh: assert property(p3_w3_lh);
if(timing_level == 2'b00) 
	a3_w4_ll: assert property(p3_w4_ll);
end
end

// logical relationship between 2 level sensitive signals with
// overlapping implication

if((logic_op == 1 || o_l_implication == 1) && timing == 0 && sig_edge == 0)
begin
a4_oli_hh: assert property(p4_oli_hh);
a4_oli_hl: assert property(p4_oli_hl);
a4_oli_lh: assert property(p4_oli_lh);
a4_oli_ll: assert property(p4_oli_ll);
end

// logical relationship between 2 edge sensitive signals with
// overlapping implication FF, FR

if((logic_op == 1 || o_e_implication == 1) && timing == 0 && sig_edge == 1 && sig1_edge == 0)
begin
a4_oei_ff: assert property(p4_oei_ff);
a4_oei_fr: assert property(p4_oei_fr);
end

// logical relationship between 2 edge sensitive signals with
// overlapping implication RF, RR

if((logic_op == 1 || o_e_implication == 1) && timing == 0 && sig_edge == 1 && sig1_edge == 1)
begin
a4_oei_rf: assert property(p4_oei_rf);
a4_oei_rr: assert property(p4_oei_rr);
end

if(logic_op == 0 && timing == 1 && sig_edge == 1 && non_o_implication == 0)
begin
if(min_time == max_time) 
begin
a4_f_rr: assert property(p4_f_rr);
a4_f_ff: assert property(p4_f_ff);
a4_f_rf: assert property(p4_f_rf);
a4_f_fr: assert property(p4_f_fr);
end

if(min_time != max_time)
begin
a4_w_rr: assert property(p4_w_rr);
a4_w_ff: assert property(p4_w_ff);
a4_w_rf: assert property(p4_w_rf);
a4_w_fr: assert property(p4_w_fr);
end

end

// timing relation between 2 level sensitive signals 
// with non-overlapping implication

if(logic_op == 0 && timing == 1 && sig_edge == 0 && non_o_implication == 1)
begin
if(min_time == max_time)
begin
if(timing_level == 2'b11) 
	a5_f_hh: assert property(p5_f_hh);
if(timing_level == 2'b10) 
	a5_f_hl: assert property(p5_f_hl);
if(timing_level == 2'b01) 
	a5_f_lh: assert property(p5_f_lh);
if(timing_level == 2'b00) 
	a5_f_ll: assert property(p5_f_ll);
end
if(min_time != max_time)
begin
if(timing_level == 2'b11) 
	a5_w_hh: assert property(p5_w_hh);
if(timing_level == 2'b10) 
	a5_w_hl: assert property(p5_w_hl);
if(timing_level == 2'b01) 
	a5_w_lh: assert property(p5_w_lh);
if(timing_level == 2'b00) 
	a5_w_ll: assert property(p5_w_ll);
end
end

// timing relation between 2 edge sensitive signals 
// with non-overlapping implication

if(logic_op == 0 && timing == 1 && sig_edge == 1 && non_o_implication == 1)
begin

if(min_time == max_time) 
begin
a6_f_rr: assert property(p6_f_rr);
a6_f_ff: assert property(p6_f_ff);
a6_f_rf: assert property(p6_f_rf);
a6_f_fr: assert property(p6_f_fr);
end

if(min_time != max_time)
begin
a6_w_rr: assert property(p6_w_rr);
a6_w_ff: assert property(p6_w_ff);
a6_w_rf: assert property(p6_w_rf);
a6_w_fr: assert property(p6_w_fr);
end

end

if(rpt_me == 1 && c_rpt == 1 && rpt_edge == 2'b11)
begin
a7_c_rpt_rh: assert property(p7_c_rpt_rh);
a7_cu_rpt_rh: assert property(p7_cu_rpt_rh);
end

if(rpt_me == 1 && c_rpt == 1 && rpt_edge == 2'b10)
begin
a7_c_rpt_rl: assert property(p7_c_rpt_rl);
a7_cu_rpt_rl: assert property(p7_cu_rpt_rl);
end

if(rpt_me == 1 && c_rpt == 1 && rpt_edge == 2'b01)
begin
a7_c_rpt_fh: assert property(p7_c_rpt_fh);
a7_cu_rpt_fh: assert property(p7_cu_rpt_fh);
end

if(rpt_me == 1 && c_rpt == 1 && rpt_edge == 2'b00)
begin
a7_c_rpt_fl: assert property(p7_c_rpt_fl);
a7_cu_rpt_fl: assert property(p7_cu_rpt_fl);
end

end


// Config Parameters illegal values
// If logical_op is asserted then timing cannot be asserted

property config_check1;
	@(posedge clk) (logic_op == 1) |-> (timing == 0);
endproperty 

// only one of the implication operators can be asserted at any time
property config_check2;
	@(posedge clk) $onehot0({o_l_implication, o_e_implication, non_o_implication});
endproperty 

// min_time should be atleast 1
property config_check3;
	@(posedge clk) (timing == 1) |-> (min_time >= 1);
endproperty 

// repetition should be greater that one
property config_check4;
	@(posedge clk) ((c_rpt == 1) && (rpt_me == 1)) |-> (repetition > 1);
endproperty 

a_check1: assert property(config_check1);
a_check2: assert property(config_check2);
a_check3: assert property(config_check3);
a_check4: assert property(config_check4);
endmodule
