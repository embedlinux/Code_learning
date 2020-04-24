library verilog;
use verilog.vl_types.all;
entity router is
    port(
        reset_n         : in     vl_logic;
        clock           : in     vl_logic;
        frame_n         : in     vl_logic_vector(15 downto 0);
        valid_n         : in     vl_logic_vector(15 downto 0);
        din             : in     vl_logic_vector(15 downto 0);
        dout            : out    vl_logic_vector(15 downto 0);
        busy_n          : out    vl_logic_vector(15 downto 0);
        valido_n        : out    vl_logic_vector(15 downto 0);
        frameo_n        : out    vl_logic_vector(15 downto 0)
    );
end router;
