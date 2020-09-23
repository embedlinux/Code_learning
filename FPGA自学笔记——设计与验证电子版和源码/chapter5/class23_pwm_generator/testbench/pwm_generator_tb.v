`timescale 1ns/1ns
`define clk_period 20

module pwm_generator_tb;

	reg Clk50M;	//50MHz时钟输入
	reg Rst_n;	//复位输入，低电平复位
	reg cnt_en;	//计数使能信号
	reg [31:0]counter_arr;//输入32位预重装值
	reg [31:0]counter_ccr;//输入32位输出比较值
	wire o_pwm;	//pwm输出信号

	pwm_generator pwm_generator(
		.Clk50M(Clk50M),
		.Rst_n(Rst_n),
		.cnt_en(cnt_en),
		.counter_arr(counter_arr),
		.counter_ccr(counter_ccr),
		.o_pwm(o_pwm)
	);
	
	initial Clk50M = 0;
	always #(`clk_period/2) Clk50M = ~Clk50M;
	
	initial begin
		Rst_n = 0;
		cnt_en = 0;
		counter_arr = 0;
		counter_ccr = 0;
		#(`clk_period*20 +1);
		Rst_n = 1;
		#(`clk_period*10 +1);
		counter_arr = 999;//设置输出信号频率为50KHz
		counter_ccr = 400;//设置输出PWM波占空比为40%
		#(`clk_period*10);
		cnt_en = 1;	//启动计数以产生PWM输出
		#100050;
		counter_ccr = 700;//设置输出PWM波占空比为70%
		#100050;
		cnt_en = 0;	//停止计数以关闭PWM输出
		counter_arr = 499;//设置输出信号频率为100KHz
		counter_ccr = 250;//设置输出PWM波占空比为50%
		#(`clk_period*10);
		cnt_en = 1;	//启动计数以产生PWM输出
		#50050;
		counter_ccr = 100;//设置输出PWM波占空比为20%
		#50050;
		$stop;
	end

endmodule
