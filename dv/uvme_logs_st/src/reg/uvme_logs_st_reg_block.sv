// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_LOGS_ST_REG_BLOCK_SV__
`define __UVME_LOGS_ST_REG_BLOCK_SV__


/**
 * TODO Describe uvme_logs_st_reg_block_c
 */
class uvme_logs_st_reg_block_c extends uvm_reg_block;
   
   uvme_logs_st_cfg_c    cfg  ;
   uvme_logs_st_cntxt_c  cntxt;
   
   // Sub-Blocks
   
   // Registers
   rand uvme_logs_st_test_reg_c  test_regs[128];
   
   
   `uvm_object_utils_begin(uvme_logs_st_reg_block_c)
      `uvm_field_sarray_object(test_regs, UVM_DEFAULT)
   `uvm_object_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvme_logs_st_reg_block", int has_coverage=UVM_NO_COVERAGE);
   
   /**
    * TODO Describe uvme_logs_st_reg_block::build().
    */
   extern virtual function void build();
   
   /**
    * TODO Describe uvme_logs_st_reg_block::connect().
    */
   extern virtual function void connect();
   
   /**
    * Creates sub-block(s).
    */
   extern virtual function void create_blocks();
   
   /**
    * Creates register(s).
    */
   extern virtual function void create_regs();
   
   /**
    * Creates default register map.
    */
   extern virtual function void create_reg_map();
   
   /**
    * Adds register(s) to register map.
    */
   extern virtual function void add_regs_to_map();
   
endclass : uvme_logs_st_reg_block_c


function uvme_logs_st_reg_block_c::new(string name="uvme_logs_st_reg_block", int has_coverage=UVM_NO_COVERAGE);
   
   super.new(name, has_coverage);
   
endfunction : new


function void uvme_logs_st_reg_block_c::build();
   
   create_blocks();
   create_regs  ();
   
endfunction : build


function void uvme_logs_st_reg_block_c::connect();
   
   create_reg_map ();
   add_regs_to_map();
   lock_model     ();
   
endfunction : connect


function void uvme_logs_st_reg_block_c::create_blocks();
   
   
   
endfunction : create_blocks


function void uvme_logs_st_reg_block_c::create_regs();
   
   foreach (test_regs[ii]) begin
      test_regs[ii] = uvme_logs_st_test_reg_c::type_id::create($sformatf("test_regs[%0d]", ii));
      test_regs[ii].configure(this);
      test_regs[ii].build();
   end
   
endfunction : create_regs


function void uvme_logs_st_reg_block_c::create_reg_map();
   
   default_map = create_map(
      .name     ("default_map"),
      .base_addr(0),
      .n_bytes  (4),
      .endian   (UVM_LITTLE_ENDIAN)
   );
   
endfunction : create_reg_map


function void uvme_logs_st_reg_block_c::add_regs_to_map();
   
   foreach (test_regs[ii]) begin
      default_map.add_reg(
         .rg    (test_regs[ii]),
         .offset(ii*4),
         .rights("RW")
      );
   end
   
endfunction : add_regs_to_map


`endif // _UVME_LOGS_ST_REG_BLOCK_SV__
