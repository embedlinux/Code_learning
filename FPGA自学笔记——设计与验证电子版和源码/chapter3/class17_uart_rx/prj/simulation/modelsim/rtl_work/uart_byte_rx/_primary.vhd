library verilog;
use verilog.vl_types.all;
entity uart_byte_rx is
    port(
        Clk             : in     vl_logic;
        Rst_n           : in     vl_logic;
        baud_set        : in     vl_logic_vector(2 downto 0);
        Rs232_Rx        : in     vl_logic;
        data_byte       : out    vl_logic_vector(7 downto 0);
        Rx_Done         : out    vl_logic
    );
end uart_byte_rx;
