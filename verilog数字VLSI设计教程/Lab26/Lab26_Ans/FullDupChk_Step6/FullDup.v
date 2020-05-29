// ===========================================================
// FullDup.v: Top-level design file for the full-duplex serdes.
// ------------------------------------------------------------
// 2006-06-20 jmw: v. 1.0 created from copy of SerDesTst.v.
// ============================================================
//
module 
FullDup #(parameter DWid = 32 // Width of addressable data word.
         , RxLogDepthA = 3, TxLogDepthA = 3 // 3 -> 8 words.
         , RxLogDepthB = 4, TxLogDepthB = 4 // 4 -> 16 words.
         )
         ( output[DWid-1:0] OutParDataA, OutParDataB
         , input[DWid-1:0] InParDataA, InParDataB
         , input InParValidA, InParValidB
         , ClockA, ClockB, Reset
         );
//
wire SerLine1, SerLine2;
wire RxRequestA, RxRequestB
   , TxRequestA, TxRequestB;
//
assign RxRequestA = 1'b1;
assign RxRequestB = 1'b1;
assign TxRequestA = InParValidA;
assign TxRequestB = InParValidB;
//
SerDes #( .DWid(DWid)
        , .RxLogDepth(RxLogDepthB)
        , .TxLogDepth(TxLogDepthA)
        ) 
SerDes_U1 // A sender; B receiver.
   ( .ParOutRxClk(OutParDataB)
   , .SerLineXfer(SerLine1)
   , .RxRequest(RxRequestB)
   , .ParDataIn(InParDataA)
   , .InParValid(InParValidA)
   , .TxRequest(TxRequestA)
   , .InParClk(ClockA)
   , .OutParClk(ClockB)
   , .Reset(Reset)
   );
//
SerDes #( .DWid(DWid)
        , .RxLogDepth(RxLogDepthA)
        , .TxLogDepth(TxLogDepthB)
        ) 
SerDes_U2 // B sender; A receiver.
   ( .ParOutRxClk(OutParDataA)
   , .SerLineXfer(SerLine2)
   , .RxRequest(RxRequestA)
   , .ParDataIn(InParDataB)
   , .InParValid(InParValidB)
   , .TxRequest(TxRequestB)
   , .InParClk(ClockB)
   , .OutParClk(ClockA)
   , .Reset(Reset)
   );
//
endmodule // FullDup.
//

