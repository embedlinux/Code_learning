
`define ADC_S_Cnt_Max_L 8'd1	/*ADC采样分频计数器计数最大值的低16位，ADDR = 8'd1*/
`define ADC_S_Cnt_Max_H 8'd2	/*ADC采样分频计数器计数最大值的高16位，ADDR = 8'd2*/
`define ADC_Sample_En	8'd3	/*ADC采样使能寄存器，ADDR = 8'd3*/
`define UART_En_Tx  		8'd4	/*串口发送使能寄存器，ADDR = 8'd4*/
`define UART_Baud_Set	8'd5	/*串口发送波特率设置寄存器，ADDR = 8'd5*/

`define DDS_En				8'd6	/*DDS使能寄存器，ADDR = 8'd6*/
`define DDS_Fword_H 		8'd7	/*DDS频率控制字高16位,ADDR = 8'd7*/
`define DDS_Fword_L 		8'd8	/*DDS频率控制字低16位,ADDR = 8'd8*/
`define DDS_Pword 		8'd9	/*DDS相位控制字,ADDR = 8'd9*/

`define DDS_S_Cnt_Max_L 8'd10	/*DDS采样分频计数器计数最大值的低16位，ADDR = 8'd10*/
`define DDS_S_Cnt_Max_H 8'd11	/*DDS采样分频计数器计数最大值的高16位，ADDR = 8'd11*/
`define DDS_Sample_En	8'd12	/*DDS采样使能寄存器，ADDR = 8'd12*/