
`ifndef CT_PARAM_IN_IF_SVH
`define CT_PARAM_IN_IF_SVH

interface ct_param_in_if #(
    int DATA_WIDTH = 8
  ) (
    input logic rst_n,
    input logic clk
  );

  logic                      ld = 0;
  logic [DATA_WIDTH - 1 : 0] data = 0;

  task wait_reset();
    @(posedge rst_n);
  endtask : wait_reset

  task wait_clocks(int cycles = 1);
    repeat (cycles) @(posedge clk);
  endtask : wait_clocks

endinterface : ct_param_in_if

`endif
