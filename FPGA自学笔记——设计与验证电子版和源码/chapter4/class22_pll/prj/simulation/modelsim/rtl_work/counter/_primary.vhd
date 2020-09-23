library verilog;
use verilog.vl_types.all;
entity counter is
    generic(
        CNT_MAX         : vl_logic_vector(0 to 24) := (Hi1, Hi0, Hi1, Hi1, Hi1, Hi1, Hi1, Hi0, Hi1, Hi0, Hi1, Hi1, Hi1, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1)
    );
    port(
        Clk             : in     vl_logic;
        Rst_n           : in     vl_logic;
        led             : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of CNT_MAX : constant is 1;
end counter;
