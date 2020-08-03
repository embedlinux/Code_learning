/*
Copyright (C) 2009 SysWip

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

`timescale 1ns/10ps

module aes_sbox (
  sbox_in,
  sbox_out
);

  input  [7:0] sbox_in;
  output [7:0] sbox_out;
  reg    [7:0] sbox_out;

  always @ (sbox_in) begin
    case (sbox_in)
      8'd0:   sbox_out = 8'd99;
      8'd1:   sbox_out = 8'd124;
      8'd2:   sbox_out = 8'd119;
      8'd3:   sbox_out = 8'd123;
      8'd4:   sbox_out = 8'd242;
      8'd5:   sbox_out = 8'd107;
      8'd6:   sbox_out = 8'd111;
      8'd7:   sbox_out = 8'd197;
      8'd8:   sbox_out = 8'd48;
      8'd9:   sbox_out = 8'd1;
      8'd10:  sbox_out = 8'd103;
      8'd11:  sbox_out = 8'd43;
      8'd12:  sbox_out = 8'd254;
      8'd13:  sbox_out = 8'd215;
      8'd14:  sbox_out = 8'd171;
      8'd15:  sbox_out = 8'd118;
      8'd16:  sbox_out = 8'd202;
      8'd17:  sbox_out = 8'd130;
      8'd18:  sbox_out = 8'd201;
      8'd19:  sbox_out = 8'd125;
      8'd20:  sbox_out = 8'd250;
      8'd21:  sbox_out = 8'd89;
      8'd22:  sbox_out = 8'd71;
      8'd23:  sbox_out = 8'd240;
      8'd24:  sbox_out = 8'd173;
      8'd25:  sbox_out = 8'd212;
      8'd26:  sbox_out = 8'd162;
      8'd27:  sbox_out = 8'd175;
      8'd28:  sbox_out = 8'd156;
      8'd29:  sbox_out = 8'd164;
      8'd30:  sbox_out = 8'd114;
      8'd31:  sbox_out = 8'd192;
      8'd32:  sbox_out = 8'd183;
      8'd33:  sbox_out = 8'd253;
      8'd34:  sbox_out = 8'd147;
      8'd35:  sbox_out = 8'd38;
      8'd36:  sbox_out = 8'd54;
      8'd37:  sbox_out = 8'd63;
      8'd38:  sbox_out = 8'd247;
      8'd39:  sbox_out = 8'd204;
      8'd40:  sbox_out = 8'd52;
      8'd41:  sbox_out = 8'd165;
      8'd42:  sbox_out = 8'd229;
      8'd43:  sbox_out = 8'd241;
      8'd44:  sbox_out = 8'd113;
      8'd45:  sbox_out = 8'd216;
      8'd46:  sbox_out = 8'd49;
      8'd47:  sbox_out = 8'd21;
      8'd48:  sbox_out = 8'd4;
      8'd49:  sbox_out = 8'd199;
      8'd50:  sbox_out = 8'd35;
      8'd51:  sbox_out = 8'd195;
      8'd52:  sbox_out = 8'd24;
      8'd53:  sbox_out = 8'd150;
      8'd54:  sbox_out = 8'd5;
      8'd55:  sbox_out = 8'd154;
      8'd56:  sbox_out = 8'd7;
      8'd57:  sbox_out = 8'd18;
      8'd58:  sbox_out = 8'd128;
      8'd59:  sbox_out = 8'd226;
      8'd60:  sbox_out = 8'd235;
      8'd61:  sbox_out = 8'd39;
      8'd62:  sbox_out = 8'd178;
      8'd63:  sbox_out = 8'd117;
      8'd64:  sbox_out = 8'd9;
      8'd65:  sbox_out = 8'd131;
      8'd66:  sbox_out = 8'd44;
      8'd67:  sbox_out = 8'd26;
      8'd68:  sbox_out = 8'd27;
      8'd69:  sbox_out = 8'd110;
      8'd70:  sbox_out = 8'd90;
      8'd71:  sbox_out = 8'd160;
      8'd72:  sbox_out = 8'd82;
      8'd73:  sbox_out = 8'd59;
      8'd74:  sbox_out = 8'd214;
      8'd75:  sbox_out = 8'd179;
      8'd76:  sbox_out = 8'd41;
      8'd77:  sbox_out = 8'd227;
      8'd78:  sbox_out = 8'd47;
      8'd79:  sbox_out = 8'd132;
      8'd80:  sbox_out = 8'd83;
      8'd81:  sbox_out = 8'd209;
      8'd82:  sbox_out = 8'd0;
      8'd83:  sbox_out = 8'd237;
      8'd84:  sbox_out = 8'd32;
      8'd85:  sbox_out = 8'd252;
      8'd86:  sbox_out = 8'd177;
      8'd87:  sbox_out = 8'd91;
      8'd88:  sbox_out = 8'd106;
      8'd89:  sbox_out = 8'd203;
      8'd90:  sbox_out = 8'd190;
      8'd91:  sbox_out = 8'd57;
      8'd92:  sbox_out = 8'd74;
      8'd93:  sbox_out = 8'd76;
      8'd94:  sbox_out = 8'd88;
      8'd95:  sbox_out = 8'd207;
      8'd96:  sbox_out = 8'd208;
      8'd97:  sbox_out = 8'd239;
      8'd98:  sbox_out = 8'd170;
      8'd99:  sbox_out = 8'd251;
      8'd100: sbox_out = 8'd67;
      8'd101: sbox_out = 8'd77;
      8'd102: sbox_out = 8'd51;
      8'd103: sbox_out = 8'd133;
      8'd104: sbox_out = 8'd69;
      8'd105: sbox_out = 8'd249;
      8'd106: sbox_out = 8'd2;
      8'd107: sbox_out = 8'd127;
      8'd108: sbox_out = 8'd80;
      8'd109: sbox_out = 8'd60;
      8'd110: sbox_out = 8'd159;
      8'd111: sbox_out = 8'd168;
      8'd112: sbox_out = 8'd81;
      8'd113: sbox_out = 8'd163;
      8'd114: sbox_out = 8'd64;
      8'd115: sbox_out = 8'd143;
      8'd116: sbox_out = 8'd146;
      8'd117: sbox_out = 8'd157;
      8'd118: sbox_out = 8'd56;
      8'd119: sbox_out = 8'd245;
      8'd120: sbox_out = 8'd188;
      8'd121: sbox_out = 8'd182;
      8'd122: sbox_out = 8'd218;
      8'd123: sbox_out = 8'd33;
      8'd124: sbox_out = 8'd16;
      8'd125: sbox_out = 8'd255;
      8'd126: sbox_out = 8'd243;
      8'd127: sbox_out = 8'd210;
      8'd128: sbox_out = 8'd205;
      8'd129: sbox_out = 8'd12;
      8'd130: sbox_out = 8'd19;
      8'd131: sbox_out = 8'd236;
      8'd132: sbox_out = 8'd95;
      8'd133: sbox_out = 8'd151;
      8'd134: sbox_out = 8'd68;
      8'd135: sbox_out = 8'd23;
      8'd136: sbox_out = 8'd196;
      8'd137: sbox_out = 8'd167;
      8'd138: sbox_out = 8'd126;
      8'd139: sbox_out = 8'd61;
      8'd140: sbox_out = 8'd100;
      8'd141: sbox_out = 8'd93;
      8'd142: sbox_out = 8'd25;
      8'd143: sbox_out = 8'd115;
      8'd144: sbox_out = 8'd96;
      8'd145: sbox_out = 8'd129;
      8'd146: sbox_out = 8'd79;
      8'd147: sbox_out = 8'd220;
      8'd148: sbox_out = 8'd34;
      8'd149: sbox_out = 8'd42;
      8'd150: sbox_out = 8'd144;
      8'd151: sbox_out = 8'd136;
      8'd152: sbox_out = 8'd70;
      8'd153: sbox_out = 8'd238;
      8'd154: sbox_out = 8'd184;
      8'd155: sbox_out = 8'd20;
      8'd156: sbox_out = 8'd222;
      8'd157: sbox_out = 8'd94;
      8'd158: sbox_out = 8'd11;
      8'd159: sbox_out = 8'd219;
      8'd160: sbox_out = 8'd224;
      8'd161: sbox_out = 8'd50;
      8'd162: sbox_out = 8'd58;
      8'd163: sbox_out = 8'd10;
      8'd164: sbox_out = 8'd73;
      8'd165: sbox_out = 8'd6;
      8'd166: sbox_out = 8'd36;
      8'd167: sbox_out = 8'd92;
      8'd168: sbox_out = 8'd194;
      8'd169: sbox_out = 8'd211;
      8'd170: sbox_out = 8'd172;
      8'd171: sbox_out = 8'd98;
      8'd172: sbox_out = 8'd145;
      8'd173: sbox_out = 8'd149;
      8'd174: sbox_out = 8'd228;
      8'd175: sbox_out = 8'd121;
      8'd176: sbox_out = 8'd231;
      8'd177: sbox_out = 8'd200;
      8'd178: sbox_out = 8'd55;
      8'd179: sbox_out = 8'd109;
      8'd180: sbox_out = 8'd141;
      8'd181: sbox_out = 8'd213;
      8'd182: sbox_out = 8'd78;
      8'd183: sbox_out = 8'd169;
      8'd184: sbox_out = 8'd108;
      8'd185: sbox_out = 8'd86;
      8'd186: sbox_out = 8'd244;
      8'd187: sbox_out = 8'd234;
      8'd188: sbox_out = 8'd101;
      8'd189: sbox_out = 8'd122;
      8'd190: sbox_out = 8'd174;
      8'd191: sbox_out = 8'd8;
      8'd192: sbox_out = 8'd186;
      8'd193: sbox_out = 8'd120;
      8'd194: sbox_out = 8'd37;
      8'd195: sbox_out = 8'd46;
      8'd196: sbox_out = 8'd28;
      8'd197: sbox_out = 8'd166;
      8'd198: sbox_out = 8'd180;
      8'd199: sbox_out = 8'd198;
      8'd200: sbox_out = 8'd232;
      8'd201: sbox_out = 8'd221;
      8'd202: sbox_out = 8'd116;
      8'd203: sbox_out = 8'd31;
      8'd204: sbox_out = 8'd75;
      8'd205: sbox_out = 8'd189;
      8'd206: sbox_out = 8'd139;
      8'd207: sbox_out = 8'd138;
      8'd208: sbox_out = 8'd112;
      8'd209: sbox_out = 8'd62;
      8'd210: sbox_out = 8'd181;
      8'd211: sbox_out = 8'd102;
      8'd212: sbox_out = 8'd72;
      8'd213: sbox_out = 8'd3;
      8'd214: sbox_out = 8'd246;
      8'd215: sbox_out = 8'd14;
      8'd216: sbox_out = 8'd97;
      8'd217: sbox_out = 8'd53;
      8'd218: sbox_out = 8'd87;
      8'd219: sbox_out = 8'd185;
      8'd220: sbox_out = 8'd134;
      8'd221: sbox_out = 8'd193;
      8'd222: sbox_out = 8'd29;
      8'd223: sbox_out = 8'd158;
      8'd224: sbox_out = 8'd225;
      8'd225: sbox_out = 8'd248;
      8'd226: sbox_out = 8'd152;
      8'd227: sbox_out = 8'd17;
      8'd228: sbox_out = 8'd105;
      8'd229: sbox_out = 8'd217;
      8'd230: sbox_out = 8'd142;
      8'd231: sbox_out = 8'd148;
      8'd232: sbox_out = 8'd155;
      8'd233: sbox_out = 8'd30;
      8'd234: sbox_out = 8'd135;
      8'd235: sbox_out = 8'd233;
      8'd236: sbox_out = 8'd206;
      8'd237: sbox_out = 8'd85;
      8'd238: sbox_out = 8'd40;
      8'd239: sbox_out = 8'd223;
      8'd240: sbox_out = 8'd140;
      8'd241: sbox_out = 8'd161;
      8'd242: sbox_out = 8'd137;
      8'd243: sbox_out = 8'd13;
      8'd244: sbox_out = 8'd191;
      8'd245: sbox_out = 8'd230;
      8'd246: sbox_out = 8'd66;
      8'd247: sbox_out = 8'd104;
      8'd248: sbox_out = 8'd65;
      8'd249: sbox_out = 8'd153;
      8'd250: sbox_out = 8'd45;
      8'd251: sbox_out = 8'd15;
      8'd252: sbox_out = 8'd176;
      8'd253: sbox_out = 8'd84;
      8'd254: sbox_out = 8'd187;
      default: sbox_out = 8'd22;
    endcase
  end
endmodule
