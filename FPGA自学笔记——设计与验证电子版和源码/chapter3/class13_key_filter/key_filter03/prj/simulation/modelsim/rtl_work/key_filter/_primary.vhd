library verilog;
use verilog.vl_types.all;
entity key_filter is
    port(
        Clk             : in     vl_logic;
        Rst_n           : in     vl_logic;
        key_in          : in     vl_logic;
        key_flag        : out    vl_logic;
        key_state       : out    vl_logic
    );
end key_filter;
