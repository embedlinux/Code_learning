#!/bin/csh

set ScriptName=`basename $0`

if ( $#argv > 1 ) then 
    echo "Error: too many arguments!"
    echo ""
    echo "Example 1: $ScriptName"
    echo "Example 2: $ScriptName tb_assert_formal_pass_sim_wrapper"
    echo ""
    exit 1
endif

if ( $#argv == 1 ) then
    set TBENCH="$1"
else
    set TBENCH="tb_assert_simulation"; # Default
endif

#module load synopsys/vcs/2006.06

set LOG="log/${TBENCH}-VCS_SVA.log"
set VC="../${TBENCH}.vc"

# Backup old log
if ( -f ${LOG} ) then
     mv ${LOG} ${LOG}.BAK
endif

# Compile
vcs -R -f $VC -sverilog -assert enable_diag -debug_all +define+ASSERT_ON -l $LOG -assert quiet+maxfail=20

#
if ( ! -f simv ) then
    echo ""
    echo "ERROR: compile failed!"
    echo ""
    exit
endif

# Run simulation
#simv -l $LOG -assert quiet+maxfail=20

# Add contents header to log
#../../../bin/contents $LOG

# Tidy up
#/bin/rm -rf csrc core* simv* vcdplus* default.cfg* vcs.key
