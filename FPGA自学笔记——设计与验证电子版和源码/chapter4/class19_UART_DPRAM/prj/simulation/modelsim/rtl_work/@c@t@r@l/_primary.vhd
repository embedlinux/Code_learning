library verilog;
use verilog.vl_types.all;
entity CTRL is
    port(
        Clk             : in     vl_logic;
        Rst_n           : in     vl_logic;
        Key_flag        : in     vl_logic;
        Key_state       : in     vl_logic;
        Rx_Done         : in     vl_logic;
        Tx_Done         : in     vl_logic;
        rdaddress       : out    vl_logic_vector(7 downto 0);
        wraddress       : out    vl_logic_vector(7 downto 0);
        wren            : out    vl_logic;
        Send_en         : out    vl_logic
    );
end CTRL;
