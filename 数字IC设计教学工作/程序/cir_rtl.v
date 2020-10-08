//------------------------------------------
module cir_rtl(clk,rst_n,a,y);
input clk;
input rst_n;
input a;
output[2:0] y;
//------------------------------------------
reg[3:0] q;
reg w7;
reg[2:0] y; 
//------------------------------------------
always @(q)
begin
    y[0] = q[1];
    y[1] = q[2];
    y[2] = q[3];
end
//------------------------------------------
always @(q) w7 = !(q[1] & (!(q[2] & q[3])));
//------------------------------------------
always @(posedge clk or negedge rst_n)
begin
    if(rst_n == 1'b0)
        q <= 4'b0000;
    else begin
        q[0] <= !( a & w7);
        q[1] <= q[0];
        q[2] <= !(q[2] & q[3]);
        q[3] <= q[2];
    end
end
//------------------------------------------
endmodule