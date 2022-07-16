// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVML_LOGS_PKG_SV__
`define __UVML_LOGS_PKG_SV__


// Pre-processor macros
`include "uvm_macros.svh"
`include "uvml_macros.svh"
`include "uvml_logs_macros.svh"


/**
 * Encapsulates all the types needed for the Moore.io Logging Utilities library.
 */
package uvml_logs_pkg;

   import uvm_pkg ::*;
   import uvml_pkg::*;

   // Constants / Structs / Enums
   `include "uvml_logs_tdefs.sv"
   `include "uvml_logs_constants.sv"

   // Objects
   `include "uvml_logs_reg_logger_cbs.sv"
   `include "uvml_logs_reg_logger_json_cbs.sv"
   `include "uvml_logs_rs_json.sv"
   `include "uvml_logs_rs_text.sv"

   // Components
   `include "uvml_logs_metadata_logger.sv"
   `include "uvml_logs_seq_item_logger.sv"
   `include "uvml_logs_mon_trn_logger.sv"

endpackage : uvml_logs_pkg


`endif // __UVML_LOGS_PKG_SV__
