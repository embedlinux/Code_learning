//------------------------------------------
module cir_tb();
reg clk,rst_n;
reg a;
wire[2:0] y;
integer i;
//------------------------------------------
cir_gate ugate
(.clk(clk),
 .rst_n(rst_n),
 .a(a),
 .y(y)
);
cir_rtl urtl
(.clk(clk),
 .rst_n(rst_n),
 .a(a),
 .y(y)
);
//------------------------------------------
initial begin
    clk = 1'b0;
    rst_n = 1'b0;
    a = 1'b0;
#1
    rst_n = 1'b1;
    
    for(i=0;i<20;i=i+1)
    begin
        #1
            clk = ~ clk;
    end 
#10
    $stop();
end
//------------------------------------------ 
endmodule