library verilog;
use verilog.vl_types.all;
entity block_nonblock is
    port(
        Clk             : in     vl_logic;
        Rst_n           : in     vl_logic;
        a               : in     vl_logic;
        b               : in     vl_logic;
        c               : in     vl_logic;
        \out\           : out    vl_logic_vector(1 downto 0)
    );
end block_nonblock;
