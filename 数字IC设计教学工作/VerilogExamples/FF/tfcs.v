//---------------------------------------------------------------------
//---------------------------------------------------------------------
module tfcs
(clk16x          ,
 set             ,
 trans_underrun  ,
 txc             ,
 data_fcs_n      ,
 dlpdu           ,
 txd
);
//----------------------------------------------------------------------
//----------------------------------------------------------------------
input clk16x;
input set;
input trans_underrun;
input txc;
input data_fcs_n;
input dlpdu;
output txd;
//----------------------------------------------------------------------
//----------------------------------------------------------------------
reg[15:0] d;
//----------------------------------------------------------------------
reg feed_back;
reg txd;
//----------------------------------------------------------------------
always @(data_fcs_n or dlpdu or d[15])
begin
    if(data_fcs_n == 1'b0)
        feed_back = 1'b0;
    else
        feed_back = dlpdu ^ d[15];
end
//----------------------------------------------------------------------
always @(posedge clk16x)
begin
    if(set == 1'b1)
        d <= 16'hffff;
    else if(txc == 1'b1) begin
        d[0]  <= feed_back;
        d[1]  <= feed_back ^ d[0];
        d[2]  <= feed_back ^ d[1];
        d[3]  <= feed_back ^ d[2];
        d[4]  <= d[3];
        d[5]  <= d[4];
        d[6]  <= feed_back ^ d[5];
        d[7]  <= feed_back ^ d[6];
        d[8]  <= feed_back ^ d[7];
        d[9]  <= d[8];
        d[10] <= feed_back ^ d[9];
        d[11] <= feed_back ^ d[10];
        d[12] <= feed_back ^ d[11];
        d[13] <= d[12];
        d[14] <= d[13];
        d[15] <= d[14];
        end
end
//----------------------------------------------------------------------
always @(set or trans_underrun or dlpdu or data_fcs_n or d[15])
begin
    if((set == 1'b1) || (trans_underrun == 1'b0))
        txd = 1'b1;
    else if(data_fcs_n == 1'b1)
        txd = dlpdu;
    else
        txd = ~ d{15]; 
end
//----------------------------------------------------------------------
endmodule



