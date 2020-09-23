library verilog;
use verilog.vl_types.all;
entity BCD_Counter is
    port(
        Clk             : in     vl_logic;
        Cin             : in     vl_logic;
        Rst_n           : in     vl_logic;
        Cout            : out    vl_logic;
        q               : out    vl_logic_vector(3 downto 0)
    );
end BCD_Counter;
