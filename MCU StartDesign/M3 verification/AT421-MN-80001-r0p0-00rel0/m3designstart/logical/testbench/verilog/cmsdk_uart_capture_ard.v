//-----------------------------------------------------------------------------
// The confidential and proprietary information contained in this file may
// only be used by a person authorised under and to the extent permitted
// by a subsisting licensing agreement from ARM Limited.
//
//            (C) COPYRIGHT 2010-2013 ARM Limited.
//                ALL RIGHTS RESERVED
//
// This entire notice must be reproduced on all copies of this file
// and copies of this file may only be made by a person if such person is
// permitted to do so under the terms of a subsisting license agreement
// from ARM Limited.
//
//      SVN Information
//
//      Checked In          : $Date: 2013-02-08 10:40:04 +0000 (Fri, 08 Feb 2013) $
//
//      Revision            : $Revision: 365823 $
//
//      Release Information : CM3DesignStart-r0p0-00rel0
//
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
// Abstract : A device to capture serial data
//-----------------------------------------------------------------------------
// This module assume CLK is same frequency as baud rate.
// In the example UART a test mode is used to enable data output as maximum
// speed (PCLK).  In such case we can connect CLK signal directly to PCLK.
// Otherwise, if the UART baud rate is reduced, the CLK rate has to be reduced
// accordingly as well.
//
// This module stop the simulation when character 0x04 is received.
// An output called SIMULATION_END is set for 1 cycle before simulation is
// terminated to allow other testbench component like profiler (if any)
// to output reports before the simulation stop.
//
// This model also support ESCAPE (0x1B, decimal 27) code sequence
// ESC - 0x10 - XY    Capture XY to AUXCTRL output
// ESC - 0x11         Set DEBUG_TESTER_ENABLE to 1
// ESC - 0x12         Clear DEBUG_TESTER_ENABLE to 0


module cmsdk_uart_capture_ard (
  input  wire       RESETn,              // Power on reset
  input  wire       CLK,                 // Clock (baud rate)
  input  wire       RXD,                 // Received data
  output wire       SIMULATIONEND,       // Simulation end indicator
  output wire       DEBUG_TESTER_ENABLE, // Enable debug tester
  output wire [7:0] AUXCTRL,             // Auxiliary control
  output wire       SPI0,                // Shield0 SPI enable
  output wire       SPI1,                // Shield1 SPI enable
  output wire       I2C0,                // Shield0 I2C enable
  output wire       I2C1,                // Shield1 I2C enable
  output wire       UART0,               // Shield0 UART enable
  output wire       UART1);              // Shield1 UART enable

  reg [8:0]        rx_shift_reg;
  wire[8:0]        nxt_rx_shift;
  reg [6:0]        string_length;
  reg [7:0]        tube_string [127:0];
  reg [7:0]        text_char;
  integer          i;
  reg              nxt_end_simulation;
  reg              reg_end_simulation;
  wire             char_received;
  reg              reg_esc_code_mode;  // Escape code mode
  reg              reg_aux_ctrl_mode;  // Auxiliary control capture mode
  reg [7:0]        reg_aux_ctrl;       // Registered Auxiliary control
  reg              reg_dbgtester_enable;
  reg              SPI0_reg;
  reg              SPI1_reg;
  reg              I2C0_reg;
  reg              I2C1_reg;
  reg              UART0_reg;
  reg              UART1_reg;

  // Receive shift register
  assign nxt_rx_shift  = {RXD,rx_shift_reg[8:1]};
  assign char_received = (rx_shift_reg[0]==1'b0);

  initial
  begin
  SPI0_reg  <= 1'b0;
  SPI1_reg  <= 1'b0;
  I2C0_reg  <= 1'b0;
  I2C1_reg  <= 1'b0;
  UART0_reg <= 1'b0;
  UART1_reg <= 1'b0;
  end


  always @(posedge CLK or negedge RESETn)
  begin
    if (~RESETn)
      rx_shift_reg <= {9{1'b1}};
    else
      if (rx_shift_reg[0]==1'b0) // Start bit reach bit[0]
        rx_shift_reg <= {9{1'b1}};
      else
        rx_shift_reg <= nxt_rx_shift;
  end

  // Escape code mode register
  always @(posedge CLK or negedge RESETn)
  begin
    if (~RESETn)
      reg_esc_code_mode <= 1'b0;
    else // Set to escape mode if ESC code is detected
      if (char_received & (reg_esc_code_mode==1'b0) & (rx_shift_reg[8:1]==8'h1B))
        reg_esc_code_mode <= 1'b1;
      else if (char_received)
        reg_esc_code_mode <= 1'b0;
  end

  // Aux Ctrl capture mode register
  always @(posedge CLK or negedge RESETn)
  begin
    if (~RESETn)
      reg_aux_ctrl_mode <= 1'b0;
    else // Set to Aux control capture mode if ESC-0x10 sequence is detected
      if (char_received & (reg_esc_code_mode==1'b1) & (rx_shift_reg[8:1]==8'h10))
        reg_aux_ctrl_mode <= 1'b1;
      else if (char_received)
        reg_aux_ctrl_mode <= 1'b0;
  end

  // Aux Ctrl capture data register
  always @(posedge CLK or negedge RESETn)
  begin
    if (~RESETn)
      reg_aux_ctrl <= {8{1'b0}};
    else // Capture received data to Aux control output if reg_aux_ctrl_mode is set
      if (char_received & (reg_aux_ctrl_mode==1'b1))
        reg_aux_ctrl <= rx_shift_reg[8:1];
  end

  assign AUXCTRL = reg_aux_ctrl;

  // Debug tester enable
  always @(posedge CLK or negedge RESETn)
  begin
    if (~RESETn)
      reg_dbgtester_enable <= 1'b0;
    else // Enable debug tester if ESC-0x11 sequence is detected
      if (char_received & (reg_esc_code_mode==1'b1) & (rx_shift_reg[8:1]==8'h11))
        reg_dbgtester_enable <= 1'b1;
      else if (char_received & (reg_esc_code_mode==1'b1) & (rx_shift_reg[8:1]==8'h12))
        // Disable debug tester if ESC-0x12 sequence is detected
        reg_dbgtester_enable <= 1'b0;
  end

  assign DEBUG_TESTER_ENABLE = reg_dbgtester_enable;

  // Message display
  always @ (posedge CLK or negedge RESETn)
  begin: p_tube
  if (~RESETn)
    begin
    string_length = 7'b0;
    nxt_end_simulation <= 1'b0;
     for (i=0; i<= 127; i=i+1) begin
       tube_string [i] = 8'h00;
     end
    end
  else
    if (char_received)
        begin
        if ((rx_shift_reg[8:1]==8'h1B) | reg_esc_code_mode | reg_aux_ctrl_mode )
          begin
          // Escape code, or in escape code mode
          // Data receive can be command, aux ctrl data
          // Ignore this data
          end
        else if  (rx_shift_reg[8:1]==8'h04) // Stop simulation if 0x04 is received
          nxt_end_simulation <= 1'b1;
        else if ((rx_shift_reg[8:1]==8'h0d)|(rx_shift_reg[8:1]==8'h0A))
          // New line
          begin
          tube_string[string_length] = 8'h00;
          $write("%t UART: ",$time);

          for (i=0; i<= string_length; i=i+1)
            begin
            text_char = tube_string[i];
            $write("%s",text_char);
            end

          $write("\n");
          string_length = 7'b0;
          end
        else if  (rx_shift_reg[8:1]==8'h0F)
          begin
          $write("%t UART: Switching on Shield I2C, SPI and UART\n",$time);
            SPI0_reg  <= 1'b1;
       SPI1_reg  <= 1'b1;
       I2C0_reg  <= 1'b1;
       I2C1_reg  <= 1'b1;
       UART0_reg <= 1'b1;
            UART1_reg <= 1'b1;
          end

        else
          begin
          tube_string[string_length] = rx_shift_reg[8:1];
          string_length = string_length + 1;
          if (string_length >79) // line too long, display and clear buffer
            begin
            tube_string[string_length] = 8'h00;
            $write("%t UART: ",$time);

            for (i=0; i<= string_length; i=i+1)
              begin
              text_char = tube_string[i];
              $write("%s",text_char);
              end

            $write("\n");
            string_length = 7'b0;

            end

          end

        end

  end // p_TUBE

  // Delay for simulation end
  always @ (posedge CLK or negedge RESETn)
  begin: p_sim_end
  if (~RESETn)
    begin
    reg_end_simulation <= 1'b0;
    end
  else
    reg_end_simulation  <= nxt_end_simulation;
    if (reg_end_simulation==1'b1)
      begin
      $write("%t UART: Test Ended\n",$time);
      $stop;
      end

  end

  assign SIMULATIONEND = nxt_end_simulation & ~reg_end_simulation;

  assign SPI0  = SPI0_reg;
  assign SPI1  = SPI1_reg;
  assign I2C0  = I2C0_reg;
  assign I2C1  = I2C1_reg;
  assign UART0 = UART0_reg;
  assign UART1 = UART1_reg;

endmodule
