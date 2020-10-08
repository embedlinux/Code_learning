library verilog;
use verilog.vl_types.all;
entity traffic_controller is
    generic(
        major_0         : integer := 0;
        major_1         : integer := 1;
        minor           : integer := 2;
        clr_all         : integer := 3
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        req_n           : in     vl_logic;
        major_red       : out    vl_logic;
        major_green     : out    vl_logic;
        minor_red       : out    vl_logic;
        minor_green     : out    vl_logic;
        req_ind         : out    vl_logic
    );
end traffic_controller;
