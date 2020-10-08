library verilog;
use verilog.vl_types.all;
entity ff_rcv_crc_tb is
    generic(
        test_data1      : integer := 52;
        test_data2      : integer := 175;
        test_data3      : integer := 33
    );
end ff_rcv_crc_tb;
