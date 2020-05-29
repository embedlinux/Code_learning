// ===========================================================
// DFFC:  A flip-flop with asynchronous clear, for
// use in shift register models of Lab 4
//
// ------------------------------------------------------------
// 2005-05-12 jmw: v. 1.3 Comment changes; added `ifdefs.
// 2005-02-13 jmw: v. 1.2 Copied here from Lab08 for Lab21.
// 2005-01-28 jmw: v. 1.2 Moved delays away from nonblocks for
//            synthesis.
// 2004-12-19 jmw: v. 1.1 Renamed to DFFC & timing for Lab08.
// 2004-12-04 jmw: v. 1.0  of ShiftFlop implemented.
// ============================================================
//
// `defines for Steps are in the tb.
//
module DFFC (output Q, Qn, input D, Clk, Clr);
//
reg  QReg;  // DFFC model storage.
//
reg Notify; // Timing-check notifier for Step 7C & after.
//
// ----------------------------
//
`ifdef Step6
specify
 specparam trClk_Q    = 1.000;
 specparam tfClk_Q    = 0.800;
 specparam trClk_Qn   = 1.100;
 specparam tfClk_Qn   = 0.850;
 specparam trClr_QQn  = 0.700;
 specparam tfClr_QQn  = 0.900;
 specparam tppulsRej  = 0.500;
 specparam tppulsErr  = 1.100;
 //
 (Clk=>Q)    = (trClk_Q,   tfClk_Q);
 (Clk=>Qn)   = (trClk_Qn,  tfClk_Qn);
 (Clr*>Q,Qn) = (trClr_QQn, tfClr_QQn);
 // specparam showcancelled Q, Qn; // Not in Silos, Aldec, VCS, or QuestaSim.
 //$nochange(posedge Clk, D, 1, 1); // Not in Silos, Aldec, VCS, or QuestaSim.
 specparam PATHPULSE$ = (tppulsRej, tppulsErr);
endspecify
`endif
`ifdef Step7A
specify
 specparam trClk_Q    = 1.000;
 specparam tfClk_Q    = 0.800;
 specparam trClk_Qn   = 1.100;
 specparam tfClk_Qn   = 0.850;
 specparam trClr_QQn  = 0.700;
 specparam tfClr_QQn  = 0.900;
 specparam tppulsRej  = 0.500;
 specparam tppulsErr  = 1.100;
 specparam twMinQQn   = 1.0;
 //
 (Clk=>Q)    = (trClk_Q,   tfClk_Q);
 (Clk=>Qn)   = (trClk_Qn,  tfClk_Qn);
 (Clr*>Q,Qn) = (trClr_QQn, tfClr_QQn);
 //specparam PATHPULSE$ = (tppulsRej, tppulsErr);
 $width(posedge Q,  twMinQQn);
 $width(posedge Qn, twMinQQn);
endspecify
`endif
`ifdef Step7B
specify
 specparam trClk_Q    = 1.000;
 specparam tfClk_Q    = 0.800;
 specparam trClk_Qn   = 1.100;
 specparam tfClk_Qn   = 0.850;
 specparam trClr_QQn  = 0.700;
 specparam tfClr_QQn  = 0.900;
 specparam tppulsRej  = 0.500;
 specparam tppulsErr  = 1.100;
 specparam twMinQQn   = 0.850; // 1.0; // not in QuestaSim.
 //
 (Clk=>Q)    = (trClk_Q,   tfClk_Q);
 (Clk=>Qn)   = (trClk_Qn,  tfClk_Qn);
 (Clr*>Q,Qn) = (trClr_QQn, tfClr_QQn);
 //specparam PATHPULSE$ = (tppulsRej, tppulsErr);
 $width(posedge Q,  twMinQQn);
 $width(posedge Qn, twMinQQn);
endspecify
`endif
`ifdef Step7C
specify
 specparam trClk_Q    = 1.000;
 specparam tfClk_Q    = 0.800;
 specparam trClk_Qn   = 1.100;
 specparam tfClk_Qn   = 0.850;
 specparam trClr_QQn  = 0.700;
 specparam tfClr_QQn  = 0.900;
 specparam tppulsRej  = 0.500;
 specparam tppulsErr  = 1.100;
 specparam twMinQQn   = 0.850; // 1.0;
 //
 (Clk=>Q)    = (trClk_Q,   tfClk_Q);
 (Clk=>Qn)   = (trClk_Qn,  tfClk_Qn);
 (Clr*>Q,Qn) = (trClr_QQn, tfClr_QQn);
 //specparam PATHPULSE$ = (tppulsRej, tppulsErr);
 $width(posedge Q,  twMinQQn, 0, Notify);
 $width(posedge Qn, twMinQQn, 0, Notify);
endspecify
`endif
`ifdef Step8A
specify
 specparam trClk_Q    = 1.000;
 specparam tfClk_Q    = 0.800;
 specparam trClk_Qn   = 1.100;
 specparam tfClk_Qn   = 0.850;
 specparam trClr_QQn  = 0.700;
 specparam tfClr_QQn  = 0.900;
 specparam tppulsRej  = 0.500;
 specparam tppulsErr  = 1.100;
 specparam twMinQQn   = 0.500;
 specparam tsMinD_Clk = 1.000;
 specparam thMinClk_D = 0.500;
 //
 (Clk=>Q)    = (trClk_Q,   tfClk_Q);
 (Clk=>Qn)   = (trClk_Qn,  tfClk_Qn);
 (Clr*>Q,Qn) = (trClr_QQn, tfClr_QQn);
 //specparam PATHPULSE$ = (tppulsRej, tppulsErr);
 $width(posedge Q,  twMinQQn, 0, Notify);
 $width(posedge Qn, twMinQQn, 0, Notify);
 $setup(D, posedge Clk, tsMinD_Clk);
 $hold(posedge Clk,  D, thMinClk_D);
endspecify
`endif
`ifdef Step8B
specify
 specparam trClk_Q    = 1.000;
 specparam tfClk_Q    = 0.800;
 specparam trClk_Qn   = 1.100;
 specparam tfClk_Qn   = 0.850;
 specparam trClr_QQn  = 0.700;
 specparam tfClr_QQn  = 0.900;
 specparam tppulsRej  = 0.500;
 specparam tppulsErr  = 1.100;
 specparam twMinQQn   = 0.500;
 specparam tsMinD_Clk = 0.010;
 specparam thMinClk_D = 0.013;
 //
 (Clk=>Q)    = (trClk_Q,   tfClk_Q);
 (Clk=>Qn)   = (trClk_Qn,  tfClk_Qn);
 (Clr*>Q,Qn) = (trClr_QQn, tfClr_QQn);
 //specparam PATHPULSE$ = (tppulsRej, tppulsErr);
 $width(posedge Q,  twMinQQn, 0, Notify);
 $width(posedge Qn, twMinQQn, 0, Notify);
 $setup(D, posedge Clk, tsMinD_Clk, Notify);
 $hold(posedge Clk,  D, thMinClk_D, Notify);
endspecify
`endif
`ifdef Step8C
specify
 specparam trClk_Q    = 1.000;
 specparam tfClk_Q    = 0.800;
 specparam trClk_Qn   = 1.100;
 specparam tfClk_Qn   = 0.850;
 specparam trClr_QQn  = 0.700;
 specparam tfClr_QQn  = 0.900;
 specparam tppulsRej  = 0.500;
 specparam tppulsErr  = 1.100;
 specparam twMinQQn   = 0.500;
 specparam tsMinD_Clk = 0.001;
 specparam thMinClk_D = 0.004;
 //
 (Clk=>Q)    = (trClk_Q,   tfClk_Q);
 (Clk=>Qn)   = (trClk_Qn,  tfClk_Qn);
 (Clr*>Q,Qn) = (trClr_QQn, tfClr_QQn);
 //specparam PATHPULSE$ = (tppulsRej, tppulsErr);
 $width(posedge Q,  twMinQQn, 0, Notify);
 $width(posedge Qn, twMinQQn, 0, Notify);
 $setup(D, posedge Clk, tsMinD_Clk, Notify);
 $hold(posedge Clk,  D, thMinClk_D, Notify);
endspecify
`endif
`ifdef Step9
specify
 specparam trClk_Q    = 1.000;
 specparam tfClk_Q    = 0.800;
 specparam trClk_Qn   = 1.100;
 specparam tfClk_Qn   = 0.850;
 specparam trClr_QQn  = 0.700;
 specparam tfClr_QQn  = 0.900;
 specparam tppulsRej  = 0.500;
 specparam tppulsErr  = 1.100;
 specparam twMinQQn   = 0; // 0.500;
 specparam tsMinD_Clk = 0; // 0.001;
 specparam thMinClk_D = 0; // 0.004;
 specparam tskwMinClr_Clk = 49.99;
 //
 (Clk=>Q)    = (trClk_Q,   tfClk_Q);
 (Clk=>Qn)   = (trClk_Qn,  tfClk_Qn);
 (Clr*>Q,Qn) = (trClr_QQn, tfClr_QQn);
 //specparam PATHPULSE$ = (tppulsRej, tppulsErr);
 $width(posedge Q,  twMinQQn, 0, Notify);
 $width(posedge Qn, twMinQQn, 0, Notify);
 $setup(D, posedge Clk, tsMinD_Clk, Notify);
 $hold(posedge Clk,  D, thMinClk_D, Notify);
 $skew(posedge Clr, posedge Clk, tskwMinClr_Clk);
endspecify
`endif
`ifdef Step10A
specify
 specparam trClk_Q    = 1.000;
 specparam tfClk_Q    = 0.800;
 specparam trClk_Qn   = 1.100;
 specparam tfClk_Qn   = 0.850;
 specparam trClr_QQn  = 0.700;
 specparam tfClr_QQn  = 0.900;
 specparam tppulsRej  = 0.500;
 specparam tppulsErr  = 1.100;
 specparam twMinQQn   = 0; // 0.500;
 specparam tsMinD_Clk = 0; // 0.001;
 specparam thMinClk_D = 0; // 0.004;
 specparam tskwMinClr_Clk   = 50.000;  // 49.99;
 specparam trecovMinClr_Clk =  0.010;
 //
 (Clk=>Q)    = (trClk_Q,   tfClk_Q);
 (Clk=>Qn)   = (trClk_Qn,  tfClk_Qn);
 (Clr*>Q,Qn) = (trClr_QQn, tfClr_QQn);
 //specparam PATHPULSE$ = (tppulsRej, tppulsErr);
 $width(posedge Q,  twMinQQn, 0, Notify);
 $width(posedge Qn, twMinQQn, 0, Notify);
 $setup(D, posedge Clk, tsMinD_Clk, Notify);
 $hold(posedge Clk,  D, thMinClk_D, Notify);
 $skew(posedge Clr, posedge Clk, tskwMinClr_Clk);
 $recovery(negedge Clr, posedge Clk, trecovMinClr_Clk);
endspecify
`endif
`ifdef Step10B
specify
 specparam trClk_Q    = 1.000;
 specparam tfClk_Q    = 0.800;
 specparam trClk_Qn   = 1.100;
 specparam tfClk_Qn   = 0.850;
 specparam trClr_QQn  = 0.700;
 specparam tfClr_QQn  = 0.900;
 specparam tppulsRej  = 0.500;
 specparam tppulsErr  = 1.100;
 specparam twMinQQn   = 0; // 0.500;
 specparam tsMinD_Clk = 0; // 0.001;
 specparam thMinClk_D = 0; // 0.004;
 specparam tskwMinClr_Clk   = 50.000;  // 49.99;
 specparam trecovMinClr_Clk =  0; // 0.010;
 specparam tremovMinClk_Clr = 0.010;
 //
 (Clk=>Q)    = (trClk_Q,   tfClk_Q);
 (Clk=>Qn)   = (trClk_Qn,  tfClk_Qn);
 (Clr*>Q,Qn) = (trClr_QQn, tfClr_QQn);
 //specparam PATHPULSE$ = (tppulsRej, tppulsErr);
 $width(posedge Q,  twMinQQn, 0, Notify);
 $width(posedge Qn, twMinQQn, 0, Notify);
 $setup(D, posedge Clk, tsMinD_Clk, Notify);
 $hold(posedge Clk,  D, thMinClk_D, Notify);
 $skew(posedge Clr, posedge Clk, tskwMinClr_Clk);
 $recovery(negedge Clr, posedge Clk, trecovMinClr_Clk);
 $removal(posedge Clk, negedge Clr, tremovMinClk_Clr);
endspecify
`endif
//
// ----------------------------
// Step 7C & later:
always@(Notify) $stop;
//
// ----------------------------
//
assign #0.001 Q  =  QReg;
assign #0.001 Qn = ~QReg;
//
always@(posedge Clk, posedge Clr)
   if (Clr==1'b1)
        QReg <= 1'b0;
   else QReg <= D;
//
endmodule // DFFC.
