class environment;
  generator               gen;            //environment中包含了generator、agent、driver、monitor和scoreboard
  agent                   agt             //等子组件,并且会对其进行调用
  driver                  drv；
  monitor                 mon；
  scoreboard              scb；

  int                     tr_num；        //定义发包数目，发挥指挥作用
   
  mailbox       gen2agt_mbx = new();      //environment顶层会定义公共邮箱，进行邮箱连接，传递数据
  mailbox       agt2drv_mbx = new();
  mailbox       agt2scb_mbx = new();
  mailbox       mon2scb_mbx = new();

  virtaul    ahb_slv_if      slv_if;      //env顶层通过接口interface与子组件之间进行连接
   
  extern function new(virtaul ahb_slv_if slv_if,int tr_num);
  extern task build();
  extern task run();
  
endclass

function environment::new(virtaul ahb_slv_if slv_if,int tr_num);
  this.slv_if = slv_if;            //new函数执行时，会将env顶层外部（DUT传递来的）接口信号与其子组件连接
  this.tr_num = tr_num;
endfunction

task environment::build();       //通过邮箱、接口，构建数据传输的通道
  gen = new(gen2agt_mbx, tr_num);         //env层公共邮箱的建立是为了实现数据包tr在组件之间的传递
  agt = new(gen2agt_mbx,agt2drv_mbx,agt2scb_mbx,tr_num);
  drv = new(agt2drv_mbx,slv_if,tr_num);   //slv_if负责连接DUT
  mon = new(mon2scb_mbx,slv_if,tr_num);   //tr_num的具体数值有testcase层给出
  scb = new(agt2scb_mbx,mon2scb_mbx,tr_num);
endtask

task environment::task();
  fork       //并发执行
     gen.run();                           //产生数据，给到agent
     agt.run();                           //将接受自generator的数据通过邮箱发送至drv，scb
     drv.run();                           //将接受自generator的数据，按照AHB时序协议通过接口slv_if送至DUT
     mon.run();                           //采集DUT输出，将其转化为无时序状态，打包发送至scb
     scb.run();                           //将golden model与无时序状态的DUT输出进行一一比较
  join
endtask

`endif

