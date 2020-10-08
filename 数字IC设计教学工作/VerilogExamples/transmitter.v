//--------------------------------------------------------------------
//--------------------------------------------------------------------
module transmitter
(clk4x,
 rst_n,
 trs_on,
 trs_fcs,
 data_len;
 prb_num,
 data_i,
 data_rdy,
 clr_trs_on,
 poact,
 pophpdu
);
//--------------------------------------------------------------------
//--------------------------------------------------------------------
input clk4x;
input rst_n;
input trs_on;
input trs_fcs;
input prb_num;
input[7:0] data_i;
input data_rdy;
output clr_trs_on;
output poact;
output pophpdu;
//--------------------------------------------------------------------
//--------------------------------------------------------------------
reg[7:0] shift_buf;
reg[2:0] bits_cnt;
reg[3:0] phase;
reg[2:0] state;
reg[2:0] next_state;
reg trs_on_m;
//--------------------------------------------------------------------
//--------------------------------------------------------------------
parameter[2:0] IDLE = 3'b000;
parameter[2:0] TRS_PRMBL = 3'b001;
parameter[2:0] TRS_STR_DLT = 3'b010;
parameter[2:0] TRS_DLPDU = 3'b011;
parameter[2:0] TRS_FCS = 3'b100;
parameter[2:0] TRS_END_DLT = 3'b101;
//--------------------------------------------------------------------
endmodule
