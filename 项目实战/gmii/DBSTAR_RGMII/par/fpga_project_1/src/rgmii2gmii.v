`timescale 1ns/100ps
module rgmii2gmii(
            rstn,
            tx_clk,
            rx_clk,

        // port for RGMII
            td,
            tx_ctl,
        
            rd,
            rx_ctl,
        
        // port for GMII
            rxd,
            rx_dv,
            rx_er,

            txd,
            tx_en,
            tx_er,
            tx_clk_out1,
            tx_clk_out
        );

input       rstn        /* synthesis IO_TYPE="LVTTL33" */;
input       tx_clk      /* synthesis IO_TYPE="HSTL15_I" */;
input       rx_clk      /* synthesis IO_TYPE="HSTL15_I" */;

input [7:0] txd         /* synthesis IO_TYPE="HSTL15_I" */;
input       tx_en       /* synthesis IO_TYPE="HSTL15_I" */;
input       tx_er       /* synthesis IO_TYPE="HSTL15_I" */;

output[7:0] rxd         /* synthesis IO_TYPE="HSTL15_I" */;
output      rx_dv       /* synthesis IO_TYPE="HSTL15_I" */;
output      rx_er       /* synthesis IO_TYPE="HSTL15_I" */;

input [3:0] rd          /* synthesis IO_TYPE="HSTL15_I" */;
input       rx_ctl      /* synthesis IO_TYPE="HSTL15_I" */;

output[3:0] td          /* synthesis IO_TYPE="HSTL15_I" */;
output      tx_ctl      /* synthesis IO_TYPE="HSTL15_I" */;
output      tx_clk_out1;
output      tx_clk_out;

reg         tx_en_buf   /* synthesis din="" */;
reg         tx_er_buf   /* synthesis din="" */;
reg [7:0]   txd_buf     /* synthesis din="" */;

reg         rx_dv       /* synthesis dout="" */;
reg         rx_er       /* synthesis dout="" */;
reg [7:0]   rxd         /* synthesis dout="" */;

wire        tx_er_gen;

wire[3:0]   rx_out_a;
wire[3:0]   rx_out_b;
wire        rx_ctl_a;
wire        rx_ctl_b;

wire        rx_clk_dly  /* synthesis syn_keep=1 frequency=125.00 */;
//wire        tx_clk_out  /* synthesis syn_keep=1 frequency=125.00 */;

//GSR GSR(rstn);


// gmii input signals buffer
always @(posedge tx_clk_out or negedge rstn)
begin
    if(!rstn) begin
        tx_en_buf <= 1'b0;
        tx_er_buf <= 1'b0;
        txd_buf   <= 8'h00;
    end else begin
        tx_en_buf <= tx_en;
        tx_er_buf <= tx_er;
        txd_buf   <= txd;
    end
end

assign tx_er_gen = tx_en_buf ^ tx_er_buf;

always @(posedge rx_clk_dly or negedge rstn)
begin
    if(!rstn) begin
        rxd     <= 8'h00;
        rx_dv   <= 1'b0;
        rx_er   <= 1'b0;
    end else begin
        rxd     <= {rx_out_b,rx_out_a};
        rx_dv   <= rx_ctl_a;
        rx_er   <= rx_ctl_a ^ rx_ctl_b;
    end
end

/*
rx_pll U_PLL_RX(
            .clkin       (rx_clk     ),
            .clkout      (      ),
            .clkoutp      (rx_clk_dly ),
            .lock       (           )
        );
*/
//assign rx_clk_dly = ~rx_clk;
assign rx_clk_dly = rx_clk;

/*
defparam U_DLY.C_STATIC_DLY = 120 ;
IODELAY U_DLY (.DI(rx_clk), .DO(rx_clk_dly), .DF(), .SDTAP(1'b0), .SETN(1'b0), .VALUE(1'b0));
*/

GW_PLL U_PLL_TX(
            .clkin       (tx_clk     ),
            .clkout      ( tx_clk_out     ),
            .clkoutp      (tx_clk_outp ),
            .lock       (           )
        );


// DDR shift register.
DDR	 U_RX(
            .rstn       (rstn       ),
            .rx_clk     (rx_clk     ),
			.rx_clk_dly (rx_clk_dly ),
            .din        (rd         ),
            .rx_ctl     (rx_ctl     ),
            .dout_a     (rx_out_a   ),
            .dout_b     (rx_out_b   ),
            .rx_ctl_a   (rx_ctl_a   ),
            .rx_ctl_b   (rx_ctl_b   ),
            .tx_clk     (tx_clk_out ),
            .txd        (txd_buf    ),
            .td         (td         ),
            .tx_en      (tx_en_buf  ),
            .tx_er      (tx_er_gen  ),
            .tx_ctl     (tx_ctl     )
        );

ODDR U_TX_CTL(
            .D0    (1      ),
            .D1    (0      ),
            .CLK   (tx_clk_out     ),
            .Q0     (tx_clk_out1     ),
            .TX (1)
        )/* synthesis ODDRAPPS = "SCLK_ALIGNED" */;

endmodule
