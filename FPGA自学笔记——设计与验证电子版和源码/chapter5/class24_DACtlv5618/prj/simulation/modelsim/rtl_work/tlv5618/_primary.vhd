library verilog;
use verilog.vl_types.all;
entity tlv5618 is
    generic(
        fCLK            : integer := 50;
        DIV_PARAM       : integer := 2
    );
    port(
        Clk             : in     vl_logic;
        Rst_n           : in     vl_logic;
        DAC_DATA        : in     vl_logic_vector(15 downto 0);
        Start           : in     vl_logic;
        Set_Done        : out    vl_logic;
        DAC_CS_N        : out    vl_logic;
        DAC_DIN         : out    vl_logic;
        DAC_SCLK        : out    vl_logic;
        DAC_State       : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of fCLK : constant is 1;
    attribute mti_svvh_generic_type of DIV_PARAM : constant is 1;
end tlv5618;
