package mem_test_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  // testbech import
  import mem_env_pkg::*;

  // agent import
  import mem_agent_pkg::*;

  `include "tests/mem_base_test.svh"
  `include "tests/mem_wr_rd_test.svh"

endpackage : mem_test_pkg