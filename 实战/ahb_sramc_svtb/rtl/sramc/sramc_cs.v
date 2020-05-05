
module sramc_cs (
   // AHB Bus Signal
   hclk,   
   hreset_n,
   hsel_reg,
   hwrite_reg,  
   hsize_reg,   
   haddr_reg,   
   hwdata,  
   hrdata,  
   htrans,
		   
   // SRAM signal
   sram_clk,    //SRAM_CLK
   sram_cb_n,   //SRAM_BANK_SELECTION
   sram_cs_n,   //SRAM_CHIP_SELECTION
   sram_write_n,//SRAM_WEN
   sram_addr,   //SRAM_A
   sram_wdata,  //SRAM_D
   sram_rdata   //SRAM_Q
   );
   
// -- define AHB Bus Width and SRAM address width --
parameter  AHB_ADDR_WIDTH   = 32  ;
parameter  AHB_DATA_WIDTH   = 32  ;
parameter  SRAM_ADDR_WIDTH  = 12  ;
parameter  SRAM_DATA_WIDTH  = 32  ;

//-- define the SRAM bank sequence --		
parameter  SRAM_BANK0	= 2'b00 ;	
parameter  SRAM_BANK1	= 2'b01 ;
parameter  SRAM_BANK2	= 2'b10 ;	
parameter  SRAM_BANK3	= 2'b11 ;
	   
//-- define switch constants --
parameter  ON   = 1'b1 ;
parameter  OFF  = 1'b0;

//-- define the port direction --
input                          hclk         ;
input	                         hreset_n     ;
input	                         hsel_reg     ;
input			                     hwrite_reg   ;
input   [2:0]	                 hsize_reg    ;
input   [AHB_ADDR_WIDTH-1:0]   haddr_reg    ;
input   [AHB_DATA_WIDTH-1:0]   hwdata       ;
input   [1:0]				           htrans       ;
output  [AHB_DATA_WIDTH-1:0]   hrdata       ;
output			                   sram_clk     ;
output  [3:0]                  sram_cb_n	;
output	[3:0]	                 sram_cs_n    ;
output	[SRAM_ADDR_WIDTH-1:0]  sram_addr    ;
output			                   sram_write_n ;
output	[SRAM_DATA_WIDTH-1:0]  sram_wdata   ;
input	[SRAM_DATA_WIDTH-1:0]    sram_rdata   ;

// -- define the port type --
reg     [3:0]                  sram_we_n    ;    //SRAM bit width enable signal 
reg     [3:0]                  sram_cb_n    ;    //SRAM chip selection signal
reg     [3:0]                  sram_cs_n	;
reg     [SRAM_DATA_WIDTH-1:0]  sram_wdata   ;
reg     [AHB_DATA_WIDTH-1:0]   hrdata       ;

//-- SRAM bank selection logic : combinational logic --
always @ ( * )
    if (( !hsel_reg )|| (!hreset_n ))
        sram_cb_n [3:0]	=  4'b1111;
    else
        begin
        case ( haddr_reg[15:14] )
            SRAM_BANK0: sram_cb_n[3:0]	= #1 4'b 1110;
            SRAM_BANK1: sram_cb_n[3:0]	= #1 4'b 1101;	    
            SRAM_BANK2: sram_cb_n[3:0]	= #1 4'b 1011;
            SRAM_BANK3:	sram_cb_n[3:0]	= #1 4'b 0111;
        endcase	
        end

//-- data width selection logic : combitional logic--
//-- litten endian data bus --

always @ ( * )
begin
    if ( !hsel_reg || !hreset_n )
        sram_we_n[3:0]	= #1 4'b1111;
    else  
      if ( hsize_reg[1:0] == 2'b10 )
        sram_we_n[3:0]	= #1 4'b0000;	    
      else
      if ( hsize_reg[1:0] == 2'b01 )
        begin
	    if ( haddr_reg[1] == 1'b0 )
	       sram_we_n[3:0]	= #1 4'b1100;	
	    else 
	       sram_we_n[3:0]	= #1 4'b0011;	     
        end
      else
      if ( hsize_reg[1:0] == 2'b00 )
        begin
	     case ( haddr_reg[1:0] )
	        2'b00 : sram_we_n[3:0]	 = #1  4'b1110;
	        2'b01 : sram_we_n[3:0]	 = #1  4'b1101;
	        2'b10 : sram_we_n[3:0]	 = #1  4'b1011;
	        2'b11 : sram_we_n[3:0]	 = #1  4'b0111;
	     endcase
        end
      else
	      sram_we_n[3:0]	= #1 4'b1111;   
  end

//-- sram chip selection logic --
  
always @ (*)
begin
	case (sram_cb_n)
		4'b1110:
			case (sram_we_n)
				4'b0000:	sram_cs_n = 4'b0000;
				4'b1100:	sram_cs_n = 4'b1100;
				4'b0011:	sram_cs_n = 4'b0011;    
				4'b1110:	sram_cs_n = 4'b1110;
				4'b1101:	sram_cs_n = 4'b1101;
				4'b1011:	sram_cs_n = 4'b1011;
				4'b0111:	sram_cs_n = 4'b0111;
				default:	sram_cs_n = 4'b1111;
			endcase
				
		4'b1101:
			case (sram_we_n)
				4'b0000:	sram_cs_n = 4'b0000;
				4'b1100:	sram_cs_n = 4'b1100;
				4'b0011:	sram_cs_n = 4'b0011;    
				4'b1110:	sram_cs_n = 4'b1110;
				4'b1101:	sram_cs_n = 4'b1101;
				4'b1011:	sram_cs_n = 4'b1011;
				4'b0111:	sram_cs_n = 4'b0111;
				default:	sram_cs_n = 4'b1111;
			endcase
		
		4'b1011:
    		case (sram_we_n)
		  	4'b0000:	sram_cs_n = 4'b0000;
				4'b1100:	sram_cs_n = 4'b1100;
				4'b0011:	sram_cs_n = 4'b0011;    
				4'b1110:	sram_cs_n = 4'b1110;
				4'b1101:	sram_cs_n = 4'b1101;
				4'b1011:	sram_cs_n = 4'b1011;
				4'b0111:	sram_cs_n = 4'b0111;
				default:	sram_cs_n = 4'b1111;
			endcase
	
		4'b0111:
        begin
			case (sram_we_n)
		    4'b0000:	sram_cs_n = 4'b0000;
				4'b1100:	sram_cs_n = 4'b1100;
				4'b0011:	sram_cs_n = 4'b0011;    
				4'b1110:	sram_cs_n = 4'b1110;
				4'b1101:	sram_cs_n = 4'b1101;
				4'b1011:	sram_cs_n = 4'b1011;
				4'b0111:	sram_cs_n = 4'b0111;
				default:	sram_cs_n = 4'b1111;
			endcase
		end
		default: sram_cs_n = 4'b1111;
	endcase
end

//-- connect the clock to SRAM --
assign   sram_clk = ~hclk;
  
//-- change the haddr to SRAM addr : combinational logic--
assign #1 sram_addr[11:0]  =   haddr_reg[13:2];

//-- connect the write or read signal to SRAM --
assign #1 sram_write_n =  ~hwrite_reg; 
 
//-- data bus connection --
always @ ( * )
    if (( !hsel_reg) || (!hreset_n ))
        begin
             sram_wdata =  32'h0000;
        end
    else
        case ( sram_we_n )
            4'b0000: sram_wdata		 	    =   hwdata;
            4'b1100: sram_wdata[15:0]	  =   hwdata[15:0];   
            4'b0011: sram_wdata[31:16]  =   hwdata[31:16];    
            4'b1110: sram_wdata[7:0]    =   hwdata[7:0];        
            4'b1101: sram_wdata[15:8]   =   hwdata[15:8];
            4'b1011: sram_wdata[23:16]  =   hwdata[23:16];
            4'b0111: sram_wdata[31:24]  =   hwdata[31:24];
            default: sram_wdata         =   32'h0;
        endcase

always @ (*)
        case (sram_we_n )
            4'b0000: hrdata			     =  sram_rdata;
            4'b1100: hrdata[15:0]	   =  sram_rdata[15:0];
            4'b0011: hrdata[31:16]   =  sram_rdata[31:16];
            4'b1110: hrdata[7:0]     =  sram_rdata[7:0];
            4'b1101: hrdata[15:8]    =  sram_rdata[15:8];
   	        4'b1011: hrdata[23:16]   =  sram_rdata[23:16];
            4'b0111: hrdata[31:24]   =  sram_rdata[31:24];
            default: hrdata          =  32'h0;
        endcase 
		    
endmodule
