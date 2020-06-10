`timescale 1 ns/10 ps
module tb_memsys;
  parameter PERIOD = 20;

  reg clk, reset;
  reg busRdWr_, adxStrb;
  reg [13:0] busAddr;
  wire [15:0] busData;
  reg [15:0] busData_r;

  reg [1:0] request;
  wire [1:0] grant;

  integer i;
  //integer r;

  integer randomVar0, randomVar1;
  reg [13:0] address0;
  reg [15:0] data0In, data0Out;
  reg [13:0] address1;
  reg [15:0] data1In, data1Out;

  task writeOp0;
   input [13:0] adx;
   input [15:0] data;
  begin
    @(posedge clk)	request[0] <= #1 1'b1;
    @(posedge clk)	wait(grant[0] == 1'b1);
			writeData(adx,data);
    			request[0] <= #1 1'b0;
  end
  endtask

  task writeOp1;
   input [13:0] adx;
   input [15:0] data;
  begin
    @(posedge clk)	request[1] <= #1 1'b1;
    @(posedge clk)	wait(grant[1] == 1'b1);
			writeData(adx,data);
    			request[1] <= #1 1'b0;
  end
  endtask

  task writeData;
   input [13:0] adx;
   input [15:0] data;
  begin
    @(posedge clk)	busAddr <= #1 adx;
    			busData_r <= #1 data;
    			busRdWr_ <= #1 1'b0;
    			adxStrb <= #1 1'b1;
    @(posedge clk) 	busData_r <= #1 16'hzzzz;
			busRdWr_ <= #1 1'b1;
    			adxStrb <= #1 1'b0;
    repeat(4) @(posedge clk);
  end
  endtask

  task readOp0;
   input [13:0] adx;
   input [15:0] data;
  begin
    @(posedge clk)	request[0] <= #1 1'b1;
    @(posedge clk)	wait(grant[0] == 1'b1);
			readData(adx,data);
    			request[0] <= #1 1'b0;
  end
  endtask

  task readOp1;
   input [13:0] adx;
   input [15:0] data;
  begin
    @(posedge clk)	request[1] <= #1 1'b1;
    @(posedge clk)	wait(grant[1] == 1'b1);
			readData(adx,data);
    			request[1] <= #1 1'b0;
  end
  endtask

  task readData;
   input [13:0] adx;
   input [15:0] data;
  begin
    @(posedge clk)	busAddr <= #1  adx;
    			busRdWr_ <= #1 1'b1;
    			adxStrb <= #1 1'b1;
    @(posedge clk)	adxStrb <= #1 1'b0;
    repeat(3) @(posedge clk);
    			data <= #1 busData;
  end
  endtask

  memsys memsys0( clk, reset, busAddr, busData, busRdWr_, adxStrb, 
             request, grant );

  initial begin 
    clk = 1'b0; 
    forever #(PERIOD/2) clk = ~clk;
  end

  assign busData=busData_r;

  initial begin

       $fsdbDumpfile("memsys.fsdb");
       $fsdbDumpvars;
       // kevin $nMonitor("pcode");

       reset <= #1 1;
       adxStrb <= #1  1'b0;
       request <= #1  2'b00;
       busData_r <= #1  16'hzzzz;
       repeat(4) @(posedge clk);	reset <= #1 0;
			
	//r = $random(34599);
        fork 
           begin 
             repeat(64) begin 
               randomVar0 = $random;
               address0 = {randomVar0[29:16],1'b0};
               data0In = randomVar0[15:0];

               writeOp0(address0, data0In);
 	       repeat(randomVar0[19:16]) @(posedge clk);

               readOp0(address0,data0Out);
 	       repeat(randomVar0[23:20]) @(posedge clk);
             end 
           end 
  
           begin 
 	     repeat(10) @(posedge clk);
             repeat(64) begin 
               randomVar1 = $random;
               address1 = {randomVar1[29:16],1'b1};
               data1In = randomVar1[15:0];

 	       repeat(randomVar1[19:16]) @(posedge clk);
               writeOp1(address1, data1In);

 	       repeat(randomVar1[23:20]) @(posedge clk);
               readOp1(address1,data1Out);
             end 
           end 
  
        join

       @(posedge clk) $finish;
  end

endmodule


