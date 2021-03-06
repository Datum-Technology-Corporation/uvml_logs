// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_LOGS_ST_MON_TRN_SV__
`define __UVME_LOGS_ST_MON_TRN_SV__


/**
 * TODO Describe uvme_logs_st_mon_trn_c
 */
class uvme_logs_st_mon_trn_c extends uvml_mon_trn_c;
   
   // Fields
   rand int unsigned    number  ; ///< 
   rand uvml_edge_enum  enum_val; ///< 
        logic [7:0]     raw_data; ///< 
   
   
   `uvm_object_utils_begin(uvme_logs_st_mon_trn_c)
      `uvm_field_int (                number  , UVM_DEFAULT + UVM_DEC)
      `uvm_field_enum(uvml_edge_enum, enum_val, UVM_DEFAULT          )
      `uvm_field_int (                raw_data, UVM_DEFAULT          )
   `uvm_object_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvme_logs_st_mon_trn");
   
   /**
    * TODO Describe uvme_logs_st_mon_trn_c::get_metadata()
    */
   extern virtual function uvml_metadata_t get_metadata();
   
endclass : uvme_logs_st_mon_trn_c


function uvme_logs_st_mon_trn_c::new(string name="uvme_logs_st_mon_trn");
   
   super.new(name);
   
endfunction : new


function uvml_metadata_t uvme_logs_st_mon_trn_c::get_metadata();
   
   string number_str   = $sformatf("%d", number);
   string enum_str     = enum_val.name();
   string raw_data_str = $sformatf("%b", raw_data);
   
   get_metadata[0] = '{
      index     : 0,
      value     : number_str,
      col_name  : "number",
      col_width :  12,
      col_align : UVML_TEXT_ALIGN_RIGHT,
      data_type : UVML_FIELD_INT
   };
   
   get_metadata[1] = '{
      index     : 1,
      value     : enum_str,
      col_name  : "enum",
      col_width :  22,
      col_align : UVML_TEXT_ALIGN_CENTER,
      data_type : UVML_FIELD_ENUM
   };
   
   get_metadata[2] = '{
      index     : 2,
      value     : raw_data_str,
      col_name  : "raw_data",
      col_width :  10,
      col_align : UVML_TEXT_ALIGN_RIGHT,
      data_type : UVML_FIELD_INT
   };
   
endfunction : get_metadata


`endif // __UVME_LOGS_ST_MON_TRN_SV__
