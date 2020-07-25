//------------------------------------------------------------
//   Copyright 2010-2018 Mentor Graphics Corporation
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
// Interface: intr_if
//
// Note signal bundle only
interface intr_if;

  logic IRQ;

  task wait_for_interrupt();
    @(posedge IRQ);
  endtask : wait_for_interrupt

  function bit is_interrupt_cleared();
    if(IRQ == 0)
      return 1;
    else
      return 0;
  endfunction : is_interrupt_cleared
  
endinterface: intr_if
