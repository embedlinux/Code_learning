library verilog;
use verilog.vl_types.all;
entity ISSP is
    port(
        probe           : in     vl_logic;
        source          : out    vl_logic_vector(15 downto 0)
    );
end ISSP;
