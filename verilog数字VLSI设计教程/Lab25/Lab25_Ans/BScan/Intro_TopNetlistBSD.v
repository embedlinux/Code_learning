
module Intro_Top ( X, Y, Z, ScanOut, A, B, C, D, ScanIn, ScanMode, ScanClk, 
        ScanRst );
  input A, B, C, D, ScanIn, ScanMode, ScanClk, ScanRst;
  output X, Y, Z, ScanOut;
  wire   qn, toZ, ab, bc, fromA, fromB, fromC, q, fromD, toX, toY, n2, n3, n4,
         n5, Intro_Top_inv_in, Intro_Top_tdi, Intro_Top_tdo, Intro_Top_tdo_en,
         net462, Intro_Top_tms, Intro_Top_trst_n, \Intro_Top_instructions[0] ,
         \Intro_Top_instructions[1] , Intro_Top_bypass_sel, net541, net543,
         shift_dr, Intro_Top_data_in, Intro_Top_data_in_1, Intro_Top_data_in_2,
         Intro_Top_data_in_3, Intro_Top_data_out, Intro_Top_data_out_1,
         Intro_Top_data_out_2, Intro_Top_si_6, net562, net584, net585, net586,
         net587, net588, net589, net590, net591, net592, net593, net594,
         net595, net596, net597, net598, net599, net600, net601, net602,
         net603, net604, net605, net606, net607, net608, net609, net610,
         net611, net612, net613, net614, net615, net616, net617, net618,
         net619, net620, net621, net622, net623, net624, net625, net626,
         net627, net628, net629, net630, net631, net632, net633, net634,
         net635, net636, net637, net638, net639, net640, net641, net642,
         net643, net644, net645, net646, net647, net648, net649, net650,
         net651, net652, net653, net766, net765, net764, net774, net782,
         net780;
  tri   ScanOut;

  AndOr InputCombo01 ( .X(ab), .Y(bc), .A(n3), .B(n5), .C(n2) );
  SR SRLatch01 ( .Q(q), .Qn(qn), .S(bc), .R(n4) );
  XorNor OutputCombo01 ( .X(toX), .Y(toY), .A(ab), .B(q), .C(qn) );
  PDC0204CDG_18_Out Xpad1 ( .I(Intro_Top_data_out), .PAD(X) );
  PDC0204CDG_18_Out Ypad1 ( .I(Intro_Top_data_out_1), .PAD(Y) );
  PDC0204CDG_18_Out Zpad1 ( .I(Intro_Top_data_out_2), .PAD(Z) );
  PDC0204CDG_18_In padA1 ( .PAD(A), .C(Intro_Top_data_in) );
  PDC0204CDG_18_In padB1 ( .PAD(B), .C(Intro_Top_data_in_1) );
  PDC0204CDG_18_In padC1 ( .PAD(C), .C(Intro_Top_data_in_2) );
  PDC0204CDG_18_In padD1 ( .PAD(D), .C(Intro_Top_data_in_3) );
  PDC0204CDG_18_Tri TDOpad1 ( .I(Intro_Top_tdo), .OEN(Intro_Top_tdo_en), .PAD(
        ScanOut) );
  PDC0204CDG_18_In padTMS1 ( .PAD(ScanMode), .C(Intro_Top_tms) );
  PDC0204CDG_18_In padTDI1 ( .PAD(ScanIn), .C(Intro_Top_tdi) );
  PDC0204CDG_18_In padTCK1 ( .PAD(ScanClk), .C(Intro_Top_inv_in) );
  PDC0204CDG_18_In padTRST1 ( .PAD(ScanRst), .C(Intro_Top_trst_n) );
  BUFFD0 U2 ( .I(fromC), .Z(n2) );
  BUFFD0 U3 ( .I(fromA), .Z(n3) );
  BUFFD0 U4 ( .I(fromD), .Z(n4) );
  BUFFD0 U5 ( .I(fromB), .Z(n5) );
  CKND0 U6 ( .CLK(qn), .CN(toZ) );
  Intro_Top_DW_tap_uc_width2_id0_idcode_opcode1_version0_part0_man_num0_sync_mode1 Intro_Top_DW_tap_inst ( 
        .tck(net766), .trst_n(Intro_Top_trst_n), .tms(net774), .tdi(net782), 
        .so(Intro_Top_si_6), .bypass_sel(Intro_Top_bypass_sel), .sentinel_val(
        net584), .device_id_sel(net585), .user_code_sel(net586), 
        .user_code_val({net587, net588, net589, net590, net591, net592, net593, 
        net594, net595, net596, net597, net598, net599, net600, net601, net602, 
        net603, net604, net605, net606, net607, net608, net609, net610, net611, 
        net612, net613, net614, net615, net616, net617, net618}), .ver({net619, 
        net620, net621, net622}), .ver_sel(net623), .part_num({net624, net625, 
        net626, net627, net628, net629, net630, net631, net632, net633, net634, 
        net635, net636, net637, net638, net639}), .part_num_sel(net640), 
        .mnfr_id({net641, net642, net643, net644, net645, net646, net647, 
        net648, net649, net650, net651}), .mnfr_id_sel(net652), .clock_dr(
        net562), .shift_dr(shift_dr), .tdo(Intro_Top_tdo), .tdo_en(net462), 
        .instructions({\Intro_Top_instructions[1] , 
        \Intro_Top_instructions[0] }), .sync_capture_en(net541), 
        .sync_update_dr(net543), .test(net653) );
  Intro_Top_BSR_top_inst_design Intro_Top_BSR_top_inst ( .toZ(toZ), .toY(toY), 
        .toX(toX), .shift_dr(shift_dr), .net562(net562), .net543(net543), 
        .net541(net541), .net462(net462), .fromD(fromD), .fromC(fromC), 
        .fromB(fromB), .fromA(fromA), .Intro_Top_tdo_en(Intro_Top_tdo_en), 
        .Intro_Top_tdi(net782), .Intro_Top_si_6(Intro_Top_si_6), 
        .Intro_Top_inv_in(net765), .\Intro_Top_instructions[1] (
        \Intro_Top_instructions[1] ), .\Intro_Top_instructions[0] (
        \Intro_Top_instructions[0] ), .Intro_Top_data_out_2(
        Intro_Top_data_out_2), .Intro_Top_data_out_1(Intro_Top_data_out_1), 
        .Intro_Top_data_out(Intro_Top_data_out), .Intro_Top_data_in_3(
        Intro_Top_data_in_3), .Intro_Top_data_in_2(Intro_Top_data_in_2), 
        .Intro_Top_data_in_1(Intro_Top_data_in_1), .Intro_Top_data_in(
        Intro_Top_data_in), .Intro_Top_bypass_sel(Intro_Top_bypass_sel) );
  INVD0 \*cell*804  ( .I(net764), .ZN(net766) );
  INVD0 \*cell*803  ( .I(net764), .ZN(net765) );
  INVD0 \*cell*802  ( .I(Intro_Top_inv_in), .ZN(net764) );
  BUFFD0 \*cell*807  ( .I(Intro_Top_tms), .Z(net774) );
  INVD0 \*cell*812  ( .I(net780), .ZN(net782) );
  INVD0 \*cell*810  ( .I(Intro_Top_tdi), .ZN(net780) );
endmodule


module AndOr ( X, Y, A, B, C );
  input A, B, C;
  output X, Y;


  CKAN2D0 U1 ( .A1(B), .A2(A), .Z(X) );
  OR2D0 U2 ( .A1(C), .A2(B), .Z(Y) );
endmodule


module SR ( Q, Qn, S, R );
  input S, R;
  output Q, Qn;


  CKND2D2 U2 ( .A1(Q), .A2(R), .ZN(Qn) );
  CKND2D0 U1 ( .A1(S), .A2(Qn), .ZN(Q) );
endmodule


module XorNor ( X, Y, A, B, C );
  input A, B, C;
  output X, Y;


  NR2D0 U1 ( .A1(C), .A2(X), .ZN(Y) );
  CKXOR2D0 U2 ( .A1(B), .A2(A), .Z(X) );
endmodule



    module Intro_Top_DW_tap_uc_width2_id0_idcode_opcode1_version0_part0_man_num0_sync_mode1 ( 
        tck, trst_n, tms, tdi, so, bypass_sel, sentinel_val, device_id_sel, 
        user_code_sel, user_code_val, ver, ver_sel, part_num, part_num_sel, 
        mnfr_id, mnfr_id_sel, clock_dr, shift_dr, update_dr, tdo, tdo_en, 
        tap_state, instructions, sync_capture_en, sync_update_dr, test );
  input [31:0] user_code_val;
  input [3:0] ver;
  input [15:0] part_num;
  input [10:0] mnfr_id;
  output [15:0] tap_state;
  output [1:0] instructions;
  input tck, trst_n, tms, tdi, so, bypass_sel, sentinel_val, device_id_sel,
         user_code_sel, ver_sel, part_num_sel, mnfr_id_sel, test;
  output clock_dr, shift_dr, update_dr, tdo, tdo_en, sync_capture_en,
         sync_update_dr;
  wire   \tap_state[8]_snps_wire , tck_n, dr_sel_int, shift_ir_int, instr_rst,
         instr_so, byp_so, tdo_ffin, \next_state[15] , \next_state[14] ,
         \next_state[13] , \next_state[12] , \next_state[11] ,
         \next_state[10] , \next_state[9] , \next_state[8] , \next_state[7] ,
         \next_state[6] , \next_state[5] , \next_state[4] , \next_state[3] ,
         \next_state[2] , \next_state[1] , \next_state[0] , dr_sel_int_next,
         sel_cap_dr, sel_cap_ir, reset, rst_n, \temp_so[1] , \ff_q[1] ,
         \ff_q[0] , \ff_d[1] , \ff_d[0] , ffin2, ffin1, ffin, net255, net442,
         net441, net440, net439, net438, net437, net436, net435, net434,
         net433, net432, net431, net430, net429, net428, net427, net426,
         net425, net424, net423, net422, net421, net420, net419, net418,
         net417, net416, net415, net414, net413, net412, net411, net410,
         net409, net408, net407, net406, net405, net404, net403, net402,
         net401, net400, net399, net398, net397, net396, net395, net394,
         net393, net392, net391, net390, net389, net388, net387, net386,
         net385, net384, net383, net382, net381, net380, net379, net378,
         net377, net376, net375, net374, net373, net372, net371, net370,
         net369, net368, net367, net366, net365, net364, net363, net362,
         net361, net360, net359, net358, net357, net356, net355, net354,
         net353, net352, net351, net350, net349, net348, net347, net346,
         net345, net344, net343, net342, net341, net340, net339, net338,
         net456, net788, net787, net786, net802;
  assign sync_update_dr = \tap_state[8]_snps_wire ;
  assign tap_state[8] = net456;

  IND2D0 U102 ( .A1(reset), .B1(net788), .ZN(instr_rst) );
  OR2D1 U42 ( .A1(tck), .A2(sel_cap_ir), .Z(net255) );
  NR2XD0 U212 ( .A1(tap_state[10]), .A2(tap_state[11]), .ZN(sel_cap_ir) );
  OR2D1 U35 ( .A1(tck), .A2(sel_cap_dr), .Z(clock_dr) );
  NR2XD0 U129 ( .A1(tap_state[3]), .A2(tap_state[4]), .ZN(sel_cap_dr) );
  CKND0 U0 ( .CLK(tck), .CN(tck_n) );
  OR2D1 \*cell*547  ( .A1(tap_state[7]), .A2(\tap_state[8]_snps_wire ), .Z(
        net375) );
  OR2D1 \*cell*546  ( .A1(tap_state[9]), .A2(tap_state[6]), .Z(net442) );
  OR2D1 \*cell*545  ( .A1(net375), .A2(net442), .Z(net385) );
  OR2D1 \*cell*544  ( .A1(tap_state[5]), .A2(tap_state[3]), .Z(net441) );
  OR2D1 \*cell*543  ( .A1(net385), .A2(net441), .Z(net408) );
  CKND0 \*cell*542  ( .CLK(net408), .CN(net434) );
  CKND0 \*cell*541  ( .CLK(tap_state[2]), .CN(net440) );
  NR2XD0 \*cell*540  ( .A1(tap_state[4]), .A2(net440), .ZN(net435) );
  OR2D1 \*cell*539  ( .A1(tap_state[10]), .A2(tap_state[11]), .Z(net401) );
  CKND0 \*cell*538  ( .CLK(tap_state[0]), .CN(net406) );
  CKND0 \*cell*537  ( .CLK(tap_state[12]), .CN(net402) );
  OR2D1 \*cell*536  ( .A1(tap_state[13]), .A2(tap_state[14]), .Z(net387) );
  OR2D1 \*cell*535  ( .A1(tap_state[1]), .A2(tap_state[15]), .Z(net439) );
  OR2D1 \*cell*534  ( .A1(net387), .A2(net439), .Z(net438) );
  CKND0 \*cell*533  ( .CLK(net438), .CN(net368) );
  ND3D1 \*cell*532  ( .A1(net406), .A2(net402), .A3(net368), .ZN(net437) );
  CKND0 \*cell*531  ( .CLK(net437), .CN(net379) );
  IND2D0 \*cell*530  ( .A1(net401), .B1(net379), .ZN(net432) );
  CKND0 \*cell*529  ( .CLK(net432), .CN(net436) );
  ND3D1 \*cell*528  ( .A1(net434), .A2(net435), .A3(net436), .ZN(net433) );
  CKND0 \*cell*527  ( .CLK(net433), .CN(net341) );
  IND2D0 \*cell*526  ( .A1(tms), .B1(net341), .ZN(net349) );
  NR2XD0 \*cell*525  ( .A1(\tap_state[8]_snps_wire ), .A2(tap_state[6]), .ZN(
        net428) );
  CKND0 \*cell*524  ( .CLK(tap_state[3]), .CN(net417) );
  CKND0 \*cell*523  ( .CLK(tap_state[9]), .CN(net367) );
  CKND0 \*cell*522  ( .CLK(tap_state[4]), .CN(net426) );
  CKND0 \*cell*521  ( .CLK(tap_state[5]), .CN(net384) );
  OR2D1 \*cell*520  ( .A1(tap_state[2]), .A2(net432), .Z(net431) );
  CKND0 \*cell*519  ( .CLK(net431), .CN(net383) );
  ND3D1 \*cell*518  ( .A1(net426), .A2(net384), .A3(net383), .ZN(net430) );
  CKND0 \*cell*517  ( .CLK(net430), .CN(net366) );
  ND3D1 \*cell*516  ( .A1(net417), .A2(net367), .A3(net366), .ZN(net429) );
  CKND0 \*cell*515  ( .CLK(net429), .CN(net374) );
  ND3D1 \*cell*514  ( .A1(tap_state[7]), .A2(net428), .A3(net374), .ZN(net427)
         );
  CKND0 \*cell*513  ( .CLK(net427), .CN(net343) );
  NR2XD0 \*cell*512  ( .A1(net385), .A2(net417), .ZN(net423) );
  OR2D1 \*cell*511  ( .A1(net408), .A2(net426), .Z(net425) );
  IND2D0 \*cell*510  ( .A1(net425), .B1(net383), .ZN(net424) );
  IOA21D2 \*cell*509  ( .A1(net423), .A2(net366), .B(net424), .ZN(net410) );
  CKND0 \*cell*508  ( .CLK(tms), .CN(net347) );
  OAI21D1 \*cell*507  ( .A1(net343), .A2(net410), .B(net347), .ZN(net422) );
  CKND0 \*cell*506  ( .CLK(net422), .CN(\next_state[4] ) );
  INR2D1 \*cell*505  ( .A1(net349), .B1(\next_state[4] ), .ZN(dr_sel_int_next)
         );
  CKND0 \*cell*504  ( .CLK(instructions[0]), .CN(net421) );
  CKMUX2D0 \*cell*503  ( .I0(net421), .S(tap_state[15]), .Z(\ff_d[0] ) );
  MUX2ND0 \*cell*502  ( .I0(instructions[1]), .I1(\temp_so[1] ), .S(
        tap_state[15]), .ZN(\ff_d[1] ) );
  AN2XD1 \*cell*501  ( .A1(shift_dr), .A2(tdi), .Z(net419) );
  CKND0 \*cell*500  ( .CN(net420) );
  MUX2ND0 \*cell*499  ( .I0(net419), .I1(net420), .S(dr_sel_int), .ZN(net418)
         );
  INR2D1 \*cell*498  ( .A1(net417), .B1(net418), .ZN(ffin) );
  CKND0 \*cell*497  ( .CLK(shift_ir_int), .CN(net416) );
  NR2XD0 \*cell*496  ( .A1(\temp_so[1] ), .A2(net416), .ZN(net414) );
  OR2D1 \*cell*495  ( .A1(shift_ir_int), .A2(net401), .Z(net411) );
  CKND0 \*cell*494  ( .CLK(net411), .CN(net415) );
  MUX2ND0 \*cell*493  ( .I0(net414), .S(net415), .ZN(ffin1) );
  CKND0 \*cell*492  ( .CLK(\temp_so[1] ), .CN(net412) );
  CKND2D0 \*cell*491  ( .A1(tdi), .A2(shift_ir_int), .ZN(net413) );
  OAI21D1 \*cell*490  ( .A1(net411), .A2(net412), .B(net413), .ZN(ffin2) );
  CKND0 \*cell*489  ( .CLK(net410), .CN(net348) );
  NR2XD0 \*cell*488  ( .A1(tap_state[1]), .A2(tap_state[14]), .ZN(net404) );
  CKND0 \*cell*487  ( .CLK(tap_state[15]), .CN(net397) );
  OR2D1 \*cell*486  ( .A1(tap_state[4]), .A2(tap_state[2]), .Z(net409) );
  OR2D1 \*cell*485  ( .A1(net408), .A2(net409), .Z(net376) );
  OR2D1 \*cell*484  ( .A1(tap_state[12]), .A2(net401), .Z(net407) );
  OR2D1 \*cell*483  ( .A1(net376), .A2(net407), .Z(net396) );
  CKND0 \*cell*482  ( .CLK(net396), .CN(net369) );
  ND3D1 \*cell*481  ( .A1(net406), .A2(net397), .A3(net369), .ZN(net405) );
  CKND0 \*cell*480  ( .CLK(net405), .CN(net394) );
  ND3D1 \*cell*479  ( .A1(tap_state[13]), .A2(net404), .A3(net394), .ZN(net356) );
  NR2XD0 \*cell*478  ( .A1(tap_state[1]), .A2(tap_state[13]), .ZN(net403) );
  ND3D1 \*cell*477  ( .A1(tap_state[14]), .A2(net403), .A3(net394), .ZN(net359) );
  NR2XD0 \*cell*476  ( .A1(tap_state[0]), .A2(net402), .ZN(net399) );
  CKND0 \*cell*475  ( .CLK(net401), .CN(net400) );
  ND3D1 \*cell*474  ( .A1(net399), .A2(net400), .A3(net368), .ZN(net398) );
  OR2D1 \*cell*473  ( .A1(net376), .A2(net398), .Z(net355) );
  AN4XD1 \*cell*472  ( .A1(net348), .A2(net356), .A3(net359), .A4(net355), .Z(
        net370) );
  NR2XD0 \*cell*471  ( .A1(tap_state[0]), .A2(net397), .ZN(net395) );
  INR2D1 \*cell*470  ( .A1(net395), .B1(net396), .ZN(net393) );
  MUX2ND0 \*cell*469  ( .I0(net393), .I1(net394), .S(tap_state[1]), .ZN(net388) );
  CKND0 \*cell*468  ( .CLK(\tap_state[8]_snps_wire ), .CN(net391) );
  NR2XD0 \*cell*467  ( .A1(tap_state[7]), .A2(tap_state[6]), .ZN(net392) );
  IND2D0 \*cell*466  ( .A1(net391), .B1(net392), .ZN(net390) );
  IND2D0 \*cell*465  ( .A1(net390), .B1(net374), .ZN(net389) );
  OAI21D1 \*cell*464  ( .A1(net387), .A2(net388), .B(net389), .ZN(net386) );
  CKND0 \*cell*463  ( .CLK(net386), .CN(net350) );
  CKND0 \*cell*462  ( .CLK(net385), .CN(net381) );
  NR3D0 \*cell*461  ( .A1(net384), .A2(tap_state[4]), .A3(tap_state[3]), .ZN(
        net382) );
  ND3D1 \*cell*460  ( .A1(net381), .A2(net382), .A3(net383), .ZN(net380) );
  CKND0 \*cell*459  ( .CLK(net380), .CN(net344) );
  XNR2D2 \*cell*458  ( .A1(tap_state[11]), .A2(tap_state[10]), .ZN(net378) );
  IND2D0 \*cell*457  ( .A1(net378), .B1(net379), .ZN(net377) );
  OR2D1 \*cell*456  ( .A1(net376), .A2(net377), .Z(net357) );
  CKND0 \*cell*455  ( .CLK(net357), .CN(net358) );
  NR3D0 \*cell*454  ( .A1(net344), .A2(net358), .A3(net341), .ZN(net372) );
  CKND0 \*cell*453  ( .CLK(net375), .CN(net364) );
  ND3D1 \*cell*452  ( .A1(tap_state[6]), .A2(net364), .A3(net374), .ZN(net373)
         );
  CKND0 \*cell*451  ( .CLK(net373), .CN(net345) );
  INR3D0 \*cell*450  ( .A1(net372), .B1(net343), .B2(net345), .ZN(net371) );
  ND3D1 \*cell*449  ( .A1(net370), .A2(net350), .A3(net371), .ZN(net361) );
  ND3D1 \*cell*448  ( .A1(tap_state[0]), .A2(net368), .A3(net369), .ZN(net351)
         );
  NR3D0 \*cell*447  ( .A1(net367), .A2(tap_state[6]), .A3(tap_state[3]), .ZN(
        net365) );
  ND3D1 \*cell*446  ( .A1(net364), .A2(net365), .A3(net366), .ZN(net360) );
  CKND0 \*cell*445  ( .CLK(net360), .CN(net363) );
  INR2D1 \*cell*444  ( .A1(net351), .B1(net363), .ZN(net362) );
  MUX2ND0 \*cell*443  ( .I0(net347), .I1(net361), .S(net362), .ZN(
        \next_state[0] ) );
  NR2XD0 \*cell*442  ( .A1(tms), .A2(net360), .ZN(\next_state[10] ) );
  CKND0 \*cell*441  ( .CLK(net359), .CN(net352) );
  OA21D1 \*cell*440  ( .A1(net358), .A2(net352), .B(net347), .Z(
        \next_state[11] ) );
  INR2D1 \*cell*439  ( .A1(tms), .B1(net357), .ZN(\next_state[12] ) );
  CKND0 \*cell*438  ( .CLK(net356), .CN(net354) );
  CKND0 \*cell*437  ( .CLK(net355), .CN(net353) );
  OA21D1 \*cell*436  ( .A1(net354), .A2(net353), .B(net347), .Z(
        \next_state[13] ) );
  AN2XD1 \*cell*435  ( .A1(net354), .A2(tms), .Z(\next_state[14] ) );
  OA21D1 \*cell*434  ( .A1(net352), .A2(net353), .B(tms), .Z(\next_state[15] )
         );
  AOI21D1 \*cell*433  ( .A1(net350), .A2(net351), .B(tms), .ZN(\next_state[1] ) );
  NR2XD0 \*cell*432  ( .A1(net350), .A2(net347), .ZN(\next_state[2] ) );
  CKND0 \*cell*431  ( .CLK(net349), .CN(\next_state[3] ) );
  NR2XD0 \*cell*430  ( .A1(net348), .A2(net347), .ZN(\next_state[5] ) );
  OAI21D1 \*cell*429  ( .A1(net345), .A2(net344), .B(net347), .ZN(net346) );
  CKND0 \*cell*428  ( .CLK(net346), .CN(\next_state[6] ) );
  AN2XD1 \*cell*427  ( .A1(net345), .A2(tms), .Z(\next_state[7] ) );
  OAI21D1 \*cell*426  ( .A1(net343), .A2(net344), .B(tms), .ZN(net342) );
  CKND0 \*cell*425  ( .CLK(net342), .CN(\next_state[8] ) );
  AN2XD1 \*cell*424  ( .A1(tms), .A2(net341), .Z(\next_state[9] ) );
  CKND0 \*cell*423  ( .CLK(instr_rst), .CN(net340) );
  CKMUX2D0 \*cell*422  ( .I0(net340), .I1(net787), .S(test), .Z(rst_n) );
  NR3D0 \*cell*421  ( .A1(tap_state[3]), .A2(tap_state[4]), .A3(shift_dr), 
        .ZN(sync_capture_en) );
  OR2D1 \*cell*420  ( .A1(shift_dr), .A2(shift_ir_int), .Z(tdo_en) );
  CKND0 \*cell*419  ( .CLK(so), .CN(net338) );
  AOI21D1 \*cell*418  ( .A1(instructions[0]), .A2(instructions[1]), .B(
        bypass_sel), .ZN(net339) );
  MUX3ND0 \*cell*417  ( .I1(net338), .S0(net339), .S1(tap_state[11]), .ZN(
        tdo_ffin) );
  AN2XD1 \*cell*416  ( .A1(tck_n), .A2(\tap_state[8]_snps_wire ), .Z(update_dr) );
  DFSNQD2 \current_state_reg[0]  ( .D(\next_state[0] ), .CP(tck), .SDN(net788), 
        .Q(tap_state[0]) );
  DFCNQD2 \current_state_reg[1]  ( .D(\next_state[1] ), .CP(tck), .CDN(net787), 
        .Q(tap_state[1]) );
  DFCNQD2 \current_state_reg[2]  ( .D(\next_state[2] ), .CP(tck), .CDN(net788), 
        .Q(tap_state[2]) );
  DFCNQD2 \current_state_reg[14]  ( .D(\next_state[14] ), .CP(tck), .CDN(
        net788), .Q(tap_state[14]) );
  DFCNQD2 \current_state_reg[13]  ( .D(\next_state[13] ), .CP(tck), .CDN(
        net787), .Q(tap_state[13]) );
  DFCNQD2 \current_state_reg[11]  ( .D(\next_state[11] ), .CP(tck), .CDN(
        net787), .Q(tap_state[11]) );
  DFCNQD2 \current_state_reg[12]  ( .D(\next_state[12] ), .CP(tck), .CDN(
        net788), .Q(tap_state[12]) );
  DFCNQD2 \current_state_reg[9]  ( .D(\next_state[9] ), .CP(tck), .CDN(net787), 
        .Q(tap_state[9]) );
  DFCNQD2 \current_state_reg[3]  ( .D(\next_state[3] ), .CP(tck), .CDN(net788), 
        .Q(tap_state[3]) );
  DFCNQD2 \current_state_reg[6]  ( .D(\next_state[6] ), .CP(tck), .CDN(net788), 
        .Q(tap_state[6]) );
  DFCNQD2 \current_state_reg[7]  ( .D(\next_state[7] ), .CP(tck), .CDN(net787), 
        .Q(tap_state[7]) );
  DFCNQD2 \current_state_reg[8]  ( .D(\next_state[8] ), .CP(tck), .CDN(net788), 
        .Q(\tap_state[8]_snps_wire ) );
  DFCNQD2 \current_state_reg[4]  ( .D(\next_state[4] ), .CP(tck), .CDN(net787), 
        .Q(tap_state[4]) );
  DFCNQD2 \current_state_reg[5]  ( .D(\next_state[5] ), .CP(tck), .CDN(net788), 
        .Q(tap_state[5]) );
  DFCNQD2 \current_state_reg[10]  ( .D(\next_state[10] ), .CP(tck), .CDN(
        net787), .Q(tap_state[10]) );
  DFCNQD2 \current_state_reg[15]  ( .D(\next_state[15] ), .CP(tck), .CDN(
        net787), .Q(tap_state[15]) );
  DFCNQD2 dr_sel_int_reg ( .D(dr_sel_int_next), .CP(tck), .CDN(net788), .Q(
        dr_sel_int) );
  DFD1 U8 ( .D(tdo_ffin), .CP(tck_n), .Q(tdo) );
  DFCND2 U71 ( .D(tap_state[4]), .CP(tck_n), .CDN(net787), .Q(shift_dr) );
  DFCND2 U82 ( .D(tap_state[11]), .CP(tck_n), .CDN(net788), .Q(shift_ir_int)
         );
  DFD1 U92 ( .D(tap_state[0]), .CP(tck_n), .Q(reset) );
  DFCND2 U3_0 ( .D(\ff_d[0] ), .CP(tck_n), .CDN(rst_n), .Q(\ff_q[0] ), .QN(
        instructions[0]) );
  DFCND2 U3_1 ( .D(\ff_d[1] ), .CP(tck_n), .CDN(rst_n), .Q(\ff_q[1] ), .QN(
        instructions[1]) );
  DFD1 U33 ( .D(ffin2), .CP(net802), .Q(\temp_so[1] ) );
  DFD1 U32 ( .D(ffin1), .CP(net802), .Q(instr_so) );
  DFD1 U4 ( .D(ffin), .CP(net802), .Q(byp_so) );
  BUFFD16 \*cell*594  ( .I(\tap_state[8]_snps_wire ), .Z(net456) );
  INVD0 \*cell*815  ( .I(net786), .ZN(net788) );
  INVD0 \*cell*814  ( .I(net786), .ZN(net787) );
  INVD0 \*cell*813  ( .I(trst_n), .ZN(net786) );
  INVD0 \*cell*821  ( .I(tck_n), .ZN(net802) );
endmodule


module Intro_Top_DW_bc_2_test_1 ( capture_clk, update_clk, capture_en, 
        update_en, shift_dr, mode, si, data_in, data_out, so );
  input capture_clk, update_clk, capture_en, update_en, shift_dr, mode, si,
         data_in;
  output data_out, so;
  wire   update_out, ffin1, ffin, net484, net483, net482;

  MUX2ND0 \*cell*614  ( .I0(data_in), .I1(update_out), .S(mode), .ZN(net482)
         );
  CKND0 \*cell*613  ( .CLK(net482), .CN(data_out) );
  CKND0 \*cell*612  ( .CLK(si), .CN(net483) );
  CKND0 \*cell*611  ( .CLK(so), .CN(net484) );
  MUX3ND0 \*cell*610  ( .I0(net482), .I1(net483), .I2(net484), .S0(shift_dr), 
        .S1(capture_en), .ZN(ffin) );
  CKMUX2D0 \*cell*609  ( .I0(update_out), .I1(so), .S(update_en), .Z(ffin1) );
  DFD2 U31 ( .D(ffin1), .CP(update_clk), .Q(update_out) );
  DFD2 U3 ( .D(ffin), .CP(capture_clk), .Q(so) );
endmodule


module Intro_Top_DW_bc_2_test_2 ( capture_clk, update_clk, capture_en, 
        update_en, shift_dr, mode, si, data_in, data_out, so );
  input capture_clk, update_clk, capture_en, update_en, shift_dr, mode, si,
         data_in;
  output data_out, so;
  wire   update_out, ffin1, ffin, net484, net483, net482;

  MUX2ND0 \*cell*614  ( .I0(data_in), .I1(update_out), .S(mode), .ZN(net482)
         );
  CKND0 \*cell*613  ( .CLK(net482), .CN(data_out) );
  CKND0 \*cell*612  ( .CLK(si), .CN(net483) );
  CKND0 \*cell*611  ( .CLK(so), .CN(net484) );
  MUX3ND0 \*cell*610  ( .I0(net482), .I1(net483), .I2(net484), .S0(shift_dr), 
        .S1(capture_en), .ZN(ffin) );
  CKMUX2D0 \*cell*609  ( .I0(update_out), .I1(so), .S(update_en), .Z(ffin1) );
  DFD2 U31 ( .D(ffin1), .CP(update_clk), .Q(update_out) );
  DFD2 U3 ( .D(ffin), .CP(capture_clk), .Q(so) );
endmodule


module Intro_Top_DW_bc_2_test_3 ( capture_clk, update_clk, capture_en, 
        update_en, shift_dr, mode, si, data_in, data_out, so );
  input capture_clk, update_clk, capture_en, update_en, shift_dr, mode, si,
         data_in;
  output data_out, so;
  wire   update_out, ffin1, ffin, net484, net483, net482;

  MUX2ND0 \*cell*614  ( .I0(data_in), .I1(update_out), .S(mode), .ZN(net482)
         );
  CKND0 \*cell*613  ( .CLK(net482), .CN(data_out) );
  CKND0 \*cell*612  ( .CLK(si), .CN(net483) );
  CKND0 \*cell*611  ( .CLK(so), .CN(net484) );
  MUX3ND0 \*cell*610  ( .I0(net482), .I1(net483), .I2(net484), .S0(shift_dr), 
        .S1(capture_en), .ZN(ffin) );
  CKMUX2D0 \*cell*609  ( .I0(update_out), .I1(so), .S(update_en), .Z(ffin1) );
  DFD2 U31 ( .D(ffin1), .CP(update_clk), .Q(update_out) );
  DFD2 U3 ( .D(ffin), .CP(capture_clk), .Q(so) );
endmodule


module Intro_Top_DW_bc_2_test_4 ( capture_clk, update_clk, capture_en, 
        update_en, shift_dr, mode, si, data_in, data_out, so );
  input capture_clk, update_clk, capture_en, update_en, shift_dr, mode, si,
         data_in;
  output data_out, so;
  wire   update_out, ffin1, ffin, net484, net483, net482;

  MUX2ND0 \*cell*614  ( .I0(data_in), .I1(update_out), .S(mode), .ZN(net482)
         );
  CKND0 \*cell*613  ( .CLK(net482), .CN(data_out) );
  CKND0 \*cell*612  ( .CLK(si), .CN(net483) );
  CKND0 \*cell*611  ( .CLK(so), .CN(net484) );
  MUX3ND0 \*cell*610  ( .I0(net482), .I1(net483), .I2(net484), .S0(shift_dr), 
        .S1(capture_en), .ZN(ffin) );
  CKMUX2D0 \*cell*609  ( .I0(update_out), .I1(so), .S(update_en), .Z(ffin1) );
  DFD2 U31 ( .D(ffin1), .CP(update_clk), .Q(update_out) );
  DFD2 U3 ( .D(ffin), .CP(capture_clk), .Q(so) );
endmodule


module Intro_Top_DW_bc_1_test_1 ( capture_clk, update_clk, capture_en, 
        update_en, shift_dr, mode, si, data_in, data_out, so );
  input capture_clk, update_clk, capture_en, update_en, shift_dr, mode, si,
         data_in;
  output data_out, so;
  wire   temp_out, ffin1, ffin;

  CKMUX2D0 \*cell*633  ( .I0(data_in), .I1(temp_out), .S(mode), .Z(data_out)
         );
  MUX3D1 \*cell*632  ( .I0(data_in), .I1(si), .I2(so), .S0(shift_dr), .S1(
        capture_en), .Z(ffin) );
  CKMUX2D0 \*cell*631  ( .I0(temp_out), .I1(so), .S(update_en), .Z(ffin1) );
  DFD2 U31 ( .D(ffin1), .CP(update_clk), .Q(temp_out) );
  DFD2 U3 ( .D(ffin), .CP(capture_clk), .Q(so) );
endmodule


module Intro_Top_DW_bc_1_test_2 ( capture_clk, update_clk, capture_en, 
        update_en, shift_dr, mode, si, data_in, data_out, so );
  input capture_clk, update_clk, capture_en, update_en, shift_dr, mode, si,
         data_in;
  output data_out, so;
  wire   temp_out, ffin1, ffin;

  CKMUX2D0 \*cell*633  ( .I0(data_in), .I1(temp_out), .S(mode), .Z(data_out)
         );
  MUX3D1 \*cell*632  ( .I0(data_in), .I1(si), .I2(so), .S0(shift_dr), .S1(
        capture_en), .Z(ffin) );
  CKMUX2D0 \*cell*631  ( .I0(temp_out), .I1(so), .S(update_en), .Z(ffin1) );
  DFD2 U31 ( .D(ffin1), .CP(update_clk), .Q(temp_out) );
  DFD2 U3 ( .D(ffin), .CP(capture_clk), .Q(so) );
endmodule


module Intro_Top_DW_bc_1_test_3 ( capture_clk, update_clk, capture_en, 
        update_en, shift_dr, mode, si, data_in, data_out, so );
  input capture_clk, update_clk, capture_en, update_en, shift_dr, mode, si,
         data_in;
  output data_out, so;
  wire   temp_out, ffin1, ffin;

  CKMUX2D0 \*cell*633  ( .I0(data_in), .I1(temp_out), .S(mode), .Z(data_out)
         );
  MUX3D1 \*cell*632  ( .I0(data_in), .I1(si), .I2(so), .S0(shift_dr), .S1(
        capture_en), .Z(ffin) );
  CKMUX2D0 \*cell*631  ( .I0(temp_out), .I1(so), .S(update_en), .Z(ffin1) );
  DFD2 U31 ( .D(ffin1), .CP(update_clk), .Q(temp_out) );
  DFD2 U3 ( .D(ffin), .CP(capture_clk), .Q(so) );
endmodule


module Intro_Top_BSR_top_inst_design ( toZ, toY, toX, shift_dr, net562, net543, 
        net541, net462, fromD, fromC, fromB, fromA, Intro_Top_tdo_en, 
        Intro_Top_tdi, Intro_Top_si_6, Intro_Top_inv_in, 
        \Intro_Top_instructions[1] , \Intro_Top_instructions[0] , 
        Intro_Top_data_out_2, Intro_Top_data_out_1, Intro_Top_data_out, 
        Intro_Top_data_in_3, Intro_Top_data_in_2, Intro_Top_data_in_1, 
        Intro_Top_data_in, Intro_Top_bypass_sel );
  input toZ, toY, toX, shift_dr, net562, net543, net541, net462, Intro_Top_tdi,
         Intro_Top_inv_in, \Intro_Top_instructions[1] ,
         \Intro_Top_instructions[0] , Intro_Top_data_in_3, Intro_Top_data_in_2,
         Intro_Top_data_in_1, Intro_Top_data_in;
  output fromD, fromC, fromB, fromA, Intro_Top_tdo_en, Intro_Top_si_6,
         Intro_Top_data_out_2, Intro_Top_data_out_1, Intro_Top_data_out,
         Intro_Top_bypass_sel;
  wire   EXTEST, Intro_Top_si, Intro_Top_si_1, Intro_Top_si_2, Intro_Top_si_3,
         Intro_Top_si_4, Intro_Top_si_5, capture_en, tck, update_en;

  Intro_Top_DW_bc_2_test_1 Intro_Top_A_bsr1 ( .capture_clk(Intro_Top_inv_in), 
        .update_clk(tck), .capture_en(capture_en), .update_en(update_en), 
        .shift_dr(shift_dr), .mode(1'b0), .si(Intro_Top_tdi), .data_in(
        Intro_Top_data_in), .data_out(fromA), .so(Intro_Top_si) );
  Intro_Top_DW_bc_2_test_2 Intro_Top_B_bsr2 ( .capture_clk(Intro_Top_inv_in), 
        .update_clk(tck), .capture_en(capture_en), .update_en(update_en), 
        .shift_dr(shift_dr), .mode(1'b0), .si(Intro_Top_si), .data_in(
        Intro_Top_data_in_1), .data_out(fromB), .so(Intro_Top_si_1) );
  Intro_Top_DW_bc_2_test_3 Intro_Top_C_bsr3 ( .capture_clk(Intro_Top_inv_in), 
        .update_clk(tck), .capture_en(capture_en), .update_en(update_en), 
        .shift_dr(shift_dr), .mode(1'b0), .si(Intro_Top_si_1), .data_in(
        Intro_Top_data_in_2), .data_out(fromC), .so(Intro_Top_si_2) );
  Intro_Top_DW_bc_2_test_4 Intro_Top_D_bsr4 ( .capture_clk(Intro_Top_inv_in), 
        .update_clk(tck), .capture_en(capture_en), .update_en(update_en), 
        .shift_dr(shift_dr), .mode(1'b0), .si(Intro_Top_si_2), .data_in(
        Intro_Top_data_in_3), .data_out(fromD), .so(Intro_Top_si_3) );
  Intro_Top_DW_bc_1_test_1 Intro_Top_X_bsr5 ( .capture_clk(Intro_Top_inv_in), 
        .update_clk(tck), .capture_en(capture_en), .update_en(update_en), 
        .shift_dr(shift_dr), .mode(EXTEST), .si(Intro_Top_si_3), .data_in(toX), 
        .data_out(Intro_Top_data_out), .so(Intro_Top_si_4) );
  Intro_Top_DW_bc_1_test_2 Intro_Top_Y_bsr6 ( .capture_clk(Intro_Top_inv_in), 
        .update_clk(tck), .capture_en(capture_en), .update_en(update_en), 
        .shift_dr(shift_dr), .mode(EXTEST), .si(Intro_Top_si_4), .data_in(toY), 
        .data_out(Intro_Top_data_out_1), .so(Intro_Top_si_5) );
  Intro_Top_DW_bc_1_test_3 Intro_Top_Z_bsr7 ( .capture_clk(Intro_Top_inv_in), 
        .update_clk(tck), .capture_en(capture_en), .update_en(update_en), 
        .shift_dr(shift_dr), .mode(EXTEST), .si(Intro_Top_si_5), .data_in(toZ), 
        .data_out(Intro_Top_data_out_2), .so(Intro_Top_si_6) );
  Intro_Top_BSR_mode_inst_design Intro_Top_BSR_mode_inst ( .update_en(
        update_en), .tck(tck), .net562(net562), .net543(net543), .net541(
        net541), .net462(net462), .capture_en(capture_en), .Intro_Top_tdo_en(
        Intro_Top_tdo_en), .Intro_Top_inv_in(Intro_Top_inv_in), 
        .\Intro_Top_instructions[1] (\Intro_Top_instructions[1] ), 
        .\Intro_Top_instructions[0] (\Intro_Top_instructions[0] ), 
        .Intro_Top_bypass_sel(Intro_Top_bypass_sel), .EXTEST(EXTEST) );
endmodule


module Intro_Top_BSR_mode_inst_design ( update_en, tck, net562, net543, net541, 
        net462, capture_en, Intro_Top_tdo_en, Intro_Top_inv_in, 
        \Intro_Top_instructions[1] , \Intro_Top_instructions[0] , 
        Intro_Top_bypass_sel, EXTEST );
  input net562, net543, net541, net462, Intro_Top_inv_in,
         \Intro_Top_instructions[1] , \Intro_Top_instructions[0] ;
  output update_en, tck, capture_en, Intro_Top_tdo_en, Intro_Top_bypass_sel,
         EXTEST;
  wire   BYPASS, PRELOAD, SAMPLE, net761, net760, net759, net758, net757,
         net756, net755, net754;

  CKND0 \*cell*799  ( .CLK(BYPASS), .CN(net758) );
  CKND0 \*cell*798  ( .CLK(EXTEST), .CN(net759) );
  CKND0 \*cell*797  ( .CLK(SAMPLE), .CN(net760) );
  CKND0 \*cell*796  ( .CLK(PRELOAD), .CN(net761) );
  ND3D1 \*cell*795  ( .A1(net759), .A2(net760), .A3(net761), .ZN(net756) );
  CKND2D0 \*cell*794  ( .A1(net758), .A2(net756), .ZN(Intro_Top_bypass_sel) );
  CKND0 \*cell*793  ( .CLK(net462), .CN(Intro_Top_tdo_en) );
  CKND0 \*cell*792  ( .CLK(net541), .CN(net757) );
  CKND2D0 \*cell*791  ( .A1(net757), .A2(net756), .ZN(capture_en) );
  CKND0 \*cell*790  ( .CLK(Intro_Top_inv_in), .CN(tck) );
  CKND0 \*cell*789  ( .CLK(net756), .CN(net754) );
  CKND0 \*cell*788  ( .CLK(net543), .CN(net755) );
  NR2XD0 \*cell*787  ( .A1(net754), .A2(net755), .ZN(update_en) );
  Intro_Top_Decoder_inst_design Intro_Top_Decoder_inst ( .SAMPLE(SAMPLE), 
        .PRELOAD(PRELOAD), .\Intro_Top_instructions[1] (
        \Intro_Top_instructions[1] ), .\Intro_Top_instructions[0] (
        \Intro_Top_instructions[0] ), .EXTEST(EXTEST), .BYPASS(BYPASS) );
endmodule


module Intro_Top_Decoder_inst_design ( SAMPLE, PRELOAD, 
        \Intro_Top_instructions[1] , \Intro_Top_instructions[0] , EXTEST, 
        BYPASS );
  input \Intro_Top_instructions[1] , \Intro_Top_instructions[0] ;
  output SAMPLE, PRELOAD, EXTEST, BYPASS;
  wire   net733, net738;
  assign PRELOAD = net738;

  AN2XD1 \*cell*781  ( .A1(\Intro_Top_instructions[1] ), .A2(
        \Intro_Top_instructions[0] ), .Z(BYPASS) );
  NR2XD0 \*cell*780  ( .A1(\Intro_Top_instructions[1] ), .A2(
        \Intro_Top_instructions[0] ), .ZN(EXTEST) );
  IND2D0 \*cell*779  ( .A1(\Intro_Top_instructions[1] ), .B1(
        \Intro_Top_instructions[0] ), .ZN(net733) );
  CKND0 \*cell*778  ( .CLK(net733), .CN(SAMPLE) );
  BUFFD16 \*cell*785  ( .I(SAMPLE), .Z(net738) );
endmodule

