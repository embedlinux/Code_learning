`ifndef SCOREBOARD_SV
`define SCOREBOARD_SV

class scoreboard;
  int         tr_num;
  mailbox     agt2scb_mbx = new();               //创建邮箱，接收由agent发来的数据，激励
  mailbox     mon2scb_mbx = new();               //创建邮箱，接收由monitor发来的数据，DUT输出
  transaction tr；

  parameter    ADDR_WIDTH = 16；                 //系统地址空间64K=2^6×2^10=2^16
  parameter    SRAM_ADDR_WIDTH = ADDR_WIDTH -2;  //SRAM地址空间16K=2^4×2^10=2^14
  parameter    SRAM_DEPTH = 1 << (SRAM_ADDR_WIDTH);  //1左移14位，即为2^14

  logic [31:0] sram_gld[SRAM_DEPTH];              //golden sram, 初始值为x，未知态
   //sram_gld是一个由2^14个32位寄存器组成的存储器,即该存储器深度为2^14,数据位宽为32bit，地址位宽为14bit
  logic [31:0] sram_gld_rdata;                    //临时变量，用于存储golden model单个数据，便于一一比对
  logic [31:0] sram_dut_rdata;                    //临时变量，用于存储DUT输出的单个数据，便于一一比对

  int          err_cnt = 0；                      //记录比较的数据不一致的错误次数

  extern function new(mailbox agt2scb_mbx,mailbx mon2scb_mbx,int tr_num);
  extern function build();
  extern task check();
  extern task run();

endclass

function scoreboard::new(mailbox agt2scb_mbx,mailbx mon2scb_mbx,int tr_num);
  this.agt2scb_mbx = agt2scb_mbx;                //将env的mailbox与tr_num传进来，建立连接
  this.mon2scb_mbx = mon2scb_mbx;
  this.tr_num = tr_num;
endfunction

function scoreboard::build();
endfunction

task scoreboard::check();
  repeat(tr_num)begin
    mon2scb_mbx.get(tr);            //从monitor到scoreboard的邮箱中取出一个数据包，用于做数据比对
    $display("**@%0t:SCB::tr.haddr(%0h),tr.hwdata(%0h)",$time,tr.haddr,tr.hwdata);  //打印，用于检查错误
    if(tr.hsel  && tr.htrans[1]) begin           //检查数据是否为有效传输
      if(tr.hwrite) begin                        //如果为写数据命令
        case({tr.hsize[1:0],tr.haddr[1:0]})begin //根据地址低两位来判断传输带宽8/16/32bit
          4'b00_00: sram_gld[tr.haddr[ADDR_WIDTH-1:2]][7:0]   = tr.hwdata[7:0]; //sram_gld地址位宽14bit，写8bit
          4'b00_01: sram_gld[tr.haddr[ADDR_WIDTH-1:2]][15:8]  = tr.hwdata[15:8];      //写8bit
          4'b00_10: sram_gld[tr.haddr[ADDR_WIDTH-1:2]][23:16] = tr.hwdata[23:16];     //写8bit
          4'b00_11: sram_gld[tr.haddr[ADDR_WIDTH-1:2]][31:24] = tr.hwdata[31:24];     //写8bit
          4'b01_00: sram_gld[tr.haddr[ADDR_WIDTH-1:2]][15:0]  = tr.hwdata[15:0];      //写低16bit
          4'b01_10: sram_gld[tr.haddr[ADDR_WIDTH-1:2]][31:16] = tr.hwdata[31:16];     //写高16bit
          4'b10_00: sram_gld[tr.haddr[ADDR_WIDTH-1:2]][31:0]  = tr.hwdata[31:0];      //写32bit
          default: begin
              sram_gld[tr.haddr[ADDR_WIDTH-1:2]] = 32'hx;
              $display("**@%0t:ERROR::WRONG hsize (%0h) and haddr[1:0](%0h)",$time,tr.hsize,tr.haddr[1:0]);
              err_cnt++;
              end
        endcase    
      end
     else begin                           //读数据命令，进行比较
       sram_gld_rdata = 32'h0000_0000;    //初始化临时变量，用于存储DUT输出的读数据
       sram_dut_rdata = 32'h0000_0000;    //初始化临时变量，用于存储agent发来的数据
       case({tr.hsize[1:0],tr.haddr[1:0]})
         4'b00_00: begin
              sram_gld_rdata[7:0] = sram_gld[tr.haddr[ADDR_WIDTH-1:2]][7:0];  //gld输出的比对数据
              sram_dut_rdata[7:0] = tr.hrdata[7:0];                           //从dut中读出的比对数据 
         4'b00_01: begin
              sram_gld_rdata[15:8] = sram_gld[tr.haddr[ADDR_WIDTH-1:2]][15:8];  
              sram_dut_rdata[15:8] = tr.hrdata[15:8];                           
         4'b00_10: begin
              sram_gld_rdata[23:16] = sram_gld[tr.haddr[ADDR_WIDTH-1:2]][23:16];  
              sram_dut_rdata[23:16] = tr.hrdata[23:16];                           
         4'b00_11: begin
              sram_gld_rdata[31:24] = sram_gld[tr.haddr[ADDR_WIDTH-1:2]][31:24];  
              sram_dut_rdata[31:24] = tr.hrdata[31:24];                           
         4'b01_00: begin
              sram_gld_rdata[15:0] = sram_gld[tr.haddr[ADDR_WIDTH-1:2]][15:0];  
              sram_dut_rdata[15:0] = tr.hrdata[15:0];       
         4'b01_10: begin
              sram_gld_rdata[31:16] = sram_gld[tr.haddr[ADDR_WIDTH-1:2]][31:16];  
              sram_dut_rdata[31:16] = tr.hrdata[31:16];                                        
         4'b10_00: begin
              sram_gld_rdata = sram_gld[tr.haddr[ADDR_WIDTH-1:2]][31:24];  
              sram_dut_rdata = tr.hrdata;                                //从dut读出的比对数据 ,32bit可省略bit位
         default: begin
              sram_gld[tr.haddr[ADDR_WIDTH-1:2]] = 32'hx;
              $display("**@%0t:ERROR::WRONG hsize (%0h) and haddr[1:0](%0h)",$time,tr.hsize,tr.haddr[1:0]);
              err_cnt++;
              end
         endcase    
     
    if(sram_gld_rdata !== sram_cmp_rdata)begin            //golden model定义为logic类型，存在未知态x，故采用!==
       $display("**@%0t:ERROR::sram_gld_hrdata(%0h) !== sram_dut_hrdata(%0h) in haddr(%0h)",      \
                                $time,sram_gld_rdata,sram_dut_rdata,tr.haddr[ADDR_WIDTH-1:0]); 
       err_cnt++;                                                    //地址不进行移位处理，便于观察
       end
     end     //else begin   
    end    //if(tr.hsel  && tr.htrans[1]) begin
  end    // repeat(tr_num)begin

endtask

task scoreboard::run();
  check();                                                      //检查错误
  if(err_cnt)begin
     $display("**********************************************");
     $display("**********************************************");
     $display("******************TEST  PASS******************");
     $display("**********************************************");
     $display("**********************************************");
   else begin
     $display("**********************************************");
     $display("**********************************************");
     $display("**************TEST FAILED with %d errors******",err_cnt);
     $display("**********************************************");
     $display("**********************************************");
   end
 
 endtask

`endif

