// Copyright 2021 Datum Technology Corporation
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __UVMT_LOGS_ST_RS_TEST_SV__
`define __UVMT_LOGS_ST_RS_TEST_SV__


/**
 * TODO Describe uvmt_logs_st_rs_test_c
 */
class uvmt_logs_st_rs_test_c extends uvmt_logs_st_base_test_c;
   
   uvml_logs_rs_text_c  rs; ///< 
   
   
   `uvm_component_utils(uvmt_logs_st_rs_test_c)
   
   /**
    * Creates rs_vseq.
    */
   extern function new(string name="uvmt_logs_st_rs_test", uvm_component parent=null);
   
   /**
    * Runs rs_vseq on vsequencer.
    */
   extern virtual task main_phase(uvm_phase phase);
   
endclass : uvmt_logs_st_rs_test_c


function uvmt_logs_st_rs_test_c::new(string name="uvmt_logs_st_rs_test", uvm_component parent=null);
   
   super.new(name, parent);
   
   rs = new("rs");
   uvm_report_server::set_server(rs);
   
endfunction : new


task uvmt_logs_st_rs_test_c::main_phase(uvm_phase phase);
   
   super.main_phase(phase);
   
   phase.raise_objection(this);
   `uvm_info("TEST", "This is some\n   sample\n\n\n TEXT", UVM_NONE)
   phase.drop_objection(this);
   
endtask : main_phase


`endif // __UVMT_LOGS_ST_RS_TEST_SV__
