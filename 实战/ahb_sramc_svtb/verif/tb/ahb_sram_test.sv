`ifndef AHB_SRAM_TEST_SV
`define AHB_SRAM_TEST_SV

program automatic ahb_sram_test(ahb_slave_if slv_if);        //创建接口对象
  int    tr_num=20;         //创建数据包变量，默认值为20
  int    rnd_seed;          //该随机种子变量在此作用不大，可以省略
  int    tc_num=0;          //定义测试用例号，运行测试用例时对用例进行指定
   
  covergroup ahb_slv_cg();     //定义覆盖组，用于功能覆盖率
     coverpoint  slv_if.hsel{ bins hsel = {0,1};}
     coverpoint  slv_if.hwrite{ bins write = {0};
                                bins read = {1};
                                }
     coverpoint  slv_if.hsize{  bins hsize_8 = {2'b00};
                                bins hsize_16 = {2'b01};
                                bins hsize_32 = {2'b10};
                                }
     coverpoint  slv_if.htrans{ bins htrans = {2'b00,2'b01,2'b10,2'b11};
                                 }
     coverpoint  slv_if.haddr{  bins haddr_low = {[32'h0:32'h0000_00FF]};
                                bins haddr_mid = {[32'h0000_100:32'h0000_7FFF]};
                                bins haddr_high = {[32'h0000_8000:32'h0000_FFFF]};
                               }
     coverpoint  slv_if.hwdata{ bins hwdata_0Byte = {[32'h0:32'hFF]};
                                bins hwdata_1Byte = {[32'h100:32'hFF_00]};
                                bins hwdata_2Byte = {[32'h1_0000:32'hFF_0000]};
                                bins hwdata_3Byte = {[32'h100_0000:32'hFF00_0000]};
                               }
     coverpoint  slv_if.hrdata{ bins hrdata_0Byte = {[32'h0:32'hFF]};
                                bins hrdata_1Byte = {[32'h100:32'hFF_00]};
                                bins hrdata_2Byte = {[32'h1_0000:32'hFF_0000]};
                                bins hrdata_3Byte = {[32'h100_0000:32'hFF00_0000]};
                               }
  endgroup

  class tc_base;              //定义基础测试用例testcase，其他用例可在此基础上进行扩展
      int           tr_num;       //设置发包数量
      environment   ahb_env;          //声明环境句柄
      virtual  ahb_slave_if  slv_if;  //例化接口
       
      ahb_slv_cg    slv_cg = new();    //实例化覆盖组，创建对象
       
      extern function new(virtual ahb_slave_if slv_if, int tr_num);
      extern function build();
      extern virtual task run();    //声明virtual run（），是为了实现多态
  endclass
   
  function tc_base::new(virtual ahb_slave_if slv_if, int tr_num);
    this.slv_if = slv_if;      //通过接口实现testcase与environment之间的连接
    this.tr_num = tr_num;
  endfunction
   
  function tc_base::build();
    ahb_env = new(this.slv_if,tr_num);      //将本地slv_if传递给environment，建立连接
    ahb_env.build();                      //通过邮箱和接口，将env中的各个子组件连接，打通数据通道。
  endfunction
   
  task tc_base::run();
    fork
       ahb_env.run();       //运行env中的run（），生产数据，并将其发送到scb,进行数据比对
         begin
           @(posedge slv_if.hclk);
           @(posedge slv_if.hresetn);      //等待复位撤销
           @(posedge slv_if.hclk);
           repeat(tr_num)begin
             @(posedge slv_if.hclk);
             slv_cg.sample();            //核心代码：每一次发包，都对其功能覆盖率进行收集
           end
         end
    join
  endtask
   
  class tc000 extends tc_base;        //继承基类测试用例——用例1
      extern function new(virtual ahb_slave_if slv_if, int tr_num);
      extern virtual task run();    
  endclass    
   
  function tc000::new(virtual ahb_slave_if slv_if, int tr_num);
    super.new(slv_if,tr_num);       //通过super关键字，引用基类中的new函数，建立组件之间的连接
  endfunction
   
  task tc000::run();
    fork
      super.run();     //调用父类的任务run，进行覆盖率收集
      begin   //在run的同时（并发），调用generator的各种场景，产生不同的数据，形成不同的用例
        for(int i=0;i<(tr_num/6);i++)begin
          #1;                         //时间间隔的设置是为了避免event事件触发不会与@等待相冲突
          ahb_env.gen.write_data32(i*4,i);    //由低位开始写数据，注意读写不同位宽数据时的地址变化规律
          #1;  
          ahb_env.gen.write_data16(i*2,i);  
          #1;  
          ahb_env.gen.write_data8(i,i);  
        end
        for(int i=0;i<(tr_num/6);i++)begin
          #1;
          ahb_env.gen.read_data32(i*4);     
          #1;
          ahb_env.gen.read_data16(i*2);    
          #1;
          ahb_env.gen.read_data8(i);                             
        end 
      end
    join
  endtask  

  class tc001 extends tc_base;        //继承基类测试用例——用例2
      extern function new(virtual ahb_slave_if slv_if, int tr_num);
      extern virtual task run();    
  endclass    
   
  function tc001::new(virtual ahb_slave_if slv_if, int tr_num);
    super.new(slv_if,tr_num);       //通过super关键字，引用基类中的new函数，建立组件之间的连接
  endfunction
   
  task tc001::run();
    fork
      super.run();     //调用父类的任务run，进行覆盖率收集
      begin   //在run的同时（并发），调用generator的各种场景，产生不同的数据，形成不同的用例
        for(int i=0;i<(tr_num/6);i++)begin
          #1;                         //时间间隔的设置是为了避免event事件触发不会与@等待相冲突
          ahb_env.gen.write_data32(32'h0000_FFFC-i*4,32'h5A5A_5A5A);    //由高地址位向低地址位写数据
          #1;  
          ahb_env.gen.write_data16(32'h0000_FFFC-i*2,32'h0000_5A5A);  
          #1;  
          ahb_env.gen.write_data8(32'h0000_FFFC-i,32'h0000_005A);  
        end
        for(int i=0;i<(tr_num/6);i++)begin
          #1;
          ahb_env.gen.read_data32(32'h0000_FFFC-i*4);     
          #1;
          ahb_env.gen.read_data16(32'h0000_FFFC-i*2);    
          #1;
          ahb_env.gen.read_data8(32'h0000_FFFC-i);                             
        end 
      end
    join
  endtask  

  class tc002 extends tc_base;        //继承基类测试用例——用例3
      extern function new(virtual ahb_slave_if slv_if, int tr_num);
      extern virtual task run();    
  endclass    
   
  function tc002::new(virtual ahb_slave_if slv_if, int tr_num);
    super.new(slv_if,tr_num);       
  endfunction
   
  task tc000::run();
    fork
      super.run();     //调用父类的任务run，进行覆盖率收集
      begin   //在run的同时（并发），调用generator的各种场景，产生不同的数据，形成不同的用例
        for(int i=0;i<(tr_num/6);i++)begin
          #1;                         
          ahb_env.gen.write_data32_random(i*4);    //由低位开始随机写数据
          #1;  
          ahb_env.gen.write_data16_random(i*2);  
          #1;  
          ahb_env.gen.write_data8_random(i);  
        end
        for(int i=0;i<(tr_num/6);i++)begin
          #1;
          ahb_env.gen.read_data32(i*4);     
          #1;
          ahb_env.gen.read_data16(i*2);    
          #1;
          ahb_env.gen.read_data8(i);                             
        end 
      end
    join
  endtask  

  class tc003 extends tc_base;        //继承基类测试用例——用例4
      extern function new(virtual ahb_slave_if slv_if, int tr_num);
      extern virtual task run();    
  endclass    
   
  function tc003::new(virtual ahb_slave_if slv_if, int tr_num);
    super.new(slv_if,tr_num);      
  endfunction
   
  task tc003::run();
    fork
      super.run();     
      begin   
        for(int i=0;i<(tr_num/12);i++)begin
          #1;                        
          ahb_env.gen.write_data8(32'h0000_FFFC-i,i);    //由高地址位向低地址位写变化数据
          #1;
          ahb_env.gen.no_op();    //插入无效操作
          #1;  
          ahb_env.gen.write_data16(32'h0000_FFFC-i*2,i);  
          #1;  
          ahb_env.gen.no_op();            
          #1;  
          ahb_env.gen.write_data32(32'h0000_FFFC-i*4,i);  
          #1;  
          ahb_env.gen.no_op();  
        end
        for(int i=0;i<(tr_num/12);i++)begin
          #1;
          ahb_env.gen.read_data8(32'h0000_FFFC-i);   
          #1;  
          ahb_env.gen.no_op();             
          #1;
          ahb_env.gen.read_data16(32'h0000_FFFC-i*2);    
          #1;  
          ahb_env.gen.no_op();           
          #1;
          ahb_env.gen.read_data32(32'h0000_FFFC-i*4);    
          #1;  
          ahb_env.gen.no_op();                                    
        end 
      end
    join
  endtask  

  class tc004 extends tc_base;        //继承基类测试用例——用例5
      extern function new(virtual ahb_slave_if slv_if, int tr_num);
      extern virtual task run();    
  endclass    
   
  function tc004::new(virtual ahb_slave_if slv_if, int tr_num);
    super.new(slv_if,tr_num);      
  endfunction
   
  task tc004::run();
    fork
      super.run();     
      begin   
        for(int i=0;i<(tr_num/12);i++)begin
          #1;                        
          ahb_env.gen.write_data8_random(i);    //由低地址位向高地址位写变化数据
          #1;
          ahb_env.gen.no_op();    //插入无效操作
          #1;  
          ahb_env.gen.write_data16_random(i*2);  
          #1;  
          ahb_env.gen.no_op();            
          #1;  
          ahb_env.gen.write_data32_random(i*4);  
          #1;  
          ahb_env.gen.no_op();  
        end
        for(int i=0;i<(tr_num/12);i++)begin
          #1;
          ahb_env.gen.read_data8(i);   
          #1;  
          ahb_env.gen.no_op();             
          #1;
          ahb_env.gen.read_data16(i*2);    
          #1;  
          ahb_env.gen.no_op();           
          #1;
          ahb_env.gen.read_data32(i*4);    
          #1;  
          ahb_env.gen.no_op();                                    
        end 
      end
    join
  endtask 

  class tc005 extends tc_base;        //继承基类测试用例——用例6(增补)
      extern function new(virtual ahb_slave_if slv_if, int tr_num);
      extern virtual task run();    
  endclass    
   
  function tc005::new(virtual ahb_slave_if slv_if, int tr_num);
    super.new(slv_if,tr_num);      
  endfunction
   
  task tc005::run();
    fork
      super.run();     
      begin   
        for(int i=0;i<(tr_num/2);i++)begin         
          #1;  
          ahb_env.gen.write_data32(i*4,100+i);  
        end
        for(int i=0;i<(tr_num/12);i++)begin       
          #1;
          ahb_env.gen.read_data32(i*4);                                    
        end 
      end
    join
  endtask  

tc000     tc0;       //声明测试用例类句柄
tc001     tc1;
tc002     tc2;
tc003     tc3;
tc004     tc4;
tc005     tc5;

initial begin
  $vcdpluson();      //生成波形文件
  if(!$value$plusargs("tc_num=%d",tc_num))begin
    tc_num = 0;
  end
  else begin
    $diaplay("***@%0t::tc_num is : %0d",$time,tc_num);
  end
  
  tc0 = new(slv_if,6000);     //传递接口和发包数量
  tc1 = new(slv_if,600);
  tc2 = new(slv_if,6000);
  tc3 = new(slv_if,1200);
  tc4 = new(slv_if,6000);
  tc5 = new(slv_if,3000);

  if(tc_num == 0)begin
    tc0.build();
    tc0.run();
  end
  else if(tc_num == 1)begin
    tc1.build();
    tc1.run();
  end
  else if(tc_num == 1)begin
    tc1.build();
    tc1.run();
  end
  else if(tc_num == 2)begin
    tc2.build();
    tc2.run();
  end
  else if(tc_num == 3)begin
    tc3.build();
    tc3.run();
  end
  else if(tc_num == 4)begin
    tc4.build();
    tc4.run();
  end
  else if(tc_num == 5)begin
    tc5.build();
    tc5.run();
  end
  else begin
    $display("@%0t : ERROR tc_num(%0d) does not exist",$time,tc_num);
  end

end

endprogram

`endif