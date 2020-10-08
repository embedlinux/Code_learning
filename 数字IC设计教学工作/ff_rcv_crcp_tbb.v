//-----------------------------------------------------------------
module ff_byte_crc_tb();
reg clk,rst,en_1b,en_8b;
reg[7:0] d;
reg b;
wire fok_1b;
wire fok_8b;
parameter[7:0] TEST_DATA1 = 8'h34;
parameter[7:0] TEST_DATA2 = 8'hAF;
parameter[7:0] TEST_DATA3 = 8'h21;
//-----------------------------------------------------------------
ff_rcv_fcs_1b rcv_crc_1b
(.clk(clk),
 .rst(rst),
 .en(en_1b),
 .d(b),
 .fok(fok_1b)
 );
//-----------------------------------------------------------------
ff_rcv_fcs_8b rcv_crc_8b 
(.clk(clk) ,
 .rst(rst) ,
 .en(en_8b),
 .d(d)     ,
 .fok(fok_8b)
);
//-----------------------------------------------------------------
task trans_byte;
input[7:0] da;
integer i;
for (i=0;i<8;i=i+1)
begin
     #1
        clk = 0;
        b = da[7];
     #1 
        clk = 1;
        da = da << 1;
end
endtask
//----------------------------------------------------------------
initial begin
    clk = 0;
    rst = 1;
    en_1b  = 0;
    en_8b  = 0;
    b = 0;
    d = 0;
    #2
    rst = 0;
    en_1b  = 1;
    
    #1
    trans_byte(8'h34);
    trans_byte(8'hAF);
    trans_byte(8'h21);
    
    #1
    rst = 1;
    b = 0;
    #1
    
    rst = 0;
    
    trans_byte(8'h33);
    trans_byte(8'h10);
    trans_byte(8'h00);
    trans_byte(8'h96);
    trans_byte(8'h3C);
    trans_byte(8'hDF);
    
    #10
    en_1b = 0;
    
    clk = 0;
    d = TEST_DATA1;
    
    en_8b = 1;  //
#1
    clk = 1;
#1
    clk = 0;
    d = TEST_DATA2;
#1  
    clk = 1;
#1 
    clk = 0;
    d = TEST_DATA3;
#1
    clk = 1;
#3  
    $stop();  
   
end
//-----------------------------------------------------------------
endmodule