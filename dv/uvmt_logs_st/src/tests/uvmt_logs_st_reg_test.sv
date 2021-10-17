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


`ifndef __UVMT_LOGS_ST_REG_TEST_SV__
`define __UVMT_LOGS_ST_REG_TEST_SV__


/**
 * TODO Describe uvmt_logs_st_reg_test_c
 */
class uvmt_logs_st_reg_test_c extends uvmt_logs_st_base_test_c;
   
        uvml_logs_reg_logger_cbs_c  reg_cbs ; ///< 
   rand uvme_logs_st_reg_vseq_c     reg_vseq; ///< 
   
   
   `uvm_component_utils(uvmt_logs_st_reg_test_c)
   
   
   /**
    * Creates reg_vseq.
    */
   extern function new(string name="uvmt_logs_st_reg_test", uvm_component parent=null);
   
   /**
    * Runs reg_vseq on vsequencer.
    */
   extern virtual task main_phase(uvm_phase phase);
   
endclass : uvmt_logs_st_reg_test_c


function uvmt_logs_st_reg_test_c::new(string name="uvmt_logs_st_reg_test", uvm_component parent=null);
   
   super.new(name, parent);
   reg_vseq = uvme_logs_st_reg_vseq_c::type_id::create("reg_vseq");
   reg_cbs = new("reg_cbs");
   
endfunction : new


task uvmt_logs_st_reg_test_c::main_phase(uvm_phase phase);
   
   super.main_phase(phase);
   
   phase.raise_objection(this);
   `uvm_info("TEST", $sformatf("Starting reg virtual sequence:\n%s", reg_vseq.sprint()), UVM_NONE)
   reg_vseq.start(vsequencer);
   `uvm_info("TEST", $sformatf("Finished reg virtual sequence:\n%s", reg_vseq.sprint()), UVM_NONE)
   phase.drop_objection(this);
   
endtask : main_phase


`endif // __UVMT_LOGS_ST_REG_TEST_SV__
