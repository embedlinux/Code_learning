module add8(a, b, cin, sum, cout);
input [7:0] a, b;
input cin;
output cout;
output [7:0] sum;
reg c8_0, c8_1;
wire [8:4] sum_0, sum_1;
wire [8:0] sum_temp;
reg [7:0] sum;
reg cout;
wire c4;

assign {c4, sum_temp[3:0]} = a[3:0] + b[3:0] + cin;
assign sum_temp[8:4]       = c4 ? sum_1:sum_0;
assign sum_0[8:4]          = a[7:4] + b[7:4];
assign sum_1[8:4]          = a[7:4] + b[7:4] + 1;

always@(a or b or cin)
//always@(sum_temp or sum_0 or sum_1 or c4)
begin
  c8_0 = sum_0[8];
  c8_1 = sum_1[8];
  sum[3:0] = sum_temp[3:0];
  sum[7:4] = sum_temp[7:4];
  cout     = c4 ? c8_1:c8_0;
end

endmodule
