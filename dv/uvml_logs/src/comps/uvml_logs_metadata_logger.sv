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


`ifndef __UVML_LOGS_METADATA_LOGGER_SV__
`define __UVML_LOGS_METADATA_LOGGER_SV__


/**
 * Logger writing sequence items debug info to disk.
 */
class uvml_logs_metadata_logger_c #(
   type T_TRN = uvm_object
) extends uvm_subscriber #(
   .T(T_TRN)
);
   // Configuration
   string                 file_name     ; ///< 
   uvml_logs_format_enum  format        ; ///< 
   string                 directory     ; ///< 
   int unsigned           time_col_width; ///< 
   
   // State
   uvml_file_c   file              ; ///< 
   bit           uses_groups       ; ///< 
   bit           file_is_open      ; ///< 
   int unsigned  col_header_size[$];
   
   
   `uvm_component_param_utils_begin(uvml_logs_metadata_logger_c#(.T_TRN(T_TRN)))
      `uvm_field_string(                       file_name     , UVM_DEFAULT          )
      `uvm_field_enum  (uvml_logs_format_enum, format        , UVM_DEFAULT          )
      `uvm_field_string(                       directory     , UVM_DEFAULT          )
      `uvm_field_int   (                       time_col_width, UVM_DEFAULT + UVM_DEC)
      
      `uvm_field_object(file        , UVM_DEFAULT)
      `uvm_field_int   (uses_groups , UVM_DEFAULT)
      `uvm_field_int   (file_is_open, UVM_DEFAULT)
   `uvm_component_utils_end
   
   
   /**
    * Default constructor
    */
   extern function new(string name="uvml_logs_metadata_logger", uvm_component parent=null);
   
   /**
    * Closes fhandle access
    */
   extern virtual function void final_phase(uvm_phase phase);
   
   /**
    * Writes contents of t to disk
    */
   extern virtual function void write(T_TRN t);
   
   /**
    * TODO Describe uvml_logs_metadata_logger_c::log_text()
    */
   extern function void log_text(ref uvml_metadata_t metadata);
   
   /**
    * TODO Describe uvml_logs_metadata_logger_c::log_json()
    */
   extern function void log_json(ref uvml_metadata_t metadata);
   
   /**
    * TODO Describe uvml_logs_metadata_logger_c::log_xml()
    */
   extern function void log_xml(ref uvml_metadata_t metadata);
   
   /**
    * TODO Describe uvml_logs_metadata_logger_c::log_yaml()
    */
   extern function void log_yaml(ref uvml_metadata_t metadata);
   
   /**
    * TODO Describe uvml_logs_metadata_logger_c::log_raw()
    */
   extern function void log_raw(ref uvml_metadata_t metadata);
   
   /**
    * TODO Describe uvml_logs_metadata_logger_c::get_file_name()
    */
   extern function string get_file_name();
   
   /**
    * TODO Describe uvml_logs_metadata_logger_c::set_file_name()
    */
   extern function void set_file_name(string val);
   
   /**
    * TODO Describe uvml_logs_metadata_logger_c::get_format()
    */
   extern function uvml_logs_format_enum get_format();
   
   /**
    * TODO Describe uvml_logs_metadata_logger_c::set_format()
    */
   extern function void set_format(uvml_logs_format_enum val);
   
   /**
    * TODO Describe uvml_logs_metadata_logger_c::get_directory()
    */
   extern function string get_directory();
   
   /**
    * TODO Describe uvml_logs_metadata_logger_c::set_directory()
    */
   extern function void set_directory(string val);
   
   /**
    * TODO Describe uvml_logs_metadata_logger_c::get_file_extension()
    */
   extern function string get_file_extension();
   
endclass : uvml_logs_metadata_logger_c


function uvml_logs_metadata_logger_c::new(string name="uvml_logs_metadata_logger", uvm_component parent=null);
   
   super.new(name, parent);
   format       = UVML_LOGS_FORMAT_TEXT;
   directory    = uvml_logs_default_trn_log_dir_name;
   uses_groups  = 0;
   file_is_open = 0;
   time_col_width = 12;
   
   if (parent != null) begin
      file_name = {parent.get_full_name()};
   end
   
endfunction : new


function void uvml_logs_metadata_logger_c::final_phase(uvm_phase phase);
   
   super.final_phase(phase);
   //file.close();
   
endfunction : final_phase


function void uvml_logs_metadata_logger_c::write(T_TRN t);
   
   string           final_file_name;
   uvml_metadata_t  metadata       ;
   
   metadata = t.get_metadata();
   if (metadata.size() == 0) begin
      return;
   end
   
   `uvm_info("MON_TRN_LOGGER", $sformatf("Trying to log metadata (%0d entries)", metadata.size()), UVM_DEBUG)
   foreach (metadata[ii]) begin
      `uvm_info("MON_TRN_LOGGER", $sformatf("metadata[%0d]: %4p", ii, metadata[ii]), UVM_DEBUG)
   end
   
   if (!file_is_open) begin
      final_file_name = {file_name, ".", get_file_extension()};
      file = uvml_file_c::type_id::create("file");
      file.set_base_dir(UVML_FILE_BASE_DIR_TEST_RESULTS);
      file.set_path({directory, "/", final_file_name});
      file.open(UVM_WRITE);
   end
   
   case (format)
      UVML_LOGS_FORMAT_TEXT: log_text(metadata);
      UVML_LOGS_FORMAT_JSON: log_json(metadata);
      UVML_LOGS_FORMAT_XML : log_xml (metadata);
      UVML_LOGS_FORMAT_YAML: log_yaml(metadata);
      UVML_LOGS_FORMAT_RAW : log_raw (metadata);
      
      default: begin
         `uvm_fatal("MON_TRN_LOGGER", $sformatf("Invalid format: %s", format.name()))
      end
   endcase
   
   file_is_open = 1;
   
endfunction : write


function void uvml_logs_metadata_logger_c::log_text(ref uvml_metadata_t metadata);
   
   int unsigned  effective_col_width;
   string        col_padding_left_str;
   string        col_padding_right_str;
   int unsigned  col_padding_left;
   int unsigned  col_padding_right;
   string        out_str;
   string        time_format_spec;
   int unsigned  padding_len;
   
   if (!file_is_open) begin
      // Print column headers
      file.write("        TIME        ");
      foreach (metadata[ii]) begin
         if (metadata[ii].col_name.len() > metadata[ii].col_width) begin
            padding_len = 2;
         end
         else begin
            padding_len = metadata[ii].col_width + 2 - metadata[ii].col_name.len();
         end
         col_padding_left  = $rtoi($floor($itor(padding_len)/2.00));
         col_padding_right = $rtoi($ceil ($itor(padding_len)/2.00));
         col_padding_left_str  = {col_padding_left {" "}};
         col_padding_right_str = {col_padding_right{" "}};
         file.write({"|", col_padding_left_str, metadata[ii].col_name.toupper(), col_padding_right_str});
         col_header_size.push_back(col_padding_left + col_padding_right + metadata[ii].col_name.len() - 2);
      end
      file.write("\n--------------------");
      foreach (metadata[ii]) begin
         out_str = {(col_header_size[ii]+2){"-"}};
         out_str = {"|", out_str};
         file.write(out_str);
      end
      file.write("\n");
   end
   
   time_format_spec = {" %", $sformatf("%0d", time_col_width), "t "};
   file.write($sformatf(time_format_spec, $realtime()));
   foreach (metadata[ii]) begin
      effective_col_width = metadata[ii].col_width;
      if (metadata[ii].value.len() > metadata[ii].col_width) begin
         padding_len = 2;
         effective_col_width = metadata[ii].value.len();
      end
      if (col_header_size[ii] > effective_col_width) begin
         padding_len = 2;
         effective_col_width = col_header_size[ii];
      end
      padding_len = effective_col_width + 2 - metadata[ii].value.len();
      col_padding_left  = $rtoi($floor($itor(padding_len)/2.00));
      col_padding_right = $rtoi($ceil ($itor(padding_len)/2.00));
      col_padding_left_str  = {col_padding_left {" "}};
      col_padding_right_str = {col_padding_right{" "}};
      file.write({"|", col_padding_left_str, metadata[ii].value, col_padding_right_str});
   end
   file.write("\n");
   
endfunction : log_text


function void uvml_logs_metadata_logger_c::log_json(ref uvml_metadata_t metadata);
   
   `uvm_warning("MON_TRN_LOGGER", "JSON logging not yet implemented")
   
endfunction : log_json


function void uvml_logs_metadata_logger_c::log_xml(ref uvml_metadata_t metadata);
   
   `uvm_warning("MON_TRN_LOGGER", "XML logging not yet implemented")
   
endfunction : log_xml


function void uvml_logs_metadata_logger_c::log_yaml(ref uvml_metadata_t metadata);
   
   `uvm_warning("MON_TRN_LOGGER", "YAML logging not yet implemented")
   
endfunction : log_yaml


function void uvml_logs_metadata_logger_c::log_raw(ref uvml_metadata_t metadata);
   
   `uvm_warning("MON_TRN_LOGGER", "RAW logging not yet implemented")
   
endfunction : log_raw


function string uvml_logs_metadata_logger_c::get_file_name();
   
   return file_name;
   
endfunction : get_file_name


function void uvml_logs_metadata_logger_c::set_file_name(string val);
   
   file_name = val;
   
endfunction : set_file_name


function uvml_logs_format_enum uvml_logs_metadata_logger_c::get_format();
   
   return format;
   
endfunction : get_format


function void uvml_logs_metadata_logger_c::set_format(uvml_logs_format_enum val);
   
   format = val;
   
endfunction : set_format


function string uvml_logs_metadata_logger_c::get_directory();
   
   return directory;
   
endfunction : get_directory


function void uvml_logs_metadata_logger_c::set_directory(string val);
   
   directory = val;
   
endfunction : set_directory


function string uvml_logs_metadata_logger_c::get_file_extension();
   
   return uvml_logs_file_extensions[format];
   
endfunction : get_file_extension



`endif // __UVML_LOGS_METADATA_LOGGER_SV__
