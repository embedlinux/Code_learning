`timescale 1 ns/10 ps
module memsys( clk, reset, busAddr, busData, busRdWr_, adxStrb, 
            request, grant );
  input clk, reset, busRdWr_, adxStrb;
  input [13:0] busAddr;
  inout [15:0] busData;
  input [1:0] request;
  output [1:0] grant;

  wire rdWr_;
  wire ce0_,ce1_,ce2_,ce3_;
  reg oe0,oe1,oe2,oe3;
  wire [11:0] ramAddr;
  wire [15:0] ramData;
  
  wire [15:0] memOut, memOutA, memOutB; 
 
 

  always@(posedge clk)
  begin
	if (reset)
	begin
	  oe0 <= #1 0;
	  oe1 <= #1 0;
	  oe2 <= #1 0;
	  oe3 <= #1 0;
  
	end
	else 
	begin
	  oe0 <= #1 ce0_ ;
	  oe1 <= #1 ce1_ ;
	  oe2 <= #1 ~(~ce2_ && rdWr_);
	  oe3 <= #1 ~(~ce3_ && rdWr_);
  
	end
  end

  mem mem0( clk, reset, busAddr, busData, busRdWr_, adxStrb, rdWr_, ce0_,
              ce1_, ce2_, ce3_, ramAddr, ramData );
  
  arb arb0( clk, reset, request, grant );
  
  dpm16bx4096 ram0 (.CLKA(clk),
                    .CLKB(clk),
                    .AA(ramAddr),
                    .AB(ramAddr+1),
                    .CENA(ce0_),
                    .CENB(ce1_),
                    .WENA(rdWr_),
                    .WENB(rdWr_),
                    .DA(ramData),
                    .DB(ramData),
                    .QA(busData),
                    .QB(memOutB),
                    .OENA(oe0),
                    .OENB(oe1)
                    );   


endmodule















