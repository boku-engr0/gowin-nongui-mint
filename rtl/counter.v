
module counter #(
    parameter WIDTH = 16
) (
    input  wire         clk,
    input  wire         rst_n,
    output reg          toggle
);

reg [WIDTH-1:0] count;

always @(posedge clk) begin
    if (!rst_n) begin
        count <= {WIDTH{1'b0}};
        toggle <= 1'b1;
    end
    else begin
        if (count == {WIDTH{1'b1}}) begin
            count  <= {WIDTH{1'b0}};
            toggle <= ~toggle;
        end
        else begin
            count <= count + 1;
        end
    end
end

endmodule
