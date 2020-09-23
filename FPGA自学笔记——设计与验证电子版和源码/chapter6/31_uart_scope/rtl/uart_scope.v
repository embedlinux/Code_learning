/*============================================================================
*
*  LOGIC CORE:          串口示波器顶层模块		
*  MODULE NAME:         uart_scope()
*  COMPANY:             芯航线电子工作室
*                       http://xiaomeige.taobao.com
*	author:					小梅哥
*	author QQ Group：472607506
*  REVISION HISTORY:  
*
*    Revision 1.0  01/01/2016     Description: Initial Release.
*
*  FUNCTIONAL DESCRIPTION:
*	本模块为串口示波器顶层模块
===========================================================================*/

module uart_scope(
	Clk,
	Rst_n,
	Rs232_Rx,
	Rs232_Tx,
	Key_in,
	ADC_SCLK,
	ADC_DOUT,
	ADC_DIN,
	ADC_CS_N,
	DAC_CS_N,
	DAC_DIN,
	DAC_SCLK
);

	input Clk;	/*系统时钟，50M*/
	input Rst_n;	/*全局复位，低电平复位*/
	input Rs232_Rx;	/*串口接收引脚*/
	output Rs232_Tx;	/*串口发送引脚*/
	input [1:0]Key_in;	/*按键输入*/
	
	output ADC_SCLK;	//ADC 串行数据接口时钟信号
	output ADC_CS_N;  //ADC 串行数据接口使能信号
	input  ADC_DOUT;		//ADC转换结果，由ADC输给FPGA
	output ADC_DIN;	//ADC控制信号输出，由FPGA发送通道控制字给ADC
	
	output DAC_CS_N;
	output DAC_DIN;
	output DAC_SCLK;
	
	reg [2:0]ADC_Channel;

	wire [2:0]Baud_Set; /*波特率设置信号*/
	
	wire [7:0]Rx_Byte;	/*串口接收到的字节数据*/
	wire Rx_Int;		/*串口接收字节成功标志信号*/
	
	wire Byte_En;		/*串口字节数据发送使能信号*/
	wire Tx_Done;		/*串口发送字节数据完成标志*/
	
	wire ADC_En;		/*ADC单次转换使能信号*/
	wire [11:0]ADC_Data;	/*ADC采样结果*/
	wire ADC_Flag;		/*ADC转换结果有效标志*/
	wire ADC_Busy;		/*ADC工作忙标志*/
	
	wire m_wr;	/*主机写数据的请求*/
	wire [7:0]m_addr;	/*主机写数据的地址*/
	wire [15:0]m_wrdata;	/*主机写数据*/
	
	wire [11:0]DDS_Data;	/*DDS生成的波形数据*/
	wire DDS_Flag;	/*DDS采样使能标志*/
	
	wire Data_Flag;	/*数据有效标志（根据用户按键进行选择DDS_Flag 或ADC_Flag）*/
	wire [7:0]Data_Byte;/*串口发送字节数据*/
	
	reg Data_Sel;	/*数据选择信号（选择串口发送DDS_Data 或 ADC_Data）*/
	reg Flag_Sel;	/*数据有效标志信号选择信号（选择DDS_Flag 或ADC_Flag）*/
	
	wire [1:0]Key_Flag;	/*按键检测成功标志信号*/
	wire [1:0]Key_Value;	/*按键检测结果*/

/*-----------例化串口字节接收模块-------*/	
	Uart_Byte_Rx Uart_Byte_Rx(
		.Clk(Clk),
		.Rst_n(Rst_n),
		.Baud_Set(Baud_Set),
		.Rs232_Rx(Rs232_Rx),
		.Rx_Byte(Rx_Byte),
		.Rx_Done(Rx_Int)
	);
	
/*-----------例化串口接收到的命令解析模块-------*/	
	CMD CMD(
		.Clk(Clk),
		.Rst_n(Rst_n),
		.Rx_Byte(Rx_Byte),
		.Rx_Int(Rx_Int),
		.m_wr(m_wr),
		.m_addr(m_addr),
		.m_wrdata(m_wrdata)
	);

/*-----------例化串口字节发送模块-------*/		
	UART_Byte_Tx UART_Byte_Tx(	
		.Clk(Clk),
		.Rst_n(Rst_n),
		.Byte_En(Byte_En),
		.Baud_Set(Baud_Set),
		.Data_Byte(Data_Byte),
		.Tx_Done(Tx_Done),
		.Rs232_Tx(Rs232_Tx)
	);
	
/*-----------例化串口字节发送控制模块-------*/	
	UART_Tx_Ctrl UART_Tx_Ctrl(
		.Clk(Clk),
		.Rst_n(Rst_n),
		.m_wr(m_wr),
		.m_addr(m_addr),
		.m_wrdata(m_wrdata),
		.ADC_Flag(Data_Flag),
		.ADC_Busy(ADC_Busy),
		.Byte_En(Byte_En),
		.Tx_Done(Tx_Done),
		.Baud_Set(Baud_Set)
	);

/*-----------例化ADC采样使能控制模块-------*/	
	Sample_Ctrl Sample_Ctrl(
		.Clk(Clk),
		.Rst_n(Rst_n),
		.m_wr(m_wr),
		.m_addr(m_addr),
		.m_wrdata(m_wrdata),
		.ADC_En(ADC_En)
	);

/*-----------例化ADC转换控制模块-------*/			
	adc128s022 adc128s022(
		.Clk(Clk),
		.Rst_n(Rst_n),
		.Channel(ADC_Channel),	//固定仅使用通道0采样
		.Data(ADC_Data),	//仅选取ADC采样结果的高8位
		.En_Conv(ADC_En),
		.Conv_Done(ADC_Flag),
		.ADC_State(ADC_Busy),
		.DIV_PARAM(8),
		.SCLK(ADC_SCLK),
		.DOUT(ADC_DOUT),
		.DIN(ADC_DIN),
		.CS_N(ADC_CS_N)
	);

/*-----------例化DDS信号发生器模块-------*/	
	DDS DDS(
		.Clk(Clk),
		.Rst_n(Rst_n),
		.m_wr(m_wr),
		.m_addr(m_addr),
		.m_wrdata(m_wrdata),
		.DDS_Data(DDS_Data),
		.DDS_Flag(DDS_Flag)
	);

/*-----------例化DAC信号发生器模块-------*/	
	tlv5618 tlv5618(
		.Clk(Clk),
		.Rst_n(Rst_n),
		
		.DAC_DATA({4'd0,1'b0,DDS_Data[11:1]}),
		.Start(DDS_Flag),
		.Set_Done(),
		.DIV_PARAM(4),
		
		.CS_N(DAC_CS_N),
		.DIN(DAC_DIN),
		.SCLK(DAC_SCLK),
		.DAC_State()
	);

/*-----------例化独立按键检测消抖模块-------*/		
	key_filter key_filter0(
		.Clk(Clk),
		.Rst_n(Rst_n),
		.key_in(Key_in[0]),
		.key_flag(Key_Flag[0]),
		.key_state(Key_Value[0])
	);

	key_filter key_filter1(
		.Clk(Clk),
		.Rst_n(Rst_n),
		.key_in(Key_in[1]),
		.key_flag(Key_Flag[1]),
		.key_state(Key_Value[1])
	);

/*串口待发送字节数据选择二选一多路器*/	
	assign Data_Byte = Data_Sel?DDS_Data[11:4]:ADC_Data[11:4];
	
/*串口待发送字节数据有效标志二选一多路器*/	
	assign Data_Flag = Flag_Sel?DDS_Flag:ADC_Flag;

/*根据用户按键动作选择数据和标志信号多路器通道*/	
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)begin
		Data_Sel <= 1'b1;
		Flag_Sel <= 1'b1;
	end
	else if(Key_Flag && (Key_Value == 2'b01))begin
		Data_Sel <= ~Data_Sel;
		Flag_Sel <= ~Flag_Sel;
	end
	else begin
		Data_Sel <= Data_Sel;
		Flag_Sel <= Flag_Sel;	
	end
		
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		ADC_Channel <= 0;
	else if(Key_Flag && (Key_Value == 2'b10))
		ADC_Channel <= ADC_Channel + 1'd1;
	else
		ADC_Channel <= ADC_Channel;
		
endmodule
