/************************************************************************\
|*                                                                      *|
|*    Copyright (c) 2005  Springer. All rights reserved.                *|
|*                                                                      *|
|*  This example code shouyld be used only for illustration purpose     *| 
|*  This material is not to reproduced,  copied,  or used  in any       *|
|*  manner without the authorization of the author's/publishers         *|
|*  written permission                                                  *|
|*                                                                      *|
\************************************************************************/

// Author: Srikanth Vijayaraghavan and Meyyappan Ramanathan


module sram_memctl (hclk, hresetn, s_sel_n, sm_we_n, sm_wp_n, sm_addr, sm_rd_data, sm_oe_n);

output logic hclk, hresetn, sm_we_n, sm_oe_n;
output logic [7:0] s_sel_n;
output logic [3:0] sm_wp_n;
output logic [22:0] sm_addr;
output logic [31:0] sm_rd_data;

endmodule
