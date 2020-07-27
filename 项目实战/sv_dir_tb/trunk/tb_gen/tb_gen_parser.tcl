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
##-- $Date:  $ April 2019
##-- $Id:  $
##-- $Source:  $
##-- Description :
##--      This application takes a text file containing the definition of a Verilog
##--         module, produces a file set for the SV Directed Test Bench.
##--      This file is the parser and generator.
##--         The parser is a simple one, in that it is not able to provide reliable
##--         code generation for all possible syntax.  It is intended that it will
##--         generate good code if the module I/O are defined like shown in the examples.
##--
##--         If you intend to generate many TB, and this parser is not quite what you
##--         need, feel free to modify it for your needs.  There are ample comments
##--         and left over puts statements that should help with any efforts to 
##--         modify the parser.
##------------------------------------------------------------------------------

#################################################################
##  parse out the pin definitions from the list of raw pins text from the module.
##    input :  list of strings containing pin definitions.
##    output :  list of list of pin properties.
##           three lists are output, each designed to provide information for
##           the generation process.  
proc pars_pindef { pins } {
    set pdef  {}
    set def_lst  {}
    set lc 0

    set logic_lst {}
    set dut_modport {}
    set names_lst {}

    foreach l $pins {
        set is_mult [string first "," $l]
        set is_bv   [string first "\[" $l]
        set l [string trim $l "\;"]
        #puts $l
        #handle precompile
        set ispre [string first "`" $l]
        if {$ispre >= 0} {
            if {[string first "timescale" $l] >= 0} {
                continue
            }
            lappend names_lst $l
            lappend logic_lst $l
            lappend dut_modport $l
            continue
        }
        ##  if is a vector def
        #puts "is_bv:  $is_bv"
        if {$is_bv > 0} {
            
            set is_cbv [string last "\]" $l]
            set bv_spec [string range $l $is_bv $is_cbv]
            set type [string range $l 0 $is_bv-1]
            set names [string range $l $is_cbv+1 end]
            set snames [split $names ","]
            foreach n $snames {
                #puts $n
                set sn [string trim $n]
                if {$sn == ""} {
                    break
                }
                lappend names_lst [string trim $n]
                if {$type != "inout"} {
                    set tmp "logic "
                } else {
                    set tmp "wire "
                }
                append tmp $bv_spec " [string trim $n]\;"
                lappend logic_lst $tmp
                set tmp [string trim $type]
                append tmp " [string trim $n],"
                lappend dut_modport $tmp
            }
        } else {
            #puts $l
            set sl [split $l ","]
            set frst [split [lindex $sl 0]]
            set type [string trim [lindex $frst 0]]
            ## get the pin type from the def.
            set tmp ""
            foreach pt [lrange $frst 1 end] {
                if {$pt != ""} {
                    if {$pt == "var"} {
                        set tmp "$pt "
                    }  else {
                        append tmp $pt
                        set pin_type $tmp
                        break
                    }
                }
            }
            #puts $pin_type
            set fname [string trim [lindex $frst end]]
            set sl [lrange $sl 1 end]
            lappend names_lst [string trim $fname]
            if {$type != "inout"} {
                set tmp "$pin_type "
            } else {
                set tmp "wire "
            }
            #set tmp "logic "
            append tmp "$fname\;"
            lappend logic_lst $tmp
            set tmp $type
            append tmp " $fname,"
            lappend dut_modport $tmp
            foreach n $sl {
                if {$n == ""} {
                    continue
                }
                #puts $n
                lappend names_lst [string trim $n]
                if {$type != "inout"} {
                    set tmp "logic "
                } else {
                    set tmp "wire "
                }
                append tmp "[string trim $n]\;"
                lappend logic_lst $tmp
                set tmp $type
                append tmp " [string trim $n],"
                lappend dut_modport $tmp
            }
        }
    }

    lappend def_lst $logic_lst
    lappend def_lst $dut_modport
    lappend def_lst $names_lst

    return $def_lst
}
##  end pars_pindef

##-------------------------------------------------------------------------------
##  pars parameters 
proc pars_params {plst} {
    set rtn {}
    foreach p $plst {
        set sp [split [string trim $p ","] " "]
        set tmp [lindex $sp 1]
        lappend tmp [lindex $sp end]
        lappend rtn $tmp
    }
    return $rtn
}
##  end  pars_params
##--------------------------------------------------------------------------------
##  Write header to file passed
##    if you intend to use this tool many times and it matters
##    mod this section to output the header as required.
proc write_header { handle } {
    global version
    ##global scan_date
    set raw_date [clock scan now]
    set scan_date [clock format $raw_date -format "%d %b %Y %T"]

    ## so CVS will not modify selections, they have to be chopped up
    set auth "// \$Auth"
    append auth "or:  \$"

    puts $handle "///////////////////////////////////////////////////////////////////////////////"
    puts $handle "//             Copyright ///////////////////////////////////"
    puts $handle "//                        All Rights Reserved"
    puts $handle "///////////////////////////////////////////////////////////////////////////////"
    puts $handle "$auth"
    puts $handle "//"
    puts $handle "//"
    puts $handle "// Description :"
    puts $handle "//          This file was generated by SV TB Gen $version"
    puts $handle "//            on $scan_date"
    puts $handle "//////////////////////////////////////////////////////////////////////////////"
    puts $handle "// This software contains concepts confidential to ////////////////"
    puts $handle "// /////////. and is only made available within the terms of a written"
    puts $handle "// agreement."
    puts $handle "///////////////////////////////////////////////////////////////////////////////"
    puts $handle ""
  }

#####################################################################
##  A directory has been selected now fill the list win with *V files
proc fill_list {} {
    global ent_dir odir
    global use_list list_win ts_ent statsVar
    global view_win mo_sel sel_lst list_ent

    ## get the user selection
    browsed_from_set $ent_dir $ent_dir
    ## as a default make output dir = input dir
    set tmp_dir [$ent_dir get]
    $odir delete 0 end
    $odir insert end $tmp_dir
    $odir configure -state readonly

    ## clear the list window and selection
    $list_win delete 0 end
    $list_ent delete 0 end
    #$list_win clear selection
    $view_win delet 0.0 end
    ## get the working directory
    set dir [$ent_dir get]
    ## get the list of SV & v files in working directory
    set ftype ".*v"
    set file_lst ""
    set are_files [catch {glob -directory $dir *$ftype} rtn_code]
    if {$are_files == 0} {
        set file_lst [glob -directory $dir *$ftype]
    } else {
        return
    }
    #puts $file_lst
    ##  for each of the files in the file_lst
    foreach l $file_lst {
        ## creat string that is just the file name: no path
        #puts "File : $l"
        set testt $l
        set nstart [string last "/" $l]
        incr nstart
        #puts "Index : $nstart"
        set name_str [string range $l $nstart end]
        set sel_lst [lappend sel_lst $name_str]
        #puts $sel_lst
    }
}

######################################################################
##   click on the  listbox  process it.
proc process_selected {} {
    global list_win m_select
    
    set sz [$list_win size]
    #puts $sz
    if {$sz > 0} {
        set sel_dx [$list_win curselection]
        set m_select [$list_win get $sel_dx]
        load_ent_file
    } else {
    }
}

######################################################################
##  load the vhdl file that has just been selected from list_win
proc load_ent_file {} {
    global ent_dir list_win view_win statsVar gen_prog

    set gen_prog 0.0
    ## update selection with selected item
    set sel_dx [$list_win curselection]
    if {$sel_dx == ""} {
        return
    }
    ## recover the selected item
    set ln [$list_win get $sel_dx]
    ##  Get the working directory
    #puts $ln
    set lp [$ent_dir get]
    ##  append the file name
    append lp "/" $ln
    ## if the file does not exist  return
    set fexist [file exist $lp]
    if {$fexist == 0} {
        return
    }
    set ent_file [open $lp r]
    ## clear the view_win
    $view_win delete 1.0 end
    set file_list {}
    ## load file to memory
    while {![eof $ent_file]} {
        ##  Get a line
        set rline [gets $ent_file]
        lappend file_list $rline
    }
    close $ent_file
    ## put file in text window and highlite the module part
    set ent_found 0
    set in_ent 0
    set statsVar ""
    foreach l $file_list {
        if {$in_ent == 0} {
            set ent_def [string first module $l]
            ## Make crazy assumption the module def is in the first few chars.
            if {$ent_def >= 0 && $ent_def <= 6} {
                set ent_name [lindex $l 1]
                set statsVar "Module:  $ent_name found"
                set ent_found 1
                set in_ent 1
                $view_win insert end "$l\n" highlite
            } else {
                $view_win insert end "$l\n"
            }
        } else {
            set ent_def [string first "endmodule" $l]
            if {$ent_def >= 0} {
                set end_name [lindex $l 1]
                set end_found 1
                set in_ent 0
                $view_win insert end "$l\n" highlite
            } else {
                $view_win insert end "$l\n" highlite
            }
        }
    }
    if {$ent_found == 0} {
        set statsVar "No Module found!!"
    }
}

#########################################################################
##  The main generator proc
proc ttb_gen {} {
    global mo_sel template ent_dir list_win odir p_view tdir
    global cpakv gbatv gen_prog comb_val m_select

    set template [$tdir get]

    $p_view configure -maximum 7
    set gen_prog 1.0
    ## recover the selected item
    set ln $m_select
    ##  Get the working directory
    #puts $ln
    set lp [$ent_dir get]
    ##  append the file name
    append lp "/" $ln

    set path_text $lp
    set destin_text [$odir get]
    set infile [open $path_text r]
    set file_list {}

    set bl_comm 0;   ##  block comment indication.
##################################################################
##  Read in the file and strip comments as we do
    while {![eof $infile]} {
        ##  Get a line
        set rline [gets $infile]
        #puts $rline
        ## get rid of white space
        set rline [string trim $rline]
        ##  Find comment if there
        set cindex [string first "//" $rline]
        ##  Block comments.
        set bcomm_s [string first "/*" $rline]
        set bcomm_e [string first "*/" $rline]
        ##  this will break if  block start  after some code ...
        if {$bcomm_s >= 0} {
            set bl_comm 1
            continue
        }
        if {$bcomm_s == 1} {
            if {$bcomm_e >= 0} {
                set bl_comm 0
            }
            continue
        }
        ## if a comment was found at the start of the line
        if {$cindex == 0 || $rline == ""} {
            continue
        ## else if comment somewhere in the line
        } elseif {$cindex > 0} {
            #  get rid of trailing comments and trim off spaces
            set rline [string trim [string range $rline 0 $cindex-1]]
            lappend file_list $rline
        ## else was not found so put line in list
        } else {
            lappend file_list $rline
        }
    }
    close $infile


    #foreach l $file_list {
    #    puts $l
    #}
    #return

    #$p_view step
    ## check for the module def
    set mod_name ""
    foreach l $file_list {
        set mod_def [string first module $l]
        if {$mod_def >= 0} {
            set ml [split $l]
            set mod_name [lindex $l 1]
            break
        }
    }

    #puts "Module name is: $mod_name"
    ## if no ent  die
    if {$mod_def < 0} {
        dbg_msg "A module definition was not found in the file provided."
        return
        ##  exit
    }
    #$p_view step
    set mod_list {}
    ## check for end module
    foreach l $file_list {
        lappend mod_list $l
        set end_def [string first endmodule $l]
        if {$end_def >= 0} {
            break
        }
    }
    ## if no end die
    if {$end_def < 0} {
        dbg_msg "no endmodule statement found for this module"
        return
        ##  exit
    }
    ####
    ## collect the parameters if there are.
    set parameter_list {}
    set p_found 0
    foreach l $mod_list {
        set p_found [string first "parameter" $l]
        if {$p_found >= 0} {
            lappend parameter_list $l
        }
    }
    #foreach pl $parameter_list {
    #    puts $pl
    #}
    ##  inc the progress bar
    set gen_prog 2.0
    #foreach l $mod_list {
    #    puts $l
    #}
    ####################################################################
    ##  a few checks have been done, and non-relevant stuff stripped off.
    ##  now create an arrry of just the pin names and related info
    set port_lst {}
    set import_lst {}
    set lc 0
    foreach l $mod_list {
        ## make lines that are continued, one line.
        set cont [string first "\;" $l]
        ## look for the port statements
        set inp [string first "input " $l]
        if {$inp >= 0} {
            lappend port_lst $l
        }
        set onp [string first "output " $l]
        if {$onp >= 0} {
            lappend port_lst $l
        }
        set ionp [string first "inout " $l]
        if {$ionp >= 0} {
            lappend port_lst $l
        }
        set tick_dir [string first "`" $l]
        if {$tick_dir >= 0} {
            lappend port_lst $l
        }
        set is_import [string first "import" $l]
        if {$is_import >= 0} {
            lappend import_lst $l
        }
        set end_pins [string first "\)\;" $l]
        set end_len [string length $l]
        if {$end_pins >= 0 && $end_len >= 2} {
            set stl [string trim $l "\)\;"]
            if {$stl != ""} {
                lappend port_lst $l
            }
            break
        }
    }

    #foreach p $port_lst {
    #    puts $p
    #}
    #return
    ##  Change the port list into a pin info list of lists
    set io_pins [pars_pindef $port_lst]
    ##  get the lists
    set log_lst [lindex $io_pins 0]
    set mod_lst [lindex $io_pins 1]
    set name_lst [lindex $io_pins 2]

    #foreach r $log_lst {
    #    puts $r
    #}
    #foreach r $mod_lst {
    #    puts $r
    #}
    #foreach r $name_lst {
    #    puts $r
    #}
    #return
    ##########################################
    ##  if there are parameters.
    if {[llength $parameter_list] > 0} {
        set param_lst [pars_params $parameter_list]
    }

    #foreach l $param_lst {
    #    puts $l
    #}

    # dbg_msg $split_pin
    ## calculate the longest pin name in characters
    set name_length 0
    foreach l $name_lst {
        set temp_length [string length $l]
        if {$temp_length > $name_length} {
            set name_length $temp_length
        }
    }
    #dbg_msg $name_length
    ##  Make the name length one bigger
    incr name_length

    ##  inc the progress bar
    set gen_prog 3.0
#########################################################################
## Generate the tb top.
    set tfn $destin_text
    append tfn "/tb_top.sv"
    set tfh [open $tfn w]

    write_header $tfh
    puts $tfh "`include \"../sv/tb_mod.sv\""
    puts $tfh ""
    puts $tfh "module tb_top \(\)\;"
    puts $tfh ""
    puts $tfh "  string STM_FILE = \"../stm/stimulus_file.stm\"\;"
    puts $tfh "  string tmp_fn;"
    puts $tfh ""
    puts $tfh "  //  Handle plus args"
    puts $tfh "  initial begin : file_select"
    puts $tfh "    if\(\$value\$plusargs\(\"STM_FILE=%s\", tmp_fn\)\) begin"
    puts $tfh "      STM_FILE = tmp_fn\;"
    puts $tfh "    end"
    puts $tfh "  end"
    puts $tfh ""
    puts $tfh "  dut_if theif\(\)\;"
    puts $tfh ""
    ## handle parameters.
    if {[llength $param_lst] == 0} {
        puts $tfh "  $mod_name u1 \("
    } else {
        puts $tfh "  $mod_name"
        puts $tfh "  \#\("
        set llen [llength $param_lst]
        set idx 1
        foreach p $param_lst {
            set tmp "    .[lindex $p 0]\("
            if {$idx < $llen} {
                append tmp "[lindex $p 1]\),"
            } else {
                append tmp "[lindex $p 1]\)"
            }
            puts $tfh $tmp
            incr idx
        }
         puts $tfh "  \) u1 \("
    }

    set llen [llength $name_lst]
    set idx 1
    foreach n $name_lst {
        set ln $n
        set tick_dir [string first "`" $n]
        if {$tick_dir >= 0} {
            puts $tfh "    $n"
            incr idx
            continue
        }
        set len [string length $ln]
        while {$len < $name_length} {
            append ln " "
            set len [string length $ln]
        }
        if {$idx < $llen} {
            puts $tfh "    .$ln \(theif.$n\),"
        } else {
            puts $tfh "    .$ln \(theif.$n\)"
        }
        incr idx
    }

    puts $tfh "  \)\;"
    puts $tfh ""
    puts $tfh "  tb_mod prg_inst\(theif\)\;"
    puts $tfh ""
    puts $tfh "endmodule"

    close $tfh
    ##  inc the progress bar
    set gen_prog 4.0
############################################################################
##  generate the interface file.
    set ifn $destin_text
    append ifn "/dut_if.sv"
    set ifh [open $ifn w]

    write_header $ifh
    ##  handle the parameters.
    if {[llength $param_lst] == 0} {
        puts $ifh "interface dut_if\(\)\;"
    } else {
        puts $tfh "  $mod_name"
        puts $tfh "  \#\("
        set llen [llength $param_lst]
        set idx 1
        foreach p $param_lst {
            set tmp "    [lindex $p 0] = "
            if {$idx < $llen} {
                append tmp "[lindex $p 1],"
            } else {
                append tmp "[lindex $p 1]"
            }
            puts $tfh $tmp
            incr idx
        }
         puts $tfh "  \)\(\)\;"
    }
    puts $ifh ""
    foreach i $import_lst {
        puts $ifh "  $i"
    }
    puts $ifh ""
    foreach l $log_lst {
        puts $ifh "  $l"
    }

    puts $ifh ""
    puts $ifh "  modport dut_conn\("
    set llen [llength $mod_lst]
    set idx 1
    foreach p $mod_lst {
        ## if there is an `ifdef ...
        set tick_dir [string first "`" $l]
        if {$tick_dir >= 0} {
            puts $ifh "    $p"
            incr idx
            continue
        }
        set sp [split $p]
        if {$idx < $llen} {
            puts $ifh "    [lindex $sp 0]   [lindex $sp end]"
        } else {
            puts $ifh "    [lindex $sp 0]   [string trim [lindex $sp end] ","]"
        }
        incr idx
    }
    puts $ifh "  \)\;"
    puts $ifh ""
    puts $ifh "  modport tb_conn\("
    set idx 1
    foreach p $mod_lst {
        ## if there is an `ifdef ...
        set tick_dir [string first "`" $p]
        if {$tick_dir >= 0} {
            puts $ifh "    $p"
            incr idx
            continue
        }
        set in [string first "input" $p]
        set out [string first "output" $p]
        if {$in >= 0} {
            set type "output  "
        } elseif {$out >= 0} {
            set type "input   "
        } else {
            set type "inout   "
        }

        set sp [split $p]
        #puts $sp
        if {$idx < $llen} {
            puts $ifh "    $type [lindex $sp end]"
        } else {
            puts $ifh "    $type [string trim [lindex $sp end] ","]"
        }
        incr idx
    }
    puts $ifh "  \)\;"
    puts $ifh ""
    puts $ifh "endinterface"
    close $ifh
    ##  inc the progress bar
    set gen_prog 5.0
##########################################################################
##   generate the tb_prg  file from template.
    #puts $comb_val
    if {$comb_val == "No mod"} {
        ##  indicate done in progress bar.
        set gen_prog 7.0
        puts "No tb_mod file was generated."
	    return
    }
    set tpl_fh [open $template r]
    set tpl_lst {}
    set hfound 0
    while {![eof $tpl_fh]} {
        set rline [gets $tpl_fh]
        if {$hfound == 0} {
            set head [string first ">>header" $rline]
            if {$head == 0} {
                set hfound 1
            }
        } else {
            lappend tpl_lst $rline
        }
    }

    #foreach l $tpl_lst {
    #    puts  $l
    #}

    set pfn $destin_text
    append pfn "/tb_mod.sv"
    set pfh [open $pfn w]

    set idx 0
    foreach l $tpl_lst {
        set ent_pt [string first ">>insert sigs" $l]
        if {$ent_pt == 0} {
            set tpl_lst [lreplace $tpl_lst $idx $idx]
            foreach l $log_lst {
                set tpl_lst [linsert $tpl_lst $idx "  $l"]
                incr idx
            }
            break
        }
        incr idx
    }

    #foreach l $tpl_lst {
    #    puts  $l
    #}

    ##  inc the progress bar
    set gen_prog 6.0
    set idx 0
    foreach l $tpl_lst {
        set ent_pt [string first ">>drive sigs" $l]
        if {$ent_pt == 0} {
            set tpl_lst [lreplace $tpl_lst $idx $idx]
            set midx 0
            foreach l $name_lst {
                set dir [lindex $mod_lst $midx]
                #puts $dir
                #puts "$idx $l"
                set idir [string first "input" $dir]
                if {[string first "`" $l] >= 0} {
                    set tmp $l
                } elseif {$idir >= 0} {
                    set tmp "  assign tif."
                    append tmp "$l = $l\;"
                } else {
                    set tmp "  assign $l"
                    append tmp " = tif.$l\;"
                }
                set tpl_lst [linsert $tpl_lst $idx $tmp]
                #puts [lindex $tpl_lst $idx]
                incr idx
                incr midx
            }
            break
        }
        incr idx
    }

    write_header $pfh
    foreach l $tpl_lst {
        puts $pfh $l
    }
    set gen_prog 7.0
    close $pfh
}
