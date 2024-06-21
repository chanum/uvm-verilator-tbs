
`ifndef CT_PARAM_IN_MONITOR_SVH
`define CT_PARAM_IN_MONITOR_SVH

class ct_param_in_monitor #(int DATA_WIDTH = 8) extends uvm_monitor;
  `uvm_component_utils(ct_param_in_monitor #(DATA_WIDTH));

  ct_param_in_agent_config #(DATA_WIDTH)  m_cfg;
  virtual ct_param_in_if #(DATA_WIDTH)    m_vif;

  uvm_analysis_port #(ct_param_in_seq_item #(DATA_WIDTH)) aport;

  function new(string name = "ct_param_in_monitor", uvm_component parent = null);
    super.new(name, parent);

    aport = new("aport", this);
  endfunction : new

  function void build_phase(uvm_phase phase);

  endfunction : build_phase

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    m_vif = m_cfg.vif;
  endfunction : connect_phase

  task run_phase(uvm_phase phase);
    m_vif.wait_reset();

    forever begin
      ct_param_in_seq_item #(DATA_WIDTH) item;
      item = ct_param_in_seq_item #(DATA_WIDTH)::type_id::create("item", this);
      do_monitor(item);

      `uvm_info(this.get_full_name(), item.convert2string(), UVM_HIGH)
      aport.write(item);
    end
  endtask : run_phase

  task do_monitor(ct_param_in_seq_item #(DATA_WIDTH) item);
    @(posedge m_vif.clk);

    item.data = m_vif.data;
    item.ld = m_vif.ld;

  endtask : do_monitor

endclass : ct_param_in_monitor

`endif