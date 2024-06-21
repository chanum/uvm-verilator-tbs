module counter #(parameter DATA_WIDTH = 8)
  (
    // System
    input logic clk_i,
    input logic rst_ni,
    // Control
    input logic load_i,
    // Data
    input logic [DATA_WIDTH-1:0] data_i,
    output logic [DATA_WIDTH-1:0] data_o
  );
  
  // signals
  logic [DATA_WIDTH-1:0] q_r;

  always_ff @(posedge clk_i or negedge rst_ni)
    begin
      if (!rst_ni) begin
        q_r <= '0;
      end else begin
        if (load_i) begin
          q_r <= data_i;
        end else begin
          q_r <= q_r + 1;
        end
      end
    end

  assign data_o = q_r;

endmodule