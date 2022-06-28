// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVML_LOGS_SIM_SUMMARY_SV__
`define __UVML_LOGS_SIM_SUMMARY_SV__


/**
 * Module printing summary at the end of simulation.
 */
module uvml_logs_sim_summary;

   import uvm_pkg      ::*;
   import uvml_logs_pkg::*;

   /**
    * End-of-test summary printout.
    */
   final begin
      static int  error_count, fatal_count, warning_count;
      bit         sim_finished;

      uvm_report_server  rs = uvm_top.get_report_server();
      error_count   = rs.get_severity_count(UVM_ERROR  );
      fatal_count   = rs.get_severity_count(UVM_FATAL  );
      warning_count = rs.get_severity_count(UVM_WARNING);

      void'(uvm_config_db#(bit)::get(null, "", "sim_finished", sim_finished));
      if ((error_count == 0) && (fatal_count == 0) && sim_finished) begin
         $display({`UVML_LOGS_GREEN, "\n", uvml_logs_sim_summary_banner_passed});
         $display($sformatf(uvml_logs_sim_summary_sub_banner_passed, warning_count));
      end
      else begin
         $display({`UVML_LOGS_RED, "\n", uvml_logs_sim_summary_banner_failed});
         if (sim_finished == 0) begin
            if (fatal_count > 0) begin
               $display($sformatf(uvml_logs_sim_summary_sub_banner_failed_fatal, error_count));
            end
            else begin
               $display($sformatf(uvml_logs_sim_summary_sub_banner_failed_aborted, error_count));
            end
         end
         else begin
            $display($sformatf(uvml_logs_sim_summary_sub_banner_failed, error_count));
         end
      end
      $display(`UVML_LOGS_RESET);
   end

endmodule : uvml_logs_sim_summary


`endif // __UVML_LOGS_SIM_SUMMARY_SV__
