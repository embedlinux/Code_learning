`ifndef AGENT_SV
`define AGENT_SV

class agent;
  int          tr_num;               //传输数据包的总个数，测试用例会告知每次传输多少个包
  mailbox      gen2agt_mbx=new();    //创建邮箱，邮箱深度不限
  mailbox      agt2drv_mbx=new();
  mailbox      agt2scb_mbx=new();
  
  transaction  tr;                    //在tr的传输过程中，数据内容都是一样的来源于transaction

  extern function new(mailbox gen2agt_mbx,agt2drv_mbx,agt2scb_mbx, int tr_num);
  extern function build();
  extern task run();
  
endclass

function agent::new(mailbox gen2agt_mbx,gen2drv_mbx,gen2scb_mbx, int tr_num);
  this.gen2agt_mbx = gen2agt_mbx;      //generator的外层（env层）会定义公共邮箱（形参），并将其
  this.agt2drv_mbx = agt2drv_mbx;      //同时传递给agent、generator，那么这两个邮箱就成了一个邮箱
  this.agt2scb_mbx = agt2scb_mbx;      //new函数的作用就是在创建agent对象时，通过公共邮箱，
  this.tr_num = tr_num;                //将generator、driver和Scoreboard的邮箱连接起来
endfunction

function agent::build();
endfunction

task agent::run();
  repeat(tr_num)begin        //tr_num为发包数目
    tr = new();              //创建对象实体
    gen2agt_mbx.get(tr);     //从generator处获得（get）一个 实体数据包
    agt2drv_mbx.put(tr);     //将tr实体数据包发送（put）到driver
    agt2scb_mbx.put(tr);     //将tr实体数据包发送（put）到Scoreboard
  end
endtask

`endif
