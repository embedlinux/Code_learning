
module fifo_synch ( data, transmit_enable, transmit_error, clk, txd, tx_en, 
        tx_er );
  input [3:0] data;
  output [3:0] txd;
  input transmit_enable, transmit_error, clk;
  output tx_en, tx_er;

  IVP U_CK1 ( .A(clk), .Z(n_ck1) );
  IVP U_CK2 ( .A(n_ck1), .Z(n_ck2) );
  IVP U_CK3 ( .A(n_ck2), .Z(n_ck3) );
  IVP U_CK4 ( .A(n_ck3), .Z(n_ck4) );
  IVP U_CK5 ( .A(n_ck4), .Z(n_ck5) );
  IVP U_CK6 ( .A(n_ck5), .Z(n_ck6) );

  FDS2 txd_reg_1 ( .D(data[1]), .CP(n_ck6), .CR(transmit_enable), .Q(txd[1]) );
  FDS2 txd_reg_3 ( .D(data[3]), .CP(n_ck6), .CR(transmit_enable), .Q(txd[3]) );
  FDS2 txd_reg_2 ( .D(data[2]), .CP(n_ck6), .CR(transmit_enable), .Q(txd[2]) );
  FDS2 txd_reg_0 ( .D(data[0]), .CP(n_ck6), .CR(transmit_enable), .Q(txd[0]) );
  FD1 tx_en_reg ( .D(transmit_enable), .CP(n_ck6), .Q(tx_en) );
  FDS2 tx_er_reg ( .D(transmit_enable), .CP(n_ck6), .CR(transmit_error), .Q(
        tx_er) );
endmodule


module ifg_timer_DW01_inc_5_0 ( A, SUM );
  input [4:0] A;
  output [4:0] SUM;
  wire   \A[4] , \A[3] , \A[2] , \A[1] , \A[0] , \SUM[4] , \SUM[3] , \SUM[2] ,
         \SUM[1] , \SUM[0] , \carry[4] , \carry[3] , \carry[2] ;
  assign \A[4]  = A[4];
  assign \A[3]  = A[3];
  assign \A[2]  = A[2];
  assign \A[1]  = A[1];
  assign \A[0]  = A[0];
  assign SUM[4] = \SUM[4] ;
  assign SUM[3] = \SUM[3] ;
  assign SUM[2] = \SUM[2] ;
  assign SUM[1] = \SUM[1] ;
  assign SUM[0] = \SUM[0] ;

  EO U5 ( .A(\carry[4] ), .B(\A[4] ), .Z(\SUM[4] ) );
  HA1 U1_1_2 ( .A(\A[2] ), .B(\carry[2] ), .S(\SUM[2] ), .CO(\carry[3] ) );
  HA1 U1_1_3 ( .A(\A[3] ), .B(\carry[3] ), .S(\SUM[3] ), .CO(\carry[4] ) );
  HA1 U1_1_1 ( .A(\A[1] ), .B(\A[0] ), .S(\SUM[1] ), .CO(\carry[2] ) );
  IVP U6 ( .A(\A[0] ), .Z(\SUM[0] ) );
endmodule


module ifg_timer ( crs, full_duplex, transmit_enable, clk, reset_n, 
        transmit_available_p );
  input crs, full_duplex, transmit_enable, clk, reset_n;
  output transmit_available_p;
  wire   state_ifg, N7, N20, N21, N22, N23, N24, N41, N65, N67, N69, N71, N73,
         N75, N78, N79, n19, n20, n27, n28, n29, n30, n31, n32, n33, n34, n35,
         n36, n37, n38, n39, n40, n41, n42;
  wire   [4:0] count_ifg;

  IVP U_CK1 ( .A(clk), .Z(n_ck1) );
  IVP U_CK2 ( .A(n_ck1), .Z(n_ck2) );
  IVP U_CK3 ( .A(n_ck2), .Z(n_ck3) );
  IVP U_CK4 ( .A(n_ck3), .Z(n_ck4) );
  IVP U_CK5 ( .A(n_ck4), .Z(n_ck5) );
  IVP U_CK6 ( .A(n_ck5), .Z(n_ck6) );

  IVP U3 ( .A(n42), .Z(N79) );
  MUX21L U4 ( .A(n31), .B(n34), .S(full_duplex), .Z(n37) );
  NR2 U5 ( .A(N7), .B(n33), .Z(N78) );
  FDS2L count_ifg_reg_0 ( .D(N67), .CP(n_ck6), .CR(1'b1), .LD(N79), .Q(
        count_ifg[0]), .QN(n27) );
  FDS2L count_ifg_reg_1 ( .D(N69), .CP(n_ck6), .CR(1'b1), .LD(N79), .Q(
        count_ifg[1]) );
  FDS2L count_ifg_reg_3 ( .D(N73), .CP(n_ck6), .CR(1'b1), .LD(N79), .Q(
        count_ifg[3]) );
  AO7 U6 ( .A(n41), .B(n40), .C(reset_n), .Z(n42) );
  MUX21L U7 ( .A(n35), .B(n34), .S(full_duplex), .Z(n36) );
  AO6 U8 ( .A(n19), .B(n32), .C(n40), .Z(n33) );
  MUX21L U9 ( .A(n37), .B(n39), .S(state_ifg), .Z(N65) );
  FDS2L transmit_available_p_reg ( .D(state_ifg), .CP(n_ck6), .CR(1'b1), .LD(N78), .Q(transmit_available_p) );
  ND4 U10 ( .A(count_ifg[3]), .B(count_ifg[2]), .C(count_ifg[1]), .D(
        count_ifg[0]), .Z(n20) );
  IVP U11 ( .A(transmit_enable), .Z(n34) );
  IVP U12 ( .A(n39), .Z(n41) );
  AO7 U13 ( .A(full_duplex), .B(N41), .C(n37), .Z(n32) );
  IVP U14 ( .A(n37), .Z(n38) );
  ND2 U15 ( .A(crs), .B(N41), .Z(n35) );
  FDS2L count_ifg_reg_2 ( .D(N71), .CP(n_ck6), .CR(1'b1), .LD(N79), .Q(
        count_ifg[2]), .QN(n30) );
  FD2 state_ifg_reg ( .D(N65), .CP(n_ck6), .CD(reset_n), .Q(state_ifg), .QN(n40)
         );
  IVP U16 ( .A(crs), .Z(n31) );
  IVP U17 ( .A(reset_n), .Z(N7) );
  NR3 U18 ( .A(n30), .B(n29), .C(n28), .Z(n19) );
  FDS2L count_ifg_reg_4 ( .D(N75), .CP(n_ck6), .CR(1'b1), .LD(N79), .Q(
        count_ifg[4]), .QN(n29) );
  AN2P U19 ( .A(n20), .B(n29), .Z(N41) );
  ifg_timer_DW01_inc_5_0 r92 ( .A({count_ifg[4], count_ifg[3], count_ifg[2], 
        count_ifg[1], count_ifg[0]}), .SUM({N24, N23, N22, N21, N20}) );
  OR3 U26 ( .A(count_ifg[3]), .B(count_ifg[1]), .C(n27), .Z(n28) );
  OR2 U27 ( .A(n19), .B(n36), .Z(n39) );
  MUX21H U28 ( .A(n38), .B(N20), .S(state_ifg), .Z(N67) );
  AN2P U29 ( .A(N21), .B(state_ifg), .Z(N69) );
  AN2P U30 ( .A(N22), .B(state_ifg), .Z(N71) );
  AN2P U31 ( .A(N23), .B(state_ifg), .Z(N73) );
  AN2P U32 ( .A(N24), .B(state_ifg), .Z(N75) );
endmodule


module ifg_err ( crs, full_duplex, transmit_enable, clk, reset_n, 
        transmit_available_p );
  input crs, full_duplex, transmit_enable, clk, reset_n;
  output transmit_available_p;
  wire   state_ifg, N7, N20, N21, N22, N23, N24, N41, N65, N67, N69, N71, N73,
         N75, N78, N79, n19, n20, n27, n28, n29, n30, n31, n32, n33, n34, n35,
         n36, n37, n38, n39, n40, n41, n42;
  wire   [4:0] count_ifg;

  AN2P U_EN ( .A(clk), .B(crs), .Z(n_ck1));
  IVP U_CK1 ( .A(n_ck1), .Z(n_ck2) );
  IVP U_CK2 ( .A(n_ck2), .Z(n_ck3) );
  IVP U_CK3 ( .A(n_ck3), .Z(n_ck4) );
  IVP U_CK4 ( .A(n_ck4), .Z(n_ck5) );
  IVP U_CK5 ( .A(n_ck5), .Z(n_ck6) );

  IVP U3 ( .A(n42), .Z(N79) );
  MUX21L U4 ( .A(n31), .B(n34), .S(full_duplex), .Z(n37) );
  NR2 U5 ( .A(N7), .B(n33), .Z(N78) );
  FDS2L count_ifg_reg_0 ( .D(n_ck6), .CP(), .CR(1'b1), .LD(N79), .Q(
        count_ifg[0]), .QN(n27) );
  FDS2L count_ifg_reg_1 ( .D(n_ck6), .CP(), .CR(1'b1), .LD(N79), .Q(
        count_ifg[1]) );
  FDS2L count_ifg_reg_3 ( .D(n_ck6), .CP(), .CR(1'b1), .LD(N79), .Q(
        count_ifg[3]) );
  AO7 U6 ( .A(n41), .B(n40), .C(reset_n), .Z(n42) );
  MUX21L U7 ( .A(n35), .B(n34), .S(full_duplex), .Z(n36) );
  AO6 U8 ( .A(n19), .B(n32), .C(n40), .Z(n33) );
  MUX21L U9 ( .A(n37), .B(n39), .S(state_ifg), .Z(N65) );
  FDS2L transmit_available_p_reg ( .D(state_ifg), .CP(n_ck6), .CR(1'b1), .LD(N78), .Q(transmit_available_p) );
  ND4 U10 ( .A(count_ifg[3]), .B(count_ifg[2]), .C(count_ifg[1]), .D(
        count_ifg[0]), .Z(n20) );
  IVP U11 ( .A(transmit_enable), .Z(n34) );
  IVP U12 ( .A(n39), .Z(n41) );
  AO7 U13 ( .A(full_duplex), .B(N41), .C(n37), .Z(n32) );
  IVP U14 ( .A(n37), .Z(n38) );
  ND2 U15 ( .A(crs), .B(N41), .Z(n35) );
  FDS2L count_ifg_reg_2 ( .D(N71), .CP(n_ck6), .CR(1'b1), .LD(N79), .Q(
        count_ifg[2]), .QN(n30) );
  FD2 state_ifg_reg ( .D(N65), .CP(n_ck6), .CD(reset_n), .Q(state_ifg), .QN(n40)
         );
  IVP U16 ( .A(crs), .Z(n31) );
  IVP U17 ( .A(reset_n), .Z(N7) );
  NR3 U18 ( .A(n30), .B(n29), .C(n28), .Z(n19) );
  FDS2L count_ifg_reg_4 ( .D(N75), .CP(n_ck6), .CR(1'b1), .LD(N79), .Q(
        count_ifg[4]), .QN(n29) );
  AN2P U19 ( .A(n20), .B(n29), .Z(N41) );
  ifg_timer_DW01_inc_5_0 r92 ( .A({count_ifg[4], count_ifg[3], count_ifg[2], 
        count_ifg[1], count_ifg[0]}), .SUM({N24, N23, N22, N21, N20}) );
  OR3 U26 ( .A(count_ifg[3]), .B(count_ifg[1]), .C(n27), .Z(n28) );
  OR2 U27 ( .A(n19), .B(n36), .Z(n39) );
  MUX21H U28 ( .A(n38), .B(N20), .S(state_ifg), .Z(N67) );
  AN2P U29 ( .A(N21), .B(state_ifg), .Z(N69) );
  AN2P U30 ( .A(N22), .B(state_ifg), .Z(N71) );
  AN2P U31 ( .A(N23), .B(state_ifg), .Z(N73) );
  AN2P U32 ( .A(N24), .B(state_ifg), .Z(N75) );
endmodule


module defer_counter_DW01_inc_13_0 ( A, SUM );
  input [12:0] A;
  output [12:0] SUM;
  wire   \A[12] , \A[11] , \A[10] , \A[9] , \A[8] , \A[7] , \A[6] , \A[5] ,
         \A[4] , \A[3] , \A[2] , \A[1] , \A[0] , \SUM[12] , \SUM[11] ,
         \SUM[10] , \SUM[9] , \SUM[8] , \SUM[7] , \SUM[6] , \SUM[5] , \SUM[4] ,
         \SUM[3] , \SUM[2] , \SUM[1] , \SUM[0] , \carry[12] , \carry[11] ,
         \carry[10] , \carry[9] , \carry[8] , \carry[7] , \carry[6] ,
         \carry[5] , \carry[4] , \carry[3] , \carry[2] ;
  assign \A[12]  = A[12];
  assign \A[11]  = A[11];
  assign \A[10]  = A[10];
  assign \A[9]  = A[9];
  assign \A[8]  = A[8];
  assign \A[7]  = A[7];
  assign \A[6]  = A[6];
  assign \A[5]  = A[5];
  assign \A[4]  = A[4];
  assign \A[3]  = A[3];
  assign \A[2]  = A[2];
  assign \A[1]  = A[1];
  assign \A[0]  = A[0];
  assign SUM[12] = \SUM[12] ;
  assign SUM[11] = \SUM[11] ;
  assign SUM[10] = \SUM[10] ;
  assign SUM[9] = \SUM[9] ;
  assign SUM[8] = \SUM[8] ;
  assign SUM[7] = \SUM[7] ;
  assign SUM[6] = \SUM[6] ;
  assign SUM[5] = \SUM[5] ;
  assign SUM[4] = \SUM[4] ;
  assign SUM[3] = \SUM[3] ;
  assign SUM[2] = \SUM[2] ;
  assign SUM[1] = \SUM[1] ;
  assign SUM[0] = \SUM[0] ;

  HA1 U1_1_8 ( .A(\A[8] ), .B(\carry[8] ), .S(\SUM[8] ), .CO(\carry[9] ) );
  EO U5 ( .A(\carry[12] ), .B(\A[12] ), .Z(\SUM[12] ) );
  HA1 U1_1_10 ( .A(\A[10] ), .B(\carry[10] ), .S(\SUM[10] ), .CO(\carry[11] )
         );
  HA1 U1_1_7 ( .A(\A[7] ), .B(\carry[7] ), .S(\SUM[7] ), .CO(\carry[8] ) );
  HA1 U1_1_5 ( .A(\A[5] ), .B(\carry[5] ), .S(\SUM[5] ), .CO(\carry[6] ) );
  HA1 U1_1_3 ( .A(\A[3] ), .B(\carry[3] ), .S(\SUM[3] ), .CO(\carry[4] ) );
  HA1 U1_1_1 ( .A(\A[1] ), .B(\A[0] ), .S(\SUM[1] ), .CO(\carry[2] ) );
  HA1 U1_1_11 ( .A(\A[11] ), .B(\carry[11] ), .S(\SUM[11] ), .CO(\carry[12] )
         );
  HA1 U1_1_9 ( .A(\A[9] ), .B(\carry[9] ), .S(\SUM[9] ), .CO(\carry[10] ) );
  HA1 U1_1_6 ( .A(\A[6] ), .B(\carry[6] ), .S(\SUM[6] ), .CO(\carry[7] ) );
  HA1 U1_1_4 ( .A(\A[4] ), .B(\carry[4] ), .S(\SUM[4] ), .CO(\carry[5] ) );
  HA1 U1_1_2 ( .A(\A[2] ), .B(\carry[2] ), .S(\SUM[2] ), .CO(\carry[3] ) );
  IVP U6 ( .A(\A[0] ), .Z(\SUM[0] ) );
endmodule


module defer_counter ( transmit_available_p, transmit_new_p, clk, reset_n, 
        excess_deferral );
  input transmit_available_p, transmit_new_p, clk, reset_n;
  output excess_deferral;
  wire   state_defer, N17, N38, N39, N40, N41, N42, N43, N44, N45, N46, N47,
         N48, N49, N50, N52, N54, N56, N58, N60, N62, N64, N66, N68, N70, N72,
         N74, N76, N77, n17, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41,
         n42, n43, n44, n45, n46, n47;
  wire   [12:0] count_defer;
    wire ck2 ;
    wire ck1 ;
    IVP  u_ck2 (.A (ck1 ),.Z (ck2 ));
    IVP  u_ck1 (.A (clk ),.Z (ck1 ));

//   FJK2 state_defer_reg ( .J(transmit_new_p), .K(n46), .CP(clk), .CD(reset_n), 
  FJK2 state_defer_reg ( .J(transmit_new_p), .K(n46), .CP(
//     ), .CD(reset_n), 
    ck2 ), .CD(reset_n), 
        .Q(state_defer) );
//   FDS2L count_defer_reg_0 ( .D(N52), .CP(clk), .CR(1'b1), .LD(n17), .Q(
  FDS2L count_defer_reg_0 ( .D(N52), .CP(ck2 ), .CR(1'b1), .LD(n17), .Q(
        count_defer[0]) );
  IVP U3 ( .A(n46), .Z(n44) );
  IVP U4 ( .A(transmit_new_p), .Z(n47) );
//   FJK2S excess_deferral_reg ( .J(1'b0), .K(1'b0), .CP(clk), .CD(reset_n), .TI(
  FJK2S excess_deferral_reg ( .J(1'b0), .K(1'b0), .CP(
//     ), .CD(reset_n), .TI(
    ck2 ), .CD(reset_n), .TI(
        state_defer), .TE(N77), .Q(excess_deferral) );
//   FDS2L count_defer_reg_1 ( .D(N54), .CP(clk), .CR(1'b1), .LD(n17), .Q(
  FDS2L count_defer_reg_1 ( .D(N54), .CP(ck2 ), .CR(1'b1), .LD(n17), .Q(
        count_defer[1]) );
//   FDS2L count_defer_reg_2 ( .D(N56), .CP(clk), .CR(1'b1), .LD(n17), .Q(
  FDS2L count_defer_reg_2 ( .D(N56), .CP(ck2 ), .CR(1'b1), .LD(n17), .Q(
        count_defer[2]) );
//   FDS2L count_defer_reg_3 ( .D(N58), .CP(clk), .CR(1'b1), .LD(n17), .Q(
  FDS2L count_defer_reg_3 ( .D(N58), .CP(ck2 ), .CR(1'b1), .LD(n17), .Q(
        count_defer[3]), .QN(n41) );
//   FDS2L count_defer_reg_4 ( .D(N60), .CP(clk), .CR(1'b1), .LD(n17), .Q(
  FDS2L count_defer_reg_4 ( .D(N60), .CP(ck2 ), .CR(1'b1), .LD(n17), .Q(
        count_defer[4]) );
//   FDS2L count_defer_reg_8 ( .D(N68), .CP(clk), .CR(1'b1), .LD(n17), .Q(
  FDS2L count_defer_reg_8 ( .D(N68), .CP(ck2 ), .CR(1'b1), .LD(n17), .Q(
        count_defer[8]), .QN(n37) );
//   FDS2L count_defer_reg_12 ( .D(N76), .CP(clk), .CR(1'b1), .LD(n17), .Q(
  FDS2L count_defer_reg_12 ( .D(N76), .CP(
//     ), .CR(1'b1), .LD(n17), .Q(
    ck2 ), .CR(1'b1), .LD(n17), .Q(
        count_defer[12]), .QN(n34) );
//   FDS2L count_defer_reg_9 ( .D(N70), .CP(clk), .CR(1'b1), .LD(n17), .Q(
  FDS2L count_defer_reg_9 ( .D(N70), .CP(ck2 ), .CR(1'b1), .LD(n17), .Q(
        count_defer[9]), .QN(n33) );
//   FDS2L count_defer_reg_5 ( .D(N62), .CP(clk), .CR(1'b1), .LD(n17), .Q(
  FDS2L count_defer_reg_5 ( .D(N62), .CP(ck2 ), .CR(1'b1), .LD(n17), .Q(
        count_defer[5]), .QN(n36) );
//   FDS2L count_defer_reg_7 ( .D(N66), .CP(clk), .CR(1'b1), .LD(n17), .Q(
  FDS2L count_defer_reg_7 ( .D(N66), .CP(ck2 ), .CR(1'b1), .LD(n17), .Q(
        count_defer[7]), .QN(n35) );
//   FDS2L count_defer_reg_10 ( .D(N72), .CP(clk), .CR(1'b1), .LD(n17), .Q(
  FDS2L count_defer_reg_10 ( .D(N72), .CP(
//     ), .CR(1'b1), .LD(n17), .Q(
    ck2 ), .CR(1'b1), .LD(n17), .Q(
        count_defer[10]), .QN(n32) );
  IVP U5 ( .A(n42), .Z(n43) );
  MUX21L U6 ( .A(n47), .B(n44), .S(state_defer), .Z(n45) );
//   FDS2L count_defer_reg_6 ( .D(N64), .CP(clk), .CR(1'b1), .LD(n17), .Q(
  FDS2L count_defer_reg_6 ( .D(N64), .CP(ck2 ), .CR(1'b1), .LD(n17), .Q(
        count_defer[6]), .QN(n40) );
//   FDS2L count_defer_reg_11 ( .D(N74), .CP(clk), .CR(1'b1), .LD(n17), .Q(
  FDS2L count_defer_reg_11 ( .D(N74), .CP(
//     ), .CR(1'b1), .LD(n17), .Q(
    ck2 ), .CR(1'b1), .LD(n17), .Q(
        count_defer[11]), .QN(n39) );
  MUX21L U7 ( .A(n47), .B(n42), .S(state_defer), .Z(N77) );
  IVP U8 ( .A(reset_n), .Z(N17) );
  NR2 U9 ( .A(N17), .B(n45), .Z(n17) );
  defer_counter_DW01_inc_13_0 add_76 ( .A({count_defer[12], count_defer[11], 
        count_defer[10], count_defer[9], count_defer[8], count_defer[7], 
        count_defer[6], count_defer[5], count_defer[4], count_defer[3], 
        count_defer[2], count_defer[1], count_defer[0]}), .SUM({N50, N49, N48, 
        N47, N46, N45, N44, N43, N42, N41, N40, N39, N38}) );
  NR6P U24 ( .A(n37), .B(n36), .C(n35), .D(n34), .E(n33), .F(n32), .Z(n38) );
  ND8 U25 ( .A(count_defer[0]), .B(n41), .C(n40), .D(n39), .E(count_defer[2]), 
        .F(count_defer[1]), .G(count_defer[4]), .H(n38), .Z(n42) );
  AN2P U26 ( .A(N38), .B(state_defer), .Z(N52) );
  OR2 U27 ( .A(transmit_available_p), .B(n43), .Z(n46) );
  AN2P U28 ( .A(N39), .B(state_defer), .Z(N54) );
  AN2P U29 ( .A(N40), .B(state_defer), .Z(N56) );
  AN2P U30 ( .A(N41), .B(state_defer), .Z(N58) );
  AN2P U31 ( .A(N42), .B(state_defer), .Z(N60) );
  AN2P U32 ( .A(N43), .B(state_defer), .Z(N62) );
  AN2P U33 ( .A(N44), .B(state_defer), .Z(N64) );
  AN2P U34 ( .A(N45), .B(state_defer), .Z(N66) );
  AN2P U35 ( .A(N46), .B(state_defer), .Z(N68) );
  AN2P U36 ( .A(N47), .B(state_defer), .Z(N70) );
  AN2P U37 ( .A(N48), .B(state_defer), .Z(N72) );
  AN2P U38 ( .A(N49), .B(state_defer), .Z(N74) );
  AN2P U39 ( .A(N50), .B(state_defer), .Z(N76) );
endmodule


module frame_length_counter_DW01_inc_12_0 ( A, SUM );
  input [11:0] A;
  output [11:0] SUM;
  wire   \A[11] , \A[10] , \A[9] , \A[8] , \A[7] , \A[6] , \A[5] , \A[4] ,
         \A[3] , \A[2] , \A[1] , \A[0] , \SUM[11] , \SUM[10] , \SUM[9] ,
         \SUM[8] , \SUM[7] , \SUM[6] , \SUM[5] , \SUM[4] , \SUM[3] , \SUM[2] ,
         \SUM[1] , \SUM[0] , \carry[11] , \carry[10] , \carry[9] , \carry[8] ,
         \carry[7] , \carry[6] , \carry[5] , \carry[4] , \carry[3] ,
         \carry[2] ;
  assign \A[11]  = A[11];
  assign \A[10]  = A[10];
  assign \A[9]  = A[9];
  assign \A[8]  = A[8];
  assign \A[7]  = A[7];
  assign \A[6]  = A[6];
  assign \A[5]  = A[5];
  assign \A[4]  = A[4];
  assign \A[3]  = A[3];
  assign \A[2]  = A[2];
  assign \A[1]  = A[1];
  assign \A[0]  = A[0];
  assign SUM[11] = \SUM[11] ;
  assign SUM[10] = \SUM[10] ;
  assign SUM[9] = \SUM[9] ;
  assign SUM[8] = \SUM[8] ;
  assign SUM[7] = \SUM[7] ;
  assign SUM[6] = \SUM[6] ;
  assign SUM[5] = \SUM[5] ;
  assign SUM[4] = \SUM[4] ;
  assign SUM[3] = \SUM[3] ;
  assign SUM[2] = \SUM[2] ;
  assign SUM[1] = \SUM[1] ;
  assign SUM[0] = \SUM[0] ;

  HA1 U1_1_2 ( .A(\A[2] ), .B(\carry[2] ), .S(\SUM[2] ), .CO(\carry[3] ) );
  HA1 U1_1_5 ( .A(\A[5] ), .B(\carry[5] ), .S(\SUM[5] ), .CO(\carry[6] ) );
  HA1 U1_1_3 ( .A(\A[3] ), .B(\carry[3] ), .S(\SUM[3] ), .CO(\carry[4] ) );
  EO U5 ( .A(\carry[11] ), .B(\A[11] ), .Z(\SUM[11] ) );
  HA1 U1_1_9 ( .A(\A[9] ), .B(\carry[9] ), .S(\SUM[9] ), .CO(\carry[10] ) );
  HA1 U1_1_7 ( .A(\A[7] ), .B(\carry[7] ), .S(\SUM[7] ), .CO(\carry[8] ) );
  HA1 U1_1_10 ( .A(\A[10] ), .B(\carry[10] ), .S(\SUM[10] ), .CO(\carry[11] )
         );
  HA1 U1_1_8 ( .A(\A[8] ), .B(\carry[8] ), .S(\SUM[8] ), .CO(\carry[9] ) );
  HA1 U1_1_6 ( .A(\A[6] ), .B(\carry[6] ), .S(\SUM[6] ), .CO(\carry[7] ) );
  HA1 U1_1_1 ( .A(\A[1] ), .B(\A[0] ), .S(\SUM[1] ), .CO(\carry[2] ) );
  HA1 U1_1_4 ( .A(\A[4] ), .B(\carry[4] ), .S(\SUM[4] ), .CO(\carry[5] ) );
  IVP U6 ( .A(\A[0] ), .Z(\SUM[0] ) );
endmodule


module frame_length_counter ( transmit_enable, transmit_fcs, clk, reset_n, 
        count_length, count_fcs, excessive_length, transmit_64byte );
  output [11:0] count_length;
  output [3:0] count_fcs;
  input transmit_enable, transmit_fcs, clk, reset_n;
  output excessive_length, transmit_64byte;
  wire   N34, N35, N36, N37, N38, N39, N40, N41, N42, N43, N44, N45, N47, N48,
         N49, N50, N67, N69, N71, N73, N75, N77, N79, N81, N83, N85, N87, N89,
         N91, N92, N93, N94, N95, N138, n28, n29, n30, n31, n32, n33, n34, n35,
         n36, n37, n38, n39, n40, n59, n60, n61, n62, n63, n64, n65, n66, n67,
         n68, n69, n70, n71, n72, n73, n74, n75;
  wire   [1:0] state_length;
// Novas ECO updated by milky Nov 7, 2005  14:40 
    wire ck2 ;
// Novas ECO updated by milky Nov 7, 2005  14:40 
    wire ck1 ;
// Novas ECO updated by milky Nov 7, 2005  14:40 
    IVP  u_ck2 (.A (ck1 ),.Z (ck2 ));
// Novas ECO updated by milky Nov 7, 2005  14:40 
    IVP  u_ck1 (.A (clk ),.Z (ck1 ));

  NR2 U3 ( .A(n60), .B(n59), .Z(n61) );
// Novas ECO updated by milky Nov 7, 2005  14:40 
//   FJK2S count_fcs_reg_0 ( .J(1'b0), .K(1'b0), .CP(clk), .CD(reset_n), .TI(N92), 
  FJK2S count_fcs_reg_0 ( .J(1'b0), .K(1'b0), .CP(
// Novas ECO updated by milky Nov 7, 2005  14:40 
//     ), .CD(reset_n), .TI(N92), 
    ck2 ), .CD(reset_n), .TI(N92), 
        .TE(N91), .Q(count_fcs[0]), .QN(N47) );
  AO7 U4 ( .A(n72), .B(n71), .C(n70), .Z(N91) );
  AO6 U5 ( .A(n31), .B(n40), .C(n32), .Z(excessive_length) );
  ND2 U6 ( .A(n74), .B(n71), .Z(n66) );
  ND2 U7 ( .A(count_fcs[1]), .B(count_fcs[0]), .Z(n60) );
// Novas ECO updated by milky Nov 7, 2005  14:40 
//   FJK2S count_length_reg_0 ( .J(1'b0), .K(1'b0), .CP(clk), .CD(reset_n), .TI(
  FJK2S count_length_reg_0 ( .J(1'b0), .K(1'b0), .CP(
// Novas ECO updated by milky Nov 7, 2005  14:40 
//     ), .CD(reset_n), .TI(
    ck2 ), .CD(reset_n), .TI(
        N67), .TE(n28), .Q(count_length[0]) );
// Novas ECO updated by milky Nov 7, 2005  14:40 
//   FJK2S count_length_reg_1 ( .J(1'b0), .K(1'b0), .CP(clk), .CD(reset_n), .TI(
  FJK2S count_length_reg_1 ( .J(1'b0), .K(1'b0), .CP(
// Novas ECO updated by milky Nov 7, 2005  14:40 
//     ), .CD(reset_n), .TI(
    ck2 ), .CD(reset_n), .TI(
        N69), .TE(n28), .Q(count_length[1]) );
  ND3 U8 ( .A(n69), .B(transmit_fcs), .C(transmit_enable), .Z(n70) );
// Novas ECO updated by milky Nov 7, 2005  14:40 
//   FJK2S count_length_reg_2 ( .J(1'b0), .K(1'b0), .CP(clk), .CD(reset_n), .TI(
  FJK2S count_length_reg_2 ( .J(1'b0), .K(1'b0), .CP(
// Novas ECO updated by milky Nov 7, 2005  14:40 
//     ), .CD(reset_n), .TI(
    ck2 ), .CD(reset_n), .TI(
        N71), .TE(n28), .Q(count_length[2]) );
// Novas ECO updated by milky Nov 7, 2005  14:40 
//   FJK2S count_length_reg_3 ( .J(1'b0), .K(1'b0), .CP(clk), .CD(reset_n), .TI(
  FJK2S count_length_reg_3 ( .J(1'b0), .K(1'b0), .CP(
// Novas ECO updated by milky Nov 7, 2005  14:40 
//     ), .CD(reset_n), .TI(
    ck2 ), .CD(reset_n), .TI(
        N73), .TE(n28), .Q(count_length[3]) );
// Novas ECO updated by milky Nov 7, 2005  14:40 
//   FJK2S count_length_reg_5 ( .J(1'b0), .K(1'b0), .CP(clk), .CD(reset_n), .TI(
  FJK2S count_length_reg_5 ( .J(1'b0), .K(1'b0), .CP(
// Novas ECO updated by milky Nov 7, 2005  14:40 
//     ), .CD(reset_n), .TI(
    ck2 ), .CD(reset_n), .TI(
        N77), .TE(n28), .Q(count_length[5]) );
// Novas ECO updated by milky Nov 7, 2005  14:40 
//   FJK2S count_length_reg_6 ( .J(1'b0), .K(1'b0), .CP(clk), .CD(reset_n), .TI(
  FJK2S count_length_reg_6 ( .J(1'b0), .K(1'b0), .CP(
// Novas ECO updated by milky Nov 7, 2005  14:40 
//     ), .CD(reset_n), .TI(
    ck2 ), .CD(reset_n), .TI(
        N79), .TE(n28), .Q(count_length[6]) );
  ND2 U9 ( .A(n29), .B(n36), .Z(n37) );
  ND2 U10 ( .A(state_length[0]), .B(n62), .Z(n74) );
  ND2 U11 ( .A(state_length[1]), .B(state_length[0]), .Z(n71) );
// Novas ECO updated by milky Nov 7, 2005  14:40 
//   FJK2S count_fcs_reg_3 ( .J(1'b0), .K(1'b0), .CP(clk), .CD(reset_n), .TI(N95), 
  FJK2S count_fcs_reg_3 ( .J(1'b0), .K(1'b0), .CP(
// Novas ECO updated by milky Nov 7, 2005  14:40 
//     ), .CD(reset_n), .TI(N95), 
    ck2 ), .CD(reset_n), .TI(N95), 
        .TE(N91), .Q(count_fcs[3]) );
  ND2 U12 ( .A(n68), .B(n67), .Z(N138) );
// Novas ECO updated by milky Nov 7, 2005  14:40 
//   FJK2S count_fcs_reg_2 ( .J(1'b0), .K(1'b0), .CP(clk), .CD(reset_n), .TI(N94), 
  FJK2S count_fcs_reg_2 ( .J(1'b0), .K(1'b0), .CP(
// Novas ECO updated by milky Nov 7, 2005  14:40 
//     ), .CD(reset_n), .TI(N94), 
    ck2 ), .CD(reset_n), .TI(N94), 
        .TE(N91), .Q(count_fcs[2]), .QN(n59) );
// Novas ECO updated by milky Nov 7, 2005  14:40 
//   FJK2S count_fcs_reg_1 ( .J(1'b0), .K(1'b0), .CP(clk), .CD(reset_n), .TI(N93), 
  FJK2S count_fcs_reg_1 ( .J(1'b0), .K(1'b0), .CP(
// Novas ECO updated by milky Nov 7, 2005  14:40 
//     ), .CD(reset_n), .TI(N93), 
    ck2 ), .CD(reset_n), .TI(N93), 
        .TE(N91), .Q(count_fcs[1]) );
  ND2 U13 ( .A(N34), .B(n66), .Z(n63) );
  AO3 U14 ( .A(n35), .B(n30), .C(n34), .D(n33), .Z(transmit_64byte) );
  ND2 U15 ( .A(N47), .B(n75), .Z(n73) );
  IVP U16 ( .A(transmit_enable), .Z(n72) );
  ND4 U17 ( .A(n39), .B(count_length[9]), .C(n38), .D(n37), .Z(n40) );
  ND2 U18 ( .A(count_length[3]), .B(count_length[2]), .Z(n36) );
// Novas ECO updated by milky Nov 7, 2005  14:40 
//   FJK2S state_length_reg_0 ( .J(1'b0), .K(1'b0), .CP(clk), .CD(reset_n), .TI(
  FJK2S state_length_reg_0 ( .J(1'b0), .K(1'b0), .CP(
// Novas ECO updated by milky Nov 7, 2005  14:40 
//     ), .CD(reset_n), .TI(
    ck2 ), .CD(reset_n), .TI(
        n28), .TE(N138), .Q(state_length[0]) );
  IVP U19 ( .A(n67), .Z(n64) );
// Novas ECO updated by milky Nov 7, 2005  14:40 
//   FJK2S state_length_reg_1 ( .J(1'b0), .K(1'b0), .CP(clk), .CD(reset_n), .TI(
  FJK2S state_length_reg_1 ( .J(1'b0), .K(1'b0), .CP(
// Novas ECO updated by milky Nov 7, 2005  14:40 
//     ), .CD(reset_n), .TI(
    ck2 ), .CD(reset_n), .TI(
        N91), .TE(N138), .Q(state_length[1]), .QN(n62) );
  IVP U20 ( .A(n74), .Z(n69) );
  IVP U21 ( .A(n71), .Z(n75) );
  IVP U22 ( .A(n66), .Z(n68) );
  EO U23 ( .A(count_fcs[3]), .B(n61), .Z(N50) );
  ND2 U24 ( .A(n67), .B(n63), .Z(N67) );
  EO U25 ( .A(n60), .B(n59), .Z(N49) );
  NR3 U26 ( .A(count_length[4]), .B(count_length[6]), .C(count_length[5]), .Z(
        n35) );
  NR2 U27 ( .A(count_length[11]), .B(count_length[10]), .Z(n34) );
  NR2 U28 ( .A(count_length[9]), .B(count_length[8]), .Z(n33) );
  EO U29 ( .A(count_fcs[1]), .B(count_fcs[0]), .Z(N48) );
  ND2 U30 ( .A(n74), .B(n73), .Z(N92) );
  AN2 U31 ( .A(transmit_enable), .B(n65), .Z(n28) );
// Novas ECO updated by milky Nov 7, 2005  14:40 
//   FJK2S count_length_reg_4 ( .J(1'b0), .K(1'b0), .CP(clk), .CD(reset_n), .TI(
  FJK2S count_length_reg_4 ( .J(1'b0), .K(1'b0), .CP(
// Novas ECO updated by milky Nov 7, 2005  14:40 
//     ), .CD(reset_n), .TI(
    ck2 ), .CD(reset_n), .TI(
        N75), .TE(n28), .Q(count_length[4]), .QN(n29) );
// Novas ECO updated by milky Nov 7, 2005  14:40 
//   FJK2S count_length_reg_7 ( .J(1'b0), .K(1'b0), .CP(clk), .CD(reset_n), .TI(
  FJK2S count_length_reg_7 ( .J(1'b0), .K(1'b0), .CP(
// Novas ECO updated by milky Nov 7, 2005  14:40 
//     ), .CD(reset_n), .TI(
    ck2 ), .CD(reset_n), .TI(
        N81), .TE(n28), .Q(count_length[7]), .QN(n30) );
// Novas ECO updated by milky Nov 7, 2005  14:40 
//   FJK2S count_length_reg_8 ( .J(1'b0), .K(1'b0), .CP(clk), .CD(reset_n), .TI(
  FJK2S count_length_reg_8 ( .J(1'b0), .K(1'b0), .CP(
// Novas ECO updated by milky Nov 7, 2005  14:40 
//     ), .CD(reset_n), .TI(
    ck2 ), .CD(reset_n), .TI(
        N83), .TE(n28), .Q(count_length[8]) );
// Novas ECO updated by milky Nov 7, 2005  14:40 
//   FJK2S count_length_reg_9 ( .J(1'b0), .K(1'b0), .CP(clk), .CD(reset_n), .TI(
  FJK2S count_length_reg_9 ( .J(1'b0), .K(1'b0), .CP(
// Novas ECO updated by milky Nov 7, 2005  14:40 
//     ), .CD(reset_n), .TI(
    ck2 ), .CD(reset_n), .TI(
        N85), .TE(n28), .Q(count_length[9]) );
// Novas ECO updated by milky Nov 7, 2005  14:40 
//   FJK2S count_length_reg_10 ( .J(1'b0), .K(1'b0), .CP(clk), .CD(reset_n), .TI(
  FJK2S count_length_reg_10 ( .J(1'b0), .K(1'b0), .CP(
// Novas ECO updated by milky Nov 7, 2005  14:40 
//     ), .CD(reset_n), .TI(
    ck2 ), .CD(reset_n), .TI(
        N87), .TE(n28), .Q(count_length[10]), .QN(n31) );
// Novas ECO updated by milky Nov 7, 2005  14:40 
//   FJK2S count_length_reg_11 ( .J(1'b0), .K(1'b0), .CP(clk), .CD(reset_n), .TI(
  FJK2S count_length_reg_11 ( .J(1'b0), .K(1'b0), .CP(
// Novas ECO updated by milky Nov 7, 2005  14:40 
//     ), .CD(reset_n), .TI(
    ck2 ), .CD(reset_n), .TI(
        N89), .TE(n28), .Q(count_length[11]), .QN(n32) );
  AN2P U32 ( .A(count_length[8]), .B(count_length[7]), .Z(n39) );
  AN2P U33 ( .A(count_length[5]), .B(count_length[6]), .Z(n38) );
  frame_length_counter_DW01_inc_12_0 r119 ( .A({count_length[11], 
        count_length[10], count_length[9], count_length[8], count_length[7], 
        count_length[6], count_length[5], count_length[4], count_length[3], 
        count_length[2], count_length[1], count_length[0]}), .SUM({N45, N44, 
        N43, N42, N41, N40, N39, N38, N37, N36, N35, N34}) );
  OR2 U52 ( .A(state_length[1]), .B(state_length[0]), .Z(n67) );
  OR3 U53 ( .A(n64), .B(n75), .C(n69), .Z(n65) );
  AN2P U54 ( .A(N35), .B(n66), .Z(N69) );
  AN2P U55 ( .A(N36), .B(n66), .Z(N71) );
  AN2P U56 ( .A(N37), .B(n66), .Z(N73) );
  AN2P U57 ( .A(N38), .B(n66), .Z(N75) );
  AN2P U58 ( .A(N39), .B(n66), .Z(N77) );
  AN2P U59 ( .A(N40), .B(n66), .Z(N79) );
  AN2P U60 ( .A(N41), .B(n66), .Z(N81) );
  AN2P U61 ( .A(N42), .B(n66), .Z(N83) );
  AN2P U62 ( .A(N43), .B(n66), .Z(N85) );
  AN2P U63 ( .A(N44), .B(n66), .Z(N87) );
  AN2P U64 ( .A(N45), .B(n66), .Z(N89) );
  AN2P U65 ( .A(N48), .B(n75), .Z(N93) );
  AN2P U66 ( .A(N49), .B(n75), .Z(N94) );
  AN2P U67 ( .A(N50), .B(n75), .Z(N95) );
endmodule


module coll_counter ( transmit_new_p, transmit_enable, transmit_preamble, 
        transmit_sfd, transmit_64byte, clk, reset_n, coll, full_duplex, 
        coll_event_p, late_coll, excessive_coll, coll_attempt );
  output [3:0] coll_attempt;
  input transmit_new_p, transmit_enable, transmit_preamble, transmit_sfd,
         transmit_64byte, clk, reset_n, coll, full_duplex;
  output coll_event_p, late_coll, excessive_coll;
  wire   N54, N60, N61, N70, N72, N74, N76, N78, N80, N83, N87, N106, N107,
         N108, N109, n10, n14, n15, n20, n21, n22, n23, n24, n25, n26, n27, n28,
         n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42,
         n43, n44, n45, n46, n47, n48, n49, n50, n51, n52, n53, n54;
  wire   [1:0] state_coll;
  assign N54 = transmit_64byte;

  IVP U1 ( .A(clk), .Z(n14) );
  IVP U2 ( .A(n14), .Z(n15) );
  ND2 U3 ( .A(excessive_coll), .B(N78), .Z(n34) );
  AO7 U4 ( .A(n51), .B(n50), .C(n49), .Z(N61) );
  IVP U5 ( .A(n37), .Z(n27) );
  AO7 U6 ( .A(n29), .B(n43), .C(reset_n), .Z(n30) );
  AO3 U7 ( .A(n40), .B(n47), .C(n39), .D(n52), .Z(N60) );
  IVP U8 ( .A(n28), .Z(N78) );
  AO7 U9 ( .A(full_duplex), .B(n53), .C(n52), .Z(n54) );
  ND2 U10 ( .A(n27), .B(n36), .Z(n46) );
  IVP U11 ( .A(n30), .Z(N83) );
  AO2 U12 ( .A(n37), .B(n36), .C(n35), .D(n48), .Z(n40) );
  ND2 U13 ( .A(state_coll[0]), .B(n25), .Z(n47) );
  NR2 U14 ( .A(n21), .B(n20), .Z(n22) );
  ND2 U15 ( .A(N109), .B(N78), .Z(n33) );
  ND2 U16 ( .A(n34), .B(n32), .Z(N74) );
  ND2 U17 ( .A(n34), .B(n26), .Z(N70) );
  ND2 U18 ( .A(n41), .B(n44), .Z(n28) );
  ND2 U19 ( .A(state_coll[1]), .B(n38), .Z(n50) );
  EO U20 ( .A(n21), .B(n20), .Z(N108) );
  ND2 U21 ( .A(N107), .B(N78), .Z(n31) );
  FDS2L coll_event_p_reg ( .D(N78), .CP(n15), .CR(1'b1), .LD(N87), .Q(
        coll_event_p) );
  IVP U22 ( .A(N61), .Z(n53) );
  ND2 U23 ( .A(transmit_enable), .B(coll), .Z(n37) );
  NR3 U24 ( .A(n46), .B(n48), .C(n28), .Z(n29) );
  IVP U25 ( .A(n46), .Z(n35) );
  IVP U26 ( .A(transmit_enable), .Z(n51) );
  IVP U27 ( .A(transmit_new_p), .Z(n36) );
  FJK2S state_coll_reg_1 ( .J(1'b0), .K(1'b0), .CP(n15), .CD(reset_n), .TI(N61), .TE(n10), .Q(state_coll[1]), .QN(n25) );
  EO U28 ( .A(coll_attempt[3]), .B(n22), .Z(N109) );
  ND2 U29 ( .A(n34), .B(n33), .Z(N76) );
  ND2 U30 ( .A(coll_attempt[1]), .B(coll_attempt[0]), .Z(n21) );
  FJK2S state_coll_reg_0 ( .J(1'b0), .K(1'b0), .CP(n15), .CD(reset_n), .TI(N60), .TE(n10), .Q(state_coll[0]), .QN(n38) );
  ND2 U31 ( .A(n34), .B(n31), .Z(N72) );
  IVP U32 ( .A(n52), .Z(n43) );
  IVP U33 ( .A(n47), .Z(n41) );
  IVP U34 ( .A(n50), .Z(n42) );
  ND2 U35 ( .A(N108), .B(N78), .Z(n32) );
  ND2 U36 ( .A(N106), .B(N78), .Z(n26) );
  EO U37 ( .A(coll_attempt[1]), .B(coll_attempt[0]), .Z(N107) );
  FDS2L late_coll_reg ( .D(N80), .CP(n15), .CR(1'b1), .LD(N83), .Q(late_coll)
         );
  IVP U38 ( .A(full_duplex), .Z(n44) );
  AN2 U39 ( .A(n45), .B(n44), .Z(n10) );
  FDS2L coll_attempt_reg_1 ( .D(N72), .CP(n15), .CR(1'b1), .LD(N83), .Q(
        coll_attempt[1]), .QN(n23) );
  FDS2L coll_attempt_reg_0 ( .D(N70), .CP(n15), .CR(1'b1), .LD(N83), .Q(
        coll_attempt[0]), .QN(N106) );
  FDS2L coll_attempt_reg_2 ( .D(N74), .CP(n15), .CR(1'b1), .LD(N83), .Q(
        coll_attempt[2]), .QN(n20) );
  NR4 U40 ( .A(n20), .B(n24), .C(N106), .D(n23), .Z(excessive_coll) );
  FDS2L coll_attempt_reg_3 ( .D(N76), .CP(n15), .CR(1'b1), .LD(N83), .Q(
        coll_attempt[3]), .QN(n24) );
  OR2 U49 ( .A(transmit_sfd), .B(transmit_preamble), .Z(n48) );
  OR2 U50 ( .A(state_coll[1]), .B(state_coll[0]), .Z(n52) );
  OR2 U51 ( .A(transmit_enable), .B(n50), .Z(n39) );
  OR3 U52 ( .A(n43), .B(n42), .C(n41), .Z(n45) );
  OR3 U53 ( .A(n48), .B(n47), .C(n46), .Z(n49) );
  AN2P U54 ( .A(N54), .B(N78), .Z(N80) );
  AN2P U55 ( .A(n54), .B(reset_n), .Z(N87) );
endmodule


module dff_tx_0 ( d, clk, reset_n, q );
  input d, clk, reset_n;
  output q;


  FD2 q_reg ( .D(d), .CP(clk), .CD(reset_n), .Q(q) );
endmodule


module dff_tx_1 ( d, clk, reset_n, q );
  input d, clk, reset_n;
  output q;


  FD2 q_reg ( .D(d), .CP(clk), .CD(reset_n), .Q(q) );
endmodule


module dff_tx_2 ( d, clk, reset_n, q );
  input d, clk, reset_n;
  output q;


  FD2 q_reg ( .D(d), .CP(clk), .CD(reset_n), .Q(q) );
endmodule


module dff_tx_3 ( d, clk, reset_n, q );
  input d, clk, reset_n;
  output q;


  FD2 q_reg ( .D(d), .CP(clk), .CD(reset_n), .Q(q) );
endmodule


module dff_tx_4 ( d, clk, reset_n, q );
  input d, clk, reset_n;
  output q;


  FD2 q_reg ( .D(d), .CP(clk), .CD(reset_n), .Q(q) );
endmodule


module dff_tx_5 ( d, clk, reset_n, q );
  input d, clk, reset_n;
  output q;


  FD2 q_reg ( .D(d), .CP(clk), .CD(reset_n), .Q(q) );
endmodule


module dff_tx_6 ( d, clk, reset_n, q );
  input d, clk, reset_n;
  output q;


  FD2 q_reg ( .D(d), .CP(clk), .CD(reset_n), .Q(q) );
endmodule


module dff_tx_7 ( d, clk, reset_n, q );
  input d, clk, reset_n;
  output q;


  FD2 q_reg ( .D(d), .CP(clk), .CD(reset_n), .Q(q) );
endmodule


module dff_tx_8 ( d, clk, reset_n, q );
  input d, clk, reset_n;
  output q;


  FD2 q_reg ( .D(d), .CP(clk), .CD(reset_n), .Q(q) );
endmodule


module dff_tx_9 ( d, clk, reset_n, q );
  input d, clk, reset_n;
  output q;


  FD2 q_reg ( .D(d), .CP(clk), .CD(reset_n), .Q(q) );
endmodule


module random_number_gen ( coll_attempt, clk, reset_n, random );
  input [3:0] coll_attempt;
  output [9:0] random;
  input clk, reset_n;
  wire   feedback, N11, N13, N15, N17, N19, N21, N23, N25, N27, N29, n40, n41, n42, n43,
         n44, n45, n46, n47, n48, n49, n50, n51, n52, n53;
  wire   [9:0] x;
  assign N25 = coll_attempt[3];

  dff_tx_9 u0 ( .d(feedback), .clk(n41), .reset_n(reset_n), .q(x[0]) );
  dff_tx_8 u1 ( .d(x[0]), .clk(n41), .reset_n(reset_n), .q(x[1]) );
  dff_tx_7 u2 ( .d(x[1]), .clk(n41), .reset_n(reset_n), .q(x[2]) );
  dff_tx_6 u3 ( .d(x[2]), .clk(n41), .reset_n(reset_n), .q(x[3]) );
  dff_tx_5 u4 ( .d(x[3]), .clk(n41), .reset_n(reset_n), .q(x[4]) );
  dff_tx_4 u5 ( .d(x[4]), .clk(n41), .reset_n(reset_n), .q(x[5]) );
  dff_tx_3 u6 ( .d(x[5]), .clk(n41), .reset_n(reset_n), .q(x[6]) );
  dff_tx_2 u7 ( .d(x[6]), .clk(n41), .reset_n(reset_n), .q(x[7]) );
  dff_tx_1 u8 ( .d(x[7]), .clk(n41), .reset_n(reset_n), .q(x[8]) );
  dff_tx_0 u9 ( .d(x[8]), .clk(n41), .reset_n(reset_n), .q(x[9]) );
  IVP U1 ( .A(clk), .Z(n40) );
  IVP U2 ( .A(n40), .Z(n41) );
  ND2 U3 ( .A(n44), .B(n42), .Z(N13) );
  ND4 U4 ( .A(n43), .B(n42), .C(n45), .D(n46), .Z(N11) );
  NR2 U5 ( .A(N25), .B(coll_attempt[2]), .Z(n44) );
  AO3 U6 ( .A(n43), .B(n42), .C(n50), .D(n46), .Z(N15) );
  ND2 U7 ( .A(n46), .B(n47), .Z(N19) );
  ND2 U8 ( .A(n46), .B(n48), .Z(N21) );
  AO7 U9 ( .A(n50), .B(n49), .C(n46), .Z(N23) );
  NR2 U10 ( .A(coll_attempt[2]), .B(coll_attempt[1]), .Z(n51) );
  NR2 U11 ( .A(coll_attempt[1]), .B(coll_attempt[2]), .Z(n52) );
  EO U12 ( .A(x[2]), .B(n53), .Z(feedback) );
  ND2 U13 ( .A(n46), .B(n45), .Z(N17) );
  AO7 U14 ( .A(coll_attempt[0]), .B(coll_attempt[1]), .C(coll_attempt[2]), .Z(
        n47) );
  ND2 U15 ( .A(coll_attempt[2]), .B(coll_attempt[1]), .Z(n48) );
  ND2 U16 ( .A(coll_attempt[1]), .B(coll_attempt[0]), .Z(n49) );
  AO6 U17 ( .A(n51), .B(n43), .C(n46), .Z(N27) );
  NR2 U18 ( .A(n52), .B(n46), .Z(N29) );
  IVP U19 ( .A(x[9]), .Z(n53) );
  IVP U20 ( .A(coll_attempt[1]), .Z(n42) );
  IVP U21 ( .A(coll_attempt[0]), .Z(n43) );
  IVP U22 ( .A(coll_attempt[2]), .Z(n50) );
  IVP U23 ( .A(coll_attempt[2]), .Z(n45) );
  IVP U24 ( .A(N25), .Z(n46) );
  AN2P U25 ( .A(x[0]), .B(N11), .Z(random[0]) );
  AN2P U26 ( .A(x[1]), .B(N13), .Z(random[1]) );
  AN2P U27 ( .A(N15), .B(x[2]), .Z(random[2]) );
  AN2P U28 ( .A(x[3]), .B(N17), .Z(random[3]) );
  AN2P U29 ( .A(x[4]), .B(N19), .Z(random[4]) );
  AN2P U30 ( .A(x[5]), .B(N21), .Z(random[5]) );
  AN2P U31 ( .A(x[6]), .B(N23), .Z(random[6]) );
  AN2P U32 ( .A(x[7]), .B(N25), .Z(random[7]) );
  AN2P U33 ( .A(x[8]), .B(N27), .Z(random[8]) );
  AN2P U34 ( .A(N29), .B(x[9]), .Z(random[9]) );
endmodule


module backoff_timer_DW01_dec_18_0 ( A, SUM );
  input [17:0] A;
  output [17:0] SUM;
  wire   \carry[16] , \carry[15] , \carry[14] , \carry[13] , \carry[12] ,
         \carry[11] , \carry[10] , \carry[9] , \carry[8] , \A[16] , \A[15] ,
         \A[14] , \A[13] , \A[12] , \A[11] , \A[10] , \A[9] , \A[8] ,
         \SUM[16] , \SUM[15] , \SUM[14] , \SUM[13] , \SUM[12] , \SUM[11] ,
         \SUM[10] , \SUM[9] , \SUM[8] , \SUM[7] ;
  assign \carry[8]  = A[7];
  assign \A[16]  = A[16];
  assign \A[15]  = A[15];
  assign \A[14]  = A[14];
  assign \A[13]  = A[13];
  assign \A[12]  = A[12];
  assign \A[11]  = A[11];
  assign \A[10]  = A[10];
  assign \A[9]  = A[9];
  assign \A[8]  = A[8];
  assign SUM[16] = \SUM[16] ;
  assign SUM[15] = \SUM[15] ;
  assign SUM[14] = \SUM[14] ;
  assign SUM[13] = \SUM[13] ;
  assign SUM[12] = \SUM[12] ;
  assign SUM[11] = \SUM[11] ;
  assign SUM[10] = \SUM[10] ;
  assign SUM[9] = \SUM[9] ;
  assign SUM[8] = \SUM[8] ;
  assign SUM[7] = \SUM[7] ;

  EN U1_A_14 ( .A(\A[14] ), .B(\carry[14] ), .Z(\SUM[14] ) );
  EN U1_A_13 ( .A(\A[13] ), .B(\carry[13] ), .Z(\SUM[13] ) );
  EN U1_A_16 ( .A(\A[16] ), .B(\carry[16] ), .Z(\SUM[16] ) );
  EN U1_A_15 ( .A(\A[15] ), .B(\carry[15] ), .Z(\SUM[15] ) );
  EN U1_A_12 ( .A(\A[12] ), .B(\carry[12] ), .Z(\SUM[12] ) );
  EN U1_A_11 ( .A(\A[11] ), .B(\carry[11] ), .Z(\SUM[11] ) );
  EN U1_A_10 ( .A(\A[10] ), .B(\carry[10] ), .Z(\SUM[10] ) );
  EN U1_A_9 ( .A(\A[9] ), .B(\carry[9] ), .Z(\SUM[9] ) );
  EN U1_A_8 ( .A(\A[8] ), .B(\carry[8] ), .Z(\SUM[8] ) );
  NR2 U6 ( .A(\A[16] ), .B(\carry[16] ), .Z(SUM[17]) );
  IV U7 ( .A(\carry[8] ), .Z(\SUM[7] ) );
  OR2 U1_B_8 ( .A(\A[8] ), .B(\carry[8] ), .Z(\carry[9] ) );
  OR2 U1_B_9 ( .A(\A[9] ), .B(\carry[9] ), .Z(\carry[10] ) );
  OR2 U1_B_10 ( .A(\A[10] ), .B(\carry[10] ), .Z(\carry[11] ) );
  OR2 U1_B_11 ( .A(\A[11] ), .B(\carry[11] ), .Z(\carry[12] ) );
  OR2 U1_B_12 ( .A(\A[12] ), .B(\carry[12] ), .Z(\carry[13] ) );
  OR2 U1_B_13 ( .A(\A[13] ), .B(\carry[13] ), .Z(\carry[14] ) );
  OR2 U1_B_14 ( .A(\A[14] ), .B(\carry[14] ), .Z(\carry[15] ) );
  OR2 U1_B_15 ( .A(\A[15] ), .B(\carry[15] ), .Z(\carry[16] ) );
endmodule


module backoff_timer_DW01_inc_17_0 ( A, SUM );
  input [16:0] A;
  output [16:0] SUM;
  wire   \A[16] , \A[15] , \A[14] , \A[13] , \A[12] , \A[11] , \A[10] , \A[9] ,
         \A[8] , \A[7] , \A[6] , \A[5] , \A[4] , \A[3] , \A[2] , \A[1] ,
         \A[0] , \SUM[16] , \SUM[15] , \SUM[14] , \SUM[13] , \SUM[12] ,
         \SUM[11] , \SUM[10] , \SUM[9] , \SUM[8] , \SUM[7] , \SUM[6] ,
         \SUM[5] , \SUM[4] , \SUM[3] , \SUM[2] , \SUM[1] , \SUM[0] ,
         \carry[16] , \carry[15] , \carry[14] , \carry[13] , \carry[12] ,
         \carry[11] , \carry[10] , \carry[9] , \carry[8] , \carry[7] ,
         \carry[6] , \carry[5] , \carry[4] , \carry[3] , \carry[2] ;
  assign \A[16]  = A[16];
  assign \A[15]  = A[15];
  assign \A[14]  = A[14];
  assign \A[13]  = A[13];
  assign \A[12]  = A[12];
  assign \A[11]  = A[11];
  assign \A[10]  = A[10];
  assign \A[9]  = A[9];
  assign \A[8]  = A[8];
  assign \A[7]  = A[7];
  assign \A[6]  = A[6];
  assign \A[5]  = A[5];
  assign \A[4]  = A[4];
  assign \A[3]  = A[3];
  assign \A[2]  = A[2];
  assign \A[1]  = A[1];
  assign \A[0]  = A[0];
  assign SUM[16] = \SUM[16] ;
  assign SUM[15] = \SUM[15] ;
  assign SUM[14] = \SUM[14] ;
  assign SUM[13] = \SUM[13] ;
  assign SUM[12] = \SUM[12] ;
  assign SUM[11] = \SUM[11] ;
  assign SUM[10] = \SUM[10] ;
  assign SUM[9] = \SUM[9] ;
  assign SUM[8] = \SUM[8] ;
  assign SUM[7] = \SUM[7] ;
  assign SUM[6] = \SUM[6] ;
  assign SUM[5] = \SUM[5] ;
  assign SUM[4] = \SUM[4] ;
  assign SUM[3] = \SUM[3] ;
  assign SUM[2] = \SUM[2] ;
  assign SUM[1] = \SUM[1] ;
  assign SUM[0] = \SUM[0] ;

  EO U5 ( .A(\carry[16] ), .B(\A[16] ), .Z(\SUM[16] ) );
  HA1 U1_1_14 ( .A(\A[14] ), .B(\carry[14] ), .S(\SUM[14] ), .CO(\carry[15] )
         );
  HA1 U1_1_12 ( .A(\A[12] ), .B(\carry[12] ), .S(\SUM[12] ), .CO(\carry[13] )
         );
  HA1 U1_1_10 ( .A(\A[10] ), .B(\carry[10] ), .S(\SUM[10] ), .CO(\carry[11] )
         );
  HA1 U1_1_8 ( .A(\A[8] ), .B(\carry[8] ), .S(\SUM[8] ), .CO(\carry[9] ) );
  HA1 U1_1_6 ( .A(\A[6] ), .B(\carry[6] ), .S(\SUM[6] ), .CO(\carry[7] ) );
  HA1 U1_1_4 ( .A(\A[4] ), .B(\carry[4] ), .S(\SUM[4] ), .CO(\carry[5] ) );
  HA1 U1_1_2 ( .A(\A[2] ), .B(\carry[2] ), .S(\SUM[2] ), .CO(\carry[3] ) );
  HA1 U1_1_13 ( .A(\A[13] ), .B(\carry[13] ), .S(\SUM[13] ), .CO(\carry[14] )
         );
  HA1 U1_1_15 ( .A(\A[15] ), .B(\carry[15] ), .S(\SUM[15] ), .CO(\carry[16] )
         );
  HA1 U1_1_11 ( .A(\A[11] ), .B(\carry[11] ), .S(\SUM[11] ), .CO(\carry[12] )
         );
  HA1 U1_1_9 ( .A(\A[9] ), .B(\carry[9] ), .S(\SUM[9] ), .CO(\carry[10] ) );
  HA1 U1_1_5 ( .A(\A[5] ), .B(\carry[5] ), .S(\SUM[5] ), .CO(\carry[6] ) );
  HA1 U1_1_7 ( .A(\A[7] ), .B(\carry[7] ), .S(\SUM[7] ), .CO(\carry[8] ) );
  HA1 U1_1_3 ( .A(\A[3] ), .B(\carry[3] ), .S(\SUM[3] ), .CO(\carry[4] ) );
  HA1 U1_1_1 ( .A(\A[1] ), .B(\A[0] ), .S(\SUM[1] ), .CO(\carry[2] ) );
  IVP U6 ( .A(\A[0] ), .Z(\SUM[0] ) );
endmodule


module backoff_timer ( start_backoff, random, clk, reset_n, backoff_p );
  input [9:0] random;
  input start_backoff, clk, reset_n;
  output backoff_p;
  wire   N0, state_backoff, N24, N49, N50, N51, N52, N53, N54, N55, N56, N57,
         N58, N59, N60, N61, N62, N63, N64, N65, N70, N72, N74, N76, N78, N80,
         N82, N84, N86, N88, N90, N92, N94, N96, N98, N100, N102, N120, N121,
         N122, N123, N124, N125, N126, N127, N128, N129, N130, n32, n33, n34,
         n53, n54, n55, n56, n57, n58, n59, n60, n61, n62, n63, n64, n65, n66,
         n67, n68, n69, n70, n71, n72, n73;
  wire   [16:0] count_backoff;
  wire   SYNOPSYS_UNCONNECTED__0, SYNOPSYS_UNCONNECTED__1, 
        SYNOPSYS_UNCONNECTED__2, SYNOPSYS_UNCONNECTED__3, 
        SYNOPSYS_UNCONNECTED__4, SYNOPSYS_UNCONNECTED__5, 
        SYNOPSYS_UNCONNECTED__6;
    wire ck2 ;
    wire ck1 ;
    B1I  u_ck2 (.A (ck1 ),.Z (ck2 ));
    IVP  u_ck1 (.A (clk ),.Z (ck1 ));

  EO U3 ( .A(N130), .B(n57), .Z(n69) );
  EO U4 ( .A(N129), .B(n58), .Z(n68) );
  MUX21L U5 ( .A(start_backoff), .B(n34), .S(state_backoff), .Z(n72) );
  EO U6 ( .A(count_backoff[14]), .B(N128), .Z(n66) );
  NR2 U7 ( .A(N24), .B(n32), .Z(N120) );
  EO U8 ( .A(count_backoff[13]), .B(N127), .Z(n65) );
//   FDS2L count_backoff_reg_0 ( .D(N70), .CP(clk), .CR(1'b1), .LD(n33), .Q(
  FDS2L count_backoff_reg_0 ( .D(N70), .CP(
//     ), .CR(1'b1), .LD(n33), .Q(
    ck2 ), .CR(1'b1), .LD(n33), .Q(
        count_backoff[0]), .QN(n55) );
  EO U9 ( .A(count_backoff[12]), .B(N126), .Z(n64) );
  EO U10 ( .A(count_backoff[11]), .B(N125), .Z(n63) );
  EO U11 ( .A(count_backoff[10]), .B(N124), .Z(n62) );
  EO U12 ( .A(count_backoff[9]), .B(N123), .Z(n61) );
  EO U13 ( .A(count_backoff[8]), .B(N122), .Z(n60) );
  EO U14 ( .A(count_backoff[7]), .B(N121), .Z(n59) );
//   FD2 state_backoff_reg ( .D(n32), .CP(clk), .CD(reset_n), .Q(state_backoff)
  FD2 state_backoff_reg ( .D(n32), .CP(
//     ), .CD(reset_n), .Q(state_backoff)
    ck2 ), .CD(reset_n), .Q(state_backoff)
         );
//   FDS2L count_backoff_reg_1 ( .D(N72), .CP(clk), .CR(1'b1), .LD(n33), .Q(
  FDS2L count_backoff_reg_1 ( .D(N72), .CP(
//     ), .CR(1'b1), .LD(n33), .Q(
    ck2 ), .CR(1'b1), .LD(n33), .Q(
        count_backoff[1]), .QN(n56) );
//   FDS2L count_backoff_reg_2 ( .D(N74), .CP(clk), .CR(1'b1), .LD(n33), .Q(
  FDS2L count_backoff_reg_2 ( .D(N74), .CP(
//     ), .CR(1'b1), .LD(n33), .Q(
    ck2 ), .CR(1'b1), .LD(n33), .Q(
        count_backoff[2]), .QN(n54) );
//   FDS2L count_backoff_reg_3 ( .D(N76), .CP(clk), .CR(1'b1), .LD(n33), .Q(
  FDS2L count_backoff_reg_3 ( .D(N76), .CP(
//     ), .CR(1'b1), .LD(n33), .Q(
    ck2 ), .CR(1'b1), .LD(n33), .Q(
        count_backoff[3]), .QN(n53) );
//   FDS2L count_backoff_reg_4 ( .D(N78), .CP(clk), .CR(1'b1), .LD(n33), .Q(
  FDS2L count_backoff_reg_4 ( .D(N78), .CP(
//     ), .CR(1'b1), .LD(n33), .Q(
    ck2 ), .CR(1'b1), .LD(n33), .Q(
        count_backoff[4]) );
//   FDS2L count_backoff_reg_5 ( .D(N80), .CP(clk), .CR(1'b1), .LD(n33), .Q(
  FDS2L count_backoff_reg_5 ( .D(N80), .CP(
//     ), .CR(1'b1), .LD(n33), .Q(
    ck2 ), .CR(1'b1), .LD(n33), .Q(
        count_backoff[5]) );
//   FDS2L count_backoff_reg_6 ( .D(N82), .CP(clk), .CR(1'b1), .LD(n33), .Q(
  FDS2L count_backoff_reg_6 ( .D(N82), .CP(
//     ), .CR(1'b1), .LD(n33), .Q(
    ck2 ), .CR(1'b1), .LD(n33), .Q(
        count_backoff[6]) );
//   FDS2L count_backoff_reg_7 ( .D(N84), .CP(clk), .CR(1'b1), .LD(n33), .Q(
  FDS2L count_backoff_reg_7 ( .D(N84), .CP(
//     ), .CR(1'b1), .LD(n33), .Q(
    ck2 ), .CR(1'b1), .LD(n33), .Q(
        count_backoff[7]) );
//   FDS2L count_backoff_reg_8 ( .D(N86), .CP(clk), .CR(1'b1), .LD(n33), .Q(
  FDS2L count_backoff_reg_8 ( .D(N86), .CP(
//     ), .CR(1'b1), .LD(n33), .Q(
    ck2 ), .CR(1'b1), .LD(n33), .Q(
        count_backoff[8]) );
//   FDS2L count_backoff_reg_10 ( .D(N90), .CP(clk), .CR(1'b1), .LD(n33), .Q(
  FDS2L count_backoff_reg_10 ( .D(N90), .CP(
//     ), .CR(1'b1), .LD(n33), .Q(
    ck2 ), .CR(1'b1), .LD(n33), .Q(
        count_backoff[10]) );
//   FDS2L count_backoff_reg_11 ( .D(N92), .CP(clk), .CR(1'b1), .LD(n33), .Q(
  FDS2L count_backoff_reg_11 ( .D(N92), .CP(
//     ), .CR(1'b1), .LD(n33), .Q(
    ck2 ), .CR(1'b1), .LD(n33), .Q(
        count_backoff[11]) );
//   FDS2L count_backoff_reg_9 ( .D(N88), .CP(clk), .CR(1'b1), .LD(n33), .Q(
  FDS2L count_backoff_reg_9 ( .D(N88), .CP(
//     ), .CR(1'b1), .LD(n33), .Q(
    ck2 ), .CR(1'b1), .LD(n33), .Q(
        count_backoff[9]) );
//   FDS2L count_backoff_reg_13 ( .D(N96), .CP(clk), .CR(1'b1), .LD(n33), .Q(
  FDS2L count_backoff_reg_13 ( .D(N96), .CP(
//     ), .CR(1'b1), .LD(n33), .Q(
    ck2 ), .CR(1'b1), .LD(n33), .Q(
        count_backoff[13]) );
//   FDS2L count_backoff_reg_14 ( .D(N98), .CP(clk), .CR(1'b1), .LD(n33), .Q(
  FDS2L count_backoff_reg_14 ( .D(N98), .CP(
//     ), .CR(1'b1), .LD(n33), .Q(
    ck2 ), .CR(1'b1), .LD(n33), .Q(
        count_backoff[14]) );
//   FDS2L count_backoff_reg_12 ( .D(N94), .CP(clk), .CR(1'b1), .LD(n33), .Q(
  FDS2L count_backoff_reg_12 ( .D(N94), .CP(
//     ), .CR(1'b1), .LD(n33), .Q(
    ck2 ), .CR(1'b1), .LD(n33), .Q(
        count_backoff[12]) );
//   FDS2L count_backoff_reg_15 ( .D(N100), .CP(clk), .CR(1'b1), .LD(n33), .Q(
  FDS2L count_backoff_reg_15 ( .D(N100), .CP(
//     ), .CR(1'b1), .LD(n33), .Q(
    ck2 ), .CR(1'b1), .LD(n33), .Q(
        count_backoff[15]), .QN(n58) );
//   FDS2L count_backoff_reg_16 ( .D(N102), .CP(clk), .CR(1'b1), .LD(n33), .Q(
  FDS2L count_backoff_reg_16 ( .D(N102), .CP(
//     ), .CR(1'b1), .LD(n33), .Q(
    ck2 ), .CR(1'b1), .LD(n33), .Q(
        count_backoff[16]), .QN(n57) );
  IVP U15 ( .A(start_backoff), .Z(n73) );
//   FDS2L backoff_p_reg ( .D(state_backoff), .CP(clk), .CR(1'b1), .LD(N120), .Q(
  FDS2L backoff_p_reg ( .D(state_backoff), .CP(
//     ), .CR(1'b1), .LD(N120), .Q(
    ck2 ), .CR(1'b1), .LD(N120), .Q(
        backoff_p) );
  IVP U16 ( .A(reset_n), .Z(N24) );
  MUX21L U17 ( .A(n73), .B(n34), .S(state_backoff), .Z(n32) );
  AN2 U18 ( .A(n72), .B(reset_n), .Z(n33) );
  NR3 U19 ( .A(n71), .B(N0), .C(n70), .Z(n34) );
  backoff_timer_DW01_dec_18_0 sub_58 ( .A({1'b0, random[9], random[8], 
        random[7], random[6], random[5], random[4], random[3], random[2], 
        random[1], random[0], 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0}), 
        .SUM({N0, N130, N129, N128, N127, N126, N125, N124, N123, N122, N121, 
        SYNOPSYS_UNCONNECTED__0, SYNOPSYS_UNCONNECTED__1, 
        SYNOPSYS_UNCONNECTED__2, SYNOPSYS_UNCONNECTED__3, 
        SYNOPSYS_UNCONNECTED__4, SYNOPSYS_UNCONNECTED__5, 
        SYNOPSYS_UNCONNECTED__6}) );
  backoff_timer_DW01_inc_17_0 add_66 ( .A({count_backoff[16], 
        count_backoff[15], count_backoff[14], count_backoff[13], 
        count_backoff[12], count_backoff[11], count_backoff[10], 
        count_backoff[9], count_backoff[8], count_backoff[7], count_backoff[6], 
        count_backoff[5], count_backoff[4], count_backoff[3], count_backoff[2], 
        count_backoff[1], count_backoff[0]}), .SUM({N65, N64, N63, N62, N61, 
        N60, N59, N58, N57, N56, N55, N54, N53, N52, N51, N50, N49}) );
  AN2P U38 ( .A(N49), .B(state_backoff), .Z(N70) );
  OR4 U39 ( .A(n56), .B(n55), .C(n54), .D(n53), .Z(n71) );
  NR8P U40 ( .A(n66), .B(n65), .C(n64), .D(n63), .E(n62), .F(n61), .G(n60), 
        .H(n59), .Z(n67) );
  ND6P U41 ( .A(count_backoff[5]), .B(count_backoff[4]), .C(count_backoff[6]), 
        .D(n69), .E(n68), .F(n67), .Z(n70) );
  AN2P U42 ( .A(N50), .B(state_backoff), .Z(N72) );
  AN2P U43 ( .A(N51), .B(state_backoff), .Z(N74) );
  AN2P U44 ( .A(N52), .B(state_backoff), .Z(N76) );
  AN2P U45 ( .A(N53), .B(state_backoff), .Z(N78) );
  AN2P U46 ( .A(N54), .B(state_backoff), .Z(N80) );
  AN2P U47 ( .A(N55), .B(state_backoff), .Z(N82) );
  AN2P U48 ( .A(N56), .B(state_backoff), .Z(N84) );
  AN2P U49 ( .A(N57), .B(state_backoff), .Z(N86) );
  AN2P U50 ( .A(N58), .B(state_backoff), .Z(N88) );
  AN2P U51 ( .A(N59), .B(state_backoff), .Z(N90) );
  AN2P U52 ( .A(N60), .B(state_backoff), .Z(N92) );
  AN2P U53 ( .A(N61), .B(state_backoff), .Z(N94) );
  AN2P U54 ( .A(N62), .B(state_backoff), .Z(N96) );
  AN2P U55 ( .A(N63), .B(state_backoff), .Z(N98) );
  AN2P U56 ( .A(N64), .B(state_backoff), .Z(N100) );
  AN2P U57 ( .A(N65), .B(state_backoff), .Z(N102) );
endmodule


module jam_timer ( coll_event_p, clk, reset_n, count_jam );
  output [3:0] count_jam;
  input coll_event_p, clk, reset_n;
  wire   N10, N11, N12, n10, n11, n12, n13;

  IVP U_CK1 ( .A(clk), .Z(n_ck1) );
  IVP U_CK2 ( .A(n_ck1), .Z(n_ck2) );
  IVP U_CK3 ( .A(n_ck2), .Z(n_ck3) );
  IVP U_CK4 ( .A(n_ck3), .Z(n_ck4) );
  IVP U_CK5 ( .A(n_ck4), .Z(n_ck5) );
  IVP U_CK6 ( .A(n_ck5), .Z(n_ck6) );

  FJK2S count_jam_reg_0 ( .J(1'b1), .K(1'b1), .CP(n_ck6), .CD(reset_n), .TI(1'b1), .TE(coll_event_p), .Q(count_jam[0]) );
  FD2S count_jam_reg_1 ( .D(1'b0), .CP(n_ck6), .CD(reset_n), .TI(n13), .TE(N10), 
        .Q(count_jam[1]) );
  NR2 U3 ( .A(n11), .B(n10), .Z(n12) );
  FD2S count_jam_reg_2 ( .D(1'b0), .CP(n_ck6), .CD(reset_n), .TI(n13), .TE(N11), 
        .Q(count_jam[2]), .QN(n10) );
  FD2S count_jam_reg_3 ( .D(1'b0), .CP(n_ck6), .CD(reset_n), .TI(n13), .TE(N12), 
        .Q(count_jam[3]) );
  ND2 U4 ( .A(count_jam[1]), .B(count_jam[0]), .Z(n11) );
  EO U5 ( .A(count_jam[3]), .B(n12), .Z(N12) );
  EO U6 ( .A(n11), .B(n10), .Z(N11) );
  EO U7 ( .A(count_jam[1]), .B(count_jam[0]), .Z(N10) );
  IVP U8 ( .A(coll_event_p), .Z(n13) );
endmodule


module crc_gen ( compute_crc, data, clk, reset_n, crc );
  input [3:0] data;
  output [3:0] crc;
  input compute_crc, clk, reset_n;
  wire   crc_buffer_31, crc_buffer_30, crc_buffer_29, crc_buffer_28,
         crc_buffer_27, crc_buffer_26, crc_buffer_25, crc_buffer_24,
         crc_buffer_23, crc_buffer_22, crc_buffer_21, crc_buffer_19,
         crc_buffer_18, crc_buffer_17, crc_buffer_16, crc_buffer_15,
         crc_buffer_14, crc_buffer_13, crc_buffer_12, crc_buffer_11,
         crc_buffer_10, crc_buffer_9, crc_buffer_8, crc_buffer_7, crc_buffer_6,
         crc_buffer_4, crc_buffer_3, crc_buffer_1, crc_buffer_0, crc_end_1,
         crc_end_0, N8, N156, N157, N158, N162, N163, N164, N165, N166, N167,
         N168, N169, N170, N171, N172, N173, N174, N175, N176, N177, N178,
         N179, N180, N181, N182, N183, N184, N185, N186, N187, N188, N189,
         N190, N191, N192, N193, N194, N195, N196, N197, N198, N241, n39, n40,
         n41, n42, n43, n44, n45, n46, n47, n48, n49, n50, n51, n52, n53, n54,
         n55, n56, n57, n58, n59, n60, n61, n99, n100, n101, n102, n103, n104,
         n105, n106, n107, n108, n109, n110, n111, n112, n113, n114, n115,
         n116, n117, n118, n119, n120, n121, n122, n123, n124, n125, n126,
         n127, n128, n129, n130, n131, n132, n133, n134, n135, n136, n137,
         n138, n139, n140, n141, n142, n143, n144, n145, n146, n147, n148,
         n149, n150, n151, n152, n153, n154, n155, n156, n157, n158, n159,
         n160, n161, n162, n163, n164, n165, n166, n167, n168, n169, n170,
         n171, n172, n173, n174, n175, n176, n177, n178, n179, n180, n181,
         n182, n183, n184, n185, n186, n187, n188, n189, n190, n191, n192,
         n193, n194, n195, n196, n197, n198, n199, n200, n201, n202, n203,
         n204, n205, n206, n207, n208, n209, n210, n211, n212, n213, n214,
         n215, n216, n217;
  wire   [1:0] state_crc;
    wire ck2 ;
    wire ck1 ;
    IVP  u_ck2 (.A (ck1 ),.Z (ck2 ));
    IVP  u_ck1 (.A (clk ),.Z (ck1 ));

  ND2 U3 ( .A(state_crc[0]), .B(n105), .Z(n171) );
  MUX21L U4 ( .A(n42), .B(n210), .S(crc_buffer_11), .Z(n160) );
  MUX21L U5 ( .A(n42), .B(n210), .S(crc_buffer_15), .Z(n169) );
  AO7 U6 ( .A(compute_crc), .B(n171), .C(n170), .Z(N166) );
  ND2 U7 ( .A(compute_crc), .B(n107), .Z(n216) );
  AO3 U8 ( .A(n187), .B(n143), .C(n142), .D(n141), .Z(N177) );
  AO3 U9 ( .A(n187), .B(n119), .C(n142), .D(n118), .Z(N171) );
  AO3 U10 ( .A(n187), .B(n133), .C(n142), .D(n132), .Z(N174) );
  EO U11 ( .A(data[3]), .B(n204), .Z(n179) );
  AO3 U12 ( .A(n187), .B(n136), .C(n146), .D(n135), .Z(N175) );
  AO3 U13 ( .A(n187), .B(n125), .C(n146), .D(n124), .Z(N172) );
  AO3 U14 ( .A(n187), .B(n147), .C(n146), .D(n145), .Z(N178) );
  AO7 U15 ( .A(n150), .B(n199), .C(n149), .Z(N179) );
  EO U16 ( .A(data[2]), .B(n209), .Z(n126) );
  ND2 U17 ( .A(n154), .B(n153), .Z(N180) );
  EO U18 ( .A(crc_buffer_29), .B(n50), .Z(n110) );
  EO U19 ( .A(n46), .B(n112), .Z(n113) );
  AO7 U20 ( .A(n181), .B(n199), .C(n180), .Z(N190) );
  ND2 U21 ( .A(n193), .B(n192), .Z(N192) );
  ND2 U22 ( .A(n159), .B(n158), .Z(N181) );
  AO3 U23 ( .A(n187), .B(n139), .C(n185), .D(n138), .Z(N176) );
  AO3 U24 ( .A(n187), .B(n130), .C(n185), .D(n129), .Z(N173) );
  AO3 U25 ( .A(n187), .B(n186), .C(n185), .D(n184), .Z(N191) );
  MUX21L U26 ( .A(n42), .B(n210), .S(crc_buffer_25), .Z(n212) );
  ND2 U27 ( .A(n169), .B(n211), .Z(N186) );
  ND2 U28 ( .A(n160), .B(n211), .Z(N182) );
  AO7 U29 ( .A(n200), .B(n199), .C(n198), .Z(N193) );
  ND2 U30 ( .A(n205), .B(n60), .Z(n175) );
//   FDS2L crc_buffer_reg_31 ( .D(N198), .CP(clk), .CR(1'b1), .LD(n39), .Q(
  FDS2L crc_buffer_reg_31 ( .D(N198), .CP(
//     ), .CR(1'b1), .LD(n39), .Q(
    ck2 ), .CR(1'b1), .LD(n39), .Q(
        crc_buffer_31), .QN(crc[0]) );
//   FDS2L crc_buffer_reg_30 ( .D(N197), .CP(clk), .CR(1'b1), .LD(n39), .Q(
  FDS2L crc_buffer_reg_30 ( .D(N197), .CP(
//     ), .CR(1'b1), .LD(n39), .Q(
    ck2 ), .CR(1'b1), .LD(n39), .Q(
        crc_buffer_30), .QN(crc[1]) );
  ND2 U31 ( .A(n216), .B(n173), .Z(N188) );
  ND2 U32 ( .A(n216), .B(n172), .Z(N187) );
  ND2 U33 ( .A(n171), .B(n170), .Z(n215) );
  EO U34 ( .A(crc_buffer_3), .B(n49), .Z(n131) );
  EO U35 ( .A(crc_buffer_6), .B(n49), .Z(n140) );
  EO U36 ( .A(crc_buffer_0), .B(n49), .Z(n117) );
  IVP U37 ( .A(n188), .Z(n155) );
  IVP U38 ( .A(data[0]), .Z(n194) );
  EO U39 ( .A(crc_buffer_7), .B(n48), .Z(n144) );
  EO U40 ( .A(crc_buffer_1), .B(n48), .Z(n123) );
  EO U41 ( .A(crc_buffer_4), .B(n48), .Z(n134) );
  IVP U42 ( .A(n126), .Z(n127) );
  AO7 U43 ( .A(n216), .B(n40), .C(n111), .Z(N169) );
  AO7 U44 ( .A(n216), .B(n46), .C(n114), .Z(N170) );
  EO U45 ( .A(n120), .B(crc[3]), .Z(n178) );
  EO U46 ( .A(n190), .B(n156), .Z(n157) );
  EO U47 ( .A(n190), .B(n189), .Z(n191) );
  EON1 U48 ( .A(n179), .B(n216), .C(n205), .D(n109), .Z(N168) );
  EO U49 ( .A(n182), .B(n130), .Z(n128) );
  EO U50 ( .A(n182), .B(n139), .Z(n137) );
  EO U51 ( .A(n182), .B(n186), .Z(n183) );
  AO7 U52 ( .A(n216), .B(n204), .C(n165), .Z(N184) );
  AO7 U53 ( .A(n216), .B(n204), .C(n203), .Z(N194) );
  AO7 U54 ( .A(n171), .B(n57), .C(n187), .Z(n163) );
  AO2 U55 ( .A(n196), .B(n46), .C(crc_buffer_9), .D(N166), .Z(n154) );
  ND2 U56 ( .A(n196), .B(n44), .Z(n142) );
  ND2 U57 ( .A(n196), .B(n41), .Z(n146) );
  ND2 U58 ( .A(n205), .B(n57), .Z(n164) );
  ND2 U59 ( .A(n205), .B(n57), .Z(n202) );
  AO2 U60 ( .A(crc_buffer_8), .B(N166), .C(n196), .D(n40), .Z(n149) );
  AO7 U61 ( .A(n216), .B(n177), .C(n162), .Z(N183) );
  AO7 U62 ( .A(n216), .B(n177), .C(n176), .Z(N189) );
  AO7 U63 ( .A(n171), .B(n60), .C(n187), .Z(n161) );
  AO7 U64 ( .A(n171), .B(n53), .C(n187), .Z(n210) );
  EO U65 ( .A(n195), .B(n197), .Z(n200) );
  AO7 U66 ( .A(n216), .B(n209), .C(n208), .Z(N195) );
  AO7 U67 ( .A(n216), .B(n209), .C(n168), .Z(N185) );
  AO7 U68 ( .A(n171), .B(n58), .C(n187), .Z(n166) );
  AO2 U69 ( .A(crc_buffer_19), .B(N166), .C(n179), .D(n196), .Z(n180) );
  AO2 U70 ( .A(n188), .B(n196), .C(crc_buffer_10), .D(N166), .Z(n159) );
  AO2 U71 ( .A(n188), .B(n196), .C(crc_buffer_21), .D(N166), .Z(n193) );
  AO2 U72 ( .A(n197), .B(n196), .C(crc_buffer_22), .D(N166), .Z(n198) );
  ND2 U73 ( .A(n205), .B(n58), .Z(n207) );
  ND2 U74 ( .A(n205), .B(n58), .Z(n167) );
  ND2 U75 ( .A(n126), .B(n196), .Z(n185) );
  AO7 U76 ( .A(data[3]), .B(n216), .C(n175), .Z(N167) );
//   FDS2L crc_buffer_reg_29 ( .D(N196), .CP(clk), .CR(1'b1), .LD(n39), .Q(
  FDS2L crc_buffer_reg_29 ( .D(N196), .CP(
//     ), .CR(1'b1), .LD(n39), .Q(
    ck2 ), .CR(1'b1), .LD(n39), .Q(
        crc_buffer_29), .QN(crc[2]) );
  ND2 U77 ( .A(data[0]), .B(n196), .Z(n211) );
  ND2 U78 ( .A(n47), .B(n102), .Z(n170) );
//   FDS2L crc_end_reg_1 ( .D(N163), .CP(clk), .CR(1'b1), .LD(n61), .Q(crc_end_1), 
  FDS2L crc_end_reg_1 ( .D(N163), .CP(
//     ), .CR(1'b1), .LD(n61), .Q(crc_end_1), 
    ck2 ), .CR(1'b1), .LD(n61), .Q(crc_end_1), 
        .QN(n101) );
  ND2 U79 ( .A(compute_crc), .B(n106), .Z(n199) );
//   FDS2L crc_end_reg_0 ( .D(N162), .CP(clk), .CR(1'b1), .LD(n61), .Q(crc_end_0), 
  FDS2L crc_end_reg_0 ( .D(N162), .CP(
//     ), .CR(1'b1), .LD(n61), .Q(crc_end_0), 
    ck2 ), .CR(1'b1), .LD(n61), .Q(crc_end_0), 
        .QN(N156) );
  ND2 U80 ( .A(n217), .B(n216), .Z(N165) );
  IVP U81 ( .A(n148), .Z(n112) );
  IVP U82 ( .A(n122), .Z(n121) );
  EO U83 ( .A(crc_buffer_31), .B(crc[1]), .Z(n116) );
  ND2 U84 ( .A(crc_buffer_17), .B(n215), .Z(n173) );
  ND2 U85 ( .A(crc_buffer_16), .B(n215), .Z(n172) );
  ND2 U86 ( .A(crc_buffer_26), .B(n215), .Z(n213) );
  ND2 U87 ( .A(crc_buffer_27), .B(n215), .Z(n214) );
  EO U88 ( .A(n100), .B(n99), .Z(N158) );
  MUX21L U89 ( .A(n43), .B(n55), .S(n117), .Z(n118) );
  MUX21L U90 ( .A(n43), .B(n55), .S(n140), .Z(n141) );
  MUX21L U91 ( .A(n43), .B(n55), .S(n131), .Z(n132) );
  EO U92 ( .A(data[1]), .B(n194), .Z(n188) );
  IVP U93 ( .A(data[2]), .Z(n204) );
  IVP U94 ( .A(n179), .Z(n120) );
  MUX21L U95 ( .A(n45), .B(n54), .S(n123), .Z(n124) );
  MUX21L U96 ( .A(n45), .B(n54), .S(n144), .Z(n145) );
  MUX21L U97 ( .A(n45), .B(n54), .S(n134), .Z(n135) );
  MUX21L U98 ( .A(n43), .B(n55), .S(n152), .Z(n153) );
  MUX21L U99 ( .A(n59), .B(n51), .S(n110), .Z(n111) );
  MUX21L U100 ( .A(n56), .B(n52), .S(n113), .Z(n114) );
  IVP U101 ( .A(data[1]), .Z(n209) );
  MUX21L U102 ( .A(n56), .B(n52), .S(n191), .Z(n192) );
  MUX21L U103 ( .A(n56), .B(n52), .S(n157), .Z(n158) );
  EO U104 ( .A(n155), .B(crc[1]), .Z(n190) );
  IVP U105 ( .A(data[3]), .Z(n177) );
  EO U106 ( .A(n178), .B(crc[2]), .Z(n109) );
  MUX21L U107 ( .A(n59), .B(n51), .S(n137), .Z(n138) );
  MUX21L U108 ( .A(n59), .B(n51), .S(n183), .Z(n184) );
  MUX21L U109 ( .A(n59), .B(n51), .S(n128), .Z(n129) );
  EO U110 ( .A(n127), .B(crc[2]), .Z(n182) );
  IVP U111 ( .A(n163), .Z(n201) );
  ND2 U112 ( .A(n212), .B(n211), .Z(N196) );
  IVP U113 ( .A(n161), .Z(n174) );
//   FJK2S state_crc_reg_1 ( .J(1'b0), .K(1'b0), .CP(clk), .CD(reset_n), .TI(N166), .TE(N241), .Q(state_crc[1]), .QN(n105) );
  FJK2S state_crc_reg_1 ( .J(1'b0), .K(1'b0), .CP(
//     ), .CD(reset_n), .TI(N166), .TE(N241), .Q(state_crc[1]), .QN(n105) );
    ck2 ), .CD(reset_n), .TI(N166), .TE(N241), .Q(state_crc[1]), .QN(n105) );
  IVP U114 ( .A(n171), .Z(n106) );
  IVP U115 ( .A(N241), .Z(n108) );
//   FJK2S state_crc_reg_0 ( .J(1'b0), .K(1'b0), .CP(clk), .CD(reset_n), .TI(N165), .TE(N241), .Q(state_crc[0]) );
  FJK2S state_crc_reg_0 ( .J(1'b0), .K(1'b0), .CP(
//     ), .CD(reset_n), .TI(N165), .TE(N241), .Q(state_crc[0]) );
    ck2 ), .CD(reset_n), .TI(N165), .TE(N241), .Q(state_crc[0]) );
  IVP U116 ( .A(n104), .Z(n107) );
  EO U117 ( .A(data[3]), .B(n194), .Z(n197) );
  IVP U118 ( .A(n166), .Z(n206) );
  IVP U119 ( .A(N166), .Z(n187) );
//   FDS2L crc_buffer_reg_28 ( .D(N195), .CP(clk), .CR(1'b1), .LD(n39), .Q(
  FDS2L crc_buffer_reg_28 ( .D(N195), .CP(
//     ), .CR(1'b1), .LD(n39), .Q(
    ck2 ), .CR(1'b1), .LD(n39), .Q(
        crc_buffer_28), .QN(crc[3]) );
  IVP U120 ( .A(n216), .Z(n196) );
  IVP U121 ( .A(n199), .Z(n205) );
  IVP U122 ( .A(reset_n), .Z(N8) );
  ND2 U123 ( .A(n216), .B(n213), .Z(N197) );
  ND2 U124 ( .A(n216), .B(n214), .Z(N198) );
  EO U125 ( .A(crc_buffer_30), .B(crc[2]), .Z(n148) );
  AO7 U126 ( .A(compute_crc), .B(n104), .C(n170), .Z(n103) );
  EO U127 ( .A(crc_buffer_31), .B(crc[2]), .Z(n122) );
  IVP U128 ( .A(n116), .Z(n115) );
  IVP U129 ( .A(n215), .Z(n217) );
//   FDS2L crc_buffer_reg_22 ( .D(N189), .CP(clk), .CR(1'b1), .LD(n39), .Q(
  FDS2L crc_buffer_reg_22 ( .D(N189), .CP(
//     ), .CR(1'b1), .LD(n39), .Q(
    ck2 ), .CR(1'b1), .LD(n39), .Q(
        crc_buffer_22) );
//   FDS2L crc_buffer_reg_9 ( .D(N176), .CP(clk), .CR(1'b1), .LD(n39), .Q(
  FDS2L crc_buffer_reg_9 ( .D(N176), .CP(ck2 ), .CR(1'b1), .LD(n39), .Q(
        crc_buffer_9), .QN(n151) );
//   FDS2L crc_buffer_reg_5 ( .D(N172), .CP(clk), .CR(1'b1), .LD(n39), .QN(n139)
  FDS2L crc_buffer_reg_5 ( .D(N172), .CP(
//     ), .CR(1'b1), .LD(n39), .QN(n139)
    ck2 ), .CR(1'b1), .LD(n39), .QN(n139)
         );
//   FDS2L crc_buffer_reg_2 ( .D(N169), .CP(clk), .CR(1'b1), .LD(n39), .QN(n130)
  FDS2L crc_buffer_reg_2 ( .D(N169), .CP(
//     ), .CR(1'b1), .LD(n39), .QN(n130)
    ck2 ), .CR(1'b1), .LD(n39), .QN(n130)
         );
//   FDS2L crc_buffer_reg_20 ( .D(N187), .CP(clk), .CR(1'b1), .LD(n39), .QN(n186)
  FDS2L crc_buffer_reg_20 ( .D(N187), .CP(
//     ), .CR(1'b1), .LD(n39), .QN(n186)
    ck2 ), .CR(1'b1), .LD(n39), .QN(n186)
         );
//   FDS2L crc_buffer_reg_10 ( .D(N177), .CP(clk), .CR(1'b1), .LD(n39), .Q(
  FDS2L crc_buffer_reg_10 ( .D(N177), .CP(
//     ), .CR(1'b1), .LD(n39), .Q(
    ck2 ), .CR(1'b1), .LD(n39), .Q(
        crc_buffer_10), .QN(n156) );
//   FDS2L crc_buffer_reg_21 ( .D(N188), .CP(clk), .CR(1'b1), .LD(n39), .Q(
  FDS2L crc_buffer_reg_21 ( .D(N188), .CP(
//     ), .CR(1'b1), .LD(n39), .Q(
    ck2 ), .CR(1'b1), .LD(n39), .Q(
        crc_buffer_21), .QN(n189) );
//   FDS2L crc_buffer_reg_19 ( .D(N186), .CP(clk), .CR(1'b1), .LD(n39), .Q(
  FDS2L crc_buffer_reg_19 ( .D(N186), .CP(
//     ), .CR(1'b1), .LD(n39), .Q(
    ck2 ), .CR(1'b1), .LD(n39), .Q(
        crc_buffer_19) );
//   FDS2L crc_buffer_reg_8 ( .D(N175), .CP(clk), .CR(1'b1), .LD(n39), .Q(
  FDS2L crc_buffer_reg_8 ( .D(N175), .CP(ck2 ), .CR(1'b1), .LD(n39), .Q(
        crc_buffer_8) );
  ND2 U130 ( .A(crc_end_1), .B(crc_end_0), .Z(n100) );
//   FDS2L crc_buffer_reg_0 ( .D(N167), .CP(clk), .CR(1'b1), .LD(n39), .Q(
  FDS2L crc_buffer_reg_0 ( .D(N167), .CP(ck2 ), .CR(1'b1), .LD(n39), .Q(
        crc_buffer_0), .QN(n119) );
//   FDS2L crc_buffer_reg_6 ( .D(N173), .CP(clk), .CR(1'b1), .LD(n39), .Q(
  FDS2L crc_buffer_reg_6 ( .D(N173), .CP(ck2 ), .CR(1'b1), .LD(n39), .Q(
        crc_buffer_6), .QN(n143) );
//   FDS2L crc_buffer_reg_4 ( .D(N171), .CP(clk), .CR(1'b1), .LD(n39), .Q(
  FDS2L crc_buffer_reg_4 ( .D(N171), .CP(ck2 ), .CR(1'b1), .LD(n39), .Q(
        crc_buffer_4), .QN(n136) );
//   FDS2L crc_buffer_reg_3 ( .D(N170), .CP(clk), .CR(1'b1), .LD(n39), .Q(
  FDS2L crc_buffer_reg_3 ( .D(N170), .CP(ck2 ), .CR(1'b1), .LD(n39), .Q(
        crc_buffer_3), .QN(n133) );
//   FDS2L crc_buffer_reg_1 ( .D(N168), .CP(clk), .CR(1'b1), .LD(n39), .Q(
  FDS2L crc_buffer_reg_1 ( .D(N168), .CP(ck2 ), .CR(1'b1), .LD(n39), .Q(
        crc_buffer_1), .QN(n125) );
//   FDS2L crc_buffer_reg_7 ( .D(N174), .CP(clk), .CR(1'b1), .LD(n39), .Q(
  FDS2L crc_buffer_reg_7 ( .D(N174), .CP(ck2 ), .CR(1'b1), .LD(n39), .Q(
        crc_buffer_7), .QN(n147) );
  EO U131 ( .A(crc_end_1), .B(crc_end_0), .Z(N157) );
//   FDS2L crc_buffer_reg_24 ( .D(N191), .CP(clk), .CR(1'b1), .LD(n39), .Q(
  FDS2L crc_buffer_reg_24 ( .D(N191), .CP(
//     ), .CR(1'b1), .LD(n39), .Q(
    ck2 ), .CR(1'b1), .LD(n39), .Q(
        crc_buffer_24) );
//   FDS2L crc_buffer_reg_12 ( .D(N179), .CP(clk), .CR(1'b1), .LD(n39), .Q(
  FDS2L crc_buffer_reg_12 ( .D(N179), .CP(
//     ), .CR(1'b1), .LD(n39), .Q(
    ck2 ), .CR(1'b1), .LD(n39), .Q(
        crc_buffer_12) );
//   FDS2L crc_buffer_reg_23 ( .D(N190), .CP(clk), .CR(1'b1), .LD(n39), .Q(
  FDS2L crc_buffer_reg_23 ( .D(N190), .CP(
//     ), .CR(1'b1), .LD(n39), .Q(
    ck2 ), .CR(1'b1), .LD(n39), .Q(
        crc_buffer_23) );
//   FDS2L crc_buffer_reg_13 ( .D(N180), .CP(clk), .CR(1'b1), .LD(n39), .Q(
  FDS2L crc_buffer_reg_13 ( .D(N180), .CP(
//     ), .CR(1'b1), .LD(n39), .Q(
    ck2 ), .CR(1'b1), .LD(n39), .Q(
        crc_buffer_13) );
//   FDS2L crc_buffer_reg_14 ( .D(N181), .CP(clk), .CR(1'b1), .LD(n39), .Q(
  FDS2L crc_buffer_reg_14 ( .D(N181), .CP(
//     ), .CR(1'b1), .LD(n39), .Q(
    ck2 ), .CR(1'b1), .LD(n39), .Q(
        crc_buffer_14) );
//   FDS2L crc_buffer_reg_18 ( .D(N185), .CP(clk), .CR(1'b1), .LD(n39), .Q(
  FDS2L crc_buffer_reg_18 ( .D(N185), .CP(
//     ), .CR(1'b1), .LD(n39), .Q(
    ck2 ), .CR(1'b1), .LD(n39), .Q(
        crc_buffer_18) );
//   FDS2L crc_buffer_reg_25 ( .D(N192), .CP(clk), .CR(1'b1), .LD(n39), .Q(
  FDS2L crc_buffer_reg_25 ( .D(N192), .CP(
//     ), .CR(1'b1), .LD(n39), .Q(
    ck2 ), .CR(1'b1), .LD(n39), .Q(
        crc_buffer_25) );
//   FDS2L crc_buffer_reg_15 ( .D(N182), .CP(clk), .CR(1'b1), .LD(n39), .Q(
  FDS2L crc_buffer_reg_15 ( .D(N182), .CP(
//     ), .CR(1'b1), .LD(n39), .Q(
    ck2 ), .CR(1'b1), .LD(n39), .Q(
        crc_buffer_15) );
//   FDS2L crc_buffer_reg_11 ( .D(N178), .CP(clk), .CR(1'b1), .LD(n39), .Q(
  FDS2L crc_buffer_reg_11 ( .D(N178), .CP(
//     ), .CR(1'b1), .LD(n39), .Q(
    ck2 ), .CR(1'b1), .LD(n39), .Q(
        crc_buffer_11) );
//   FDS2L crc_buffer_reg_27 ( .D(N194), .CP(clk), .CR(1'b1), .LD(n39), .Q(
  FDS2L crc_buffer_reg_27 ( .D(N194), .CP(
//     ), .CR(1'b1), .LD(n39), .Q(
    ck2 ), .CR(1'b1), .LD(n39), .Q(
        crc_buffer_27) );
//   FDS2L crc_buffer_reg_17 ( .D(N184), .CP(clk), .CR(1'b1), .LD(n39), .Q(
  FDS2L crc_buffer_reg_17 ( .D(N184), .CP(
//     ), .CR(1'b1), .LD(n39), .Q(
    ck2 ), .CR(1'b1), .LD(n39), .Q(
        crc_buffer_17) );
//   FDS2L crc_buffer_reg_16 ( .D(N183), .CP(clk), .CR(1'b1), .LD(n39), .Q(
  FDS2L crc_buffer_reg_16 ( .D(N183), .CP(
//     ), .CR(1'b1), .LD(n39), .Q(
    ck2 ), .CR(1'b1), .LD(n39), .Q(
        crc_buffer_16) );
//   FDS2L crc_buffer_reg_26 ( .D(N193), .CP(clk), .CR(1'b1), .LD(n39), .Q(
  FDS2L crc_buffer_reg_26 ( .D(N193), .CP(
//     ), .CR(1'b1), .LD(n39), .Q(
    ck2 ), .CR(1'b1), .LD(n39), .Q(
        crc_buffer_26) );
  NR2 U132 ( .A(N8), .B(n108), .Z(n39) );
  EN U133 ( .A(n127), .B(n177), .Z(n40) );
  EN U134 ( .A(n120), .B(n194), .Z(n41) );
  AN2 U135 ( .A(n205), .B(n53), .Z(n42) );
  AN2 U136 ( .A(n205), .B(n115), .Z(n43) );
  EN U137 ( .A(n155), .B(n177), .Z(n44) );
//   FDS2L crc_end_reg_2 ( .D(N164), .CP(clk), .CR(1'b1), .LD(n61), .QN(n99) );
  FDS2L crc_end_reg_2 ( .D(N164), .CP(
//     ), .CR(1'b1), .LD(n61), .QN(n99) );
    ck2 ), .CR(1'b1), .LD(n61), .QN(n99) );
  AN2 U138 ( .A(n205), .B(n121), .Z(n45) );
  EN U139 ( .A(n155), .B(n204), .Z(n46) );
  AN2 U140 ( .A(state_crc[1]), .B(state_crc[0]), .Z(n47) );
  EN U141 ( .A(n41), .B(crc[3]), .Z(n48) );
  EN U142 ( .A(n44), .B(crc[3]), .Z(n49) );
  EN U143 ( .A(n40), .B(crc[3]), .Z(n50) );
  AN2 U144 ( .A(n205), .B(crc[1]), .Z(n51) );
  AN2 U145 ( .A(n205), .B(crc[0]), .Z(n52) );
  EN U146 ( .A(crc_buffer_31), .B(n194), .Z(n53) );
  AN2 U147 ( .A(n122), .B(n205), .Z(n54) );
  AN2 U148 ( .A(n116), .B(n205), .Z(n55) );
  AN2 U149 ( .A(n205), .B(crc_buffer_31), .Z(n56) );
  EN U150 ( .A(crc_buffer_29), .B(n204), .Z(n57) );
  EN U151 ( .A(crc_buffer_30), .B(n209), .Z(n58) );
  AN2 U152 ( .A(n205), .B(crc_buffer_30), .Z(n59) );
  EN U153 ( .A(crc_buffer_28), .B(n177), .Z(n60) );
  AN2 U154 ( .A(n103), .B(reset_n), .Z(n61) );
  AN2P U192 ( .A(N156), .B(n47), .Z(N162) );
  OR2 U193 ( .A(state_crc[1]), .B(state_crc[0]), .Z(n104) );
  OR3 U194 ( .A(crc_end_0), .B(n101), .C(n99), .Z(n102) );
  AN2P U195 ( .A(N157), .B(n47), .Z(N163) );
  AN2P U196 ( .A(N158), .B(n47), .Z(N164) );
  OR3 U197 ( .A(n107), .B(n47), .C(n106), .Z(N241) );
  EO3P U198 ( .A(crc_buffer_8), .B(n50), .C(n148), .Z(n150) );
  EO3P U199 ( .A(n46), .B(crc[2]), .C(n151), .Z(n152) );
  MUX21H U200 ( .A(n175), .B(n174), .S(crc_buffer_12), .Z(n162) );
  MUX21H U201 ( .A(n164), .B(n201), .S(crc_buffer_13), .Z(n165) );
  MUX21H U202 ( .A(n167), .B(n206), .S(crc_buffer_14), .Z(n168) );
  MUX21H U203 ( .A(n175), .B(n174), .S(crc_buffer_18), .Z(n176) );
  EO3P U204 ( .A(crc_buffer_29), .B(crc_buffer_19), .C(n178), .Z(n181) );
  EO3P U205 ( .A(crc_buffer_31), .B(crc_buffer_22), .C(crc_buffer_28), .Z(n195) );
  MUX21H U206 ( .A(n202), .B(n201), .S(crc_buffer_23), .Z(n203) );
  MUX21H U207 ( .A(n207), .B(n206), .S(crc_buffer_24), .Z(n208) );
endmodule


module data_mux ( data_select, data_in, crc, data_out );
  input [1:0] data_select;
  input [3:0] data_in;
  input [3:0] crc;
  output [3:0] data_out;
  wire   n2, n3, n4, n5, n6, n7, n8;

  EON1 U3 ( .A(data_select[0]), .B(n8), .C(data_select[1]), .D(crc[3]), .Z(
        data_out[3]) );
  IVP U4 ( .A(data_select[0]), .Z(n4) );
  MUX21L U5 ( .A(n6), .B(n5), .S(data_select[1]), .Z(data_out[1]) );
  ND2 U6 ( .A(data_in[1]), .B(n4), .Z(n6) );
  ND2 U7 ( .A(crc[1]), .B(data_select[0]), .Z(n5) );
  NR2 U8 ( .A(data_in[3]), .B(data_select[1]), .Z(n8) );
  EN U9 ( .A(data_select[1]), .B(n4), .Z(n2) );
  MUX21H U10 ( .A(data_in[0]), .B(crc[0]), .S(data_select[0]), .Z(n3) );
  OR2 U11 ( .A(n2), .B(n3), .Z(data_out[0]) );
  MUX21H U12 ( .A(data_in[2]), .B(crc[2]), .S(data_select[0]), .Z(n7) );
  OR2 U13 ( .A(n2), .B(n7), .Z(data_out[2]) );
endmodule


module tx_state_machine ( tx_sof, tx_eof, tx_underrun, clk, reset_n, 
        transmit_available_p, excess_deferral, coll_event_p, late_coll, 
        excessive_coll, backoff_p, count_length, count_fcs, excessive_length, 
        count_jam, tx_data_used, tx_done, tx_abort, tx_retransmit, tx_status, 
        tx_status_valid_n, transmit_new_p, transmit_enable, transmit_preamble, 
        transmit_sfd, transmit_fcs, transmit_error, start_backoff, compute_crc, 
        data_select );
  input [11:0] count_length;
  input [3:0] count_fcs;
  input [3:0] count_jam;
  output [6:0] tx_status;
  output [1:0] data_select;
  input tx_sof, tx_eof, tx_underrun, clk, reset_n, transmit_available_p,
         excess_deferral, coll_event_p, late_coll, excessive_coll, backoff_p,
         excessive_length;
  output tx_data_used, tx_done, tx_abort, tx_retransmit, tx_status_valid_n,
         transmit_new_p, transmit_enable, transmit_preamble, transmit_sfd,
         transmit_fcs, transmit_error, start_backoff, compute_crc;
  wire   excess_deferral, late_coll, excessive_coll, excessive_length, N75,
         start_backoff, next_tx_state_1, next_tx_state_3, next_tx_state_0, n15,
         n16, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31,
         n32, n33, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45, n46,
         n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58, n59, n60,
         n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71, n72, n73, n74,
         n75, n76, n77, n78, n79, n80, n81, n82, n83, n84, n85, n86, n87, n88,
         n89, n90, n91, n92, n93, n94, n95, n96, n97, n98, n99, n100, n101,
         n102, n103, n104, n105, n106, n107, n108, n109, n110, n111;
  wire   [3:0] current_tx_state;
    wire ck2 ;
    wire ck1 ;
    IVP  u_ck2 (.A (ck1 ),.Z (ck2 ));
    IVP  u_ck1 (.A (clk ),.Z (ck1 ));
  assign tx_status[3] = 1'b0;
  assign tx_status[0] = excess_deferral;
  assign tx_status[1] = late_coll;
  assign tx_status[2] = excessive_coll;
  assign tx_status[4] = excessive_length;
  assign tx_retransmit = start_backoff;

//   FD2 current_tx_state_reg_3 ( .D(next_tx_state_3), .CP(clk), .CD(reset_n), 
  FD2 current_tx_state_reg_3 ( .D(next_tx_state_3), .CP(
//     ), .CD(reset_n), 
    ck2 ), .CD(reset_n), 
        .Q(current_tx_state[3]), .QN(n60) );
  ND2 U3 ( .A(current_tx_state[2]), .B(n43), .Z(n59) );
  IVP U4 ( .A(n82), .Z(transmit_fcs) );
  ND2 U5 ( .A(current_tx_state[1]), .B(n60), .Z(n42) );
  ND2 U6 ( .A(n67), .B(n82), .Z(data_select[1]) );
  ND2 U7 ( .A(n64), .B(n93), .Z(compute_crc) );
  AO3 U8 ( .A(n101), .B(n67), .C(n66), .D(n65), .Z(n68) );
  ND2 U9 ( .A(n69), .B(n85), .Z(n70) );
  AO3 U10 ( .A(n82), .B(n96), .C(n81), .D(n80), .Z(n83) );
  NR2 U11 ( .A(n24), .B(n23), .Z(n33) );
//   FD2S current_tx_state_reg_2 ( .D(1'b1), .CP(clk), .CD(reset_n), .TI(n70), 
  FD2S current_tx_state_reg_2 ( .D(1'b1), .CP(
//     ), .CD(reset_n), .TI(n70), 
    ck2 ), .CD(reset_n), .TI(n70), 
        .TE(n98), .Q(current_tx_state[2]), .QN(n37) );
//   FD2 current_tx_state_reg_1 ( .D(next_tx_state_1), .CP(clk), .CD(reset_n), 
  FD2 current_tx_state_reg_1 ( .D(next_tx_state_1), .CP(
//     ), .CD(reset_n), 
    ck2 ), .CD(reset_n), 
        .Q(current_tx_state[1]), .QN(n50) );
  IVP U12 ( .A(n86), .Z(n78) );
  ND2 U13 ( .A(n36), .B(n35), .Z(n67) );
  IVP U14 ( .A(n64), .Z(tx_data_used) );
  IVP U15 ( .A(n68), .Z(n85) );
  ND4 U16 ( .A(n73), .B(n72), .C(n71), .D(n97), .Z(next_tx_state_0) );
  AO7 U17 ( .A(n53), .B(n52), .C(n51), .Z(n77) );
  IVP U18 ( .A(n83), .Z(n106) );
  IVP U19 ( .A(n54), .Z(start_backoff) );
  ND4 U20 ( .A(n94), .B(n93), .C(n92), .D(n91), .Z(n95) );
  IVP U21 ( .A(n110), .Z(n63) );
  IVP U22 ( .A(excessive_length), .Z(n96) );
  ND2 U23 ( .A(n16), .B(current_tx_state[3]), .Z(n109) );
  ND2 U24 ( .A(n22), .B(n21), .Z(n23) );
  AO7 U25 ( .A(n29), .B(n28), .C(n27), .Z(n30) );
  ND2 U26 ( .A(n26), .B(n25), .Z(n31) );
  IVP U27 ( .A(backoff_p), .Z(n104) );
//   FD2 current_tx_state_reg_0 ( .D(next_tx_state_0), .CP(clk), .CD(reset_n), 
  FD2 current_tx_state_reg_0 ( .D(next_tx_state_0), .CP(
//     ), .CD(reset_n), 
    ck2 ), .CD(reset_n), 
        .Q(current_tx_state[0]), .QN(n43) );
  IVP U28 ( .A(n93), .Z(n57) );
  ND2 U29 ( .A(current_tx_state[3]), .B(current_tx_state[2]), .Z(n41) );
  IVP U30 ( .A(n59), .Z(n35) );
  IVP U31 ( .A(n42), .Z(n36) );
  IVP U32 ( .A(n67), .Z(transmit_sfd) );
  IVP U33 ( .A(n45), .Z(n38) );
  IVP U34 ( .A(n79), .Z(n58) );
  IVP U35 ( .A(n70), .Z(n97) );
  IVP U36 ( .A(n77), .Z(n81) );
  IVP U37 ( .A(compute_crc), .Z(n53) );
  AO6 U38 ( .A(tx_data_used), .B(n79), .C(n78), .Z(n80) );
  ND2 U39 ( .A(N75), .B(n15), .Z(n71) );
  ND3 U40 ( .A(n85), .B(n84), .C(n106), .Z(next_tx_state_1) );
  NR2 U41 ( .A(count_length[11]), .B(count_length[10]), .Z(n47) );
  IVP U42 ( .A(n87), .Z(n88) );
  AO2 U43 ( .A(start_backoff), .B(n104), .C(tx_data_used), .D(coll_event_p), 
        .Z(n91) );
  AO7 U44 ( .A(n63), .B(transmit_fcs), .C(coll_event_p), .Z(n66) );
  IVP U45 ( .A(count_length[5]), .Z(n49) );
  IVP U46 ( .A(count_length[6]), .Z(n48) );
  AO2 U47 ( .A(n63), .B(n96), .C(n78), .D(n62), .Z(n69) );
  IVP U48 ( .A(n99), .Z(n74) );
  NR2 U49 ( .A(n96), .B(n110), .Z(n75) );
  AO2 U50 ( .A(transmit_fcs), .B(n105), .C(start_backoff), .D(n104), .Z(n107)
         );
  ND2 U51 ( .A(n45), .B(n44), .Z(n46) );
  IVP U52 ( .A(count_length[7]), .Z(n89) );
  NR2 U53 ( .A(n54), .B(n104), .Z(n55) );
  IVP U54 ( .A(count_length[0]), .Z(n90) );
  IVP U55 ( .A(count_fcs[3]), .Z(n102) );
  IVP U56 ( .A(coll_event_p), .Z(n52) );
  IVP U57 ( .A(n109), .Z(tx_abort) );
  IVP U58 ( .A(count_length[11]), .Z(n21) );
  IVP U59 ( .A(count_length[10]), .Z(n22) );
  ND2 U60 ( .A(count_jam[2]), .B(count_jam[0]), .Z(n61) );
  ND2 U61 ( .A(n20), .B(n19), .Z(n24) );
  AO7 U62 ( .A(n31), .B(n30), .C(count_length[7]), .Z(n32) );
  ND2 U63 ( .A(count_length[1]), .B(count_length[0]), .Z(n28) );
  IVP U64 ( .A(n108), .Z(tx_done) );
  IVP U65 ( .A(count_length[3]), .Z(n27) );
  NR2 U66 ( .A(count_length[6]), .B(count_length[5]), .Z(n26) );
  IVP U67 ( .A(count_length[2]), .Z(n29) );
  IVP U68 ( .A(excess_deferral), .Z(n100) );
  IVP U69 ( .A(tx_sof), .Z(n101) );
//   FD1 transmit_error_reg ( .D(tx_underrun), .CP(clk), .Q(transmit_error) );
  FD1 transmit_error_reg ( .D(tx_underrun), .CP(
//     ), .Q(transmit_error) );
    ck2 ), .Q(transmit_error) );
  IVP U70 ( .A(n41), .Z(n39) );
  IVP U71 ( .A(tx_status[5]), .Z(tx_status[6]) );
  AN2 U72 ( .A(n58), .B(tx_data_used), .Z(n15) );
  NR3 U73 ( .A(current_tx_state[2]), .B(n50), .C(n43), .Z(n16) );
  AN2 U74 ( .A(n38), .B(current_tx_state[0]), .Z(transmit_new_p) );
  NR3 U75 ( .A(current_tx_state[2]), .B(current_tx_state[0]), .C(n42), .Z(
        transmit_preamble) );
  IVP U76 ( .A(count_length[4]), .Z(n25) );
  IVP U77 ( .A(count_length[8]), .Z(n20) );
  IVP U78 ( .A(count_length[9]), .Z(n19) );
  AN2P U79 ( .A(n33), .B(n32), .Z(N75) );
  OR4 U81 ( .A(n43), .B(n37), .C(current_tx_state[3]), .D(current_tx_state[1]), 
        .Z(n93) );
  OR3 U82 ( .A(n43), .B(n50), .C(n41), .Z(n86) );
  OR3 U83 ( .A(current_tx_state[3]), .B(current_tx_state[1]), .C(n59), .Z(n82)
         );
  OR4 U84 ( .A(n57), .B(transmit_preamble), .C(n78), .D(transmit_fcs), .Z(
        data_select[0]) );
  OR3 U85 ( .A(n43), .B(n37), .C(n42), .Z(n64) );
  OR3 U86 ( .A(n60), .B(n50), .C(n59), .Z(n54) );
  OR3 U87 ( .A(transmit_sfd), .B(tx_data_used), .C(data_select[0]), .Z(
        transmit_enable) );
  OR3 U88 ( .A(current_tx_state[3]), .B(current_tx_state[2]), .C(
        current_tx_state[1]), .Z(n45) );
  OR3 U89 ( .A(n39), .B(n43), .C(n38), .Z(n40) );
  OR3 U90 ( .A(n16), .B(n40), .C(transmit_enable), .Z(tx_status_valid_n) );
  OR2 U92 ( .A(tx_underrun), .B(excessive_length), .Z(n79) );
  OR4 U93 ( .A(excess_deferral), .B(late_coll), .C(excessive_coll), .D(n79), 
        .Z(tx_status[5]) );
  OR3 U94 ( .A(current_tx_state[1]), .B(n43), .C(n41), .Z(n108) );
  OR3 U95 ( .A(current_tx_state[2]), .B(n43), .C(n42), .Z(n99) );
  OR3 U96 ( .A(transmit_available_p), .B(excess_deferral), .C(n99), .Z(n44) );
  AO1P U97 ( .A(tx_sof), .B(n46), .C(tx_done), .D(tx_abort), .Z(n73) );
  ND8 U98 ( .A(count_length[2]), .B(count_length[1]), .C(n25), .D(n49), .E(n48), .F(n20), .G(n47), .H(n19), .Z(n87) );
  OR4 U99 ( .A(n90), .B(n89), .C(count_length[3]), .D(n87), .Z(n56) );
  OR4 U100 ( .A(n60), .B(n50), .C(current_tx_state[2]), .D(current_tx_state[0]), .Z(n51) );
  AO1P U101 ( .A(n57), .B(n56), .C(n77), .D(n55), .Z(n72) );
  OR3 U102 ( .A(current_tx_state[1]), .B(n60), .C(n59), .Z(n110) );
  OR3 U103 ( .A(count_jam[3]), .B(count_jam[1]), .C(n61), .Z(n62) );
  OR3 U104 ( .A(tx_eof), .B(n64), .C(n79), .Z(n65) );
  OR3 U105 ( .A(transmit_new_p), .B(n74), .C(transmit_preamble), .Z(n76) );
  AO1P U106 ( .A(tx_sof), .B(n76), .C(n75), .D(start_backoff), .Z(n84) );
  OR3 U107 ( .A(late_coll), .B(excessive_coll), .C(n86), .Z(n94) );
  ND6P U108 ( .A(n90), .B(n89), .C(tx_sof), .D(n88), .E(transmit_preamble), 
        .F(count_length[3]), .Z(n92) );
  AO1P U109 ( .A(transmit_fcs), .B(n96), .C(n15), .D(n95), .Z(n98) );
  OR3 U110 ( .A(n101), .B(n100), .C(n99), .Z(n111) );
  AN4P U111 ( .A(count_fcs[2]), .B(count_fcs[1]), .C(count_fcs[0]), .D(n102), 
        .Z(n103) );
  OR2 U112 ( .A(n103), .B(coll_event_p), .Z(n105) );
  ND6P U113 ( .A(n111), .B(n110), .C(n109), .D(n108), .E(n107), .F(n106), .Z(
        next_tx_state_3) );
endmodule


module tx_clkgen (ckin1,ckin2,cken1, cken2, reset_n,  cko1,cko2);
input  ckin1,ckin2;
input  cken1,cken2;
input  reset_n;
output cko1, cko2;

    wire ck1 ;
    wire ck2 ;
    wire ck3 ;
    wire ck4 ;


    IVP  u_ck11 (.A (ckin1 ),.Z (ck1_1 ));
    IVP  u_ck12 (.A (ck1_1 ),.Z (ck1_2 ));
    IVP  u_ck13 (.A (ck1_2 ),.Z (ck1_3 ));
    IVP  u_ck14 (.A (ck1_3 ),.Z (ck1_4 ));

    IVP  u_ck21 (.A (ckin2 ),.Z (ck2_1 ));
    IVP  u_ck22 (.A (ck2_1 ),.Z (ck2_2 ));
    IVP  u_ck23 (.A (ck2_2 ),.Z (ck2_3 ));
    IVP  u_ck24 (.A (ck2_3 ),.Z (ck2_4 ));


    MUX21H u_muxA ( .A(ck1_4), .B(ck2_4), .S(cken1), .Z(cko1) );
//    LD4P   clk_div_reg ( .GN(ck2_4), .D(ckdiv), .CD(reset_n), .Q(ck2_5), .QN(ckdiv) );
    MUX21H u_muxB ( .A(ck1_4), .B(ck2_4), .S(cken2), .Z(cko2) );


endmodule


module txethmac ( tx_data, tx_sof, tx_eof, tx_underrun, full_duplex, reset_n, 
        crs, coll, tx_clk1, tx_clk2, tx_data_used, tx_done, tx_abort, tx_retransmit, 
        tx_status, tx_status_valid_n, txd, tx_en, tx_er ,tx_cko1, tx_cko2,
	tx_cken1, tx_cken2 );
  input [3:0] tx_data;
  output [6:0] tx_status;
  output [3:0] txd;
  input tx_sof, tx_eof, tx_underrun, full_duplex, reset_n, crs, coll, tx_clk1, tx_clk2;
  output tx_data_used, tx_done, tx_abort, tx_retransmit, tx_status_valid_n,
         tx_en, tx_er;
  output tx_cko1, tx_cko2 ;
  input  tx_cken1, tx_cken2;

  wire   transmit_error, transmit_enable, compute_crc, transmit_available_p,
         transmit_new_p, excess_deferral, transmit_preamble, transmit_sfd,
         late_coll, excessive_coll, coll_event_p, transmit_64byte,
         transmit_fcs, excessive_length, backoff_p, start_backoff;
  wire   [3:0] data;
  wire   [3:0] crc;
  wire   [1:0] data_select;
  wire   [3:0] coll_attempt;
  wire   [11:0] count_length;
  wire   [3:0] count_fcs;
  wire   [3:0] count_jam;
 wire   [9:0] random;
  wire   SYNOPSYS_UNCONNECTED__0;
  wire   tx_cko1 ;


  tx_clkgen tx_clkgen1 ( .ckin1(tx_clk1), .ckin2(tx_clk2), .cken1(tx_cken1), .cken2(tx_cken2),.reset_n(reset_n),
	 .cko1(tx_cko1), .cko2(tx_cko2));

  assign tx_status[3] = 1'b0;

  fifo_synch tx_1 ( .data({data[3], data[2], data[1], data[0]}), 
        .transmit_enable(transmit_enable), .transmit_error(transmit_error), 
        .clk(
       tx_cko1 ), .txd({txd[3], txd[2], txd[1], txd[0]}), .tx_en(tx_en), 
        .tx_er(tx_er) );
  ifg_timer tx_2 ( .crs(crs), .full_duplex(full_duplex), .transmit_enable(
        transmit_enable), .clk(   tx_cko1 ), .reset_n(reset_n), 
        .transmit_available_p(transmit_available_p) );
  defer_counter tx_3 ( .transmit_available_p(transmit_available_p), 
        .transmit_new_p(transmit_new_p), .clk( 
      tx_cko1 ), .reset_n(reset_n), 
        .excess_deferral(excess_deferral) );
  frame_length_counter tx_4 ( .transmit_enable(transmit_enable), 
        .transmit_fcs(transmit_fcs), .clk(   tx_cko1 ), .reset_n(reset_n), 
        .count_length({count_length[11], count_length[10], count_length[9], 
        count_length[8], count_length[7], count_length[6], count_length[5], 
        count_length[4], count_length[3], count_length[2], count_length[1], 
        count_length[0]}), .count_fcs({count_fcs[3], count_fcs[2], 
        count_fcs[1], count_fcs[0]}), .excessive_length(excessive_length), 
        .transmit_64byte(transmit_64byte) );
  coll_counter tx_5 ( .transmit_new_p(transmit_new_p), .transmit_enable(
        transmit_enable), .transmit_preamble(transmit_preamble), 
        .transmit_sfd(transmit_sfd), .transmit_64byte(transmit_64byte), .clk(
    tx_cko2 ), .reset_n(reset_n), .coll(coll), .full_duplex(full_duplex), 
        .coll_event_p(coll_event_p), .late_coll(late_coll), .excessive_coll(
        excessive_coll), .coll_attempt({coll_attempt[3], coll_attempt[2], 
        coll_attempt[1], coll_attempt[0]}) );
  random_number_gen tx_6 ( .coll_attempt({coll_attempt[3], coll_attempt[2], 
        coll_attempt[1], coll_attempt[0]}), .clk(
       tx_cko2 ), .reset_n(reset_n), 
        .random({random[9], random[8], random[7], random[6], random[5], 
        random[4], random[3], random[2], random[1], random[0]}) );
  backoff_timer tx_7 ( .start_backoff(start_backoff), .random({random[9], 
        random[8], random[7], random[6], random[5], random[4], random[3], 
        random[2], random[1], random[0]}), .clk(
       tx_cko1 ), .reset_n(reset_n), 
        .backoff_p(backoff_p) );
  jam_timer tx_8 ( .coll_event_p(coll_event_p), .clk(
    tx_cko2 ), .reset_n(reset_n), .count_jam({count_jam[3], count_jam[2], count_jam[1], count_jam[0]}) );
  crc_gen tx_9 ( .compute_crc(compute_crc), .data({data[3], data[2], data[1], 
        data[0]}), .clk( 
      tx_cko2 ), .reset_n(reset_n), .crc({crc[3], crc[2], 
        crc[1], crc[0]}) );
  data_mux tx_10 ( .data_select({data_select[1], data_select[0]}), .data_in({
        tx_data[3], tx_data[2], tx_data[1], tx_data[0]}), .crc({crc[3], crc[2], 
        crc[1], crc[0]}), .data_out({data[3], data[2], data[1], data[0]}) );
  tx_state_machine tx_11 ( .tx_sof(tx_sof), .tx_eof(tx_eof), .tx_underrun(
        tx_underrun), .clk(
       tx_cko1 ), .reset_n(reset_n), .transmit_available_p(
        transmit_available_p), .excess_deferral(excess_deferral), 
        .coll_event_p(coll_event_p), .late_coll(late_coll), .excessive_coll(
        excessive_coll), .backoff_p(backoff_p), .count_length({
        count_length[11], count_length[10], count_length[9], count_length[8], 
        count_length[7], count_length[6], count_length[5], count_length[4], 
        count_length[3], count_length[2], count_length[1], count_length[0]}), 
        .count_fcs({count_fcs[3], count_fcs[2], count_fcs[1], count_fcs[0]}), 
        .excessive_length(excessive_length), .count_jam({count_jam[3], 
        count_jam[2], count_jam[1], count_jam[0]}), .tx_data_used(tx_data_used), .tx_done(tx_done), .tx_abort(tx_abort), .tx_retransmit(tx_retransmit), 
        .tx_status({tx_status[6], tx_status[5], tx_status[4], 
        SYNOPSYS_UNCONNECTED__0, tx_status[2], tx_status[1], tx_status[0]}), 
        .tx_status_valid_n(tx_status_valid_n), .transmit_new_p(transmit_new_p), 
        .transmit_enable(transmit_enable), .transmit_preamble(
        transmit_preamble), .transmit_sfd(transmit_sfd), .transmit_fcs(
        transmit_fcs), .transmit_error(transmit_error), .start_backoff(
        start_backoff), .compute_crc(compute_crc), .data_select({
        data_select[1], data_select[0]}) );
  ifg_err tx_12 ( .crs(crs), .full_duplex(full_duplex), .transmit_enable(
        transmit_enable), .clk(   tx_cko1 ), .reset_n(reset_n), 
        .transmit_available_p(transmit_available_p) );
  

endmodule


module sync ( sync_clk, sync_reset, sync_in, sync_out );
  input [3:0] sync_in;
  output [3:0] sync_out;
  input sync_clk, sync_reset;

  wire   [3:0] tmp_sync;

  IVP u_ck1 ( .A(sync_clk), .Z(n155) );
  IVP u_ck2 ( .A(n155), .Z(n156) );
  IVP u_ck3 ( .A(n156), .Z(n157) );
  IVP u_ck4 ( .A(n157), .Z(n158) );

  FD2 tmp_sync_reg_2 ( .D(sync_in[2]), .CP(n158), .CD(sync_reset), .Q(
        tmp_sync[2]) );
  FD2 sync_out_reg_1 ( .D(tmp_sync[1]), .CP(n158), .CD(sync_reset), .Q(
        sync_out[1]) );
  FD2 sync_out_reg_3 ( .D(tmp_sync[3]), .CP(n158), .CD(sync_reset), .Q(
        sync_out[3]) );
  FD2 sync_out_reg_0 ( .D(tmp_sync[0]), .CP(n158), .CD(sync_reset), .Q(
        sync_out[0]) );
  FD2 sync_out_reg_2 ( .D(tmp_sync[2]), .CP(n158), .CD(sync_reset), .Q(
        sync_out[2]) );
  FD2 tmp_sync_reg_0 ( .D(sync_in[0]), .CP(n158), .CD(sync_reset), .Q(
        tmp_sync[0]) );
  FD2 tmp_sync_reg_1 ( .D(sync_in[1]), .CP(n158), .CD(sync_reset), .Q(
        tmp_sync[1]) );
  FD2 tmp_sync_reg_3 ( .D(sync_in[3]), .CP(n158), .CD(sync_reset), .Q(
        tmp_sync[3]) );
endmodule


module rx_clkgen ( clk, reset_n, en, clko1, clko2 );
  input clk, reset_n, en;
  output clko1, clko2;
  wire   clk, N1;

  IVP u_ck1 ( .A(clk), .Z(n147) );
  IVP u_ck2 ( .A(n147), .Z(n148) );
  IVP u_ck3 ( .A(n148), .Z(n149) );
  IVP u_ck4 ( .A(n149), .Z(n150) );
  IVP u_ck5 ( .A(n150), .Z(n151) );
  IVP u_ck6 ( .A(n151), .Z(clko1) );
  IVP u_ck7 ( .A(n148), .Z(n152) );
  IVP u_ck8 ( .A(n152), .Z(n153) );

  FT2 clk_div_reg ( .CP(n153), .CD(reset_n), .Q(N1) );
  AN2P U3 ( .A(en), .B(N1), .Z(clko2) );
endmodule


module rx_sm_DW01_inc_12_0 ( A, SUM );
  input [11:0] A;
  output [11:0] SUM;
  wire   \A[11] , \A[10] , \A[9] , \A[8] , \A[7] , \A[6] , \A[5] , \A[4] ,
         \A[3] , \A[2] , \A[1] , \A[0] , \SUM[11] , \SUM[10] , \SUM[9] ,
         \SUM[8] , \SUM[7] , \SUM[6] , \SUM[5] , \SUM[4] , \SUM[3] , \SUM[2] ,
         \SUM[1] , \SUM[0] , \carry[11] , \carry[10] , \carry[9] , \carry[8] ,
         \carry[7] , \carry[6] , \carry[5] , \carry[4] , \carry[3] ,
         \carry[2] ;
  assign \A[11]  = A[11];
  assign \A[10]  = A[10];
  assign \A[9]  = A[9];
  assign \A[8]  = A[8];
  assign \A[7]  = A[7];
  assign \A[6]  = A[6];
  assign \A[5]  = A[5];
  assign \A[4]  = A[4];
  assign \A[3]  = A[3];
  assign \A[2]  = A[2];
  assign \A[1]  = A[1];
  assign \A[0]  = A[0];
  assign SUM[11] = \SUM[11] ;
  assign SUM[10] = \SUM[10] ;
  assign SUM[9] = \SUM[9] ;
  assign SUM[8] = \SUM[8] ;
  assign SUM[7] = \SUM[7] ;
  assign SUM[6] = \SUM[6] ;
  assign SUM[5] = \SUM[5] ;
  assign SUM[4] = \SUM[4] ;
  assign SUM[3] = \SUM[3] ;
  assign SUM[2] = \SUM[2] ;
  assign SUM[1] = \SUM[1] ;
  assign SUM[0] = \SUM[0] ;

  HA1 U1_1_7 ( .A(\A[7] ), .B(\carry[7] ), .S(\SUM[7] ), .CO(\carry[8] ) );
  HA1 U1_1_5 ( .A(\A[5] ), .B(\carry[5] ), .S(\SUM[5] ), .CO(\carry[6] ) );
  HA1 U1_1_3 ( .A(\A[3] ), .B(\carry[3] ), .S(\SUM[3] ), .CO(\carry[4] ) );
  HA1 U1_1_1 ( .A(\A[1] ), .B(\A[0] ), .S(\SUM[1] ), .CO(\carry[2] ) );
  HA1 U1_1_9 ( .A(\A[9] ), .B(\carry[9] ), .S(\SUM[9] ), .CO(\carry[10] ) );
  HA1 U1_1_8 ( .A(\A[8] ), .B(\carry[8] ), .S(\SUM[8] ), .CO(\carry[9] ) );
  HA1 U1_1_6 ( .A(\A[6] ), .B(\carry[6] ), .S(\SUM[6] ), .CO(\carry[7] ) );
  HA1 U1_1_2 ( .A(\A[2] ), .B(\carry[2] ), .S(\SUM[2] ), .CO(\carry[3] ) );
  HA1 U1_1_4 ( .A(\A[4] ), .B(\carry[4] ), .S(\SUM[4] ), .CO(\carry[5] ) );
  HA1 U1_1_10 ( .A(\A[10] ), .B(\carry[10] ), .S(\SUM[10] ), .CO(\carry[11] )
         );
  EO U5 ( .A(\carry[11] ), .B(\A[11] ), .Z(\SUM[11] ) );
  IVP U6 ( .A(\A[0] ), .Z(\SUM[0] ) );
endmodule


module rx_sm_DW01_inc_13_0 ( A, SUM );
  input [12:0] A;
  output [12:0] SUM;
  wire   \A[12] , \A[11] , \A[10] , \A[9] , \A[8] , \A[7] , \A[6] , \A[5] ,
         \A[4] , \A[3] , \A[2] , \A[1] , \A[0] , \SUM[12] , \SUM[11] ,
         \SUM[10] , \SUM[9] , \SUM[8] , \SUM[7] , \SUM[6] , \SUM[5] , \SUM[4] ,
         \SUM[3] , \SUM[2] , \SUM[1] , \SUM[0] , \carry[12] , \carry[11] ,
         \carry[10] , \carry[9] , \carry[8] , \carry[7] , \carry[6] ,
         \carry[5] , \carry[4] , \carry[3] , \carry[2] ;
  assign \A[12]  = A[12];
  assign \A[11]  = A[11];
  assign \A[10]  = A[10];
  assign \A[9]  = A[9];
  assign \A[8]  = A[8];
  assign \A[7]  = A[7];
  assign \A[6]  = A[6];
  assign \A[5]  = A[5];
  assign \A[4]  = A[4];
  assign \A[3]  = A[3];
  assign \A[2]  = A[2];
  assign \A[1]  = A[1];
  assign \A[0]  = A[0];
  assign SUM[12] = \SUM[12] ;
  assign SUM[11] = \SUM[11] ;
  assign SUM[10] = \SUM[10] ;
  assign SUM[9] = \SUM[9] ;
  assign SUM[8] = \SUM[8] ;
  assign SUM[7] = \SUM[7] ;
  assign SUM[6] = \SUM[6] ;
  assign SUM[5] = \SUM[5] ;
  assign SUM[4] = \SUM[4] ;
  assign SUM[3] = \SUM[3] ;
  assign SUM[2] = \SUM[2] ;
  assign SUM[1] = \SUM[1] ;
  assign SUM[0] = \SUM[0] ;

  HA1 U1_1_3 ( .A(\A[3] ), .B(\carry[3] ), .S(\SUM[3] ), .CO(\carry[4] ) );
  HA1 U1_1_7 ( .A(\A[7] ), .B(\carry[7] ), .S(\SUM[7] ), .CO(\carry[8] ) );
  HA1 U1_1_8 ( .A(\A[8] ), .B(\carry[8] ), .S(\SUM[8] ), .CO(\carry[9] ) );
  HA1 U1_1_2 ( .A(\A[2] ), .B(\carry[2] ), .S(\SUM[2] ), .CO(\carry[3] ) );
  HA1 U1_1_5 ( .A(\A[5] ), .B(\carry[5] ), .S(\SUM[5] ), .CO(\carry[6] ) );
  HA1 U1_1_10 ( .A(\A[10] ), .B(\carry[10] ), .S(\SUM[10] ), .CO(\carry[11] )
         );
  EO U5 ( .A(\carry[12] ), .B(\A[12] ), .Z(\SUM[12] ) );
  HA1 U1_1_4 ( .A(\A[4] ), .B(\carry[4] ), .S(\SUM[4] ), .CO(\carry[5] ) );
  HA1 U1_1_1 ( .A(\A[1] ), .B(\A[0] ), .S(\SUM[1] ), .CO(\carry[2] ) );
  HA1 U1_1_6 ( .A(\A[6] ), .B(\carry[6] ), .S(\SUM[6] ), .CO(\carry[7] ) );
  HA1 U1_1_9 ( .A(\A[9] ), .B(\carry[9] ), .S(\SUM[9] ), .CO(\carry[10] ) );
  HA1 U1_1_11 ( .A(\A[11] ), .B(\carry[11] ), .S(\SUM[11] ), .CO(\carry[12] )
         );
  IVP U6 ( .A(\A[0] ), .Z(\SUM[0] ) );
endmodule


module rx_sm ( clk, reset_n, rx_dv, rx_error, SFD_detected, address_match, 
        multicast, broadcast, crc_ok, SFD_start_detect, data_en, 
        FCS_start_check, last_data, data_valid, rx_status_valid_n, rx_status
 );
  output [15:0] rx_status;
  input clk, reset_n, rx_dv, rx_error, SFD_detected, address_match, multicast,
         broadcast, crc_ok;
  output SFD_start_detect, data_en, FCS_start_check, last_data, data_valid,
         rx_status_valid_n;
  wire   N0, N2, N7, N12, rx_error_temp, N37, nibble_count_temp_12,
         nibble_count_temp_11, nibble_count_temp_10, nibble_count_temp_9,
         nibble_count_temp_8, nibble_count_temp_7, nibble_count_temp_6,
         nibble_count_temp_5, nibble_count_temp_4, nibble_count_temp_3,
         nibble_count_temp_2, address_match_temp, broadcast_temp,
         multicast_temp, nibble_count_11, nibble_count_10, nibble_count_9,
         nibble_count_8, nibble_count_7, nibble_count_6, nibble_count_5,
         nibble_count_4, nibble_count_3, nibble_count_2, nibble_count_1,
         nibble_count_0, N129, N135, N137, N139, N141, N143, N145, N147, N149,
         N151, N153, N155, N157, N159, N161, N163, N165, N167, N170, N171,
         N188, N190, N191, N192, N193, N213, N217, N218, N219, N220, N221,
         N222, N223, N224, N225, N226, N227, N228, N229, N230, N231, N232,
         N233, N234, N235, N236, N237, N268, N269, N288, N289, N290, N315,
         N316, N317, N318, N319, N320, N321, N322, N323, N324, N325, N326, n63,
         n64, n65, n66, n67, n68, \add_93/carry[12] , \add_93/carry[11] ,
         \add_93/carry[10] , \add_93/carry[9] , \add_93/carry[8] ,
         \add_93/carry[7] , \add_93/carry[6] , \add_93/carry[5] ,
         \add_93/carry[4] , \add_93/carry[3] , \add_93/carry[2] , n123, n124,
         n125, n126, n127, n128, n129, n130, n131, n132, n133, n134, n135,
         n136, n137, n138, n139, n140, n141, n142, n143, n144, n145, n146,
         n147, n148, n149, n150, n151, n152, n153, n154, n155, n156, n157,
         n158, n159, n160;
  wire   [3:0] rx_sm_state;

  FDS2L data_en_reg ( .D(n64), .CP(clk), .CR(1'b1), .LD(N192), .Q(data_en) );
  AO7 U3 ( .A(n147), .B(n156), .C(n146), .Z(n150) );
  ND2 U4 ( .A(n145), .B(reset_n), .Z(n158) );
  IVP U5 ( .A(n130), .Z(N170) );
  FD2S nibble_count_temp_reg_0 ( .D(1'b0), .CP(clk), .CD(reset_n), .TI(data_en), .TE(N225), .Q(N12) );
  ND2 U6 ( .A(rx_sm_state[2]), .B(n142), .Z(n148) );
  FD2S nibble_count_temp_reg_2 ( .D(1'b0), .CP(clk), .CD(reset_n), .TI(data_en), .TE(N227), .Q(nibble_count_temp_2) );
  FD2S nibble_count_temp_reg_8 ( .D(1'b0), .CP(clk), .CD(reset_n), .TI(data_en), .TE(N233), .Q(nibble_count_temp_8) );
  FD2S nibble_count_temp_reg_11 ( .D(1'b0), .CP(clk), .CD(reset_n), .TI(
        data_en), .TE(N236), .Q(nibble_count_temp_11) );
  FD2S nibble_count_temp_reg_5 ( .D(1'b0), .CP(clk), .CD(reset_n), .TI(data_en), .TE(N230), .Q(nibble_count_temp_5) );
  FD2S nibble_count_temp_reg_10 ( .D(1'b0), .CP(clk), .CD(reset_n), .TI(
        data_en), .TE(N235), .Q(nibble_count_temp_10) );
  ND2 U7 ( .A(rx_dv), .B(N135), .Z(n152) );
  IVP U8 ( .A(N288), .Z(n138) );
  ND2 U9 ( .A(N135), .B(n157), .Z(n128) );
  ND2 U10 ( .A(n138), .B(n68), .Z(n139) );
  FJK2S nibble_count_reg_0 ( .J(1'b0), .K(1'b0), .CP(clk), .CD(reset_n), .TI(
        N12), .TE(data_en), .Q(nibble_count_0) );
  AO7 U11 ( .A(n156), .B(n65), .C(n146), .Z(n130) );
  FD2S nibble_count_temp_reg_4 ( .D(1'b0), .CP(clk), .CD(reset_n), .TI(data_en), .TE(N229), .Q(nibble_count_temp_4) );
  FD2S nibble_count_temp_reg_9 ( .D(1'b0), .CP(clk), .CD(reset_n), .TI(data_en), .TE(N234), .Q(nibble_count_temp_9) );
  FD2S nibble_count_temp_reg_6 ( .D(1'b0), .CP(clk), .CD(reset_n), .TI(data_en), .TE(N231), .Q(nibble_count_temp_6) );
  FD2S nibble_count_temp_reg_7 ( .D(1'b0), .CP(clk), .CD(reset_n), .TI(data_en), .TE(N232), .Q(nibble_count_temp_7) );
  FD2S nibble_count_temp_reg_3 ( .D(1'b0), .CP(clk), .CD(reset_n), .TI(data_en), .TE(N228), .Q(nibble_count_temp_3) );
  ND2 U12 ( .A(n135), .B(n64), .Z(n153) );
  FD2 rx_sm_state_reg_1 ( .D(N290), .CP(clk), .CD(reset_n), .Q(rx_sm_state[1]), 
        .QN(n141) );
  AO7 U13 ( .A(n158), .B(n151), .C(n150), .Z(N192) );
  ND2 U14 ( .A(rx_dv), .B(SFD_detected), .Z(n134) );
  IVP U15 ( .A(n154), .Z(N135) );
  FD2 rx_sm_state_reg_0 ( .D(N289), .CP(clk), .CD(reset_n), .Q(rx_sm_state[0]), 
        .QN(n142) );
  FJK2S nibble_count_reg_11 ( .J(1'b0), .K(1'b0), .CP(clk), .CD(reset_n), .TI(
        nibble_count_temp_11), .TE(data_en), .Q(nibble_count_11) );
  AO6 U16 ( .A(n127), .B(n138), .C(N37), .Z(N171) );
  FDS2L FCS_start_check_reg ( .D(n64), .CP(clk), .CR(1'b1), .LD(N193), .Q(
        FCS_start_check) );
  NR2 U17 ( .A(n159), .B(n158), .Z(N188) );
  FDS2L SFD_start_detect_reg ( .D(N129), .CP(clk), .CR(1'b1), .LD(N191), .Q(
        SFD_start_detect) );
  IVP U18 ( .A(n150), .Z(N190) );
  FD2S rx_sm_state_reg_2 ( .D(n144), .CP(clk), .CD(reset_n), .TI(1'b0), .TE(
        n139), .Q(rx_sm_state[2]), .QN(n129) );
  IVP U19 ( .A(rx_dv), .Z(n157) );
  NR2 U20 ( .A(n141), .B(n148), .Z(n136) );
  FD2S nibble_count_temp_reg_12 ( .D(1'b0), .CP(clk), .CD(reset_n), .TI(N237), 
        .TE(data_en), .Q(nibble_count_temp_12) );
  IVP U21 ( .A(n128), .Z(n156) );
  FJK2S nibble_count_reg_5 ( .J(1'b0), .K(1'b0), .CP(clk), .CD(reset_n), .TI(
        nibble_count_temp_5), .TE(data_en), .Q(nibble_count_5) );
  FJK2S nibble_count_reg_9 ( .J(1'b0), .K(1'b0), .CP(clk), .CD(reset_n), .TI(
        nibble_count_temp_9), .TE(data_en), .Q(nibble_count_9) );
  FJK2S nibble_count_reg_8 ( .J(1'b0), .K(1'b0), .CP(clk), .CD(reset_n), .TI(
        nibble_count_temp_8), .TE(data_en), .Q(nibble_count_8) );
  FJK2S nibble_count_reg_7 ( .J(1'b0), .K(1'b0), .CP(clk), .CD(reset_n), .TI(
        nibble_count_temp_7), .TE(data_en), .Q(nibble_count_7) );
  FJK2S nibble_count_reg_6 ( .J(1'b0), .K(1'b0), .CP(clk), .CD(reset_n), .TI(
        nibble_count_temp_6), .TE(data_en), .Q(nibble_count_6) );
  FJK2S nibble_count_reg_4 ( .J(1'b0), .K(1'b0), .CP(clk), .CD(reset_n), .TI(
        nibble_count_temp_4), .TE(data_en), .Q(nibble_count_4) );
  FJK2S nibble_count_reg_3 ( .J(1'b0), .K(1'b0), .CP(clk), .CD(reset_n), .TI(
        nibble_count_temp_3), .TE(data_en), .Q(nibble_count_3) );
  FJK2S nibble_count_reg_2 ( .J(1'b0), .K(1'b0), .CP(clk), .CD(reset_n), .TI(
        nibble_count_temp_2), .TE(data_en), .Q(nibble_count_2) );
  FJK2S nibble_count_reg_10 ( .J(1'b0), .K(1'b0), .CP(clk), .CD(reset_n), .TI(
        nibble_count_temp_10), .TE(data_en), .Q(nibble_count_10) );
  FJK2S nibble_count_reg_1 ( .J(1'b0), .K(1'b0), .CP(clk), .CD(reset_n), .TI(
        \add_93/carry[2] ), .TE(data_en), .Q(nibble_count_1) );
  IVP U22 ( .A(reset_n), .Z(N37) );
  IVP U23 ( .A(n158), .Z(n146) );
  AO6 U24 ( .A(n154), .B(n153), .C(n158), .Z(N191) );
  AO7 U25 ( .A(n140), .B(n139), .C(n138), .Z(N290) );
  AO7 U26 ( .A(n133), .B(n139), .C(n138), .Z(N289) );
  ND2 U27 ( .A(n148), .B(n152), .Z(n132) );
  IVP U28 ( .A(n151), .Z(n155) );
  IVP U29 ( .A(n153), .Z(n147) );
  IVP U30 ( .A(n139), .Z(n145) );
  IVP U31 ( .A(n134), .Z(n135) );
  FDS2L rx_error_temp_reg ( .D(N288), .CP(clk), .CR(1'b1), .LD(N171), .Q(
        rx_error_temp) );
  FDS2L multicast_temp_reg ( .D(N269), .CP(clk), .CR(1'b1), .LD(N213), .Q(
        multicast_temp) );
  FDS2L address_match_temp_reg ( .D(n63), .CP(clk), .CR(1'b1), .LD(N213), .Q(
        address_match_temp) );
  FDS2L broadcast_temp_reg ( .D(N268), .CP(clk), .CR(1'b1), .LD(N213), .Q(
        broadcast_temp) );
  ND2 U32 ( .A(n150), .B(n149), .Z(N193) );
  IVP U33 ( .A(n148), .Z(n143) );
  IVP U34 ( .A(n152), .Z(N129) );
  IVP U35 ( .A(address_match), .Z(n123) );
  FDS2L sending_data_n_status_reg ( .D(n64), .CP(clk), .CR(1'b1), .LD(N190), 
        .QN(n124) );
  FDS2L data_valid_reg ( .D(n64), .CP(clk), .CR(1'b1), .LD(N192), .Q(
        data_valid) );
  FDS2L last_data_reg ( .D(n66), .CP(clk), .CR(1'b1), .LD(N188), .Q(last_data)
         );
  FDS2L rx_status_reg_0 ( .D(N137), .CP(clk), .CR(1'b1), .LD(N170), .Q(
        rx_status[0]) );
  FDS2L rx_status_reg_1 ( .D(N139), .CP(clk), .CR(1'b1), .LD(N170), .Q(
        rx_status[1]) );
  FDS2L rx_status_reg_2 ( .D(N141), .CP(clk), .CR(1'b1), .LD(N170), .Q(
        rx_status[2]) );
  FDS2L rx_status_reg_3 ( .D(N143), .CP(clk), .CR(1'b1), .LD(N170), .Q(
        rx_status[3]) );
  FDS2L rx_status_reg_4 ( .D(N145), .CP(clk), .CR(1'b1), .LD(N170), .Q(
        rx_status[4]) );
  FDS2L rx_status_reg_5 ( .D(N147), .CP(clk), .CR(1'b1), .LD(N170), .Q(
        rx_status[5]) );
  FDS2L rx_status_reg_6 ( .D(N149), .CP(clk), .CR(1'b1), .LD(N170), .Q(
        rx_status[6]) );
  FDS2L rx_status_reg_7 ( .D(N151), .CP(clk), .CR(1'b1), .LD(N170), .Q(
        rx_status[7]) );
  FDS2L rx_status_reg_8 ( .D(N153), .CP(clk), .CR(1'b1), .LD(N170), .Q(
        rx_status[8]) );
  FDS2L rx_status_reg_9 ( .D(N155), .CP(clk), .CR(1'b1), .LD(N170), .Q(
        rx_status[9]) );
  FDS2L rx_status_reg_10 ( .D(N157), .CP(clk), .CR(1'b1), .LD(N170), .Q(
        rx_status[10]) );
  FDS2L rx_status_reg_11 ( .D(N159), .CP(clk), .CR(1'b1), .LD(N170), .Q(
        rx_status[11]) );
  FDS2L rx_status_reg_12 ( .D(N161), .CP(clk), .CR(1'b1), .LD(N170), .Q(
        rx_status[12]) );
  FDS2L rx_status_valid_n_reg ( .D(N135), .CP(clk), .CR(1'b1), .LD(N170), .Q(
        rx_status_valid_n) );
  FDS2L rx_status_reg_13 ( .D(N163), .CP(clk), .CR(1'b1), .LD(N170), .Q(
        rx_status[13]) );
  FDS2L rx_status_reg_14 ( .D(N165), .CP(clk), .CR(1'b1), .LD(N170), .Q(
        rx_status[14]) );
  FDS2L rx_status_reg_15 ( .D(N167), .CP(clk), .CR(1'b1), .LD(N170), .Q(
        rx_status[15]) );
  NR3 U36 ( .A(n123), .B(n124), .C(N37), .Z(n63) );
  NR3 U37 ( .A(rx_sm_state[2]), .B(rx_sm_state[1]), .C(n142), .Z(n64) );
  NR3 U38 ( .A(rx_sm_state[1]), .B(n129), .C(n142), .Z(n65) );
  NR3 U39 ( .A(rx_sm_state[2]), .B(rx_sm_state[0]), .C(n141), .Z(n66) );
  FD2S nibble_count_temp_reg_1 ( .D(1'b0), .CP(clk), .CD(reset_n), .TI(data_en), .TE(N226), .Q(\add_93/carry[2] ), .QN(n67) );
  EO U40 ( .A(nibble_count_temp_12), .B(\add_93/carry[12] ), .Z(N0) );
  AN2 U41 ( .A(\add_93/carry[11] ), .B(nibble_count_temp_11), .Z(
        \add_93/carry[12] ) );
  EO U42 ( .A(nibble_count_temp_11), .B(\add_93/carry[11] ), .Z(N224) );
  AN2 U43 ( .A(\add_93/carry[10] ), .B(nibble_count_temp_10), .Z(
        \add_93/carry[11] ) );
  EO U44 ( .A(nibble_count_temp_10), .B(\add_93/carry[10] ), .Z(N2) );
  AN2 U45 ( .A(\add_93/carry[9] ), .B(nibble_count_temp_9), .Z(
        \add_93/carry[10] ) );
  EO U46 ( .A(nibble_count_temp_9), .B(\add_93/carry[9] ), .Z(N223) );
  AN2 U47 ( .A(\add_93/carry[8] ), .B(nibble_count_temp_8), .Z(
        \add_93/carry[9] ) );
  EO U48 ( .A(nibble_count_temp_8), .B(\add_93/carry[8] ), .Z(N222) );
  AN2 U49 ( .A(\add_93/carry[7] ), .B(nibble_count_temp_7), .Z(
        \add_93/carry[8] ) );
  EO U50 ( .A(nibble_count_temp_7), .B(\add_93/carry[7] ), .Z(N221) );
  AN2 U51 ( .A(\add_93/carry[6] ), .B(nibble_count_temp_6), .Z(
        \add_93/carry[7] ) );
  EO U52 ( .A(nibble_count_temp_6), .B(\add_93/carry[6] ), .Z(N220) );
  AN2 U53 ( .A(\add_93/carry[5] ), .B(nibble_count_temp_5), .Z(
        \add_93/carry[6] ) );
  EO U54 ( .A(nibble_count_temp_5), .B(\add_93/carry[5] ), .Z(N7) );
  AN2 U55 ( .A(\add_93/carry[4] ), .B(nibble_count_temp_4), .Z(
        \add_93/carry[5] ) );
  EO U56 ( .A(nibble_count_temp_4), .B(\add_93/carry[4] ), .Z(N219) );
  AN2 U57 ( .A(\add_93/carry[3] ), .B(nibble_count_temp_3), .Z(
        \add_93/carry[4] ) );
  EO U58 ( .A(nibble_count_temp_3), .B(\add_93/carry[3] ), .Z(N218) );
  AN2 U59 ( .A(\add_93/carry[2] ), .B(nibble_count_temp_2), .Z(
        \add_93/carry[3] ) );
  EO U60 ( .A(nibble_count_temp_2), .B(\add_93/carry[2] ), .Z(N217) );
  FD2 rx_sm_state_reg_3 ( .D(1'b0), .CP(clk), .CD(reset_n), .Q(rx_sm_state[3]), 
        .QN(n68) );
  rx_sm_DW01_inc_12_0 add_167 ( .A({nibble_count_11, nibble_count_10, 
        nibble_count_9, nibble_count_8, nibble_count_7, nibble_count_6, 
        nibble_count_5, nibble_count_4, nibble_count_3, nibble_count_2, 
        nibble_count_1, nibble_count_0}), .SUM({N326, N325, N324, N323, N322, 
        N321, N320, N319, N318, N317, N316, N315}) );
  rx_sm_DW01_inc_13_0 add_189 ( .A({nibble_count_temp_12, nibble_count_temp_11, 
        nibble_count_temp_10, nibble_count_temp_9, nibble_count_temp_8, 
        nibble_count_temp_7, nibble_count_temp_6, nibble_count_temp_5, 
        nibble_count_temp_4, nibble_count_temp_3, nibble_count_temp_2, 
        \add_93/carry[2] , N12}), .SUM({N237, N236, N235, N234, N233, N232, 
        N231, N230, N229, N228, N227, N226, N225}) );
  AN2P U115 ( .A(broadcast), .B(n63), .Z(N268) );
  OR3 U116 ( .A(address_match), .B(n124), .C(N37), .Z(N213) );
  AN2P U117 ( .A(multicast), .B(n63), .Z(N269) );
  ND8 U118 ( .A(N218), .B(N217), .C(N219), .D(N220), .E(N221), .F(N222), .G(
        N223), .H(N224), .Z(n125) );
  NR6P U119 ( .A(n125), .B(N0), .C(N2), .D(N7), .E(N12), .F(n67), .Z(n126) );
  OR2 U120 ( .A(rx_error), .B(n126), .Z(N288) );
  OR3 U121 ( .A(rx_sm_state[2]), .B(rx_sm_state[1]), .C(rx_sm_state[0]), .Z(
        n154) );
  OR2 U122 ( .A(rx_sm_state[3]), .B(n128), .Z(n127) );
  AN2P U123 ( .A(n64), .B(n134), .Z(n131) );
  AO1P U124 ( .A(n66), .B(n157), .C(n132), .D(n131), .Z(n133) );
  OR3 U125 ( .A(n66), .B(n65), .C(n147), .Z(n137) );
  AO1P U126 ( .A(n64), .B(n157), .C(n137), .D(n136), .Z(n140) );
  OR3 U127 ( .A(rx_sm_state[2]), .B(n142), .C(n141), .Z(n151) );
  OR3 U128 ( .A(n143), .B(n155), .C(n65), .Z(n144) );
  OR3 U129 ( .A(rx_sm_state[1]), .B(n148), .C(n158), .Z(n149) );
  AO1P U130 ( .A(n66), .B(n157), .C(n156), .D(n155), .Z(n159) );
  AN2P U131 ( .A(rx_error_temp), .B(n65), .Z(N137) );
  AN2P U132 ( .A(address_match_temp), .B(n65), .Z(N139) );
  OR2 U133 ( .A(broadcast_temp), .B(multicast_temp), .Z(n160) );
  AN2P U134 ( .A(n65), .B(n160), .Z(N141) );
  AN2P U135 ( .A(crc_ok), .B(n65), .Z(N143) );
  AN2P U136 ( .A(N315), .B(n65), .Z(N145) );
  AN2P U137 ( .A(N316), .B(n65), .Z(N147) );
  AN2P U138 ( .A(N317), .B(n65), .Z(N149) );
  AN2P U139 ( .A(N318), .B(n65), .Z(N151) );
  AN2P U140 ( .A(N319), .B(n65), .Z(N153) );
  AN2P U141 ( .A(N320), .B(n65), .Z(N155) );
  AN2P U142 ( .A(N321), .B(n65), .Z(N157) );
  AN2P U143 ( .A(N322), .B(n65), .Z(N159) );
  AN2P U144 ( .A(N323), .B(n65), .Z(N161) );
  AN2P U145 ( .A(N324), .B(n65), .Z(N163) );
  AN2P U146 ( .A(N325), .B(n65), .Z(N165) );
  AN2P U147 ( .A(N326), .B(n65), .Z(N167) );
endmodule


module rx_buffer ( clk, reset_n, rx_data, data_tap, data, data_en );
  input [3:0] rx_data;
  output [3:0] data_tap;
  output [3:0] data;
  input clk, reset_n, data_en;

  wire   [3:0] data_temp;
  tri   [3:0] data;

  FD2 data_tap_reg_3 ( .D(rx_data[3]), .CP(clk), .CD(reset_n), .Q(data_tap[3])
         );
  FD2 data_tap_reg_1 ( .D(rx_data[1]), .CP(clk), .CD(reset_n), .Q(data_tap[1])
         );
  FD2 data_tap_reg_0 ( .D(rx_data[0]), .CP(clk), .CD(reset_n), .Q(data_tap[0])
         );
  FD2 data_tap_reg_2 ( .D(rx_data[2]), .CP(clk), .CD(reset_n), .Q(data_tap[2])
         );
  BTS4 data_tri_3 ( .A(data_temp[3]), .E(data_en), .Z(data[3]) );
  BTS4 data_tri_0 ( .A(data_temp[0]), .E(data_en), .Z(data[0]) );
  BTS4 data_tri_2 ( .A(data_temp[2]), .E(data_en), .Z(data[2]) );
  BTS4 data_tri_1 ( .A(data_temp[1]), .E(data_en), .Z(data[1]) );
  FD2 data_temp_reg_2 ( .D(data_tap[2]), .CP(clk), .CD(reset_n), .Q(
        data_temp[2]) );
  FD2 data_temp_reg_3 ( .D(data_tap[3]), .CP(clk), .CD(reset_n), .Q(
        data_temp[3]) );
  FD2 data_temp_reg_0 ( .D(data_tap[0]), .CP(clk), .CD(reset_n), .Q(
        data_temp[0]) );
  FD2 data_temp_reg_1 ( .D(data_tap[1]), .CP(clk), .CD(reset_n), .Q(
        data_temp[1]) );
endmodule


module SFD_detector ( clk, reset_n, data_tap, SFD_start_detect, SFD_detected
 );
  input [3:0] data_tap;
  input clk, reset_n, SFD_start_detect;
  output SFD_detected;
  wire   N6, n1, n2;

  IVP U3 ( .A(data_tap[1]), .Z(n2) );
  FD2 SFD_detected_reg ( .D(N6), .CP(clk), .CD(reset_n), .Q(SFD_detected) );
  AN2P U4 ( .A(data_tap[3]), .B(data_tap[2]), .Z(n1) );
  AN4P U5 ( .A(SFD_start_detect), .B(n2), .C(data_tap[0]), .D(n1), .Z(N6) );
endmodule


module aml ( clk, reset_n, data_tap, eth_address, SFD_detected, address_match, 
        broadcast, multicast );
  input [3:0] data_tap;
  input [47:0] eth_address;
  input clk, reset_n, SFD_detected;
  output address_match, broadcast, multicast;
  wire   DA_42, DA_41, DA_40, DA_39, DA_38, DA_37, DA_36, DA_35, DA_34, DA_33,
         DA_32, DA_31, DA_30, DA_29, DA_28, DA_27, DA_26, DA_25, DA_24, DA_23,
         DA_22, DA_21, DA_20, DA_19, DA_18, DA_17, DA_16, DA_15, DA_14, DA_13,
         DA_12, DA_11, DA_10, DA_9, DA_8, DA_7, DA_6, DA_5, DA_4, DA_3, DA_2,
         DA_1, DA_0, N123, start_count, N357, N358, N359, N360, N361, N362,
         N363, N364, N365, N366, N367, N368, N369, N370, N371, N372, N373,
         N374, N375, N376, N377, N378, N379, N380, N381, N382, N383, N384,
         N385, N386, N387, N388, N389, N390, N391, N392, N393, N394, N395,
         N396, N397, N398, N399, N400, N401, N402, N403, N404, N405, N406,
         N407, N411, N415, N419, N423, N427, N431, N435, N439, N443, N447,
         N451, N455, N463, N464, N465, N475, N476, N477, N490, N544, n64, n65,
         n66, n67, n68, n127, n128, n129, n130, n131, n132, n133, n134, n135,
         n136, n137, n138, n139, n140, n141, n142, n143, n144, n145, n146,
         n147, n148, n149, n150, n151, n152, n153, n154, n155, n156, n157,
         n158, n159, n160, n161, n162, n163, n164, n165, n166, n167, n168,
         n169, n170, n171, n172, n173, n174, n175, n176, n177, n178, n179,
         n180, n181, n182, n183, n184, n185, n186, n187, n188, n189, n190,
         n191, n192, n193, n194, n195, n196, n197, n198, n199, n200, n201,
         n202, n203, n204, n205, n206, n207, n208, n209, n210, n211, n212,
         n213, n214, n215, n216, n217, n218, n219, n220, n221, n222, n223,
         n224, n225, n226, n227, n228, n229, n230, n231, n232, n233, n234,
         n235, n236, n237, n238, n239, n240, n241, n242, n243, n244, n245,
         n246, n247, n248, n249, n250, n251, n252, n253, n254, n255, n256,
         n257, n258, n259, n260, n261, n262, n263, n264, n265, n266, n267,
         n268, n269, n270, n271, n272, n273, n274, n275, n276, n277, n278,
         n279, n280, n281, n282, n283, n284, n285, n286, n287, n288, n289,
         n290, n291, n292, n293, n294, n295, n296, n297, n298, n299, n300,
         n301, n302, n303, n304, n305, n306, n307, n308, n309, n310, n311;

  wire   [1:0] state_AML;
  wire   [3:0] AML_count;
  wire   [3:0] data_tap_temp;

  IVP U1 ( .A(clk), .Z(n310) );
  IVP U2 ( .A(n310), .Z(n311) );
  ND2 U3 ( .A(state_AML[0]), .B(n252), .Z(n256) );
  ND2 U4 ( .A(n245), .B(DA_40), .Z(n251) );
  ND2 U5 ( .A(data_tap_temp[2]), .B(n258), .Z(n306) );
  ND2 U6 ( .A(data_tap_temp[1]), .B(n258), .Z(n305) );
  ND2 U7 ( .A(data_tap_temp[3]), .B(n258), .Z(n307) );
  ND2 U8 ( .A(data_tap_temp[0]), .B(n258), .Z(n301) );
  FJK2 AML_count_reg_0 ( .J(start_count), .K(1'b1), .CP(n310), .CD(reset_n), 
        .Q(AML_count[0]), .QN(n299) );
  ND2 U9 ( .A(n291), .B(n290), .Z(n294) );
  ND2 U10 ( .A(n290), .B(n285), .Z(n288) );
  FD2S AML_count_reg_3 ( .D(1'b0), .CP(n310), .CD(reset_n), .TI(N477), .TE(
        start_count), .Q(AML_count[3]), .QN(n262) );
  FJK2S state_AML_reg_0 ( .J(1'b0), .K(1'b0), .CP(n311), .CD(reset_n), .TI(N406), .TE(N544), .Q(state_AML[0]) );
  FD2S AML_count_reg_1 ( .D(1'b0), .CP(n310), .CD(reset_n), .TI(start_count), 
        .TE(N475), .Q(AML_count[1]), .QN(n300) );
  ND3 U11 ( .A(n243), .B(n242), .C(n251), .Z(n247) );
  ND2 U12 ( .A(SFD_detected), .B(n253), .Z(n309) );
  ND2 U13 ( .A(n67), .B(n285), .Z(n254) );
  AO7 U14 ( .A(n266), .B(n67), .C(n68), .Z(n267) );
  AO7 U15 ( .A(n67), .B(n302), .C(n68), .Z(n303) );
  AO7 U16 ( .A(n286), .B(n67), .C(n68), .Z(n287) );
  AO7 U17 ( .A(n282), .B(n67), .C(n68), .Z(n283) );
  AO7 U18 ( .A(n292), .B(n67), .C(n68), .Z(n293) );
  AO7 U19 ( .A(n259), .B(n67), .C(n68), .Z(n260) );
  AO7 U20 ( .A(n263), .B(n67), .C(n68), .Z(n264) );
  AO7 U21 ( .A(n278), .B(n67), .C(n68), .Z(n279) );
  AO7 U22 ( .A(n275), .B(n67), .C(n68), .Z(n276) );
  NR2 U23 ( .A(n128), .B(n127), .Z(n129) );
  ND2 U24 ( .A(n304), .B(n296), .Z(N447) );
  FDS2L start_count_reg ( .D(N405), .CP(n311), .CR(1'b1), .LD(N455), .Q(
        start_count) );
  ND2 U25 ( .A(AML_count[0]), .B(n300), .Z(n289) );
  ND2 U26 ( .A(AML_count[3]), .B(n127), .Z(n298) );
  FD2S address_match_reg ( .D(1'b0), .CP(n311), .CD(reset_n), .TI(N464), .TE(
        n250), .Q(address_match) );
  AO7 U27 ( .A(n295), .B(n67), .C(n68), .Z(n296) );
  AO7 U28 ( .A(n64), .B(n251), .C(N464), .Z(N465) );
  ND2 U29 ( .A(n304), .B(n260), .Z(N411) );
  ND2 U30 ( .A(n256), .B(state_AML[0]), .Z(N544) );
  ND2 U31 ( .A(n304), .B(n303), .Z(N451) );
  ND2 U32 ( .A(n304), .B(n293), .Z(N443) );
  ND2 U33 ( .A(n304), .B(n283), .Z(N435) );
  ND2 U34 ( .A(n304), .B(n279), .Z(N431) );
  ND2 U35 ( .A(n304), .B(n287), .Z(N439) );
  ND2 U36 ( .A(n304), .B(n267), .Z(N419) );
  ND2 U37 ( .A(n304), .B(n257), .Z(N407) );
  ND2 U38 ( .A(n304), .B(n276), .Z(N427) );
  ND2 U39 ( .A(n304), .B(n264), .Z(N415) );
  ND2 U40 ( .A(n304), .B(n271), .Z(N423) );
  ND2 U41 ( .A(AML_count[1]), .B(AML_count[0]), .Z(n128) );
  IVP U42 ( .A(reset_n), .Z(N123) );
  AO7 U43 ( .A(n255), .B(n256), .C(n309), .Z(N406) );
  FDS2L DA_reg_40 ( .D(N397), .CP(n311), .CR(1'b1), .LD(N447), .Q(DA_40), .QN(
        n244) );
  NR2 U44 ( .A(n301), .B(n268), .Z(N369) );
  NR2 U45 ( .A(n305), .B(n268), .Z(N370) );
  NR2 U46 ( .A(n307), .B(n268), .Z(N372) );
  NR2 U47 ( .A(n305), .B(n277), .Z(N378) );
  NR2 U48 ( .A(n306), .B(n277), .Z(N379) );
  NR2 U49 ( .A(n307), .B(n277), .Z(N380) );
  NR2 U50 ( .A(n256), .B(n254), .Z(N490) );
  NR2 U51 ( .A(n305), .B(n284), .Z(N386) );
  NR2 U52 ( .A(n305), .B(n265), .Z(N366) );
  NR2 U53 ( .A(n306), .B(n265), .Z(N367) );
  NR2 U54 ( .A(n301), .B(n265), .Z(N365) );
  NR2 U55 ( .A(n301), .B(n288), .Z(N389) );
  NR2 U56 ( .A(n305), .B(n288), .Z(N390) );
  NR2 U57 ( .A(n306), .B(n288), .Z(N391) );
  NR2 U58 ( .A(n306), .B(n268), .Z(N371) );
  NR2 U59 ( .A(n307), .B(n288), .Z(N392) );
  NR2 U60 ( .A(n301), .B(n294), .Z(N393) );
  NR2 U61 ( .A(n305), .B(n294), .Z(N394) );
  NR2 U62 ( .A(n305), .B(n261), .Z(N362) );
  NR2 U63 ( .A(n306), .B(n261), .Z(N363) );
  NR2 U64 ( .A(n307), .B(n294), .Z(N396) );
  NR2 U65 ( .A(n305), .B(n297), .Z(N398) );
  NR2 U66 ( .A(n306), .B(n297), .Z(N399) );
  NR2 U67 ( .A(n301), .B(n277), .Z(N377) );
  NR2 U68 ( .A(n307), .B(n297), .Z(N400) );
  NR2 U69 ( .A(n308), .B(n301), .Z(N401) );
  NR2 U70 ( .A(n308), .B(n305), .Z(N402) );
  NR2 U71 ( .A(n308), .B(n306), .Z(N403) );
  NR2 U72 ( .A(n308), .B(n307), .Z(N404) );
  NR2 U73 ( .A(n301), .B(n280), .Z(N381) );
  NR2 U74 ( .A(n306), .B(n294), .Z(N395) );
  NR2 U75 ( .A(n305), .B(n280), .Z(N382) );
  NR2 U76 ( .A(n306), .B(n280), .Z(N383) );
  NR2 U77 ( .A(n307), .B(n280), .Z(N384) );
  NR2 U78 ( .A(n301), .B(n284), .Z(N385) );
  NR2 U79 ( .A(n307), .B(n261), .Z(N364) );
  NR2 U80 ( .A(n306), .B(n284), .Z(N387) );
  NR2 U81 ( .A(n307), .B(n284), .Z(N388) );
  NR2 U82 ( .A(n307), .B(n265), .Z(N368) );
  NR2 U83 ( .A(n301), .B(n261), .Z(N361) );
  ND2 U84 ( .A(n247), .B(N464), .Z(N463) );
  EO U85 ( .A(eth_address[43]), .B(n180), .Z(n240) );
  EO U86 ( .A(DA_8), .B(eth_address[8]), .Z(n229) );
  EO U87 ( .A(DA_6), .B(eth_address[6]), .Z(n228) );
  EO U88 ( .A(eth_address[46]), .B(n184), .Z(n236) );
  EO U89 ( .A(eth_address[47]), .B(n183), .Z(n237) );
  EO U90 ( .A(DA_38), .B(eth_address[38]), .Z(n189) );
  EO U91 ( .A(DA_7), .B(eth_address[7]), .Z(n230) );
  EO U92 ( .A(eth_address[44]), .B(n182), .Z(n238) );
  EO U93 ( .A(DA_42), .B(eth_address[42]), .Z(n186) );
  EO U94 ( .A(DA_39), .B(eth_address[39]), .Z(n185) );
  EO U95 ( .A(DA_26), .B(eth_address[26]), .Z(n193) );
  EO U96 ( .A(DA_24), .B(eth_address[24]), .Z(n192) );
  EO U97 ( .A(DA_36), .B(eth_address[36]), .Z(n188) );
  EO U98 ( .A(DA_11), .B(eth_address[11]), .Z(n226) );
  EO U99 ( .A(DA_27), .B(eth_address[27]), .Z(n195) );
  EO U100 ( .A(eth_address[45]), .B(n181), .Z(n239) );
  EO U101 ( .A(DA_31), .B(eth_address[31]), .Z(n202) );
  EO U102 ( .A(DA_32), .B(eth_address[32]), .Z(n201) );
  EO U103 ( .A(DA_30), .B(eth_address[30]), .Z(n200) );
  EO U104 ( .A(DA_37), .B(eth_address[37]), .Z(n190) );
  EO U105 ( .A(DA_35), .B(eth_address[35]), .Z(n198) );
  EO U106 ( .A(DA_33), .B(eth_address[33]), .Z(n197) );
  EO U107 ( .A(DA_41), .B(eth_address[41]), .Z(n187) );
  EO U108 ( .A(DA_0), .B(eth_address[0]), .Z(n206) );
  EO U109 ( .A(DA_1), .B(eth_address[1]), .Z(n205) );
  EO U110 ( .A(DA_5), .B(eth_address[5]), .Z(n210) );
  EO U111 ( .A(DA_3), .B(eth_address[3]), .Z(n209) );
  EO U112 ( .A(DA_4), .B(eth_address[4]), .Z(n208) );
  EO U113 ( .A(DA_23), .B(eth_address[23]), .Z(n218) );
  EO U114 ( .A(DA_10), .B(eth_address[10]), .Z(n227) );
  EO U115 ( .A(DA_9), .B(eth_address[9]), .Z(n225) );
  EO U116 ( .A(DA_14), .B(eth_address[14]), .Z(n213) );
  EO U117 ( .A(DA_12), .B(eth_address[12]), .Z(n212) );
  EO U118 ( .A(DA_13), .B(eth_address[13]), .Z(n211) );
  EO U119 ( .A(DA_17), .B(eth_address[17]), .Z(n216) );
  EO U120 ( .A(DA_15), .B(eth_address[15]), .Z(n215) );
  EO U121 ( .A(DA_16), .B(eth_address[16]), .Z(n214) );
  EO U122 ( .A(DA_19), .B(eth_address[19]), .Z(n222) );
  EO U123 ( .A(DA_20), .B(eth_address[20]), .Z(n221) );
  EO U124 ( .A(DA_18), .B(eth_address[18]), .Z(n220) );
  EO U125 ( .A(DA_22), .B(eth_address[22]), .Z(n219) );
  EO U126 ( .A(DA_2), .B(eth_address[2]), .Z(n207) );
  EO U127 ( .A(DA_21), .B(eth_address[21]), .Z(n217) );
  EO U128 ( .A(DA_25), .B(eth_address[25]), .Z(n191) );
  EO U129 ( .A(DA_29), .B(eth_address[29]), .Z(n196) );
  EO U130 ( .A(DA_28), .B(eth_address[28]), .Z(n194) );
  EO U131 ( .A(DA_34), .B(eth_address[34]), .Z(n199) );
  IVP U132 ( .A(n256), .Z(n258) );
  AO7 U133 ( .A(n65), .B(n67), .C(n68), .Z(n271) );
  AO7 U134 ( .A(n66), .B(n67), .C(n68), .Z(n257) );
  ND2 U135 ( .A(AML_count[1]), .B(n262), .Z(n281) );
  FD2 data_tap_temp_reg_3 ( .D(data_tap[3]), .CP(n311), .CD(reset_n), .Q(
        data_tap_temp[3]) );
  FD2 data_tap_temp_reg_2 ( .D(data_tap[2]), .CP(n311), .CD(reset_n), .Q(
        data_tap_temp[2]) );
  FD2 data_tap_temp_reg_1 ( .D(data_tap[1]), .CP(n311), .CD(reset_n), .Q(
        data_tap_temp[1]) );
  EO U136 ( .A(n128), .B(n127), .Z(N476) );
  EO U137 ( .A(AML_count[1]), .B(AML_count[0]), .Z(N475) );
  FD2 data_tap_temp_reg_0 ( .D(data_tap[0]), .CP(n311), .CD(reset_n), .Q(
        data_tap_temp[0]) );
  IVP U138 ( .A(n269), .Z(n285) );
  IVP U139 ( .A(n298), .Z(n290) );
  NR2 U140 ( .A(n301), .B(n297), .Z(N397) );
  NR2 U141 ( .A(N123), .B(state_AML[0]), .Z(N455) );
  IVP U142 ( .A(n254), .Z(n255) );
  IVP U143 ( .A(n241), .Z(n245) );
  EO U144 ( .A(AML_count[3]), .B(n129), .Z(N477) );
  EO U145 ( .A(eth_address[40]), .B(n244), .Z(n246) );
  FJK2S multicast_reg ( .J(1'b0), .K(1'b0), .CP(n311), .CD(reset_n), .TI(N464), 
        .TE(N465), .Q(multicast) );
  FJK2S state_AML_reg_1 ( .J(1'b0), .K(1'b0), .CP(n311), .CD(reset_n), .TI(N490), .TE(N544), .Q(state_AML[1]), .QN(n252) );
  FJK2S broadcast_reg ( .J(1'b0), .K(1'b0), .CP(n311), .CD(reset_n), .TI(N464), 
        .TE(N463), .Q(broadcast) );
  IVP U146 ( .A(n308), .Z(n302) );
  IVP U147 ( .A(n280), .Z(n278) );
  IVP U148 ( .A(n289), .Z(n291) );
  IVP U149 ( .A(n268), .Z(n266) );
  IVP U150 ( .A(n288), .Z(n286) );
  IVP U151 ( .A(n284), .Z(n282) );
  IVP U152 ( .A(n297), .Z(n295) );
  IVP U153 ( .A(n265), .Z(n263) );
  IVP U154 ( .A(n277), .Z(n275) );
  IVP U155 ( .A(n261), .Z(n259) );
  IVP U156 ( .A(n307), .Z(n274) );
  IVP U157 ( .A(n306), .Z(n273) );
  IVP U158 ( .A(n294), .Z(n292) );
  IVP U159 ( .A(n305), .Z(n272) );
  IVP U160 ( .A(N464), .Z(n253) );
  IVP U161 ( .A(n301), .Z(n270) );
  FDS2L DA_reg_13 ( .D(N370), .CP(n311), .CR(1'b1), .LD(N419), .Q(DA_13), .QN(
        n158) );
  FDS2L DA_reg_39 ( .D(N396), .CP(n311), .CR(1'b1), .LD(N443), .Q(DA_39), .QN(
        n140) );
  FDS2L DA_reg_0 ( .D(N357), .CP(n311), .CR(1'b1), .LD(N407), .Q(DA_0), .QN(
        n154) );
  FDS2L DA_reg_1 ( .D(N358), .CP(n311), .CR(1'b1), .LD(N407), .Q(DA_1), .QN(
        n153) );
  FDS2L DA_reg_41 ( .D(N398), .CP(n311), .CR(1'b1), .LD(N447), .Q(DA_41), .QN(
        n139) );
  FDS2L DA_reg_2 ( .D(N359), .CP(n311), .CR(1'b1), .LD(N407), .Q(DA_2), .QN(
        n152) );
  FDS2L DA_reg_34 ( .D(N391), .CP(n311), .CR(1'b1), .LD(N439), .Q(DA_34), .QN(
        n146) );
  FDS2L DA_reg_3 ( .D(N360), .CP(n311), .CR(1'b1), .LD(N407), .Q(DA_3), .QN(
        n156) );
  FDS2L DA_reg_4 ( .D(N361), .CP(n311), .CR(1'b1), .LD(N411), .Q(DA_4), .QN(
        n155) );
  FDS2L DA_reg_5 ( .D(N362), .CP(n311), .CR(1'b1), .LD(N411), .Q(DA_5), .QN(
        n157) );
  FDS2L DA_reg_6 ( .D(N363), .CP(n311), .CR(1'b1), .LD(N411), .Q(DA_6), .QN(
        n175) );
  FDS2L DA_reg_42 ( .D(N399), .CP(n311), .CR(1'b1), .LD(N447), .Q(DA_42), .QN(
        n141) );
  FDS2L DA_reg_7 ( .D(N364), .CP(n311), .CR(1'b1), .LD(N411), .Q(DA_7), .QN(
        n177) );
  FDS2L DA_reg_27 ( .D(N384), .CP(n311), .CR(1'b1), .LD(N431), .Q(DA_27), .QN(
        n134) );
  FDS2L DA_reg_8 ( .D(N365), .CP(n311), .CR(1'b1), .LD(N415), .Q(DA_8), .QN(
        n176) );
  FDS2L DA_reg_9 ( .D(N366), .CP(n311), .CR(1'b1), .LD(N415), .Q(DA_9), .QN(
        n172) );
  FDS2L DA_reg_11 ( .D(N368), .CP(n311), .CR(1'b1), .LD(N415), .Q(DA_11), .QN(
        n173) );
  FDS2L DA_reg_12 ( .D(N369), .CP(n311), .CR(1'b1), .LD(N419), .Q(DA_12), .QN(
        n159) );
  FDS2L DA_reg_19 ( .D(N376), .CP(n311), .CR(1'b1), .LD(N423), .Q(DA_19), .QN(
        n169) );
  FDS2L DA_reg_18 ( .D(N375), .CP(n311), .CR(1'b1), .LD(N423), .Q(DA_18), .QN(
        n167) );
  FDS2L DA_reg_14 ( .D(N371), .CP(n311), .CR(1'b1), .LD(N419), .Q(DA_14), .QN(
        n160) );
  FDS2L DA_reg_30 ( .D(N387), .CP(n311), .CR(1'b1), .LD(N435), .Q(DA_30), .QN(
        n147) );
  FDS2L DA_reg_29 ( .D(N386), .CP(n311), .CR(1'b1), .LD(N435), .Q(DA_29), .QN(
        n135) );
  FDS2L DA_reg_28 ( .D(N385), .CP(n311), .CR(1'b1), .LD(N435), .Q(DA_28), .QN(
        n133) );
  FDS2L DA_reg_35 ( .D(N392), .CP(n311), .CR(1'b1), .LD(N439), .Q(DA_35), .QN(
        n145) );
  FDS2L DA_reg_38 ( .D(N395), .CP(n311), .CR(1'b1), .LD(N443), .Q(DA_38), .QN(
        n138) );
  FDS2L DA_reg_37 ( .D(N394), .CP(n311), .CR(1'b1), .LD(N443), .Q(DA_37), .QN(
        n136) );
  FDS2L DA_reg_36 ( .D(N393), .CP(n311), .CR(1'b1), .LD(N443), .Q(DA_36), .QN(
        n137) );
  FDS2L DA_reg_15 ( .D(N372), .CP(n311), .CR(1'b1), .LD(N419), .Q(DA_15), .QN(
        n162) );
  FDS2L DA_reg_17 ( .D(N374), .CP(n311), .CR(1'b1), .LD(N423), .Q(DA_17), .QN(
        n163) );
  FDS2L DA_reg_22 ( .D(N379), .CP(n311), .CR(1'b1), .LD(N427), .Q(DA_22), .QN(
        n166) );
  FDS2L DA_reg_33 ( .D(N390), .CP(n311), .CR(1'b1), .LD(N439), .Q(DA_33), .QN(
        n144) );
  FDS2L DA_reg_32 ( .D(N389), .CP(n311), .CR(1'b1), .LD(N439), .Q(DA_32), .QN(
        n148) );
  FDS2L DA_reg_31 ( .D(N388), .CP(n311), .CR(1'b1), .LD(N435), .Q(DA_31), .QN(
        n149) );
  FDS2L DA_reg_26 ( .D(N383), .CP(n311), .CR(1'b1), .LD(N431), .Q(DA_26), .QN(
        n132) );
  FDS2L DA_reg_25 ( .D(N382), .CP(n311), .CR(1'b1), .LD(N431), .Q(DA_25), .QN(
        n130) );
  FDS2L DA_reg_24 ( .D(N381), .CP(n311), .CR(1'b1), .LD(N431), .Q(DA_24), .QN(
        n131) );
  FDS2L DA_reg_23 ( .D(N380), .CP(n311), .CR(1'b1), .LD(N427), .Q(DA_23), .QN(
        n165) );
  FDS2L DA_reg_16 ( .D(N373), .CP(n311), .CR(1'b1), .LD(N423), .Q(DA_16), .QN(
        n161) );
  FDS2L DA_reg_10 ( .D(N367), .CP(n311), .CR(1'b1), .LD(N415), .Q(DA_10), .QN(
        n174) );
  FDS2L DA_reg_21 ( .D(N378), .CP(n311), .CR(1'b1), .LD(N427), .Q(DA_21), .QN(
        n164) );
  FDS2L DA_reg_20 ( .D(N377), .CP(n311), .CR(1'b1), .LD(N427), .Q(DA_20), .QN(
        n168) );
  IVP U162 ( .A(n251), .Z(n249) );
  IVP U163 ( .A(n309), .Z(N405) );
  IVP U164 ( .A(n247), .Z(n248) );
  FDS2L DA_reg_44 ( .D(N401), .CP(n311), .CR(1'b1), .LD(N451), .QN(n182) );
  FDS2L DA_reg_45 ( .D(N402), .CP(n311), .CR(1'b1), .LD(N451), .QN(n181) );
  FDS2L DA_reg_43 ( .D(N400), .CP(n311), .CR(1'b1), .LD(N447), .QN(n180) );
  FDS2L DA_reg_47 ( .D(N404), .CP(n311), .CR(1'b1), .LD(N451), .QN(n183) );
  FDS2L DA_reg_46 ( .D(N403), .CP(n311), .CR(1'b1), .LD(N451), .QN(n184) );
  AN2 U165 ( .A(n246), .B(n245), .Z(n64) );
  NR3 U166 ( .A(AML_count[3]), .B(n127), .C(n269), .Z(n65) );
  NR3 U167 ( .A(AML_count[3]), .B(AML_count[2]), .C(n269), .Z(n66) );
  AN2 U168 ( .A(AML_count[3]), .B(AML_count[2]), .Z(n67) );
  NR3 U169 ( .A(N123), .B(n256), .C(n255), .Z(n68) );
  FD2S AML_count_reg_2 ( .D(1'b0), .CP(n310), .CD(reset_n), .TI(start_count), 
        .TE(N476), .Q(AML_count[2]), .QN(n127) );
  OR2 U228 ( .A(state_AML[1]), .B(state_AML[0]), .Z(N464) );
  OR3 U229 ( .A(n132), .B(n131), .C(n130), .Z(n151) );
  OR3 U230 ( .A(n135), .B(n134), .C(n133), .Z(n150) );
  OR3 U231 ( .A(n138), .B(n137), .C(n136), .Z(n143) );
  OR3 U232 ( .A(n141), .B(n140), .C(n139), .Z(n142) );
  NR16P U233 ( .I0(n151), .I1(n150), .I2(n143), .I3(n142), .I4(n182), .I5(n181), .I6(n180), .I7(n244), .I8(n184), .I9(n183), .I10(n149), .I11(n148), .I12(
        n147), .I13(n146), .I14(n145), .I15(n144), .Z(n243) );
  OR3 U234 ( .A(n154), .B(n153), .C(n152), .Z(n179) );
  OR3 U235 ( .A(n157), .B(n156), .C(n155), .Z(n178) );
  OR3 U236 ( .A(n160), .B(n159), .C(n158), .Z(n171) );
  OR3 U237 ( .A(n163), .B(n162), .C(n161), .Z(n170) );
  NR16P U238 ( .I0(n179), .I1(n178), .I2(n171), .I3(n170), .I4(n169), .I5(n168), .I6(n167), .I7(n166), .I8(n165), .I9(n164), .I10(n177), .I11(n176), .I12(
        n175), .I13(n174), .I14(n173), .I15(n172), .Z(n242) );
  NR6P U239 ( .A(n190), .B(n189), .C(n188), .D(n187), .E(n186), .F(n185), .Z(
        n235) );
  OR3 U240 ( .A(n193), .B(n192), .C(n191), .Z(n204) );
  OR3 U241 ( .A(n196), .B(n195), .C(n194), .Z(n203) );
  NR8P U242 ( .A(n204), .B(n203), .C(n202), .D(n201), .E(n200), .F(n199), .G(
        n198), .H(n197), .Z(n234) );
  OR3 U243 ( .A(n207), .B(n206), .C(n205), .Z(n232) );
  OR3 U244 ( .A(n210), .B(n209), .C(n208), .Z(n231) );
  OR3 U245 ( .A(n213), .B(n212), .C(n211), .Z(n224) );
  OR3 U246 ( .A(n216), .B(n215), .C(n214), .Z(n223) );
  NR16P U247 ( .I0(n232), .I1(n231), .I2(n224), .I3(n223), .I4(n222), .I5(n221), .I6(n220), .I7(n219), .I8(n218), .I9(n217), .I10(n230), .I11(n229), .I12(
        n228), .I13(n227), .I14(n226), .I15(n225), .Z(n233) );
  ND8 U248 ( .A(n240), .B(n239), .C(n238), .D(n237), .E(n236), .F(n235), .G(
        n234), .H(n233), .Z(n241) );
  OR3 U249 ( .A(n249), .B(n64), .C(n248), .Z(n250) );
  OR2 U250 ( .A(AML_count[0]), .B(AML_count[1]), .Z(n269) );
  AN2P U251 ( .A(n66), .B(n270), .Z(N357) );
  OR3 U252 ( .A(SFD_detected), .B(N123), .C(N464), .Z(n304) );
  AN2P U253 ( .A(n66), .B(n272), .Z(N358) );
  AN2P U254 ( .A(n66), .B(n273), .Z(N359) );
  AN2P U255 ( .A(n66), .B(n274), .Z(N360) );
  OR3 U256 ( .A(AML_count[3]), .B(AML_count[2]), .C(n289), .Z(n261) );
  OR3 U257 ( .A(AML_count[2]), .B(AML_count[0]), .C(n281), .Z(n265) );
  OR3 U258 ( .A(AML_count[2]), .B(n299), .C(n281), .Z(n268) );
  AN2P U259 ( .A(n65), .B(n270), .Z(N373) );
  AN2P U260 ( .A(n65), .B(n272), .Z(N374) );
  AN2P U261 ( .A(n65), .B(n273), .Z(N375) );
  AN2P U262 ( .A(n65), .B(n274), .Z(N376) );
  OR3 U263 ( .A(AML_count[3]), .B(n127), .C(n289), .Z(n277) );
  OR3 U264 ( .A(AML_count[0]), .B(n127), .C(n281), .Z(n280) );
  OR3 U265 ( .A(n127), .B(n299), .C(n281), .Z(n284) );
  OR3 U266 ( .A(AML_count[0]), .B(n300), .C(n298), .Z(n297) );
  OR3 U267 ( .A(n300), .B(n299), .C(n298), .Z(n308) );
endmodule


module fcs_check ( clk, reset_n, FCS_start_check, data, crc_ok );
  input [3:0] data;
  input clk, reset_n, FCS_start_check;
  output crc_ok;
  wire   crc_buffer_29, crc_buffer_28, crc_buffer_27, crc_buffer_23,
         crc_buffer_22, crc_buffer_21, crc_buffer_20, crc_buffer_19,
         crc_buffer_17, crc_buffer_16, crc_buffer_13, crc_buffer_9,
         crc_buffer_7, crc_buffer_2, crc_buffer_31, crc_buffer_30,
         crc_buffer_26, crc_buffer_10, crc_buffer_5, n35, n36, n37, n38, n39,
         n40, n41, n74, n75, n76, n77, n78, n79, n80, n81, n82, n83, n84, n85,
         n86, n87, n88, n89, n90, n91, n92, n93, n94, n95, n96, n97, n98, n99,
         n100, n101, n102, n103, n104, n105, n106, n107, n108, n109, n110,
         n111, n112, n113, n114, n115, n116, n117, n118, n119, n120, n121,
         n122, n123, n124, n125, n126, n127, n128, n129, n130, n131, n132,
         n133, n134, n135, n136, n137, n138, n139, n140, n141, n142, n143,
         n144;
  tri   [3:0] data;

  ND2 U3 ( .A(reset_n), .B(FCS_start_check), .Z(n124) );
  FD1S crc_buffer_reg_29 ( .D(1'b1), .CP(clk), .TI(n124), .TE(n123), .Q(
        crc_buffer_29), .QN(n81) );
  FD1S crc_buffer_reg_31 ( .D(n124), .CP(clk), .TI(1'b1), .TE(crc_buffer_27), 
        .Q(crc_buffer_31), .QN(n125) );
  FD1S crc_buffer_reg_30 ( .D(n124), .CP(clk), .TI(1'b1), .TE(crc_buffer_26), 
        .Q(crc_buffer_30), .QN(n126) );
  EO U4 ( .A(n41), .B(n117), .Z(n111) );
  EO U5 ( .A(n37), .B(n104), .Z(n95) );
  FD1S crc_buffer_reg_20 ( .D(n124), .CP(clk), .TI(1'b1), .TE(crc_buffer_16), 
        .Q(crc_buffer_20) );
  FD1S crc_buffer_reg_21 ( .D(n124), .CP(clk), .TI(1'b1), .TE(crc_buffer_17), 
        .Q(crc_buffer_21) );
  EO U6 ( .A(n98), .B(n97), .Z(n99) );
  EO U7 ( .A(n39), .B(n134), .Z(n102) );
  EO U8 ( .A(n35), .B(n133), .Z(n103) );
  EO U9 ( .A(n40), .B(n105), .Z(n106) );
  EO U10 ( .A(n38), .B(n132), .Z(n108) );
  EO U11 ( .A(n39), .B(n131), .Z(n109) );
  EO U12 ( .A(n39), .B(n128), .Z(n123) );
  EO U13 ( .A(n35), .B(n130), .Z(n110) );
  EO U14 ( .A(n75), .B(n81), .Z(n76) );
  EO U15 ( .A(n40), .B(n120), .Z(n121) );
  EO U16 ( .A(n38), .B(n129), .Z(n122) );
  EO U17 ( .A(crc_buffer_31), .B(n126), .Z(n97) );
  EO U18 ( .A(crc_buffer_31), .B(n81), .Z(n88) );
  EO U19 ( .A(n36), .B(n81), .Z(n113) );
  EO U20 ( .A(crc_buffer_30), .B(n81), .Z(n92) );
  EO U21 ( .A(n37), .B(n126), .Z(n115) );
  FD1S crc_buffer_reg_19 ( .D(1'b1), .CP(clk), .TI(n124), .TE(n109), .Q(
        crc_buffer_19) );
  FD1S crc_buffer_reg_9 ( .D(1'b1), .CP(clk), .TI(n124), .TE(n85), .Q(
        crc_buffer_9) );
  FD1S crc_buffer_reg_2 ( .D(1'b1), .CP(clk), .TI(n124), .TE(n77), .Q(
        crc_buffer_2) );
  IVP U22 ( .A(data[2]), .Z(n104) );
  FD1S crc_buffer_reg_27 ( .D(1'b1), .CP(clk), .TI(n124), .TE(n121), .Q(
        crc_buffer_27) );
  FD1S crc_buffer_reg_17 ( .D(1'b1), .CP(clk), .TI(n124), .TE(n106), .Q(
        crc_buffer_17) );
  FD1S crc_buffer_reg_16 ( .D(1'b1), .CP(clk), .TI(n124), .TE(n103), .Q(
        crc_buffer_16) );
  FD1S crc_buffer_reg_10 ( .D(1'b1), .CP(clk), .TI(n124), .TE(n87), .Q(
        crc_buffer_10), .QN(n135) );
  FD1S crc_buffer_reg_5 ( .D(1'b1), .CP(clk), .TI(n124), .TE(n80), .Q(
        crc_buffer_5), .QN(n138) );
  IVP U23 ( .A(data[1]), .Z(n107) );
  IVP U24 ( .A(data[0]), .Z(n101) );
  FD1S crc_buffer_reg_26 ( .D(1'b1), .CP(clk), .TI(n124), .TE(n119), .Q(
        crc_buffer_26), .QN(n127) );
  FD1S crc_buffer_reg_28 ( .D(1'b1), .CP(clk), .TI(n124), .TE(n122), .Q(
        crc_buffer_28), .QN(n117) );
  FD1S crc_buffer_reg_22 ( .D(1'b1), .CP(clk), .TI(n124), .TE(n110), .Q(
        crc_buffer_22) );
  IVP U25 ( .A(data[3]), .Z(n74) );
  FDS2 crc_ok_reg ( .D(n144), .CP(clk), .CR(n143), .Q(crc_ok) );
  FD1S crc_buffer_reg_23 ( .D(1'b1), .CP(clk), .TI(n124), .TE(n112), .Q(
        crc_buffer_23), .QN(n120) );
  FD1S crc_buffer_reg_13 ( .D(1'b1), .CP(clk), .TI(n124), .TE(n99), .Q(
        crc_buffer_13), .QN(n105) );
  FD1S crc_buffer_reg_7 ( .D(1'b1), .CP(clk), .TI(n124), .TE(n83), .Q(
        crc_buffer_7), .QN(n89) );
  IVP U26 ( .A(n111), .Z(n75) );
  IVP U27 ( .A(n95), .Z(n96) );
  FD1S crc_buffer_reg_0 ( .D(n35), .CP(clk), .TI(1'b1), .TE(n124), .QN(n142)
         );
  FD1S crc_buffer_reg_25 ( .D(1'b1), .CP(clk), .TI(n124), .TE(n116), .QN(n128)
         );
  FD1S crc_buffer_reg_24 ( .D(1'b1), .CP(clk), .TI(n124), .TE(n114), .QN(n129)
         );
  FD1S crc_buffer_reg_18 ( .D(1'b1), .CP(clk), .TI(n124), .TE(n108), .QN(n130)
         );
  FD1S crc_buffer_reg_15 ( .D(1'b1), .CP(clk), .TI(n124), .TE(n102), .QN(n131)
         );
  FD1S crc_buffer_reg_14 ( .D(1'b1), .CP(clk), .TI(n124), .TE(n100), .QN(n132)
         );
  FD1S crc_buffer_reg_12 ( .D(1'b1), .CP(clk), .TI(n124), .TE(n94), .QN(n133)
         );
  FD1S crc_buffer_reg_11 ( .D(1'b1), .CP(clk), .TI(n124), .TE(n91), .QN(n134)
         );
  FD1S crc_buffer_reg_8 ( .D(1'b1), .CP(clk), .TI(n124), .TE(n84), .QN(n136)
         );
  FD1S crc_buffer_reg_6 ( .D(1'b1), .CP(clk), .TI(n124), .TE(n82), .QN(n137)
         );
  FD1S crc_buffer_reg_4 ( .D(1'b1), .CP(clk), .TI(n124), .TE(n79), .QN(n139)
         );
  FD1S crc_buffer_reg_3 ( .D(1'b1), .CP(clk), .TI(n124), .TE(n78), .QN(n140)
         );
  FD1S crc_buffer_reg_1 ( .D(1'b1), .CP(clk), .TI(n124), .TE(n76), .QN(n141)
         );
  EN U28 ( .A(crc_buffer_28), .B(n74), .Z(n35) );
  EN U29 ( .A(data[2]), .B(n107), .Z(n36) );
  EN U30 ( .A(data[1]), .B(n101), .Z(n37) );
  EN U31 ( .A(crc_buffer_30), .B(n107), .Z(n38) );
  EN U32 ( .A(crc_buffer_31), .B(n101), .Z(n39) );
  EN U33 ( .A(crc_buffer_29), .B(n104), .Z(n40) );
  EN U34 ( .A(data[3]), .B(n104), .Z(n41) );
  EO3P U67 ( .A(n36), .B(data[3]), .C(n117), .Z(n93) );
  EO3P U68 ( .A(crc_buffer_30), .B(crc_buffer_29), .C(n93), .Z(n77) );
  EO3P U69 ( .A(n95), .B(n125), .C(n92), .Z(n78) );
  EO3P U70 ( .A(n37), .B(data[3]), .C(n117), .Z(n86) );
  EO3P U71 ( .A(n86), .B(n142), .C(n97), .Z(n79) );
  EO3P U72 ( .A(n41), .B(data[0]), .C(n117), .Z(n90) );
  EO3P U73 ( .A(n90), .B(n141), .C(n88), .Z(n80) );
  EO3P U74 ( .A(crc_buffer_30), .B(crc_buffer_2), .C(n113), .Z(n82) );
  EO3P U75 ( .A(n86), .B(n140), .C(n97), .Z(n83) );
  EO3P U76 ( .A(n90), .B(n139), .C(n88), .Z(n84) );
  EO3P U77 ( .A(crc_buffer_30), .B(crc_buffer_5), .C(n113), .Z(n85) );
  EO3P U78 ( .A(n86), .B(n137), .C(n97), .Z(n87) );
  EO3P U79 ( .A(n90), .B(n89), .C(n88), .Z(n91) );
  EO3P U80 ( .A(n93), .B(n136), .C(n92), .Z(n94) );
  EO3P U81 ( .A(n96), .B(crc_buffer_9), .C(crc_buffer_29), .Z(n98) );
  EO3P U82 ( .A(crc_buffer_31), .B(crc_buffer_10), .C(n115), .Z(n100) );
  EO3P U83 ( .A(crc_buffer_29), .B(crc_buffer_19), .C(n111), .Z(n112) );
  EO3P U84 ( .A(crc_buffer_30), .B(crc_buffer_20), .C(n113), .Z(n114) );
  EO3P U85 ( .A(crc_buffer_31), .B(crc_buffer_21), .C(n115), .Z(n116) );
  EO3P U86 ( .A(data[3]), .B(data[0]), .C(crc_buffer_31), .Z(n118) );
  EO3P U87 ( .A(crc_buffer_22), .B(n118), .C(n117), .Z(n119) );
  NR16P U88 ( .I0(n140), .I1(n139), .I2(n132), .I3(n131), .I4(n130), .I5(n129), 
        .I6(n128), .I7(n127), .I8(n126), .I9(n125), .I10(n138), .I11(n137), 
        .I12(n136), .I13(n135), .I14(n134), .I15(n133), .Z(n144) );
  NR16P U89 ( .I0(crc_buffer_29), .I1(crc_buffer_28), .I2(crc_buffer_17), .I3(
        crc_buffer_16), .I4(crc_buffer_13), .I5(crc_buffer_9), .I6(
        crc_buffer_7), .I7(crc_buffer_2), .I8(n142), .I9(n141), .I10(
        crc_buffer_27), .I11(crc_buffer_23), .I12(crc_buffer_22), .I13(
        crc_buffer_21), .I14(crc_buffer_20), .I15(crc_buffer_19), .Z(n143) );
endmodule


module rx_mac ( rx_clk, rx_en, reset_n, rx_dv, rx_error, rx_data, data, 
        rx_status_valid_n, rx_status, data_valid, last_data, eth_address );
  input [3:0] rx_data;
  output [3:0] data;
  output [15:0] rx_status;
  input [47:0] eth_address;
  input rx_clk, rx_en, reset_n, rx_dv, rx_error;
  output rx_status_valid_n, data_valid, last_data;
  wire   SFD_start_detect, SFD_detected, FCS_start_check, data_en,
         address_match, multicast, broadcast, crc_ok, rx_clko, rx_clkdiv;
  wire   [3:0] data_tap;
  tri   [3:0] data;

  rx_clkgen rx_clkgen ( .clk(rx_clk), .reset_n(reset_n), .en(rx_en), .clko1(
        rx_clko), .clko2(rx_clkdiv) );
  rx_sm rx_sm ( .clk(rx_clkdiv), .reset_n(reset_n), .rx_dv(rx_dv), .rx_error(
        rx_error), .SFD_detected(SFD_detected), .address_match(address_match), 
        .multicast(multicast), .broadcast(broadcast), .crc_ok(crc_ok), 
        .SFD_start_detect(SFD_start_detect), .data_en(data_en), 
        .FCS_start_check(FCS_start_check), .last_data(last_data), .data_valid(
        data_valid), .rx_status_valid_n(rx_status_valid_n), .rx_status({
        rx_status[15], rx_status[14], rx_status[13], rx_status[12], 
        rx_status[11], rx_status[10], rx_status[9], rx_status[8], rx_status[7], 
        rx_status[6], rx_status[5], rx_status[4], rx_status[3], rx_status[2], 
        rx_status[1], rx_status[0]}) );
  rx_buffer rx_buffer ( .clk(rx_clko), .reset_n(reset_n), .rx_data({rx_data[3], 
        rx_data[2], rx_data[1], rx_data[0]}), .data_tap({data_tap[3], 
        data_tap[2], data_tap[1], data_tap[0]}), .data({data[3], data[2], 
        data[1], data[0]}), .data_en(data_en) );
  SFD_detector rx_sfd ( .clk(rx_clko), .reset_n(reset_n), .data_tap({
        data_tap[3], data_tap[2], data_tap[1], data_tap[0]}), 
        .SFD_start_detect(SFD_start_detect), .SFD_detected(SFD_detected) );
  aml rx_aml ( .clk(rx_clkdiv), .reset_n(reset_n), .data_tap({data_tap[3], 
        data_tap[2], data_tap[1], data_tap[0]}), .eth_address({eth_address[47], 
        eth_address[46], eth_address[45], eth_address[44], eth_address[43], 
        eth_address[42], eth_address[41], eth_address[40], eth_address[39], 
        eth_address[38], eth_address[37], eth_address[36], eth_address[35], 
        eth_address[34], eth_address[33], eth_address[32], eth_address[31], 
        eth_address[30], eth_address[29], eth_address[28], eth_address[27], 
        eth_address[26], eth_address[25], eth_address[24], eth_address[23], 
        eth_address[22], eth_address[21], eth_address[20], eth_address[19], 
        eth_address[18], eth_address[17], eth_address[16], eth_address[15], 
        eth_address[14], eth_address[13], eth_address[12], eth_address[11], 
        eth_address[10], eth_address[9], eth_address[8], eth_address[7], 
        eth_address[6], eth_address[5], eth_address[4], eth_address[3], 
        eth_address[2], eth_address[1], eth_address[0]}), .SFD_detected(
        SFD_detected), .address_match(address_match), .broadcast(broadcast), 
        .multicast(multicast) );
  fcs_check rx_fcs ( .clk(rx_clkdiv), .reset_n(reset_n), .FCS_start_check(
        FCS_start_check), .data({data[3], data[2], data[1], data[0]}), 
        .crc_ok(crc_ok) );
endmodule


module top ( tx_data, tx_sof, tx_eof, tx_underrun, full_duplex, en, reset_n, 
        crs, coll, tx_clk1, tx_clk2, rx_clk, eth_address, data, data_valid, last_data, 
        rx_status_valid_n, rx_status, tx_data_used, tx_done, tx_abort, 
        tx_retransmit, tx_status_valid_n, tx_status ,cko,
	tx_cken1, tx_cken2 );
    output cko ;
  input [3:0] tx_data;
  input [47:0] eth_address;
  output [3:0] data;
  output [15:0] rx_status;
  output [6:0] tx_status;
  input tx_sof, tx_eof, tx_underrun, full_duplex, en, reset_n, crs, coll,
         tx_clk1, tx_clk2,  rx_clk;
  output data_valid, last_data, rx_status_valid_n, tx_data_used, tx_done,
         tx_abort, tx_retransmit, tx_status_valid_n;
  input  tx_cken1, tx_cken2;

  wire   mii_err, mii_en;
  wire   [3:0] async_data;
  wire   [3:0] sync_data;
  tri   [3:0] data;
    wire cko ;
    wire cko2 ;
    wire cko1 ;

    IVP  u_ck100 (.A (cko1 ));
    IVP  u_cko2 (.Z (cko ),.A (cko1 ));
    IVP  u_cko1 (.A (cko2 ),.Z (cko1 ));

  txethmac TX ( .tx_data({tx_data[3], tx_data[2], tx_data[1], tx_data[0]}), 
        .tx_sof(tx_sof), .tx_eof(tx_eof), .tx_underrun(tx_underrun), 
        .full_duplex(full_duplex), .reset_n(reset_n), .crs(crs), .coll(coll), 
        .tx_clk1(tx_clk1), .tx_clk2(tx_clk2), .tx_data_used(tx_data_used), .tx_done(tx_done), 
        .tx_abort(tx_abort), .tx_retransmit(tx_retransmit), .tx_status({
        tx_status[6], tx_status[5], tx_status[4], tx_status[3], tx_status[2], 
        tx_status[1], tx_status[0]}), .tx_status_valid_n(tx_status_valid_n), 
        .txd({async_data[3], async_data[2], async_data[1], async_data[0]}), 
        .tx_en(mii_en), .tx_er(mii_err) ,.tx_cko1 ( cko2 ), .tx_cko2(),
	.tx_cken1(tx_cken1), .tx_cken2(tx_cken2)
	);

  sync SYNC ( .sync_clk(rx_clk), .sync_reset(reset_n), .sync_in({async_data[3], 
        async_data[2], async_data[1], async_data[0]}), .sync_out({sync_data[3], 
        sync_data[2], sync_data[1], sync_data[0]}) );
  rx_mac RX ( .rx_clk(rx_clk), .rx_en(en), .reset_n(reset_n), .rx_dv(mii_en), 
        .rx_error(mii_err), .rx_data({sync_data[3], sync_data[2], sync_data[1], 
        sync_data[0]}), .data({data[3], data[2], data[1], data[0]}), 
        .rx_status_valid_n(rx_status_valid_n), .rx_status({rx_status[15], 
        rx_status[14], rx_status[13], rx_status[12], rx_status[11], 
        rx_status[10], rx_status[9], rx_status[8], rx_status[7], rx_status[6], 
        rx_status[5], rx_status[4], rx_status[3], rx_status[2], rx_status[1], 
        rx_status[0]}), .data_valid(data_valid), .last_data(last_data), 
        .eth_address({eth_address[47], eth_address[46], eth_address[45], 
        eth_address[44], eth_address[43], eth_address[42], eth_address[41], 
        eth_address[40], eth_address[39], eth_address[38], eth_address[37], 
        eth_address[36], eth_address[35], eth_address[34], eth_address[33], 
        eth_address[32], eth_address[31], eth_address[30], eth_address[29], 
        eth_address[28], eth_address[27], eth_address[26], eth_address[25], 
        eth_address[24], eth_address[23], eth_address[22], eth_address[21], 
        eth_address[20], eth_address[19], eth_address[18], eth_address[17], 
        eth_address[16], eth_address[15], eth_address[14], eth_address[13], 
        eth_address[12], eth_address[11], eth_address[10], eth_address[9], 
        eth_address[8], eth_address[7], eth_address[6], eth_address[5], 
        eth_address[4], eth_address[3], eth_address[2], eth_address[1], 
        eth_address[0]}) );
endmodule

