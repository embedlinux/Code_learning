library verilog;
use verilog.vl_types.all;
entity uart_tx_top is
    port(
        Clk             : in     vl_logic;
        Rst_n           : in     vl_logic;
        Rs232_Tx        : out    vl_logic;
        key_in0         : in     vl_logic;
        led             : out    vl_logic
    );
end uart_tx_top;
