// Copyright 2021 Datum Technology Corporation
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_LOGS_ST_REG_ADAPTER_SV__
`define __UVME_LOGS_ST_REG_ADAPTER_SV__


typedef class uvme_logs_st_seq_item_c;


/**
 * Object that converts between abstract register operations (UVM) and the mock sequence item for this env.
 */
class uvme_logs_st_reg_adapter_c extends uvm_reg_adapter;
   
   `uvm_object_utils(uvme_logs_st_reg_adapter_c)
   
   
   /**
    * Default constructor
    */
   extern function new(string name="uvme_logs_st_reg_adapter");
   
   /**
    * Converts from UVM register operation to Advanced Peripheral Bus.
    */
   extern virtual function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
   
   /**
    * Converts from AXI-Lite to UVM register operation.
    */
   extern virtual function void bus2reg(uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);
   
endclass : uvme_logs_st_reg_adapter_c


function uvme_logs_st_reg_adapter_c::new(string name="uvme_logs_st_reg_adapter");
   
   super.new(name);
   supports_byte_enable = 1;
   
endfunction : new


function uvm_sequence_item uvme_logs_st_reg_adapter_c::reg2bus(const ref uvm_reg_bus_op rw);
   
   uvme_logs_st_seq_item_c  seq_item = uvme_logs_st_seq_item_c::type_id::create("seq_item");
   
   seq_item.we      = (rw.kind == UVM_WRITE);
   seq_item.address = rw.addr;
   seq_item.be      = rw.byte_en;
   
   if (rw.kind == UVM_WRITE) begin
      seq_item.wdata = rw.data;
   end
   
   return seq_item;
   
endfunction : reg2bus


function void uvme_logs_st_reg_adapter_c::bus2reg(uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);
   
   uvme_logs_st_seq_item_c  seq_item;
   
   if (!$cast(seq_item, bus_item)) begin
      `uvm_fatal("AXIL_REG_ADAPTER", $sformatf("Could not cast bus_item (%s) into seq_item (%s)", $typename(bus_item), $typename(seq_item)))
   end
   
   rw.kind = (seq_item.we) ? UVM_WRITE : UVM_READ;
   rw.addr = seq_item.address;
   rw.byte_en = seq_item.be;
   
   case (seq_item.we)
      0 : rw.data = seq_item.rdata;
      1 : rw.data = seq_item.wdata;
   endcase
   
   rw.status = UVM_IS_OK;
   
endfunction : bus2reg


`endif // __UVME_LOGS_ST_REG_ADAPTER_SV__
