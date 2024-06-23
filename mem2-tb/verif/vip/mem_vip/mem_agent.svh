
class mem_agent extends uvm_agent;
  
  uvm_analysis_port #(mem_seq_item) aport;

  mem_agent_config m_config;

  //---------------------------------------
  // component instances
  //---------------------------------------
  mem_driver    driver;
  mem_sequencer sequencer;
  mem_monitor   monitor;

  `uvm_component_utils(mem_agent)

  //---------------------------------------
  // constructor
  //---------------------------------------
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  //---------------------------------------
  // build_phase
  //---------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if (m_config == null) begin
      if (!uvm_config_db#(mem_agent_config)::get(this, "", "m_agt_config", m_config)) begin
        `uvm_fatal(this.get_full_name(), "No mem_agent config specified!")
      end
    end

     if (m_config.active == UVM_ACTIVE) begin
      sequencer = mem_sequencer::type_id::create("sequencer", this);
      driver = mem_driver::type_id::create("driver", this);
      // driver.m_cfg = m_config;
    end

    monitor = mem_monitor::type_id::create("monitor", this);
    // monitor.m_cfg = m_config;

    aport = new("aport", this);
  endfunction : build_phase

  //---------------------------------------
  // connect_phase - connecting the driver and sequencer port
  //---------------------------------------
  function void connect_phase(uvm_phase phase);
    if (m_config.active == UVM_ACTIVE) begin
      driver.seq_item_port.connect(sequencer.seq_item_export);
    end

    monitor.item_collected_port.connect(aport);
  endfunction : connect_phase

endclass : mem_agent
