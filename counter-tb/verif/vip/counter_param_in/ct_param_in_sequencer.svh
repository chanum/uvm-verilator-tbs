

`ifndef CT_PARAM_IN_SEQUENCER_SVH
`define CT_PARAM_IN_SEQUENCER_SVH

class ct_param_in_sequencer #(int DATA_WIDTH = 8) 
  extends uvm_sequencer #(ct_param_in_seq_item #(DATA_WIDTH));
  `uvm_component_utils(ct_param_in_sequencer #(DATA_WIDTH));

  function new(input string name, uvm_component parent = null);
    super.new(name, parent);
  endfunction : new

endclass : ct_param_in_sequencer

`endif