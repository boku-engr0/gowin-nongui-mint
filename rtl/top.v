
module top (
    input  wire clk,
    input  wire rst_n,
    output wire toggle
);

counter #(
    .WIDTH(24)
) u_counter (
    .clk(clk),
    .rst_n(rst_n),
    .toggle(toggle)
);

endmodule