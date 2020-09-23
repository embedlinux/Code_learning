library verilog;
use verilog.vl_types.all;
entity PLL_LED is
    port(
        Clk             : in     vl_logic;
        Rst_n           : in     vl_logic;
        LED             : out    vl_logic_vector(3 downto 0)
    );
end PLL_LED;
