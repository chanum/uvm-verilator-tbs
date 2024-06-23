
class mem_agent_config extends uvm_object;

  virtual mem_if vif;
  uvm_active_passive_enum active = UVM_ACTIVE;
  
  `uvm_object_utils(mem_agent_config)
    
  function new(string name = "mem_agent_config");
    super.new(name);
  endfunction

endclass : mem_agent_config
