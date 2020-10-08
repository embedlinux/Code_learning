//------------
module fifo_tb();
reg clk,rst;
reg wr_n,rd_n;
reg[7:0] di;
wire[7:0] do;
reg[7:0] data_reg[0:15];
reg[7:0] buf1,buf2;

//------------------
task half_pulse;//ÈÎÎñ
  #1 clk = ~ clk;
endtask
//------------------
task pulse;
input[7:0] num;
integer i;
    for(i=0;i<num;i=i+1)
      begin
          half_pulse;
          half_pulse;
      end
endtask
//------------------
task write_byte;
input[7:0] data;
begin
    wr_n = 1'b0;
    di = data;
    pulse(1);
    wr_n = 1'b1;
    pulse(1); 
end 
endtask
//------------------
task read_byte;
output[7:0] data_buf;
begin
    rd_n = 1'b0;
    pulse(1);
    data_buf = do;
    rd_n = 1'b1;
    pulse(1);
end
endtask
//------------------
initial begin
     clk = 1'b0;
     rst = 1'b1;
     wr_n = 1'b1;
     rd_n = 1'b1;
     di = 8'h00;
    
    buf1 = 8'h00;
    buf2 = 8'h00;
    
     pulse(10);
     //-----------------
     write_byte(8'h12);
     write_byte(8'h15);
     read_byte(buf1);
     read_byte(buf2);
   
        #1
     if((buf1[0] != 8'h12) || (buf2[1] != 8'h15))
     begin 
        $display("error at step1");
        $stop();
     end
     
     #1
        $display("no error"); 
      
     $stop(10);
    
end
//--------------
endmodule