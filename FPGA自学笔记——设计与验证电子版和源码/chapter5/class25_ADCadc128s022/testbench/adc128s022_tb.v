`timescale 1ns/1ns

/*注意，由于使用联合仿真的时候，modelsim的默认目录是当前Quartus工
程下的simulation目录下的modelsim文件夹，所以，需要在执行仿真前手
动将sin_12bit.txt文件拷贝到simulation/modelsim下。修改了
sin_12bit.txt内容后也请记得重新覆盖modelsim下的sin_12bit.txt文件
*/
`define sin_data_file "./sin_12bit.txt"

module adc128s022_tb;

	reg Clk;
	reg Rst_n;
	reg [2:0]Channel;
	wire [11:0]Data;
	
	reg En_Conv;
	wire Conv_Done;
	wire ADC_State;
	wire [7:0]DIV_PARAM;
	
	wire ADC_SCLK;
	wire ADC_CS_N;
	reg  ADC_DOUT;
	wire ADC_DIN;
	
	assign DIV_PARAM = 13;
	
	reg[11:0]  memory[4095:0];//测试波形数据存储空间
	
	reg[11:0] address;//存储器地址 

	adc128s022 adc128s022(
		.Clk(Clk),
		.Rst_n(Rst_n),
		.Channel(Channel),
		.Data(Data),
		.En_Conv(En_Conv),
		.Conv_Done(Conv_Done),
		.ADC_State(ADC_State),
		.DIV_PARAM(DIV_PARAM),
		.ADC_SCLK(ADC_SCLK),
		.ADC_DOUT(ADC_DOUT),
		.ADC_DIN(ADC_DIN),
		.ADC_CS_N(ADC_CS_N)
	);

	initial Clk = 1'b1;
	always #10 Clk = ~Clk;
	
	//将原始波形数据从文件读取到定义的存储器中
	initial $readmemh(`sin_data_file,memory);//读取原始波形数据读到memory中

	integer i;
	
	initial begin
		Rst_n = 0;
		Channel = 0;
		En_Conv = 0;
		ADC_DOUT = 0;
		address = 0;
		#101;
		Rst_n = 1;
		#100;
		Channel = 5;
		for(i=0;i<3;i=i+1)begin
			for(address=0;address<4095;address=address+1)begin
				En_Conv = 1;
				#20;
				En_Conv = 0;
				gene_DOUT(memory[address]);	//依次将存储器中存储的波形读出，按照ADC的转换结果输出方式送到DOUT信号线上
				@(posedge Conv_Done);	//等待转换完成信号
				#200;
			end
		end
		#20000;
		$stop;
	end	
	
	//将并行数据按照ADC的数据输出格式，送到DOUT信号线上，供控制模块采集读取
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
		end
	endtask
	
endmodule
