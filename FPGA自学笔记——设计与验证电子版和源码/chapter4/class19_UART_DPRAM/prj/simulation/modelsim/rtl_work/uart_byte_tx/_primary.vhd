library verilog;
use verilog.vl_types.all;
entity uart_byte_tx is
    port(
        Clk             : in     vl_logic;
        Rst_n           : in     vl_logic;
        data_byte       : in     vl_logic_vector(7 downto 0);
        send_en         : in     vl_logic;
        baud_set        : in     vl_logic_vector(2 downto 0);
        Rs232_Tx        : out    vl_logic;
        Tx_Done         : out    vl_logic;
        uart_state      : out    vl_logic
    );
end uart_byte_tx;
