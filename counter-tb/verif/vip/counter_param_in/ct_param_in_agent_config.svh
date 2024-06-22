

`ifndef CT_PARAM_IN_AGENT_CONFIG_SVH
`define CT_PARAM_IN_AGENT_CONFIG_SVH

class ct_param_in_agent_config #(int DATA_WIDTH = 8) extends uvm_object;
  `uvm_object_utils(ct_param_in_agent_config #(DATA_WIDTH))

  // virtual ct_param_in_if #(DATA_WIDTH)  vif;
  virtual ct_param_in_if  vif;

  uvm_active_passive_enum active            = UVM_ACTIVE;
  int                     initial_clk_count = 1;    

  function new(string name = "ct_param_in_agent_config");
    super.new(name);
  endfunction

endclass

`endif