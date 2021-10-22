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


`ifndef __UVML_LOGS_SEQ_ITEM_LOGGER_SV__
`define __UVML_LOGS_SEQ_ITEM_LOGGER_SV__


/**
 * Logger writing sequence items debug info to disk.
 */
class uvml_logs_seq_item_logger_c#(
   type T_TRN   = uvml_seq_item_c,
   type T_CFG   = uvm_object     ,
   type T_CNTXT = uvm_object
) extends uvm_subscriber#(
   .T(T_TRN)
);
   
   // Objects
   T_CFG    cfg;
   T_CNTXT  cntxt;
   
   // IO constants
   string  cli_args   = uvml_logs_default_sim_dir_cli_arg ;
   string  sub_dir    = uvml_logs_default_trn_log_dir_name;
   string  fextension = uvml_logs_default_trn_fextension  ;
   
   // IO variables
   bit           fhandle_valid     = 0;
   int unsigned  fhandle           = 0;
   string        test_results_path = "";
   string        fpath             = "";
   string        name              = "";
   
   
   `uvm_component_param_utils_begin(uvml_logs_seq_item_logger_c#(T_TRN, T_CFG, T_CNTXT))
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
      
      `uvm_field_string(cli_args  , UVM_DEFAULT)
      `uvm_field_string(sub_dir   , UVM_DEFAULT)
      `uvm_field_string(fextension, UVM_DEFAULT)
      
      `uvm_field_int   (fhandle_valid    , UVM_DEFAULT)
      `uvm_field_int   (fhandle          , UVM_DEFAULT)
      `uvm_field_string(test_results_path, UVM_DEFAULT)
      `uvm_field_string(fpath            , UVM_DEFAULT)
      `uvm_field_string(name             , UVM_DEFAULT)
   `uvm_component_utils_end
   
   
   /**
    * Default constructor
    */
   extern function new(string name="uvml_logs_seq_item_logger", uvm_component parent=null);
   
   /**
    * 1. Ensures cfg & cntxt handles are not null
    * 2. Opens fhandle for write access
    * 3. Prints banner into fhandle
    */
   extern virtual function void build_phase(uvm_phase phase);
   
   /**
    * TODO Describe uvml_logs_seq_item_logger_c::end_of_elaboration_phase()
    */
   extern virtual function void end_of_elaboration_phase(uvm_phase phase);
   
   /**
    * Closes fhandle access
    */
   extern virtual function void final_phase(uvm_phase phase);
   
   /**
    * Writes contents of t to disk
    */
   extern virtual function void write(T_TRN t);
   
   /**
    * Writes log header to disk
    */
   extern virtual function void print_header();
   
   /**
    * Writes msg to disk
    */
   extern function void fwrite(string msg);
   
   /**
    * Returns string of byte array in 'xxxx_xxxx' format.
    */
   extern function string log_bytes(ref bit [7:0] bytes[]);
   
endclass : uvml_logs_seq_item_logger_c


function uvml_logs_seq_item_logger_c::new(string name="uvml_logs_seq_item_logger", uvm_component parent=null);
   
   super.new(name, parent);
   test_results_path = uvml_file_c::get_cli_path(UVML_FILE_BASE_DIR_TEST_RESULTS);
   
endfunction : new


function void uvml_logs_seq_item_logger_c::build_phase(uvm_phase phase);
   
   super.build_phase(phase);
   
   void'(uvm_config_db#(T_CFG)::get(this, "", "cfg", cfg));
   if (cfg == null) begin
     `uvm_fatal("CFG", "Configuration handle is null")
   end
   
   void'(uvm_config_db#(T_CNTXT)::get(this, "", "cntxt", cntxt));
   if (cntxt == null) begin
      `uvm_fatal("CNTXT", "Context handle is null")
   end
   
endfunction : build_phase


function void uvml_logs_seq_item_logger_c::end_of_elaboration_phase(uvm_phase phase);
   
   uvm_component  parent = get_parent();
   
   super.end_of_elaboration_phase(phase);
   
   // Assemble final path
   if (name == "") begin
      fpath = {test_results_path, "/", sub_dir, "/", parent.get_full_name(), ".seq_item.", fextension};
   end
   else begin
      fpath = {test_results_path, "/", sub_dir, "/", parent.get_full_name(), name, ".seq_item.", fextension};
   end
   
   // Opem file handle and check 
   fhandle       = $fopen(fpath, "w");
   fhandle_valid = (fhandle != 0);
   
   print_header();
   
endfunction : end_of_elaboration_phase


function void uvml_logs_seq_item_logger_c::final_phase(uvm_phase phase);
   
   super.final_phase(phase);
   
   $fclose(fhandle);
   
endfunction : final_phase


function void uvml_logs_seq_item_logger_c::write(T_TRN t);
   
   `uvm_fatal("LOGGER", "Call to pure virtual function")
   
endfunction : write


function void uvml_logs_seq_item_logger_c::print_header();
   
   `uvm_fatal("LOGGER", "Call to pure virtual function")
   
endfunction : print_header


function void uvml_logs_seq_item_logger_c::fwrite(string msg);
   
   if (fhandle_valid) begin
      $fwrite(fhandle, {msg, "\n"});
   end
   
endfunction : fwrite


function string uvml_logs_seq_item_logger_c::log_bytes(ref bit [7:0] bytes[]);
   
   foreach (bytes[ii]) begin
      log_bytes = {$sformatf("%h", bytes[ii]), log_bytes};
      if ((ii % 2) && (ii != (bytes.size()-1))) begin
         log_bytes = {"_", log_bytes};
      end
   end
   
endfunction : log_bytes


`endif // __UVML_LOGS_SEQ_ITEM_LOGGER_SV__
