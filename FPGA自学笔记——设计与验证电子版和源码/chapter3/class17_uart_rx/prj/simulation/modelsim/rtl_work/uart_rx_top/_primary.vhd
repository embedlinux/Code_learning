library verilog;
use verilog.vl_types.all;
entity uart_rx_top is
    port(
        Clk             : in     vl_logic;
        Rst_n           : in     vl_logic;
        Rs232_Rx        : in     vl_logic
    );
end uart_rx_top;
