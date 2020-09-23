library verilog;
use verilog.vl_types.all;
entity counter_top is
    port(
        cin             : in     vl_logic;
        clk             : in     vl_logic;
        cout            : out    vl_logic;
        q               : out    vl_logic_vector(7 downto 0)
    );
end counter_top;
