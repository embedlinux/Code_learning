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


module pci_target(PCLK, PRSTNN, PFRAMENN, PIRDYNN, PTRDYNN, PSTOPNN, PDEVSELNN, PIDSEL, PBENN,PCXBENN, PGNTNN, PREQNN, PPERRNN, PD, PADATA, PREQ64NN, PACK64NN, PPAR64, PPAR, PSERRNN);

output logic PCLK, PRSTNN, PFRAMENN, PIRDYNN, PTRDYNN, PSTOPNN, PDEVSELNN;
output logic [3:0] PBENN, PCXBENN;
output logic PGNTNN, PREQNN, PIDSEL, PPERRNN;
output logic [31:0] PD, PADATA;
output logic PREQ64NN, PACK64NN, PPAR64, PPAR, PSERRNN;


endmodule 
