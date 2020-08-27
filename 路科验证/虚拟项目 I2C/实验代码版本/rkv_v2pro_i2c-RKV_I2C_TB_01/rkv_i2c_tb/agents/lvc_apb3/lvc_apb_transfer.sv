//=======================================================================
// COPYRIGHT (C) 2018-2020 RockerIC, Ltd.
// This software and the associated documentation are confidential and
// proprietary to RockerIC, Ltd. Your use or disclosure of this software
// is subject to the terms and conditions of a consulting agreement
// between you, or your company, and RockerIC, Ltd. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
//
// The entire notice above must be reproduced on all authorized copies.
//
// VisitUs  : www.rockeric.com
// Support  : support@rockeric.com
// WeChat   : eva_bill 
//-----------------------------------------------------------------------
`ifndef LVC_APB_TRANSFER_SV
`define LVC_APB_TRANSFER_SV

//------------------------------------------------------------------------------
//
// transfer enums, parameters, and events
//
//------------------------------------------------------------------------------
typedef enum {IDLE, WRITE, READ } lvc_apb_trans_kind;
typedef enum {OK, ERROR} lvc_apb_trans_status;


//------------------------------------------------------------------------------
//
// CLASS: lvc_apb_transfer
//
//------------------------------------------------------------------------------

class lvc_apb_transfer extends uvm_sequence_item;
  // USER: Add transaction fields

  rand bit [31:0]      addr;
  rand bit [31:0]      data;
  rand lvc_apb_trans_kind  trans_kind; 
  rand lvc_apb_trans_status trans_status;
  rand int idle_cycles;

  constraint cstr{
    soft idle_cycles == 1;
  };

   // USER: Add constraint blocks
  `uvm_object_utils_begin(lvc_apb_transfer)
    `uvm_field_enum     (lvc_apb_trans_kind, trans_kind, UVM_ALL_ON)
    // USER: Register fields here
    `uvm_field_int      (addr, UVM_ALL_ON)
    `uvm_field_int      (data, UVM_ALL_ON)
    `uvm_field_int      (idle_cycles, UVM_ALL_ON)
  `uvm_object_utils_end

  // new - constructor
  function new (string name = "lvc_apb_transfer_inst");
    super.new(name);
  endfunction : new


endclass : lvc_apb_transfer

`endif // LVC_APB_TRANSFER_SV

