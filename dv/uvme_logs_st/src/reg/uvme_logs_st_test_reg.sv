// Copyright 2021 Datum Technology Corporation
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __UVME_LOGS_ST_TEST_REG_SV__
`define __UVME_LOGS_ST_TEST_REG_SV__


/**
 * TODO Describe uvme_logs_st_test_reg_c
 */
class uvme_logs_st_test_reg_c extends uvm_reg;
   
   // Register fields
   rand uvm_reg_field  field_a;
   rand uvm_reg_field  field_b;
   rand uvm_reg_field  field_c;
   
   
   `uvm_object_utils_begin(uvme_logs_st_test_reg_c)
      `uvm_field_object(field_a, UVM_DEFAULT)
      `uvm_field_object(field_b, UVM_DEFAULT)
      `uvm_field_object(field_c, UVM_DEFAULT)
   `uvm_object_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvme_logs_st_test_reg", int unsigned n_bits=32, int has_coverage=UVM_NO_COVERAGE);
   
   /**
    * Creates and configures register fields.
    */
   extern function void build();
   
endclass : uvme_logs_st_test_reg_c


function uvme_logs_st_test_reg_c::new(string name="uvme_logs_st_test_reg", int unsigned n_bits=32, int has_coverage=UVM_NO_COVERAGE);
   
   super.new(name, n_bits, has_coverage);
   
endfunction : new


function void uvme_logs_st_test_reg_c::build();
   
   field_a = uvm_reg_field::type_id::create("field_a");
   field_a.configure(
      .parent                 (this),
      .size                   (  16),
      .lsb_pos                (   0),
      .access                 ("RW"),
      .volatile               (   0),
      .reset                  (   0),
      .has_reset              (   1),
      .is_rand                (   1),
      .individually_accessible(   1)
   );
   
   field_b = uvm_reg_field::type_id::create("field_b");
   field_b.configure(
      .parent                 (this),
      .size                   (   1),
      .lsb_pos                (  16),
      .access                 ("RW"),
      .volatile               (   0),
      .reset                  (   0),
      .has_reset              (   1),
      .is_rand                (   1),
      .individually_accessible(   1)
   );
   
   field_c = uvm_reg_field::type_id::create("field_c");
   field_c.configure(
      .parent                 (this),
      .size                   (   8),
      .lsb_pos                (  17),
      .access                 ("RO"),
      .volatile               (   0),
      .reset                  (   0),
      .has_reset              (   1),
      .is_rand                (   1),
      .individually_accessible(   1)
   );
   
endfunction: build


`endif // __UVME_LOGS_ST_TEST_REG_SV__
