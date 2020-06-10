## ****************************************************
## * Program : Verdi to SDC
## * Circuit : top
## * Date : Fri Nov 16 17:22:19 2007
## ****************************************************
##
##
## Constraint
##
create_clock [get_pins {{TX/tx_clk1}}]
create_clock [get_pins {{TX/tx_clk2}}]
create_clock [get_pins {{RX/rx_clk} {SYNC/sync_clk}}]
