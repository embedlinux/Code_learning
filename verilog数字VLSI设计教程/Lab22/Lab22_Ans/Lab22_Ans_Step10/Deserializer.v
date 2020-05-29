// ===========================================================
// Deserializer: Top level of the Des half of the SerDes.
//
// Default parallel output bus width is 32 bits.
//
// Intended for testing with the DeserializerTst module.
// ------------------------------------------------------------
// 2006-05-19 jmw:  v. 1.0 Implemented.
// ============================================================
//
module Deserializer
  #(parameter AWid = 5   // Configures FIFO default depth.
   ,          DWid = 32  // Addressable widths everywhere.
   )
  ( output[DWid-1:0] ParOut, output ParValid, DecoderParClk
  , output FIFOEmpty, FIFOFull
  , input ParOutClk, SerialIn, FIFOReadCmd, SerValid, Reset
  );
//
wire[DWid-1:0] FIFO_Out, DecodeToFIFO;
wire SerialClk, SerRxToDecode, ParValidDecode;
//
reg[DWid-1:0] ParBuf;  // The buffer shown in the figure.
reg ParValidReg;
//
// -------------------------------------------------------
// Runtime:
assign ParOut   = ParBuf; // Could add delays here:
assign ParValid = ParValidReg;
//
// The output buffer functionality:
//
always@(posedge ParOutClk, posedge Reset)
  begin : OutputBuffer
  if (Reset==1'b1)
       begin
       ParBuf      <= 'b0;
       ParValidReg <= 1'b0;
       end
  else begin
       ParBuf <= FIFO_Out;
       ParValidReg <= ~FIFOEmpty;
       end
  end
//
// -------------------------------------------------------
// Structure:
//
FIFO_Top #( .AWid(AWid), .DWid(DWid) )
FIFO_U1
  ( .Dout(FIFO_Out), .Din(DecodeToFIFO)
  , .ReadIn(FIFOReadCmd), .WriteIn(ParValidDecode)
  , .Full(FIFOFull), .Empty(FIFOEmpty)
  , .Clocker(DecoderParClk), .Reseter(Reset)
  );
//
DesDecoder #( .DWid(DWid) )
DesDecoder_U1
  ( .ParOut(DecodeToFIFO), .ParValid(ParValidDecode)
  , .ParClk(DecoderParClk), .SerClk(SerialClk)
  , .SerIn(SerRxToDecode), .SerValid(SerValid), .Reset(Reset)
  );
//
SerialRx
SerialRx_U1
  ( .SerClk(SerialClk), .SerData(SerRxToDecode)
  , .SerLinkIn(SerialIn), .ParClk(DecoderParClk)
  , .Reset(Reset)
  );
//
endmodule // Deserializer.
//
