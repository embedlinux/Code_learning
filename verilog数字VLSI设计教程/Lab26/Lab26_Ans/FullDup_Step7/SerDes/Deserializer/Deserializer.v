// ===========================================================
// Deserializer: Top level of the Des half of the SerDes.
//
// Default parallel output bus width is 32 bits.
//
// Intended for testing with the DeserializerTst module.
// ------------------------------------------------------------
// 2006-07-26 jmw:  v. 1.3 Renamed instances consistent with
//      names in Serializer.
// 2006-05-24 jmw:  v. 1.2 Renamed ParValidReg to ParValidr;
//      renamed FIFOReadCmd input port to ReadReq
// 2006-05-23 jmw:  v. 1.1 Connected FIFO WriteIn to DesDecoder
//      ParValid; modified ParValid logic.
// 2006-05-19 jmw:  v. 1.0 Implemented.
// ============================================================
//
module Deserializer
  #(parameter AWid = 5   // Configures FIFO default depth.
   ,          DWid = 32  // Addressable widths everywhere.
   )
  ( output[DWid-1:0] ParOut, output ParValid, DecoderParClk
  , output FIFOEmpty, FIFOFull
  , input ParOutClk, SerialIn, ReadReq, SerValid, Reset
  );
//
wire[DWid-1:0] FIFO_Out, DecodeToFIFO;
wire SerialClk, SerRxToDecode, ParValidDecode;
//
reg[DWid-1:0] ParBuf;  // The buffer shown in the figure.
reg ParValidr;
//
// -------------------------------------------------------
// Runtime:
assign ParOut   = ParBuf; // Could add delays here:
assign ParValid = ParValidr;
//
// The output buffer functionality
// (may be done any of several ways):
//
always@(posedge ParOutClk, posedge Reset)
  begin : OutputBuffer
  if (Reset==1'b1)
       begin
       ParBuf    <=  'b0;
       ParValidr <= 1'b0;
       end
  else begin
       ParBuf    <= (ReadReq==1'b1)? FIFO_Out : 'b0;
       ParValidr <=  ReadReq && (~FIFOEmpty);
       end
  end
//
// -------------------------------------------------------
// Structure:
//
FIFOTop #( .AWid(AWid), .DWid(DWid) )
FIFO_Rx1
  ( .Dout(FIFO_Out), .Din(DecodeToFIFO)
  , .ReadIn(ReadReq), .WriteIn(ParValidDecode)
  , .Full(FIFOFull), .Empty(FIFOEmpty)
  , .ClkR(ParOutClk), .ClkW(DecoderParClk), .Reseter(Reset)
  );
//
DesDecoder #( .DWid(DWid) )
DesDec_Rx1
  ( .ParOut(DecodeToFIFO), .ParValid(ParValidDecode)
  , .ParClk(DecoderParClk), .SerClk(SerialClk)
  , .SerIn(SerRxToDecode), .SerValid(SerValid), .Reset(Reset)
  );
//
SerialRx
SerRx_Rx1
  ( .SerClk(SerialClk), .SerData(SerRxToDecode)
  , .SerLinkIn(SerialIn), .ParClk(DecoderParClk)
  , .Reset(Reset)
  );
//
endmodule // Deserializer.
//
