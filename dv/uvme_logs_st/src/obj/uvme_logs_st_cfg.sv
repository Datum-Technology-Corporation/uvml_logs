// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
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
