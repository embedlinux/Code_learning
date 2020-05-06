`ifndef DRIVER_SV
`define DRIVER_SV

class driver;
  mailbox         agt2drv_mbx = new();     //创建邮箱，以采集由agent发送至driver的数据包（无时序）
  transaction     tr;   
  virtaul  ahb_slv_if  slv_if;             //driver会将接收到的数据按照AHB时序处理后，通过接口interface发送至DUT
  int             tr_num;                  //发包数量
  logic  [31:0]   hwdata_ld;               //做时序用途，因为数据阶段会比地址阶段晚一拍发送

  extern function new(mailbox agt2drv_mbx,virtual ahb_slv_if slv_if,int tr_num);
  extern function build();                 //new函数主要将driver内部成员（从generator发送到agent，再到driver的
  extern task run();                       //tr数据包）与DUT的外部接口DUT成员连接起来，以便数据发送

endclass

function driver::new(mailbox agt2drv_mbx,virtual ahb_slv_if slv_if,int tr_num);
  this.agt2drv_mbx = agt2drv_mbx;          //通过公共邮箱，建立agent与driver之间的连接
  this.slv_if = slv_if;                    //接口的作用也是为了建立driver与DUT之间的连接，类似邮箱的作用
  this.tr_num = tr_num;
endfunction

function driver::build();
endfunction

task driver::run();                        //run将对agent发来的数据进行时序处理，再经过接口发送进入DUT
  @(posedge slv_if.hresetn);               //在run开始之前，先等待DUT的复位信号失效，由低变高
  @slv_if.drv_cb;
  @slv_if.drv_cb;                          //等待两个时钟周期
  repeat(tr_num)begin
    tr = new();                            //创建数据包对象
    agt2drv_mbx.get(tr);                   //将由agent发送来的数据从邮箱mailbox中取出
    wait(slv_if.hready_resp);              //master需要看到slave ready信号是才会发送数据，
      slv_if.drv_cb.hsel   <= tr.hsel;     //driver是去模拟master的行为时序，等slave ready为高时，才将数据发出
      slv_if.drv_cb.haddr  <= tr.haddr;
      slv_if.drv_cb.htrans <= tr.htrans;
      slv_if.drv_cb.hwrite <= tr.hwrite;
      slv_if.drv_cb.hsize  <= tr.hsize;    //右侧数据为generator进过agent发送来driver的数据  
      hwdata_ld            <= tr.hwdata;   //地址和控制信号相对于写数据信号晚一拍
      @slv_if.drv_cb;                      //等待一个时钟周期，再发送写数据信号（总线协议时序要求）
      slv_if.drv_cb.hwdata <= tr.hwdata; 
    end
  
  repeat(10)begin
    @slv_if.drv_cb;                        //后续处理，等待几个周期，以防止尾巴上的数据丢失
  end

endtask

`endif
