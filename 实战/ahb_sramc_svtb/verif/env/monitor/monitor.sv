`ifndef MONITOR_SV
`define MONITOR_SV

class monitor;
  mailbox          mon2scb_mbx = new();    //创建邮箱，采集DUT输出的数据，并发送至scb
  transaction      tr;                     //数据包对象句柄，其中数据无时序概念
  virtaul ahb_slv_if slv_if                //monitor与DUT之间通过接口相连
  int              tr_num;                 //发包个数

  logic  [31:0]    haddr_ld;               //从接口中采集的数据是按照AHB时序采集的
  logic            hwrite_ld;              //在将这些数据发送至scb之前需要将地址和控制信号放置一拍，与数据对齐
  logic  [1:0]     htrans_ld;              //然后一起打包成tr，放入邮箱，发送至scb
  logic  [1:0]     hsize_ld;
  logic            hsel_ld;

  extern function new(mailbox mon2scb_mbx,virtaul ahb_slv_if slv_if,int tr_num);
  extern function build();
  extern task run();

endclass

function monitor::new(mailbox mon2scb_mbx,virtaul ahb_slv_if slv_if,int tr_num);
  this.mon2scb_mbx = mon2scb_mbx;          //new函数主要起连接作用，将顶层邮箱与本地邮箱连接起来
  this.slv_if = slv_if;                    //将顶层DUT的interface与本地相连
  this.tr_num = tr_num;
endfunction

function driver::build();                  //初始化配置
endfunction

task monitor::run();                       //实时采集slv_if的数据，并将采集的数据进行时序处理，打包放入邮箱送至scb
  @(posedge slv_if.hresetn);               //在run开始之前，先等待DUT的复位信号失效，有低变高
  @slv_if.mon_cb;
  @slv_if.mon_cb;                          //等待两个时钟周期
  repeat(tr_num)begin
    tr = new();                            //创建数据包对象
    haddr_ld  <= slv_if.mon_cb.haddr;
    htrans_ld <= slv_if.mon_cb.htrans;
    hwrite_ld <= slv_if.mon_cb.hwrite;
    hsize_ld  <= slv_if.mon_cb.hsize;
    hsel_ld   <= slv_if.mon_cb.hsel;
    @slv_if.mon_cb;                			//等待一个时钟周期，即将monitor采集的接口地址阶段信号寄存一拍
    tr.haddr  = haddr_ld;         
    tr.htrans = htrans_ld;         			//由于tr对象里的数据都为随机化数据，故只能使用阻塞赋值
    tr.hwrite = hwrite_ld;
    tr.hsize  = hsize_ld;
    tr.hsel   = hsel_ld;           			//地址和控制信号，slave选择信号寄存一拍，到来需等待数据信号
    tr.hwdata = slv_if.mon_cb.hwdata;
    tr.hrdata = slv_if.mon_cb.hrdata;
    mon2scb_mbx.put(tr);          //将采集的接口信号放入邮箱中，以便scb从邮箱中获取数据
  end

  repeat(10) begin
    @slv_if.mon_cb;                  //后续时钟延长处理，防止数据丢失
  end

endtask

`endif
