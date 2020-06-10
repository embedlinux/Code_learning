`timescale 1 ns/10 ps
//`celldefine
module dpm16bx4096 (
   QA,
   CLKA,
   CENA,
   WENA,
   AA,
   DA,
   OENA,
   QB,
   CLKB,
   CENB,
   WENB,
   AB,
   DB,
   OENB
);
   parameter		   BITS = 16;
   parameter		   word_depth = 4096;
   parameter		   addr_width = 12;
   parameter		   wordx = {BITS{1'bx}};
   parameter		   addrx = {addr_width{1'bx}};
	
   output [15:0] QA;
   input CLKA;
   input CENA;
   input WENA;
   input [11:0] AA;
   input [15:0] DA;
   input OENA;
   output [15:0] QB;
   input CLKB;
   input CENB;
   input WENB;
   input [11:0] AB;
   input [15:0] DB;
   input OENB;

   reg [BITS-1:0]	   mem [word_depth-1:0];
   reg                     NOT_CONTA;
   reg                     NOT_CONTB;

   reg			   NOT_CENA;
   reg			   NOT_WENA;

   reg			   NOT_AA0;
   reg			   NOT_AA1;
   reg			   NOT_AA2;
   reg			   NOT_AA3;
   reg			   NOT_AA4;
   reg			   NOT_AA5;
   reg			   NOT_AA6;
   reg			   NOT_AA7;
   reg			   NOT_AA8;
   reg			   NOT_AA9;
   reg			   NOT_AA10;
   reg			   NOT_AA11;
   reg [addr_width-1:0]	   NOT_AA;
   reg			   NOT_DA0;
   reg			   NOT_DA1;
   reg			   NOT_DA2;
   reg			   NOT_DA3;
   reg			   NOT_DA4;
   reg			   NOT_DA5;
   reg			   NOT_DA6;
   reg			   NOT_DA7;
   reg			   NOT_DA8;
   reg			   NOT_DA9;
   reg			   NOT_DA10;
   reg			   NOT_DA11;
   reg			   NOT_DA12;
   reg			   NOT_DA13;
   reg			   NOT_DA14;
   reg			   NOT_DA15;
   reg [BITS-1:0]	   NOT_DA;
   reg			   NOT_CLKA_PER;
   reg			   NOT_CLKA_MINH;
   reg			   NOT_CLKA_MINL;
   reg			   NOT_CENB;
   reg			   NOT_WENB;

   reg			   NOT_AB0;
   reg			   NOT_AB1;
   reg			   NOT_AB2;
   reg			   NOT_AB3;
   reg			   NOT_AB4;
   reg			   NOT_AB5;
   reg			   NOT_AB6;
   reg			   NOT_AB7;
   reg			   NOT_AB8;
   reg			   NOT_AB9;
   reg			   NOT_AB10;
   reg			   NOT_AB11;
   reg [addr_width-1:0]	   NOT_AB;
   reg			   NOT_DB0;
   reg			   NOT_DB1;
   reg			   NOT_DB2;
   reg			   NOT_DB3;
   reg			   NOT_DB4;
   reg			   NOT_DB5;
   reg			   NOT_DB6;
   reg			   NOT_DB7;
   reg			   NOT_DB8;
   reg			   NOT_DB9;
   reg			   NOT_DB10;
   reg			   NOT_DB11;
   reg			   NOT_DB12;
   reg			   NOT_DB13;
   reg			   NOT_DB14;
   reg			   NOT_DB15;
   reg [BITS-1:0]	   NOT_DB;
   reg			   NOT_CLKB_PER;
   reg			   NOT_CLKB_MINH;
   reg			   NOT_CLKB_MINL;

   reg			   LAST_NOT_CENA;
   reg			   LAST_NOT_WENA;
   reg [addr_width-1:0]	   LAST_NOT_AA;
   reg [BITS-1:0]	   LAST_NOT_DA;
   reg			   LAST_NOT_CLKA_PER;
   reg			   LAST_NOT_CLKA_MINH;
   reg			   LAST_NOT_CLKA_MINL;
   reg			   LAST_NOT_CENB;
   reg			   LAST_NOT_WENB;
   reg [addr_width-1:0]	   LAST_NOT_AB;
   reg [BITS-1:0]	   LAST_NOT_DB;
   reg			   LAST_NOT_CLKB_PER;
   reg			   LAST_NOT_CLKB_MINH;
   reg			   LAST_NOT_CLKB_MINL;

   reg                     LAST_NOT_CONTA;
   reg                     LAST_NOT_CONTB;
   wire                    contA_flag;
   wire                    contB_flag;
   wire                    cont_flag;

   wire [BITS-1:0]   _QA;
   wire			   _OENAi;
   wire [addr_width-1:0]   _AA;
   wire			   _CLKA;
   wire			   _CENA;
   wire			   _OENA;
   wire                    _WENA;

   wire [BITS-1:0]   _DA;
   wire                    re_flagA;
   wire                    re_data_flagA;

   wire [BITS-1:0]   _QB;
   wire			   _OENBi;
   wire [addr_width-1:0]   _AB;
   wire			   _CLKB;
   wire			   _CENB;
   wire			   _OENB;
   wire                    _WENB;

   wire [BITS-1:0]   _DB;
   wire                    re_flagB;
   wire                    re_data_flagB;


   reg			   LATCHED_CENA;
   reg	                  LATCHED_WENA;
   reg [addr_width-1:0]	   LATCHED_AA;
   reg [BITS-1:0]	   LATCHED_DA;
   reg			   LATCHED_CENB;
   reg	                  LATCHED_WENB;
   reg [addr_width-1:0]	   LATCHED_AB;
   reg [BITS-1:0]	   LATCHED_DB;

   reg			   CENAi;
   reg           	   WENAi;
   reg [addr_width-1:0]	   AAi;
   reg [BITS-1:0]	   DAi;
   reg [BITS-1:0]	   QAi;
   reg [BITS-1:0]	   LAST_QAi;
   reg			   CENBi;
   reg           	   WENBi;
   reg [addr_width-1:0]	   ABi;
   reg [BITS-1:0]	   DBi;
   reg [BITS-1:0]	   QBi;
   reg [BITS-1:0]	   LAST_QBi;



   reg			   LAST_CLKA;
   reg			   LAST_CLKB;



   reg                     valid_cycleA;
   reg                     valid_cycleB;



endmodule
//`endcelldefine






