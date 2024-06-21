
package defn_pkg;

  // TB Top definitions.
  localparam int RESET_CLOCK_COUNT = 10;
  localparam int CLK_FREQ_HZ = 500e6;
  localparam time CLK_PERIOD = 1s / CLK_FREQ_HZ;
  localparam int SIM_PKT_NUM = 10;

  localparam int Q_DATA_WIDTH = 8;

endpackage : defn_pkg