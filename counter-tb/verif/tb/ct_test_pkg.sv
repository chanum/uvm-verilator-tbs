// Package: ct_test_pkg
// Package of the test class
package ct_test_pkg;

  // Package imports.
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  import ct_defn_pkg::*;
  import ct_env_pkg::*;
  import ct_vseq_pkg::*;

  // Agent package imports
  import ct_param_in_agent_pkg::*;

  //------------------------------------------------------------------------------
  // Class: ct_test_base
  //------------------------------------------------------------------------------
  // Verification test base for ct design.
  //------------------------------------------------------------------------------
  class ct_test_base extends uvm_test;
    // UVM Factory Registration Macro
    `uvm_component_utils(ct_test_base)

    // Environment class instantiation.
    ct_env m_env;

    // Environment configuration object instantiation.
    ct_env_config env_config;

    // Constructor.
    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction : new

    // Test's build phase.
    function void build_phase(uvm_phase phase);
      // Must always call parent method's build phase.
      super.build_phase(phase);

      // Create environment and its configuration object.
      m_env = ct_env::type_id::create("m_env", this);
      env_config = ct_env_config::type_id::create("env_config");

      // Configure ct_in Agent
      env_config.m_ct_in_agent_config = ct_param_in_agent_config#(Q_DATA_WIDTH)::type_id::create("m_ct_in_agent_config");
      env_config.m_ct_in_agent_config.active = UVM_ACTIVE;
      env_config.m_ct_in_agent_config.initial_clk_count = 0;
      if (!uvm_config_db#(virtual ct_param_in_if #(Q_DATA_WIDTH))::get(this, "", "ct_param_in_vif", env_config.m_ct_in_agent_config.vif)) begin
        `uvm_fatal(get_name(), "No virtual interface specified for ct_param_in_agent Agent");
      end

      // Environment post configuration
      configure_env(env_config);

      // Post configure and set configuration object to database
      uvm_config_db#(ct_env_config)::set(this, "*", "ct_env_config", env_config);

    endfunction : build_phase

    // Convenience method used by test sub-classes to modify the environment.
    virtual function void configure_env(ct_env_config env_config);
      // Environment post config here (if needed).
    endfunction : configure_env

    function void init_vseq(ct_base_vseq vseq);

      if (env_config.has_ct_in_agent) begin
        vseq.ct_in_sqr = m_env.m_ct_in_agent.m_sequencer;
      end

    endfunction : init_vseq

  endclass : ct_test_base


  //------------------------------------------------------------------------------
  // Class: ct_main_test
  //------------------------------------------------------------------------------
  class ct_main_test extends ct_test_base;
    // UVM Factory Registration Macro
    `uvm_component_utils(ct_main_test)

    // Constructor
    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction : new

    // Test's build phase
    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
    endfunction : build_phase

    // Environment configuration for current test
    function void configure_env(ct_env_config env_config);
      env_config.has_ct_in_agent  = 1'b1;
      // env_config.has_ct_out_agent = 1'b1;
      // env_config.has_scoreboard   = 1'b1;
      // env_config.has_coverage     = 1'b1;
    endfunction : configure_env

    // Main task executed by the test.
    task run_phase(uvm_phase phase);
      ct_rand_vseq ct_vseq;

      ct_vseq = ct_rand_vseq::type_id::create("ct_vseq");
      init_vseq(ct_vseq);

      // uvm_test_done.raise_objection(this);
      phase.raise_objection(this);

      // ct_vseq.n = SIM_PKT_NUM;
      ct_vseq.start(null);
      #100ns;

      // uvm_test_done.drop_objection(this);
      phase.drop_objection(this);

    endtask : run_phase

  endclass : ct_main_test

  // //------------------------------------------------------------------------------
  // // Class: ct_fibo_test
  // //------------------------------------------------------------------------------
  // class ct_fibo_test extends ct_test_base;
  //   // UVM Factory Registration Macro
  //   `uvm_component_utils(ct_fibo_test)

  //   // Constructor.
  //   function new(string name, uvm_component parent);
  //     super.new(name, parent);
  //   endfunction : new

  //   // Test's build phase.
  //   function void build_phase(uvm_phase phase);
  //     super.build_phase(phase);
  //   endfunction : build_phase

  //   // Environment configuration for current test.
  //   function void configure_env(ct_env_config env_config);
  //     env_config.has_ct_in_agent  = 1'b1;
  //     env_config.has_ct_out_agent = 1'b1;
  //     env_config.has_scoreboard   = 1'b1;
  //     env_config.has_coverage     = 1'b1;
  //   endfunction : configure_env

  //   // Main task executed by the test.
  //   task run_phase(uvm_phase phase);
  //     fibo_vseq ct_vseq;

  //     ct_vseq = fibo_vseq::type_id::create("ct_vseq");
  //     init_vseq(ct_vseq);

  //     m_env.m_ct_in_agent.m_monitor.set_report_verbosity_level(UVM_HIGH);
  //     m_env.m_ct_out_agent.m_monitor.set_report_verbosity_level(UVM_HIGH);
  //     m_env.m_scoreboard.m_comparator.set_report_verbosity_level(UVM_HIGH);

  //     uvm_test_done.raise_objection(this);

  //     ct_vseq.n = SIM_PKT_NUM;
  //     ct_vseq.start(null);
  //     #100ns;

  //     uvm_test_done.drop_objection(this);

  //   endtask : run_phase

  // endclass : ct_fibo_test

endpackage : ct_test_pkg
