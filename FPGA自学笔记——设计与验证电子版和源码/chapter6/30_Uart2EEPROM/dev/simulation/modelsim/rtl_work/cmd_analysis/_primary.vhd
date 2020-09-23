library verilog;
use verilog.vl_types.all;
entity cmd_analysis is
    port(
        Clk             : in     vl_logic;
        Rst_n           : in     vl_logic;
        Rx_done         : in     vl_logic;
        Rx_data         : in     vl_logic_vector(7 downto 0);
        Wfifo_req       : out    vl_logic;
        Wfifo_data      : out    vl_logic_vector(7 downto 0);
        Rddata_num      : out    vl_logic_vector(5 downto 0);
        Wrdata_num      : out    vl_logic_vector(5 downto 0);
        Wdaddr_num      : out    vl_logic_vector(1 downto 0);
        Device_addr     : out    vl_logic_vector(2 downto 0);
        Word_addr       : out    vl_logic_vector(15 downto 0);
        Rd              : out    vl_logic
    );
end cmd_analysis;
