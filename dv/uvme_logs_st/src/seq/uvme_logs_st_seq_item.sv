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


`ifndef __UVME_LOGS_SEQ_ITEM_SV__
`define __UVME_LOGS_SEQ_ITEM_SV__


/**
 * TODO Describe uvme_logs_st_seq_item_c
 */
class uvme_logs_st_seq_item_c extends uvml_seq_item_c;
   
   // Fields
   rand bit          we     ; ///< 
   rand bit [31:00]  address; ///< 
   rand bit [31:00]  wdata  ; ///< 
   rand bit [31:00]  rdata  ; ///< 
   rand bit [03:00]  be     ; ///< 
   
   
   `uvm_object_utils_begin(uvme_logs_st_seq_item_c)
      `uvm_field_int(we     , UVM_DEFAULT)
      `uvm_field_int(address, UVM_DEFAULT)
      `uvm_field_int(wdata  , UVM_DEFAULT)
      `uvm_field_int(rdata  , UVM_DEFAULT)
      `uvm_field_int(be     , UVM_DEFAULT)
   `uvm_object_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvme_logs_st_seq_item");
   
   /**
    * TODO Describe uvme_logs_st_seq_item_c::get_metadata()
    */
   extern virtual function uvml_metadata_t get_metadata();
   
endclass : uvme_logs_st_seq_item_c


function uvme_logs_st_seq_item_c::new(string name="uvme_logs_st_seq_item");
   
   super.new(name);
   
endfunction : new


function uvml_metadata_t uvme_logs_st_seq_item_c::get_metadata();
   
   string we_str    = $sformatf("%d", we);
   string addr_str  = $sformatf("%h", address);
   string wdata_str = $sformatf("%h", wdata);
   string rdata_str = $sformatf("%h", rdata);
   string be_str    = $sformatf("%b", be);
   
   get_metadata[0] = '{
      index     : 0,
      value     : we_str,
      col_name  : "we",
      col_width : 4,
      col_align : UVML_TEXT_ALIGN_RIGHT,
      data_type : UVML_FIELD_INT
   };
   
   get_metadata[] = '{
      index     : 1,
      value     : addr_str,
      col_name  : "addr",
      col_width :  10,
      col_align : UVML_TEXT_ALIGN_RIGHT,
      data_type : UVML_FIELD_INT
   };
   
   get_metadata[3]= '{
      index     : 2,
      value     : wdata_str,
      col_name  : "wdata",
      col_width :  10,
      col_align : UVML_TEXT_ALIGN_RIGHT,
      data_type : UVML_FIELD_INT
   };
   
   get_metadata[4] = '{
      index     : 3,
      value     : rdata_str,
      col_name  : "rdata",
      col_width :  10,
      col_align : UVML_TEXT_ALIGN_RIGHT,
      data_type : UVML_FIELD_INT
   };
   
   get_metadata[2] = '{
      index     : 4,
      value     : be_str,
      col_name  : "be",
      col_width :  6,
      col_align : UVML_TEXT_ALIGN_RIGHT,
      data_type : UVML_FIELD_INT
   };
   
endfunction : get_metadata


`endif // __UVME_LOGS_SEQ_ITEM_SV__
