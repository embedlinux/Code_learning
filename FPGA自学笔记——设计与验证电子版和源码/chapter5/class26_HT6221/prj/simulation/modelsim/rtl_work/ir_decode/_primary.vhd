library verilog;
use verilog.vl_types.all;
entity ir_decode is
    port(
        Clk             : in     vl_logic;
        Rst_n           : in     vl_logic;
        iIR             : in     vl_logic;
        Get_Flag        : out    vl_logic;
        irData          : out    vl_logic_vector(15 downto 0);
        irAddr          : out    vl_logic_vector(15 downto 0)
    );
end ir_decode;
