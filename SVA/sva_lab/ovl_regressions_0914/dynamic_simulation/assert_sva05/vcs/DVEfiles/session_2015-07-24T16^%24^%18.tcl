# Begin_DVE_Session_Save_Info
# DVE reload session
# Saved on Fri Jul 24 16:24:18 2015
# Designs open: 1
#   V1: /home/klin/assertion/ovl_regressions/dynamic_simulation/assert_sva05/vcs/dump.vcd
# Toplevel windows open: 1
# 	TopLevel.1
#   Source.1: 
#   Wave.1: 8 signals
#   Group count = 2
#   Group Group1 signal count = 8
#   Group _$$txp_fail_action_ovl_assert.A_ASSERT_WIN_UNCHANGE_XZ_ON_TEST_EXPR_P signal count = 0
# End_DVE_Session_Save_Info

# DVE version: G-2012.09
# DVE build date: Aug 24 2012 00:30:46


#<Session mode="Reload" path="/home/klin/assertion/ovl_regressions/dynamic_simulation/assert_sva05/vcs/DVEfiles/session.tcl" type="Debug">

gui_set_loading_session_type Reload
gui_continuetime_set

# Close design
if { [gui_sim_state -check active] } {
    gui_sim_terminate
}
gui_close_db -all
gui_expr_clear_all
gui_clear_window -type Wave
gui_clear_window -type List

# Application preferences
gui_set_pref_value -key app_default_font -value {Helvetica,10,-1,5,50,0,0,0,0,0}
gui_src_preferences -tabstop 8 -maxbits 24 -windownumber 1
#<WindowLayout>

# DVE Topleve session: 


# Create and position top-level windows :TopLevel.1

set TopLevel.1 TopLevel.1

# Docked window settings
set HSPane.1 HSPane.1
set Hier.1 Hier.1
set DLPane.1 DLPane.1
set Data.1 Data.1
set Console.1 Console.1
gui_sync_global -id ${TopLevel.1} -option true

# MDI window settings
set Source.1 Source.1
gui_update_layout -id ${Source.1} {{show_state maximized} {dock_state undocked} {dock_on_new_line false}}
set Wave.1 Wave.1
gui_update_layout -id ${Wave.1} {{show_state maximized} {dock_state undocked} {dock_on_new_line false} {child_wave_left 362} {child_wave_right 881} {child_wave_colname 260} {child_wave_colvalue 98} {child_wave_col1 0} {child_wave_col2 1}}

# End MDI window settings


#</WindowLayout>

#<Database>

# DVE Open design session: 

if { ![gui_is_db_opened -db {/home/klin/assertion/ovl_regressions/dynamic_simulation/assert_sva05/vcs/dump.vcd}] } {
	gui_open_db -design V1 -file /home/klin/assertion/ovl_regressions/dynamic_simulation/assert_sva05/vcs/dump.vcd -nosource
}
gui_set_precision 1ns
gui_set_time_units 1ns
#</Database>

# DVE Global setting session: 


# Global: Bus

# Global: Expressions

# Global: Signal Time Shift

# Global: Signal Compare

# Global: Signal Groups
gui_load_child_values {tb_assert_simulation.DUT.u_wuc_1}


set _session_group_1 Group1
gui_sg_create "$_session_group_1"
set Group1 "$_session_group_1"

gui_sg_addsignal -group "$_session_group_1" { tb_assert_simulation.DUT.u_wuc_1.clk tb_assert_simulation.DUT.u_wuc_1.reset_n tb_assert_simulation.DUT.u_wuc_1.start_event tb_assert_simulation.DUT.u_wuc_1.test_expr tb_assert_simulation.DUT.u_wuc_1.end_event tb_assert_simulation.DUT.u_wuc_1.error_count tb_assert_simulation.DUT.u_wuc_1.cover_count tb_assert_simulation.DUT.u_wuc_1.window }
gui_set_radix -radix {decimal} -signals {V1:tb_assert_simulation.DUT.u_wuc_1.error_count}
gui_set_radix -radix {twosComplement} -signals {V1:tb_assert_simulation.DUT.u_wuc_1.error_count}
gui_set_radix -radix {decimal} -signals {V1:tb_assert_simulation.DUT.u_wuc_1.cover_count}
gui_set_radix -radix {twosComplement} -signals {V1:tb_assert_simulation.DUT.u_wuc_1.cover_count}

set _session_group_2 {_$$txp_fail_action_ovl_assert.A_ASSERT_WIN_UNCHANGE_XZ_ON_TEST_EXPR_P}
gui_sg_create "$_session_group_2"
set {_$$txp_fail_action_ovl_assert.A_ASSERT_WIN_UNCHANGE_XZ_ON_TEST_EXPR_P} "$_session_group_2"


# Global: Highlighting

# Global: Stack
gui_change_stack_mode -mode list

# Post database loading setting...

# Restore C1 time
gui_set_time -C1_only 0



# Save global setting...

# Wave/List view global setting
gui_cov_show_value -switch false

# Close all empty TopLevel windows
foreach __top [gui_ekki_get_window_ids -type TopLevel] {
    if { [llength [gui_ekki_get_window_ids -parent $__top]] == 0} {
        gui_close_window -window $__top
    }
}
gui_set_loading_session_type noSession
# DVE View/pane content session: 


# Hier 'Hier.1'
gui_show_window -window ${Hier.1}
gui_list_set_filter -id ${Hier.1} -list { {Package 1} {All 0} {Process 1} {UnnamedProcess 1} {Function 1} {Block 1} {OVA Unit 1} {LeafScCell 1} {LeafVlgCell 1} {Interface 1} {PowSwitch 0} {LeafVhdCell 1} {$unit 1} {NamedBlock 1} {Task 1} {VlgPackage 1} {IsoCell 0} {ClassDef 1} }
gui_list_set_filter -id ${Hier.1} -text {*} -force
gui_change_design -id ${Hier.1} -design V1
catch {gui_list_expand -id ${Hier.1} tb_assert_simulation}
catch {gui_list_expand -id ${Hier.1} tb_assert_simulation.DUT}
catch {gui_list_select -id ${Hier.1} {tb_assert_simulation.DUT.u_nxt_1}}
gui_view_scroll -id ${Hier.1} -vertical -set 565
gui_view_scroll -id ${Hier.1} -horizontal -set 0

# Data 'Data.1'
gui_list_set_filter -id ${Data.1} -list { {Buffer 1} {Input 1} {Others 1} {Linkage 1} {Output 1} {LowPower 1} {Parameter 1} {All 1} {Aggregate 1} {Event 1} {Assertion 1} {Constant 1} {Interface 1} {Signal 1} {$unit 1} {Inout 1} {Variable 1} }
gui_list_set_filter -id ${Data.1} -text {*}
gui_list_show_data -id ${Data.1} {tb_assert_simulation.DUT.u_nxt_1}
gui_view_scroll -id ${Data.1} -vertical -set 0
gui_view_scroll -id ${Data.1} -horizontal -set 0
gui_view_scroll -id ${Hier.1} -vertical -set 565
gui_view_scroll -id ${Hier.1} -horizontal -set 0

# Source 'Source.1'
gui_src_value_annotate -id ${Source.1} -switch false
gui_set_env TOGGLE::VALUEANNOTATE 0
gui_view_scroll -id ${Source.1} -vertical -set 0
gui_src_set_reusable -id ${Source.1}

# View 'Wave.1'
gui_wv_sync -id ${Wave.1} -switch false
set groupExD [gui_get_pref_value -category Wave -key exclusiveSG]
gui_set_pref_value -category Wave -key exclusiveSG -value {false}
set origWaveHeight [gui_get_pref_value -category Wave -key waveRowHeight]
gui_list_set_height -id Wave -height 25
set origGroupCreationState [gui_list_create_group_when_add -wave]
gui_list_create_group_when_add -wave -disable
gui_wv_zoom_timerange -id ${Wave.1} 14833 18815
gui_list_add_group -id ${Wave.1} -after {New Group} {Group1}
gui_list_add_group -id ${Wave.1} -after {New Group} {{_$$txp_fail_action_ovl_assert.A_ASSERT_WIN_UNCHANGE_XZ_ON_TEST_EXPR_P}}
gui_seek_criteria -id ${Wave.1} {Any Edge}



gui_set_env TOGGLE::DEFAULT_WAVE_WINDOW ${Wave.1}
gui_set_pref_value -category Wave -key exclusiveSG -value $groupExD
gui_list_set_height -id Wave -height $origWaveHeight
if {$origGroupCreationState} {
	gui_list_create_group_when_add -wave -enable
}
if { $groupExD } {
 gui_msg_report -code DVWW028
}
gui_list_set_filter -id ${Wave.1} -list { {Buffer 1} {Input 1} {Others 1} {Linkage 1} {Output 1} {Parameter 1} {All 1} {Aggregate 1} {Event 1} {Assertion 1} {Constant 1} {Interface 1} {Signal 1} {$unit 1} {Inout 1} {Variable 1} }
gui_list_set_filter -id ${Wave.1} -text {*}
gui_list_set_insertion_bar  -id ${Wave.1} -group {_$$txp_fail_action_ovl_assert.A_ASSERT_WIN_UNCHANGE_XZ_ON_TEST_EXPR_P}  -position in

gui_marker_move -id ${Wave.1} {C1} 0
gui_view_scroll -id ${Wave.1} -vertical -set 0
gui_show_grid -id ${Wave.1} -enable false
# Restore toplevel window zorder
# The toplevel window could be closed if it has no view/pane
if {[gui_exist_window -window ${TopLevel.1}]} {
	gui_set_active_window -window ${TopLevel.1}
	gui_set_active_window -window ${Wave.1}
	gui_set_active_window -window ${HSPane.1}
}
#</Session>

