library verilog;
use verilog.vl_types.all;
entity counter is
    port(
        Clk50M          : in     vl_logic;
        Rst_n           : in     vl_logic;
        led             : out    vl_logic
    );
end counter;
