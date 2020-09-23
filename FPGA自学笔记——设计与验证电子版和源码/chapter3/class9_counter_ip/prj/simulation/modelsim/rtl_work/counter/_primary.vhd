library verilog;
use verilog.vl_types.all;
entity counter is
    port(
        cin             : in     vl_logic;
        clock           : in     vl_logic;
        cout            : out    vl_logic;
        q               : out    vl_logic_vector(3 downto 0)
    );
end counter;
