library verilog;
use verilog.vl_types.all;
entity UART_DPRAM is
    port(
        Clk             : in     vl_logic;
        Rst_n           : in     vl_logic;
        Key_in          : in     vl_logic;
        Rs232_Rx        : in     vl_logic;
        Rs232_Tx        : out    vl_logic
    );
end UART_DPRAM;
