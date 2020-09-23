library verilog;
use verilog.vl_types.all;
entity TFT_test_pll is
    port(
        inclk0          : in     vl_logic;
        c0              : out    vl_logic
    );
end TFT_test_pll;
