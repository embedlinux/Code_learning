library verilog;
use verilog.vl_types.all;
entity key_model is
    port(
        press           : in     vl_logic;
        key             : out    vl_logic
    );
end key_model;
