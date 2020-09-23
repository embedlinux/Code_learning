library verilog;
use verilog.vl_types.all;
entity I2C is
    generic(
        SYS_CLOCK       : integer := 50000000;
        SCL_CLOCK       : integer := 400000
    );
    port(
        Clk             : in     vl_logic;
        Rst_n           : in     vl_logic;
        Rddata_num      : in     vl_logic_vector(5 downto 0);
        Wrdata_num      : in     vl_logic_vector(5 downto 0);
        Wdaddr_num      : in     vl_logic_vector(1 downto 0);
        Device_addr     : in     vl_logic_vector(2 downto 0);
        Word_addr       : in     vl_logic_vector(15 downto 0);
        Wr              : in     vl_logic;
        Wr_data         : in     vl_logic_vector(7 downto 0);
        Wr_data_vaild   : out    vl_logic;
        Rd              : in     vl_logic;
        Rd_data         : out    vl_logic_vector(7 downto 0);
        Rd_data_vaild   : out    vl_logic;
        Scl             : out    vl_logic;
        Sda             : inout  vl_logic;
        Done            : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of SYS_CLOCK : constant is 1;
    attribute mti_svvh_generic_type of SCL_CLOCK : constant is 1;
end I2C;
