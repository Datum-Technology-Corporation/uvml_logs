// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_LOGS_ST_MON_TRN_LOGGER_SV__
`define __UVME_LOGS_ST_MON_TRN_LOGGER_SV__


/**
 * TODO Describe uvme_logs_st_mon_trn_logger_c
 */
class uvme_logs_st_mon_trn_logger_c extends uvml_logs_mon_trn_logger_c #(
   .T_TRN  (uvme_logs_st_mon_trn_c),
   .T_CFG  (uvme_logs_st_cfg_c    ),
   .T_CNTXT(uvme_logs_st_cntxt_c  )
);
   
   `uvm_component_utils(uvme_logs_st_mon_trn_logger_c)
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvme_logs_st_mon_trn_logger", uvm_component parent=null);
   
   /**
    * Writes contents of t to disk
    */
   extern virtual function void write(uvme_logs_st_mon_trn_c t);
   
   /**
    * Writes log header to disk
    */
   extern virtual function void print_header();
   
endclass : uvme_logs_st_mon_trn_logger_c


function uvme_logs_st_mon_trn_logger_c::new(string name="uvme_logs_st_mon_trn_logger", uvm_component parent=null);
   
   super.new(name, parent);
   
endfunction : new


function void uvme_logs_st_mon_trn_logger_c::write(uvme_logs_st_mon_trn_c t);
   
   `uvm_info("MON_TRN_LOGGER", $sformatf("Printing transaction to file:\n%s", t.sprint()), UVM_LOW)
   fwrite($sformatf(" %t | %10d | %20s | %8b", $realtime(), t.number, t.enum_val.name(), t.raw_data));
   
endfunction : write


function void uvme_logs_st_mon_trn_logger_c::print_header();
   
   `uvm_info("MON_TRN_LOGGER", "Printing transation log header to file", UVM_LOW)
   fwrite("---------------------------------------------------------");
   fwrite("         TIME       |    DEC     |         ENUM         | RAW DATA");
   fwrite("---------------------------------------------------------");
   
endfunction : print_header


`endif // __UVME_LOGS_ST_MON_TRN_LOGGER_SV__
