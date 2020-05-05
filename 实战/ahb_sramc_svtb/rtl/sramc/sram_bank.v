
module sram_bank (
    		           QA,
                   QB,
                   CLKA,
                   CENA,
                   WENA,
                   AA,
                   DA,
                   CLKB,
                   CENB,
                   WENB,
                   AB,
                   DB,
                   EMAA,
                   EMAB
                 );

   output [31:0]            QA;
   output [31:0]            QB;
   input                    CLKA;
   input  [3:0]             CENA;
   input                    WENA;
   input [11:0]             AA;
   input [31:0]             DA;
   input                    CLKB;
   input                    CENB;
   input                    WENB;
   input [11:0]             AB;
   input [7:0]              DB;
   input [2:0]              EMAA;
   input [2:0]              EMAB;


SRAM_DP_4KX8 SRAM_BANK1_U1  (
                .QA  	  (QA[7:0]),
                .QB 	  (),
                .CLKA	  (CLKA),
                .CENA	  (CENA[0]),
                .WENA	  (WENA),
                .AA     (AA),
                .DA	    (DA[7:0]),
                .CLKB   (1'b1),
                .CENB   (1'b1),
                .WENB   (1'b1),
                .AB     (12'h000),
                .DB     (8'h00),
                .EMAA   (3'h0),
                .EMAB   (3'h0)
                );
SRAM_DP_4KX8 SRAM_BANK1_U2  (
                .QA	    (QA[15:8]),
                .QB 	  (),
                .CLKA	  (CLKA),
                .CENA	  (CENA[1]),
                .WENA	  (WENA),
                .AA     (AA),
                .DA  	  (DA[15:8]),
                .CLKB   (1'b1),
                .CENB   (1'b1),
                .WENB   (1'b1),
                .AB     (12'h000),
                .DB     (8'h00),
                .EMAA   (3'h0),
                .EMAB   (3'h0)
                );
SRAM_DP_4KX8 SRAM_BANK1_U3  (
                .QA	    (QA[23:16]),
                 .QB 	  (),
                .CLKA	  (CLKA),
                .CENA	  (CENA[2]),
                .WENA	  (WENA),
                .AA     (AA),
                .DA	    (DA[23:16]),
                .CLKB   (1'b1),
                .CENB   (1'b1),
                .WENB   (1'b1),
                .AB     (12'h000),
                .DB     (8'h00),
                .EMAA   (3'h0),
                .EMAB   (3'h0)
                );
SRAM_DP_4KX8 SRAM_BANK1_U4  (
                .QA 	  (QA[31:24]),
                .QB 	  (),
                .CLKA	  (CLKA),
                .CENA	  (CENA[3]),
                .WENA	  (WENA),
                .AA     (AA),
                .DA	    (DA[31:24]),
                .CLKB   (1'b1),
                .CENB   (1'b1),
                .WENB   (1'b1),
                .AB     (12'h000),
                .DB     (8'h00),
                .EMAA   (3'h0),
                .EMAB   (3'h0)
                );
endmodule
