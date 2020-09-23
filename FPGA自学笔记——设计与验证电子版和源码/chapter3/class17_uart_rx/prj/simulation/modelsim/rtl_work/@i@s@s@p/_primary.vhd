library verilog;
use verilog.vl_types.all;
entity ISSP is
    port(
        probe           : in     vl_logic_vector(7 downto 0);
        source          : out    vl_logic
    );
end ISSP;
