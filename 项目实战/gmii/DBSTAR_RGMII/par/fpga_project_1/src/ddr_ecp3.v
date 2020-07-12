`timescale 1ns/100ps
module DDR	 (rstn,
              rx_clk,
			  rx_clk_dly,
              din,
              rx_ctl,
              dout_a,
              dout_b,
              rx_ctl_a,
              rx_ctl_b,
              tx_clk,
              txd,
              td,
              tx_ctl,
              tx_er,
              tx_en
          );

input        rstn;
input        rx_clk;
input		 rx_clk_dly;
input [3:0]  din;
input        rx_ctl;
input        tx_clk;
input [7:0]  txd;
input        tx_er;
input        tx_en;


output[3:0]  dout_a /* synthesis syn_keep=1 */;
output[3:0]  dout_b /* synthesis syn_keep=1 */;
output       rx_ctl_a;
output       rx_ctl_b;
output[3:0]  td;
output       tx_ctl;


parameter DLY_VALUE = 120;

reg [3:0]	ireg_pos;
reg [3:0]	ireg_neg;
reg [3:0]	din_clk_a /* synthesis syn_keep=1 */;
reg [3:0]	din_clk_b /* synthesis syn_keep=1 */;
reg			ireg_ctl_pos;
reg			ireg_ctl_neg;
reg			rx_ctrl_a;
reg			rx_ctrl_b;
/*
always @(posedge rx_clk_dly)
begin
	ireg_pos <= din;
	ireg_ctl_pos <= rx_ctl;
end
always @(negedge rx_clk_dly)
begin
	ireg_neg <= din;
	ireg_ctl_neg <= rx_ctl;
end

always @(posedge rx_clk_dly)
begin
	din_clk_a <= ireg_pos;
	din_clk_b <= ireg_neg;
	rx_ctrl_a <= ireg_ctl_pos;
	rx_ctrl_b <= ireg_ctl_neg;
end

assign dout_a = din_clk_a;
assign dout_b = din_clk_b;
assign rx_ctl_a = rx_ctrl_a;
assign rx_ctl_b = rx_ctrl_b;
*/

wire [3:0] din_dly;
wire rx_ctl_dly;

defparam U_DLY0.C_STATIC_DLY = DLY_VALUE ;
IODELAY U_DLY0 (.DI(din[0]), .DO(din_dly[0]), .DF(), .SDTAP(1'b0), .SETN(1'b0), .VALUE(1'b0));

defparam U_DLY1.C_STATIC_DLY = DLY_VALUE ;
IODELAY U_DLY1 (.DI(din[1]), .DO(din_dly[1]), .DF(), .SDTAP(1'b0), .SETN(1'b0), .VALUE(1'b0));

defparam U_DLY2.C_STATIC_DLY = DLY_VALUE ;
IODELAY U_DLY2 (.DI(din[2]), .DO(din_dly[2]), .DF(), .SDTAP(1'b0), .SETN(1'b0), .VALUE(1'b0));

defparam U_DLY3.C_STATIC_DLY = DLY_VALUE ;
IODELAY U_DLY3 (.DI(din[3]), .DO(din_dly[3]), .DF(), .SDTAP(1'b0), .SETN(1'b0), .VALUE(1'b0));

defparam U_DLY4.C_STATIC_DLY = DLY_VALUE ;
IODELAY U_DLY4 (.DI(rx_ctl), .DO(rx_ctl_dly), .DF(), .SDTAP(1'b0), .SETN(1'b0), .VALUE(1'b0));

IDDR 
U0_IDDR
(.Q0      (dout_a[0])
,.Q1      (dout_b[0])
,.D       (din_dly[0])
,.CLK     (rx_clk_dly)
);

IDDR 
U1_IDDR
(.Q0      (dout_a[1])
,.Q1      (dout_b[1])
,.D       (din_dly[1])
,.CLK     (rx_clk_dly)
);

IDDR 
U2_IDDR
(.Q0      (dout_a[2])
,.Q1      (dout_b[2])
,.D       (din_dly[2])
,.CLK     (rx_clk_dly)
);

IDDR 
U3_IDDR
(.Q0      (dout_a[3])
,.Q1      (dout_b[3])
,.D       (din_dly[3])
,.CLK     (rx_clk_dly)
);

IDDR 
U4_IDDR
(.Q0      (rx_ctl_a)
,.Q1      (rx_ctl_b)
,.D       (rx_ctl_dly)
,.CLK     (rx_clk_dly)
);

// output DDR
ODDR U_TX_OUT0(
            .D0     (txd[0]     ),
            .D1     (txd[4]     ),
            .CLK    (tx_clk     ),
            .Q0      (td[0]      ),
            .TX(1)
        )/* synthesis ODDRAPPS = "SCLK_ALIGNED" */;

ODDR U_TX_OUT1(
            .D0     (txd[1]     ),
            .D1     (txd[5]     ),
            .CLK    (tx_clk     ),
            .Q0      (td[1]      ),
            .TX(1)
        )/* synthesis ODDRAPPS = "SCLK_ALIGNED" */;

ODDR U_TX_OUT2(
            .D0    (txd[2]     ),
            .D1    (txd[6]     ),
            .CLK   (tx_clk     ),
            .Q0     (td[2]      ),
            .TX(1) 
        )/* synthesis ODDRAPPS = "SCLK_ALIGNED" */;

ODDR U_TX_OUT3(
            .D0    (txd[3]     ),
            .D1    (txd[7]     ),
            .CLK   (tx_clk     ),
            .Q0     (td[3]      ),
            .TX(1)
        )/* synthesis ODDRAPPS = "SCLK_ALIGNED" */;

ODDR U_TX_CTL(
            .D0    (tx_en      ),
            .D1    (tx_er      ),
            .CLK   (tx_clk     ),
            .Q0     (tx_ctl     ),
            .TX(1)
        )/* synthesis ODDRAPPS = "SCLK_ALIGNED" */;


endmodule
