
module top (
    input  wire clk,
    input  wire rst_n,
    output wire toggle
);

    wire clk_o;
    wire locked;

    pll pll_inst(
        .clock_in(clk), // clkin
        .clock_out(clk_o), // clkout
        .locked(locked)
    );

    counter #(
        .WIDTH(24)
    ) u_counter (
        .clk(clk_o),
        .rst_n(rst_n & locked),
        .toggle(toggle)
    );

endmodule