//************************************************************************************************
// File Name : reg_sync.v
// Project   : ISA8201
// Author    : zhangxiaoliang
// Date      : 2015-08-19
// Description : 
//      This module is spi reg sync.
//
// Revision History:
//       Ver1.0   2015-08-19  Initial Version for ISA8201
//       v 2.0    2015-8-21   change reg map
//         2.1    2015-9-8    CHANGE REG[5]         
//************************************************************************************************



module reg_sync(          
input         rst     ,
input [1023:0] DOUT    ,
input         clk     ,
input         sys_idle, 
input         fval    ,


output[7:0] SPI_REG_00,
output[7:0] SPI_REG_01,
output[7:0] SPI_REG_02,
output[7:0] SPI_REG_03,
output[7:0] SPI_REG_04,
output[7:0] SPI_REG_05,
output[7:0] SPI_REG_06,
output[7:0] SPI_REG_07,
output[7:0] SPI_REG_08,
output[7:0] SPI_REG_09,
output[7:0] SPI_REG_0A,
output[7:0] SPI_REG_0B,
output[7:0] SPI_REG_0C,
output[7:0] SPI_REG_0D,
output[7:0] SPI_REG_0E,
output[7:0] SPI_REG_0F,
output[7:0] SPI_REG_10,
output[7:0] SPI_REG_11,
output[7:0] SPI_REG_12,
output[7:0] SPI_REG_13,
output[7:0] SPI_REG_14,
output[7:0] SPI_REG_15,
output[7:0] SPI_REG_16,
output[7:0] SPI_REG_17,
output[7:0] SPI_REG_18,
output[7:0] SPI_REG_19,
output[7:0] SPI_REG_1A,
output[7:0] SPI_REG_1B,
output[7:0] SPI_REG_1C,
output[7:0] SPI_REG_1D,
output[7:0] SPI_REG_1E,
output[7:0] SPI_REG_1F,
output[7:0] SPI_REG_20,
output[7:0] SPI_REG_21,
output[7:0] SPI_REG_22,
output[7:0] SPI_REG_23,
output[7:0] SPI_REG_24,
output[7:0] SPI_REG_25,
output[7:0] SPI_REG_26,
output[7:0] SPI_REG_27,
output[7:0] SPI_REG_28,
output[7:0] SPI_REG_29,
output[7:0] SPI_REG_2A,
output[7:0] SPI_REG_2B,
output[7:0] SPI_REG_2C,
output[7:0] SPI_REG_2D,
output[7:0] SPI_REG_2E,
output[7:0] SPI_REG_2F,
output[7:0] SPI_REG_30,
output[7:0] SPI_REG_31,
output[7:0] SPI_REG_32,
output[7:0] SPI_REG_33,
output[7:0] SPI_REG_34,
output[7:0] SPI_REG_35,
output[7:0] SPI_REG_36,
output[7:0] SPI_REG_37,
output[7:0] SPI_REG_38,
output[7:0] SPI_REG_39,
output[7:0] SPI_REG_3A,
output[7:0] SPI_REG_3B,
output[7:0] SPI_REG_3C,
output[7:0] SPI_REG_3D,
output[7:0] SPI_REG_3E,
output[7:0] SPI_REG_3F,
output[7:0] SPI_REG_40,
output[7:0] SPI_REG_41,
output[7:0] SPI_REG_42,
output[7:0] SPI_REG_43,
output[7:0] SPI_REG_44,
output[7:0] SPI_REG_45,
output[7:0] SPI_REG_46,
output[7:0] SPI_REG_47,
output[7:0] SPI_REG_48,
output[7:0] SPI_REG_49,
output[7:0] SPI_REG_4A,
output[7:0] SPI_REG_4B,
output[7:0] SPI_REG_4C,
output[7:0] SPI_REG_4D,
output[7:0] SPI_REG_4E,
output[7:0] SPI_REG_4F,
output[7:0] SPI_REG_50,
output[7:0] SPI_REG_51,
output[7:0] SPI_REG_52,
output[7:0] SPI_REG_53,
output[7:0] SPI_REG_54,
output[7:0] SPI_REG_55,
output[7:0] SPI_REG_56,
output[7:0] SPI_REG_57,
output[7:0] SPI_REG_58,
output[7:0] SPI_REG_59,
output[7:0] SPI_REG_5A,
output[7:0] SPI_REG_5B,
output[7:0] SPI_REG_5C,
output[7:0] SPI_REG_5D,
output[7:0] SPI_REG_5E,
output[7:0] SPI_REG_5F,
output[7:0] SPI_REG_60,
output[7:0] SPI_REG_61,
output[7:0] SPI_REG_62,
output[7:0] SPI_REG_63,
output[7:0] SPI_REG_64,
output[7:0] SPI_REG_65,
output[7:0] SPI_REG_66,
output[7:0] SPI_REG_67,
output[7:0] SPI_REG_68,
output[7:0] SPI_REG_69,
output[7:0] SPI_REG_6A,
output[7:0] SPI_REG_6B,
output[7:0] SPI_REG_6C,
output[7:0] SPI_REG_6D,
output[7:0] SPI_REG_6E,
output[7:0] SPI_REG_6F,
output[7:0] SPI_REG_70,
output[7:0] SPI_REG_71,
output[7:0] SPI_REG_72,
output[7:0] SPI_REG_73,
output[7:0] SPI_REG_74,
output[7:0] SPI_REG_75,
output[7:0] SPI_REG_76,
output[7:0] SPI_REG_77,
output[7:0] SPI_REG_78,
output[7:0] SPI_REG_79,
output[7:0] SPI_REG_7A,
output[7:0] SPI_REG_7B,
output[7:0] SPI_REG_7C,
output[7:0] SPI_REG_7D,
output[7:0] SPI_REG_7E,
output[7:0] SPI_REG_7F

);
        
        
        
        


reg  [1023:0] DOUT_1;
reg  [1023:0] DOUT_2;
reg  [1023:0] DOUT_3;
wire [1023:0] DOUT_hold;
reg           sys_idle_1        ;
reg           fval_1      ;
reg           stop;
reg           sync;

		
		
		
		
		
		



always @(posedge clk or negedge rst)
  if (!rst) 
    begin
        DOUT_1  <= DOUT;
        DOUT_3  <= DOUT;
    end 
  else if(stop)
    begin
     if(sync)
        begin
        DOUT_1  <= DOUT;  
        DOUT_3  <= DOUT;
        end
     else
     		begin     		
        DOUT_1  <= DOUT_hold; 
        end
   end
  else
       begin
         DOUT_3  <= DOUT;
        DOUT_1  <= DOUT; 
        end


always @(posedge clk or negedge rst)
  if (!rst) 
    begin
        DOUT_2  <= DOUT; 
    end 
  else
    begin
        DOUT_2  <= DOUT_1; 
    end

always @ (posedge clk or negedge rst)   //por
begin
	if (!rst)
	begin
		 sys_idle_1 <=   1'b0;	
		 fval_1     <=   1'b0;
	end
	else 
	begin		
	   sys_idle_1 <=   sys_idle;
	   fval_1     <=   fval;
  end
end 

always @ (posedge clk or negedge rst)   //por
begin
	if (!rst)
	begin
		  stop <=   1'b0;	
	end
	else if(sys_idle)
		  stop <=   1'b0;
	else if(sys_idle_1&(!sys_idle))
	  	stop <=   1'b1;	
end 


always @ (posedge clk or negedge rst)   //por
begin
	if (!rst)
	begin
		  sync <=   1'b0;	
	end
	else if(stop)
      begin
         if(fval_1&(!fval))
              sync <=   1'b1;	
         else
      	      sync <=   1'b0;	
      end      
end 

wire [7:0] SPI_REG_00_O; 
wire [7:0] SPI_REG_01_O; 
wire [7:0] SPI_REG_02_O; 
wire [7:0] SPI_REG_03_O; 
wire [7:0] SPI_REG_04_O; 
wire [7:0] SPI_REG_05_O; 
wire [7:0] SPI_REG_06_O; 
wire [7:0] SPI_REG_07_O; 
wire [7:0] SPI_REG_08_O; 
wire [7:0] SPI_REG_09_O; 
wire [7:0] SPI_REG_0A_O; 
wire [7:0] SPI_REG_0B_O; 
wire [7:0] SPI_REG_0C_O; 
wire [7:0] SPI_REG_0D_O; 
wire [7:0] SPI_REG_0E_O; 
wire [7:0] SPI_REG_0F_O; 
wire [7:0] SPI_REG_10_O; 
wire [7:0] SPI_REG_11_O; 
wire [7:0] SPI_REG_12_O; 
wire [7:0] SPI_REG_13_O; 
wire [7:0] SPI_REG_14_O; 
wire [7:0] SPI_REG_15_O; 
wire [7:0] SPI_REG_16_O; 
wire [7:0] SPI_REG_17_O; 
wire [7:0] SPI_REG_18_O; 
wire [7:0] SPI_REG_19_O; 
wire [7:0] SPI_REG_1A_O; 
wire [7:0] SPI_REG_1B_O; 
wire [7:0] SPI_REG_1C_O; 
wire [7:0] SPI_REG_1D_O; 
wire [7:0] SPI_REG_1E_O; 
wire [7:0] SPI_REG_1F_O; 
wire [7:0] SPI_REG_20_O; 
wire [7:0] SPI_REG_21_O; 
wire [7:0] SPI_REG_22_O; 
wire [7:0] SPI_REG_23_O; 
wire [7:0] SPI_REG_24_O; 
wire [7:0] SPI_REG_25_O; 
wire [7:0] SPI_REG_26_O; 
wire [7:0] SPI_REG_27_O; 
wire [7:0] SPI_REG_28_O; 
wire [7:0] SPI_REG_29_O; 
wire [7:0] SPI_REG_2A_O; 
wire [7:0] SPI_REG_2B_O; 
wire [7:0] SPI_REG_2C_O; 
wire [7:0] SPI_REG_2D_O; 
wire [7:0] SPI_REG_2E_O; 
wire [7:0] SPI_REG_2F_O; 
wire [7:0] SPI_REG_30_O; 
wire [7:0] SPI_REG_31_O; 
wire [7:0] SPI_REG_32_O; 
wire [7:0] SPI_REG_33_O; 
wire [7:0] SPI_REG_34_O; 
wire [7:0] SPI_REG_35_O; 
wire [7:0] SPI_REG_36_O; 
wire [7:0] SPI_REG_37_O; 
wire [7:0] SPI_REG_38_O; 
wire [7:0] SPI_REG_39_O; 
wire [7:0] SPI_REG_3A_O; 
wire [7:0] SPI_REG_3B_O; 
wire [7:0] SPI_REG_3C_O; 
wire [7:0] SPI_REG_3D_O; 
wire [7:0] SPI_REG_3E_O; 
wire [7:0] SPI_REG_3F_O; 
wire [7:0] SPI_REG_40_O; 
wire [7:0] SPI_REG_41_O; 
wire [7:0] SPI_REG_42_O; 
wire [7:0] SPI_REG_43_O; 
wire [7:0] SPI_REG_44_O; 
wire [7:0] SPI_REG_45_O; 
wire [7:0] SPI_REG_46_O; 
wire [7:0] SPI_REG_47_O; 
wire [7:0] SPI_REG_48_O; 
wire [7:0] SPI_REG_49_O; 
wire [7:0] SPI_REG_4A_O; 
wire [7:0] SPI_REG_4B_O; 
wire [7:0] SPI_REG_4C_O; 
wire [7:0] SPI_REG_4D_O; 
wire [7:0] SPI_REG_4E_O; 
wire [7:0] SPI_REG_4F_O; 
wire [7:0] SPI_REG_50_O; 
wire [7:0] SPI_REG_51_O; 
wire [7:0] SPI_REG_52_O; 
wire [7:0] SPI_REG_53_O; 
wire [7:0] SPI_REG_54_O; 
wire [7:0] SPI_REG_55_O; 
wire [7:0] SPI_REG_56_O; 
wire [7:0] SPI_REG_57_O; 
wire [7:0] SPI_REG_58_O; 
wire [7:0] SPI_REG_59_O; 
wire [7:0] SPI_REG_5A_O; 
wire [7:0] SPI_REG_5B_O; 
wire [7:0] SPI_REG_5C_O; 
wire [7:0] SPI_REG_5D_O; 
wire [7:0] SPI_REG_5E_O; 
wire [7:0] SPI_REG_5F_O; 
wire [7:0] SPI_REG_60_O; 
wire [7:0] SPI_REG_61_O; 
wire [7:0] SPI_REG_62_O; 
wire [7:0] SPI_REG_63_O; 
wire [7:0] SPI_REG_64_O; 
wire [7:0] SPI_REG_65_O; 
wire [7:0] SPI_REG_66_O; 
wire [7:0] SPI_REG_67_O; 
wire [7:0] SPI_REG_68_O; 
wire [7:0] SPI_REG_69_O; 
wire [7:0] SPI_REG_6A_O; 
wire [7:0] SPI_REG_6B_O; 
wire [7:0] SPI_REG_6C_O; 
wire [7:0] SPI_REG_6D_O; 
wire [7:0] SPI_REG_6E_O; 
wire [7:0] SPI_REG_6F_O; 
wire [7:0] SPI_REG_70_O; 
wire [7:0] SPI_REG_71_O; 
wire [7:0] SPI_REG_72_O; 
wire [7:0] SPI_REG_73_O; 
wire [7:0] SPI_REG_74_O; 
wire [7:0] SPI_REG_75_O; 
wire [7:0] SPI_REG_76_O; 
wire [7:0] SPI_REG_77_O; 
wire [7:0] SPI_REG_78_O; 
wire [7:0] SPI_REG_79_O;
wire [7:0] SPI_REG_7A_O;
wire [7:0] SPI_REG_7B_O;
wire [7:0] SPI_REG_7C_O;
wire [7:0] SPI_REG_7D_O;
wire [7:0] SPI_REG_7E_O;
wire [7:0] SPI_REG_7F_O;
                   
 
 
wire [7:0] SPI_REG_00_H; 
wire [7:0] SPI_REG_01_H; 
wire [7:0] SPI_REG_02_H; 
wire [7:0] SPI_REG_03_H; 
wire [7:0] SPI_REG_04_H; 
wire [7:0] SPI_REG_05_H; 
wire [7:0] SPI_REG_06_H; 
wire [7:0] SPI_REG_07_H; 
wire [7:0] SPI_REG_08_H; 
wire [7:0] SPI_REG_09_H; 
wire [7:0] SPI_REG_0A_H; 
wire [7:0] SPI_REG_0B_H; 
wire [7:0] SPI_REG_0C_H; 
wire [7:0] SPI_REG_0D_H; 
wire [7:0] SPI_REG_0E_H; 
wire [7:0] SPI_REG_0F_H; 
wire [7:0] SPI_REG_10_H; 
wire [7:0] SPI_REG_11_H; 
wire [7:0] SPI_REG_12_H; 
wire [7:0] SPI_REG_13_H; 
wire [7:0] SPI_REG_14_H; 
wire [7:0] SPI_REG_15_H; 
wire [7:0] SPI_REG_16_H; 
wire [7:0] SPI_REG_17_H; 
wire [7:0] SPI_REG_18_H; 
wire [7:0] SPI_REG_19_H; 
wire [7:0] SPI_REG_1A_H; 
wire [7:0] SPI_REG_1B_H; 
wire [7:0] SPI_REG_1C_H; 
wire [7:0] SPI_REG_1D_H; 
wire [7:0] SPI_REG_1E_H; 
wire [7:0] SPI_REG_1F_H; 
wire [7:0] SPI_REG_20_H; 
wire [7:0] SPI_REG_21_H; 
wire [7:0] SPI_REG_22_H; 
wire [7:0] SPI_REG_23_H; 
wire [7:0] SPI_REG_24_H; 
wire [7:0] SPI_REG_25_H; 
wire [7:0] SPI_REG_26_H; 
wire [7:0] SPI_REG_27_H; 
wire [7:0] SPI_REG_28_H; 
wire [7:0] SPI_REG_29_H; 
wire [7:0] SPI_REG_2A_H; 
wire [7:0] SPI_REG_2B_H; 
wire [7:0] SPI_REG_2C_H; 
wire [7:0] SPI_REG_2D_H; 
wire [7:0] SPI_REG_2E_H; 
wire [7:0] SPI_REG_2F_H; 
wire [7:0] SPI_REG_30_H; 
wire [7:0] SPI_REG_31_H; 
wire [7:0] SPI_REG_32_H; 
wire [7:0] SPI_REG_33_H; 
wire [7:0] SPI_REG_34_H; 
wire [7:0] SPI_REG_35_H; 
wire [7:0] SPI_REG_36_H; 
wire [7:0] SPI_REG_37_H; 
wire [7:0] SPI_REG_38_H; 
wire [7:0] SPI_REG_39_H; 
wire [7:0] SPI_REG_3A_H; 
wire [7:0] SPI_REG_3B_H; 
wire [7:0] SPI_REG_3C_H; 
wire [7:0] SPI_REG_3D_H; 
wire [7:0] SPI_REG_3E_H; 
wire [7:0] SPI_REG_3F_H; 
wire [7:0] SPI_REG_40_H; 
wire [7:0] SPI_REG_41_H; 
wire [7:0] SPI_REG_42_H; 
wire [7:0] SPI_REG_43_H; 
wire [7:0] SPI_REG_44_H; 
wire [7:0] SPI_REG_45_H; 
wire [7:0] SPI_REG_46_H; 
wire [7:0] SPI_REG_47_H; 
wire [7:0] SPI_REG_48_H; 
wire [7:0] SPI_REG_49_H; 
wire [7:0] SPI_REG_4A_H; 
wire [7:0] SPI_REG_4B_H; 
wire [7:0] SPI_REG_4C_H; 
wire [7:0] SPI_REG_4D_H; 
wire [7:0] SPI_REG_4E_H; 
wire [7:0] SPI_REG_4F_H; 
wire [7:0] SPI_REG_50_H; 
wire [7:0] SPI_REG_51_H; 
wire [7:0] SPI_REG_52_H; 
wire [7:0] SPI_REG_53_H; 
wire [7:0] SPI_REG_54_H; 
wire [7:0] SPI_REG_55_H; 
wire [7:0] SPI_REG_56_H; 
wire [7:0] SPI_REG_57_H; 
wire [7:0] SPI_REG_58_H; 
wire [7:0] SPI_REG_59_H; 
wire [7:0] SPI_REG_5A_H; 
wire [7:0] SPI_REG_5B_H; 
wire [7:0] SPI_REG_5C_H; 
wire [7:0] SPI_REG_5D_H; 
wire [7:0] SPI_REG_5E_H; 
wire [7:0] SPI_REG_5F_H; 
wire [7:0] SPI_REG_60_H;
wire [7:0] SPI_REG_61_H;
wire [7:0] SPI_REG_62_H;
wire [7:0] SPI_REG_63_H;
wire [7:0] SPI_REG_64_H;
wire [7:0] SPI_REG_65_H;
wire [7:0] SPI_REG_66_H;
wire [7:0] SPI_REG_67_H;
wire [7:0] SPI_REG_68_H;
wire [7:0] SPI_REG_69_H;
wire [7:0] SPI_REG_6A_H;
wire [7:0] SPI_REG_6B_H;
wire [7:0] SPI_REG_6C_H;
wire [7:0] SPI_REG_6D_H;
wire [7:0] SPI_REG_6E_H;
wire [7:0] SPI_REG_6F_H;
wire [7:0] SPI_REG_70_H;
wire [7:0] SPI_REG_71_H;
wire [7:0] SPI_REG_72_H;
wire [7:0] SPI_REG_73_H;
wire [7:0] SPI_REG_74_H;
wire [7:0] SPI_REG_75_H;
wire [7:0] SPI_REG_76_H;
wire [7:0] SPI_REG_77_H;
wire [7:0] SPI_REG_78_H; 
wire [7:0] SPI_REG_79_H;
wire [7:0] SPI_REG_7A_H;
wire [7:0] SPI_REG_7B_H;
wire [7:0] SPI_REG_7C_H;
wire [7:0] SPI_REG_7D_H;
wire [7:0] SPI_REG_7E_H;
wire [7:0] SPI_REG_7F_H;


 
 
assign  {
SPI_REG_7F_O,  
SPI_REG_7E_O,   
SPI_REG_7D_O,  
SPI_REG_7C_O,  
SPI_REG_7B_O,  
SPI_REG_7A_O,  
SPI_REG_79_O,  
SPI_REG_78_O,
SPI_REG_77_O,
SPI_REG_76_O,
SPI_REG_75_O,
SPI_REG_74_O,
SPI_REG_73_O,
SPI_REG_72_O,
SPI_REG_71_O,
SPI_REG_70_O,
SPI_REG_6F_O,
SPI_REG_6E_O,
SPI_REG_6D_O,
SPI_REG_6C_O,
SPI_REG_6B_O,
SPI_REG_6A_O,
SPI_REG_69_O,
SPI_REG_68_O,
SPI_REG_67_O,
SPI_REG_66_O,
SPI_REG_65_O,
SPI_REG_64_O,
SPI_REG_63_O,
SPI_REG_62_O,
SPI_REG_61_O,
SPI_REG_60_O,
SPI_REG_5F_O,
SPI_REG_5E_O,
SPI_REG_5D_O,
SPI_REG_5C_O,
SPI_REG_5B_O,
SPI_REG_5A_O,
SPI_REG_59_O,
SPI_REG_58_O,
SPI_REG_57_O,
SPI_REG_56_O,
SPI_REG_55_O,
SPI_REG_54_O,
SPI_REG_53_O,
SPI_REG_52_O,
SPI_REG_51_O,
SPI_REG_50_O,
SPI_REG_4F_O,
SPI_REG_4E_O,
SPI_REG_4D_O,
SPI_REG_4C_O,
SPI_REG_4B_O,
SPI_REG_4A_O,
SPI_REG_49_O,
SPI_REG_48_O,
SPI_REG_47_O,
SPI_REG_46_O,
SPI_REG_45_O,
SPI_REG_44_O,
SPI_REG_43_O,
SPI_REG_42_O,
SPI_REG_41_O,
SPI_REG_40_O,
SPI_REG_3F_O,
SPI_REG_3E_O,
SPI_REG_3D_O,
SPI_REG_3C_O,
SPI_REG_3B_O,
SPI_REG_3A_O,
SPI_REG_39_O,
SPI_REG_38_O,
SPI_REG_37_O,
SPI_REG_36_O,
SPI_REG_35_O,
SPI_REG_34_O,
SPI_REG_33_O,
SPI_REG_32_O,
SPI_REG_31_O,
SPI_REG_30_O,
SPI_REG_2F_O,
SPI_REG_2E_O,
SPI_REG_2D_O,
SPI_REG_2C_O,
SPI_REG_2B_O,
SPI_REG_2A_O,
SPI_REG_29_O,
SPI_REG_28_O,
SPI_REG_27_O,
SPI_REG_26_O,
SPI_REG_25_O,
SPI_REG_24_O,
SPI_REG_23_O,
SPI_REG_22_O,
SPI_REG_21_O,
SPI_REG_20_O,
SPI_REG_1F_O,
SPI_REG_1E_O,
SPI_REG_1D_O,
SPI_REG_1C_O,
SPI_REG_1B_O,
SPI_REG_1A_O,
SPI_REG_19_O,
SPI_REG_18_O,
SPI_REG_17_O,
SPI_REG_16_O,
SPI_REG_15_O,
SPI_REG_14_O,
SPI_REG_13_O,
SPI_REG_12_O,
SPI_REG_11_O,
SPI_REG_10_O,
SPI_REG_0F_O,
SPI_REG_0E_O,
SPI_REG_0D_O,
SPI_REG_0C_O,
SPI_REG_0B_O,
SPI_REG_0A_O,
SPI_REG_09_O,
SPI_REG_08_O,
SPI_REG_07_O,
SPI_REG_06_O,
SPI_REG_05_O,
SPI_REG_04_O,
SPI_REG_03_O,
SPI_REG_02_O,
SPI_REG_01_O,
SPI_REG_00_O} = DOUT;


assign  { 
SPI_REG_7F_H,
SPI_REG_7E_H,
SPI_REG_7D_H,
SPI_REG_7C_H,
SPI_REG_7B_H,
SPI_REG_7A_H,
SPI_REG_79_H,
SPI_REG_78_H,    
SPI_REG_77_H,    
SPI_REG_76_H,    
SPI_REG_75_H,    
SPI_REG_74_H,    
SPI_REG_73_H,    
SPI_REG_72_H,    
SPI_REG_71_H,    
SPI_REG_70_H,    
SPI_REG_6F_H,    
SPI_REG_6E_H,    
SPI_REG_6D_H,    
SPI_REG_6C_H,    
SPI_REG_6B_H,    
SPI_REG_6A_H,    
SPI_REG_69_H,    
SPI_REG_68_H,    
SPI_REG_67_H,    
SPI_REG_66_H,    
SPI_REG_65_H,    
SPI_REG_64_H,    
SPI_REG_63_H,    
SPI_REG_62_H,    
SPI_REG_61_H,    
SPI_REG_60_H,    
SPI_REG_5F_H,
SPI_REG_5E_H,
SPI_REG_5D_H,
SPI_REG_5C_H,
SPI_REG_5B_H,
SPI_REG_5A_H,
SPI_REG_59_H,
SPI_REG_58_H,
SPI_REG_57_H,
SPI_REG_56_H,
SPI_REG_55_H,
SPI_REG_54_H,
SPI_REG_53_H,
SPI_REG_52_H,
SPI_REG_51_H,
SPI_REG_50_H,
SPI_REG_4F_H,
SPI_REG_4E_H,
SPI_REG_4D_H,
SPI_REG_4C_H,
SPI_REG_4B_H,
SPI_REG_4A_H,
SPI_REG_49_H,
SPI_REG_48_H,
SPI_REG_47_H,
SPI_REG_46_H,
SPI_REG_45_H,
SPI_REG_44_H,
SPI_REG_43_H,
SPI_REG_42_H,
SPI_REG_41_H,
SPI_REG_40_H,
SPI_REG_3F_H,
SPI_REG_3E_H,
SPI_REG_3D_H,
SPI_REG_3C_H,
SPI_REG_3B_H,
SPI_REG_3A_H,
SPI_REG_39_H,
SPI_REG_38_H,
SPI_REG_37_H,
SPI_REG_36_H,
SPI_REG_35_H,
SPI_REG_34_H,
SPI_REG_33_H,
SPI_REG_32_H,
SPI_REG_31_H,
SPI_REG_30_H,
SPI_REG_2F_H,
SPI_REG_2E_H,
SPI_REG_2D_H,
SPI_REG_2C_H,
SPI_REG_2B_H,
SPI_REG_2A_H,
SPI_REG_29_H,
SPI_REG_28_H,
SPI_REG_27_H,
SPI_REG_26_H,
SPI_REG_25_H,
SPI_REG_24_H,
SPI_REG_23_H,
SPI_REG_22_H,
SPI_REG_21_H,
SPI_REG_20_H,
SPI_REG_1F_H,
SPI_REG_1E_H,
SPI_REG_1D_H,
SPI_REG_1C_H,
SPI_REG_1B_H,
SPI_REG_1A_H,
SPI_REG_19_H,
SPI_REG_18_H,
SPI_REG_17_H,
SPI_REG_16_H,
SPI_REG_15_H,
SPI_REG_14_H,
SPI_REG_13_H,
SPI_REG_12_H,
SPI_REG_11_H,
SPI_REG_10_H,
SPI_REG_0F_H,
SPI_REG_0E_H,
SPI_REG_0D_H,
SPI_REG_0C_H,
SPI_REG_0B_H,
SPI_REG_0A_H,
SPI_REG_09_H,
SPI_REG_08_H,
SPI_REG_07_H,
SPI_REG_06_H,
SPI_REG_05_H,
SPI_REG_04_H,
SPI_REG_03_H,
SPI_REG_02_H,
SPI_REG_01_H,
SPI_REG_00_H} = DOUT_3;


assign DOUT_hold={ 
SPI_REG_7F_H,
SPI_REG_7E_H,
SPI_REG_7D_H,
SPI_REG_7C_H,
SPI_REG_7B_H,
SPI_REG_7A_H,    
SPI_REG_79_H,
SPI_REG_78_H, 
SPI_REG_77_H, 
SPI_REG_76_H, 
SPI_REG_75_H, 
SPI_REG_74_H, 
SPI_REG_73_H, 
SPI_REG_72_H, 
SPI_REG_71_H, 
SPI_REG_70_H, 
SPI_REG_6F_H, 
SPI_REG_6E_H, 
SPI_REG_6D_H, 
SPI_REG_6C_H, 
SPI_REG_6B_H, 
SPI_REG_6A_H, 
SPI_REG_69_H, 
SPI_REG_68_H, 
SPI_REG_67_H, 
SPI_REG_66_H, 
SPI_REG_65_H, 
SPI_REG_64_H, 
SPI_REG_63_H, 
SPI_REG_62_H, 
SPI_REG_61_H, 
SPI_REG_60_H, 
SPI_REG_5F_H,
SPI_REG_5E_H,
SPI_REG_5D_H,
SPI_REG_5C_H,
SPI_REG_5B_H,
SPI_REG_5A_H,
SPI_REG_59_H,
SPI_REG_58_H,
SPI_REG_57_H,
SPI_REG_56_H,
SPI_REG_55_H,
SPI_REG_54_H,
SPI_REG_53_H,
SPI_REG_52_H,
SPI_REG_51_H,
SPI_REG_50_H,
SPI_REG_4F_H,
SPI_REG_4E_H,
SPI_REG_4D_H,
SPI_REG_4C_H,
SPI_REG_4B_H,
SPI_REG_4A_H,
SPI_REG_49_H,
SPI_REG_48_H,
SPI_REG_47_H,
SPI_REG_46_H,
SPI_REG_45_H,
SPI_REG_44_H,
SPI_REG_43_H,
SPI_REG_42_H,
SPI_REG_41_H,
SPI_REG_40_H,
SPI_REG_3F_H,
SPI_REG_3E_H,
SPI_REG_3D_H,
SPI_REG_3C_H,
SPI_REG_3B_H,
SPI_REG_3A_H,
SPI_REG_39_H,
SPI_REG_38_H,
SPI_REG_37_H,
SPI_REG_36_H,
SPI_REG_35_H,
SPI_REG_34_H,
SPI_REG_33_H,
SPI_REG_32_H,
SPI_REG_31_H,
SPI_REG_30_H,
SPI_REG_2F_H,
SPI_REG_2E_H,
SPI_REG_2D_H,
SPI_REG_2C_H,
SPI_REG_2B_H[7:3],SPI_REG_2B_O[2:0],
SPI_REG_2A_H[7:2],SPI_REG_2A_O[1],SPI_REG_2A_H[0],
SPI_REG_29_H,
SPI_REG_28_H,
SPI_REG_27_H,
SPI_REG_26_H,
SPI_REG_25_H,
SPI_REG_24_H[7],SPI_REG_24_O[6],SPI_REG_24_H[5:0],
SPI_REG_23_H,
SPI_REG_22_O[7:6],SPI_REG_22_H[5:0], 
SPI_REG_21_H,
SPI_REG_20_H[7],SPI_REG_20_O[6:5],SPI_REG_20_H[4:0], 
SPI_REG_1F_H,
SPI_REG_1E_H,
SPI_REG_1D_H,
SPI_REG_1C_O[7],SPI_REG_1C_H[6:0],
SPI_REG_1B_H,
SPI_REG_1A_H,
SPI_REG_19_H,
SPI_REG_18_O[7],SPI_REG_18_H[6:0],
SPI_REG_17_H,
SPI_REG_16_H,
SPI_REG_15_H,
SPI_REG_14_H,
SPI_REG_13_O,
SPI_REG_12_O,
SPI_REG_11_O,
SPI_REG_10_O,
SPI_REG_0F_O,
SPI_REG_0E_H[7],SPI_REG_0E_O[6],SPI_REG_0E_H[5:4],SPI_REG_0E_O[3:0],
SPI_REG_0D_H,
SPI_REG_0C_O,
SPI_REG_0B_O,
SPI_REG_0A_H[7:6],SPI_REG_0A_O[5:0],
SPI_REG_09_O,
SPI_REG_08_H,
SPI_REG_07_H,
SPI_REG_06_H[7:2],SPI_REG_06_O[1],SPI_REG_06_H[0],
SPI_REG_05_H[7:1],SPI_REG_05_O[0],
SPI_REG_04_H,
SPI_REG_03_H,
SPI_REG_02_H,
SPI_REG_01_H,
SPI_REG_00_H};

assign  {
SPI_REG_7F,
SPI_REG_7E,
SPI_REG_7D,
SPI_REG_7C,
SPI_REG_7B,
SPI_REG_7A,
SPI_REG_79,           
SPI_REG_78,
SPI_REG_77,
SPI_REG_76,
SPI_REG_75,
SPI_REG_74,
SPI_REG_73,
SPI_REG_72,
SPI_REG_71,
SPI_REG_70,
SPI_REG_6F,
SPI_REG_6E,
SPI_REG_6D,
SPI_REG_6C,
SPI_REG_6B,
SPI_REG_6A,
SPI_REG_69,
SPI_REG_68,
SPI_REG_67,
SPI_REG_66,
SPI_REG_65,
SPI_REG_64,
SPI_REG_63,
SPI_REG_62,
SPI_REG_61,
SPI_REG_60,
SPI_REG_5F,
SPI_REG_5E,
SPI_REG_5D,
SPI_REG_5C,
SPI_REG_5B,
SPI_REG_5A,
SPI_REG_59,
SPI_REG_58,
SPI_REG_57,
SPI_REG_56,
SPI_REG_55,
SPI_REG_54,
SPI_REG_53,
SPI_REG_52,
SPI_REG_51,
SPI_REG_50,
SPI_REG_4F,
SPI_REG_4E,
SPI_REG_4D,
SPI_REG_4C,
SPI_REG_4B,
SPI_REG_4A,
SPI_REG_49,
SPI_REG_48,
SPI_REG_47,
SPI_REG_46,
SPI_REG_45,
SPI_REG_44,
SPI_REG_43,
SPI_REG_42,
SPI_REG_41,
SPI_REG_40,
SPI_REG_3F,
SPI_REG_3E,
SPI_REG_3D,
SPI_REG_3C,
SPI_REG_3B,
SPI_REG_3A,
SPI_REG_39,
SPI_REG_38,
SPI_REG_37,
SPI_REG_36,
SPI_REG_35,
SPI_REG_34,
SPI_REG_33,
SPI_REG_32,
SPI_REG_31,
SPI_REG_30,
SPI_REG_2F,
SPI_REG_2E,
SPI_REG_2D,
SPI_REG_2C,
SPI_REG_2B,
SPI_REG_2A,
SPI_REG_29,
SPI_REG_28,
SPI_REG_27,
SPI_REG_26,
SPI_REG_25,
SPI_REG_24,
SPI_REG_23,
SPI_REG_22,
SPI_REG_21,
SPI_REG_20,
SPI_REG_1F,
SPI_REG_1E,
SPI_REG_1D,
SPI_REG_1C,
SPI_REG_1B,
SPI_REG_1A,  
SPI_REG_19,					
SPI_REG_18, 
SPI_REG_17,			
SPI_REG_16,
SPI_REG_15,
SPI_REG_14,
SPI_REG_13,
SPI_REG_12,
SPI_REG_11,
SPI_REG_10,
SPI_REG_0F,
SPI_REG_0E,
SPI_REG_0D,
SPI_REG_0C,
SPI_REG_0B,
SPI_REG_0A,
SPI_REG_09,
SPI_REG_08,
SPI_REG_07,
SPI_REG_06,
SPI_REG_05,
SPI_REG_04,
SPI_REG_03,
SPI_REG_02,
SPI_REG_01,
SPI_REG_00} = DOUT_2;



endmodule
