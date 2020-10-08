//------------------------------------------------
module nand2 (a,b,y);
input a,b;
output y;
//------------------------------------------------
reg y;
always @(a or b) y = ~ (a & b);
endmodule
//------------------------------------------------
module dff(clk,rst_n,d,q);
input clk,rst_n,d;
output q;
//------------------------------------------------
reg q;
always @(posedge clk or negedge rst_n)
begin
    if(rst_n == 1'b0)
        q <= 1'b0;
    else
        q <= d;
end
//------------------------------------------------
endmodule
//------------------------------------------------
module cir_gate (clk,rst_n,a,y);
input clk;
input rst_n;
input a;
output[2:0] y;
//------------------------------------------------
wire w1,w2,w3,w4,w5,w6,w7;

nand2 x5(.a(a),.b(w7),.y(w1));
nand2 x6(.a(w4),.b(w3),.y(w7));
nand2 x7(.a(w6),.b(w5),.y(w4));
dff   x0(.clk(clk),.rst_n(rst_n),.d(w1),.q(w2));
dff   x1(.clk(clk),.rst_n(rst_n),.d(w2),.q(w3));
dff   x2(.clk(clk),.rst_n(rst_n),.d(w4),.q(w5));
dff   x3(.clk(clk),.rst_n(rst_n),.d(w5),.q(w6));

assign y[0] = w3;
assign y[1] = w5;
assign y[2] = w6;

endmodule 