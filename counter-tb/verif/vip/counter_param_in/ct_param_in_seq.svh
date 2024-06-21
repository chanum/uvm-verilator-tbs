

`ifndef CT_PARAM_IN_SEQ_SVH
`define CT_PARAM_IN_SEQ_SVH

class ct_param_in_seq_base #(int DATA_WIDTH = 8) 
  extends uvm_sequence #(ct_param_in_seq_item #(DATA_WIDTH));

  // UVM Factory Registration Macro.
  `uvm_object_param_utils(ct_param_in_seq_base #(DATA_WIDTH))

  // Declare sequencer type.
  `uvm_declare_p_sequencer(ct_param_in_sequencer #(DATA_WIDTH))

  function new (string name = "");
    super.new(name);
  endfunction: new

endclass : ct_param_in_seq_base

class ct_param_in_rand_seq extends ct_param_in_seq_base;
  // UVM Factory Registration Macro.
  `uvm_object_utils(ct_param_in_rand_seq)

  // Utility variables.
  int length = 1;

  // Seq's constructor.
  function new(string name = "ct_param_in_rand_seq");
    super.new(name);
  endfunction : new

  // Main task executed by the sequence.
  task body;
    ct_param_in_seq_item #(DATA_WIDTH) seq_item;
    // Create new seq item.
    seq_item = ct_param_in_seq_item#(DATA_WIDTH)::type_id::create("seq_item");

    for (int i = 0; i < length; i++) begin
      start_item(seq_item);
      if (!seq_item.randomize()) begin
        `uvm_error(get_name(), "Failed to randomize random seq!");
      end
      finish_item(seq_item);
    end

  endtask : body

endclass : ct_param_in_rand_seq

class ct_param_in_fibo_seq extends ct_param_in_seq_base;
  // UVM Factory Registration Macro.
  `uvm_object_utils(ct_param_in_fibo_seq)

  // Utility variables.
  int length = 10;

  // Seq's constructor.
  function new(string name = "ct_param_in_fibo_seq");
    super.new(name);
  endfunction : new

  // Main task executed by the sequence.
  task body;
    bit [DATA_WIDTH-1:0] data = 0;
    bit [DATA_WIDTH-1:0] data_next = 1;
    bit [DATA_WIDTH-1:0] data_aux;
    ct_param_in_seq_item #(DATA_WIDTH) seq_item;
    // Create new seq item.
    seq_item = ct_param_in_seq_item#(DATA_WIDTH)::type_id::create("seq_item");

    for (int i = 0; i < length; i++) begin
      seq_item.ld = 1'b1;
      seq_item.data = data;
      start_item(seq_item);
      finish_item(seq_item);
      data_aux = data;
      data = data_next;
      data_next = data + data_aux;
    end

  endtask : body

endclass : ct_param_in_fibo_seq

`endif