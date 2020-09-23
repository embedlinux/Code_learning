/***************************************************
*	Module Name		:	block_nonblock		   
*	Engineer		:	小梅哥
*	Target Device	:	EP4CE10F17C8
*	Tool versions	:	Quartus II 13.0
*	Create Date		:	2017-3-31
*	Revision		:	v1.0
*	Description		:   阻塞赋值与非阻塞赋值设计与比较
**************************************************/

//请按照书中所说，依次选择每一种方式进行仿真，查看波形

/*
module block_nonblock(Clk,Rst_n,a,b,c,out);

	input Clk;
	input Rst_n;
	input a,b,c;
	output reg [1:0]out;
	    reg [1:0] d;    
    always@(posedge Clk or negedge Rst_n)
    if(!Rst_n)
        out = 2'b0;
    else begin
        
        out = d + c;
		  d  = a + b ;
    end  

	
endmodule

*/
/* 
module block_nonblock(Clk,Rst_n,a,b,c,out);

	input Clk;
	input Rst_n;
	input a,b,c;
	output reg [1:0]out;
	
	//out = a + b + c;
	
	//d = a+b;
	//out = d + c;
	
	reg [1:0] d;
	
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		out <= 2'b0;
	else begin
		out <= a + b + c;
	end
	
endmodule


*/
module block_nonblock(Clk,Rst_n,a,b,c,out);

	input Clk;
	input Rst_n;
	input a,b,c;
	output reg [1:0]out;
	
	reg [1:0] d;
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		out <=  2'b0;
	else begin	
        out <= d + c;
        d  <= a + b;
		
	end
	
endmodule
