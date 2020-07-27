#! /usr/bin/env wish
##-------------------------------------------------------------------------------
##                     Copyright 2019 Ken Campbell
##
##   Licensed under the Apache License, Version 2.0 (the "License");
##   you may not use this file except in compliance with the License.
##   You may obtain a copy of the License at
##
##     http://www.apache.org/licenses/LICENSE-2.0
##
##   Unless required by applicable law or agreed to in writing, software
##   distributed under the License is distributed on an "AS IS" BASIS,
##   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
##   See the License for the specific language governing permissions and
##   limitations under the License.
##-------------------------------------------------------------------------------
##-- $Author:  $ Ken Campbell
##--
##-- $Date:  $ April 2019
##--
##-- $Id:  $
##--
##-- $Source:  $
##--
##-- Description :
##--      This application takes a text file containing the definition of a Verilog
##           module, produces a file set for the SV Directed Test Bench.
##--      This file is the GUI items.
##------------------------------------------------------------------------------

## package requires
package require Ttk
package require Tk

## set the current version info
set version "Version 1.2"
## put up a title on the main window boarder
wm title . "SV TB Gen $version"

## the location of the template by default
set template "./tb_mod_template.sv"

set use_list 0

##  Working Directory or vhdl directory
set workd [frame .wdf]
set ent_lbl [label $workd.lbl1 -text "Top mod loc" -justify left]
set ent_dir [entry $workd.ent1]
button $workd.br0 -text "Browse" -command {fill_list}
pack $ent_lbl -side left
pack $workd.br0 -side right
pack $ent_dir -fill x
pack $workd -fill x -pady 6

##  Output directory
set tlist [frame .lstf]
set odir_lbl [label $tlist.lbl2 -text "Output loc" -justify left]
set odir [entry $tlist.ent2]
set lbut [button $tlist.br1 -text "Browse" -command {browsed_from_set $odir $odir}]
pack $odir_lbl -side left
pack $lbut -side right
pack $odir -fill x
pack $tlist -fill x

##  Template location
set tdirf [frame .tmpf]
set tdir_lbl [label $tdirf.lbl3 -text "Template loc" -justify left]
set tdir [entry $tdirf.ent3]
set tbut [button $tdirf.br2 -text "Browse" -command {browse_set_entry $tdir}]
pack $tdir_lbl -side left
pack $tbut -side right
pack $tdir -fill x
pack $tdirf -fill x -pady 6
$tdir delete 0 end
$tdir insert end $template
$tdir configure -state readonly

## type spec
set tsf [frame .tsfr]
set load_but [button $tsf.bt1 -text "Generate" -command ttb_gen]
## this button enables quicker development of the parser.  If 
set test_but [button $tsf.bt2 -text "Source" -command {source tb_gen_parser.tcl}]
set comb_vals {"No mod" "Gen mod"}
set comb_val "No mod"
set mo_sel [ttk::combobox $tsf.mode -textvariable comb_val -values $comb_vals -state readonly]
set gbatv 0
set cpakv 0
$mo_sel insert end "No mod"
$mo_sel insert end "Gen mod"
#"Gen mod"
set gen_prog 0.0
set p_view [ttk::progressbar $tsf.fb1 -variable gen_prog]
set statsVar ""
set stat_txt [label .lb1 -textvariable statsVar]

##   about button
button $tsf.bout1 -text "About" -command show_about

pack $mo_sel -side left
pack $load_but -side left -padx 20
pack $test_but -side left -padx 20
pack $p_view -side left
pack $tsf.bout1 -side right
pack $tsf -fill x
pack $stat_txt -fill x

## create paned window
set win [panedwindow .pw -width 200 -height 300 -orient horizontal]
pack $win -fill both -expand yes
set wtop [frame $win.wf1]
set wmid [frame $win.wf2]

$win add $wtop $wmid

## create two object boxes
set sel_lst {}
set m_select ""
set list_win [listbox $wtop.sb -listvariable sel_lst -height 16]
set list_ent [entry $wtop.lent -textvariable m_select]
set view_win [text $wmid.rts -borderwidth 2 -wrap none]
pack $list_win -fill both -expand yes
pack $list_ent -anchor s -fill x -expand yes
pack $view_win -fill both -expand yes

## tag for the view window
$view_win tag configure highlite -background grey80

###########################################################################
##  some debug and help procs
##    Message Error, terminate
proc msg_error { msg } {
  tk_messageBox -message $msg -type ok
  exit
}
###########################################################################
##  Message, continue
proc dbg_msg { msg } {
  tk_messageBox -message $msg -type ok
}
#########################################################################
##  browse and get directory
##    Using extfileselectiondialog get a directory and update the
##    field passed to it
proc browsed_from_set { src dest } {
    set wdir [$src get]
    #puts $wdir
    if {$wdir == ""} {
        set curd [pwd]
        #puts $curd
        set fn [tk_chooseDirectory -title "Choose a directory" -initialdir $curd]
    } else {
        set fn [tk_chooseDirectory -initialdir $wdir -title "Choose a directory"]
    }

  if {$fn != ""} {
      $dest configure -state normal
      $dest delete 0 end
      $dest insert 0 "$fn"
      $dest configure -state readonly
  }
  destroy .dsb
}
#########################################################################
##  browse and get file name
##    Using extfileselectiondialog get a directory and update the
##    field passed to it
proc browse_set_entry { dest } {
    set fn [tk_getOpenFile]

  if {$fn != ""} {
      $dest configure -state normal
      $dest delete 0 end
      $dest insert 0 "$fn"
      $dest configure -state readonly
  }
  destroy .dsb
}

##################################################
##  Now with the GUI set up, load the parser
source "tb_gen_parser.tcl"

## end ttb_gen
#################################################
##  show  about message
proc show_about {} {
    global version

		set msg "Copyright 2019 Ken Campbell\n
Version $version\n
Licensed under the Apache License, Version 2.0 (the \"License\"); You may not use this file except in compliance with the License. You may obtain a copy of the License at\n
http://www.apache.org/licenses/LICENSE-2.0\n
Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an \"AS IS\" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and limitations under the License."

    dbg_msg $msg
}

## enable pop up console for debug
bind . <F12> {catch {console show}}
bind  $list_win <<ListboxSelect>> {process_selected}
