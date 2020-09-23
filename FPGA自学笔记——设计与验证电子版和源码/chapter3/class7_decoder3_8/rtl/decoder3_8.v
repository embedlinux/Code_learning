/***************************************************
*	Module Name		:	decoder3_8		   
*	Engineer		:	小梅哥
*	Target Device	:	EP4CE10F17C8
*	Tool versions	:	Quartus II 13.0
*	Create Date		:	2017-3-31
*	Revision		:	v1.0
*	Description		:   组合逻辑之三八译码器设计
**************************************************/

module decoder3_8(
		a,
		b,
		c,
		out
	);

	input a;//输入端口A
	input b;//输入端口B
	input c;//输入端口C
	
	output [7:0]out;//输出端口
	reg [7:0]out;
	
	always@(a,b,c)begin
		case({a,b,c})
			3'b000:out = 8'b0000_0001;
			3'b001:out = 8'b0000_0010;
			3'b010:out = 8'b0000_0100;
			3'b011:out = 8'b0000_1000;
			3'b100:out = 8'b0001_0000;
			3'b101:out = 8'b0010_0000;
			3'b110:out = 8'b0100_0000;
			3'b111:out = 8'b1000_0000;
		endcase	
	end

endmodule
