library verilog;
use verilog.vl_types.all;
entity ff_rcv_fcs_4b is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        en              : in     vl_logic;
        d               : in     vl_logic_vector(3 downto 0);
        fok             : out    vl_logic
    );
end ff_rcv_fcs_4b;
