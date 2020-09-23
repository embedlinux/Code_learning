library verilog;
use verilog.vl_types.all;
entity pwm_generator is
    port(
        Clk50M          : in     vl_logic;
        Rst_n           : in     vl_logic;
        cnt_en          : in     vl_logic;
        counter_arr     : in     vl_logic_vector(31 downto 0);
        counter_ccr     : in     vl_logic_vector(31 downto 0);
        o_pwm           : out    vl_logic
    );
end pwm_generator;
