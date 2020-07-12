`timescale 1ns/100ps
module rgmii2gmii
(rstn
,tx_clk
,rx_clk
// port for RGMII
,td
,tx_ctl      
,rd
,rx_ctl
// port for GMII
,rxd
,rx_dv
,rx_er
,txd
,tx_en
,tx_er
,tx_clk_out1
,tx_clk_out
);

input       rstn        ;
input       tx_clk      ;
input       rx_clk      ;                       
input [7:0] txd         ;
input       tx_en       ;
input       tx_er       ;                       
output[7:0] rxd         ;
output      rx_dv       ;
output      rx_er       ;                        
input [3:0] rd          ;
input       rx_ctl      ;                        
output[3:0] td          ;
output      tx_ctl      ;
output      tx_clk_out1 ;
output      tx_clk_out  ;
reg         tx_en_buf   ;
reg         tx_er_buf   ;
reg [7:0]   txd_buf     ;
reg         rx_dv       ;
reg         rx_er       ;
reg [7:0]   rxd         ;
wire        tx_er_gen   ;
wire[3:0]   rx_out_a    ;
wire[3:0]   rx_out_b    ;
wire        rx_ctl_a    ;
wire        rx_ctl_b    ;
wire        rx_clk_dly  ;

//gmii input signals buffer
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

assign rx_clk_dly = rx_clk;

tx_pll U_PLL_TX
(.clkin       (tx_clk)
,.clkout      (tx_clk_out)
,.clkoutp     (tx_clk_outp)
,.lock        ()
);

// DDR shift register.
DDR	 U_RX
(.rstn       (rstn       )
,.rx_clk     (rx_clk     )
,.rx_clk_dly (rx_clk_dly )
,.din        (rd         )
,.rx_ctl     (rx_ctl     )
,.dout_a     (rx_out_a   )
,.dout_b     (rx_out_b   )
,.rx_ctl_a   (rx_ctl_a   )
,.rx_ctl_b   (rx_ctl_b   )
,.tx_clk     (tx_clk_out )
,.txd        (txd_buf    )
,.td         (td         )
,.tx_en      (tx_en_buf  )
,.tx_er      (tx_er_gen  )
,.tx_ctl     (tx_ctl     )
);

ODDR U_TX_CTL
(.D0    (1)
,.D1    (0)
,.CLK   (tx_clk_out)
,.Q     (tx_clk_out1)
);

endmodule
