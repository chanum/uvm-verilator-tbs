// Package: ct_vseq_pkg
// Package of the sequencies used to estimulate the DUT

package ct_vseq_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  import ct_defn_pkg::*;
  import ct_param_in_agent_pkg::*;

  class ct_base_vseq extends uvm_sequence #(uvm_sequence_item);
    // UVM Factory Registration Macro
    `uvm_object_utils(ct_base_vseq)

    // Sequencer for any sequencie item
    ct_param_in_sequencer #(Q_DATA_WIDTH) ct_in_sqr;

    function new(string name = "ct_base_vseq");
      super.new(name);
    endfunction : new

  endclass : ct_base_vseq


  class ct_rand_vseq extends ct_base_vseq;
    // UVM Factory Registration Macro
    `uvm_object_utils(ct_rand_vseq)

    function new(string name = "ct_rand_vseq");
      super.new(name);
    endfunction : new

    task body;
      int n;
      ct_param_in_seq_item #(Q_DATA_WIDTH) item;

      // Loop to create SIM_PKT_NUM packets
      // while (n) begin
      //   ct_param_in_seq_item #(Q_DATA_WIDTH) item;
      //   item = ct_param_in_seq_item#(Q_DATA_WIDTH)::type_id::create("item");
      //   start_item(item, .sequencer(ct_in_sqr));

      //   if (!item.randomize()) begin
      //     `uvm_error(get_name(), "Failed to randomize, error sequence item!");
      //   end
      //   item.delay_cycles = 0;
      //   finish_item(item);
      //   n = n - 1;

      // end

      `uvm_do(item)

    endtask : body

  endclass : ct_rand_vseq

  // class fibo_vseq extends ct_base_vseq;
  //   // UVM Factory Registration Macro
  //   `uvm_object_utils(fibo_vseq)

  //   int n;

  //   function new(string name = "fibo_vseq");
  //     super.new(name);
  //   endfunction : new

  //   task body;
  //     ct_param_in_fibo_seq fibo_seq;

  //     fibo_seq = ct_param_in_fibo_seq::type_id::create("fibo_seq");

  //     fibo_seq.length = n;
  //     fibo_seq.start(ct_in_sqr);

  //   endtask : body

  // endclass : fibo_vseq

endpackage : ct_vseq_pkg
