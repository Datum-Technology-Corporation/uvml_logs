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


`ifndef __UVME_LOGS_ST_SEQ_ITEM_LOGGER_SV__
`define __UVME_LOGS_ST_SEQ_ITEM_LOGGER_SV__


/**
 * TODO Describe uvme_logs_st_seq_item_logger_c
 */
class uvme_logs_st_seq_item_logger_c extends uvml_logs_seq_item_logger_c #(
   .T_TRN  (uvme_logs_st_seq_item_c),
   .T_CFG  (uvme_logs_st_cfg_c     ),
   .T_CNTXT(uvme_logs_st_cntxt_c   )
);
   
   `uvm_component_utils(uvme_logs_st_seq_item_logger_c)
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvme_logs_st_seq_item_logger", uvm_component parent=null);
   
   /**
    * Writes contents of t to disk
    */
   extern virtual function void write(uvme_logs_st_seq_item_c t);
   
   /**
    * Writes log header to disk
    */
   extern virtual function void print_header();
   
endclass : uvme_logs_st_seq_item_logger_c


function uvme_logs_st_seq_item_logger_c::new(string name="uvme_logs_st_seq_item_logger", uvm_component parent=null);
   
   super.new(name, parent);
   
endfunction : new


function void uvme_logs_st_seq_item_logger_c::write(uvme_logs_st_seq_item_c t);
   
   string  access  = t.we ? "  W" : "R  ";
   string  address = $sformatf("%h", t.address);
   string  data    = t.we ? $sformatf("%h", t.wdata) : $sformatf("%h", t.rdata);
   
   `uvm_info("SEQ_ITEM_LOGGER", $sformatf("Printing transaction to file:\n%s", t.sprint()), UVM_LOW)
   fwrite($sformatf(" %t | %s | %s | %s", $realtime(), access, address, data));
   
endfunction : write


function void uvme_logs_st_seq_item_logger_c::print_header();
   
   `uvm_info("SEQ_ITEM_LOGGER", "Printing transation log header to file", UVM_LOW)
   fwrite("--------------------------------------");
   fwrite("        TIME        | R/W |  ADDRESS | DATA");
   fwrite("--------------------------------------");
   
endfunction : print_header


`endif // __UVME_LOGS_ST_SEQ_ITEM_LOGGER_SV__
