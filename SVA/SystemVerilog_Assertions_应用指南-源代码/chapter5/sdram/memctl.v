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


// This is the design under test
// modify the port list as per your signals and then modify them in 
// sdram_assertions.sva  bind statement also

module memctl (hclk, hresetn, s_bank_addr, hsize, hburst, s_ras_n, s_cas_n, s_sel_n, s_we_n, s_addr, s_rd_data, s_rd_pop, s_rd_start, s_dqm);

output logic hclk, hresetn, s_ras_n, s_cas_n, s_we_n;
output logic [7:0] s_sel_n;
output logic [15:0] s_addr;
output logic [31:0] s_rd_data;
output logic [2:0] hburst;
output logic [1:0] hsize;
output logic [1:0] s_bank_addr;
output logic [3:0] s_dqm;
output logic s_rd_pop, s_rd_start;

endmodule
