/*

	display.svh - fsdblog format file

Note:
	1.   commented out cross coverage #78 ../sv/cpu_cover.sv since 2008.03 doesn't support the syntax
	2.   modified  ../sv/cpu_inst.sv for error output

*/
`define NOVAS_ERROR 1
`define NOVAS_NOTE 2
`define NOVAS_DEBUG 3
`define NOVAS_TRACE 4
`define NOVAS_VERBOSE 5
`define NOVAS_VERBOSE2 6 
`define NOVAS_VERBOSE3 7 //generated
`define NOVAS_VERBOSE4 8 //print coverage
`define NOVAS_VERBOSE5 9 //print instructions

//`define DISPLAY_FSDBLOG
`define FSDBLOG_ENABLE
//`define DEFAULT_FSDBLOG_NAME

`timescale 1 ns / 1ns

// add -in front of numbers for not output to fsdbLog
`define print_severity1 1
`define print_severity2 2
`define print_severity3 -3
`define print_severity4 4
`define print_severity5 -5
`define print_severity6 -6 
`define print_severity7 -7
`define print_severity8 8
`define print_severity9 -9 


`ifdef FSDBLOG_ENABLE
`define FSDBLOG(Label,Message,Severity,Stream_name,String) \
if( \
   (Severity == `print_severity1) ||  \
   (Severity == `print_severity2) ||  \
   (Severity == `print_severity3) ||  \
   (Severity == `print_severity4) ||  \
   (Severity == `print_severity5) ||  \
   (Severity == `print_severity6) ||  \
   (Severity == `print_severity7) ||  \
   (Severity == `print_severity8) ||  \
   (Severity == `print_severity9)) \
   begin \
   `ifdef DISPLAY_FSDBLOG \
   $display("label = ",Label,",msg=",Message,",sev=",Severity, ",sig=",Stream_name,",var= ",String); \
   `endif \
   `ifdef DEFAULT_FSDBLOG_NAME \
   $fsdbLog(Label,Message,Severity,,String); \
   `else \
   $fsdbLog(Label,Message,Severity,Stream_name,String); \
   `endif \
   end 
`else
`define FSDBLOG(Label,Message,Severity,Stream_name,String) 
`endif


`ifdef FSDBLOG_ENABLE
`define FSDBLOG0(Label,Message,Severity,Stream_name) \
if( \
   (Severity == `print_severity1) ||  \
   (Severity == `print_severity2) ||  \
   (Severity == `print_severity3) ||  \
   (Severity == `print_severity4) ||  \
   (Severity == `print_severity5) ||  \
   (Severity == `print_severity6) ||  \
   (Severity == `print_severity7) ||  \
   (Severity == `print_severity8) ||  \
   (Severity == `print_severity9)) \
   begin \
   `ifdef DISPLAY_FSDBLOG \
   $display($time, "label = ",Label,",msg=",Message,",sev=",Severity, ",sig=",Stream_name);\
   `endif \
   `ifdef DEFAULT_FSDBLOG_NAME \
   $fsdbLog(Label,Message,Severity,); \
   `else \
   $fsdbLog(Label,Message,Severity,Stream_name); \
   `endif \
   end 
`else
`define FSDBLOG0(Label,Message,Severity,Stream_name) 
`endif

`ifdef FSDBLOG_ENABLE
`define FSDBLOG1(Label,Message,Severity,Stream_name,Var1) \
if( \
   (Severity == `print_severity1) ||  \
   (Severity == `print_severity2) ||  \
   (Severity == `print_severity3) ||  \
   (Severity == `print_severity4) ||  \
   (Severity == `print_severity5) ||  \
   (Severity == `print_severity6) ||  \
   (Severity == `print_severity7) ||  \
   (Severity == `print_severity8) ||  \
   (Severity == `print_severity9)) \
   begin \
   `ifdef DISPLAY_FSDBLOG \
   $display("label = ",Label,",msg=",Message,",sev=",Severity, ",sig=",Stream_name,",var1= ",Var1); \
   `endif \
   `ifdef DEFAULT_FSDBLOG_NAME \
   $fsdbLog(Label,Message,Severity,,Var1); \
   `else \
   $fsdbLog(Label,Message,Severity,Stream_name,Var1); \
   `endif \
   end 
`else
`define FSDBLOG1(Label,Message,Severity,Stream_name,Var1) 
`endif

`ifdef FSDBLOG_ENABLE
`define FSDBLOG2(Label,Message,Severity,Stream_name,Var1,Var2) \
   if( \
   (Severity == `print_severity1) ||  \
   (Severity == `print_severity2) ||  \
   (Severity == `print_severity3) ||  \
   (Severity == `print_severity4) ||  \
   (Severity == `print_severity5) ||  \
   (Severity == `print_severity6) ||  \
   (Severity == `print_severity7) ||  \
   (Severity == `print_severity8) ||  \
   (Severity == `print_severity9)) \
   begin \
   `ifdef DISPLAY_FSDBLOG \
   $display("label = ",Label,",msg=",Message,",sev=",Severity, ",sig=",Stream_name,",var1= ",Var1,",var2=",Var2); \
   `endif \
   `ifdef DEFAULT_FSDBLOG_NAME \
   $fsdbLog(Label,Message,Severity,,Var1,Var2); \
   `else \
   $fsdbLog(Label,Message,Severity,Stream_name,Var1,Var2); \
   `endif \
   end 
`else
`define FSDBLOG2(Label,Message,Severity,Stream_name,Var1,Var2) 
`endif



//`timescale 1 ns / 1 ns

module fsdb;
initial
   begin
        // Simulation dump
        $fsdbDumpfile("novas.fsdb");
        $fsdbDumpvars("+all");
        $fsdbDumpvars("+class");
   end


endmodule


