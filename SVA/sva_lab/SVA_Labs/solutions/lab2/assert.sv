module assert_inputs(input clk, reset_n, logic[15:0] frame_n, valid_n, din);
parameter port_no = 0;

property p_valid_during_pad(fr_n, vld_n, data);
@(posedge clk) $fell(fr_n) |-> ##4 (vld_n && data) [*5];
endproperty

a_vld_hi_in_pad: assert property (
  disable iff(!reset_n) p_valid_during_pad(frame_n[port_no], valid_n[port_no], din[port_no])
) else begin
  $fatal(1,"[FATAL] %m: Pad protocol violation on port %0d at %t", port_no, $realtime);
end

endmodule //assert_inputs

module assert_outputs(input clk, reset_n, logic[15:0] frameo_n, valido_n, dout);
parameter port_no = 0;

int unsigned bit_cntr;

dout_unknown_check: assert property (@(posedge clk) !valido_n[port_no] |-> (!$isunknown(dout[port_no])));

always@(posedge clk or negedge reset_n) begin: bit_counter
  if (!reset_n) bit_cntr = 0;
  else if (!valido_n[port_no]) bit_cntr++;
end : bit_counter

a_vld_lo_rsng_frm: assert property (
  @(posedge clk) disable iff (!reset_n) p_vld_lo_on_rsng_frm) begin
    $display("[NOTE]%t End of frame successfully checked", $realtime);
    bit_cntr = 0;
  end else begin
    bit_cntr = 0;
    protocol_error_handler("Bit Alingment Error Found");
    $fatal;
  end

property p_vld_lo_on_rsng_frm;
  s_frame |-> ##0 ((bit_cntr%8 == 7) && (!valido_n[port_no]));
endproperty

sequence s_frame;
  $fell(frameo_n[port_no]) ##1 $rose(frameo_n[port_no])[->1];
endsequence

task protocol_error_handler(string msg);
  $display("[ERROR]%t Port %0d: %s", $realtime, port_no, msg);
endtask

endmodule //assert_outputs
