// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_LOGS_ST_VSQR_SV__
`define __UVME_LOGS_ST_VSQR_SV__


/**
 * Component on which all UVM Logging VIP Self-Test virtual sequences are run.
 */
class uvme_logs_st_vsqr_c extends uvml_vsqr_c #(
   .REQ(uvm_sequence_item),
   .RSP(uvm_sequence_item)
);
   
   // Objects
   uvme_logs_st_cfg_c    cfg  ; ///< 
   uvme_logs_st_cntxt_c  cntxt; ///< 
   
   // Sequencer handles
   uvme_logs_st_mon_trn_sqr_c   mon_trn_sequencer ; ///< 
   uvme_logs_st_seq_item_sqr_c  seq_item_sequencer; ///< 
   
   // TLM
   uvm_analysis_port #(uvme_logs_st_mon_trn_c )  mon_trn_ap ; ///< 
   uvm_analysis_port #(uvme_logs_st_seq_item_c)  seq_item_ap; ///< 
   
   
   `uvm_component_utils_begin(uvme_logs_st_vsqr_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvme_logs_st_sqr", uvm_component parent=null);
   
   /**
    * Ensures cfg & cntxt handles are not null.
    */
   extern virtual function void build_phase(uvm_phase phase);
   
   /**
    * TODO Describe uvme_logs_st_vsqr_c::run_phase()
    */
   extern virtual task run_phase(uvm_phase phase);
   
endclass : uvme_logs_st_vsqr_c


function uvme_logs_st_vsqr_c::new(string name="uvme_logs_st_sqr", uvm_component parent=null);
   
   super.new(name, parent);
   
endfunction : new


function void uvme_logs_st_vsqr_c::build_phase(uvm_phase phase);
   
   super.build_phase(phase);
   
   void'(uvm_config_db#(uvme_logs_st_cfg_c)::get(this, "", "cfg", cfg));
   if (cfg == null) begin
      `uvm_fatal("CFG", "Configuration handle is null")
   end
   uvm_config_db#(uvme_logs_st_cfg_c)::set(this, "*", "cfg", cfg);
   
   void'(uvm_config_db#(uvme_logs_st_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (cntxt == null) begin
      `uvm_fatal("CNTXT", "Context handle is null")
   end
   uvm_config_db#(uvme_logs_st_cntxt_c)::set(this, "*", "cntxt", cntxt);
   
   mon_trn_sequencer  = uvme_logs_st_mon_trn_sqr_c ::type_id::create("mon_trn_sequencer" , this);
   seq_item_sequencer = uvme_logs_st_seq_item_sqr_c::type_id::create("seq_item_sequencer", this);
   
   mon_trn_ap  = new("mon_trn_ap" , this);
   seq_item_ap = new("seq_item_ap", this);
   
endfunction : build_phase


task uvme_logs_st_vsqr_c::run_phase(uvm_phase phase);
   
   uvme_logs_st_mon_trn_c   mon_trn ;
   uvme_logs_st_seq_item_c  seq_item;
   
   super.run_phase(phase);
   
   fork
      begin
         forever begin
            mon_trn_sequencer.get_next_item(mon_trn);
            mon_trn_ap.write(mon_trn);
            mon_trn_sequencer.item_done();
         end
      end
      
      begin
         forever begin
            seq_item_sequencer.get_next_item(seq_item);
            seq_item_ap.write(seq_item);
            seq_item_sequencer.item_done();
         end
      end
   join
   
endtask : run_phase


`endif // __UVME_LOGS_ST_VSQR_SV__
