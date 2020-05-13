//------------------------------------------------------------
//   Copyright 2010 Mentor Graphics Corporation
//   All Rights Reserved Worldwide
//
//   Licensed under the Apache License, Version 2.0 (the
//   "License"); you may not use this file except in
//   compliance with the License.  You may obtain a copy of
//   the License at
//
//       http://www.apache.org/licenses/LICENSE-2.0
//
//   Unless required by applicable law or agreed to in
//   writing, software distributed under the License is
//   distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
//   CONDITIONS OF ANY KIND, either express or implied.  See
//   the License for the specific language governing
//   permissions and limitations under the License.
//------------------------------------------------------------

//
// Class Description:
//
//
class spi_agent_config extends uvm_object;

// UVM Factory Registration Macro
//
`uvm_object_utils(spi_agent_config)

// Virtual Interface
virtual spi_if SPI;

//------------------------------------------
// Data Members
//------------------------------------------
// Is the agent active or passive
uvm_active_passive_enum active = UVM_ACTIVE;
bit has_functional_coverage = 0;

//------------------------------------------
// Methods
//------------------------------------------
// Standard UVM Methods:
extern function new(string name = "spi_agent_config");

endclass: spi_agent_config

function spi_agent_config::new(string name = "spi_agent_config");
  super.new(name);
endfunction
