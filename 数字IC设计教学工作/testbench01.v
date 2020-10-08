//*********************************************************************************
//    Design unit : Testbench of FF Receiver.                                      
//    File name   : TbReceive.v                                                   
//    Author      : XinXiaoNing                                                    
//    Revision    : Version 0.1   02/07/2003                                       
//*********************************************************************************
`timescale  1 ns / 1 ps
module testbench01();
//-------------------- signals connect to Testting component ---------------------
reg  rst;
reg  clk16x;
reg  pi_pdu;
reg cs_n;
reg rd_n;
reg sys_wr_n;
reg[15:0] addr;
reg[7:0]sys_dat_i;
initial begin
    cs_n = 1'b1;
    rd_n = 1'b1;
    sys_wr_n = 1'b1;
    addr = 16'h0000;
    sys_dat_i = 8'h00;
end
//-------------------------------------------------------------------------------
wire po_pdu;
wire po_tact;
wire rdy_o;
wire int_n;
wire[7:0] sys_dat_o;

tta_pp                    pp
(.clk(clk16x)             ,
 .rst(rst)                ,
 .cs_n(cs_n)              ,
 .rd_n(rd_n)              ,
 .wr_n(sys_wr_n)          ,
 .addr(addr)              ,
 .sys_dat_i(sys_dat_i)    ,
 .pi_phpdu(pi_pdu)        ,
 .sys_dat_o(sys_dat_o)    ,
 .rdy_o(rdy_o)            ,
 .int_n(int_n)            ,
 .po_phpdu(po_pdu)        ,
 .po_tact(po_tact) 
);
//--------------------------------------------------------------------------------
//--------------------------------------------------------------------------------
reg rcv_en;
reg cancel;
reg po_tact_i;
reg dup;
reg en_lp_bk;
reg lp_bk;
wire carry;
wire fcs_ok_w;
wire byte_rcvd_w;
wire frame_rcvd_w; 
wire fr_err_w;
wire[7:0] rcv_pdu_w;
initial begin
    rcv_en = 1'b1;
    cancel = 1'b0;
    po_tact_i = 1'b0;
    dup = 1'b0;
    en_lp_bk = 1'b0;
    lp_bk = 1'b0;
end
//--------------------------------------------------------------------------------
receiver                    receiver
(.rst(rst)                  ,     
 .clk(clk16x)               ,    
 .rcv_en(rcv_en)            ,    
 .rcvd_msg_cancel(cancel)   ,    
 .en_full_duplex(dup)       ,    
 .trans_active(po_tact_i)   ,     
 .pi_pdu(po_pdu)            ,    
 .en_lp_bk(en_lp_bk)        ,     
 .loop_back(lp_bk)          ,    
 .carry_detect(carry)       ,    
 .fcs_ok(fcs_ok_w)          ,    
 .byte_rcvd(byte_rcvd_w)    ,    
 .frame_rcvd(frame_rcvd_w)  ,    
 .frame_error(fr_err_w)     ,    
 .wr_n(wr_n_w)              ,     
 .dat_out(rcv_pdu_w)                 
 );
//--------------------------------------------------------------------------------
//---------------------Variable for Simulation -----------------------------------
`define RAM_SIZE 16
reg [1:0] Preamble[7:0];
reg [1:0] StartDelimiter[7:0];
reg [1:0] EndDelimiter[7:0];
reg Test1,Test2,Test3;
reg Clk31P25K;
reg [7:0] RAM[`RAM_SIZE-1:0];
reg [7:0] Pointer;
reg DataValid;
//--------------------------------------------------------------------------------
//--------------------------------------------------------------------------------
task ClearRam;
input[7:0] num;
integer i;
    for(i=0;i<num;i=i+1)
        RAM[i] = 8'h00;
endtask 
//--------------------------------------------------------------------------------
//    Clock cycle = 2000ns. frequency = 500k  here Pulse is " a half pulse "
//--------------------------------------------------------------------------------
task HalfPulse;
inout Clk;
    begin
    #1000 Clk = ~Clk;  
    end
endtask
//--------------------------------------------------------------------------------
task Pulse;
input[15:0] num;
integer i;
    for(i=0;i<num;i=i+1)
    begin
        HalfPulse(clk16x);
        HalfPulse(clk16x);
    end
endtask     
//--------------------------------------------------------------------------------
//    A mt bit should be represented by two logic bits. 0 = "01" 1 = "10"
//--------------------------------------------------------------------------------
function[1:0] ConvBitToMtBits;
input b;
    if(b == 0)
        ConvBitToMtBits = 2'b01;
    else
        ConvBitToMtBits = 2'b10;  
endfunction
//--------------------------------------------------------------------------------
//    Transmit a "half mt bit". "01" = 0; "10" = 1; "00" = N-; "11" = N+.   
//--------------------------------------------------------------------------------
task TransmitMtBit;
input  Mb;
output PiPdu;
inout  Clk31p;
integer i;
begin
    if(Mb == 1)
        PiPdu = 1;
    else
        PiPdu = 0;
        
    Clk31p = ~Clk31p; 
    
    for(i=0;i<16; i=i+1)
        HalfPulse(clk16x); 
end
endtask
//-------------------------------------------------------------------------------- 
//    Transmit Preamble. Preamble = "10101010"
//--------------------------------------------------------------------------------
task TransmitPreamble;
integer i;
output s;
reg [1:0] m;
begin
    for(i=0;i<8;i=i+1)
    begin
        m = Preamble[i];
        TransmitMtBit(m[1],pi_pdu,Clk31P25K);
        TransmitMtBit(m[0],pi_pdu,Clk31P25K);
    end
    s = 1;
end
endtask
//--------------------------------------------------------------------------------
//    Transmit StartDelimiter. StartDelimiter = "1 N+ N- 1 0 N- N+ 0"
//--------------------------------------------------------------------------------
task TransmitStartDelimiter;
integer i;
output s;
reg [1:0] m;
begin
    for(i=0;i<8;i=i+1)
    begin
        m = StartDelimiter[i];
        TransmitMtBit(m[1],pi_pdu,Clk31P25K);
        TransmitMtBit(m[0],pi_pdu,Clk31P25K);
    end
    s = 1;
end
endtask
//---------------------------------------------------------------------------------
//    Transmit EndDelimiter. StartDelimiter = "1 N+ N- N+ N- 1 0 1"
//---------------------------------------------------------------------------------
task TransmitEndDelimiter;
integer i;
output s;
reg [1:0] m;
begin
    for(i=0;i<8;i=i+1)
    begin
        m = EndDelimiter[i];
        TransmitMtBit(m[1],pi_pdu,Clk31P25K);
        TransmitMtBit(m[0],pi_pdu,Clk31P25K);
    end
    s = 1;
end
endtask
//---------------------------------------------------------------------------------
//            Data should be convert to Mt Code first.        
//---------------------------------------------------------------------------------
task TransmitByte;
input[7:0] Data;
reg[1:0] m;
integer i;
begin
    for(i=0;i<8;i=i+1)
    begin
        m = ConvBitToMtBits(Data[7]);
        TransmitMtBit(m[1],pi_pdu,Clk31P25K);
        TransmitMtBit(m[0],pi_pdu,Clk31P25K);
        Data = Data << 1;
    end
end
endtask
//---------------------------------------------------------------------------------
//                 Initiate Signals
//---------------------------------------------------------------------------------
//Octets 5 and 6 shall specify the responding DLE¡¯s required value of
//  maximumresponse-
//delay-in-octets, V(MRD) ¡Á V(ST), defined in 6.7.1.3 and 6.7.1.1. If this value,
//which reflects the device¡¯s capability, is larger than the link¡¯s configured 
// value of maximumresponse-
//delay-in-octets, V(MRD) ¡Á V(ST), then the responding node is not capable of
//operating on the local link.
//e) Octet 7 shall specify the responding DLE¡¯s required value 
//  of minimum-inter-DLPDUdelay,
//V(MID) defined in 6.7.1.12. If this value, which reflects the device¡¯s capability,
//  is
//larger than the link¡¯s configured value of V(MID), then the responding DLE 
// is not capable of
//operating on the local link.
//f) Octet 8 shall specify the value for the sending DLE¡¯s random identifier
//  variable, V(RID)
//(see 6.7.1.18), which is re-randomized upon receipt of a PN DLPDU addressed 
// to the DLE.
//----------------------------------------------------------------------------------
initial begin
    clk16x = 0;
    pi_pdu = 1;
    
    Clk31P25K =0;
    Test1 = 0;
    Test2 = 0;
    Test3 = 0;
    //nRD = 1;
    Pointer = 8'h00;
    DataValid = 1'b0;
    
        
    Preamble[0]=2'b10;           // 1
    Preamble[1]=2'b01;           // 0
    Preamble[2]=2'b10;           // 1
    Preamble[3]=2'b01;           // 0
    Preamble[4]=2'b10;           // 1
    Preamble[5]=2'b01;           // 0
    Preamble[6]=2'b10;           // 1
    Preamble[7]=2'b01;           // 0
    
    StartDelimiter[0]=2'b10;     // 1
    StartDelimiter[1]=2'b11;     // N+
    StartDelimiter[2]=2'b00;     // N-
    StartDelimiter[3]=2'b10;     // 1
    StartDelimiter[4]=2'b01;     // 0
    StartDelimiter[5]=2'b00;     // N-
    StartDelimiter[6]=2'b11;     // N+
    StartDelimiter[7]=2'b01;     // 0
    
    EndDelimiter[0]=2'b10;       // 1
    EndDelimiter[1]=2'b11;       // N+
    EndDelimiter[2]=2'b00;       // N-
    EndDelimiter[3]=2'b11;       // N+
    EndDelimiter[4]=2'b00;       // N-
    EndDelimiter[5]=2'b10;       // 1
    EndDelimiter[6]=2'b01;       // 0
    EndDelimiter[7]=2'b10;       // 1
    
    ClearRam(`RAM_SIZE);
    
end
//------------------------------- Start -------------------------------------------
always
begin
    rst = 1;
    Pulse(1);
    rst = 0;
    Pulse(120);
    TransmitPreamble(Test1);
    TransmitStartDelimiter(Test2);
    TransmitByte(8'h34);
    TransmitByte(8'hAF);
    TransmitByte(8'h21);
    TransmitEndDelimiter(Test3);
    Pulse(1);
    pi_pdu <= 1;
    Pulse(32);
    TransmitPreamble(Test1);
    TransmitStartDelimiter(Test2);
    TransmitByte(8'h33);
    TransmitByte(8'h10);
    TransmitByte(8'h00);
    TransmitByte(8'h96);
    TransmitByte(8'h3C);
    TransmitByte(8'hDF);
    TransmitEndDelimiter(Test3);
    Pulse(3);
    pi_pdu <= 1;
    Pulse(32);
    //unsigned char emulatePN[8]={0x26,0x11,0x01,0x12,0x00,0x05,0x05,0x0A};
    TransmitPreamble(Test1);
    TransmitStartDelimiter(Test2);
    TransmitByte(8'h26);
    TransmitByte(8'h11);
    TransmitByte(8'h01);    // version 01
    TransmitByte(8'h12);    // post gap 1, prb 2.
    TransmitByte(8'h00);    
    TransmitByte(8'h05);    // slot time 0005
    TransmitByte(8'h05);    // V(MRD) 5 
    TransmitByte(8'h0a);    // V(MID) 10
    TransmitEndDelimiter(Test3);
    Pulse(3);
    pi_pdu <= 1;
    Pulse(32);
    Pulse(2000);
    //---------------------------------------------------------------------
    TransmitPreamble(Test1);
    TransmitStartDelimiter(Test2);
    TransmitByte(8'h26);
    TransmitByte(8'hf8);
    TransmitByte(8'h01);
    TransmitByte(8'h12);
    TransmitByte(8'h00);
    TransmitByte(8'h05);
    TransmitByte(8'h05);
    TransmitByte(8'h0a);
    TransmitEndDelimiter(Test3);
    Pulse(3);
    pi_pdu <= 1;
    Pulse(32);
    Pulse(2000);
    //unsigned char emulateDT1_NODEACT[16]
    //={0xD3,0x11,0x00,0x04,0x00,0x09,0x00,0x00,0x04,
    // 0x00,0x00,0x00,0x00,0x00,0x00,0xcc };
    TransmitPreamble(Test1);
    TransmitStartDelimiter(Test2);
    TransmitByte(8'hd3);    // 
    TransmitByte(8'hf8);    // node address.
    TransmitByte(8'h00);    // local dle.      
    TransmitByte(8'h04);    // 
    TransmitByte(8'h00);    // 0400 is LAS address.
    TransmitByte(8'h09);    // 1---  version is 001.
    TransmitByte(8'h00);    // 2---  V(MRC) V(NRC) are 00.
    TransmitByte(8'h00);    // 3---  V(Phlo) is 0. 
    TransmitByte(8'h04);    // 4--- {00000,V(TSC)} time-synchronization-class.
    TransmitByte(8'h00);    // 5---  V(MEP) HI
    TransmitByte(8'h00);    // 6---  V(MEP) LO
    TransmitByte(8'h00);    // 7---  V(TL)  Hi   This Link Hi.
    TransmitByte(8'h00);    // 8---- V(TL)  Lo   This Link Lo.
    TransmitByte(8'h00);    // 9---- V(NDL) Hi   0 for FF.
    TransmitByte(8'h09);    // 10----V(NDL) Lo
    TransmitByte(8'h00);    // 11----V(RID)
    TransmitEndDelimiter(Test3);
    Pulse(3);
    pi_pdu <= 1;
    Pulse(32);
    //unsigned char emulateDT1_SMIDEN[8]={0xD3,0x11,0x02,0x10,0x02,0x82,0x1E,0x30 };
    TransmitPreamble(Test1);
    TransmitStartDelimiter(Test2);
    TransmitByte(8'hd3);
    TransmitByte(8'hf8);
    TransmitByte(8'h02);
    TransmitByte(8'h10);
    TransmitByte(8'h02);
    TransmitByte(8'h82);
    TransmitByte(8'h1e);
    TransmitByte(8'h30);
    TransmitEndDelimiter(Test3);
    Pulse(3);
    pi_pdu <= 1;
    Pulse(32);
    
    TransmitPreamble(Test1);
    TransmitStartDelimiter(Test2);
    TransmitByte(8'hd3);
    TransmitByte(8'hf8);
    TransmitByte(8'h02);
    TransmitByte(8'h10);
    TransmitByte(8'h02);
    TransmitByte(8'h82);
    TransmitByte(8'h01);
    TransmitByte(8'hd3);   // setpdtag
    TransmitByte(8'h0f);
    TransmitByte(8'h20);
    TransmitByte(8'hd3);
    TransmitByte(8'hd3);
    TransmitByte(8'hd3);
    TransmitByte(8'hd3);
    TransmitByte(8'hd3);
    TransmitByte(8'hd3);
    TransmitByte(8'hd3);
    TransmitByte(8'hd3);
    TransmitByte(8'hd3);
    TransmitByte(8'hd3);
    TransmitByte(8'hd3);
    TransmitByte(8'hd3);
    TransmitByte(8'hd3);
    TransmitByte(8'hd3);
    TransmitByte(8'hd3);
    TransmitByte(8'hd3);
    TransmitByte(8'hd3);
    TransmitByte(8'hd3);
    TransmitByte(8'hd3);
    TransmitByte(8'hd3);
    TransmitByte(8'hd3);
    TransmitByte(8'hd3);
    TransmitByte(8'hd3);
    TransmitByte(8'hd3);
    TransmitByte(8'hd3);
    TransmitByte(8'hd3);
    TransmitByte(8'hd3);
    TransmitByte(8'hd3);
    TransmitByte(8'hd3);
    TransmitByte(8'hd3);
    TransmitByte(8'hd3);
    TransmitByte(8'hd3);
    TransmitByte(8'h1f);
    TransmitByte(8'h20);
    TransmitByte(8'he3);
    TransmitByte(8'he3);
    TransmitByte(8'he3);
    TransmitByte(8'he3);
    TransmitByte(8'he3);
    TransmitByte(8'he3);
    TransmitByte(8'he3);
    TransmitByte(8'he3);
    TransmitByte(8'he3);
    TransmitByte(8'he3);
    TransmitByte(8'he3);
    TransmitByte(8'he3);
    TransmitByte(8'he3);
    TransmitByte(8'he3);
    TransmitByte(8'he3);
    TransmitByte(8'he3);
    TransmitByte(8'he3);
    TransmitByte(8'he3);
    TransmitByte(8'he3);
    TransmitByte(8'he3);
    TransmitByte(8'he3);
    TransmitByte(8'he3);
    TransmitByte(8'he3);
    TransmitByte(8'he3);
    TransmitByte(8'he3);
    TransmitByte(8'he3);
    TransmitByte(8'he3);
    TransmitByte(8'he3);
    TransmitByte(8'he3);
    TransmitByte(8'he3);
    TransmitByte(8'he3);
    TransmitByte(8'he3);
    TransmitByte(8'h21);
    TransmitByte(8'h00);
    TransmitEndDelimiter(Test3);
    Pulse(3);
    pi_pdu <= 1;
    Pulse(32);
    
    //unsigned char emulatePT_SMRSP[6]={0x33,0x11,0x00,0x96,0x18,0x63};
    TransmitPreamble(Test1);
    TransmitStartDelimiter(Test2);
    TransmitByte(8'h33);
    TransmitByte(8'hf8);
    TransmitByte(8'h00);
    TransmitByte(8'h96);
    TransmitByte(8'h18);
    TransmitByte(8'h63);
    TransmitEndDelimiter(Test3);
    Pulse(3);
    pi_pdu <= 1;
    Pulse(32);
    
    $stop();
    
    
    
    
    
    
    /*unsigned char emulateEC1[63]
     ={0XF0,0X11,0X07,0X10,0X20,0X10,0X07,0X81,0X76,0XEA,0X60,
       0X27,0X10,0XA2,0X80,0X00,0X80,0XA2,0X80,0X00,0X80,0X00,
       0X00,0X00,0X11,0XF8,0X00,0X00,0X10,0X20,0XE2,0X00,0X89,
       0X02,0X00,0X00,0X12,0X4D,0X47,0X21,0X00,0X32,0X00,0X00,
       0X41,0X7F,0X51,0X7F,0X68,0X00,0X30,0X96,0X80,0X00,0X00,
       0X00,0X00,0X71,0X07,0X01,0X71,0X08,0X01};*/
    TransmitPreamble(Test1);
    TransmitStartDelimiter(Test2);
    TransmitByte(8'hf0);
    TransmitByte(8'h11);
    TransmitByte(8'h07);
    TransmitByte(8'h10);
    TransmitByte(8'h20);
    TransmitByte(8'h10);
    TransmitByte(8'h07);
    TransmitByte(8'h81);
    TransmitByte(8'h76);
    TransmitByte(8'hea);
    TransmitByte(8'h60);
    TransmitByte(8'h27);
    TransmitByte(8'h10);
    TransmitByte(8'ha2);
    TransmitByte(8'h80);
    TransmitByte(8'h00);
    TransmitByte(8'h80);
    TransmitByte(8'ha2);
    TransmitByte(8'h80);
    TransmitByte(8'h00);
    TransmitByte(8'h80);
    TransmitByte(8'h00);
    TransmitByte(8'h00);
    TransmitByte(8'h00);
    TransmitByte(8'h11);
    TransmitByte(8'hf8);
    TransmitByte(8'h00);
    TransmitByte(8'h00);
    TransmitByte(8'h10);
    TransmitByte(8'h20);
    TransmitByte(8'he2);
    TransmitByte(8'h00);
    TransmitByte(8'h89);
    TransmitByte(8'h10);
    TransmitByte(8'h20);
    TransmitByte(8'h63);
    TransmitEndDelimiter(Test3);   
       
    //unsigned char emulateDT1_EC1CONF[7]={0XD3,0X11,0XF8,0X10,0X20,0X10,0X40}; 
      
    TransmitPreamble(Test1);
    TransmitStartDelimiter(Test2);
    TransmitByte(8'hd3);
    TransmitByte(8'h11);
    TransmitByte(8'hf8);
    TransmitByte(8'h10);
    TransmitByte(8'h20);
    TransmitByte(8'h10);
    TransmitByte(8'h40);
    TransmitEndDelimiter(Test3);
                              
 
    $stop();
end
//----------------------------------------------------------------------------------
endmodule
//-------------------------------- End ---------------------------------------------