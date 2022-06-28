// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_LOGS_ST_VSEQ_LIB_SV__
`define __UVME_LOGS_ST_VSEQ_LIB_SV__


`include "uvme_logs_st_traffic_vseq.sv"
`include "uvme_logs_st_reg_vseq.sv"


/**
 * TODO Describe uvme_logs_st_vseq_lib_c
 */
class uvme_logs_st_vseq_lib_c extends uvml_vseq_lib_c #(
   .REQ(uvm_sequence_item),
   .RSP(uvm_sequence_item)
);
   
   `uvm_object_utils          (uvme_logs_st_vseq_lib_c)
   `uvm_sequence_library_utils(uvme_logs_st_vseq_lib_c)
   
   
   /**
    * Initializes sequence library
    */
   extern function new(string name="uvme_logs_st_vseq_lib");
   
endclass : uvme_logs_st_vseq_lib_c


function uvme_logs_st_vseq_lib_c::new(string name="uvme_logs_st_vseq_lib");
   
   super.new(name);
   init_sequence_library();
   
   add_sequence(uvme_logs_st_traffic_vseq_c::get_type());
   add_sequence(uvme_logs_st_reg_vseq_c    ::get_type());
   
endfunction : new


`endif // __UVME_LOGS_ST_VSEQ_LIB_SV__
