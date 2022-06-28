// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_LOGS_ST_TRAFFIC_VSEQ_SV__
`define __UVME_LOGS_ST_TRAFFIC_VSEQ_SV__


/**
 * TODO Describe uvme_logs_st_traffic_vseq_c
 */
class uvme_logs_st_traffic_vseq_c extends uvme_logs_st_base_vseq_c;
   
   // Fields
   rand int unsigned  num_trn; ///< 
   
   
   `uvm_object_utils_begin(uvme_logs_st_traffic_vseq_c)
      `uvm_field_int(num_trn, UVM_DEFAULT + UVM_DEC)
   `uvm_object_utils_end
   
   
   constraint limits_cons {
      num_trn > 0;
      num_trn <= 100;
   }
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvme_logs_st_traffic_vseq");
   
   /**
    * TODO Describe uvme_logs_st_traffic_vseq_c::body()
    */
   extern virtual task body();
   
endclass : uvme_logs_st_traffic_vseq_c


function uvme_logs_st_traffic_vseq_c::new(string name="uvme_logs_st_traffic_vseq");
   
   super.new(name);
   
endfunction : new


task uvme_logs_st_traffic_vseq_c::body();
   
   uvme_logs_st_mon_trn_c  mon_trn;
   
   for (int unsigned ii=0; ii<num_trn; ii++) begin
      `uvm_create_on(mon_trn, p_sequencer.mon_trn_sequencer)
      mon_trn.raw_data = $urandom_range(0,255);
      foreach (mon_trn.raw_data[ii]) begin
         randcase
            8: ;// do nothing
            1: mon_trn.raw_data[ii] = 1'bZ;
            1: mon_trn.raw_data[ii] = 1'bX;
         endcase
      end
      `uvm_info("TRAFFIC_VSEQ", $sformatf("Sending item #%0d of %0d:\n%s", ii+1, num_trn, mon_trn.sprint()), UVM_LOW)
      `uvm_rand_send(mon_trn)
      #100ns;
   end
   
endtask : body


`endif // __UVME_LOGS_ST_TRAFFIC_VSEQ_SV__
