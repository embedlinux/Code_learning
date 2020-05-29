// ===========================================================
// SerDes: The fully assembled SerDes.
// ------------------------------------------------------------
// 2006-06-05 jmw:  v. 1.0 implemented.
// ============================================================
//
`include "SerDes.inc"  // timescale & period delays.
//
module 
SerDes #(parameter DWid = 32 // Width of addressable data word.
        ,          AWid = 5  // 2**5 = 32 addresses deep. 
        )
        ( output[DWid-1:0] ParOutRxClk /*, ParOutTxClk */
        , output SerLineXfer
        , input[DWid-1:0] ParDataIn
        , input InParClk, InParValid, OutParClk, RxRequest
        , TxRequest, Reset
        );
//
// Serializer collateral outputs start with "Tx_", Deserializer
// with // "Rx_".  Collateral outputs are left unconnected
// at the SerDes level of the design.
//
wire SerLine, SerLineValid
   , Tx_F_Empty, Tx_F_Full, Tx_SerClk
   , Rx_F_Empty, Rx_F_Full, Rx_ParClk
   , Rx_ParValid;
//
assign SerLineXfer = SerLine;
//
// ---------------------------------------------------------
//
Serializer #( .DWid(DWid), .AWid(AWid) ) 
   Ser_U1
  ( .SerOut(SerLine), .SerValid(SerLineValid)
  , .FIFOEmpty(Tx_F_Empty), .FIFOFull(Tx_F_Full)
  , .SerClk(Tx_SerClk) , .ParIn(ParDataIn)
  , .InParValid(InParValid) , .ParInClk(InParClk)
  , .SendSerial(TxRequest) , .Reset(Reset)
  );
//
Deserializer #( .DWid(DWid), .AWid(AWid) ) 
   Des_U1
   ( .ParOut(ParOutRxClk) /*, .ParOutT(ParOutTxClk) */
   , .ParValid(Rx_ParValid)
   , .DecoderParClk(Rx_ParClk), .FIFOEmpty(Rx_F_Empty)
   , .FIFOFull(Rx_F_Full), .ParOutClk(OutParClk)
   , .SerialIn(SerLine), .ReadReq(RxRequest)
   , .SerValid(SerLineValid), .Reset(Reset)
   );
//
endmodule // SerDes.
//

