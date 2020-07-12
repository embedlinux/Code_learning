/****************************************************************
========Oooo=========================================Oooo========
=     Copyright ©2015-2017 Gowin Semiconductor Corporation.     =
=                     All rights reserved.                      =
========Oooo=========================================Oooo========

<File Title>: Template file for instantiation
<gwModGen version>: 1.8.0Alpha
<Series, Device, Package, Speed>: GW2AR, GW2AR-18, LQFP144
<Created Time>: Mon Mar 19 10:16:21 2018
****************************************************************/

//Change the instance name and port connections to the signal names
//--------Copy here to design--------

    GW_PLL your_instance_name(
        .clkout(clkout_o), //output clkout
        .lock(lock_o), //output lock
        .clkoutp(clkoutp_o), //output clkoutp
        .clkin(clkin_i) //input clkin
    );

//--------Copy end-------------------
