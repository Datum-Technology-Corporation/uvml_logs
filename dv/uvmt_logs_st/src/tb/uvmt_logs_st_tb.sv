// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMT_LOGS_ST_TB_SV__
`define __UVMT_LOGS_ST_TB_SV__


/**
 * Module starting and ending simulation for the Moore.io UVM Logging Extensions Self-Testing Test Bench..
 */
module uvmt_logs_st_tb;

   import uvm_pkg         ::*;
   import uvmt_logs_st_pkg::*;

   // Clocking & Reset
   uvmt_logs_st_clknrst_gen_if  clknrst_gen_if();


   /**
    * Test bench entry point.
    */
   initial begin
      // Specify time format for simulation
      $timeformat(
         .units_number       (   -9),
         .precision_number   (    3),
         .suffix_string      (" ns"),
         .minimum_field_width(   18)
      );

      // Add interfaces to uvm_config_db
      uvm_config_db#(virtual uvmt_logs_st_clknrst_gen_if)::set(null, "*", "clknrst_gen_vif", clknrst_gen_if);

      // Run test
      uvm_top.enable_print_topology = 0;
      uvm_top.finish_on_completion  = 1;
      uvm_top.run_test();
   end

endmodule : uvmt_logs_st_tb


`endif // __UVMT_LOGS_ST_TB_SV__
