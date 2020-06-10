$sn("load ../e/cpu_top;test")
$sn("sys.novas_sn.fsdbDumpfile("vcs_verilog.fsdb")")
$sn("sys.novas_sn.fsdbDumpvars(0,"sys")")
$sn("sys.novas_sn.fsdbTraceDriverLoad()")
$fsdbDumpfile("vcs_verilog.fsdb");
$fsdbDumpSVA;
$fsdbDumpvars(0, system, "+all");
continue
quit