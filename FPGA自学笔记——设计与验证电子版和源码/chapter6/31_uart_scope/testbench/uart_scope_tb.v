/*============================================================================
*
*  LOGIC CORE:          串口示波器仿真顶层模块		
*  MODULE NAME:         uart_scope_tb()
*  COMPANY:             芯航线电子工作室
*                       http://xiaomeige.taobao.com
*	author:					小梅哥
*	author QQ Group：472607506
*  REVISION HISTORY:  
*
*    Revision 1.0  01/01/2016     Description: Initial Release.
*
*	FileType	：Testbench
*
*  FUNCTIONAL DESCRIPTION:
*	本模块为串口示波器仿真顶层模块
===========================================================================*/

`timescale 1ns/1ns
`include "../rtl/header.v"
`define sin_data_file "./sin_12bit.txt"
module uart_scope_tb;
	
	reg Clk;
	reg Rst_n;
	reg [1:0]Key_in;
	
/*波特率设置总线，此处默认为9600bps，仿真不做波特率修改测试*/	
	wire [2:0]Baud_Set;
	reg [7:0]Tx_Data;/*串口发送仿真模型待发送数据字节*/
	reg Tx_En;	/*串口发送仿真模型发送使能信号*/
	wire Rs232_MTSR;	/*串口“主机（PC）发送-从机（FPGA）接收”信号*/
	wire Rs232_MRST;	/*串口“主机（PC）接收-从机（FPGA）发送”信号*/
	wire Tx_Done;	/*串口字节发送完成信号*/
	
	assign Baud_Set = 3'd0;/*设置波特率为固定的9600bps*/
	
	wire ADC_SCLK;	//ADC 串行数据接口时钟信号
	wire ADC_CS_N;  //ADC 串行数据接口使能信号
	reg  ADC_DOUT;		//ADC转换结果，由ADC输给FPGA
	wire ADC_DIN;	//ADC控制信号输出，由FPGA发送通道控制字给ADC
	
	wire DAC_CS_N;
	wire DAC_DIN;
	wire DAC_SCLK;
	
	
	reg[11:0]  memory[4095:0];//测试波形数据存储空间
	
	reg[11:0] address;//存储器地址 
	
	//将原始波形数据从文件读取到定义的存储器中
	initial $readmemh(`sin_data_file,memory);//读取原始波形数据读到memory中
	
	integer i;
	
	initial begin
		Rst_n = 0;
		ADC_DOUT = 0;
		address = 0;
		#101;
		Rst_n = 1;
		#100;
		forever begin
			for(address=0;address<4095;address=address+10)begin
				gene_DOUT(memory[address]);	//依次将存储器中存储的波形读出，按照ADC的转换结果输出方式送到DOUT信号线上
				#60;
			end
		end
		#20000;
		$stop;
	end	
	
	//将并行数据按照ADC的数据输出格式，送到ADC_DOUT信号线上，供控制模块采集读取
	task gene_DOUT;
		input [15:0]vdata;
		reg [4:0]cnt;
		begin
			cnt = 0;
			wait(!ADC_CS_N);
			while(cnt<16)begin
				@(negedge ADC_SCLK) ADC_DOUT = vdata[15-cnt];
				cnt = cnt + 1'b1;
			end
			wait(ADC_CS_N);
		end
	endtask
	
	localparam 
		Header = 8'hAA,	/*帧头*/
		Length = 8'd3,		/*帧长*/
		Tail   = 8'h88;	/*帧尾*/

/*------例化串口示波器顶层模块------*/
	uart_scope uart_scope(
		.Clk(Clk),
		.Rst_n(Rst_n),
		.Rs232_Rx(Rs232_MTSR),
		.Rs232_Tx(Rs232_MRST),
		.Key_in(Key_in),
		.ADC_SCLK(ADC_SCLK),
		.ADC_DOUT(ADC_DOUT),
		.ADC_DIN(ADC_DIN),
		.ADC_CS_N(ADC_CS_N),
		.DAC_CS_N(DAC_CS_N),
		.DAC_DIN(DAC_DIN),
		.DAC_SCLK(DAC_SCLK)
	);
	
/*------例化串口发送仿真模型------*/
	Uart_Tx_Model Uart_Tx_Model(
		.Baud_Set(Baud_Set),
		.Tx_Data(Tx_Data),
		.Tx_En(Tx_En),
		.uart_tx(Rs232_MTSR),
		.Tx_Done(Tx_Done)
	);
	
/*------例化串口接收仿真模型------*/
//该模型接收FPGA发送出来的数据并打印在modelsim的transcript窗口中	
	Uart_RX_Model Uart_RX_Model(
		.Baud_Set(Baud_Set),
		.uart_rx(Rs232_MRST)
	);

/*-------生成50M时钟信号--------*/	
	initial Clk = 0;
	always #10 Clk = ~Clk;
	
	initial begin
		Rst_n = 1'b0;
		Tx_En = 1'b0;
		Tx_Data = 8'd0;
		Key_in = 4'b1111;
		#200;
		Rst_n = 1'b1;	/*释放复位信号，系统即进入正常工作状态*/
		#1000;
		En_DDS_Run;	/*使能DDS信号发生器生成信号数据*/
		#10000;
		En_S_DDS;	/*使能采样ADC数据*/
		En_S_ADC;	/*使能采样DDS数据*/
		#10000;
		En_UART_Send;/*使能串口发送，此时串口猎人软件上将会开始持续接收到数据*/	
	end
	
	initial begin
		#200_000_000;press_key(0);
		#200_000_000;press_key(1);
		#200_000_000;
		$stop;
	end
	
	

/*---发送命令帧数据任务-----*/	
	task Send_CMD;
		input [7:0]DATAA,DATAB,DATAC;/*用户数据（地址、数据高字节，数据低字节）*/
		begin
			Tx_Data = Header;/*需发送数据为帧头*/
			Tx_En = 1;	/*启动发送*/
			#20 Tx_En = 0;	/*一个时钟周期后，清零发送启动信号*/
			@(posedge Tx_Done)/*等待发送完成信号*/
			#1000;
			
			Tx_Data = Length;/*需发送数据为帧长，此处帧长只是数据内容的长度*/
			Tx_En = 1;	/*启动发送*/
			#20 Tx_En = 0;	/*一个时钟周期后，清零发送启动信号*/
			@(posedge Tx_Done)/*等待发送完成信号*/
			#1000;
			
			Tx_Data = DATAA;/*需发送数据第一个字节，此数据代表外设寄存器的地址*/
			Tx_En = 1;	/*启动发送*/
			#20 Tx_En = 0;	/*一个时钟周期后，清零发送启动信号*/
			@(posedge Tx_Done)/*等待发送完成信号*/
			#1000;
			
			Tx_Data = DATAB;/*需发送数据第二个字节，此数据代表写入外设寄存器的内容高8位*/
			Tx_En = 1;	/*启动发送*/
			#20 Tx_En = 0;	/*一个时钟周期后，清零发送启动信号*/
			@(posedge Tx_Done)/*等待发送完成信号*/
			#1000;
			
			Tx_Data = DATAC;/*需发送数据第三个字节，此数据代表写入外设寄存器的内容低8位*/
			Tx_En = 1;	/*启动发送*/
			#20 Tx_En = 0;	/*一个时钟周期后，清零发送启动信号*/
			@(posedge Tx_Done)/*等待发送完成信号*/
			#1000;
			
			Tx_Data = Tail;/*需发送数据为帧尾*/
			Tx_En = 1;	/*启动发送*/
			#20 Tx_En = 0;	/*一个时钟周期后，清零发送启动信号*/
			@(posedge Tx_Done)/*等待发送完成信号*/
			#1000;
			#10000;	
		end
	endtask	
	
	task En_DDS_Run;/*使能DDS生成数据*/
		begin
			Send_CMD(`DDS_En, 8'h00, 8'h01);
			$display("En DDS Run");
		end
	endtask
	
	task Stop_DDS_Run;/*停止DDS生成数据*/
		begin
			Send_CMD(`DDS_En, 8'h00, 8'h00);
			$display("Stop DDS Run");
		end
	endtask
	
	task En_S_DDS;/*使能采样DDS数据*/
		begin
			Send_CMD(`DDS_Sample_En, 8'h00, 8'h01);
			$display("En Sample DDS data");
		end
	endtask
	
	task Stop_S_DDS;/*停止采样DDS数据*/
		begin
			Send_CMD(`DDS_Sample_En, 8'h00, 8'h00);
			$display("Stop Sample DDS data");
		end
	endtask
	
	task En_UART_Send;/*使能串口发送*/
		begin
			Send_CMD(`UART_En_Tx, 8'h00, 8'h01);
			$display("En UART Send");
		end
	endtask
	
	task Stop_UART_Send;/*停止串口发送*/
		begin
			Send_CMD(`UART_En_Tx, 8'h00, 8'h00);
			$display("Stop UART Send");
		end
	endtask
	
		task En_S_ADC;/*使能采集ADC数据*/
		begin
			Send_CMD(`ADC_Sample_En, 8'h00, 8'h01);
			$display("En Sample ADC data");
		end
	endtask
	
	task Stop_S_ADC;/*停止采集ADC数据*/
		begin
			Send_CMD(`ADC_Sample_En, 8'h00, 8'h00);
			$display("Stop Sample ADC data");
		end
	endtask

	task Set_ADC_Sample_Speed;/*设置ADC采样率*/
		input[25:0] Fs;/*采样率实际频率*/
		reg [31:0] S_cnt_top;/*分频计数器计数最大值*/
		begin
		/*由采样实际频率值换算出采样分频计数器计数最大值*/
			S_cnt_top = 50000000/Fs - 1;
		/*写采样分频计数器计数最大值低16位*/
			Send_CMD(`ADC_S_Cnt_Max_L,S_cnt_top[15:8],S_cnt_top[7:0]);
		/*写采样分频计数器计数最大值高16位*/
			Send_CMD(`ADC_S_Cnt_Max_H,S_cnt_top[31:24],S_cnt_top[23:16]);
			$display("Set ADC Sample Speed as  = %0d" ,Fs);
		end
	endtask
	
	task Set_DDS_Sample_Speed;/*设置DDS数据的采样率*/
		input[25:0] Fs;/*采样率实际频率*/
		reg [31:0] S_cnt_top;/*分频计数器计数最大值*/
		begin
		/*由采样实际频率值换算出采样分频计数器计数最大值*/
			S_cnt_top = 50000000/Fs - 1;
		/*写采样分频计数器计数最大值低16位*/	
			Send_CMD(`DDS_S_Cnt_Max_L,S_cnt_top[15:8],S_cnt_top[7:0]);
		/*写采样分频计数器计数最大值高16位*/
			Send_CMD(`DDS_S_Cnt_Max_H,S_cnt_top[31:24],S_cnt_top[23:16]);
			$display("Set DDS Sample Speed as  = %0d" ,Fs);
		end
	endtask
	
	task Set_DDS_Fout_Speed;/*设置DDS输出信号频率*/
		input[25:0] Fs;/*输出信号实际频率*/
		reg [31:0] r_fword;/*DDS频率控制字*/
		begin
		/*由实际要求输出频率数据换算出频率控制字*/
			r_fword = Fs*65536*65536/50000000;
			Send_CMD(`DDS_Fword_L,r_fword[15:8],r_fword[7:0]);
			Send_CMD(`DDS_Fword_H,r_fword[31:24],r_fword[23:16]);
			$display("Set DDS Fout as = %0d" ,Fs);
		end
	endtask
	
	
	task press_key;
		input [1:0]Key;
		reg [15:0]myrand;
		begin
			Key_in = 2'b11;
			/*按下抖动*/
			repeat(20)begin
				myrand = {$random} % 65536;
				#myrand Key_in[Key] = ~Key_in[Key];
			end
			Key_in[Key] = 1'b0;
						
			#22000000;/*稳定期*/
			
			/*释放抖动*/
			repeat(20)begin
				myrand = {$random} % 65536;
				#myrand Key_in[Key] = ~Key_in[Key];
			end
			Key_in[Key] = 1'b1;
			#22000000;/*稳定期*/
		end
	endtask
		
endmodule
