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


`ifndef __UVME_LOGS_ST_CNTXT_SV__
`define __UVME_LOGS_ST_CNTXT_SV__


/**
 * Object encapsulating all state variables for the UVM Logging Extensions Self-Testing environment (uvme_logs_st_env_c)
 * components.
 */
class uvme_logs_st_cntxt_c extends uvml_cntxt_c;
   
   // Agent context handles
   uvma_logs_cntxt_c  abc_cntxt;
   uvma_logs_cntxt_c  def_cntxt;
   
   // Events
   uvm_event  sample_cfg_e  ;
   uvm_event  sample_cntxt_e;
   
   
   `uvm_object_utils_begin(uvme_logs_st_cntxt_c)
      `uvm_field_object(abc_cntxt, UVM_DEFAULT)
      `uvm_field_object(def_cntxt, UVM_DEFAULT)
      
      `uvm_field_event(sample_cfg_e  , UVM_DEFAULT)
      `uvm_field_event(sample_cntxt_e, UVM_DEFAULT)
   `uvm_object_utils_end
   
   
   /**
    * Builds events and sub-context objects.
    */
   extern function new(string name="uvme_logs_st_cntxt");
   
   /**
    * TODO Describe uvme_logs_st_cntxt_c::reset()
    */
   extern function void reset();
   
endclass : uvme_logs_st_cntxt_c


function uvme_logs_st_cntxt_c::new(string name="uvme_logs_st_cntxt");
   
   super.new(name);
   
   abc_cntxt = uvma_logs_cntxt_c::type_id::create("abc_cntxt");
   def_cntxt = uvma_logs_cntxt_c::type_id::create("def_cntxt");
   
   sample_cfg_e   = new("sample_cfg_e"  );
   sample_cntxt_e = new("sample_cntxt_e");
   
endfunction : new


function void uvme_logs_st_cntxt_c::reset();
   
   
   
endfunction : reset


`endif // __UVME_LOGS_ST_CNTXT_SV__
