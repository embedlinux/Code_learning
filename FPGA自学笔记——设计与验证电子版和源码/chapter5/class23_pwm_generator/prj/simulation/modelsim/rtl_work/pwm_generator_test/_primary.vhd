library verilog;
use verilog.vl_types.all;
entity pwm_generator_test is
    port(
        Clk50M          : in     vl_logic;
        Rst_n           : in     vl_logic;
        beep            : out    vl_logic
    );
end pwm_generator_test;
