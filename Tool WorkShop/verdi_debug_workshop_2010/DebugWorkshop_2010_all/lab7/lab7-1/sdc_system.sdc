create_clock -period 30 -waveform {0 15} [get_ports {clock}]
create_clock -period 30 -waveform {0 15}  \
[list [get_ports {R_W}] [get_ports {reset}]]
create_clock -name "CLKA" [get_ports {VMA}]
create_generated_clock -name "i_cpu/i_CCU/C6_reg/Q" \
-source [get_ports {VMA}] \
-divide_by 2 [get_pins {i_cpu/i_CCU/C6_reg/Q}]
set_logic_zero [get_ports {reset}]
create_clock -period 30 -waveform {0 15} 
