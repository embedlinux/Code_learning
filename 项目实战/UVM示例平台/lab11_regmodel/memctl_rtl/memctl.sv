//****************************************************************************/
//  File: memctl.sv
//  Description: Simple DUT with register types to exercise uvm_rgm
//
//   Mode Registers:
//      'h1000 Mode0
//      'h1001 Mode1
//      'h1002 Mode2
//      'h1003 Mode3
//
//   Status Register:
//      'h1010 Status Reg
//      'h1011 Read Count
//      'h1012 Write Count
//
//   Memory:
//      'h0000 - 'h0FFF
//
//  PARAMETERS:
//    DEF_MODE0, DEF_MODE1, DEF_MODE2, DEF_MODE3
//
//****************************************************************************/
`ifndef DUT_DSIZE
   `define DUT_DSIZE 8
`endif
`ifndef DUT_ASIZE
   `define DUT_ASIZE 32 
`endif

typedef struct packed {
            logic m3_wr;        //Mode3 Reg Written
            logic m2_wr;        //Mode2 Reg Written
            logic m1_wr;        //Mode1 Reg Written
            logic m0_wr;        //Mode0 Reg Written
            logic m3_rd;        //Mode3 Reg Read
            logic m2_rd;        //Mode2 Reg Read
            logic m1_rd;        //Mode1 Reg Read
            logic m0_rd;        //Mode0 Reg Read
        } status_t;

module memctl ( input clock,
                input reset,   //ACTIVE LOW
                input wr_rd,
                input en,
                input select,
                input  [`DUT_ASIZE-1:0] addr,
                input  [`DUT_DSIZE-1:0] data_in,
                output [`DUT_DSIZE-1:0] data_out,
               // OTHER FOR APB
                output reg ready,
                output reg error,
               // REGISTER OUTPUTS 
                output reg [`DUT_DSIZE-1:0] mode0_reg,
                output reg [`DUT_DSIZE-1:0] mode1_reg,
                output reg [`DUT_DSIZE-1:0] mode2_reg,
                output reg [`DUT_DSIZE-1:0] mode3_reg,
                output status_t status_reg,
                output reg [`DUT_DSIZE-1:0] rd_cnt_reg,
                output reg [`DUT_DSIZE-1:0] wr_cnt_reg
              );

  // Default Mode Register values
  parameter DEF_MODE0 = 'h00;         // 'h0000
`ifdef INJECT_RESET_ERROR
  parameter DEF_MODE1 = 'h20;         // 'h0001
`else
  parameter DEF_MODE1 = 'h22;         // 'h0001
`endif
  parameter DEF_MODE2 = 'h55;         // 'h0002
  parameter DEF_MODE3 = 'hAA;         // 'h0003

  reg wr_rd_r;
  reg en_r;

  // Internal Data Bus and Memory
  reg [`DUT_DSIZE-1:0] int_data;

  reg [`DUT_DSIZE-1:0] memory [0:'h0FFF];

  assign data_out = int_data;

  always @(negedge clock or negedge reset) begin
    en_r <= en && select;
    if (!reset) begin  // RESET
      mode0_reg = DEF_MODE0;
      mode1_reg = DEF_MODE1;
      mode2_reg = DEF_MODE2;
      mode3_reg = DEF_MODE3;
      status_reg = 'h00;
      rd_cnt_reg = 'h00;
      wr_cnt_reg = 'h00;
      en_r = 'b0;
      error = 'b0;
      ready = 'b0;
      int_data = 'h00; 
    end  // RESET
    else if (en && select && wr_rd) begin  //WRITE
      ready <= 'b1;
      casez (addr)
        'h0???: begin    //'h0000 - 'h0fff  writes to memory
`ifdef INJECT_ERROR
                 if (addr == 'h000f)
                   memory[addr] <= ~data_in;
                 else  
`endif
                   memory[addr] <= data_in;
                 wr_cnt_reg <= wr_cnt_reg + 1'b1;
                end
        'h1000: begin
                 mode0_reg <= data_in;
                 status_reg.m0_wr <= 1'b1;
                 wr_cnt_reg <= wr_cnt_reg + 1'b1;
                end
        'h1001: begin
                 mode1_reg <= data_in;
                 status_reg.m1_wr <= 1'b1;
                 wr_cnt_reg <= wr_cnt_reg + 1'b1;
                end
        'h1002: begin
`ifdef INJECT_ERROR
                 mode2_reg <= data_in[3:0];
`else
                 mode2_reg <= data_in;
`endif
                 status_reg.m2_wr <= 1'b1;
                 wr_cnt_reg <= wr_cnt_reg + 1'b1;
                end
        'h1003: begin
                 mode3_reg <= data_in;
                 status_reg.m3_wr <= 1'b1;
                 wr_cnt_reg <= wr_cnt_reg + 1'b1;
                end
       default: $display("DUT WARNING: Out-of-Range Address for Write:%h", addr);
      endcase
    end  // WRITE
    else if (en && select && !wr_rd) begin  //READ
      ready <= 'b1;
      casez (addr)
        'h0???: begin    //'h0000 - 'h0fff  reads to memory
                 int_data <= memory[addr];
                 rd_cnt_reg <= rd_cnt_reg + 1'b1;
                end
        'h1000: begin
                  int_data <= mode0_reg;
                  status_reg.m0_rd <= 1'b1;
                  if (!en_r)
                    rd_cnt_reg <= rd_cnt_reg + 1'b1;
                end
        'h1001: begin
                  int_data <= mode1_reg;
                  status_reg.m1_rd <= 1'b1;
                  if (!en_r)
                    rd_cnt_reg <= rd_cnt_reg + 1'b1;
                end
        'h1002: begin
                  int_data <= mode2_reg;
                  status_reg.m2_rd <= 1'b1;
                  if (!en_r)
                    rd_cnt_reg <= rd_cnt_reg + 1'b1;
                end
        'h1003: begin
                  int_data <= mode3_reg;
                  status_reg.m3_rd <= 1'b1;
                  if (!en_r)
                    rd_cnt_reg <= rd_cnt_reg + 1'b1;
                end
        'h1010: begin
                  int_data <= status_reg;
                  //if (!en_r) rd_cnt_reg <= rd_cnt_reg + 1'b1;
                end
        'h1011: begin
                  int_data <= rd_cnt_reg;
                  //if (!en_r) rd_cnt_reg <= rd_cnt_reg + 1'b1;
                end
        'h1012: begin
                  int_data <= wr_cnt_reg;
                  //if (!en_r) rd_cnt_reg <= rd_cnt_reg + 1'b1;
                end
       default: $display("DUT WARNING: Out-of-Range Address for Read:%h", addr);
      endcase
    end //READ
    else if (!en && en_r) // !en
       ; // Hold int_data one more clock
    else // !en
       int_data = 'z;
  end

  function void print_regs();
    $display("\n***DUT REGISTERS %m ***\n",
      "    MODE[0]  :'h%h\n    MODE[1]  :'h%h\n", mode0_reg, mode1_reg,
      "    MODE[2]  :'h%h\n    MODE[3]  :'h%h\n", mode2_reg, mode3_reg,
      "    STATUS   :'h%h  RD[m3:0]=%b WR[m3:0]=%b\n",
       status_reg, status_reg[7:4], status_reg[3:0], 
      "    RD_COUNT :'h%h  cnt=%0d\n", rd_cnt_reg, rd_cnt_reg,
      "    WR_COUNT :'h%h  cnt=%0d\n", wr_cnt_reg, wr_cnt_reg);
  endfunction : print_regs

endmodule : memctl
