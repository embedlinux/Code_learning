library verilog;
use verilog.vl_types.all;
entity TFT_CTRL_test is
    port(
        Clk             : in     vl_logic;
        Rst_n           : in     vl_logic;
        TFT_RGB         : out    vl_logic_vector(15 downto 0);
        TFT_HS          : out    vl_logic;
        TFT_VS          : out    vl_logic;
        TFT_CLK         : out    vl_logic;
        TFT_DE          : out    vl_logic;
        TFT_PWM         : out    vl_logic
    );
end TFT_CTRL_test;
