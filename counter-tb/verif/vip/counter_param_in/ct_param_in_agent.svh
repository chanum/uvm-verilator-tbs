
`ifndef CT_PARAM_IN_AGENT_SVH
`define CT_PARAM_IN_AGENT_SVH

class ct_param_in_agent #(int DATA_WIDTH = 8) extends uvm_agent;
  `uvm_component_utils(ct_param_in_agent #(DATA_WIDTH))

  uvm_analysis_port #(ct_param_in_seq_item #(DATA_WIDTH)) aport;

  ct_param_in_agent_config  #(DATA_WIDTH)   m_config;
  ct_param_in_sequencer     #(DATA_WIDTH)   m_sequencer;
  ct_param_in_driver        #(DATA_WIDTH)   m_driver;
  ct_param_in_monitor       #(DATA_WIDTH)   m_monitor;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if (m_config == null) begin
      if (!uvm_config_db#(ct_param_in_agent_config#(DATA_WIDTH))::get(this, "", "m_config", m_config)) begin
        `uvm_fatal(this.get_full_name, "No ct_param_in_agent config specified!")
      end
    end

    if (m_config.active == UVM_ACTIVE) begin
      m_sequencer = ct_param_in_sequencer#(DATA_WIDTH)::type_id::create("m_sequencer", this);
      m_driver = ct_param_in_driver#(DATA_WIDTH)::type_id::create("m_driver", this);
      m_driver.m_cfg = m_config;
    end

    m_monitor = ct_param_in_monitor#(DATA_WIDTH)::type_id::create("m_monitor", this);
    m_monitor.m_cfg = m_config;

    aport = new("aport", this);
  endfunction : build_phase

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    if (m_config.active == UVM_ACTIVE) begin
      m_driver.seq_item_port.connect(m_sequencer.seq_item_export);
    end

    m_monitor.aport.connect(aport);
  endfunction

endclass : ct_param_in_agent

`endif