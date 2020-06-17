
module rx_DW01_add_10_1 ( A, B, CI, SUM, CO );
  input [9:0] A;
  input [9:0] B;
  output [9:0] SUM;
  input CI;
  output CO;
  wire   \carry[9] , \carry[8] , \carry[7] , \carry[6] , \carry[5] ,
         \carry[4] , \carry[3] , \carry[2] , \carry[1] ;
  assign \carry[1]  = A[0];

  FA1A U1_2 ( .CI(\carry[2] ), .A(A[2]), .B(B[2]), .S(SUM[2]), .CO(\carry[3] )
         );
  FA1A U1_3 ( .CI(\carry[3] ), .A(A[3]), .B(B[3]), .S(SUM[3]), .CO(\carry[4] )
         );
  FA1A U1_4 ( .CI(\carry[4] ), .A(A[4]), .B(B[4]), .S(SUM[4]), .CO(\carry[5] )
         );
  FA1A U1_5 ( .CI(\carry[5] ), .A(A[5]), .B(B[5]), .S(SUM[5]), .CO(\carry[6] )
         );
  FA1A U1_6 ( .CI(\carry[6] ), .A(A[6]), .B(B[6]), .S(SUM[6]), .CO(\carry[7] )
         );
  FA1A U1_7 ( .CI(\carry[7] ), .A(A[7]), .B(B[7]), .S(SUM[7]), .CO(\carry[8] )
         );
  FA1A U1_8 ( .CI(\carry[8] ), .A(A[8]), .B(B[8]), .S(SUM[8]), .CO(\carry[9] )
         );
  FA1A U1_1 ( .CI(\carry[1] ), .A(A[1]), .B(B[1]), .S(SUM[1]), .CO(\carry[2] )
         );
  EO3P U1_9 ( .A(A[9]), .B(B[9]), .C(\carry[9] ), .Z(SUM[9]) );
endmodule


module rx_DW01_add_10_0 ( A, B, CI, SUM, CO );
  input [9:0] A;
  input [9:0] B;
  output [9:0] SUM;
  input CI;
  output CO;
  wire   \carry[9] , \carry[8] , \carry[7] , \carry[6] , \carry[5] ,
         \carry[4] , \carry[3] , \carry[2] , \carry[1] ;

  FA1A U1_1 ( .CI(\carry[1] ), .A(A[1]), .B(B[1]), .S(SUM[1]), .CO(\carry[2] )
         );
  FA1A U1_2 ( .CI(\carry[2] ), .A(A[2]), .B(B[2]), .S(SUM[2]), .CO(\carry[3] )
         );
  FA1A U1_3 ( .CI(\carry[3] ), .A(A[3]), .B(B[3]), .S(SUM[3]), .CO(\carry[4] )
         );
  FA1A U1_4 ( .CI(\carry[4] ), .A(A[4]), .B(B[4]), .S(SUM[4]), .CO(\carry[5] )
         );
  FA1A U1_5 ( .CI(\carry[5] ), .A(A[5]), .B(B[5]), .S(SUM[5]), .CO(\carry[6] )
         );
  FA1A U1_6 ( .CI(\carry[6] ), .A(A[6]), .B(B[6]), .S(SUM[6]), .CO(\carry[7] )
         );
  FA1A U1_7 ( .CI(\carry[7] ), .A(A[7]), .B(B[7]), .S(SUM[7]), .CO(\carry[8] )
         );
  FA1A U1_8 ( .CI(\carry[8] ), .A(A[8]), .B(B[8]), .S(SUM[8]), .CO(\carry[9] )
         );
  EO3P U1_9 ( .A(A[9]), .B(B[9]), .C(\carry[9] ), .Z(SUM[9]) );
  AN2 U4 ( .A(B[0]), .B(A[0]), .Z(\carry[1] ) );
  EO U5 ( .A(A[0]), .B(B[0]), .Z(SUM[0]) );
endmodule


module rx ( sum_0, dec_tap_1, sum_1 );
  input [9:0] sum_0;
  input [9:0] dec_tap_1;
  output [9:0] sum_1;
  wire   N0, N1, N2, N3, N4, N5, N6, N7, N8, N9;
  wire   SYNOPSYS_UNCONNECTED__0;
  assign sum_1[0] = 1'b0;

  rx_DW01_add_10_1 add_0_root_add_10_3 ( .A({N9, N8, N7, N6, N5, N4, N3, N2, 
        N1, N0}), .B({N9, N8, N7, N6, N5, N4, N3, N2, N1, N0}), .CI(1'b0), 
        .SUM({sum_1[9:1], SYNOPSYS_UNCONNECTED__0}) );
  rx_DW01_add_10_0 r260 ( .A(sum_0), .B(dec_tap_1), .CI(1'b0), .SUM({N9, N8, 
        N7, N6, N5, N4, N3, N2, N1, N0}) );
endmodule

