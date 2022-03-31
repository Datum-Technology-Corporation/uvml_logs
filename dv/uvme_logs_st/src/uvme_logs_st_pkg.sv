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


`ifndef __UVME_LOGS_ST_PKG_SV__
`define __UVME_LOGS_ST_PKG_SV__


// Pre-processor macros
`include "uvm_macros.svh"
`include "uvml_macros.svh"
`include "uvml_logs_macros.svh"
`include "uvme_logs_st_macros.svh"

// Interface(s)


 /**
 * Encapsulates all the types needed for an UVM environment capable of self-testing the Moore.io UVM Logging Extensions
 * Library.
 */
package uvme_logs_st_pkg;

   import uvm_pkg      ::*;
   import uvml_pkg     ::*;
   import uvml_logs_pkg::*;

   // Constants / Structs / Enums
   `include "uvme_logs_st_tdefs.sv"
   `include "uvme_logs_st_constants.sv"

   // Register Abstraction Layer
   `include "uvme_logs_st_reg_adapter.sv"
   `include "uvme_logs_st_test_reg.sv"
   `include "uvme_logs_st_reg_block.sv"

   // Objects
   `include "uvme_logs_st_cfg.sv"
   `include "uvme_logs_st_cntxt.sv"
   `include "uvme_logs_st_mon_trn.sv"
   `include "uvme_logs_st_seq_item.sv"

   // Environment components
   `include "uvme_logs_st_cov_model.sv"
   `include "uvme_logs_st_mon_trn_logger.sv"
   `include "uvme_logs_st_seq_item_logger.sv"
   `include "uvme_logs_st_mon_trn_sqr.sv"
   `include "uvme_logs_st_seq_item_sqr.sv"
   `include "uvme_logs_st_vsqr.sv"
   `include "uvme_logs_st_env.sv"

   // Sequences
   `include "uvme_logs_st_base_vseq.sv"
   `include "uvme_logs_st_vseq_lib.sv"

endpackage : uvme_logs_st_pkg


// Module(s) / Checker(s)


`endif // __UVME_LOGS_ST_PKG_SV__
