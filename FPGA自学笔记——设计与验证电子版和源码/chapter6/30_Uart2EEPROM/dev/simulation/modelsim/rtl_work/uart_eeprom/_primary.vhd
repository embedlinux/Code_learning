library verilog;
use verilog.vl_types.all;
entity uart_eeprom is
    generic(
        Baud_set        : vl_logic_vector(0 to 2) := (Hi1, Hi0, Hi0)
    );
    port(
        Clk             : in     vl_logic;
        Rst_n           : in     vl_logic;
        Uart_rx         : in     vl_logic;
        Uart_tx         : out    vl_logic;
        Sda             : inout  vl_logic;
        Scl             : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of Baud_set : constant is 1;
end uart_eeprom;
