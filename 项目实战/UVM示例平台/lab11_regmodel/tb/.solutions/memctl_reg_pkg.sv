// This file is generated using Cadence iregGen version 13.20.s007 

`ifndef MEMCTL_REG_PKG_SV
`define MEMCTL_REG_PKG_SV

// Input File: ./memctl_reg_def.xml

// Number of AddrMaps = 1
// Number of RegFiles = 1
// Number of Registers = 7
// Number of Memories = 1

package memctl_reg_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"


//////////////////////////////////////////////////////////////////////////////
// Register definition
//////////////////////////////////////////////////////////////////////////////
// Line Number: 27

/* Mode 0 Register */

class mode0_reg_c extends uvm_reg;

  rand uvm_reg_field data;

  virtual function void build();
    data = uvm_reg_field::type_id::create("data");
    data.configure(this, 8, 0, "RW", 0, `UVM_REG_DATA_WIDTH'h00>>0, 1, 1, 1);
    wr_cg.set_inst_name($sformatf("%s.wcov", get_full_name()));
    rd_cg.set_inst_name($sformatf("%s.rcov", get_full_name()));
  endfunction

  covergroup wr_cg;
    option.per_instance=1;
    data : coverpoint data.value[7:0];
  endgroup
  covergroup rd_cg;
    option.per_instance=1;
    data : coverpoint data.value[7:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t  data, byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if(!is_read) wr_cg.sample();
    if(is_read) rd_cg.sample();
  endfunction

  `uvm_register_cb(mode0_reg_c, uvm_reg_cbs) 
  `uvm_set_super_type(mode0_reg_c, uvm_reg)
  `uvm_object_utils(mode0_reg_c)
  function new(input string name="unnamed-mode0_reg_c");
    super.new(name, 8, build_coverage(UVM_CVR_FIELD_VALS));
    wr_cg=new;
    rd_cg=new;
  endfunction : new
endclass : mode0_reg_c

//////////////////////////////////////////////////////////////////////////////
// Register definition
//////////////////////////////////////////////////////////////////////////////
// Line Number: 45

/* Mode 1 Register */

class mode1_reg_c extends uvm_reg;

  rand uvm_reg_field data;

  virtual function void build();
    data = uvm_reg_field::type_id::create("data");
    data.configure(this, 8, 0, "RW", 0, `UVM_REG_DATA_WIDTH'h22>>0, 1, 1, 1);
    wr_cg.set_inst_name($sformatf("%s.wcov", get_full_name()));
    rd_cg.set_inst_name($sformatf("%s.rcov", get_full_name()));
  endfunction

  covergroup wr_cg;
    option.per_instance=1;
    data : coverpoint data.value[7:0];
  endgroup
  covergroup rd_cg;
    option.per_instance=1;
    data : coverpoint data.value[7:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t  data, byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if(!is_read) wr_cg.sample();
    if(is_read) rd_cg.sample();
  endfunction

  `uvm_register_cb(mode1_reg_c, uvm_reg_cbs) 
  `uvm_set_super_type(mode1_reg_c, uvm_reg)
  `uvm_object_utils(mode1_reg_c)
  function new(input string name="unnamed-mode1_reg_c");
    super.new(name, 8, build_coverage(UVM_CVR_FIELD_VALS));
    wr_cg=new;
    rd_cg=new;
  endfunction : new
endclass : mode1_reg_c

//////////////////////////////////////////////////////////////////////////////
// Register definition
//////////////////////////////////////////////////////////////////////////////
// Line Number: 63

/* Mode 2 Register */

class mode2_reg_c extends uvm_reg;

  rand uvm_reg_field data;

  virtual function void build();
    data = uvm_reg_field::type_id::create("data");
    data.configure(this, 8, 0, "RW", 0, `UVM_REG_DATA_WIDTH'h55>>0, 1, 1, 1);
    wr_cg.set_inst_name($sformatf("%s.wcov", get_full_name()));
    rd_cg.set_inst_name($sformatf("%s.rcov", get_full_name()));
  endfunction

  covergroup wr_cg;
    option.per_instance=1;
    data : coverpoint data.value[7:0];
  endgroup
  covergroup rd_cg;
    option.per_instance=1;
    data : coverpoint data.value[7:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t  data, byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if(!is_read) wr_cg.sample();
    if(is_read) rd_cg.sample();
  endfunction

  `uvm_register_cb(mode2_reg_c, uvm_reg_cbs) 
  `uvm_set_super_type(mode2_reg_c, uvm_reg)
  `uvm_object_utils(mode2_reg_c)
  function new(input string name="unnamed-mode2_reg_c");
    super.new(name, 8, build_coverage(UVM_CVR_FIELD_VALS));
    wr_cg=new;
    rd_cg=new;
  endfunction : new
endclass : mode2_reg_c

//////////////////////////////////////////////////////////////////////////////
// Register definition
//////////////////////////////////////////////////////////////////////////////
// Line Number: 81

/* Mode 3 Register */

class mode3_reg_c extends uvm_reg;

  rand uvm_reg_field data;

  virtual function void build();
    data = uvm_reg_field::type_id::create("data");
    data.configure(this, 8, 0, "RW", 0, `UVM_REG_DATA_WIDTH'hAA>>0, 1, 1, 1);
    wr_cg.set_inst_name($sformatf("%s.wcov", get_full_name()));
    rd_cg.set_inst_name($sformatf("%s.rcov", get_full_name()));
  endfunction

  covergroup wr_cg;
    option.per_instance=1;
    data : coverpoint data.value[7:0];
  endgroup
  covergroup rd_cg;
    option.per_instance=1;
    data : coverpoint data.value[7:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t  data, byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if(!is_read) wr_cg.sample();
    if(is_read) rd_cg.sample();
  endfunction

  `uvm_register_cb(mode3_reg_c, uvm_reg_cbs) 
  `uvm_set_super_type(mode3_reg_c, uvm_reg)
  `uvm_object_utils(mode3_reg_c)
  function new(input string name="unnamed-mode3_reg_c");
    super.new(name, 8, build_coverage(UVM_CVR_FIELD_VALS));
    wr_cg=new;
    rd_cg=new;
  endfunction : new
endclass : mode3_reg_c

//////////////////////////////////////////////////////////////////////////////
// Register definition
//////////////////////////////////////////////////////////////////////////////
// Line Number: 99

/* Read Status Register */

class status_reg_c extends uvm_reg;

  rand uvm_reg_field m0_rd;
  rand uvm_reg_field m1_rd;
  rand uvm_reg_field m2_rd;
  rand uvm_reg_field m3_rd;
  rand uvm_reg_field m0_wr;
  rand uvm_reg_field m1_wr;
  rand uvm_reg_field m2_wr;
  rand uvm_reg_field m3_wr;

  virtual function void build();
    m0_rd = uvm_reg_field::type_id::create("m0_rd");
    m0_rd.configure(this, 1, 0, "RO", 0, `UVM_REG_DATA_WIDTH'h00>>0, 1, 1, 1);
    m1_rd = uvm_reg_field::type_id::create("m1_rd");
    m1_rd.configure(this, 1, 1, "RO", 0, `UVM_REG_DATA_WIDTH'h00>>1, 1, 1, 1);
    m2_rd = uvm_reg_field::type_id::create("m2_rd");
    m2_rd.configure(this, 1, 2, "RO", 0, `UVM_REG_DATA_WIDTH'h00>>2, 1, 1, 1);
    m3_rd = uvm_reg_field::type_id::create("m3_rd");
    m3_rd.configure(this, 1, 3, "RO", 0, `UVM_REG_DATA_WIDTH'h00>>3, 1, 1, 1);
    m0_wr = uvm_reg_field::type_id::create("m0_wr");
    m0_wr.configure(this, 1, 4, "RO", 0, `UVM_REG_DATA_WIDTH'h00>>4, 1, 1, 1);
    m1_wr = uvm_reg_field::type_id::create("m1_wr");
    m1_wr.configure(this, 1, 5, "RO", 0, `UVM_REG_DATA_WIDTH'h00>>5, 1, 1, 1);
    m2_wr = uvm_reg_field::type_id::create("m2_wr");
    m2_wr.configure(this, 1, 6, "RO", 0, `UVM_REG_DATA_WIDTH'h00>>6, 1, 1, 1);
    m3_wr = uvm_reg_field::type_id::create("m3_wr");
    m3_wr.configure(this, 1, 7, "RO", 0, `UVM_REG_DATA_WIDTH'h00>>7, 1, 1, 1);
    rd_cg.set_inst_name($sformatf("%s.rcov", get_full_name()));
  endfunction

  covergroup rd_cg;
    option.per_instance=1;
    m0_rd : coverpoint m0_rd.value[0:0];
    m1_rd : coverpoint m1_rd.value[0:0];
    m2_rd : coverpoint m2_rd.value[0:0];
    m3_rd : coverpoint m3_rd.value[0:0];
    m0_wr : coverpoint m0_wr.value[0:0];
    m1_wr : coverpoint m1_wr.value[0:0];
    m2_wr : coverpoint m2_wr.value[0:0];
    m3_wr : coverpoint m3_wr.value[0:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t  data, byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if(is_read) rd_cg.sample();
  endfunction

  `uvm_register_cb(status_reg_c, uvm_reg_cbs) 
  `uvm_set_super_type(status_reg_c, uvm_reg)
  `uvm_object_utils(status_reg_c)
  function new(input string name="unnamed-status_reg_c");
    super.new(name, 8, build_coverage(UVM_CVR_FIELD_VALS));
    rd_cg=new;
  endfunction : new
endclass : status_reg_c

//////////////////////////////////////////////////////////////////////////////
// Register definition
//////////////////////////////////////////////////////////////////////////////
// Line Number: 167

/* Read Count Register */

class ro_reg_c extends uvm_reg;

  rand uvm_reg_field data;

  virtual function void build();
    data = uvm_reg_field::type_id::create("data");
    data.configure(this, 8, 0, "RO", 0, `UVM_REG_DATA_WIDTH'h00>>0, 1, 1, 1);
    wr_cg.set_inst_name($sformatf("%s.wcov", get_full_name()));
    rd_cg.set_inst_name($sformatf("%s.rcov", get_full_name()));
  endfunction

  covergroup wr_cg;
    option.per_instance=1;
    data : coverpoint data.value[7:0];
  endgroup
  covergroup rd_cg;
    option.per_instance=1;
    data : coverpoint data.value[7:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t  data, byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if(!is_read) wr_cg.sample();
    if(is_read) rd_cg.sample();
  endfunction

  `uvm_register_cb(ro_reg_c, uvm_reg_cbs) 
  `uvm_set_super_type(ro_reg_c, uvm_reg)
  `uvm_object_utils(ro_reg_c)
  function new(input string name="unnamed-ro_reg_c");
    super.new(name, 8, build_coverage(UVM_CVR_FIELD_VALS));
    wr_cg=new;
    rd_cg=new;
  endfunction : new
endclass : ro_reg_c

class memctl_rf_c extends uvm_reg_block;

  rand mode0_reg_c mode0_reg;
  rand mode1_reg_c mode1_reg;
  rand mode2_reg_c mode2_reg;
  rand mode3_reg_c mode3_reg;
  rand status_reg_c status_reg;
  rand ro_reg_c rd_cnt_reg;
  rand ro_reg_c wr_cnt_reg;

  virtual function void build();

    // Now create all registers

    mode0_reg = mode0_reg_c::type_id::create("mode0_reg", , get_full_name());
    mode1_reg = mode1_reg_c::type_id::create("mode1_reg", , get_full_name());
    mode2_reg = mode2_reg_c::type_id::create("mode2_reg", , get_full_name());
    mode3_reg = mode3_reg_c::type_id::create("mode3_reg", , get_full_name());
    status_reg = status_reg_c::type_id::create("status_reg", , get_full_name());
    rd_cnt_reg = ro_reg_c::type_id::create("rd_cnt_reg", , get_full_name());
    wr_cnt_reg = ro_reg_c::type_id::create("wr_cnt_reg", , get_full_name());

    // Now build the registers. Set parent and hdl_paths

    mode0_reg.configure(this, null, "mode0_reg");
    mode0_reg.build();
    mode1_reg.configure(this, null, "mode1_reg");
    mode1_reg.build();
    mode2_reg.configure(this, null, "mode2_reg");
    mode2_reg.build();
    mode3_reg.configure(this, null, "mode3_reg");
    mode3_reg.build();
    status_reg.configure(this, null, "status_reg");
    status_reg.build();
    rd_cnt_reg.configure(this, null, "rd_cnt_reg");
    rd_cnt_reg.build();
    wr_cnt_reg.configure(this, null, "wr_cnt_reg");
    wr_cnt_reg.build();
    // Now define address mappings
    default_map = create_map("default_map", 0, 1, UVM_LITTLE_ENDIAN);
    default_map.add_reg(mode0_reg, `UVM_REG_ADDR_WIDTH'h0, "RW");
    default_map.add_reg(mode1_reg, `UVM_REG_ADDR_WIDTH'h1, "RW");
    default_map.add_reg(mode2_reg, `UVM_REG_ADDR_WIDTH'h2, "RW");
    default_map.add_reg(mode3_reg, `UVM_REG_ADDR_WIDTH'h3, "RW");
    default_map.add_reg(status_reg, `UVM_REG_ADDR_WIDTH'h10, "RO");
    default_map.add_reg(rd_cnt_reg, `UVM_REG_ADDR_WIDTH'h11, "RO");
    default_map.add_reg(wr_cnt_reg, `UVM_REG_ADDR_WIDTH'h12, "RO");
  endfunction

  `uvm_object_utils(memctl_rf_c)
  function new(input string name="unnamed-memctl_rf");
    super.new(name, UVM_NO_COVERAGE);
  endfunction : new

endclass : memctl_rf_c
 
//////////////////////////////////////////////////////////////////////////////
// Memory definition
//////////////////////////////////////////////////////////////////////////////
// Line Number: 210

class memory4096_c extends uvm_mem;
  virtual function void build();
  endfunction
  `uvm_register_cb(memory4096_c, uvm_reg_cbs) 
  `uvm_set_super_type(memory4096_c, uvm_mem)
  `uvm_object_utils(memory4096_c)
  function new(input string name="unnamed-memory4096_c");
    super.new(name, `UVM_REG_ADDR_WIDTH'h1000, 8, "RW", UVM_NO_COVERAGE);
  endfunction : new
endclass : memory4096_c

//////////////////////////////////////////////////////////////////////////////
// Address_map definition
//////////////////////////////////////////////////////////////////////////////
class memctl_reg_model_c extends uvm_reg_block;

  rand memctl_rf_c memctl_rf;
  rand memory4096_c memory4096;

  virtual function void build();
    // Now define address mappings
    default_map = create_map("default_map", 0, 1, UVM_LITTLE_ENDIAN);
    memctl_rf = memctl_rf_c::type_id::create("memctl_rf", , get_full_name());
    memctl_rf.configure(this, "dut.memctl");
    memctl_rf.build();
    memctl_rf.lock_model();
    default_map.add_submap(memctl_rf.default_map, `UVM_REG_ADDR_WIDTH'h1000);
    memory4096 = memory4096_c::type_id::create("memory4096");
    memory4096.configure(this, "dut.memctl.memory");
    memory4096.build();
    default_map.add_mem(memory4096, `UVM_REG_ADDR_WIDTH'h0, "RW");
    set_hdl_path_root("top");
    this.lock_model();
    default_map.set_check_on_read();
  endfunction
  `uvm_object_utils(memctl_reg_model_c)
  function new(input string name="unnamed-memctl_reg_model_c");
    super.new(name, UVM_NO_COVERAGE);
  endfunction
endclass : memctl_reg_model_c
 
endpackage //memctl_reg_pkg


`endif // MEMCTL_REG_PKG_SV
