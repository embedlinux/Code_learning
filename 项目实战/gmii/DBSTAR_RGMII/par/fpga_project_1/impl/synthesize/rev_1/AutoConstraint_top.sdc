
#Begin clock constraint
define_clock -name {top|clk} {p:top|clk} -period 3.330 -clockgroup Autoconstr_clkgroup_0 -rise 0.000 -fall 1.665 -route 0.000 
#End clock constraint

#Begin clock constraint
define_clock -name {GW_PLL|clkout_inferred_clock} {n:GW_PLL|clkout_inferred_clock} -period 3.533 -clockgroup Autoconstr_clkgroup_1 -rise 0.000 -fall 1.766 -route 0.000 
#End clock constraint

#Begin clock constraint
define_clock -name {top|rx_clk} {p:top|rx_clk} -period 1.131 -clockgroup Autoconstr_clkgroup_2 -rise 0.000 -fall 0.566 -route 0.000 
#End clock constraint
