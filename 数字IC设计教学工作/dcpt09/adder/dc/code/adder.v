//-----------------------------------------------
module adder(clk,rst_n,a,b,s);
input clk;
input rst_n;
input[63:0] a;
input[63:0] b;
output[63:0] s;
//-----------------------------------------------
reg[63:0] am;
reg[63:0] bm;
reg[2:0] cnt;
reg en;
reg[63:0] s;
//-----------------------------------------------
always @(posedge clk or negedge rst_n)
begin
    if(rst_n == 1'b0)
        cnt <= 3'b000;
    else
        cnt <= cnt + 1'b1;
end
//-----------------------------------------------
always @(cnt)
begin
    if(cnt == 3'b111)
        en = 1'b1;
    else
        en = 1'b0;
end
//-----------------------------------------------
always @(posedge clk or negedge rst_n)
begin
    if(rst_n == 1'b0)
       am <= 64'h0000_0000_0000_0000;
    else if(en == 1'b1)
       am <= a;   
end
//-----------------------------------------------
always @(posedge clk or negedge rst_n)
begin
    if(rst_n == 1'b0)
       bm <= 64'h0000_0000_0000_0000;
    else if(en == 1'b1)
       bm <= b;   
end
//-----------------------------------------------
always @(posedge clk or negedge rst_n)
begin
    if(rst_n == 1'b0)
       s <= 64'h0000_0000_0000_0000;
    else if(en == 1'b1)
       s <= am + bm;   
end
//-----------------------------------------------
endmodule