
module tb_top;
  import uvm_pkg::*;
  import defn_pkg::*;
  // import ct_test_pkg::*;

  `include "uvm_macros.svh"

  // Clock and reset signals
  logic clk;
  logic rst_n;

  // -------------------------------------------//
  // Clock and reset generator
  // -------------------------------------------//
  initial begin
    // Initialize clock to 0 and reset_n to TRUE.
    clk   = 0;
    rst_n = 0;
    // Wait for reset completion (RESET_CLOCK_COUNT)
    repeat (RESET_CLOCK_COUNT) begin
      #(CLK_PERIOD / 2) clk = 0;
      #(CLK_PERIOD - CLK_PERIOD / 2) clk = 1;
    end
    // Set rst to FALSE.
    rst_n = 1;
    forever begin
      #(CLK_PERIOD / 2) clk = 0;
      #(CLK_PERIOD - CLK_PERIOD / 2) clk = 1;
    end
  end

  // -------------------------------------------//
  // Interfaces 
  // -------------------------------------------//
  ct_param_in_if #(
    .DATA_WIDTH(Q_DATA_WIDTH)
  ) counter_in_if(
    .clk(clk),
    .rst_n(rst_n)
  );

  // ct_out_if #(
  //   .DATA_WIDTH(Q_DATA_WIDTH)
  // ) counter_out(
  //   .clk(clk),
  //   .rst_n(rst_n)
  // );

  // -------------------------------------------//
  // DUT instance
  // -------------------------------------------//
  counter #(
    .DATA_WIDTH(Q_DATA_WIDTH)
    ) DUT (
    .clk_i(clk),
    .rst_ni(rst_n),
    .load_i(counter_in_if.ld),
    .data_i(counter_in_if.data),
    .data_o()
  );

  initial begin
    uvm_config_db#(virtual ct_param_in_if)::set(uvm_root::get(),"*","m_counter_in_vif", counter_in_if);
    // uvm_config_db #(virtual ct_param_in_if#(Q_DATA_WIDTH))::set(null, "uvm_test_top","m_counter_in_vif", counter_in_if);
  end

  initial begin
    // Set time format for simulation.
    // $timeformat(-12, 1, " ps", 1);

    // Set default verbosity level for all TB components.
    //uvm_top.set_report_verbosity_level(UVM_HIGH);
   
    // Configure some simulation options.
    //uvm_top.enable_print_topology = 1;
    //uvm_top.finish_on_completion  = 0;

    // Execute test
    run_test(); 

    // Stop simulation.
    // $stop();
  end

endmodule : tb_top