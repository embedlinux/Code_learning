/*****************************************************
FileName    : reg_cfg_00.sv
Auhtor	    : Jy
Data	      : 2011-7-4
Version	    : 0.10
Function    : It is user's operation code here, read 
	            and write registers typically.
*****************************************************/

// write register operation
write_reg(`BASE_ADDR+32'h4, 32'hABCD_EF00);
// read register operation
read_reg(`BASE_ADDR+32'h4, r_data);
$display("read register's value is %0h", r_data);

#10; // MUST have!

write_reg(`BASE_ADDR+32'h8, 32'hABCD_EF11);
read_reg(`BASE_ADDR+32'h8, r_data);
$display("read register's value is %0h", r_data);

#10; // MUST have!

read_reg(`BASE_ADDR+32'h4, r_data);
$display("read register's value is %0h", r_data);
