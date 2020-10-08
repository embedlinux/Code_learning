//-----------------------------------------------------------------
module ff_rcv_crc_tb();
reg clk,rst,en_1b,en_4b;
reg[3:0] d;
reg[7:0] td;
reg b;
wire fok_1b;
wire fok_4b;
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
ff_rcv_fcs_4b rcv_crc_4b 
(.clk(clk) ,
 .rst(rst) ,
 .en(en_4b),
 .d(d)     ,
 .fok(fok_4b)
);
//-----------------------------------------------------------------
initial begin
    clk = 0;
    rst = 1;
    en_1b  = 0;
    en_4b  = 0;
    d = 0;
    td = TEST_DATA1;
    b = 0;
    i = 0;
#1
    rst = 0;
    en_1b = 1;
    
    for (i=0;i<8;i=i+1)
    begin
     #1
        clk = 0;
        b = td[7];
     #1 
        clk = 1;
        td = td << 1;
    end
    
    td = TEST_DATA2;
    
    for (i=0;i<8;i=i+1)
    begin
     #1
        clk = 0;
        b = td[7];
     #1 
        clk = 1;
        td = td << 1;
    end
    
    td= TEST_DATA3;
    
    for (i=0;i<8;i=i+1)
    begin
     #1
        clk = 0;
        b = td[7];
     #1 
        clk = 1;
        td = td << 1;
    end
    
#1    
    clk = 0;
    d = TEST_DATA1[7:4];
    en_1b = 0;
    en_4b = 1;
#1
    clk = 1;
#1  clk = 0;
    d = TEST_DATA1[3:0];
#1  clk = 1;
#1  clk = 0;
    d = TEST_DATA2[7:4];
#1  clk = 1;
#1  clk = 0;
    d = TEST_DATA2[3:0];
#1  clk = 1;
#1  clk = 0;
    d = TEST_DATA3[7:4];
#1  clk = 1;
#1  clk = 0;
    d = TEST_DATA3[3:0];
#1  clk = 1;
            
#3  
    $stop();  
end
//-----------------------------------------------------------------
endmodule