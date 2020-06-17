# SYNOPSYS synthesis environement
setenv SYNOPSYS /tools/2001.08-SP1
setenv SNPS $SYNOPSYS
set ARCH='sparcOS5'

# aliases
alias design_analyzer "$SYNOPSYS/$ARCH/syn/bin/design_analyzer&"
alias dc_shell "$SYNOPSYS/$ARCH/syn/bin/dc_shell"
alias iview "$SYNOPSYS/sold &"
alias sold "$SYNOPSYS/sold &"

setenv MANPATH /usr/man:/usr/local/man:$SYNOPSYS/doc/syn/man:$SYNOPSYS/doc/sim/man

#
set path = ($path  $SYNOPSYS/$ARCH/syn/bin /tools/2002.03-FM/sparcOS5/fm/bin)

setenv SNPSLMD_LICENSE_FILE 27000@marlboro-trn
