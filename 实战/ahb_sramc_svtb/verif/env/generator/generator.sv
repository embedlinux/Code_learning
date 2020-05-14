`ifndef GENERATOR_SV
`define GENERATOR_SV

class generator;
  int            tr_num;            //定义了要发送的激励的数量（不同的testcase发送的激励命令数量不一样）
  transaction    tr;                //产生对象tr（tr的产生由顶层testcase告知）
  mailbox        mbx=new();         //将tr对象放入邮箱mbx中，负责数据的传递
  event          gen_data;          //定义时间，以便于内部通信
  // typedef mailbox #(ahb_slv_pkt) generator_mailbox;
  
  extern function new(mailbox mbx,int tr_num);
  extern function build();
  extern task write_data32(logic [31:0] addr, logic [31:0] wdata);     //只写32/16/8位数据，
  extern task write_data16(logic [31:0] addr, logic [31:0] wdata);     //testcase告诉地址addr和数据wdata，
  extern task write_data8(logic [31:0] addr, logic [31:0] wdata);      //就会产生tr对象。
  extern task write_data32_random(logic [31:0] addr);           //写32位随机数据，随机产生tr。
  extern task write_data16_random(logic [31:0] addr);           //写16位随机数据，随机产生tr。
  extern task write_data8_random(logic [31:0] addr);            //写8位随机数据，随机产生tr。
  extern task write_addr_random(logic [31:0] wdata);
  extern task read_data32(logic [31:0] addr);
  extern task read_data16(logic [31:0] addr);
  extern task read_data8(logic [31:0] addr);
  extern task read_addr_random();          	//读地址随机
  extern task read_write_random();         	//读/写都随机，即地址、数据和类型hwrite都随机
  extern task all_random();          		//所有的tr数据都随机，包括hsel、hwrite等信号
  extern task no_op();            			//无操作，空命令
  extern task run();

endclass

function generator::new(mailbox mbx,int tr_num);
  this.mbx = mbx;       		//将外部邮箱赋给内部邮箱，使两者相连接，generator的mbx会放在公共邮箱里，等待下一级组件去取
  this.tr_num = tr_num; 		//不同testcase发送的tr_num激励数量不一样
endfunction

function generator::build();         //在运行testcase之前的准备工作
  tr = new;                          //对象tr实例化，分配空间
  if(!tr.randomize())begin           //随机化transaction中的数据
    $display("@%0t ERROR::generator::build randomize failed",$time);
  end
endfunction

task generator::write_data32(logic [31:0] addr, logic [31:0] wdata);
  tr = new;                 //对象tr实例化分配空间
  tr.haddr  = addr;         //testcase传入地址，对数据进行地址分配地址
  tr.hsel   = 1'b1;         //选中该slave
  tr.hwrite = 1'b1;         //1'b1：表示写数据传输模式
  tr.htrans = 2'b10;        //2'b10：表示指示写传输命令有效：NONSEQ； 非burst传输类型一般只有NONSEQ有效状态，SEQ状态一般不出现
  tr.hsize  = 2'b10;        //2'b10：表示有效数据传输位为32bit
  tr.hburst = 2'b00;        //single操作，非连续传输（可省略），burst传输第一个传输类型为NONSEQ，其后为SEQ
  tr.hwdata = wdata;        //写入数据
  ->gen_data;     			//触发事件，在后边run（）的时刻，等待事件在收到触发时，就会把tr放入邮箱
endtask

task generator::write_data16(logic [31:0] addr, logic [31:0] wdata);
  tr = new;                 //对象tr实例化，分配空间
  tr.haddr  = addr;         //testcase传入地址，对写数据进行地址分配地址
  tr.hsel   = 1'b1;         //选中该slave
  tr.hwrite = 1'b1;         //1'b1：表示写数据传输模式
  tr.htrans = 2'b10;        //2'b10：表示指示写传输命令有效：NONSEQ
  tr.hsize  = 2'b01;        //2'b01：表示有效数据传输位为16bit
  tr.hburst = 2'b00;        //（可省略）
  tr.hwdata = wdata;        //写数据
  ->gen_data;      //触发事件，在后边run（）;的时刻，等待事件在收到触发时，就会把tr放入邮箱
endtask

task generator::write_data8(logic [31:0] addr, logic [31:0] wdata);
  tr = new;
  tr.haddr  = addr;         //testcase传入地址，对写数据进行地址分配地址
  tr.hsel   = 1'b1;         //选中该slave
  tr.hwrite = 1'b1;         //1'b1：表示写数据传输模式
  tr.htrans = 2'b10;        //2'b10：表示指示写传输命令有效：NONSEQ
  tr.hsize  = 2'b00;        //2'b00：表示有效数据传输位为8bit
  tr.hburst = 2'b00;        
  tr.hwdata = wdata;        
  ->gen_data;
endtask

task generator::write_data32_random(logic [31:0] addr);
  tr = new;
  if(!tr.randomize())begin  //随机化transaction包中的数据
    $display("@%0t ERROR::generator::write_data_random.randomize failed",$time);
  end
  tr.haddr  = addr;         //testcase传入地址，对随机化数据进行地址分配
  tr.hsel   = 1'b1;         //选中该slave
  tr.hwrite = 1'b1;         //1'b1：表示写数据传输模式
  tr.htrans = 2'b10;        //2'b10：表示指示写传输命令有效：NONSEQ
  tr.hsize  = 2'b10;        //2'b10：表示有效数据传输位为32bit
  ->gen_data;
endtask

task generator::write_data16_random(logic [31:0] addr);
  tr = new;
  if(!tr.randomize())begin  //随机化transaction包中的数据
    $display("@%0t ERROR::generator::write_data_random.randomize failed",$time);
  end
  tr.haddr  = addr;         //testcase传入地址，对随机化数据进行地址分配
  tr.hsel   = 1'b1;         //选中该slave
  tr.hwrite = 1'b1;         //1'b1：表示写数据传输模式
  tr.htrans = 2'b10;        //2'b10：表示指示写传输命令有效：NONSEQ
  tr.hsize  = 2'b01;        //2'b01：表示有效数据传输位为16bit
  ->gen_data;
endtask

task generator::write_data8_random(logic [31:0] addr);
  tr = new;
  if(!tr.randomize())begin  //随机化transaction包中的数据
    $display("@%0t ERROR::generator::write_data_random.randomize failed",$time);
  end
  tr.haddr  = addr;         //testcase传入地址，对随机化数据进行地址分配
  tr.hsel   = 1'b1;         //选中该slave
  tr.hwrite = 1'b1;         //1'b1：表示写数据传输模式
  tr.htrans = 2'b10;        //2'b10：表示指示写传输命令有效：NONSEQ
  tr.hsize  = 2'b00;        //2'b00：表示有效数据传输位为32bit
  ->gen_data;
endtask

task generator::write_addr_random(logic [31:0] wdata);
  tr = new;
  if(!tr.randomize())begin  //随机化transaction包中的数据
    $display("@%0t ERROR::generator::write_addr_random.randomize failed",$time);
  end
  tr.hsel   = 1'b1;         //选中该slave
  tr.hwrite = 1'b1;         //1'b1：表示写数据传输模式
  tr.htrans = 2'b10;        //2'b10：表示指示写传输命令有效：NONSEQ
  tr.hsize  = 2'b10;        //2'b10：表示有效数据传输位为32bit（支持写8/16/32bit）
  tr.hwdata = wdata;        //随机写入数据
  ->gen_data;
endtask

task generator::read_data32(logic [31:0] addr);
  tr = new;
  tr.haddr  = addr;       
  tr.hsel   = 1'b1;         //选中该slave
  tr.hwrite = 1'b0;         //1'b0：表示读数据传输模式
  tr.htrans = 2'b10;        //2'b10：表示指示传输命令有效：NONSEQ
  tr.hsize  = 2'b10;        //2'b10：表示有效数据传输位为32bit
  ->gen_data;
endtask

task generator::read_data16(logic [31:0] addr);
  tr = new;
  tr.haddr  = addr;       
  tr.hsel   = 1'b1;         //选中该slave
  tr.hwrite = 1'b0;         //1'b0：表示读数据传输模式
  tr.htrans = 2'b10;        //2'b10：表示指示传输命令有效：NONSEQ
  tr.hsize  = 2'b01;        //2'b10：表示有效数据传输位为16bit
  ->gen_data;
endtask

task generator::read_data8(logic [31:0] addr);
  tr = new;
  tr.haddr  = addr;       
  tr.hsel   = 1'b1;         //选中该slave
  tr.hwrite = 1'b0;         //1'b0：表示读数据传输模式
  tr.htrans = 2'b10;        //2'b10：表示指示传输命令有效：NONSEQ
  tr.hsize  = 2'b00;        //2'b00：表示有效数据传输位为8bit
  ->gen_data;
endtask

task generator::read_addr_random();   //读数据只需要地址即可，地址随机化，故不再需要参数
  tr = new;
  if(!tr.randomize())begin  //随机化transaction包中的数据
    $display("@%0t ERROR::generator::read_addr_random.randomize failed",$time);
  end
  tr.hsel   = 1'b1;         //选中该slave
  tr.hwrite = 1'b0;         //1'b0：表示读数据传输命令模式
  tr.htrans = 2'b10;        //2'b10：表示指示传输命令有效：NONSEQ
  tr.hsize  = 2'b10;        //2'b10：表示有效数据传输位为32bit（支持读8/16/32bit）
  ->gen_data;
endtask

task generator::read_write_random();  //读/写都随机，hwrite也随即化，不再需要赋值
  tr = new;
  if(!tr.randomize())begin  //随机化transaction包中的数据
    $display("@%0t ERROR::generator::read_addr_random.randomize failed",$time);
  end
  tr.hsel   = 1'b1;         //选中该slave
  tr.htrans = 2'b10;        //2'b10：表示指示传输命令有效：NONSEQ
  tr.hsize  = 2'b10;        //2'b10：表示有效数据传输位为32bit
  ->gen_data;
endtask

task generator::all_random();       //所有都随机，不再对各个信号再进行赋值
  tr = new;
  if(!tr.randomize())begin  //随机化transaction包中的数据
    $display("@%0t ERROR::generator::read_addr_random.randomize failed",$time);
  end
  ->gen_data;
endtask

task generator::no_op();            //无操作命令
  tr = new;
  if(!tr.randomize())begin          //随机化transaction包中的数据
    $display("@%0t ERROR::generator::read_addr_random.randomize failed",$time);
  end
  tr.hsel   = 'h0;                  //未选中slave
  tr.htrans = 'h0;                  //无效命令指示，  无效操作
  ->gen_data;
endtask

task generator::run();        //前面产生激励的task，如果产生数据的话，便会同时触发事件gen_data，告诉run（）；
  reteat(tr_num)begin         //tr数据包已产生了数据，然后run会把数据包放入邮箱mbx，等待下一个组件去取。
     @(gen_data);             //testcase每发一个包命令，run（）就等待tr产生数据，然后放入邮箱
     mbx.put(tr);             //这里的邮箱就相当于一个FIFO
  end
endtask

`endif
