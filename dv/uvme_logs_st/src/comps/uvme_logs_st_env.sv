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


`ifndef __UVME_LOGS_ST_ENV_SV__
`define __UVME_LOGS_ST_ENV_SV__


/**
 * Top-level component that encapsulates, builds and connects all other UVM Logging environment components.
 */
class uvme_logs_st_env_c extends uvml_env_c;
   
   // Objects
   uvme_logs_st_cfg_c      cfg; ///< 
   uvme_logs_st_cntxt_c  cntxt; ///< 
   
   // Components
   uvme_logs_st_cov_model_c        cov_model      ; ///< 
   uvme_logs_st_vsqr_c             vsequencer     ; ///< 
   uvme_logs_st_mon_trn_logger_c   mon_trn_logger ; ///< 
   uvme_logs_st_seq_item_logger_c  seq_item_logger; ///< 
   
   // Register Abstraction Layer
   uvme_logs_st_reg_adapter_c  reg_adapter; ///< 
   uvme_logs_st_reg_block_c    reg_block  ; ///< 
   
   
   `uvm_component_utils_begin(uvme_logs_st_env_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvme_logs_st_env", uvm_component parent=null);
   
   /**
    * 1. Ensures cfg & cntxt handles are not null
    * 2. Retrieves cntxt.clk_vif from UVM configuration database via retrieve_clk_vif()
    * 3. Assigns cfg and cntxt handles via assign_cfg() & assign_cntxt()
    * 4. Builds all components via create_<x>()
    */
   extern virtual function void build_phase(uvm_phase phase);
   
   /**
    * 1. Connects agents to predictor via connect_predictor()
    * 2. Connects predictor & agents to scoreboard via connect_scoreboard()
    * 3. Assembles virtual sequencer handles via assemble_vsequencer()
    * 4. Connects agents to coverage model via connect_coverage_model()
    */
   extern virtual function void connect_phase(uvm_phase phase);
   
   /**
    * Assigns configuration handles to components using UVM Configuration Database.
    */
   extern function void assign_cfg();
   
   /**
    * Assigns context handles to components using UVM Configuration Database.
    */
   extern function void assign_cntxt();
   
   /**
    * Creates ral_adapter which translates to/from ral to axil_agent.
    */
   extern virtual function void create_ral_adapter();
   
   /**
    * Creates additional (non-agent) environment components (and objects).
    */
   extern function void create_env_components();
   
   /**
    * Creates environment's virtual sequencer.
    */
   extern function void create_vsequencer();
   
   /**
    * Creates environment's coverage model.
    */
   extern function void create_cov_model();
   
   /**
    * Connects RAL to provisioning agent (axil_agent).
    */
   extern virtual function void connect_reg_block();
   
   /**
    * TODO Describe uvme_logs_st_env_c::connect_trn_loggers()
    */
   extern function void connect_trn_loggers();
   
   /**
    * Connects environment coverage model to agents/scoreboards/predictor.
    */
   extern function void connect_coverage_model();
   
endclass : uvme_logs_st_env_c


function uvme_logs_st_env_c::new(string name="uvme_logs_st_env", uvm_component parent=null);
   
   super.new(name, parent);
   
endfunction : new


function void uvme_logs_st_env_c::build_phase(uvm_phase phase);
   
   super.build_phase(phase);
   
   void'(uvm_config_db#(uvme_logs_st_cfg_c)::get(this, "", "cfg", cfg));
   if (cfg == null) begin
      `uvm_fatal("CFG", "Configuration handle is null")
   end
   else begin
      `uvm_info("CFG", $sformatf("Found configuration handle:\n%s", cfg.sprint()), UVM_DEBUG)
   end
   
   if (cfg.enabled) begin
      void'(uvm_config_db#(uvme_logs_st_cntxt_c)::get(this, "", "cntxt", cntxt));
      if (cntxt == null) begin
         `uvm_info("CNTXT", "Context handle is null; creating.", UVM_DEBUG)
         cntxt = uvme_logs_st_cntxt_c::type_id::create("cntxt");
      end
      
      assign_cfg           ();
      assign_cntxt         ();
      create_env_components();
      
      if (cfg.is_active) begin
         create_vsequencer ();
         create_ral_adapter();
      end
      
      if (cfg.cov_model_enabled) begin
         create_cov_model();
      end
   end
   
endfunction : build_phase


function void uvme_logs_st_env_c::connect_phase(uvm_phase phase);
   
   super.connect_phase(phase);
   
   if (cfg.enabled) begin
      connect_reg_block();
      if (cfg.trn_log_enabled) begin
         connect_trn_loggers();
      end
      if (cfg.cov_model_enabled) begin
         connect_coverage_model();
      end
   end
   
endfunction: connect_phase


function void uvme_logs_st_env_c::assign_cfg();
   
   uvm_config_db#(uvme_logs_st_cfg_c)::set(this, "*", "cfg", cfg);
   
endfunction: assign_cfg


function void uvme_logs_st_env_c::assign_cntxt();
   
   uvm_config_db#(uvme_logs_st_cntxt_c)::set(this, "*", "cntxt", cntxt);
   
endfunction: assign_cntxt


function void uvme_logs_st_env_c::create_env_components();
   
   if (cfg.trn_log_enabled) begin
      mon_trn_logger  = uvme_logs_st_mon_trn_logger_c ::type_id::create("mon_trn_logger" , this);
      seq_item_logger = uvme_logs_st_seq_item_logger_c::type_id::create("seq_item_logger", this);
   end
   
endfunction: create_env_components


function void uvme_logs_st_env_c::create_ral_adapter();
   
   reg_adapter = uvme_logs_st_reg_adapter_c::type_id::create("reg_adapter");
   reg_block = cfg.reg_block;
   reg_block.cntxt = cntxt;
   
endfunction: create_ral_adapter


function void uvme_logs_st_env_c::create_vsequencer();
   
   vsequencer = uvme_logs_st_vsqr_c::type_id::create("vsequencer", this);
   
endfunction: create_vsequencer


function void uvme_logs_st_env_c::create_cov_model();
   
   cov_model = uvme_logs_st_cov_model_c::type_id::create("cov_model", this);
   
endfunction: create_cov_model


function void uvme_logs_st_env_c::connect_reg_block();
   
   reg_block.connect();
   reg_block.default_map.set_sequencer(vsequencer.seq_item_sequencer, reg_adapter);
   reg_block.default_map.set_auto_predict(1);
   
endfunction: connect_reg_block


function void uvme_logs_st_env_c::connect_trn_loggers();
   
   vsequencer.mon_trn_ap .connect(mon_trn_logger .analysis_export);
   vsequencer.seq_item_ap.connect(seq_item_logger.analysis_export);
   
endfunction : connect_trn_loggers


function void uvme_logs_st_env_c::connect_coverage_model();
   
   vsequencer.seq_item_ap.connect(cov_model.seq_item_export);
   vsequencer.mon_trn_ap .connect(cov_model.mon_trn_export );
   
endfunction: connect_coverage_model


`endif // __UVME_LOGS_ST_ENV_SV__
