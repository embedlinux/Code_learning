library verilog;
use verilog.vl_types.all;
entity counter is
    port(
        rst             : in     vl_logic;
        clk             : in     vl_logic;
        ld              : in     vl_logic;
        en              : in     vl_logic;
        d               : in     vl_logic_vector(3 downto 0);
        q               : out    vl_logic_vector(3 downto 0);
        co              : out    vl_logic
    );
end counter;
