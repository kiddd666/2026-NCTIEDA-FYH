`timescale 1ns/1ps

module tiny_core_prescan (
    input  wire clk,
    input  wire rst_n,

    input  wire in_a,
    input  wire in_b,
    input  wire in_c,

    output wire y
);

    reg [3:0] q;

    wire d0;
    wire d1;
    wire d2;
    wire d3;

    // Functional combinational logic
    assign d0 = in_a ^ q[3];
    assign d1 = q[0] & in_b;
    assign d2 = q[1] ^ q[0];
    assign d3 = q[2] | in_c;

    // Four ordinary functional DFFs
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            q <= 4'b0000;
        else begin
            q[0] <= d0;
            q[1] <= d1;
            q[2] <= d2;
            q[3] <= d3;
        end
    end

    // Only one functional output is externally visible
    assign y = q[3] ^ q[1];

endmodule
