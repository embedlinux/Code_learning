
This is the README file for the CD-ROM acompanying the
Springer edition of "Digital VLSI Design with Verilog",
by John Michael Williams.   It is,

      Copyright 2008 by John Michael Williams.
              All rights reserved.

Last updated:  2008-01-17.

The CD-ROM includes all lab exercises and answers for
the book, sorted by book lab number.  It is meant for
use either in a Linux or Unix environment, but it also
has been tested usable in MS Windows.  All files should
be readable also in Mac OS or in any other CD-ROM
compatible system.

A. To use the CD-ROM while reading the book:
     The CD-ROM simply may be read, lab by lab, along
     with the book.  All files are plain text.   They
     are best viewed in vim or wordpad.

B. To use with a verilog simulator or synthesizer:
     The entire CD-ROM should be copied onto a hard
     disc into a directory intended to be the reader's
     work location; all relative directory structure
     should be preserved.
     
     A few paths in the synthesis scripts (.sct files)
     may have to be modified, depending on the reader's
     setup.  Of course, the reader must set up a 
     working environment in which the chosen tools can be
     operated properly.

     A few extra side files are in the "misc" directory:
     These should be installed at the work location or
     in a directory nearby.

 ------------------------------------------------------
 -------- Some Details: -------------------------------
 ------------------------------------------------------

There are several empty files on the CD-ROM.  These are
of two kinds:

  1. The *.v files and a few others were symbolic links;
     the reader may want to recreate them as links to the
     "misc" files of the same name.  Some of these links
     were references to proprietary Synopsys or TSMC data;
     such links should be created pointing wherever
     the reader legally has installed the licensed tools.

  2. Files ending in .log have been zeroed out purposely
     to avoid publishing proprietary information.  They
     were created by the Synopsys synthesizer and will be
     recreated if the synthesizer is run by the reader
     in the proper directory, using the respective
     synthesis script for the lab involved.

In the CD-ROM "misc" directory, there are several .v
verilog library files which are necessary for netlist
simulation according to the lab instructions in the book.
These verilog files were written by the present author
and do not include any proprietary information.

A key to some filename extensions used:

   .cfg  VCS-generated GUI window configuration.
   .inc  verilog include file.
   .log  logged-message file (synthesizer).
   .sct  synthesis control script (Tcl format).
   .sdf  delay back-annotation file for simulation.
   .spj  SILOS-generated GUI window configuration.
   .txt  ASCII text file.
   .v    verilog source or netlist file.
   .vcd  value-change-dump from simulator.
   .vcs  VCS or QuestaSim design file list.

 =============================================================
 ========= Concerning simulation of the answer netlists: =====
 =============================================================

All the verilog source code designs in the answers on the
CD-ROM will simulate in VCS-MX as described in the book.

All the netlists in the answers will function correctly
as described in the book.

Some of the answer netlists synthesized from the more
complicated designs (especially Lab 23 and on) may not
simulate correctly, depending on which simulator software
is being used.   Netlist simulation failure may be because
of simulator peculiarity or because of hold violations.

Problems with netlist simulation because of netlist
complexity may be worked around:

  (a) Try simulating with the DC-generated SDF file for
      the netlist; and/or,

  (b) Try resynthesizing the netlist, using a newer
      version of the synthesizer or using different
      constraints in the synthesis script.
      Two recommended constraint solutions:

        Apply timing constraints to clocked logic far too
        tight; this may speed up the logic enough so that
        hold is not violated any more.   DC-reported negative
        slack, of course, should be ignored if constraints
        purposely were set unrealistically.

        Use DC set_fix_hold [all_clocks]; this will produce
        a completely correct netlist for simulation, but
        it will take MUCH longer to synthesize -- about
        200x as long for the complete FullDup design of
        Lab 26.

Failure of a reader's netlist simulation sometimes may
be because of the verilog library models which are
provided on the CD-ROM.   The timing in these models
is crude, and a few of the sequential models may be slightly
different functionally, in a given simulator, from
the models actually used to generate the waveform
figures in the book.   The models on the CD-ROM have
been rewritten to avoid revealing TSMC or Synopsys
proprietary library details.   Of course, SDF will
cause all verilog model timing to be ignored.

