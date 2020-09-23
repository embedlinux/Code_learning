library verilog;
use verilog.vl_types.all;
entity led_ctrl is
    port(
        Clk             : in     vl_logic;
        Rst_n           : in     vl_logic;
        key_flag0       : in     vl_logic;
        key_flag1       : in     vl_logic;
        key_state0      : in     vl_logic;
        key_state1      : in     vl_logic;
        led             : out    vl_logic_vector(3 downto 0)
    );
end led_ctrl;
