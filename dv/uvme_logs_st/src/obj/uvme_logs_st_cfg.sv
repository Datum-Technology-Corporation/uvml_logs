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


`ifndef __UVME_LOGS_ST_CFG_SV__
`define __UVME_LOGS_ST_CFG_SV__


/**
 * Object encapsulating all parameters for creating, connecting and running the Moore.io UVM Logging Extensions
 * Self-Testing Environment (uvme_logs_st_env_c) components.
 */
class uvme_logs_st_cfg_c extends uvml_cfg_c;
   
   // Integrals
   rand bit                      enabled;
   rand uvm_active_passive_enum  is_active;
   rand bit                      cov_model_enabled;
   rand bit                      trn_log_enabled;
   
   // Objects
   rand uvme_logs_st_reg_block_c  reg_block;
   
   
   `uvm_object_utils_begin(uvme_logs_st_cfg_c)
      `uvm_field_int (                         enabled              , UVM_DEFAULT)
      `uvm_field_enum(uvm_active_passive_enum, is_active            , UVM_DEFAULT)
      `uvm_field_int (                         cov_model_enabled    , UVM_DEFAULT)
      `uvm_field_int (                         trn_log_enabled      , UVM_DEFAULT)
      
      `uvm_field_object(reg_block, UVM_DEFAULT)
   `uvm_object_utils_end
   
   
   constraint defaults_cons {
      soft enabled                == 0;
      soft is_active              == UVM_PASSIVE;
      soft cov_model_enabled      == 0;
      soft trn_log_enabled        == 1;
   }
   
   
   /**
    * Creates sub-configuration objects.
    */
   extern function new(string name="uvme_logs_st_cfg");
   
endclass : uvme_logs_st_cfg_c


function uvme_logs_st_cfg_c::new(string name="uvme_logs_st_cfg");
   
   super.new(name);
   reg_block = uvme_logs_st_reg_block_c::type_id::create("reg_block");
   reg_block.build();
   
endfunction : new


`endif // __UVME_LOGS_ST_CFG_SV__
