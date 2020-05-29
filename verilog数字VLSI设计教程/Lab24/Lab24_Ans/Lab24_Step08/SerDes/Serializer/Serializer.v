// ===========================================================
// Serializer: Top level of the Ser half of the SerDes.
//
// Default parallel output bus width is 32 bits.
// The clock input must be about 1 MHz, although the serial
// link can transfer words only at half that rate.
//
// Intended for testing with the SerializerTst module located
// in a separate file.
// ------------------------------------------------------------
// 2006-06-02 jmw: v. 1.0 completed.  Instances all named *Tx1.
// 2006-06-01 jmw: v. 0.1 skeleton implemented.
// ============================================================
//
`include "SerDes.inc"  // timescale.
//
module Serializer
  #(parameter DWid = 32  // Width of addressable data word.
   ,          AWid =  5  // Depth of FIFO = 2**AWid words.
   )
   ( output SerOut, SerValid, FIFOEmpty, FIFOFull, SerClk 
   , input[DWid-1:0] ParIn, input InParValid, ParInClk
   , SendSerial, Reset
   );
//
wire[DWid-1:0] FIFO_Out;
wire SerTxOut, SerClkOut
   , SerEncReadReq, EncSerValid, EncD_ToTx
   , F_ReadReq, F_WriteReq, F_Empty, F_Full, F_Valid
   ;
//
assign SerOut    = SerTxOut;
assign SerValid  = EncSerValid;
assign FIFOEmpty = F_Empty;
assign FIFOFull  = F_Full;
assign SerClk    = SerClkOut;
//
// Compose a few new values:
//
assign F_Valid    = !F_Empty && !Reset;
assign F_ReadReq  = !F_Empty && SerEncReadReq && SendSerial;
assign F_WriteReq = !F_Full && InParValid;
//
// -------------------------------------------------------
// Structure:
//
FIFOTop #( .DWid(DWid), .AWid(AWid) )
FIFO_Tx1 ( .Dout(FIFO_Out), .Din(ParIn), .Full(F_Full)
         , .Empty(F_Empty), .ReadIn(F_ReadReq)
         , .WriteIn(F_WriteReq)
         , .ClkR(ParInClk), .ClkW(ParInClk)
         , .Reseter(Reset)
         );
//
SerEncoder #( .DWid(DWid) )
SerEnc_Tx1   ( .SerOut(EncD_ToTx), .SerValid(EncSerValid)
            , .FIFO_ReadReq(SerEncReadReq), .F_Empty(F_Empty)
            , .ParClk(ParInClk), .SerClk(SerClkOut)
            , .ParIn(FIFO_Out), .ParValid(F_Valid)
            , .Reset(Reset)
            );
//
SerialTx
SerTx_Tx1
          ( .SerClk(SerClkOut), .SerOut(SerTxOut)
          , .SerIn(EncD_ToTx), .ParClk(ParInClk)
          , .Reset(Reset)
          );
//
endmodule // Serializer.
//

