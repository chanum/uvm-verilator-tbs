
`include "uvm_pkg.sv"
import uvm_pkg::*;
import mem_test_pkg::*;

`include "uvm_macros.svh"

module tb_top;

  //---------------------------------------
  // clock and reset signal declaration
  //---------------------------------------
  bit clk;
  bit reset;

  //---------------------------------------
  // clock generation
  //---------------------------------------
  always #5 clk = ~clk;

  //---------------------------------------
  // reset Generation
  //---------------------------------------
  initial begin
    reset = 1;
    #5 reset =0;
  end

  //---------------------------------------
  // interface instance
  //---------------------------------------
  mem_if mem_intf(clk, reset);

  //---------------------------------------
  // DUT instance
  //---------------------------------------
  memory DUT (
    .clk(mem_intf.clk),
    .reset(mem_intf.reset),
    .addr(mem_intf.addr),
    .wr_en(mem_intf.wr_en),
    .rd_en(mem_intf.rd_en),
    .wdata(mem_intf.wdata),
    .rdata(mem_intf.rdata)
   );

  //---------------------------------------
  // passing the interface handle to lower heirarchy using set method
  // and enabling the wave dump
  //---------------------------------------
  initial begin
    uvm_config_db#(virtual mem_if)::set(uvm_root::get(), "*"," mem_vif", mem_intf);
  end

  //---------------------------------------
  //calling test
  //---------------------------------------
  initial begin
    run_test();
  end

  initial begin
    $dumpfile("tb_top.vcd");
    $dumpvars(0,tb_top);
 end

endmodule : tb_top

