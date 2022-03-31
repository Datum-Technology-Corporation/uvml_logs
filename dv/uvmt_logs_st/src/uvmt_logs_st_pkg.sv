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


`ifndef __UVMT_LOGS_ST_PKG_SV__
`define __UVMT_LOGS_ST_PKG_SV__


// Pre-processor macros
`include "uvm_macros.svh"
`include "uvml_macros.svh"
`include "uvml_logs_macros.svh"
`include "uvme_logs_st_macros.svh"
`include "uvmt_logs_st_macros.svh"

// Time units and precision for this test bench
timeunit       1ns;
timeprecision  1ps;

// Interface(s)
`include "uvmt_logs_st_clknrst_gen_if.sv"


/**
 * Encapsulates all the types and test cases for self-testing the Moore.io UVM Logging Extensions Library.
 */
package uvmt_logs_st_pkg;

   import uvm_pkg         ::*;
   import uvml_pkg        ::*;
   import uvml_logs_pkg   ::*;
   import uvme_logs_st_pkg::*;

   // Constants / Structs / Enums
   `include "uvmt_logs_st_tdefs.sv"
   `include "uvmt_logs_st_constants.sv"

   // Sequences

   // Base test
   `include "uvmt_logs_st_test_cfg.sv"
   `include "uvmt_logs_st_base_test.sv"
   `include "uvmt_logs_st_rs_test.sv"
   `include "uvmt_logs_st_traffic_test.sv"
   `include "uvmt_logs_st_reg_test.sv"

endpackage : uvmt_logs_st_pkg


// Module(s) / Checker(s)
`include "uvmt_logs_st_tb.sv"


`endif // __UVMT_LOGS_ST_PKG_SV__
