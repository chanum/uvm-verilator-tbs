package mem_env_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  import mem_agent_pkg::*;
  import mem_scoreboard_pkg::*;

  class mem_env_config extends uvm_object;
    `uvm_object_utils(mem_env_config)

    // Agent usage flags
    bit has_mem_agent = 1;

    // Scoreboard usage flag
    bit has_scoreboard = 1;

    // Agent configuration objects
    mem_agent_config mem_agent_cnfg;

    function new(string name = "mem_env_config");
      super.new(name);
    endfunction : new

  endclass : mem_env_config

  class mem_env extends uvm_env;

    // Environment's configuration object instantiation.
    mem_env_config m_config;

    // Agents instantiation
    mem_agent      mem_agnt;

    // Scoreboard instantiation.
    mem_scoreboard mem_scb;

    `uvm_component_utils(mem_env)

    //---------------------------------------
    // constructor
    //---------------------------------------
    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction : new

    //---------------------------------------
    // build_phase - crate the components
    //---------------------------------------
    function void build_phase(uvm_phase phase);
      super.build_phase(phase);

      // Get Environment's configuration from database.
      if (!uvm_config_db#(mem_env_config)::get(this, "", "mem_env_config", m_config)) begin
        `uvm_fatal("Mem Env", "No configuration object specified")
      end
      
      // Create Agent 
      if (m_config.has_mem_agent) begin
        mem_agnt = mem_agent::type_id::create("mem_agnt", this);
        // Set Agent's configuration object from database.
        uvm_config_db#(mem_agent_config)::set(uvm_root::get(), "*", "m_agt_config", m_config.mem_agent_cnfg);
      end

      // Create Scoreboard 
      if (m_config.has_scoreboard) begin 
        mem_scb = mem_scoreboard::type_id::create("mem_scb", this);
      end

    endfunction : build_phase

    //---------------------------------------
    // connect_phase - connecting monitor and scoreboard port
    //---------------------------------------
    function void connect_phase(uvm_phase phase);
      mem_agnt.aport.connect(mem_scb.item_collected_export);
    endfunction : connect_phase

  endclass : mem_env

endpackage : mem_env_pkg
