
`ifndef CT_PARAM_IN_DRIVER_SVH
`define CT_PARAM_IN_DRIVER_SVH

class ct_param_in_driver #(int DATA_WIDTH = 8) 
  extends uvm_driver #(ct_param_in_seq_item #(DATA_WIDTH));
  `uvm_component_utils(ct_param_in_driver #(DATA_WIDTH));

  ct_param_in_agent_config #(DATA_WIDTH)  m_cfg;
  virtual ct_param_in_if #(DATA_WIDTH)    m_vif;

  function new(string name = "ct_param_in_driver", uvm_component parent = null);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);

  endfunction : build_phase

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    m_vif = m_cfg.vif;
  endfunction : connect_phase

  task run_phase(uvm_phase phase);
    m_vif.wait_reset();
    m_vif.wait_clocks(m_cfg.initial_clk_count);

    forever begin
      ct_param_in_seq_item #(DATA_WIDTH) item;

      seq_item_port.get_next_item(item);
      `uvm_info(this.get_full_name(), item.convert2string(), UVM_HIGH);

      do_drive(item);

      seq_item_port.item_done();
    end
  endtask : run_phase

  
  task do_drive(ct_param_in_seq_item #(DATA_WIDTH) item);
    repeat (item.delay_cycles) @(posedge m_vif.clk);

    m_vif.ld <= item.ld;
    m_vif.data  <= item.data;

    @(posedge m_vif.clk);

    m_vif.data <= 0;
    m_vif.ld <= 0;
  endtask : do_drive
  
endclass : ct_param_in_driver

`endif