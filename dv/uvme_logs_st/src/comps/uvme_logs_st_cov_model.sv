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


`ifndef __UVME_LOGS_ST_COV_MODEL_SV__
`define __UVME_LOGS_ST_COV_MODEL_SV__


/**
 * Component encapsulating UVM Logging Self-Test Environment functional coverage model.
 */
class uvme_logs_st_cov_model_c extends uvm_component;
   
   // Coverage targets
   uvme_logs_st_cfg_c       cfg     ; ///< 
   uvme_logs_st_cntxt_c     cntxt   ; ///< 
   uvme_logs_st_seq_item_c  seq_item; ///< 
   uvme_logs_st_mon_trn_c   mon_trn ; ///< 
   
   // TLM
   uvm_analysis_export   #(uvme_logs_st_seq_item_c)  seq_item_export; ///< 
   uvm_analysis_export   #(uvme_logs_st_mon_trn_c )  mon_trn_export ; ///< 
   uvm_tlm_analysis_fifo #(uvme_logs_st_seq_item_c)  seq_item_fifo  ; ///< 
   uvm_tlm_analysis_fifo #(uvme_logs_st_mon_trn_c )  mon_trn_fifo   ; ///< 
   
   
   `uvm_component_utils_begin(uvme_logs_st_cov_model_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end
   
   
   covergroup logs_st_cfg_cg;
      // TODO Implement logs_st_cfg_cg
      //      Ex: abc_cpt : coverpoint cfg.abc;
      //          xyz_cpt : coverpoint cfg.xyz;
   endgroup : logs_st_cfg_cg
   
   covergroup logs_st_cntxt_cg;
      // TODO Implement logs_st_cntxt_cg
      //      Ex: abc_cpt : coverpoint cntxt.abc;
      //          xyz_cpt : coverpoint cntxt.xyz;
   endgroup : logs_st_cntxt_cg
   
   covergroup logs_st_seq_item_cg;
      // TODO Implement logs_st_seq_item_cg
      //      Ex: abc_cpt : coverpoint seq_item.abc;
      //          xyz_cpt : coverpoint seq_item.xyz;
   endgroup : logs_st_seq_item_cg
   
   covergroup logs_st_mon_trn_cg;
      // TODO Implement logs_st_mon_trn_cg
      //      Ex: abc_cpt : coverpoint mon_trn.abc;
      //          xyz_cpt : coverpoint mon_trn.xyz;
   endgroup : logs_st_mon_trn_cg
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvme_logs_st_cov_model", uvm_component parent=null);
   
   /**
    * Ensures cfg & cntxt handles are not null.
    */
   extern virtual function void build_phase(uvm_phase phase);
   
   /**
    * TODO Describe uvme_logs_st_cov_model_c::connect_phase()
    */
   extern virtual function void connect_phase(uvm_phase phase);
   
   /**
    * Describe uvme_logs_st_cov_model_c::run_phase()
    */
   extern virtual task run_phase(uvm_phase phase);
   
   /**
    * TODO Describe uvme_logs_st_cov_model_c::sample_cfg()
    */
   extern function void sample_cfg();
   
   /**
    * TODO Describe uvme_logs_st_cov_model_c::sample_cntxt()
    */
   extern function void sample_cntxt();
   
   /**
    * TODO Describe uvme_logs_st_cov_model_c::sample_seq_item()
    */
   extern function void sample_seq_item();
   
   /**
    * TODO Describe uvme_logs_st_cov_model_c::sample_mon_trn()
    */
   extern function void sample_mon_trn();
   
endclass : uvme_logs_st_cov_model_c


function uvme_logs_st_cov_model_c::new(string name="uvme_logs_st_cov_model", uvm_component parent=null);
   
   super.new(name, parent);
   
endfunction : new


function void uvme_logs_st_cov_model_c::build_phase(uvm_phase phase);
   
   super.build_phase(phase);
   
   void'(uvm_config_db#(uvme_logs_st_cfg_c)::get(this, "", "cfg", cfg));
   if (cfg == null) begin
      `uvm_fatal("CFG", "Configuration handle is null")
   end
   
   void'(uvm_config_db#(uvme_logs_st_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (cntxt == null) begin
      `uvm_fatal("CNTXT", "Context handle is null")
   end
   
   // Build TLM objects
   seq_item_export = new("seq_item_export", this);
   mon_trn_export  = new("mon_trn_export" , this);
   seq_item_fifo   = new("seq_item_fifo"  , this);
   mon_trn_fifo    = new("mon_trn_fifo"   , this);
   
endfunction : build_phase


function void uvme_logs_st_cov_model_c::connect_phase(uvm_phase phase);
   
   super.connect_phase(phase);
   
   // Connect TLM objects
   seq_item_export.connect(seq_item_fifo.analysis_export);
   mon_trn_export .connect(mon_trn_fifo .analysis_export);
   
endfunction : connect_phase


task uvme_logs_st_cov_model_c::run_phase(uvm_phase phase);
   
   super.run_phase(phase);
  
  fork
    // Configuration
    forever begin
      cntxt.sample_cfg_e.wait_trigger();
      sample_cfg();
    end
    
    // Context
    forever begin
      cntxt.sample_cntxt_e.wait_trigger();
      sample_cntxt();
    end
    
    // abc sequence item coverage
    forever begin
       seq_item_fifo.get(seq_item);
       sample_seq_item();
    end
    
    // abc monitored transaction coverage
    forever begin
       mon_trn_fifo.get(mon_trn);
       sample_mon_trn();
    end
  join_none
   
endtask : run_phase


function void uvme_logs_st_cov_model_c::sample_cfg();
   
  logs_st_cfg_cg.sample();
   
endfunction : sample_cfg


function void uvme_logs_st_cov_model_c::sample_cntxt();
   
   logs_st_cntxt_cg.sample();
   
endfunction : sample_cntxt


function void uvme_logs_st_cov_model_c::sample_seq_item();
   
   logs_st_seq_item_cg.sample();
   
endfunction : sample_seq_item


function void uvme_logs_st_cov_model_c::sample_mon_trn();
   
   logs_st_mon_trn_cg.sample();
   
endfunction : sample_mon_trn


`endif // __UVME_LOGS_ST_COV_MODEL_SV__
