`timescale 1 ns/10 ps
module mem( clk, reset, busAddr, busData, busRdWr_, adxStrb, rdWr_, ce0_,
            ce1_, ce2_, ce3_, ramAddr, ramData);

  input clk, reset, busRdWr_, adxStrb;
  input [13:0] busAddr;
  inout [15:0] busData;
  output rdWr_, ce0_, ce1_, ce2_, ce3_;
  output [11:0] ramAddr;
  inout [15:0] ramData;

  reg [1:0] state, nxState;
  wire nxvalid;
  reg valid;
  reg [3:0] nxCe_, ce_;
  reg nxRdWr_, rdWr_;
  reg outEn;
  reg [15:0] dataWr, dataRd;
  reg [13:0] address;
  reg busOe, readWrite_;

  

  parameter IDLE = 0, START = 1, WRITE0 = 2, WRITE1 = 3;

  assign ramData = (outEn)? dataWr:16'hzzzz;
  assign busData = (busOe)? dataRd:16'hzzzz;

  assign ce0_ = ce_[0];
  assign ce1_ = ce_[1];
  assign ce2_ = ce_[2];
  assign ce3_ = ce_[3];

  assign ramAddr = address[11:0];

  always @(state or ce_ or readWrite_ or valid or address)
  begin

    nxState = state;
    nxCe_ = ce_;
    nxRdWr_ = 1'b1;
    outEn = 1'b0;

    case(state)
      IDLE: begin
	if(valid)
	   nxState = START;
	if(valid & readWrite_) begin
	  case(address[13:12])
	    2'b00: nxCe_ = 4'b1110;
	    2'b01: nxCe_ = 4'b1101;
	    2'b10: nxCe_ = 4'b1011;
	    2'b11: nxCe_ = 4'b0111;
          endcase
	end
	else nxCe_ = 4'b1111;
      end

      START: begin
	if(readWrite_) begin
	  nxState = IDLE;
	  nxCe_ = 4'b1111;
	end
	else begin
	  nxRdWr_ = 1'b0;
	  case(address[13:12])
	    2'b00: nxCe_ = 4'b1110;
	    2'b01: nxCe_ = 4'b1101;
	    2'b10: nxCe_ = 4'b1011;
	    2'b11: nxCe_ = 4'b0111;
          endcase
	  outEn = 1'b1;
	  nxState = WRITE0;
	end
      end

      WRITE0: begin
        nxRdWr_ = 1'b1;
	outEn = 1'b1;
	nxCe_ = 4'b1111;
	nxState = WRITE1;
      end

      WRITE1: begin
	outEn = 1'b1;
	nxState = IDLE;
      end

    endcase
  end

  assign nxvalid = adxStrb & (state == IDLE);
  
  always @(posedge clk) begin
     if(reset) 
       state = IDLE;
     else begin
       state <= #1 nxState;
     end

     address <= #1 (nxvalid)? busAddr : address;
     dataWr <= #1 (nxvalid & ~busRdWr_)? busData : dataWr;
     readWrite_ <= #1 (nxvalid) ? busRdWr_: readWrite_;
     ce_ <= #1 nxCe_;
     rdWr_ <= #1 nxRdWr_;
     dataRd <= #1 (rdWr_ & ~&ce_)? ramData : dataRd;
     busOe <= #1  ce0_ ;
     valid <= #1 nxvalid;
  end

endmodule







