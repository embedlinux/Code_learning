2008-01-17 jmw:  ReadMe for Lab26 Step 7 netlists
           synthesized for complete full-duplex class
           project.

The Simple netlist of the lab exercise will not
simulate correctly, because of hold violations.

To show a working implementation, the Netlists/*AllHold*
files were synthesized with a set_fix_hold constraint on
all design clocks.   This synthesis took about 200 times
as long as the Simple one.   The hierarchical netlist
simulated, but the incremental flat one, with or
without SDF, did not.  A full flat synthesis with
fix_hold was not attempted, because of time limitations.

Because the hold times in the DesDecoder are the
primary problem, a second set of netlist files
named *DesDecHold* were synthesized.   This took
about 20 times as long as synthesis of the Simple one.
The resulting hierarchical netlist simulated, but the
incremental flat netlist, with or without SDF, again
did not.

Finally, the *AllHoldAbort* files were created by
using a hold fix for all clocks, but aborting
synthesis (cntrl-C) about 10 minutes after the start
of Design Rule Fixing.   When the DC text menu appeared,
the optimization was aborted, and the netlist was
written automatically, in its current state.
Although of poorer quality, the resulting hierarchical
netlist simulated usably.
