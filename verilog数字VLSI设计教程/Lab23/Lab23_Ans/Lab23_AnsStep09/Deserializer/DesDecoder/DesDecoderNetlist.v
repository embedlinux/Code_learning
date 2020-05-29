
module DesDecoder ( ParOut, ParValid, ParClk, SerIn, SerClk, SerValid, Reset
 );
  output [31:0] ParOut;
  input SerIn, SerClk, SerValid, Reset;
  output ParValid, ParClk;
  wire   n440, SerClock, N28, N29, N30, N31, N32, N35, N36, N37, N38, N39, N40,
         N41, N45, n2, n3, n4, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17,
         n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31,
         n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45,
         n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58, n60,
         n126, n127, n128, n129, n130, n131, n132, n133, n134, n135, n136,
         n137, n138, n142, n143, n144, n145, n146, n147, n148, n149, n150,
         n151, n152, n153, n157, n158, n159, n160, n161, n162, n163, n164,
         n165, n166, n167, n172, n173, n174, n175, n176, n177, n178, n179,
         n180, n181, n190, n191, n192, n193, n194, n195, n196, n197, n198,
         n199, n200, n201, n202, n203, n204, n205, n206, n207, n208, n209,
         n210, n211, n212, n213, n214, n215, n216, n217, n218, n219, n220,
         n221, n222, n223, n224, n225, n226, n227, n228, n229, n230, n231,
         n232, n233, n234, n235, n236, n237, n238, n239, n240, n241, n242,
         n243, n244, n245, n246, n247, n248, n249, n250, n251, n252, n253,
         n254, n255, n256, n257, n258, n259, n260, n261, n262, n263, n264,
         n298, n299, n300, n301, n302, n303, n305, n307, n309, n311, n313,
         n315, n317, n319, n321, n323, n325, n327, n329, n331, n333, n335,
         n337, n339, n341, n343, n345, n347, n349, n351, n353, n355, n357,
         n359, n361, n363, n365, n367, n369, n371, n394, n395, n396, n397,
         n398, n399, n400, n401, n402, n403, n404, n405, n406, n407, n408,
         n409, n410, n411, n412, n413, n414, n415, n416, n417, n418, n419,
         n420, n421, n422, n423, n424, n425, n426, n427, n428, n429, n430,
         n431, n432, n433, n434, n435, n436, n437, n438, n439;
  wire   [63:0] FrameSR;
  wire   [4:0] Count32;

  AN2D2 U115 ( .A1(SerClk), .A2(SerValid), .Z(SerClock) );
  OA21D1 U131 ( .A1(n58), .A2(n298), .B(SerValid), .Z(N41) );
  OR2D1 U133 ( .A1(Count32[1]), .A2(Count32[0]), .Z(n60) );
  DesDecoder_DW01_inc_0 \ClkGen/add_201  ( .A(Count32), .SUM({N32, N31, N30, 
        N29, N28}) );
  DFNCND1 \FrameSR_reg[51]  ( .D(FrameSR[50]), .CPN(SerClock), .CDN(n434), .Q(
        FrameSR[51]), .QN(n138) );
  DFNCND1 \FrameSR_reg[52]  ( .D(FrameSR[51]), .CPN(SerClock), .CDN(n434), .Q(
        FrameSR[52]), .QN(n137) );
  DFNCND1 \FrameSR_reg[36]  ( .D(FrameSR[35]), .CPN(SerClock), .CDN(n433), .Q(
        FrameSR[36]), .QN(n153) );
  DFNCND1 \FrameSR_reg[16]  ( .D(FrameSR[15]), .CPN(SerClock), .CDN(n431), .Q(
        FrameSR[16]), .QN(n173) );
  DFNCND1 \FrameSR_reg[23]  ( .D(FrameSR[22]), .CPN(SerClock), .CDN(n431), .Q(
        FrameSR[23]), .QN(n166) );
  DFNCND1 \FrameSR_reg[38]  ( .D(FrameSR[37]), .CPN(SerClock), .CDN(n433), .Q(
        FrameSR[38]), .QN(n151) );
  DFNCND1 \FrameSR_reg[54]  ( .D(FrameSR[53]), .CPN(SerClock), .CDN(n434), .Q(
        FrameSR[54]), .QN(n135) );
  DFNCND1 \FrameSR_reg[17]  ( .D(FrameSR[16]), .CPN(SerClock), .CDN(n431), .Q(
        FrameSR[17]), .QN(n172) );
  DFNCND1 \FrameSR_reg[32]  ( .D(FrameSR[31]), .CPN(SerClock), .CDN(n432), .Q(
        FrameSR[32]), .QN(n157) );
  DFNCND1 \FrameSR_reg[39]  ( .D(FrameSR[38]), .CPN(SerClock), .CDN(n433), .Q(
        FrameSR[39]), .QN(n150) );
  DFNCND1 \FrameSR_reg[55]  ( .D(FrameSR[54]), .CPN(SerClock), .CDN(n434), .Q(
        FrameSR[55]), .QN(n134) );
  DFNCND1 \FrameSR_reg[8]  ( .D(FrameSR[7]), .CPN(SerClock), .CDN(n430), .Q(
        FrameSR[8]), .QN(n181) );
  DFNCND1 \FrameSR_reg[9]  ( .D(FrameSR[8]), .CPN(SerClock), .CDN(n430), .Q(
        FrameSR[9]), .QN(n180) );
  DFNCND1 \FrameSR_reg[10]  ( .D(FrameSR[9]), .CPN(SerClock), .CDN(n430), .Q(
        FrameSR[10]), .QN(n179) );
  DFNCND1 \FrameSR_reg[11]  ( .D(FrameSR[10]), .CPN(SerClock), .CDN(n430), .Q(
        FrameSR[11]), .QN(n178) );
  DFNCND1 \FrameSR_reg[12]  ( .D(FrameSR[11]), .CPN(SerClock), .CDN(n431), .Q(
        FrameSR[12]), .QN(n177) );
  DFNCND1 \FrameSR_reg[13]  ( .D(FrameSR[12]), .CPN(SerClock), .CDN(n431), .Q(
        FrameSR[13]), .QN(n176) );
  DFNCND1 \FrameSR_reg[14]  ( .D(FrameSR[13]), .CPN(SerClock), .CDN(n431), .Q(
        FrameSR[14]), .QN(n175) );
  DFNCND1 \FrameSR_reg[15]  ( .D(FrameSR[14]), .CPN(SerClock), .CDN(n431), .Q(
        FrameSR[15]), .QN(n174) );
  DFNCND1 \FrameSR_reg[24]  ( .D(FrameSR[23]), .CPN(SerClock), .CDN(n432), .Q(
        FrameSR[24]), .QN(n165) );
  DFNCND1 \FrameSR_reg[25]  ( .D(FrameSR[24]), .CPN(SerClock), .CDN(n432), .Q(
        FrameSR[25]), .QN(n164) );
  DFNCND1 \FrameSR_reg[26]  ( .D(FrameSR[25]), .CPN(SerClock), .CDN(n432), .Q(
        FrameSR[26]), .QN(n163) );
  DFNCND1 \FrameSR_reg[27]  ( .D(FrameSR[26]), .CPN(SerClock), .CDN(n432), .Q(
        FrameSR[27]), .QN(n162) );
  DFNCND1 \FrameSR_reg[28]  ( .D(FrameSR[27]), .CPN(SerClock), .CDN(n432), .Q(
        FrameSR[28]), .QN(n161) );
  DFNCND1 \FrameSR_reg[29]  ( .D(FrameSR[28]), .CPN(SerClock), .CDN(n432), .Q(
        FrameSR[29]), .QN(n160) );
  DFNCND1 \FrameSR_reg[30]  ( .D(FrameSR[29]), .CPN(SerClock), .CDN(n432), .Q(
        FrameSR[30]), .QN(n159) );
  DFNCND1 \FrameSR_reg[31]  ( .D(FrameSR[30]), .CPN(SerClock), .CDN(n432), .Q(
        FrameSR[31]), .QN(n158) );
  DFNCND1 \FrameSR_reg[40]  ( .D(FrameSR[39]), .CPN(SerClock), .CDN(n433), .Q(
        FrameSR[40]), .QN(n149) );
  DFNCND1 \FrameSR_reg[41]  ( .D(FrameSR[40]), .CPN(SerClock), .CDN(n433), .Q(
        FrameSR[41]), .QN(n148) );
  DFNCND1 \FrameSR_reg[42]  ( .D(FrameSR[41]), .CPN(SerClock), .CDN(n433), .Q(
        FrameSR[42]), .QN(n147) );
  DFNCND1 \FrameSR_reg[43]  ( .D(FrameSR[42]), .CPN(SerClock), .CDN(n433), .Q(
        FrameSR[43]), .QN(n146) );
  DFNCND1 \FrameSR_reg[44]  ( .D(FrameSR[43]), .CPN(SerClock), .CDN(n433), .Q(
        FrameSR[44]), .QN(n145) );
  DFNCND1 \FrameSR_reg[45]  ( .D(FrameSR[44]), .CPN(SerClock), .CDN(n433), .Q(
        FrameSR[45]), .QN(n144) );
  DFNCND1 \FrameSR_reg[46]  ( .D(FrameSR[45]), .CPN(SerClock), .CDN(n433), .Q(
        FrameSR[46]), .QN(n143) );
  DFNCND1 \FrameSR_reg[47]  ( .D(FrameSR[46]), .CPN(SerClock), .CDN(n433), .Q(
        FrameSR[47]), .QN(n142) );
  DFNCND1 \FrameSR_reg[56]  ( .D(FrameSR[55]), .CPN(SerClock), .CDN(n434), .Q(
        FrameSR[56]), .QN(n133) );
  DFNCND1 \FrameSR_reg[57]  ( .D(FrameSR[56]), .CPN(SerClock), .CDN(n434), .Q(
        FrameSR[57]), .QN(n132) );
  DFNCND1 \FrameSR_reg[58]  ( .D(FrameSR[57]), .CPN(SerClock), .CDN(n434), .Q(
        FrameSR[58]), .QN(n131) );
  DFNCND1 \FrameSR_reg[59]  ( .D(FrameSR[58]), .CPN(SerClock), .CDN(n434), .Q(
        FrameSR[59]), .QN(n130) );
  DFNCND1 \FrameSR_reg[60]  ( .D(FrameSR[59]), .CPN(SerClock), .CDN(n435), .Q(
        FrameSR[60]), .QN(n129) );
  DFNCND1 \FrameSR_reg[61]  ( .D(FrameSR[60]), .CPN(SerClock), .CDN(n435), .Q(
        FrameSR[61]), .QN(n128) );
  DFNCND1 \FrameSR_reg[62]  ( .D(FrameSR[61]), .CPN(SerClock), .CDN(n435), .Q(
        FrameSR[62]), .QN(n127) );
  DFNCND1 \FrameSR_reg[63]  ( .D(FrameSR[62]), .CPN(SerClock), .CDN(n435), 
        .QN(n126) );
  DFNCND1 \FrameSR_reg[22]  ( .D(FrameSR[21]), .CPN(SerClock), .CDN(n431), .Q(
        FrameSR[22]), .QN(n167) );
  DFNCND1 \FrameSR_reg[37]  ( .D(FrameSR[36]), .CPN(SerClock), .CDN(n433), .Q(
        FrameSR[37]), .QN(n152) );
  DFNCND1 \FrameSR_reg[53]  ( .D(FrameSR[52]), .CPN(SerClock), .CDN(n434), .Q(
        FrameSR[53]), .QN(n136) );
  DFNCND1 \Decoder_reg[31]  ( .D(n258), .CPN(SerClock), .CDN(n435), .QN(n13)
         );
  DFNCND1 \Decoder_reg[30]  ( .D(n257), .CPN(SerClock), .CDN(n435), .QN(n14)
         );
  DFNCND1 \Decoder_reg[29]  ( .D(n256), .CPN(SerClock), .CDN(n435), .QN(n15)
         );
  DFNCND1 \Decoder_reg[28]  ( .D(n255), .CPN(SerClock), .CDN(n435), .QN(n16)
         );
  DFNCND1 \Decoder_reg[27]  ( .D(n254), .CPN(SerClock), .CDN(n435), .QN(n17)
         );
  DFNCND1 \Decoder_reg[26]  ( .D(n253), .CPN(SerClock), .CDN(n435), .QN(n18)
         );
  DFNCND1 \Decoder_reg[25]  ( .D(n252), .CPN(SerClock), .CDN(n435), .QN(n19)
         );
  DFNCND1 \Decoder_reg[24]  ( .D(n251), .CPN(SerClock), .CDN(n435), .QN(n20)
         );
  DFNCND1 \Decoder_reg[23]  ( .D(n250), .CPN(SerClock), .CDN(n435), .QN(n21)
         );
  DFNCND1 \Decoder_reg[22]  ( .D(n249), .CPN(SerClock), .CDN(n435), .QN(n22)
         );
  DFNCND1 \Decoder_reg[21]  ( .D(n248), .CPN(SerClock), .CDN(n433), .QN(n23)
         );
  DFNCND1 \Decoder_reg[20]  ( .D(n247), .CPN(SerClock), .CDN(n259), .QN(n24)
         );
  DFNCND1 \Decoder_reg[19]  ( .D(n246), .CPN(SerClock), .CDN(n434), .QN(n25)
         );
  DFNCND1 \Decoder_reg[18]  ( .D(n245), .CPN(SerClock), .CDN(n259), .QN(n26)
         );
  DFNCND1 \Decoder_reg[17]  ( .D(n244), .CPN(SerClock), .CDN(n436), .QN(n27)
         );
  DFNCND1 \Decoder_reg[16]  ( .D(n243), .CPN(SerClock), .CDN(n259), .QN(n28)
         );
  DFNCND1 \Decoder_reg[15]  ( .D(n242), .CPN(SerClock), .CDN(n433), .QN(n29)
         );
  DFNCND1 \Decoder_reg[14]  ( .D(n241), .CPN(SerClock), .CDN(n436), .QN(n30)
         );
  DFNCND1 \Decoder_reg[13]  ( .D(n240), .CPN(SerClock), .CDN(n259), .QN(n31)
         );
  DFNCND1 \Decoder_reg[12]  ( .D(n239), .CPN(SerClock), .CDN(n436), .QN(n32)
         );
  DFNCND1 \Decoder_reg[11]  ( .D(n238), .CPN(SerClock), .CDN(n430), .QN(n33)
         );
  DFNCND1 \Decoder_reg[10]  ( .D(n237), .CPN(SerClock), .CDN(n259), .QN(n34)
         );
  DFNCND1 \Decoder_reg[9]  ( .D(n236), .CPN(SerClock), .CDN(n259), .QN(n35) );
  DFNCND1 \Decoder_reg[8]  ( .D(n235), .CPN(SerClock), .CDN(n259), .QN(n36) );
  DFNCND1 \Decoder_reg[7]  ( .D(n234), .CPN(SerClock), .CDN(n431), .QN(n37) );
  DFNCND1 \Decoder_reg[6]  ( .D(n233), .CPN(SerClock), .CDN(n431), .QN(n38) );
  DFNCND1 \Decoder_reg[5]  ( .D(n232), .CPN(SerClock), .CDN(n436), .QN(n39) );
  DFNCND1 \Decoder_reg[4]  ( .D(n231), .CPN(SerClock), .CDN(n431), .QN(n40) );
  DFNCND1 \Decoder_reg[3]  ( .D(n230), .CPN(SerClock), .CDN(n259), .QN(n41) );
  DFNCND1 \Decoder_reg[2]  ( .D(n229), .CPN(SerClock), .CDN(n430), .QN(n42) );
  DFNCND1 \Decoder_reg[1]  ( .D(n228), .CPN(SerClock), .CDN(n436), .QN(n43) );
  DFNCND1 \Decoder_reg[0]  ( .D(n227), .CPN(SerClock), .CDN(n432), .QN(n44) );
  EDFCNQD1 \Count32_reg[4]  ( .D(N40), .E(SerValid), .CP(SerClock), .CDN(n431), 
        .Q(Count32[4]) );
  DFNCND1 \FrameSR_reg[0]  ( .D(SerIn), .CPN(SerClock), .CDN(n430), .Q(
        FrameSR[0]) );
  DFNCND1 \FrameSR_reg[4]  ( .D(FrameSR[3]), .CPN(SerClock), .CDN(n430), .Q(
        FrameSR[4]) );
  DFNCND1 \FrameSR_reg[20]  ( .D(FrameSR[19]), .CPN(SerClock), .CDN(n431), .Q(
        FrameSR[20]) );
  DFNCND1 \FrameSR_reg[34]  ( .D(FrameSR[33]), .CPN(SerClock), .CDN(n432), .Q(
        FrameSR[34]) );
  DFNCND1 \FrameSR_reg[49]  ( .D(FrameSR[48]), .CPN(SerClock), .CDN(n434), .Q(
        FrameSR[49]) );
  DFNCND1 \FrameSR_reg[2]  ( .D(FrameSR[1]), .CPN(SerClock), .CDN(n430), .Q(
        FrameSR[2]) );
  DFNCND1 \FrameSR_reg[6]  ( .D(FrameSR[5]), .CPN(SerClock), .CDN(n430), .Q(
        FrameSR[6]) );
  DFNCND1 \FrameSR_reg[18]  ( .D(FrameSR[17]), .CPN(SerClock), .CDN(n431), .Q(
        FrameSR[18]) );
  DFNCND1 \FrameSR_reg[33]  ( .D(FrameSR[32]), .CPN(SerClock), .CDN(n432), .Q(
        FrameSR[33]) );
  DFNCND1 \FrameSR_reg[48]  ( .D(FrameSR[47]), .CPN(SerClock), .CDN(n434), .Q(
        FrameSR[48]) );
  DFNCND1 \FrameSR_reg[1]  ( .D(FrameSR[0]), .CPN(SerClock), .CDN(n430), .Q(
        FrameSR[1]) );
  DFNCND1 \FrameSR_reg[3]  ( .D(FrameSR[2]), .CPN(SerClock), .CDN(n430), .Q(
        FrameSR[3]) );
  DFNCND1 \FrameSR_reg[5]  ( .D(FrameSR[4]), .CPN(SerClock), .CDN(n430), .Q(
        FrameSR[5]) );
  DFNCND1 \FrameSR_reg[7]  ( .D(FrameSR[6]), .CPN(SerClock), .CDN(n430), .Q(
        FrameSR[7]) );
  DFNCND1 \FrameSR_reg[21]  ( .D(FrameSR[20]), .CPN(SerClock), .CDN(n431), .Q(
        FrameSR[21]) );
  DFNCND1 \FrameSR_reg[35]  ( .D(FrameSR[34]), .CPN(SerClock), .CDN(n432), .Q(
        FrameSR[35]) );
  DFNCND1 \FrameSR_reg[50]  ( .D(FrameSR[49]), .CPN(SerClock), .CDN(n434), .Q(
        FrameSR[50]) );
  DFNCND1 \FrameSR_reg[19]  ( .D(FrameSR[18]), .CPN(SerClock), .CDN(n431), .Q(
        FrameSR[19]) );
  EDFCNQD1 \Count32_reg[1]  ( .D(N37), .E(SerValid), .CP(SerClock), .CDN(n436), 
        .Q(Count32[1]) );
  EDFCNQD1 \Count32_reg[3]  ( .D(N39), .E(SerValid), .CP(SerClock), .CDN(n435), 
        .Q(Count32[3]) );
  EDFCNQD1 \Count32_reg[2]  ( .D(N38), .E(SerValid), .CP(SerClock), .CDN(n436), 
        .Q(Count32[2]) );
  EDFCNQD1 \Count32_reg[0]  ( .D(N36), .E(SerValid), .CP(SerClock), .CDN(n259), 
        .Q(Count32[0]) );
  DFNCND1 \ParValidTimer_reg[2]  ( .D(n192), .CPN(SerClock), .CDN(n259), .QN(
        n263) );
  DFNCND1 \ParValidTimer_reg[1]  ( .D(n193), .CPN(SerClock), .CDN(n431), .Q(
        n300), .QN(n261) );
  DFNCND1 \ParValidTimer_reg[3]  ( .D(n191), .CPN(SerClock), .CDN(n434), .QN(
        n264) );
  DFNCND1 \ParValidTimer_reg[0]  ( .D(n194), .CPN(SerClock), .CDN(n259), .QN(
        n262) );
  DFNCND1 UnLoad_reg ( .D(n438), .CPN(SerClock), .CDN(n436), .Q(n299), .QN(
        n260) );
  DFNCND1 doParSync_reg ( .D(N45), .CPN(SerClock), .CDN(n434), .Q(n298), .QN(
        n2) );
  EDFCNQD1 ParClkr_reg ( .D(N35), .E(N41), .CP(SerClock), .CDN(n434), .Q(n440)
         );
  DFNCND1 ParValidr_reg ( .D(n190), .CPN(SerClock), .CDN(n435), .QN(n394) );
  DFNCND1 \ParOutr_reg[22]  ( .D(n204), .CPN(SerClock), .CDN(n432), .QN(n395)
         );
  DFNCND1 \ParOutr_reg[23]  ( .D(n203), .CPN(SerClock), .CDN(n435), .QN(n396)
         );
  DFNCND1 \ParOutr_reg[24]  ( .D(n202), .CPN(SerClock), .CDN(n434), .QN(n397)
         );
  DFNCND1 \ParOutr_reg[25]  ( .D(n201), .CPN(SerClock), .CDN(n433), .QN(n398)
         );
  DFNCND1 \ParOutr_reg[0]  ( .D(n226), .CPN(SerClock), .CDN(n436), .QN(n399)
         );
  DFNCND1 \ParOutr_reg[1]  ( .D(n225), .CPN(SerClock), .CDN(n436), .QN(n400)
         );
  DFNCND1 \ParOutr_reg[2]  ( .D(n224), .CPN(SerClock), .CDN(n435), .QN(n401)
         );
  DFNCND1 \ParOutr_reg[3]  ( .D(n223), .CPN(SerClock), .CDN(n259), .QN(n402)
         );
  DFNCND1 \ParOutr_reg[4]  ( .D(n222), .CPN(SerClock), .CDN(n259), .QN(n403)
         );
  DFNCND1 \ParOutr_reg[5]  ( .D(n221), .CPN(SerClock), .CDN(n436), .QN(n404)
         );
  DFNCND1 \ParOutr_reg[6]  ( .D(n220), .CPN(SerClock), .CDN(n430), .QN(n405)
         );
  DFNCND1 \ParOutr_reg[7]  ( .D(n219), .CPN(SerClock), .CDN(n436), .QN(n406)
         );
  DFNCND1 \ParOutr_reg[8]  ( .D(n218), .CPN(SerClock), .CDN(n432), .QN(n407)
         );
  DFNCND1 \ParOutr_reg[9]  ( .D(n217), .CPN(SerClock), .CDN(n259), .QN(n408)
         );
  DFNCND1 \ParOutr_reg[10]  ( .D(n216), .CPN(SerClock), .CDN(n431), .QN(n409)
         );
  DFNCND1 \ParOutr_reg[11]  ( .D(n215), .CPN(SerClock), .CDN(n432), .QN(n410)
         );
  DFNCND1 \ParOutr_reg[12]  ( .D(n214), .CPN(SerClock), .CDN(n436), .QN(n411)
         );
  DFNCND1 \ParOutr_reg[13]  ( .D(n213), .CPN(SerClock), .CDN(n433), .QN(n412)
         );
  DFNCND1 \ParOutr_reg[14]  ( .D(n212), .CPN(SerClock), .CDN(n259), .QN(n413)
         );
  DFNCND1 \ParOutr_reg[15]  ( .D(n211), .CPN(SerClock), .CDN(n433), .QN(n414)
         );
  DFNCND1 \ParOutr_reg[16]  ( .D(n210), .CPN(SerClock), .CDN(n436), .QN(n415)
         );
  DFNCND1 \ParOutr_reg[17]  ( .D(n209), .CPN(SerClock), .CDN(n259), .QN(n416)
         );
  DFNCND1 \ParOutr_reg[18]  ( .D(n208), .CPN(SerClock), .CDN(n436), .QN(n417)
         );
  DFNCND1 \ParOutr_reg[19]  ( .D(n207), .CPN(SerClock), .CDN(n259), .QN(n418)
         );
  DFNCND1 \ParOutr_reg[20]  ( .D(n206), .CPN(SerClock), .CDN(n432), .QN(n419)
         );
  DFNCND1 \ParOutr_reg[21]  ( .D(n205), .CPN(SerClock), .CDN(n430), .QN(n420)
         );
  DFNCND1 \ParOutr_reg[26]  ( .D(n200), .CPN(SerClock), .CDN(n436), .QN(n421)
         );
  DFNCND1 \ParOutr_reg[27]  ( .D(n199), .CPN(SerClock), .CDN(n430), .QN(n422)
         );
  DFNCND1 \ParOutr_reg[28]  ( .D(n198), .CPN(SerClock), .CDN(n259), .QN(n423)
         );
  DFNCND1 \ParOutr_reg[29]  ( .D(n197), .CPN(SerClock), .CDN(n434), .QN(n424)
         );
  DFNCND1 \ParOutr_reg[30]  ( .D(n196), .CPN(SerClock), .CDN(n433), .QN(n425)
         );
  DFNCND1 \ParOutr_reg[31]  ( .D(n195), .CPN(SerClock), .CDN(n432), .QN(n426)
         );
  INVD1 U141 ( .I(n369), .ZN(n302) );
  INVD0 U142 ( .I(n369), .ZN(n301) );
  CKNXD16 U143 ( .I(n369), .ZN(ParClk) );
  CKBD0 U144 ( .CLK(n427), .C(n369) );
  CKBD0 U145 ( .CLK(n426), .C(n303) );
  CKNXD16 U146 ( .I(n303), .ZN(ParOut[31]) );
  CKBD0 U147 ( .CLK(n425), .C(n305) );
  CKNXD16 U148 ( .I(n305), .ZN(ParOut[30]) );
  CKBD0 U149 ( .CLK(n424), .C(n307) );
  CKNXD16 U150 ( .I(n307), .ZN(ParOut[29]) );
  CKBD0 U151 ( .CLK(n423), .C(n309) );
  CKNXD16 U152 ( .I(n309), .ZN(ParOut[28]) );
  CKBD0 U153 ( .CLK(n422), .C(n311) );
  CKNXD16 U154 ( .I(n311), .ZN(ParOut[27]) );
  CKBD0 U155 ( .CLK(n421), .C(n313) );
  CKNXD16 U156 ( .I(n313), .ZN(ParOut[26]) );
  CKBD0 U157 ( .CLK(n420), .C(n315) );
  CKNXD16 U158 ( .I(n315), .ZN(ParOut[21]) );
  CKBD0 U159 ( .CLK(n419), .C(n317) );
  CKNXD16 U160 ( .I(n317), .ZN(ParOut[20]) );
  CKBD0 U161 ( .CLK(n418), .C(n319) );
  CKNXD16 U162 ( .I(n319), .ZN(ParOut[19]) );
  CKBD0 U163 ( .CLK(n417), .C(n321) );
  CKNXD16 U164 ( .I(n321), .ZN(ParOut[18]) );
  CKBD0 U165 ( .CLK(n416), .C(n323) );
  CKNXD16 U166 ( .I(n323), .ZN(ParOut[17]) );
  CKBD0 U167 ( .CLK(n415), .C(n325) );
  CKNXD16 U168 ( .I(n325), .ZN(ParOut[16]) );
  CKBD0 U169 ( .CLK(n414), .C(n327) );
  CKNXD16 U170 ( .I(n327), .ZN(ParOut[15]) );
  CKBD0 U171 ( .CLK(n413), .C(n329) );
  CKNXD16 U172 ( .I(n329), .ZN(ParOut[14]) );
  CKBD0 U173 ( .CLK(n412), .C(n331) );
  CKNXD16 U174 ( .I(n331), .ZN(ParOut[13]) );
  CKBD0 U175 ( .CLK(n411), .C(n333) );
  CKNXD16 U176 ( .I(n333), .ZN(ParOut[12]) );
  CKBD0 U177 ( .CLK(n410), .C(n335) );
  CKNXD16 U178 ( .I(n335), .ZN(ParOut[11]) );
  CKBD0 U179 ( .CLK(n409), .C(n337) );
  CKNXD16 U180 ( .I(n337), .ZN(ParOut[10]) );
  CKBD0 U181 ( .CLK(n408), .C(n339) );
  CKNXD16 U182 ( .I(n339), .ZN(ParOut[9]) );
  CKBD0 U183 ( .CLK(n407), .C(n341) );
  CKNXD16 U184 ( .I(n341), .ZN(ParOut[8]) );
  CKBD0 U185 ( .CLK(n406), .C(n343) );
  CKNXD16 U186 ( .I(n343), .ZN(ParOut[7]) );
  CKBD0 U187 ( .CLK(n405), .C(n345) );
  CKNXD16 U188 ( .I(n345), .ZN(ParOut[6]) );
  CKBD0 U189 ( .CLK(n404), .C(n347) );
  CKNXD16 U190 ( .I(n347), .ZN(ParOut[5]) );
  CKBD0 U191 ( .CLK(n403), .C(n349) );
  CKNXD16 U192 ( .I(n349), .ZN(ParOut[4]) );
  CKBD0 U193 ( .CLK(n402), .C(n351) );
  CKNXD16 U194 ( .I(n351), .ZN(ParOut[3]) );
  CKBD0 U195 ( .CLK(n401), .C(n353) );
  CKNXD16 U196 ( .I(n353), .ZN(ParOut[2]) );
  CKBD0 U197 ( .CLK(n400), .C(n355) );
  CKNXD16 U198 ( .I(n355), .ZN(ParOut[1]) );
  CKBD0 U199 ( .CLK(n399), .C(n357) );
  CKNXD16 U200 ( .I(n357), .ZN(ParOut[0]) );
  CKBD0 U201 ( .CLK(n398), .C(n359) );
  CKNXD16 U202 ( .I(n359), .ZN(ParOut[25]) );
  CKBD0 U203 ( .CLK(n397), .C(n361) );
  CKNXD16 U204 ( .I(n361), .ZN(ParOut[24]) );
  CKBD0 U205 ( .CLK(n396), .C(n363) );
  CKNXD16 U206 ( .I(n363), .ZN(ParOut[23]) );
  CKBD0 U207 ( .CLK(n395), .C(n365) );
  CKNXD16 U208 ( .I(n365), .ZN(ParOut[22]) );
  CKBD0 U209 ( .CLK(n394), .C(n367) );
  CKNXD16 U210 ( .I(n367), .ZN(ParValid) );
  CKND0 U211 ( .CLK(n440), .CN(n427) );
  INVD1 U212 ( .I(n439), .ZN(n437) );
  INVD1 U213 ( .I(n45), .ZN(n438) );
  BUFFD1 U214 ( .I(n45), .Z(n439) );
  BUFFD1 U215 ( .I(n431), .Z(n435) );
  BUFFD1 U216 ( .I(n430), .Z(n434) );
  BUFFD1 U217 ( .I(n434), .Z(n433) );
  BUFFD1 U218 ( .I(n436), .Z(n432) );
  BUFFD1 U219 ( .I(n436), .Z(n431) );
  BUFFD1 U220 ( .I(n436), .Z(n430) );
  NR2D0 U221 ( .A1(n301), .A2(n298), .ZN(N35) );
  IND2D1 U222 ( .A1(n46), .B1(n47), .ZN(n45) );
  NR2D1 U223 ( .A1(n47), .A2(n46), .ZN(N45) );
  INVD1 U224 ( .I(n429), .ZN(n428) );
  BUFFD1 U225 ( .I(n259), .Z(n436) );
  NR4D0 U226 ( .A1(n4), .A2(n300), .A3(n264), .A4(n302), .ZN(n3) );
  ND2D1 U227 ( .A1(n263), .A2(n262), .ZN(n4) );
  NR4D0 U228 ( .A1(n60), .A2(Count32[2]), .A3(Count32[4]), .A4(Count32[3]), 
        .ZN(n58) );
  AN2D1 U229 ( .A1(N32), .A2(n2), .Z(N40) );
  AN2D1 U230 ( .A1(N31), .A2(n2), .Z(N39) );
  AN2D1 U231 ( .A1(N30), .A2(n2), .Z(N38) );
  AN2D1 U232 ( .A1(N29), .A2(n2), .Z(N37) );
  AN2D1 U233 ( .A1(N28), .A2(n2), .Z(N36) );
  NR4D0 U234 ( .A1(n57), .A2(n137), .A3(n153), .A4(n138), .ZN(n50) );
  ND3D1 U235 ( .A1(n173), .A2(n172), .A3(FrameSR[19]), .ZN(n57) );
  OAI22D0 U236 ( .A1(n299), .A2(n395), .B1(n429), .B2(n22), .ZN(n204) );
  OAI22D0 U237 ( .A1(n299), .A2(n396), .B1(n429), .B2(n21), .ZN(n203) );
  OAI22D0 U238 ( .A1(n299), .A2(n397), .B1(n429), .B2(n20), .ZN(n202) );
  OAI22D0 U239 ( .A1(n299), .A2(n398), .B1(n429), .B2(n19), .ZN(n201) );
  OAI22D0 U240 ( .A1(n45), .A2(n181), .B1(n437), .B2(n44), .ZN(n227) );
  OAI22D0 U241 ( .A1(n45), .A2(n180), .B1(n437), .B2(n43), .ZN(n228) );
  OAI22D0 U242 ( .A1(n45), .A2(n179), .B1(n437), .B2(n42), .ZN(n229) );
  OAI22D0 U243 ( .A1(n45), .A2(n178), .B1(n438), .B2(n41), .ZN(n230) );
  OAI22D0 U244 ( .A1(n45), .A2(n177), .B1(n438), .B2(n40), .ZN(n231) );
  OAI22D0 U245 ( .A1(n45), .A2(n176), .B1(n438), .B2(n39), .ZN(n232) );
  OAI22D0 U246 ( .A1(n439), .A2(n175), .B1(n438), .B2(n38), .ZN(n233) );
  OAI22D0 U247 ( .A1(n439), .A2(n174), .B1(n438), .B2(n37), .ZN(n234) );
  OAI22D0 U248 ( .A1(n439), .A2(n165), .B1(n438), .B2(n36), .ZN(n235) );
  OAI22D0 U249 ( .A1(n439), .A2(n164), .B1(n438), .B2(n35), .ZN(n236) );
  OAI22D0 U250 ( .A1(n439), .A2(n163), .B1(n438), .B2(n34), .ZN(n237) );
  OAI22D0 U251 ( .A1(n439), .A2(n162), .B1(n437), .B2(n33), .ZN(n238) );
  OAI22D0 U252 ( .A1(n439), .A2(n161), .B1(n438), .B2(n32), .ZN(n239) );
  OAI22D0 U253 ( .A1(n439), .A2(n160), .B1(n437), .B2(n31), .ZN(n240) );
  OAI22D0 U254 ( .A1(n439), .A2(n159), .B1(n438), .B2(n30), .ZN(n241) );
  OAI22D0 U255 ( .A1(n439), .A2(n158), .B1(n437), .B2(n29), .ZN(n242) );
  OAI22D0 U256 ( .A1(n439), .A2(n149), .B1(n437), .B2(n28), .ZN(n243) );
  OAI22D0 U257 ( .A1(n439), .A2(n148), .B1(n437), .B2(n27), .ZN(n244) );
  OAI22D0 U258 ( .A1(n45), .A2(n147), .B1(n437), .B2(n26), .ZN(n245) );
  OAI22D0 U259 ( .A1(n45), .A2(n146), .B1(n437), .B2(n25), .ZN(n246) );
  OAI22D0 U260 ( .A1(n45), .A2(n145), .B1(n437), .B2(n24), .ZN(n247) );
  OAI22D0 U261 ( .A1(n45), .A2(n144), .B1(n437), .B2(n23), .ZN(n248) );
  OAI22D0 U262 ( .A1(n45), .A2(n143), .B1(n437), .B2(n22), .ZN(n249) );
  OAI22D0 U263 ( .A1(n45), .A2(n142), .B1(n437), .B2(n21), .ZN(n250) );
  OAI22D0 U264 ( .A1(n439), .A2(n133), .B1(n438), .B2(n20), .ZN(n251) );
  OAI22D0 U265 ( .A1(n439), .A2(n132), .B1(n437), .B2(n19), .ZN(n252) );
  OAI22D0 U266 ( .A1(n45), .A2(n131), .B1(n438), .B2(n18), .ZN(n253) );
  OAI22D0 U267 ( .A1(n45), .A2(n130), .B1(n438), .B2(n17), .ZN(n254) );
  OAI22D0 U268 ( .A1(n45), .A2(n129), .B1(n437), .B2(n16), .ZN(n255) );
  OAI22D0 U269 ( .A1(n45), .A2(n128), .B1(n438), .B2(n15), .ZN(n256) );
  OAI22D0 U270 ( .A1(n45), .A2(n127), .B1(n438), .B2(n14), .ZN(n257) );
  OAI22D0 U271 ( .A1(n45), .A2(n126), .B1(n438), .B2(n13), .ZN(n258) );
  OAI22D0 U272 ( .A1(n299), .A2(n399), .B1(n260), .B2(n44), .ZN(n226) );
  OAI22D0 U273 ( .A1(n299), .A2(n400), .B1(n260), .B2(n43), .ZN(n225) );
  OAI22D0 U274 ( .A1(n299), .A2(n401), .B1(n260), .B2(n42), .ZN(n224) );
  OAI22D0 U275 ( .A1(n428), .A2(n402), .B1(n260), .B2(n41), .ZN(n223) );
  OAI22D0 U276 ( .A1(n428), .A2(n403), .B1(n260), .B2(n40), .ZN(n222) );
  OAI22D0 U277 ( .A1(n428), .A2(n404), .B1(n429), .B2(n39), .ZN(n221) );
  OAI22D0 U278 ( .A1(n428), .A2(n405), .B1(n429), .B2(n38), .ZN(n220) );
  OAI22D0 U279 ( .A1(n428), .A2(n406), .B1(n260), .B2(n37), .ZN(n219) );
  OAI22D0 U280 ( .A1(n428), .A2(n407), .B1(n260), .B2(n36), .ZN(n218) );
  OAI22D0 U281 ( .A1(n428), .A2(n408), .B1(n260), .B2(n35), .ZN(n217) );
  OAI22D0 U282 ( .A1(n428), .A2(n409), .B1(n260), .B2(n34), .ZN(n216) );
  OAI22D0 U283 ( .A1(n428), .A2(n410), .B1(n260), .B2(n33), .ZN(n215) );
  OAI22D0 U284 ( .A1(n428), .A2(n411), .B1(n260), .B2(n32), .ZN(n214) );
  OAI22D0 U285 ( .A1(n428), .A2(n412), .B1(n260), .B2(n31), .ZN(n213) );
  OAI22D0 U286 ( .A1(n299), .A2(n413), .B1(n260), .B2(n30), .ZN(n212) );
  OAI22D0 U287 ( .A1(n299), .A2(n414), .B1(n260), .B2(n29), .ZN(n211) );
  OAI22D0 U288 ( .A1(n299), .A2(n415), .B1(n260), .B2(n28), .ZN(n210) );
  OAI22D0 U289 ( .A1(n299), .A2(n416), .B1(n260), .B2(n27), .ZN(n209) );
  OAI22D0 U290 ( .A1(n299), .A2(n417), .B1(n260), .B2(n26), .ZN(n208) );
  OAI22D0 U291 ( .A1(n299), .A2(n418), .B1(n429), .B2(n25), .ZN(n207) );
  OAI22D0 U292 ( .A1(n299), .A2(n419), .B1(n260), .B2(n24), .ZN(n206) );
  OAI22D0 U293 ( .A1(n428), .A2(n422), .B1(n429), .B2(n17), .ZN(n199) );
  OAI22D0 U294 ( .A1(n428), .A2(n423), .B1(n429), .B2(n16), .ZN(n198) );
  OAI22D0 U295 ( .A1(n428), .A2(n424), .B1(n429), .B2(n15), .ZN(n197) );
  OAI22D0 U296 ( .A1(n428), .A2(n425), .B1(n429), .B2(n14), .ZN(n196) );
  OAI22D0 U297 ( .A1(n428), .A2(n426), .B1(n260), .B2(n13), .ZN(n195) );
  OAI22D0 U298 ( .A1(n299), .A2(n420), .B1(n429), .B2(n23), .ZN(n205) );
  OAI22D0 U299 ( .A1(n428), .A2(n421), .B1(n429), .B2(n18), .ZN(n200) );
  INR2D1 U300 ( .A1(n264), .B1(n262), .ZN(n10) );
  ND2D1 U301 ( .A1(n48), .A2(n49), .ZN(n46) );
  NR4D0 U302 ( .A1(FrameSR[3]), .A2(FrameSR[2]), .A3(FrameSR[1]), .A4(
        FrameSR[0]), .ZN(n48) );
  NR4D0 U303 ( .A1(FrameSR[7]), .A2(FrameSR[6]), .A3(FrameSR[5]), .A4(
        FrameSR[4]), .ZN(n49) );
  AN4D1 U304 ( .A1(n50), .A2(n51), .A3(n52), .A4(n53), .Z(n47) );
  NR4D0 U305 ( .A1(n56), .A2(FrameSR[18]), .A3(FrameSR[21]), .A4(FrameSR[20]), 
        .ZN(n51) );
  NR4D0 U306 ( .A1(n55), .A2(FrameSR[33]), .A3(FrameSR[35]), .A4(FrameSR[34]), 
        .ZN(n52) );
  NR4D0 U307 ( .A1(n54), .A2(FrameSR[48]), .A3(FrameSR[50]), .A4(FrameSR[49]), 
        .ZN(n53) );
  BUFFD1 U308 ( .I(n260), .Z(n429) );
  ND3D1 U309 ( .A1(n135), .A2(n134), .A3(n136), .ZN(n54) );
  ND3D1 U310 ( .A1(n151), .A2(n150), .A3(n152), .ZN(n55) );
  ND3D1 U311 ( .A1(n166), .A2(n157), .A3(n167), .ZN(n56) );
  INR2D1 U312 ( .A1(n371), .B1(n299), .ZN(n191) );
  OAI31D0 U313 ( .A1(n262), .A2(n263), .A3(n261), .B(n264), .ZN(n371) );
  NR2D1 U314 ( .A1(n299), .A2(n8), .ZN(n192) );
  XNR2D1 U315 ( .A1(n9), .A2(n263), .ZN(n8) );
  ND2D1 U316 ( .A1(n10), .A2(n300), .ZN(n9) );
  NR2D1 U317 ( .A1(n299), .A2(n11), .ZN(n193) );
  XOR2D1 U318 ( .A1(n10), .A2(n261), .Z(n11) );
  NR2D1 U319 ( .A1(n299), .A2(n12), .ZN(n194) );
  XOR2D1 U320 ( .A1(n264), .A2(n262), .Z(n12) );
  INVD1 U321 ( .I(Reset), .ZN(n259) );
  OAI21D1 U322 ( .A1(n3), .A2(n394), .B(n429), .ZN(n190) );
endmodule


module DesDecoder_DW01_inc_0 ( A, SUM );
  input [4:0] A;
  output [4:0] SUM;
  wire   \carry[4] , \carry[3] , \carry[2] ;

  HA1D0 U1_1_3 ( .A(A[3]), .B(\carry[3] ), .CO(\carry[4] ), .S(SUM[3]) );
  HA1D0 U1_1_1 ( .A(A[1]), .B(A[0]), .CO(\carry[2] ), .S(SUM[1]) );
  HA1D0 U1_1_2 ( .A(A[2]), .B(\carry[2] ), .CO(\carry[3] ), .S(SUM[2]) );
  CKXOR2D0 U1 ( .A1(\carry[4] ), .A2(A[4]), .Z(SUM[4]) );
  CKND0 U2 ( .CLK(A[0]), .CN(SUM[0]) );
endmodule

