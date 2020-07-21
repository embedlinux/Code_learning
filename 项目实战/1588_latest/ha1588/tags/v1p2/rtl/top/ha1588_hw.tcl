# TCL File Generated by Component Editor 10.1sp1
# Sat Mar 31 21:26:56 CST 2012
# DO NOT MODIFY


# +-----------------------------------
# | 
# | ha1588 "Hardware Assisted IEEE 1588 IP Core" v1.0
# | BABY&HW 2012.03.31.21:26:56
# | Hardware Assisted IEEE 1588 IP Core
# | 
# | ha1588.v
# | 
# |    ../../rtl/top/ha1588.v syn, sim
# |    ../../rtl/reg/reg.v syn, sim
# |    ../../rtl/rtc/rtc.v syn, sim
# |    ../../rtl/tsu/tsu.v syn, sim
# |    ../../rtl/tsu/ptp_parser.v syn, sim
# |    ../../rtl/tsu/ptp_queue.v syn, sim
# | 
# +-----------------------------------

# +-----------------------------------
# | request TCL package from ACDS 10.1
# | 
package require -exact sopc 10.1
# | 
# +-----------------------------------

# +-----------------------------------
# | module ha1588
# | 
set_module_property DESCRIPTION "Hardware Assisted IEEE 1588 IP Core"
set_module_property NAME ha1588
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR "BABY&HW"
set_module_property DISPLAY_NAME "Hardware Assisted IEEE 1588 IP Core"
set_module_property TOP_LEVEL_HDL_FILE ha1588.v
set_module_property TOP_LEVEL_HDL_MODULE ha1588
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property ANALYZE_HDL TRUE
# | 
# +-----------------------------------

# +-----------------------------------
# | files
# | 
add_file ../../rtl/top/ha1588.v {SYNTHESIS SIMULATION}
add_file ../../rtl/reg/reg.v {SYNTHESIS SIMULATION}
add_file ../../rtl/rtc/rtc.v {SYNTHESIS SIMULATION}
add_file ../../rtl/tsu/tsu.v {SYNTHESIS SIMULATION}
add_file ../../rtl/tsu/ptp_parser.v {SYNTHESIS SIMULATION}
add_file ../../rtl/tsu/ptp_queue.v {SYNTHESIS SIMULATION}
# | 
# +-----------------------------------

# +-----------------------------------
# | parameters
# | 
add_parameter addr_is_in_word BOOLEAN true ""
set_parameter_property addr_is_in_word DEFAULT_VALUE true
set_parameter_property addr_is_in_word DISPLAY_NAME addr_is_in_word
set_parameter_property addr_is_in_word WIDTH ""
set_parameter_property addr_is_in_word TYPE BOOLEAN
set_parameter_property addr_is_in_word ENABLED false
set_parameter_property addr_is_in_word UNITS None
set_parameter_property addr_is_in_word DESCRIPTION ""
set_parameter_property addr_is_in_word AFFECTS_GENERATION false
set_parameter_property addr_is_in_word HDL_PARAMETER true
# | 
# +-----------------------------------

# +-----------------------------------
# | display items
# | 
# | 
# +-----------------------------------

# +-----------------------------------
# | connection point clock
# | 
add_interface clock clock end
set_interface_property clock clockRate 0

set_interface_property clock ENABLED true

add_interface_port clock clk clk Input 1
add_interface_port clock rst reset Input 1
# | 
# +-----------------------------------

# +-----------------------------------
# | connection point avalon_slave
# | 
add_interface avalon_slave avalon end
set_interface_property avalon_slave addressAlignment DYNAMIC
set_interface_property avalon_slave addressUnits WORDS
set_interface_property avalon_slave associatedClock clock
set_interface_property avalon_slave burstOnBurstBoundariesOnly false
set_interface_property avalon_slave explicitAddressSpan 0
set_interface_property avalon_slave holdTime 0
set_interface_property avalon_slave isMemoryDevice false
set_interface_property avalon_slave isNonVolatileStorage false
set_interface_property avalon_slave linewrapBursts false
set_interface_property avalon_slave maximumPendingReadTransactions 0
set_interface_property avalon_slave printableDevice false
set_interface_property avalon_slave readLatency 0
set_interface_property avalon_slave readWaitTime 1
set_interface_property avalon_slave setupTime 0
set_interface_property avalon_slave timingUnits Cycles
set_interface_property avalon_slave writeWaitTime 0

set_interface_property avalon_slave ENABLED true

add_interface_port avalon_slave wr_in write Input 1
add_interface_port avalon_slave rd_in read Input 1
add_interface_port avalon_slave addr_in address Input 8
add_interface_port avalon_slave data_in writedata Input 32
add_interface_port avalon_slave data_out readdata Output 32
# | 
# +-----------------------------------

# +-----------------------------------
# | connection point ref_clock
# | 
add_interface ref_clock conduit end

set_interface_property ref_clock ENABLED true

add_interface_port ref_clock rtc_clk export Input 1
add_interface_port ref_clock rtc_time_ptp_ns export Output 32
add_interface_port ref_clock rtc_time_ptp_sec export Output 48
# | 
# +-----------------------------------

# +-----------------------------------
# | connection point gmii_monitor
# | 
add_interface gmii_monitor conduit end

set_interface_property gmii_monitor ENABLED true

add_interface_port gmii_monitor rx_gmii_clk export Input 1
add_interface_port gmii_monitor rx_gmii_ctrl export Input 1
add_interface_port gmii_monitor rx_gmii_data export Input 8
add_interface_port gmii_monitor tx_gmii_clk export Input 1
add_interface_port gmii_monitor tx_gmii_ctrl export Input 1
add_interface_port gmii_monitor tx_gmii_data export Input 8
# | 
# +-----------------------------------
