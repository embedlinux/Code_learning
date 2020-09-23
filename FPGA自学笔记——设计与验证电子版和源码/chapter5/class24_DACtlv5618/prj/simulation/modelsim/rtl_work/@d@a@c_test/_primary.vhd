library verilog;
use verilog.vl_types.all;
entity DAC_test is
    port(
        Clk             : in     vl_logic;
        Rst_n           : in     vl_logic;
        DAC_CS_N        : out    vl_logic;
        DAC_DIN         : out    vl_logic;
        DAC_SCLK        : out    vl_logic
    );
end DAC_test;
