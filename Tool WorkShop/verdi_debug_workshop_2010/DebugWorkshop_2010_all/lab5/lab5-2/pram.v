// ************************************************************************
// *  NOVAS SOFTWARE CONFIDENTIAL PROPRIETARY NOTE                        *
// *                                                                      *
// *  This software contains information confidential and proprietary     *
// *  to Novas Software Inc. It shall not be reproduced in whole          *
// *  or in part or transferred to other documents, or disclosed          *
// *  to third parties, or used for any purpose other than that           *
// *  for which it was obtained, without the prior written consent        *
// *  of Novas Software Inc.                                              *
// *  (c) 1996, 1997, 1998 Novas Software Inc.                            *
// *  All rights reserved                                                 *
// *                                                                      *
// ************************************************************************

/* Verdi tutorial case: A simplified microprogramming-based CPU
   file name: pram.v
   description: This part modelize the program memory for the system operation

		clock: system clock
		VMA: valid memory address where read/write can be performed
		R_W: memory read or memory write
		addr: 8-bits address bus
		data: 8-bits data bus
*/

module pram(clock,VMA,R_W,BUSY,addr,data);
input clock;
input VMA;
input R_W;
output BUSY;
input [7:0] addr;
inout [7:0] data;

reg [7:0] dataout;
reg BUSY;
reg Reading;
reg [7:0] Writing;

reg [7:0] macroram [255:0];

assign data = R_W ? dataout : 8'hz;

initial
   begin
        BUSY = 0;
        Reading = 0;
        Writing = 0;
    end

always @(posedge clock or negedge clock)
begin
        if (clock) begin
                if (Reading) begin
                        BUSY = #1 0;
                        Reading = #1 0;
                end
                else if (Writing != 0) begin
                        if (Writing >= 3 ) begin
                                BUSY = #1 0;
                                Writing = #1 0;
                        end
                        else
                                Writing = #1 Writing +1;
                end

        end
        else if(!clock) begin
                if (VMA && R_W) begin
                        BUSY = #1 1;
                        Reading = #1 1;
                end
                else if (VMA && !R_W && (Writing==0)) begin
                        BUSY = #1 1;
                        Writing = #1 1;
                end
        end
end

initial
begin
	$readmemb("./memory/pram.dat",macroram);
end

always @(posedge clock)
begin
	if (VMA)
          if (R_W == 1) 
		dataout=macroram[addr];
          else 
		macroram[addr]=data;
end

endmodule
