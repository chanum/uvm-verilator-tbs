//------------------------------------------------------------------------------
// PACKAGE: ct_env_pkg
//------------------------------------------------------------------------------
// Counter Control Environment package
//------------------------------------------------------------------------------
package ct_env_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  
  import ct_defn_pkg::*;
  import ct_param_in_agent_pkg::*;;
  // import ct_scoreboard_pkg::*;

  //------------------------------------------------------------------------------
  // CLASS: ct_env_config
  //------------------------------------------------------------------------------
  // Counter Control Environment configuration object
  //------------------------------------------------------------------------------
  class ct_env_config extends uvm_object;
    // UVM Factory Registration Macro.
    `uvm_object_utils(ct_env_config)

    // Agent usage flags
    bit has_ct_in_agent   = 1'b0;

    // Scoreboard usage flag
    bit has_scoreboard    = 1'b0;

    // Coverage usage flag
    bit has_coverage      = 1'b0;

    // Agent configuration objects
    ct_param_in_agent_config #(Q_DATA_WIDTH) m_ct_in_agent_config;

    function new(string name = "ct_env_config");
      super.new(name);
    endfunction : new

  endclass : ct_env_config

  //------------------------------------------------------------------------------
  // Class: ct_env
  //------------------------------------------------------------------------------
  // Counter Control Environment class
  //------------------------------------------------------------------------------
  class ct_env extends uvm_env;
    // UVM Factory Registration Macro.
    `uvm_component_utils(ct_env)

    // Environment's configuration object instantiation
    ct_env_config m_config;

    // Agents instantiation.
    ct_param_in_agent #(Q_DATA_WIDTH) m_ct_in_agent;

    // Scoreboard instantiation.
    // ct_scoreboard m_scoreboard;

    // Environment's constructor.
    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction : new

    // Environment's build phase.
    function void build_phase(uvm_phase phase);
      super.build_phase(phase);

      // Get Environment's configuration from database.
      if (!uvm_config_db#(ct_env_config)::get(this, "", "ct_env_config", m_config)) begin
        `uvm_fatal("Counter Control Env", "No configuration object specified")
      end

      // Create ct_in Agent if this is used
      if (m_config.has_ct_in_agent) begin
        // Create Agent.
        m_ct_in_agent = ct_param_in_agent#(Q_DATA_WIDTH)::type_id::create("m_ct_in_agent", this);
        // Get Agent's configuration object from database.
        uvm_config_db#(ct_param_in_agent_config#(Q_DATA_WIDTH))::set(this, "m_ct_in_agent", "m_config", m_config.m_ct_in_agent_config);
      end

      // Create Scoreboard if used.
      // if (m_config.has_scoreboard) begin
      //   m_scoreboard = ct_scoreboard::type_id::create("m_scoreboard", this);
      // end


    endfunction : build_phase

    // Environment's connect phase.
    function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);

      // // Connection between Soreboard and the monitor analysis port of ct_in agent
      // if (m_config.has_scoreboard && m_config.has_ct_in_agent) begin
      //   m_ct_in_agent.aport.connect(m_scoreboard.ct_in_export);
      // end

      // // Connection between Soreboard and the monitor analysis port of ct_out agent
      // if (m_config.has_scoreboard && m_config.has_ct_out_agent) begin
      //   m_ct_out_agent.aport.connect(m_scoreboard.ct_out_export);
      // end

      // // Connection between Coverage and the monitor analysis port of ct_out agent
      // if (m_config.has_coverage && m_config.has_ct_out_agent) begin
      //   m_ct_out_agent.aport.connect(m_coverage.ct_out_fifo.analysis_export);
      // end

      // // Connection between Coverage and the monitor analysis port of ct_in agent
      // if (m_config.has_coverage && m_config.has_ct_out_agent) begin
      //   m_ct_in_agent.aport.connect(m_coverage.ct_in_fifo.analysis_export);
      // end
      
    endfunction : connect_phase

  endclass : ct_env
  
endpackage : ct_env_pkg