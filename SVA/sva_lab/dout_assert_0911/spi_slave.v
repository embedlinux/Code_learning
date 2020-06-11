//************************************************************************************************
// File Name : spi_slave.v
// Project   : ISA8201
// Author    : zhangxiaoliang
// Date      : 2015-08-19
// Description : 
//      This module is spi slave.
//
// Revision History:
//       Ver1.0   2015-08-19  Initial Version for ISA8201
//                2015-9-8 change default value
//************************************************************************************************







//                   1024'h00_00_00_00_00_00_79_78_77_76_75_74_73_72_71_70_6f_6e_6d_6c_6b_6a_69_68_67_66_65_64_63_62_61_60_5f_5e_5d_5c_5b_5a_59_58_57_56_55_54_53_52_51_50_4f_4e_4d_4c_4b_4a_49_48_47_46_45_44_43_42_41_40_3f_3e_3d_3c_3b_3a_39_38_37_36_35_34_33_32_31_30_2f_2e_2d_2c_2b_2a_29_28_27_26_25_24_23_22_21_20_1F_1E_1D_1C_1B_1A_19_18_17_16_15_14_13_12_11_10_0F_0E_0D_0C_0B_0A_09_08_07_06_05_04_03_02_01_00_
`define mem_default  1024'h00_00_aa_66_00_ff_0f_08_00_08_00_08_00_08_00_07_00_08_00_08_00_08_00_08_00_08_00_08_00_08_00_18_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_08_00_00_00_00_00_00_13_08_00_00_00_0A_00_00_01_81_8F_00_00_80_40_00_08_83_03_00_00_18_01_40_22_3F_64_00_ff_ff_13_00_00_00_00_00_00_00_00_C0_00_00_00_80_E1_00_00_00_00_00_00

`define mem_array {mem[127],mem[126],mem[125],mem[124],mem[123],mem[122],mem[121],mem[120],mem[119],mem[118],mem[117],mem[116],mem[115],mem[114],mem[113],mem[112],mem[111],mem[110],mem[109],mem[108],mem[107],mem[106],mem[105],mem[104],mem[103],mem[102],mem[101],mem[100],mem[99],mem[98],mem[97],mem[96],mem[95],mem[94],mem[93],mem[92],mem[91],mem[90],mem[89],mem[88],mem[87],mem[86],mem[85],mem[84],mem[83],mem[82],mem[81],mem[80],mem[79],mem[78],mem[77],mem[76],mem[75],mem[74],mem[73],mem[72],mem[71],mem[70],mem[69],mem[68],mem[67],mem[66],mem[65],mem[64],mem[63],mem[62],mem[61],mem[60],mem[59],mem[58],mem[57],mem[56],mem[55],mem[54],mem[53],mem[52],mem[51],mem[50],mem[49],mem[48],mem[47],mem[46],mem[45],mem[44],mem[43],mem[42],mem[41],mem[40],mem[39],mem[38],mem[37],mem[36],mem[35],mem[34],mem[33],mem[32],mem[31],mem[30],mem[29],mem[28],mem[27],mem[26],mem[25],mem[24],mem[23],mem[22],mem[21],mem[20],mem[19],mem[18],mem[17],mem[16],mem[15],mem[14],mem[13],mem[12],mem[11],mem[10],mem[9],mem[8],mem[7],mem[6],mem[5],mem[4],mem[3],mem[2],mem[1],mem[0]}

`define rd_array {rd[127],rd[126],rd[125],rd[124],rd[123],rd[122],rd[121],rd[120],rd[119],rd[118],rd[117],rd[116],rd[115],rd[114],rd[113],rd[112],rd[111],rd[110],rd[109],rd[108],rd[107],rd[106],rd[105],rd[104],rd[103],rd[102],rd[101],rd[100],rd[99],rd[98],rd[97],rd[96],rd[95],rd[94],rd[93],rd[92],rd[91],rd[90],rd[89],rd[88],rd[87],rd[86],rd[85],rd[84],rd[83],rd[82],rd[81],rd[80],rd[79],rd[78],rd[77],rd[76],rd[75],rd[74],rd[73],rd[72],rd[71],rd[70],rd[69],rd[68],rd[67],rd[66],rd[65],rd[64],rd[63],rd[62],rd[61],rd[60],rd[59],rd[58],rd[57],rd[56],rd[55],rd[54],rd[53],rd[52],rd[51],rd[50],rd[49],rd[48],rd[47],rd[46],rd[45],rd[44],rd[43],rd[42],rd[41],rd[40],rd[39],rd[38],rd[37],rd[36],rd[35],rd[34],rd[33],rd[32],rd[31],rd[30],rd[29],rd[28],rd[27],rd[26],rd[25],rd[24],rd[23],rd[22],rd[21],rd[20],rd[19],rd[18],rd[17],rd[16],rd[15],rd[14],rd[13],rd[12],rd[11],rd[10],rd[9],rd[8],rd[7],rd[6],rd[5],rd[4],rd[3],rd[2],rd[1],rd[0]}



module spi_slave(
input  rst,
output [1023:0]POUT,
input  spi_clk,
input  spi_en,
input  spi_in,
output spi_out,
input  CPOL,
input  CPHA
);
reg       w;
reg [3:0] cnt;
reg [7:0] datar;
reg [7:0] dataw;
reg [6:0] addr;
reg [6:0] addrr;
reg       spiout;
reg [7:0] mem[127:0];

wire[7:0] rd[127:0];	
wire    clk;

assign spi_out=spiout;
assign `rd_array = `mem_array;
assign POUT = `mem_array;



assign clk = (CPOL^CPHA)?~spi_clk:spi_clk;
 
always @(posedge clk or negedge rst)
  if (!rst) 
    begin
        cnt  <= 4'b0000; 
        w  <= 1'b0;
    end 
  else if(spi_en)
		begin
		       cnt <= cnt+1'b1;
	    	if(cnt==4'b0)
		       w <= spi_in; 
		    else      
		       w <= w; 
    end
  else
    begin
        cnt  <= 4'b0000;      
        w  <= 1'b0;
    end



always @(negedge clk or negedge rst)
begin
    if (!rst)
      begin 
        `mem_array <= `mem_default;
      end
    else if(w&(cnt==4'd0)&(addr!=7'h01)&(addr!=7'h02)&(addr!=7'h03)&(addr!=7'h00)&(addr!=7'h04))
		   mem[addr]<= dataw;               
end

             

always @(negedge clk or negedge rst)
    if (!rst)
      begin 
        	 spiout<=1'b0;
			 datar<=8'b00000000; 
      end 
	 else	if ((!w)&(cnt==4'd8))
	 begin
		     datar	<=rd[addr];		
           spiout <= rd[addr][7];			  
	 end
	 else if((!w)&(cnt>4'd8))
       begin                           
          spiout <= datar[6];          
          datar[6:1]<=datar[5:0];       
       end 
    else
  		    datar<=8'b00000000;	 



always @(posedge clk or negedge rst)
  if (!rst) 
		begin
			  addr <=7'b000000;
		    dataw<=8'b00000000;
		end			
  else if(spi_en)
    begin 
          if((w)&(cnt!=4'b0))	                            
            begin		                            
               if (cnt<=4'd7)                    
                  begin                          
                      addr[0]<=spi_in;           
                      addr[6:1]<=addr[5:0];	
                     				 
                  end                            
               else                              
                  begin                          
                      dataw[0]<=spi_in;          
                      dataw[7:1]<=dataw[6:0];     
                  end                            
   	        end                                   
          else if((!w)&(cnt!=4'b0))                                    
            begin		                            
               if (cnt<=4'd7)                     
                  begin                           
            		     addr[0]<=spi_in;             
                     addr[6:1]<=addr[5:0];								
                  end				                      					
            end                                  
    end
  else  
  		begin
			  addr <=7'b0000000;
		    dataw<=8'b00000000;
	  	end			
    
	 
	 

    	 
	 
	 
	 
endmodule

