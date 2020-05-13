//****************************************************************************/
//  File: memctldut.sv
//
//  PARAMETERS: //    MEMID
//
//****************************************************************************/
`ifndef DUT_DSIZE
   `define DUT_DSIZE 8
`endif
`ifndef DUT_ASIZE
   `define DUT_ASIZE 32 
`endif

module memctldut #(parameter bit [15:0] MEMID = 0)
              ( input clock,
                input reset,
                interface apbif);

// simple memory controller registers
wire [`DUT_DSIZE-1:0] mode0_reg, mode1_reg, mode2_reg, mode3_reg;
wire [`DUT_DSIZE-1:0] status_reg, rd_cnt_reg, wr_cnt_reg;

`ifdef HAS_SUBMOD
// sub-module registers - to show some hdl_path hierarchy
wire [`DUT_DSIZE-1:0] sub_mode0_reg, sub_mode1_reg, sub_mode2_reg, sub_mode3_reg;
wire [`DUT_DSIZE-1:0] sub_status_reg, sub_rd_cnt_reg, sub_wr_cnt_reg;
`endif

wire t_pslverr, t_pready;
wire [`DUT_DSIZE-1:0] t_prdata;

memctl memctl ( .clock(clock),
                .reset(reset),
                .wr_rd(apbif.prwd),
                .en(apbif.penable),
                .select(apbif.psel[MEMID]),
                .addr(apbif.paddr),
                .data_in(apbif.pwdata),
                .data_out(apbif.prdata),
                .ready(apbif.pready),
                .error(apbif.pslverr),
               // REGISTER OUTPUTS 
                .mode0_reg(mode0_reg),
                .mode1_reg(mode1_reg),
                .mode2_reg(mode2_reg),
                .mode3_reg(mode3_reg),
                .status_reg(status_reg),
                .rd_cnt_reg(rd_cnt_reg),
                .wr_cnt_reg(wr_cnt_reg) );


`ifdef HAS_SUBMOD
submod #(.OFFSET('h6000))submod ( .clock(clock),
                .reset(reset),
                .wr_rd(apbif.prwd),
                .en(apbif.penable),
                .select(apbif.psel[MEMID]),
                .addr(apbif.paddr),
                .data_in(apbif.pwdata),
                //.data_out(apbif.prdata),
                //.ready(apbif.pready),
                //.error(apbif.pslverr),
                .data_out(t_prdata),
                .ready(t_pready),
                .error(t_pslverr),
               // REGISTER OUTPUTS 
                .mode0_reg(sub_mode0_reg),
                .mode1_reg(sub_mode1_reg),
                .mode2_reg(sub_mode2_reg),
                .mode3_reg(sub_mode3_reg),
                .status_reg(sub_status_reg),
                .rd_cnt_reg(sub_rd_cnt_reg),
                .wr_cnt_reg(sub_wr_cnt_reg) );
`endif  // HAS_SUBMOD

  function void print_regs();
      memctl.print_regs();
`ifdef HAS_SUBMOD
      submod.print_regs();
`endif
  endfunction : print_regs

  final begin
     print_regs();
  end

endmodule : memctldut
