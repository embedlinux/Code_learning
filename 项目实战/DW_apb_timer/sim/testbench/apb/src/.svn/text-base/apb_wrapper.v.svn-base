module Xkkkc(Llkkc,Qlkkc,Ylkkc,Gmkkc,Vmkkc,Bnkkc,Inkkc,Nnkkc,Unkkc,
Bokkc,Mokkc,Yokkc,Epkkc,Kpkkc,Vpkkc,Cqkkc,Kqkkc);
parameter Qwkkc=3'b0;
parameter Twkkc=3'b1;
parameter Wwkkc=3'b010;
parameter Zwkkc=3'b011;
parameter Cxkkc=3'b100;
parameter Fxkkc=3'b101;
parameter Ixkkc=3'b110;
input Gmkkc;
input[(32-1):0]Vmkkc;
input Llkkc;
input Qlkkc;
input Bnkkc;
input Inkkc;
input[(2-1):0]Nnkkc;
input[(256-1):0]Bokkc;
input Unkkc;
input Ylkkc;
output Mokkc;
output[(2-1):0]Yokkc;
output[(32-1):0]Epkkc;
output Cqkkc;
output Kqkkc;
output[(32-1):0]Kpkkc;
output Vpkkc;
reg Mokkc;
reg[(32-1):0]Epkkc;
reg Cqkkc;
reg Kqkkc;
reg[(32-1):0]Kpkkc;
reg Vpkkc;
wire Sqkkc;wire Frkkc;wire Prkkc;wire[(32-1):0]Zrkkc;reg[(32-1):0]Jskkc;reg[(32-1):0]Sskkc;reg Etkkc;reg Rtkkc;
reg[(32-1):0]Aukkc;reg[(32-1):0]Mukkc;reg Bvkkc;reg Lvkkc;reg[2:0]Awkkc;reg[2:0]Kwkkc;assign Frkkc=(Inkkc & Bnkkc);
assign Sqkkc=((Nnkkc !=2'b0)&&(Nnkkc !=2'b1));assign Prkkc=((Frkkc==1'b1)&&(Sqkkc==1'b1));assign Yokkc=2'b0;assign Zrkkc=(Rtkkc ? Sskkc : Aukkc);
always @(Zrkkc or Bokkc or Gmkkc)begin : Lxkkc if(32==64)begin if(Gmkkc==1'b1)begin case(Zrkkc[2])1'b1: Jskkc=Bokkc[31:0];
1'b0: Jskkc=Bokkc[63:32];endcase end else begin case(Zrkkc[2])1'b0: Jskkc=Bokkc[31:0];1'b1: Jskkc=Bokkc[63:32];endcase end 
end else if(32==128)begin if(Gmkkc==1'b1)begin case(Zrkkc[3:2])2'b11: Jskkc=Bokkc[31:0];2'b10: Jskkc=Bokkc[63:32];2'b1: 
Jskkc=Bokkc[95:64];2'b0: Jskkc=Bokkc[127:96];endcase end else begin case(Zrkkc[3:2])2'b0: Jskkc=Bokkc[31:0];2'b1: Jskkc=Bokkc[63:32];
2'b10: Jskkc=Bokkc[95:64];2'b11: Jskkc=Bokkc[127:96];endcase end end else if(32==256)begin if(Gmkkc==1'b1)begin case(Zrkkc[4:2])
3'b111: Jskkc=Bokkc[31:0];3'b110: Jskkc=Bokkc[63:32];3'b101: Jskkc=Bokkc[95:64];3'b100: Jskkc=Bokkc[127:96];3'b011: Jskkc=Bokkc[159:128];
3'b010: Jskkc=Bokkc[191:160];3'b1: Jskkc=Bokkc[223:192];3'b0: Jskkc=Bokkc[255:224];endcase end else begin case(Zrkkc[4:2])
3'b0: Jskkc=Bokkc[31:0];3'b1: Jskkc=Bokkc[63:32];3'b010: Jskkc=Bokkc[95:64];3'b011: Jskkc=Bokkc[127:96];3'b100: Jskkc=Bokkc[159:128];
3'b101: Jskkc=Bokkc[191:160];3'b110: Jskkc=Bokkc[223:192];3'b111: Jskkc=Bokkc[255:224];endcase end end else begin Jskkc=Bokkc[31:0];
end end always @(posedge Llkkc or negedge Qlkkc)begin : Gykkc if(Qlkkc==1'b0)begin Epkkc <={32 {1'b0}};end else begin if(Ylkkc==1'b1)begin 
case(Awkkc)Wwkkc: if((Kwkkc==Twkkc)&&(Bvkkc==1'b1))begin Epkkc <=Aukkc;end else begin Epkkc <=Sskkc;end Cxkkc: if((Kwkkc==Zwkkc)&&(Rtkkc==1'b1))begin 
Epkkc <=Sskkc;end Fxkkc: case(Kwkkc)Qwkkc,Ixkkc: Epkkc <=Vmkkc;Cxkkc: if(Rtkkc==1'b1)begin Epkkc <=Sskkc;end else begin 
Epkkc <=Aukkc;end Zwkkc: if(Prkkc==1'b1)begin Epkkc <=Vmkkc;end else begin Epkkc <=Sskkc;end default: Epkkc <=Epkkc;endcase 
default: Epkkc <=Epkkc;endcase end end end always @(posedge Llkkc or negedge Qlkkc)begin : Rykkc if(Qlkkc==1'b0)begin Cqkkc <=1'b0;
end else begin if(Ylkkc==1'b1)begin case(Kwkkc)Wwkkc,Fxkkc: Cqkkc <=1'b1;default: Cqkkc <=1'b0;endcase end end end always @(posedge Llkkc or negedge Qlkkc)begin : Ezkkc 
if(Qlkkc==1'b0)begin Vpkkc <=1'b0;end else begin if(Ylkkc==1'b1)begin case(Awkkc)Wwkkc: Vpkkc <=1'b1;Fxkkc: Vpkkc <=1'b0;
default: Vpkkc <=Vpkkc;endcase end end end always @(posedge Llkkc or negedge Qlkkc)begin : Qzkkc if(Qlkkc==1'b0)begin Kpkkc <={32 {1'b0}};
end else begin if(Ylkkc==1'b1)begin case(Awkkc)Wwkkc: if(Kwkkc==Twkkc)begin if(Lvkkc==1'b1)begin Kpkkc <=Mukkc;end 
else begin Kpkkc <=Jskkc;end end else begin Kpkkc <=Jskkc;end default: Kpkkc <=Kpkkc;endcase end end end always @(posedge Llkkc or negedge Qlkkc)begin : C0lkc 
if(Qlkkc==1'b0)begin Kqkkc <=1'b0;end else begin if(Ylkkc==1'b1)begin case(Awkkc)Wwkkc,Zwkkc,Fxkkc,Ixkkc: Kqkkc <=1'b1;
default: Kqkkc <=1'b0;endcase end end end always @(posedge Llkkc or negedge Qlkkc)begin : P0lkc if(Qlkkc==1'b0)begin Mokkc <=1'b1;
end else begin case(Kwkkc)Qwkkc: if((Awkkc==Fxkkc)||(Awkkc==Cxkkc))begin Mokkc <=1'b0;end else begin Mokkc <=1'b1;end 
Twkkc: if(Prkkc==1'b1)begin Mokkc <=1'b0;end else if((Awkkc==Wwkkc)&&(Rtkkc==1'b0))begin Mokkc <=1'b1;end Wwkkc: if(Prkkc==1'b1)begin 
Mokkc <=1'b0;end else if((Awkkc==Zwkkc)&&(Rtkkc==1'b1))begin Mokkc <=1'b0;end Zwkkc: case(Awkkc)Twkkc: if(Rtkkc==1'b1)begin 
Mokkc <=1'b0;end Cxkkc,Fxkkc: Mokkc <=1'b0;default: Mokkc <=1'b1;endcase Ixkkc: case(Awkkc)Cxkkc,Fxkkc: Mokkc <=1'b0;default: 
Mokkc <=1'b1;endcase Cxkkc: Mokkc <=1'b0;Fxkkc: if(Ylkkc==1'b1)begin Mokkc <=1'b1;end default: Mokkc <=1'b1;endcase end 
end always @(posedge Llkkc or negedge Qlkkc)begin : G1lkc if(Qlkkc==1'b0)begin Rtkkc <=1'b0;end else begin if(Ylkkc==1'b0)begin 
case(Kwkkc)Twkkc,Wwkkc: if(Prkkc==1'b1)begin Rtkkc <=1'b1;end Zwkkc: if((Prkkc==1'b0)&&(Awkkc !=Cxkkc))begin Rtkkc <=1'b0;
end else if((Prkkc==1'b1)&&(Awkkc==Cxkkc))begin Rtkkc <=1'b1;end Qwkkc: Rtkkc <=1'b0;default: Rtkkc <=Rtkkc;endcase end 
else begin case(Kwkkc)Twkkc,Wwkkc: if(Prkkc==1'b1)begin Rtkkc <=1'b1;end Zwkkc: if(Prkkc==1'b0)begin Rtkkc <=1'b0;end 
else if((Rtkkc==1'b1)&&(Etkkc==1'b0))begin Rtkkc <=1'b0;end Cxkkc,Qwkkc: Rtkkc <=1'b0;default: Rtkkc <=Rtkkc;endcase 
end end end always @(posedge Llkkc or negedge Qlkkc)begin : U1lkc if(Qlkkc==1'b0)begin Sskkc <={32 {1'b0}};end else begin case(Kwkkc)
Twkkc,Wwkkc,Zwkkc: if(Prkkc==1'b1)begin Sskkc <=Vmkkc;end default: Sskkc <=Sskkc;endcase end end always @(posedge Llkkc or negedge Qlkkc)begin : L2lkc 
if(Qlkkc==1'b0)begin Aukkc <={32 {1'b0}};end else begin case(Awkkc)Twkkc: if((Kwkkc==Qwkkc)||(Kwkkc==Ixkkc))begin Aukkc <=Vmkkc;
end else if(Kwkkc==Zwkkc)begin if(Rtkkc==1'b1)begin Aukkc <=Sskkc;end else begin Aukkc <=Vmkkc;end end Cxkkc: if((Kwkkc==Qwkkc)||(Kwkkc==Ixkkc))begin 
Aukkc <=Vmkkc;end default: Aukkc <=Aukkc;endcase end end always @(posedge Llkkc or negedge Qlkkc)begin : C3lkc if(Qlkkc==1'b0)begin 
Etkkc <=1'b0;end else begin case(Kwkkc)Twkkc,Wwkkc,Zwkkc: if(Prkkc==1'b1)begin Etkkc <=Unkkc;end default: Etkkc <=Etkkc;
endcase end end always @(posedge Llkkc or negedge Qlkkc)begin : U3lkc if(Qlkkc==1'b0)begin Mukkc <={32 {1'b0}};end else begin 
if(Lvkkc==1'b1)begin Mukkc <=Mukkc;end else begin case(Awkkc)Twkkc: if((Kwkkc==Twkkc)||((Kwkkc==Zwkkc)&&(Rtkkc==1'b1)))begin 
Mukkc <=Jskkc;end Zwkkc: if((Kwkkc==Wwkkc)&&(Rtkkc==1'b1))begin Mukkc <=Jskkc;end default: Mukkc <=Mukkc;endcase end 
end end always @(posedge Llkkc or negedge Qlkkc)begin : O4lkc if(Qlkkc==1'b0)begin Bvkkc <=1'b0;end else begin case(Awkkc)
Twkkc: if(((Kwkkc==Qwkkc)||(Kwkkc==Zwkkc))||(Kwkkc==Ixkkc))begin Bvkkc <=1'b1;end Wwkkc: if(Kwkkc==Twkkc)begin Bvkkc <=1'b0;
end default: Bvkkc <=Bvkkc;endcase end end always @(posedge Llkkc or negedge Qlkkc)begin : D5lkc if(Qlkkc==1'b0)begin Lvkkc <=1'b0;
end else begin if((Bvkkc==1'b1)&&(Ylkkc==0))begin Lvkkc <=1'b1;end else begin Lvkkc <=1'b0;end end end always @(posedge Llkkc or negedge Qlkkc)begin : X5lkc 
if(Qlkkc==1'b0)begin Kwkkc <=Qwkkc;end else begin Kwkkc <=Awkkc;end end always @(Kwkkc or Prkkc or Unkkc or Ylkkc or Rtkkc or Etkkc)begin : I6lkc 
Awkkc=Qwkkc;case(Kwkkc)Qwkkc: begin if(Prkkc==1'b1)begin if(Unkkc==1'b0)begin if(Ylkkc==1'b1)begin Awkkc=Fxkkc;
end else begin Awkkc=Cxkkc;end end else begin Awkkc=Twkkc;end end end Twkkc: begin if(Ylkkc==1'b1)begin Awkkc=Wwkkc;end 
else begin Awkkc=Twkkc;end end Wwkkc: begin if(Ylkkc==1'b1)begin Awkkc=Zwkkc;end else begin Awkkc=Wwkkc;end end Ixkkc,Zwkkc: begin 
if(Rtkkc==1'b1)begin if(Etkkc==1'b1)begin if(Ylkkc==1'b1)begin Awkkc=Wwkkc;end else begin Awkkc=Twkkc;end end else 
begin if(Ylkkc==1'b1)begin Awkkc=Fxkkc;end else begin Awkkc=Cxkkc;end end end else begin if(Prkkc==1'b1)begin if(Unkkc==1'b0)begin 
if(Ylkkc==1'b1)begin Awkkc=Fxkkc;end else begin Awkkc=Cxkkc;end end else begin Awkkc=Twkkc;end end else begin Awkkc=Qwkkc;
end end end Cxkkc: begin if(Ylkkc==1'b1)begin Awkkc=Fxkkc;end else begin Awkkc=Cxkkc;end end Fxkkc: begin if(Ylkkc==1'b1)begin 
Awkkc=Ixkkc;end else begin Awkkc=Fxkkc;end end default: begin Awkkc=Qwkkc;end endcase end endmodule module X6lkc(Epkkc,J7lkc);
input[(32-1):0]Epkkc;output[(2-1):0]J7lkc;wire[(16-1):0]S7lkc;assign S7lkc[0]=((Epkkc >=32'h01000400)&&(Epkkc <=32'h010007ff));
assign S7lkc[1]=((Epkkc >=32'h01000800)&&(Epkkc <=32'h01000bff));assign S7lkc[2]=((Epkkc >=32'h00000c00)&&(Epkkc <=32'h00000fff));
assign S7lkc[3]=((Epkkc >=32'h00001000)&&(Epkkc <=32'h000013ff));assign S7lkc[4]=((Epkkc >=32'h00001400)&&(Epkkc <=32'h000017ff));
assign S7lkc[5]=((Epkkc >=32'h00001800)&&(Epkkc <=32'h00001bff));assign S7lkc[6]=((Epkkc >=32'h00001c00)&&(Epkkc <=32'h00001fff));
assign S7lkc[7]=((Epkkc >=32'h00002000)&&(Epkkc <=32'h000023ff));assign S7lkc[8]=((Epkkc >=32'h00002400)&&(Epkkc <=32'h000027ff));
assign S7lkc[9]=((Epkkc >=32'h00002800)&&(Epkkc <=32'h00002bff));assign S7lkc[10]=((Epkkc >=32'h00002c00)&&(Epkkc <=32'h00002fff));
assign S7lkc[11]=((Epkkc >=32'h00003000)&&(Epkkc <=32'h000033ff));assign S7lkc[12]=((Epkkc >=32'h00003400)&&(Epkkc <=32'h000037ff));
assign S7lkc[13]=((Epkkc >=32'h00003800)&&(Epkkc <=32'h00003bff));assign S7lkc[14]=((Epkkc >=32'h00003c00)&&(Epkkc <=32'h00003fff));
assign S7lkc[15]=((Epkkc >=32'h00004000)&&(Epkkc <=32'h000043ff));assign J7lkc[(2-1):0]=S7lkc[(2-1):0];endmodule module B8lkc(Gmkkc,Epkkc,P8lkc,A9lkc);
input Gmkkc;input[(32-1):0]Epkkc;input[(32-1):0]P8lkc;output[(256-1):0]A9lkc;reg[(256-1):0]A9lkc;reg[31:0]L9lkc;
`define L3lkc `APB_DATA_WIDTH
always @(Epkkc or P8lkc or Gmkkc)begin : U9lkc if(`L3lkc==8)begin if(Gmkkc==1'b1)begin case(Epkkc[1:0])2'b11: L9lkc={24'b0,P8lkc[7:0]};
2'b10: L9lkc={16'b0,P8lkc[7:0],8'b0};2'b1: L9lkc={8'b0,P8lkc[7:0],16'b0};2'b0: L9lkc={P8lkc[7:0],24'b0};endcase end else 
begin case(Epkkc[1:0])2'b0: L9lkc={24'b0,P8lkc[7:0]};2'b1: L9lkc={16'b0,P8lkc[7:0],8'b0};2'b10: L9lkc={8'b0,P8lkc[7:0],16'b0};
2'b11: L9lkc={P8lkc[7:0],24'b0};endcase end end else if(`L3lkc==16)begin if(Gmkkc==1'b1)begin case(Epkkc[1])1'b1: L9lkc={16'b0,P8lkc[7:0],P8lkc[15:8]};
1'b0: L9lkc={P8lkc[7:0],P8lkc[15:8],16'b0};endcase end else begin case(Epkkc[1])1'b0: L9lkc={16'b0,P8lkc[15:0]};1'b1: L9lkc={P8lkc[15:0],16'b0};
endcase end end else begin if(Gmkkc==1'b1)begin L9lkc={P8lkc[7:0],P8lkc[15:8],P8lkc[23:16],P8lkc[31:24]};end else begin L9lkc=P8lkc;
end end end always @(Epkkc or L9lkc or Gmkkc)begin : Ralkc if(32==64)begin if(Gmkkc==1'b1)begin case(Epkkc[2])1'b1: A9lkc[63:0]={32'b0,L9lkc};
1'b0: A9lkc[63:0]={L9lkc,32'b0};endcase end else begin case(Epkkc[2])1'b0: A9lkc[63:0]={32'b0,L9lkc};1'b1: A9lkc[63:0]={L9lkc,32'b0};
endcase end end else if(32==128)begin if(Gmkkc==1'b1)begin case(Epkkc[3:2])2'b11: A9lkc[127:0]={96'b0,L9lkc};2'b10: A9lkc[127:0]={64'b0,L9lkc,32'b0};
2'b1: A9lkc[127:0]={32'b0,L9lkc,64'b0};2'b0: A9lkc[127:0]={L9lkc,96'b0};endcase end else begin case(Epkkc[3:2])2'b0: A9lkc[127:0]={96'b0,L9lkc};
2'b1: A9lkc[127:0]={64'b0,L9lkc,32'b0};2'b10: A9lkc[127:0]={32'b0,L9lkc,64'b0};2'b11: A9lkc[127:0]={L9lkc,96'b0};endcase 
end end else if(32==256)begin if(Gmkkc==1'b1)begin case(Epkkc[4:2])3'b111: A9lkc={224'b0,L9lkc};3'b110: A9lkc={192'b0,L9lkc,32'b0};
3'b101: A9lkc={160'b0,L9lkc,64'b0};3'b100: A9lkc={128'b0,L9lkc,96'b0};3'b011: A9lkc={96'b0,L9lkc,128'b0};3'b010: A9lkc={64'b0,L9lkc,160'b0};
3'b1: A9lkc={32'b0,L9lkc,192'b0};3'b0: A9lkc={L9lkc,224'b0};endcase end else begin case(Epkkc[4:2])3'b0: A9lkc={224'b0,L9lkc};
3'b1: A9lkc={192'b0,L9lkc,32'b0};3'b010: A9lkc={160'b0,L9lkc,64'b0};3'b011: A9lkc={128'b0,L9lkc,96'b0};3'b100: A9lkc={96'b0,L9lkc,128'b0};
3'b101: A9lkc={64'b0,L9lkc,160'b0};3'b110: A9lkc={32'b0,L9lkc,192'b0};3'b111: A9lkc={L9lkc,224'b0};endcase end end else 
begin A9lkc[31:0]=L9lkc;end end endmodule module Oblkc(J7lkc,Cclkc,Mclkc);input[(2-1):0]J7lkc;input[((`L3lkc*2)-1):0]Cclkc;
output[(`L3lkc-1):0]Mclkc;reg[(`L3lkc-1):0]Mclkc;integer Xclkc;always @(J7lkc or Cclkc)begin : Zclkc Mclkc=Cclkc[(`L3lkc-1):0];
for(Xclkc=1;(Xclkc < 2);Xclkc=(Xclkc+1))begin if(J7lkc[Xclkc]==1'b1)begin Mclkc=(Cclkc >>(Xclkc*`L3lkc));end end 
end endmodule module Qdlkc(Kqkkc,J7lkc,Celkc);input Kqkkc;input[(2-1):0]J7lkc;output[(2-1):0]Celkc;reg[(2-1):0]Celkc;
always @(J7lkc or Kqkkc)begin : Lelkc if(Kqkkc==1'b1)begin Celkc=J7lkc;end else begin Celkc={2 {1'b0}};end end endmodule 
module Velkc(Gmkkc,Epkkc,Kpkkc,Hflkc);input Gmkkc;input[(32-1):0]Epkkc;input[(32-1):0]Kpkkc;output[(32-1):0]Hflkc;
reg[(32-1):0]Hflkc;always @(Epkkc or Kpkkc or Gmkkc)begin : Sflkc if(`L3lkc==16)begin if(Gmkkc==1'b1)begin case(Epkkc[1])
1'b1: Hflkc[15:0]={Kpkkc[7:0],Kpkkc[15:8]};1'b0: Hflkc[15:0]={Kpkkc[23:16],Kpkkc[31:24]};endcase end else begin case(Epkkc[1])
1'b0: Hflkc[15:0]=Kpkkc[15:0];1'b1: Hflkc[15:0]=Kpkkc[31:16];endcase end end else if(`L3lkc==8)begin if(Gmkkc==1'b1)begin 
case(Epkkc[1:0])2'b11: Hflkc[7:0]=Kpkkc[7:0];2'b10: Hflkc[7:0]=Kpkkc[15:8];2'b1: Hflkc[7:0]=Kpkkc[23:16];2'b0: Hflkc[7:0]=Kpkkc[31:24];
endcase end else begin case(Epkkc[1:0])2'b0: Hflkc[7:0]=Kpkkc[7:0];2'b1: Hflkc[7:0]=Kpkkc[15:8];2'b10: Hflkc[7:0]=Kpkkc[23:16];
2'b11: Hflkc[7:0]=Kpkkc[31:24];endcase end end else begin if(Gmkkc==1'b1)begin Hflkc={Kpkkc[7:0],Kpkkc[15:8],Kpkkc[23:16],Kpkkc[31:24]};
end else begin Hflkc=Kpkkc;end end end endmodule module apb_wrapper(hclk,hresetn,haddr,hready,hsel,htrans,hwrite,hsize,hburst,
pready_s1,pslverr_s1,pslverr_s0,pready_s0,
hresp,hready_resp,hwdata,hrdata,pclk_en,paddr,penable,pwrite,pwdata,psel_s1,psel_s0,prdata_s1,prdata_s0);input hclk;
input hresetn;input[(32-1):0]haddr;input hready;input hsel;input[(2-1):0]htrans;input hwrite;input[(3-1):0]hsize;
input pready_s0;
input pslverr_s0;
input pready_s1;
input pslverr_s1;
input[(3-1):0]hburst;input[(32-1):0]hwdata;output[(32-1):0]hrdata;output hready_resp;output[(2-1):0]hresp;input pclk_en;
output[(32-1):0]paddr;output penable;output psel_s0;output psel_s1;output[(`L3lkc-1):0]pwdata;output pwrite;input[(`L3lkc-1):0]prdata_s0;
input[(`L3lkc-1):0]prdata_s1;wire[(`L3lkc-1):0]Fjlkc;wire[(`L3lkc-1):0]Pjlkc;wire[(`L3lkc-1):0]Zjlkc;wire[(`L3lkc-1):0]Jklkc;
wire[(`L3lkc-1):0]Tklkc;wire[(`L3lkc-1):0]Dllkc;wire[(`L3lkc-1):0]Nllkc;wire[(`L3lkc-1):0]Xllkc;wire[(`L3lkc-1):0]Hmlkc;
wire[(`L3lkc-1):0]Smlkc;wire[(`L3lkc-1):0]Dnlkc;wire[(`L3lkc-1):0]Onlkc;wire[(`L3lkc-1):0]Znlkc;wire[(`L3lkc-1):0]Kolkc;
wire Volkc;wire Dplkc;wire Lplkc;wire Tplkc;wire Bqlkc;wire Jqlkc;wire Rqlkc;wire Zqlkc;wire Hrlkc;wire Qrlkc;wire Zrlkc;
wire Islkc;wire Rslkc;wire Atlkc;wire[((`L3lkc*2)-1):0]Cclkc;wire[(512-1):0]Jtlkc;wire Gmkkc;wire[(`L3lkc-1):0]Mclkc;
wire[(32-1):0]Kpkkc;reg[(32-1):0]P8lkc;wire[(256-1):0]A9lkc;reg[(256-1):0]Bokkc;wire[(32-1):0]Hflkc;wire Kqkkc;
wire[(16-1):0]Celkc;wire[(2-1):0]J7lkc;assign Gmkkc=0;assign pwdata=Hflkc[(`L3lkc-1):0];assign hrdata[(32-1):0]=A9lkc[(32-1):0];
assign Jtlkc[(`L3lkc-1):0]=prdata_s0;assign Jtlkc[((`L3lkc*2)-1):`L3lkc]=prdata_s1;assign Jtlkc[((`L3lkc*3)-1):(`L3lkc*2)]=Fjlkc;
assign Jtlkc[((`L3lkc*4)-1):(`L3lkc*3)]=Pjlkc;assign Jtlkc[((`L3lkc*5)-1):(`L3lkc*4)]=Zjlkc;assign Jtlkc[((`L3lkc*6)-1):(`L3lkc*5)]=Jklkc;
assign Jtlkc[((`L3lkc*7)-1):(`L3lkc*6)]=Tklkc;assign Jtlkc[((`L3lkc*8)-1):(`L3lkc*7)]=Dllkc;assign Jtlkc[((`L3lkc*9)-1):(`L3lkc*8)]=Nllkc;
assign Jtlkc[((`L3lkc*10)-1):(`L3lkc*9)]=Xllkc;assign Jtlkc[((`L3lkc*11)-1):(`L3lkc*10)]=Hmlkc;assign Jtlkc[((`L3lkc*12)-1):(`L3lkc*11)]=Smlkc;
assign Jtlkc[((`L3lkc*13)-1):(`L3lkc*12)]=Dnlkc;assign Jtlkc[((`L3lkc*14)-1):(`L3lkc*13)]=Onlkc;assign Jtlkc[((`L3lkc*15)-1):(`L3lkc*14)]=Znlkc;
assign Jtlkc[((`L3lkc*16)-1):(`L3lkc*15)]=Kolkc;assign Cclkc=Jtlkc[((`L3lkc*2)-1):0];assign psel_s0=Celkc[0];assign psel_s1=Celkc[1];
assign Volkc=Celkc[2];assign Dplkc=Celkc[3];assign Lplkc=Celkc[4];assign Tplkc=Celkc[5];assign Bqlkc=Celkc[6];assign Jqlkc=Celkc[7];
assign Rqlkc=Celkc[8];assign Zqlkc=Celkc[9];assign Hrlkc=Celkc[10];assign Qrlkc=Celkc[11];assign Zrlkc=Celkc[12];assign Islkc=Celkc[13];
assign Rslkc=Celkc[14];assign Atlkc=Celkc[15];Xkkkc Xtlkc(.Gmkkc(Gmkkc),.Llkkc(hclk),.Qlkkc(hresetn),.Vmkkc(haddr),
.Bnkkc(hready),.Inkkc(hsel),.Nnkkc(htrans),.Unkkc(hwrite),.Bokkc(Bokkc),.Mokkc(hready_resp),.Yokkc(hresp),.Ylkkc(pclk_en),.Epkkc 
(paddr),.Kpkkc(Kpkkc),.Vpkkc(pwrite),.Cqkkc(penable),.Kqkkc(Kqkkc));X6lkc Nulkc(.Epkkc(paddr),.J7lkc(J7lkc));Velkc Bvlkc(.Gmkkc(Gmkkc),.Epkkc(paddr),.Kpkkc(Kpkkc),.Hflkc(Hflkc));
B8lkc Pvlkc(.Gmkkc(Gmkkc),.Epkkc(paddr),.P8lkc(P8lkc),.A9lkc(A9lkc));Oblkc Fwlkc(.J7lkc(J7lkc),.Cclkc(Cclkc),.Mclkc(Mclkc));
Qdlkc Vwlkc(.Kqkkc(Kqkkc),.J7lkc(J7lkc),.Celkc(Celkc[(2-1):0]));always @(hwdata)begin Bokkc={256 {1'b0}};Bokkc[(32-1):0]=hwdata[(32-1):0];
end always @(Mclkc) begin P8lkc = {32 {1'b0}}; P8lkc[(`L3lkc - 1):0] = Mclkc; end endmodule 
