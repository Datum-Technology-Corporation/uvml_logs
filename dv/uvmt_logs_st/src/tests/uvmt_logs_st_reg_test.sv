// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
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
    * TODO Describe uvmt_logs_st_reg_test_c::build_phase()
    */
   extern virtual function void build_phase(uvm_phase phase);
   
   /**
    * TODO Describe uvmt_logs_st_reg_test_c::connect_phase()
    */
   extern virtual function void connect_phase(uvm_phase phase);
   
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


function void uvmt_logs_st_reg_test_c::build_phase(uvm_phase phase);
   
   super.build_phase(phase);
   
   reg_cbs = uvml_logs_reg_logger_cbs_c::type_id::create("reg_cbs");
  
endfunction : build_phase


function void uvmt_logs_st_reg_test_c::connect_phase(uvm_phase phase);
   
   super.connect_phase(phase);
   
   uvm_reg_cb::add(null, reg_cbs);
   
endfunction : connect_phase


task uvmt_logs_st_reg_test_c::main_phase(uvm_phase phase);
   
   super.main_phase(phase);
   
   phase.raise_objection(this);
   `uvm_info("TEST", $sformatf("Starting reg virtual sequence:\n%s", reg_vseq.sprint()), UVM_NONE)
   reg_vseq.start(vsequencer);
   `uvm_info("TEST", $sformatf("Finished reg virtual sequence:\n%s", reg_vseq.sprint()), UVM_NONE)
   phase.drop_objection(this);
   
endtask : main_phase


`endif // __UVMT_LOGS_ST_REG_TEST_SV__
