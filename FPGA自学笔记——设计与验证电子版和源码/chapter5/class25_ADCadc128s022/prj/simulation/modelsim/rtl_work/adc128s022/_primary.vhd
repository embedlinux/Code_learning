library verilog;
use verilog.vl_types.all;
entity adc128s022 is
    port(
        Clk             : in     vl_logic;
        Rst_n           : in     vl_logic;
        Channel         : in     vl_logic_vector(2 downto 0);
        Data            : out    vl_logic_vector(11 downto 0);
        En_Conv         : in     vl_logic;
        Conv_Done       : out    vl_logic;
        ADC_State       : out    vl_logic;
        DIV_PARAM       : in     vl_logic_vector(7 downto 0);
        ADC_SCLK        : out    vl_logic;
        ADC_DOUT        : in     vl_logic;
        ADC_DIN         : out    vl_logic;
        ADC_CS_N        : out    vl_logic
    );
end adc128s022;
