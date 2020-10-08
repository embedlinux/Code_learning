library verilog;
use verilog.vl_types.all;
entity fifo16x8 is
    port(
        rst             : in     vl_logic;
        clk             : in     vl_logic;
        clr             : in     vl_logic;
        rd_n            : in     vl_logic;
        wr_n            : in     vl_logic;
        di              : in     vl_logic_vector(7 downto 0);
        do              : out    vl_logic_vector(7 downto 0);
        full            : out    vl_logic;
        empty           : out    vl_logic
    );
end fifo16x8;
