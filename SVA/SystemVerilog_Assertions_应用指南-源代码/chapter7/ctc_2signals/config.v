/************************************************************************\
|*                                                                      *|
|*    Copyright (c) 2005  Springer. All rights reserved.                *|
|*                                                                      *|
|*  This example code shouyld be used only for illustration purpose     *| 
|*  This material is not to reproduced,  copied,  or used  in any       *|
|*  manner without the authorization of the author's/publishers         *|
|*  written permission                                                  *|
|*                                                                      *|
\************************************************************************/

// Author: Srikanth Vijayaraghavan and Meyyappan Ramanathan


// configuration for 2 signals
// set the parameters to configure the SVA test bench

// default is $rise(1)

parameter sig_edge = 1;
parameter sig1_edge = 0;

// default is on(1)

parameter logic_op = 0;

// time
// maximum time should be greater than the minimum time
// minimum time cannot be zero 

parameter timing = 0;
parameter min_time = 1;
parameter max_time = 2;
parameter timing_level = 2'b11;

// overlapping implication

parameter o_l_implication = 0;
parameter o_e_implication = 0;

parameter non_o_implication = 0;

// repetitions
// the value of repetition has to be greater than 1

parameter rpt_me = 1;
parameter rpt_edge = 2'b00; 
parameter start_wait = 2;
parameter repetition = 3;
parameter c_rpt = 1;
parameter c_rpt_until = 0;




