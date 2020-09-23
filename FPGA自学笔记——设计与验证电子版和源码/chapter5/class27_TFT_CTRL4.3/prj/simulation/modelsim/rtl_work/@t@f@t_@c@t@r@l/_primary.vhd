library verilog;
use verilog.vl_types.all;
entity TFT_CTRL is
    generic(
        TFT_HS_end      : vl_logic_vector(0 to 9) := (Hi0, Hi0, Hi0, Hi0, Hi1, Hi0, Hi1, Hi0, Hi0, Hi0);
        hdat_begin      : vl_logic_vector(0 to 9) := (Hi0, Hi0, Hi0, Hi0, Hi1, Hi0, Hi1, Hi0, Hi1, Hi0);
        hdat_end        : vl_logic_vector(0 to 9) := (Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi0, Hi1, Hi0);
        hpixel_end      : vl_logic_vector(0 to 9) := (Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi1, Hi0, Hi0);
        TFT_VS_end      : vl_logic_vector(0 to 9) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi0, Hi0, Hi1);
        vdat_begin      : vl_logic_vector(0 to 9) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi0, Hi1, Hi1);
        vdat_end        : vl_logic_vector(0 to 9) := (Hi0, Hi1, Hi0, Hi0, Hi0, Hi1, Hi1, Hi0, Hi1, Hi1);
        vline_end       : vl_logic_vector(0 to 9) := (Hi0, Hi1, Hi0, Hi0, Hi0, Hi1, Hi1, Hi1, Hi0, Hi1)
    );
    port(
        Clk9M           : in     vl_logic;
        Rst_n           : in     vl_logic;
        data_in         : in     vl_logic_vector(15 downto 0);
        hcount          : out    vl_logic_vector(9 downto 0);
        vcount          : out    vl_logic_vector(9 downto 0);
        TFT_RGB         : out    vl_logic_vector(15 downto 0);
        TFT_HS          : out    vl_logic;
        TFT_VS          : out    vl_logic;
        TFT_CLK         : out    vl_logic;
        TFT_DE          : out    vl_logic;
        TFT_PWM         : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of TFT_HS_end : constant is 1;
    attribute mti_svvh_generic_type of hdat_begin : constant is 1;
    attribute mti_svvh_generic_type of hdat_end : constant is 1;
    attribute mti_svvh_generic_type of hpixel_end : constant is 1;
    attribute mti_svvh_generic_type of TFT_VS_end : constant is 1;
    attribute mti_svvh_generic_type of vdat_begin : constant is 1;
    attribute mti_svvh_generic_type of vdat_end : constant is 1;
    attribute mti_svvh_generic_type of vline_end : constant is 1;
end TFT_CTRL;
