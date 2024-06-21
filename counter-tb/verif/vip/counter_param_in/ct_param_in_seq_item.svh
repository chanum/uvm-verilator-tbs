
`ifndef CT_PARAM_IN_SEQ_ITEM_SVH
`define CT_PARAM_IN_SEQ_ITEM_SVH

class ct_param_in_seq_item #(int DATA_WIDTH = 8) extends uvm_sequence_item;
  `uvm_object_utils(ct_param_in_seq_item #(DATA_WIDTH));

  rand logic [DATA_WIDTH-1:0]   data;
  rand logic                    ld;

  rand int                      delay_cycles;

  constraint delay_cycles_range {
    delay_cycles dist {
      0       := 90,
      [1 : 4] :/ 10
    };
  }

  function new(string name = "ct_param_in_seq_item");
    super.new(name);
  endfunction : new

  function void do_copy(uvm_object rhs);
    ct_param_in_seq_item #(DATA_WIDTH) rhs_;

    if (!$cast(rhs_, rhs)) begin
      `uvm_error({this.get_name(), ".do_copy()"}, "Cast failed!");
      return;
    end

    /*  chain the copy with parent classes  */
    super.do_copy(rhs);

    /*  list of local properties to be copied  */
    this.data = rhs_.data;
    this.ld = rhs_.ld;
  endfunction : do_copy

  function bit do_compare(uvm_object rhs, uvm_comparer comparer);
    ct_param_in_seq_item #(DATA_WIDTH) rhs_;

    if (!$cast(rhs_, rhs)) begin
      `uvm_error({this.get_name(), ".do_compare()"}, "Cast failed!");
      return 0;
    end

    /*  chain the compare with parent classes  */
    do_compare = super.do_compare(rhs, comparer);

    do_compare &= comparer.compare_field("data", this.data, rhs_.data, $bits(data));
    do_compare &= comparer.compare_field("ld", this.ld, rhs_.ld, $bits(ld));
  endfunction : do_compare

  function string convert2string();
    string s;

    /*  chain the convert2string with parent classes  */
    s = super.convert2string();

    s = {s, $sformatf("Payload data: 0x%0h", data)};
    s = {s, $sformatf("\t Payload ld: 0x%0h", ld)};

    return s;
  endfunction : convert2string

endclass : ct_param_in_seq_item

`endif