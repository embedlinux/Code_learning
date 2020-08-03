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

package AES_MODEL;
typedef bit [7:0]  bit8;
///////////////////////////////////////////////////////////////////////////////
// Class Aes:
///////////////////////////////////////////////////////////////////////////////
class Aes;
  /////////////////////////////////////////////////////////////////////////////
  //************************ Class Variables ********************************//
  /////////////////////////////////////////////////////////////////////////////
  local bit8 sboxInv[256] = '{
    8'h52, 8'h09, 8'h6a, 8'hd5, 8'h30, 8'h36, 8'ha5, 8'h38, 8'hbf, 8'h40, 8'ha3,
    8'h9e, 8'h81, 8'hf3, 8'hd7, 8'hfb, 8'h7c, 8'he3, 8'h39, 8'h82, 8'h9b, 8'h2f,
    8'hff, 8'h87, 8'h34, 8'h8e, 8'h43, 8'h44, 8'hc4, 8'hde, 8'he9, 8'hcb, 8'h54,
    8'h7b, 8'h94, 8'h32, 8'ha6, 8'hc2, 8'h23, 8'h3d, 8'hee, 8'h4c, 8'h95, 8'h0b,
    8'h42, 8'hfa, 8'hc3, 8'h4e, 8'h08, 8'h2e, 8'ha1, 8'h66, 8'h28, 8'hd9, 8'h24,
    8'hb2, 8'h76, 8'h5b, 8'ha2, 8'h49, 8'h6d, 8'h8b, 8'hd1, 8'h25, 8'h72, 8'hf8,
    8'hf6, 8'h64, 8'h86, 8'h68, 8'h98, 8'h16, 8'hd4, 8'ha4, 8'h5c, 8'hcc, 8'h5d,
    8'h65, 8'hb6, 8'h92, 8'h6c, 8'h70, 8'h48, 8'h50, 8'hfd, 8'hed, 8'hb9, 8'hda,
    8'h5e, 8'h15, 8'h46, 8'h57, 8'ha7, 8'h8d, 8'h9d, 8'h84, 8'h90, 8'hd8, 8'hab,
    8'h00, 8'h8c, 8'hbc, 8'hd3, 8'h0a, 8'hf7, 8'he4, 8'h58, 8'h05, 8'hb8, 8'hb3,
    8'h45, 8'h06, 8'hd0, 8'h2c, 8'h1e, 8'h8f, 8'hca, 8'h3f, 8'h0f, 8'h02, 8'hc1,
    8'haf, 8'hbd, 8'h03, 8'h01, 8'h13, 8'h8a, 8'h6b, 8'h3a, 8'h91, 8'h11, 8'h41,
    8'h4f, 8'h67, 8'hdc, 8'hea, 8'h97, 8'hf2, 8'hcf, 8'hce, 8'hf0, 8'hb4, 8'he6,
    8'h73, 8'h96, 8'hac, 8'h74, 8'h22, 8'he7, 8'had, 8'h35, 8'h85, 8'he2, 8'hf9,
    8'h37, 8'he8, 8'h1c, 8'h75, 8'hdf, 8'h6e, 8'h47, 8'hf1, 8'h1a, 8'h71, 8'h1d,
    8'h29, 8'hc5, 8'h89, 8'h6f, 8'hb7, 8'h62, 8'h0e, 8'haa, 8'h18, 8'hbe, 8'h1b,
    8'hfc, 8'h56, 8'h3e, 8'h4b, 8'hc6, 8'hd2, 8'h79, 8'h20, 8'h9a, 8'hdb, 8'hc0,
    8'hfe, 8'h78, 8'hcd, 8'h5a, 8'hf4, 8'h1f, 8'hdd, 8'ha8, 8'h33, 8'h88, 8'h07,
    8'hc7, 8'h31, 8'hb1, 8'h12, 8'h10, 8'h59, 8'h27, 8'h80, 8'hec, 8'h5f, 8'h60,
    8'h51, 8'h7f, 8'ha9, 8'h19, 8'hb5, 8'h4a, 8'h0d, 8'h2d, 8'he5, 8'h7a, 8'h9f,
    8'h93, 8'hc9, 8'h9c, 8'hef, 8'ha0, 8'he0, 8'h3b, 8'h4d, 8'hae, 8'h2a, 8'hf5,
    8'hb0, 8'hc8, 8'heb, 8'hbb, 8'h3c, 8'h83, 8'h53, 8'h99, 8'h61, 8'h17, 8'h2b,
    8'h04, 8'h7e, 8'hba, 8'h77, 8'hd6, 8'h26, 8'he1, 8'h69, 8'h14, 8'h63, 8'h55,
    8'h21, 8'h0c, 8'h7d };
  local bit8 sbox[256] =  '{
    8'h63, 8'h7c, 8'h77, 8'h7b, 8'hf2, 8'h6b, 8'h6f, 8'hc5, 8'h30, 8'h01, 8'h67,
    8'h2b, 8'hfe, 8'hd7, 8'hab, 8'h76, 8'hca, 8'h82, 8'hc9, 8'h7d, 8'hfa, 8'h59,
    8'h47, 8'hf0, 8'had, 8'hd4, 8'ha2, 8'haf, 8'h9c, 8'ha4, 8'h72, 8'hc0, 8'hb7,
    8'hfd, 8'h93, 8'h26, 8'h36, 8'h3f, 8'hf7, 8'hcc, 8'h34, 8'ha5, 8'he5, 8'hf1,
    8'h71, 8'hd8, 8'h31, 8'h15, 8'h04, 8'hc7, 8'h23, 8'hc3, 8'h18, 8'h96, 8'h05,
    8'h9a, 8'h07, 8'h12, 8'h80, 8'he2, 8'heb, 8'h27, 8'hb2, 8'h75, 8'h09, 8'h83,
    8'h2c, 8'h1a, 8'h1b, 8'h6e, 8'h5a, 8'ha0, 8'h52, 8'h3b, 8'hd6, 8'hb3, 8'h29,
    8'he3, 8'h2f, 8'h84, 8'h53, 8'hd1, 8'h00, 8'hed, 8'h20, 8'hfc, 8'hb1, 8'h5b,
    8'h6a, 8'hcb, 8'hbe, 8'h39, 8'h4a, 8'h4c, 8'h58, 8'hcf, 8'hd0, 8'hef, 8'haa,
    8'hfb, 8'h43, 8'h4d, 8'h33, 8'h85, 8'h45, 8'hf9, 8'h02, 8'h7f, 8'h50, 8'h3c,
    8'h9f, 8'ha8, 8'h51, 8'ha3, 8'h40, 8'h8f, 8'h92, 8'h9d, 8'h38, 8'hf5, 8'hbc,
    8'hb6, 8'hda, 8'h21, 8'h10, 8'hff, 8'hf3, 8'hd2, 8'hcd, 8'h0c, 8'h13, 8'hec,
    8'h5f, 8'h97, 8'h44, 8'h17, 8'hc4, 8'ha7, 8'h7e, 8'h3d, 8'h64, 8'h5d, 8'h19,
    8'h73, 8'h60, 8'h81, 8'h4f, 8'hdc, 8'h22, 8'h2a, 8'h90, 8'h88, 8'h46, 8'hee,
    8'hb8, 8'h14, 8'hde, 8'h5e, 8'h0b, 8'hdb, 8'he0, 8'h32, 8'h3a, 8'h0a, 8'h49,
    8'h06, 8'h24, 8'h5c, 8'hc2, 8'hd3, 8'hac, 8'h62, 8'h91, 8'h95, 8'he4, 8'h79,
    8'he7, 8'hc8, 8'h37, 8'h6d, 8'h8d, 8'hd5, 8'h4e, 8'ha9, 8'h6c, 8'h56, 8'hf4,
    8'hea, 8'h65, 8'h7a, 8'hae, 8'h08, 8'hba, 8'h78, 8'h25, 8'h2e, 8'h1c, 8'ha6,
    8'hb4, 8'hc6, 8'he8, 8'hdd, 8'h74, 8'h1f, 8'h4b, 8'hbd, 8'h8b, 8'h8a, 8'h70,
    8'h3e, 8'hb5, 8'h66, 8'h48, 8'h03, 8'hf6, 8'h0e, 8'h61, 8'h35, 8'h57, 8'hb9,
    8'h86, 8'hc1, 8'h1d, 8'h9e, 8'he1, 8'hf8, 8'h98, 8'h11, 8'h69, 8'hd9, 8'h8e,
    8'h94, 8'h9b, 8'h1e, 8'h87, 8'he9, 8'hce, 8'h55, 8'h28, 8'hdf, 8'h8c, 8'ha1,
    8'h89, 8'h0d, 8'hbf, 8'he6, 8'h42, 8'h68, 8'h41, 8'h99, 8'h2d, 8'h0f, 8'hb0,
    8'h54, 8'hbb, 8'h16 };
  local bit8 Rcon[11] = '{
    8'h8d, 8'h01, 8'h02, 8'h04, 8'h08, 8'h10, 8'h20, 8'h40, 8'h80, 8'h1b, 8'h36};
  /////////////////////////////////////////////////////////////////////////////
  //************************* Class Methods *********************************//
  /////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////
  /*- blockXor():*/
  /////////////////////////////////////////////////////////////////////////////
  local task blockXor(bit8 data1[16], bit8 data2[16], output bit8 dataOut[16]);
    for (int i = 0; i < 16; i++)begin
      dataOut[i] = data1[i] ^ data2[i];
    end
  endtask
  /////////////////////////////////////////////////////////////////////////////
  /*- subBytes():*/
  /////////////////////////////////////////////////////////////////////////////
  local task subBytes(bit8 dataIn[16], output bit8 dataOut[16]);
    for (int i = 0; i < 16; i++) begin
      dataOut[i] = this.sbox[dataIn[i]];
    end
  endtask
  /////////////////////////////////////////////////////////////////////////////
  /*- InvSubBytes():*/
  /////////////////////////////////////////////////////////////////////////////
  local task InvSubBytes(bit8 dataIn[16], output bit8 dataOut[16]);
    for (int i = 0; i < 16; i++) begin
      dataOut[i] = this.sboxInv[dataIn[i]];
    end
  endtask
  /////////////////////////////////////////////////////////////////////////////
  /*- shftRows():*/
  /////////////////////////////////////////////////////////////////////////////
  local task shftRows(bit8 dataIn[16], output bit8 dataOut[16]);
    bit8 temp;
    bit8 state[4][4];
    for (int i = 0; i < 4; i++) begin
      for (int j = 0; j < 4; j++) begin
        state[j][i] = dataIn[i*4 + j];
      end
    end
    // Rotate first row 1 columns to left
    temp=state[1][0];
    state[1][0]=state[1][1];
    state[1][1]=state[1][2];
    state[1][2]=state[1][3];
    state[1][3]=temp;
    // Rotate second row 2 columns to left
    temp=state[2][0];
    state[2][0]=state[2][2];
    state[2][2]=temp;
    temp=state[2][1];
    state[2][1]=state[2][3];
    state[2][3]=temp;
    // Rotate third row 3 columns to left
    temp=state[3][0];
    state[3][0]=state[3][3];
    state[3][3]=state[3][2];
    state[3][2]=state[3][1];
    state[3][1]=temp;
    for (int i = 0; i < 4; i++) begin
      for (int j = 0; j < 4; j++) begin
        dataOut[i*4 + j] = state[j][i];
      end
    end
  endtask
  /////////////////////////////////////////////////////////////////////////////
  /*- InvShiftRows():*/
  /////////////////////////////////////////////////////////////////////////////
  local task InvShiftRows(bit8 dataIn[16], output bit8 dataOut[16]);
    bit8 temp;
    bit8 state[4][4];
    for (int i = 0; i < 4; i++) begin
      for (int j = 0; j < 4; j++) begin
        state[j][i] = dataIn[i*4 + j];
      end
    end
    // Rotate first row 1 columns to right
    temp=state[1][3];
    state[1][3]=state[1][2];
    state[1][2]=state[1][1];
    state[1][1]=state[1][0];
    state[1][0]=temp;
    // Rotate second row 2 columns to right
    temp=state[2][0];
    state[2][0]=state[2][2];
    state[2][2]=temp;
    temp=state[2][1];
    state[2][1]=state[2][3];
    state[2][3]=temp;
    // Rotate third row 3 columns to right
    temp=state[3][0];
    state[3][0]=state[3][1];
    state[3][1]=state[3][2];
    state[3][2]=state[3][3];
    state[3][3]=temp;
    for (int i = 0; i < 4; i++) begin
      for (int j = 0; j < 4; j++) begin
        dataOut[i*4 + j] = state[j][i];
      end
    end
  endtask
  /////////////////////////////////////////////////////////////////////////////
  /*- xtime():*/
  /////////////////////////////////////////////////////////////////////////////
  local function bit8 xtime(bit8 x);
    xtime = ((x<<1) ^ (((x>>7) & 1) * 8'h1b));
  endfunction
  /////////////////////////////////////////////////////////////////////////////
  /*- x4time():*/
  /////////////////////////////////////////////////////////////////////////////
  local function bit8 x4time(bit8 x, y);
    x4time = (((y & 1) * x) ^ ((y>>1 & 1) * xtime(x)) ^ ((y>>2 & 1) *
              xtime(xtime(x))) ^ ((y>>3 & 1) * xtime(xtime(xtime(x)))) ^
              ((y>>4 & 1) * xtime(xtime(xtime(xtime(x))))));
  endfunction
  /////////////////////////////////////////////////////////////////////////////
  /*- mixClms():*/
  /////////////////////////////////////////////////////////////////////////////
  local task mixClms(bit8 dataIn[16], output bit8 dataOut[16]);
    bit8 Tmp,Tm,t;
    bit8 state[4][4];
    for (int i = 0; i < 4; i++) begin
      for (int j = 0; j < 4; j++)begin
        state[j][i] = dataIn[i*4 + j];
      end
    end
    for(int i = 0; i < 4; i++) begin
      t=state[0][i];
      Tmp = state[0][i] ^ state[1][i] ^ state[2][i] ^ state[3][i];
      Tm  = state[0][i] ^ state[1][i];
      Tm = xtime(Tm);
      state[0][i] ^= Tm ^ Tmp;
      Tm  = state[1][i] ^ state[2][i];
      Tm = xtime(Tm);
      state[1][i] ^= Tm ^ Tmp;
      Tm  = state[2][i] ^ state[3][i];
      Tm = xtime(Tm);
      state[2][i] ^= Tm ^ Tmp;
      Tm  = state[3][i] ^ t;
      Tm = xtime(Tm);
      state[3][i] ^= Tm ^ Tmp;
    end
    for (int i = 0; i < 4; i++) begin
      for (int j = 0; j < 4; j++) begin
        dataOut[i*4 + j] = state[j][i];
      end
    end
  endtask
  /////////////////////////////////////////////////////////////////////////////
  /*- InvMixClms():*/
  /////////////////////////////////////////////////////////////////////////////
  local task InvMixClms(bit8 dataIn[16], output bit8 dataOut[16]);
    bit8 a, b, c, d;
    bit8 state[4][4];
    for (int i = 0; i < 4; i++) begin
      for (int j = 0; j < 4; j++)begin
        state[j][i] = dataIn[i*4 + j];
      end
    end
    for(int i=0; i < 4; i++) begin
      a = state[0][i];
      b = state[1][i];
      c = state[2][i];
      d = state[3][i];
      state[0][i] = x4time(a, 8'h0e) ^ x4time(b, 8'h0b) ^ x4time(c, 8'h0d) ^ x4time(d, 8'h09);
      state[1][i] = x4time(a, 8'h09) ^ x4time(b, 8'h0e) ^ x4time(c, 8'h0b) ^ x4time(d, 8'h0d);
      state[2][i] = x4time(a, 8'h0d) ^ x4time(b, 8'h09) ^ x4time(c, 8'h0e) ^ x4time(d, 8'h0b);
      state[3][i] = x4time(a, 8'h0b) ^ x4time(b, 8'h0d) ^ x4time(c, 8'h09) ^ x4time(d, 8'h0e);
    end
    for (int i = 0; i < 4; i++) begin
      for (int j = 0; j < 4; j++) begin
        dataOut[i*4 + j] = state[j][i];
      end
    end
  endtask
  /////////////////////////////////////////////////////////////////////////////
  /*- keyExpEnc():*/
  /////////////////////////////////////////////////////////////////////////////
  local task keyExpEnc(bit8 keyIn[16], output bit8 rndKeyOut[176]);
    bit8 temp[4], k;
    bit8 rndKey[176];
    for (int i = 0; i < 16; i++) begin
      rndKey[i] = keyIn[i];
    end
    for (int rndNum = 1; rndNum <= 10; rndNum++) begin
      for(int i = 0; i < 4; i++) begin
        temp[i] = rndKey[(rndNum-1)*16+12+i];
      end
      k = temp[0];
      temp[0] = temp[1];
      temp[1] = temp[2];
      temp[2] = temp[3];
      temp[3] = k;
      temp[0] = this.sbox[temp[0]];
      temp[1] = this.sbox[temp[1]];
      temp[2] = this.sbox[temp[2]];
      temp[3] = this.sbox[temp[3]];
      temp[0] = Rcon[rndNum] ^ temp[0];
      for (int i = 0; i < 4; i++) begin
        rndKey[(rndNum*16)+i] = rndKey[(rndNum-1)*16+i] ^ temp[i];
      end
      for (int i = 4; i < 16; i++) begin
        rndKey[(rndNum*16)+i] = rndKey[(rndNum-1)*16+i] ^ rndKey[(rndNum*16)+i-4];
      end
      for (int i = 0; i < 176; i++) begin
        rndKeyOut[i] = rndKey[i];
      end
    end
  endtask
  /////////////////////////////////////////////////////////////////////////////
  /*- encryptBlock():*/
  /////////////////////////////////////////////////////////////////////////////
  local task encryptBlock(bit8 keyIn[16], bit8 dataIn[16], output bit8 dataOut[16]);
    bit8 roundKey[176];
    bit8 currRndKey[16];
    bit8 rndData[16];
    keyExpEnc(keyIn, roundKey);
    for (int i = 0; i < 16; i++) begin
      currRndKey[i] = roundKey[i];
    end
    this.blockXor(currRndKey, dataIn, rndData);
    for (int rnd = 0; rnd < 9; rnd++) begin
      this.subBytes(rndData, rndData);
      this.shftRows(rndData, rndData);
      this.mixClms(rndData, rndData);
      for (int i = 0; i < 16; i++) begin
        currRndKey[i] = roundKey[16*(rnd+1)+i];
      end
      this.blockXor(currRndKey, rndData, rndData);
    end
    this.subBytes(rndData, rndData);
    this.shftRows(rndData, rndData);
    for (int i = 0; i < 16; i++) begin
      currRndKey[i] = roundKey[160+i];
    end
    this.blockXor(currRndKey, rndData, dataOut);
  endtask
  /////////////////////////////////////////////////////////////////////////////
  /*- decryptBlock():*/
  /////////////////////////////////////////////////////////////////////////////
  local task decryptBlock(bit8 keyIn[16], bit8 dataIn[16], output bit8 dataOut[16]);
    bit8 roundKey[176];
    bit8 currRndKey[16];
    bit8 rndData[16];
    this.keyExpEnc(keyIn, roundKey);
    for (int i = 0; i < 16; i++) begin
      currRndKey[i] = roundKey[160+i];
    end
    this.blockXor(currRndKey, dataIn, rndData);
    for (int rnd = 8; rnd >= 0; rnd--) begin
      this.InvShiftRows(rndData, rndData);
      this.InvSubBytes(rndData, rndData);
      for (int i = 0; i < 16; i++) begin
        currRndKey[i] = roundKey[16*(rnd+1)+i];
      end
      this.blockXor(currRndKey, rndData, rndData);
      this.InvMixClms(rndData, rndData);
    end
    this.InvShiftRows(rndData, rndData);
    this.InvSubBytes(rndData, rndData);
    for (int i = 0; i < 16; i++) begin
      currRndKey[i] = roundKey[i];
    end
    this.blockXor(currRndKey, rndData, dataOut);
  endtask
  /////////////////////////////////////////////////////////////////////////////
  /*- CryptECB(): Will encrypt/decrypt input packet.
  // "dir" - mode. "ENC" for encrypt or "DEC" for decrypt.
  // "keyIn" - Input secret key. Is a byte array with a length 16.
  // "dataIn" - Input packet. Is a byte queue and can be more then 16 bytes.
  // "dataOut" - Output packet. Is a byte queue.
  // Input packet length should be multiple 16 bytes. If not error will be
  // generated.*/
  /////////////////////////////////////////////////////////////////////////////
  task CryptECB (string dir, bit8 keyIn[$], dataIn[$], output bit8 dataOut[$]);
    int buffSize;
    bit8 blkDataIn[16];
    dataOut = {};
    $display ("---Model: Mode is ECB %s", dir);
    buffSize = dataIn.size();
    if (buffSize % 16 != 0) begin
      $display("---Model: AES ECB input length error. Input lenght must be multiple 16");
      return;
    end
    if (dir == "ENC") begin
      for (int i = 0; i < buffSize; i+=16) begin
        for (int j = 0; j < 16; j++) begin
          blkDataIn[j] = dataIn.pop_front();
        end
        this.encryptBlock(keyIn, blkDataIn, blkDataIn);
        for (int j = 0; j < 16; j++) begin
          dataOut.push_back(blkDataIn[j]);
        end
      end
    end else if (dir == "DEC") begin
      for (int i = 0; i < buffSize; i+=16) begin
        for (int j = 0; j < 16; j++) begin
          blkDataIn[j] = dataIn.pop_front();
        end
        this.decryptBlock(keyIn, blkDataIn, blkDataIn);
        for (int j = 0; j < 16; j++) begin
          dataOut.push_back(blkDataIn[j]);
        end
      end
    end else begin
      $display("---Model: Wrong direction selected. Use 'ENC' or 'DEC'");
    end
  endtask
  //
endclass
//
endpackage

