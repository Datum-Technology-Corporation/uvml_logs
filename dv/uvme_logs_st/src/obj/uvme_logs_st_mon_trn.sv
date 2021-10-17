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


`ifndef __UVME_LOGS_ST_MON_TRN_SV__
`define __UVME_LOGS_ST_MON_TRN_SV__


/**
 * TODO Describe uvme_logs_st_mon_trn_c
 */
class uvme_logs_st_mon_trn_c extends uvml_mon_trn_c;
   
   // Fields
   rand int unsigned    number  ; ///< 
        logic [7:0]     raw_data; ///< 
   rand uvml_edge_enum  enum_val; ///< 
   
   
   `uvm_object_utils_begin(uvme_logs_st_mon_trn_c)
      `uvm_field_int (                number  , UVM_DEFAULT + UVM_DEC)
      `uvm_field_int (                raw_data, UVM_DEFAULT          )
      `uvm_field_enum(uvml_edge_enum, enum_val, UVM_DEFAULT          )
   `uvm_object_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvme_logs_st_mon_trn");
   
endclass : uvme_logs_st_mon_trn_c


function uvme_logs_st_mon_trn_c::new(string name="uvme_logs_st_mon_trn");
   
   super.new(name);
   
endfunction : new


`endif // __UVME_LOGS_ST_MON_TRN_SV__
