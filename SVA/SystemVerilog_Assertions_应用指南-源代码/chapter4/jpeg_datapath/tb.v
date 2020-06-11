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

module tb;

logic rd, clk, get_data, reset_, done_frame;
logic [ADDR_WIDTH-1:0] rd_addr;



wire [RAM_DATA_WIDTH-1:0] data;

ram262144x8 ram (.data(data), .rd(rd), .wr(1'b0), .memory_enable(1'b1), .addr(rd_addr));
jpeg jpeg_int (.*);



always #5 clk = ~clk;

initial begin
clk = 0;
reset_ = 0;
get_data = 0;
#30
reset_ = 1;
#10
get_data = 1;
wait (done_frame ==1);
get_data = 0;
wait (done_frame ==0);
#2000
$finish;
end

initial $readmemh("grande_image.dat", ram.mem);

initial
begin
$vcdpluson();
end
endmodule
