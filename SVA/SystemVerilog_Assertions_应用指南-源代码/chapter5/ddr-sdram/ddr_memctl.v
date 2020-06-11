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


module ddr_memctl(s_clk, s_clk2x, s_ras_n, s_cas_n, s_sel_n, s_we_n, s_addr, d_dq, s_rd_start);

output logic s_clk, s_clk2x, s_ras_n, s_cas_n;
output logic [7:0] s_sel_n;
output logic s_rd_start, s_we_n;
output logic [15:0] s_addr;
output logic [15:0] d_dq;


endmodule
