//UM functions:
//1: includes 4 interafce: localbus, cdp input, cdp output, and ddr2.
//2: works on pass-through mode, users can test a ping packet between external prot2 and port3. In FPGA, there are
//   port1 and port2 because port number is countered since 0.
//3: Eight UM ID registers and Eight UM RAM registers are defined in this mudule, and UM ID0-ID3 are read only;
//4: DDR2 interface is accessable via localbus in this module. In UM specification, UM supports mutiple words ddr2 write and read,
//   since the reason of simplification, we only support one word ddr2 write or read here. If users need continous access as 
//   long as 127 words, you can receive command and data via ethernet packets from any external port.
module UM(
			clk,
			reset,

//////////////localbus control/////////////////////////////////////                                 
         localbus_cs_n,
         localbus_rd_wr,
         localbus_data,
         localbus_ale, 
         localbus_ack_n,  
         localbus_data_out,						  

////////////// CDP input control //////////////////////////////////
			um2cdp_path,					//if um2cdp_path=0, packets are routed to UM, else if um2cdp_path=1, packets are routed to CDP.
         cdp2um_data_valid,
         cdp2um_data,
         um2cdp_tx_enable,				//change the name by mxl and ccz according to UM2.0;
   
////////////// CDP output control /////////////////////////////////  
         um2cdp_data_valid,
         um2cdp_data,
         cdp2um_tx_enable,				//change the name by mxl and ccz according to UM2.0;
			um2cdp_rule,
			um2cdp_rule_wrreq,
			cdp2um_rule_usedw,

////////////// UM_DDR2 control ////////////////////////////////////
			um2ddr_wrclk,
			um2ddr_wrreq, 
			um2ddr_wdata, 
			ddr2um_ready,
			um2ddr_command_wrreq, 
			um2ddr_command,
			um2ddr_rdclk,
			um2ddr_rdreq, 			
			ddr2um_rdata,
			um2ddr_valid_rdreq, 
			ddr2um_valid_rdata, 
			ddr2um_valid_empty

			);
               
			input 			clk;              		//125M System Clock;
			input 			reset;						//System Reset;

			input 			cdp2um_data_valid;      //data valid indicator from CDP input_ctrl, active high. while cdp2um_data_valid=1, cdp2um_data concludes a valid packets;
			input	[138:0] 	cdp2um_data;        		//packet data from CDP input_ctrl;
			output			um2cdp_tx_enable;			//Tx enable to CDP input_ctrl, active high;
			
			output 			um2cdp_path;				//if um2cdp_path=0, packets are routed to UM, else id um2cdp_path=1, packets are routed to CDP.
																//um2cdp_path is used to define the direction out from CDP_input_ctrl's packets(to input2output FIFO or to UM).
			input 			localbus_cs_n;				//chip select, active low;
			input 			localbus_rd_wr;			//read_write operation. 1-read, 0-write;
			input [31:0] 	localbus_data;				//multiplex address and data, while localbus_ale=1, it is addrsss which follwed by actual data;
			input 			localbus_ale;				//address latch enable. while localbus_ale=1, localbus_data concludes addrsss; 
			output 			localbus_ack_n;			//acknowledge from UM, active low;
			output [31:0]	localbus_data_out;		//read data from UM;

			output			um2cdp_data_valid;		//data_valid indicator to CDP output_ctrl, active high. while um2cdp_data_valid=1, um2cdp_data concludes a valid packets;
			output [138:0] um2cdp_data;				//packet data to CDP output_ctrl;
			input  			cdp2um_tx_enable;			//Tx enable from CDP output_ctrl, active high;
			output [29:0] 	um2cdp_rule;				//rule to CDP output_ctrl, defines the forward rules;
			output 			um2cdp_rule_wrreq;		//rule write requirement;
			input [4:0]		cdp2um_rule_usedw;		//number of words in rule fifo;
		  
			output			um2ddr_wrclk; 				//um to ddr2 write clock;
			output			um2ddr_wrreq; 				//um to ddr2 write requirement, active high;
			output [127:0]	um2ddr_wdata; 				//um to ddr2 write data;
			input				ddr2um_ready;				//ready indicator from write data and command fifo, active high;
			output			um2ddr_command_wrreq; 	//um to ddr2 write command requirement, active high;
			output [33:0]	um2ddr_command;			//um to ddr2 write command;
			output			um2ddr_rdclk; 				//um to ddr2 read clock;
			output			um2ddr_rdreq; 				//um to ddr2 read requirement, active high;
			input	 [127:0]	ddr2um_rdata;				//ddr2 to um read data;
			output			um2ddr_valid_rdreq; 		//ddr2 to um information fifo read requirement;
			input	[6:0]		ddr2um_valid_rdata; 		//ddr2 to um information fifo read data;
			input				ddr2um_valid_empty;		//ddr2 to um information fifo empty indicator;
      
			reg 				um2cdp_tx_enable;
			reg 				um2cdp_data_valid;
			reg [138:0] 	um2cdp_data;
			reg [29:0] 		um2cdp_rule;		
			reg 				um2cdp_rule_wrreq;		
		   
			wire 				um2cdp_path;				
			wire [138:0]	cdp2um_data_q;
			reg 				cdp2um_data_rdreq;
			wire [7:0]		cdp2um_data_usedw;
		  
			reg [3:0] 		input_port_reg;			//input port number;
			
			reg	[1:0]		cdp2um_state;				//UM receive state;
			reg	[2:0]		um2cdp_state;				//UM transmit state;
			parameter		pass_through_idle = 3'b000, pass_through_header1 = 3'b001, pass_through_header2 = 3'b010, pass_through_header3 = 3'b011;  
			parameter		pass_through_header4 = 3'b100, pass_through_payload = 3'b101;  

			reg	[27:0]	localbus_addr;
			reg				localbus_ack_n;
			reg	[31:0]	localbus_data_in,localbus_data_out;
			reg	[2:0]		localbus_state;
			parameter		localbus_idle=3'b000, localbus_address=3'b001,localbus_write=3'b010,localbus_read=3'b011,localbus_ack=3'b100;
			reg	[31:0]	UM_ID0,UM_ID1,UM_ID2,UM_ID3,UM_ID4,UM_ID5,UM_ID6,UM_ID7;				//UM ID registers;
			reg	[31:0]	UM_RAM0,UM_RAM1,UM_RAM2,UM_RAM3,UM_RAM4,UM_RAM5,UM_RAM6,UM_RAM7;	//UM RAM registers;
			 
			reg				um2ddr_wrreq; 
			reg	[127:0]	um2ddr_wdata; 
			reg				um2ddr_command_wrreq; 
			reg	 [33:0]	um2ddr_command;
			reg				um2ddr_rdreq; 			
			reg				um2ddr_valid_rdreq; 
			reg	[2:0]		um2ddr_state;
			reg	[31:0]	UM2DDR_WDATA0,UM2DDR_WDATA1,UM2DDR_WDATA2,UM2DDR_WDATA3;				//UM to DDR2 write data registers;
			reg	[31:0]	UM2DDR_RDATA0,UM2DDR_RDATA1,UM2DDR_RDATA2,UM2DDR_RDATA3;				//DDR2 to UM read registers;
			reg	[31:0]	UM2DDR_COMMAND0, UM2DDR_COMMAND1;  											//UM to DDR2 command registers;
			parameter		um2ddr_idle=3'b000, um2ddr_order=3'b001, um2ddr_write=3'b010, um2ddr_valid_wait=3'b011;
			parameter		um2ddr_valid_read=3'b100,um2ddr_data_read=3'b101;
			
//define forward rule here, users can implement his own looking-table forward arithmetic. The route tables can be saved in UM
//RAM registers or external DDR2 memory. 
//rule[29] tells CDP output_ctrl where the packets come from. rule[29]=0, packets come from UM, else from CDP.						
//normally the forward rule should be formed according to the route table, for the reason of simplification, we defined
//the value of rule directly here.
always@(posedge clk or negedge reset)
    if(!reset)	
    	begin
		 um2cdp_rule <=30'b0;					//clear all output signals in reset;
		 um2cdp_rule_wrreq <= 1'b0;
		 input_port_reg <= 4'b0;
		 end
		else
		  begin
			  if((cdp2um_data_valid==1'b1)&&(cdp2um_data[138:136]==3'b101))	//paclets header coming;
				input_port_reg <= cdp2um_data[131:128];								//latch input port number;
			  
			  if((cdp2um_data_valid==1'b1)&&(cdp2um_data[138:136]==3'b110)&&(cdp2um_rule_usedw<5'd30))   //packet end coming;
					begin
						/////////////port switch/////////////////////////
						if(input_port_reg==UM_RAM0[3:0])          //from external port_x(logic port_x-1);
							begin
								um2cdp_rule <=UM_RAM1[29:0];			//to external port_y(logic port_y-1), and tell CDP output_ctrl, packets are coming from UM;
								um2cdp_rule_wrreq <=1'b1;				//give a rule write requirement;
							end
						else if(input_port_reg==UM_RAM2[3:0])     //from external port_y(logic port_y-1);
							begin
								um2cdp_rule <=UM_RAM3[29:0];			//to external port_x(logic port_x-1);
								um2cdp_rule_wrreq <=1'b1;
							end
						else
							begin
								um2cdp_rule <=32'h02000000;			//discard packets from error ports;
								um2cdp_rule_wrreq <=1'b1;				//packets from other ports, no rule written;	 
							end
					end
				else
					um2cdp_rule_wrreq <= 1'b0;								
			end

//output um2cdp_tx_enable to CDP input_ctrl;
always@(posedge clk or negedge reset)
	if(!reset)	
		begin
			um2cdp_tx_enable <= 1'b0;			
			cdp2um_state <= 2'b00;
		end
	else case(cdp2um_state)
		2'b00:
			if((cdp2um_data_usedw<8'd161) && (cdp2um_rule_usedw<5'd30) && (cdp2um_data_valid==1'b0))	//pass_through fifo and rule fifo have space simultaneously and cdp input_ctrl is idle;
				begin
					um2cdp_tx_enable <= 1'b1;			
					cdp2um_state <= 2'b01;
				end
		2'b01:
			if(cdp2um_data_valid==1'b1)	//modified by CCZ according to um2.0, falls to 0 after cdp2um_data_valid=1;
				begin
					um2cdp_tx_enable <= 1'b0;			
					cdp2um_state <= 2'b00;
				end
		default:
				begin
					um2cdp_tx_enable <= 1'b0;			
					cdp2um_state <= 2'b00;
				end
		endcase	

		assign	um2cdp_path = um2cdp_rule[29]; //0-from UM, 1-from CDP;


//use a FIFO_256x139 same as input2output_fifo to buffer packets from CDP to UM;
input2output_128_139 CDP2UM_DATA_FIFO(
	.aclr(!reset),
	.clock(clk),
	.data(cdp2um_data),
	.rdreq(cdp2um_data_rdreq),
	.wrreq(cdp2um_data_valid), 		
	.q(cdp2um_data_q),
	.usedw(cdp2um_data_usedw)
   ); 

//read whole packet and change first 64 Bytes;
//This is the simplest pass_through operation;
always@(posedge clk or negedge reset)
	if(!reset)	
		begin
			cdp2um_data_rdreq <= 1'b0;
			um2cdp_data_valid <=1'b0;
			um2cdp_data <= 139'b0;
			um2cdp_state <= pass_through_idle;
		end
	else case(um2cdp_state)
		pass_through_idle:
			begin
				cdp2um_data_rdreq <= 1'b0;
				um2cdp_data_valid <= 1'b0;
				um2cdp_data <= 139'b0;
			if(cdp2um_tx_enable == 1'b1)							//CDP output_ctrl is ready;
				begin
					cdp2um_data_rdreq <= 1'b1;						//read CDP2UM_DATA_FIFO;
					um2cdp_state <= pass_through_header1;
				end
			end
		pass_through_header1:
			begin
				cdp2um_data_rdreq <= 1'b1;							
				um2cdp_data_valid <= 1'b1;							//give packet header;
				um2cdp_data <= cdp2um_data_q;						//if you want, you can modify the first 4 words from here.
				um2cdp_state <= pass_through_header2;			//also, you can serch a table using the first 4 words and then to decide the rules.
			end
		pass_through_header2:
			begin
				cdp2um_data_rdreq <= 1'b1;
				um2cdp_data_valid <= 1'b1;
				um2cdp_data <= cdp2um_data_q;
				um2cdp_state <= pass_through_header3;
			end
		pass_through_header3:
			begin
				cdp2um_data_rdreq <= 1'b1;
				um2cdp_data_valid <= 1'b1;
				um2cdp_data <= cdp2um_data_q;
				um2cdp_state <= pass_through_header4;
			end
		pass_through_header4:
			begin
				cdp2um_data_rdreq <= 1'b1;
				um2cdp_data_valid <= 1'b1;
				um2cdp_data <= cdp2um_data_q;
				if(cdp2um_data_q[138:136]==3'b110)				//packet end coming;
					um2cdp_state <= pass_through_idle;
				else
					um2cdp_state <= pass_through_payload;
			end
		pass_through_payload:
			begin
				cdp2um_data_rdreq <= 1'b1;
				um2cdp_data_valid <= 1'b1;
				um2cdp_data <= cdp2um_data_q;
				if(cdp2um_data_q[138:136]==3'b110)				//packet end coming;
					um2cdp_state <= pass_through_idle;
				else
					um2cdp_state <= pass_through_payload;
			end
		default:
			begin
				cdp2um_data_rdreq <= 1'b0;
				um2cdp_data_valid <= 1'b0;
				um2cdp_data <= 139'b0;
				um2cdp_state <= pass_through_idle;
			end
		endcase
		
//localbus write and read;
always@(posedge clk or negedge reset)
	if(!reset)	
		begin
			UM_ID0 <= 32'h554D;								//554D=ASCII code "UM";
			UM_ID1 <= 32'h0609;								
			UM_ID2 <= 32'h0528;								//UM date;
			UM_ID3 <= 32'h0526;								//UM version;
			UM_ID4 <= 32'h0;							
			UM_ID5 <= 32'h0;							
			UM_ID6 <= 32'h0;							
			UM_ID7 <= 32'h0;						
			UM_RAM0 <= 32'h00000001;						//default external port2 in;	
			UM_RAM1 <= 32'h00000004;						//default external port3 out;
			UM_RAM2 <= 32'h00000002;						//default external port3 in;
			UM_RAM3 <= 32'h00000002;						//default external port2 out;
			UM_RAM4 <= 32'h0;
			UM_RAM5 <= 32'h0;
			UM_RAM6 <= 32'h0;
			UM_RAM7 <= 32'h0;
			UM2DDR_WDATA0 <= 32'h0;
			UM2DDR_WDATA1 <= 32'h0;
			UM2DDR_WDATA2 <= 32'h0;
			UM2DDR_WDATA3 <= 32'h0;
			UM2DDR_COMMAND0 <= 32'h0;//{UM2DDR_COMMAND1[0],UM2DDR_COMMAND0[31:26]}= number of continous addresses; UM2DDR_COMMAND0[25:0]= start address;
			UM2DDR_COMMAND1 <= 32'h0;//UM2DDR_COMMAND1[2]=1, start ddr2 access; UM2DDR_COMMAND1[1]=1, read ddr2, UM2DDR_COMMAND1[1]=0, write ddr2; 
			localbus_addr <= 28'b0;
			localbus_ack_n <= 1'b1;
			localbus_data_in <=32'b0;
			localbus_data_out <= 32'b0;
			localbus_state <= localbus_idle;
		end
	else case(localbus_state)
		localbus_idle:
			if(localbus_ale == 1'b1 && localbus_data[31:28] == 4'b0001) //UM registers;
				begin
					localbus_addr <= localbus_data[27:0];						//only localbus_addr[7:0] are used while access UM ID registers;
					localbus_state <= localbus_address;
				end
		localbus_address:
			if(localbus_cs_n == 1'b0 && localbus_rd_wr == 1'b0)			//latch write dada;
				begin
					localbus_data_in <= localbus_data;
					localbus_state <= localbus_write;
				end
			else if(localbus_cs_n == 1'b0 && localbus_rd_wr == 1'b1)		//begin to read dada;
				begin
					localbus_state <= localbus_read;
				end
		localbus_write:
			if(localbus_addr[27:26] == 2'b00)									//UM ID registers;
				begin
					case(localbus_addr[7:0])
						8'h04:															//UM ID0-ID3 are read only;
							UM_ID4 <= localbus_data_in;
						8'h05:
							UM_ID5 <= localbus_data_in;
						8'h06:
							UM_ID6 <= localbus_data_in;
						8'h07:
							UM_ID7 <= localbus_data_in;
						//user can add more ID or mode registers here;
						default:
							begin
							end
					endcase
					localbus_ack_n <= 1'b0;
					localbus_state <= localbus_ack;
				end
			else if(localbus_addr[27:26] == 2'b01)								//UM RAM registers;
				begin
					case(localbus_addr[7:0])
						8'h00:
							UM_RAM0 <= localbus_data_in;
						8'h01:
							UM_RAM1 <= localbus_data_in;
						8'h02:
							UM_RAM2 <= localbus_data_in;
						8'h03:
							UM_RAM3 <= localbus_data_in;
						8'h04:
							UM_RAM4 <= localbus_data_in;
						8'h05:
							UM_RAM5 <= localbus_data_in;
						8'h06:
							UM_RAM6 <= localbus_data_in;
						8'h07:
							UM_RAM7 <= localbus_data_in;
						//user can add more UM RAM registers here;
						default:
							begin
							end
					endcase
					localbus_ack_n <= 1'b0;
					localbus_state <= localbus_ack;
				end
			else if(localbus_addr[27:26] == 2'b10)								//UM DDR2 indirect registers;
				begin
					case(localbus_addr[7:0])
						8'h00:
							UM2DDR_WDATA0 <= localbus_data_in;					//4 words from local_bus_data = 1 UM2DDR_WDATA;
						8'h01:
							UM2DDR_WDATA1 <= localbus_data_in;
						8'h02:
							UM2DDR_WDATA2 <= localbus_data_in;
						8'h03:
							UM2DDR_WDATA3 <= localbus_data_in;
						8'h04:
							UM2DDR_COMMAND0 <= localbus_data_in;
						8'h05:
							UM2DDR_COMMAND1 <= localbus_data_in;
						//user can add more UM2DDR indirect registers here;
						default:
							begin
							end
					endcase
					localbus_ack_n <= 1'b0;
					localbus_state <= localbus_ack;
				end
			else
				begin
					localbus_ack_n <= 1'b0;
					localbus_state <= localbus_ack;
				end
		localbus_read:
			if(localbus_addr[27:26] == 2'b00)									//UM ID registers;
				begin
					case(localbus_addr[7:0])
						8'h00:															//UM ID0-ID3 are read only;
							localbus_data_out <= UM_ID0;
						8'h01:
							localbus_data_out <= UM_ID1;
						8'h02:
							localbus_data_out <= UM_ID2;
						8'h03:
							localbus_data_out <= UM_ID3;
						8'h04:
							localbus_data_out <= UM_ID4;
						8'h05:
							localbus_data_out <= UM_ID5;
						8'h06:
							localbus_data_out <= UM_ID6;
						8'h07:
							localbus_data_out <= UM_ID7;
						//user can add more ID or mode registers here;
						default:
							localbus_data_out <= 32'b0;
					endcase
					localbus_ack_n <= 1'b0;
					localbus_state <= localbus_ack;
				end
			else if(localbus_addr[27:26] == 2'b01)								//UM RAM registers;
				begin
					case(localbus_addr[7:0])
						8'h00:
							localbus_data_out <= UM_RAM0;
						8'h01:
							localbus_data_out <= UM_RAM1;
						8'h02:
							localbus_data_out <= UM_RAM2;
						8'h03:
							localbus_data_out <= UM_RAM3;
						8'h04:
							localbus_data_out <= UM_RAM4;
						8'h05:
							localbus_data_out <= UM_RAM5;
						8'h06:
							localbus_data_out <= UM_RAM6;
						8'h07:
							localbus_data_out <= UM_RAM7;
						//user can add more UM RAM registers here;
						default:
							localbus_data_out <= 32'b0;
					endcase
					localbus_ack_n <= 1'b0;
					localbus_state <= localbus_ack;
				end
			else if(localbus_addr[27:26] == 2'b10)								//UM DDR2 indirect registers;
				begin
					case(localbus_addr[7:0])
						8'h00:
							localbus_data_out <= UM2DDR_WDATA0;					//data written into DDR2 can be read out if you want;
						8'h01:
							localbus_data_out <= UM2DDR_WDATA1;
						8'h02:
							localbus_data_out <= UM2DDR_WDATA2;
						8'h03:
							localbus_data_out <= UM2DDR_WDATA3;
						8'h04:
							localbus_data_out <= UM2DDR_COMMAND0;				
						8'h05:
							localbus_data_out <= UM2DDR_COMMAND1;				
						8'h06:
							localbus_data_out <= UM2DDR_RDATA0;					//read data from ddr2;
						8'h07:
							localbus_data_out <= UM2DDR_RDATA1;
						8'h08:
							localbus_data_out <= UM2DDR_RDATA2;
						8'h09:
							localbus_data_out <= UM2DDR_RDATA3;
						//user can add more UM DDR2 indirect registers here;
						default:
							localbus_data_out <= 32'b0;
					endcase
					localbus_ack_n <= 1'b0;
					localbus_state <= localbus_ack;
				end
			else
				begin
					localbus_data_out <= 32'b0;
					localbus_ack_n <= 1'b0;
					localbus_state <= localbus_ack;
				end
		localbus_ack:
			begin
				if(localbus_cs_n == 1'b1)
					begin
						localbus_ack_n <= 1'b1;
						localbus_state <= localbus_idle;
					end
				if(um2ddr_state == um2ddr_order)
					UM2DDR_COMMAND1 <= 32'h0;			//clear the start bit of UM2DDR_COMMAND1[2] right after um2ddr state works;
			end
		default:
			begin
				localbus_ack_n <= 1'b1;
				localbus_state <= localbus_idle;
			end
		endcase
			
assign	um2ddr_wrclk = clk;
assign	um2ddr_rdclk = clk;

//UM2DDR  interface:
//DDR2 interface is accessable via localbus in this module. In UM specification, UM supports mutiple words ddr2 write and read,
//since the reason of simplification, we only support one word ddr2 write or read here. If users need continous access as 
//long as 127 words, you can receive command and data via ethernet packets from any external port.
//UM2DDR_COMMAND1[2] is used to start and stop the ddr2 operation. 1-start, 0-stop. it is written by localbus and cleared right after
//the state of um2ddr_order. This bit is not defined in UM spec. because you can define another signal or method to start and stop
//the ddr2 operation. 
always@(posedge clk or negedge reset)
	if(!reset)	
		begin
			um2ddr_command_wrreq <= 1'b0;
			um2ddr_command <= 34'b0;
			um2ddr_wrreq <= 1'b0;
			um2ddr_wdata <= 128'b0;
			um2ddr_valid_rdreq <= 1'b0;
			um2ddr_rdreq <= 1'b0;
			UM2DDR_RDATA0 <= 32'b0;
			UM2DDR_RDATA1 <= 32'b0;
			UM2DDR_RDATA2 <= 32'b0;
			UM2DDR_RDATA3 <= 32'b0;
			um2ddr_state <= um2ddr_idle;
		end
	else case(um2ddr_state)
		um2ddr_idle:
			if(ddr2um_ready == 1'b1 && UM2DDR_COMMAND1[2] == 1'b1)		//ddr2 is ready and start command is sent by localbus;
				begin
					um2ddr_command_wrreq <= 1'b1;									//write command;
					um2ddr_command <= {UM2DDR_COMMAND1[1:0],UM2DDR_COMMAND0[31:0]};
					um2ddr_state <= um2ddr_order;
				end
		um2ddr_order:
			begin
				um2ddr_command_wrreq <= 1'b0;
				if(um2ddr_command[33]==1'b0)					//write operation;
					begin
						um2ddr_wrreq <= 1'b1;					//write ddr2;
						um2ddr_wdata <= {UM2DDR_WDATA3,UM2DDR_WDATA2,UM2DDR_WDATA1,UM2DDR_WDATA0};//4 UM2DDR_WDATA = 1 um2ddr_wdata;
						um2ddr_state <= um2ddr_write;
					end
				else 													//read ddr2 registers;
						um2ddr_state <= um2ddr_valid_wait;	//read operation, go to wait valid fifo(information fifo);
			end
		um2ddr_write:
			begin
				um2ddr_wrreq <= 1'b0;
				um2ddr_state <= um2ddr_idle;
			end
		um2ddr_valid_wait:
			if(ddr2um_valid_empty == 1'b0)					//valid fifo is ready;
				begin
					um2ddr_valid_rdreq <= 1'b1;				//read valid fifo to decide the number of words from ddr2;
					um2ddr_state <= um2ddr_valid_read;
				end
		um2ddr_valid_read:
			begin
				um2ddr_valid_rdreq <= 1'b0;					
				um2ddr_rdreq <= 1'b1; 							
				um2ddr_state <= um2ddr_data_read;
			end
		um2ddr_data_read:
			begin
				um2ddr_rdreq <= 1'b0; 							//only 1 word are read in this example since the reason of test;
				UM2DDR_RDATA0 <= ddr2um_rdata[31:0];		//4 UM2DDR_RDATA = 1 um2ddr_rdata;
				UM2DDR_RDATA1 <= ddr2um_rdata[63:32];
				UM2DDR_RDATA2 <= ddr2um_rdata[95:64];
				UM2DDR_RDATA3 <= ddr2um_rdata[127:96];
				um2ddr_state <= um2ddr_idle;
			end
		default: begin end
		endcase
			
endmodule
