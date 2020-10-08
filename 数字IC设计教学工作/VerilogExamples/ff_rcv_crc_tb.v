//-----------------------------------------------------------------
module ff_rcv_crc_tb();
reg clk,rst,en_1b,en_8b;
reg[7:0] d;
reg b;
wire fok_1b;
wire fok_8b;
integer i;
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
ff_rcv_fcs rcv_crc_8b 
(.clk(clk) ,
 .rst(rst) ,
 .en(en_8b),
 .d(d)     ,
 .fok(fok_8b)
);
//-----------------------------------------------------------------
initial begin
    clk = 0;
    rst = 1;
    en_1b  = 0;
    en_8b  = 0;
    d = TEST_DATA1;
    b = 0;
    i = 0;
#1
    rst = 0;
    en_1b = 1;
    
    for (i=0;i<8;i=i+1)
    begin
     #1
        clk = 0;
        b = d[7];
     #1 
        clk = 1;
        d = d << 1;
    end
    
    d = TEST_DATA2;
    
    for (i=0;i<8;i=i+1)
    begin
     #1
        clk = 0;
        b = d[7];
     #1 
        clk = 1;
        d = d << 1;
    end
    
    d= TEST_DATA3;
    
    for (i=0;i<8;i=i+1)
    begin
     #1
        clk = 0;
        b = d[7];
     #1 
        clk = 1;
        d = d << 1;
    end
    
#1    
    clk = 0;
    d = TEST_DATA1;
    en_1b = 0;
    en_8b = 1;
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