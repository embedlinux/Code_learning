// Need following to dump all internal signals
+access+r
//
// Point to Verdi & Debussy PLI - $LD_LIBRARY_PATH has to be set.  Look in setup.ncverilog, which is sourced
+ncloadpli1=debpli:deb_PLIPtr
//
+incdir+src
src/tb_CPUsystem.v
src/CPUsystem.v
src/CPU.v 
src/ALUB.v 
src/CCU.v 
src/PCU.v 
src/alu.v 
src/maprom.v
src/pram.v
src/microrom.v
src/BJkernel.v
src/BJsource.v
