library verilog;
use verilog.vl_types.all;
entity key_led_top is
    port(
        Clk             : in     vl_logic;
        Rst_n           : in     vl_logic;
        key_in0         : in     vl_logic;
        key_in1         : in     vl_logic;
        led             : out    vl_logic_vector(3 downto 0)
    );
end key_led_top;
