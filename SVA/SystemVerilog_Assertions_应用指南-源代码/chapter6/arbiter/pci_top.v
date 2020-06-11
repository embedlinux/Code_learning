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


module pci_top (pclk, prstnn, pframenn, pirdynn, ptrdynn, pstopnn, pdevselnn, pidsel, pcxbenn_upper, pcxbenn_lower, pgntnn, preqnn, pperrnn, pad_upper, pad_lower, preq64nn, pack64nn, ppar64, ppar, pserrnn, plocknn);

output logic pclk, prstnn, pframenn, pirdynn, ptrdynn, pstopnn, pdevselnn;
output logic [3:0] pcxbenn_upper, pcxbenn_lower, pidsel, pgntnn, preqnn;
output logic [31:0] pad_upper, pad_lower;
output logic pperrnn, preq64nn, pack64nn, ppar64, ppar, pserrnn, plocknn;

endmodule
