/*
------------------------------------------------------------------------
--
--  This confidential and proprietary software may be used only
--  as authorized by a licensing agreement from Synopsys Inc.
--  In the event of publication, the following notice is applicable:
--
--                    (C) COPYRIGHT 2000-2010 SYNOPSYS INC.
--                          ALL RIGHTS RESERVED
--
--  The entire notice above must be reproduced on all authorized copies.
--
-- File :                       DW_apb_cc_constants.v
-- Author:                      Chris Gilbert
-- Date :                       $DateTime: 2010/07/20 09:40:49 $
-- Version      :               $Revision: #2 $
-- Abstract     :               This module contains definitions that
--                              are configured by coreConsultant
--
-- Modification History:        Refer to CVS log
-- =====================================================================
*/


// Description:  AHB System Address Width
// DefaultValue: 32-bit
// EnumValues:   32
//               64
// ValueRange:   32-bit
//               64-bit
`define HADDR_WIDTH 32


// Description:  APB System Address Width
// DefaultValue: 32-bit
// EnumValues:   32
//               64
// ValueRange:   32-bit
//               64-bit
`define PADDR_WIDTH 32


// Description:  The  AHB Databus Width
// DefaultValue: 32
// EnumValues:   32
//               64
//               128
//               256
`define AHB_DATA_WIDTH 32


// Description:  Define the Endianness (Big-Endian or Little-Endian) of the AHB
//                the APB subsystem is ALWAYS little endian.
// DefaultValue: Little-Endian
// EnumValues:   0
//               1
// ValueRange:   Little-Endian
//               Big-Endian
`define BIG_ENDIAN 0


// Description:  The APB Databus Width
// DefaultValue: 32
// EnumValues:   8
//               16
//               32
`define APB_DATA_WIDTH 8


// Description:  The  Number of Slave Ports (1 to 16)
// DefaultValue: 4
// EnumValues:   1
//               2
//               3
//               4
//               5
//               6
//               7
//               8
//               9
//               10
//               11
//               12
//               13
//               14
//               15
//               16
`define NUM_APB_SLAVES 2


// Description:  Start Address for APB Slave #0 (Address in Hexadecimal)
//               This is an absolute address value (not an offset)
// DefaultValue: 0x00000400
// MinValue:     0x00000000
// MaxValue:     0xfffffc00
`define START_PADDR_0 32'h01000400


// Description:  Start Address for APB Slave #1 (Address in Hexadecimal)
//               This is an absolute address value (not an offset)
// DefaultValue: 0x00000800
// MinValue:     0x00000000
// MaxValue:     0xfffffc00
`define START_PADDR_1 32'h01000800


// Description:  Start Address for APB Slave #2 (Address in Hexadecimal)
//               This is an absolute address value (not an offset)
// DefaultValue: 0x00000c00
// MinValue:     0x00000000
// MaxValue:     0xfffffc00
`define START_PADDR_2 32'h00000c00


// Description:  Start Address for APB Slave #3 (Address in Hexadecimal)
//               This is an absolute address value (not an offset)
// DefaultValue: 0x00001000
// MinValue:     0x00000000
// MaxValue:     0xfffffc00
`define START_PADDR_3 32'h00001000


// Description:  Start Address for APB Slave #4 (Address in Hexadecimal)
//               This is an absolute address value (not an offset)
// DefaultValue: 0x00001400
// MinValue:     0x00000000
// MaxValue:     0xfffffc00
`define START_PADDR_4 32'h00001400


// Description:  Start Address for APB Slave #5 (Address in Hexadecimal)
//               This is an absolute address value (not an offset)
// DefaultValue: 0x00001800
// MinValue:     0x00000000
// MaxValue:     0xfffffc00
`define START_PADDR_5 32'h00001800


// Description:  Start Address for APB Slave #6 (Address in Hexadecimal)
//               This is an absolute address value (not an offset)
// DefaultValue: 0x00001c00
// MinValue:     0x00000000
// MaxValue:     0xfffffc00
`define START_PADDR_6 32'h00001c00


// Description:  Start Address for APB Slave #7 (Address in Hexadecimal)
//               This is an absolute address value (not an offset)
// DefaultValue: 0x00002000
// MinValue:     0x00000000
// MaxValue:     0xfffffc00
`define START_PADDR_7 32'h00002000


// Description:  Start Address for APB Slave #8 (Address in Hexadecimal)
//               This is an absolute address value (not an offset)
// DefaultValue: 0x00002400
// MinValue:     0x00000000
// MaxValue:     0xfffffc00
`define START_PADDR_8 32'h00002400


// Description:  Start Address for APB Slave #9 (Address in Hexadecimal)
//               This is an absolute address value (not an offset)
// DefaultValue: 0x00002800
// MinValue:     0x00000000
// MaxValue:     0xfffffc00
`define START_PADDR_9 32'h00002800


// Description:  Start Address for APB Slave #10 (Address in Hexadecimal)
//               This is an absolute address value (not an offset)
// DefaultValue: 0x00002c00
// MinValue:     0x00000000
// MaxValue:     0xfffffc00
`define START_PADDR_10 32'h00002c00


// Description:  Start Address for APB Slave #11 (Address in Hexadecimal)
//               This is an absolute address value (not an offset)
// DefaultValue: 0x00003000
// MinValue:     0x00000000
// MaxValue:     0xfffffc00
`define START_PADDR_11 32'h00003000


// Description:  Start Address for APB Slave #12 (Address in Hexadecimal)
//               This is an absolute address value (not an offset)
// DefaultValue: 0x00003400
// MinValue:     0x00000000
// MaxValue:     0xfffffc00
`define START_PADDR_12 32'h00003400


// Description:  Start Address for APB Slave #13 (Address in Hexadecimal)
//               This is an absolute address value (not an offset)
// DefaultValue: 0x00003800
// MinValue:     0x00000000
// MaxValue:     0xfffffc00
`define START_PADDR_13 32'h00003800


// Description:  Start Address for APB Slave #14 (Address in Hexadecimal)
//               This is an absolute address value (not an offset)
// DefaultValue: 0x00003c00
// MinValue:     0x00000000
// MaxValue:     0xfffffc00
`define START_PADDR_14 32'h00003c00


// Description:  Start Address for APB Slave #15 (Address in Hexadecimal)
//               This is an absolute address value (not an offset)
// DefaultValue: 0x00004000
// MinValue:     0x00000000
// MaxValue:     0xfffffc00
`define START_PADDR_15 32'h00004000


// Description:  End Address for APB Slave #0
//               This is an absolute address value (not an offset)
// DefaultValue: 0x000007ff
// MinValue:     0x000003ff
// MaxValue:     0xffffffff
`define END_PADDR_0 32'h010007ff


// Description:  End Address for APB Slave #1
//               This is an absolute address value (not an offset)
// DefaultValue: 0x00000bff
// MinValue:     0x000003ff
// MaxValue:     0xffffffff
`define END_PADDR_1 32'h01000bff


// Description:  End Address for APB Slave #2
//               This is an absolute address value (not an offset)
// DefaultValue: 0x00000fff
// MinValue:     0x000003ff
// MaxValue:     0xffffffff
`define END_PADDR_2 32'h00000fff


// Description:  End Address for APB Slave #3
//               This is an absolute address value (not an offset)
// DefaultValue: 0x000013ff
// MinValue:     0x000003ff
// MaxValue:     0xffffffff
`define END_PADDR_3 32'h000013ff


// Description:  End Address for APB Slave #4
//               This is an absolute address value (not an offset)
// DefaultValue: 0x000017ff
// MinValue:     0x000003ff
// MaxValue:     0xffffffff
`define END_PADDR_4 32'h000017ff


// Description:  End Address for APB Slave #5
//               This is an absolute address value (not an offset)
// DefaultValue: 0x00001bff
// MinValue:     0x000003ff
// MaxValue:     0xffffffff
`define END_PADDR_5 32'h00001bff


// Description:  End Address for APB Slave #6
//               This is an absolute address value (not an offset)
// DefaultValue: 0x00001fff
// MinValue:     0x000003ff
// MaxValue:     0xffffffff
`define END_PADDR_6 32'h00001fff


// Description:  End Address for APB Slave #7
//               This is an absolute address value (not an offset)
// DefaultValue: 0x000023ff
// MinValue:     0x000003ff
// MaxValue:     0xffffffff
`define END_PADDR_7 32'h000023ff


// Description:  End Address for APB Slave #8
//               This is an absolute address value (not an offset)
// DefaultValue: 0x000027ff
// MinValue:     0x000003ff
// MaxValue:     0xffffffff
`define END_PADDR_8 32'h000027ff


// Description:  End Address for APB Slave #9
//               This is an absolute address value (not an offset)
// DefaultValue: 0x00002bff
// MinValue:     0x000003ff
// MaxValue:     0xffffffff
`define END_PADDR_9 32'h00002bff


// Description:  End Address for APB Slave #10
//               This is an absolute address value (not an offset)
// DefaultValue: 0x00002fff
// MinValue:     0x000003ff
// MaxValue:     0xffffffff
`define END_PADDR_10 32'h00002fff


// Description:  End Address for APB Slave #11
//               This is an absolute address value (not an offset)
// DefaultValue: 0x000033ff
// MinValue:     0x000003ff
// MaxValue:     0xffffffff
`define END_PADDR_11 32'h000033ff


// Description:  End Address for APB Slave #12
//               This is an absolute address value (not an offset)
// DefaultValue: 0x000037ff
// MinValue:     0x000003ff
// MaxValue:     0xffffffff
`define END_PADDR_12 32'h000037ff


// Description:  End Address for APB Slave #13
//               This is an absolute address value (not an offset)
// DefaultValue: 0x00003bff
// MinValue:     0x000003ff
// MaxValue:     0xffffffff
`define END_PADDR_13 32'h00003bff


// Description:  End Address for APB Slave #14
//               This is an absolute address value (not an offset)
// DefaultValue: 0x00003fff
// MinValue:     0x000003ff
// MaxValue:     0xffffffff
`define END_PADDR_14 32'h00003fff


// Description:  End Address for APB Slave #15
//               This is an absolute address value (not an offset)
// DefaultValue: 0x000043ff
// MinValue:     0x000003ff
// MaxValue:     0xffffffff
`define END_PADDR_15 32'h000043ff


// Description:  Normal Start Address for APB Subsystem
//               Must be entered in hex.
// DefaultValue: 0x00000000
// MinValue:     0x00000000
// MaxValue:     0xfffffc00
`define R0_APB_SA 32'h01000000


// Description:  Normal End Address for APB Subsystem
//               Must be entered in hex.
// DefaultValue: 0x000043ff
// MinValue:     0x000003ff
// MaxValue:     0xffffffff
`define R0_APB_EA 32'h01ffffff

