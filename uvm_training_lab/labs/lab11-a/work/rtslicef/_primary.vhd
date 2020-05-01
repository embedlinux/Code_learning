library verilog;
use verilog.vl_types.all;
entity rtslicef is
    port(
        reset           : in     vl_logic;
        clock           : in     vl_logic;
        frame_n         : in     vl_logic;
        valid_n         : in     vl_logic;
        din             : in     vl_logic;
        iarbin          : in     vl_logic_vector(15 downto 0);
        arbout          : out    vl_logic_vector(15 downto 0);
        arbhead         : in     vl_logic;
        okstep          : out    vl_logic;
        dout            : out    vl_logic_vector(15 downto 0);
        busy_n          : out    vl_logic;
        valido_n        : out    vl_logic_vector(15 downto 0);
        frameo_n        : inout  vl_logic_vector(15 downto 0)
    );
end rtslicef;
