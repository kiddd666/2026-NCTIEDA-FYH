
`timescale 1ns/1ps

module tiny_core_scan (
    input  wire clk,
    input  wire rst_n,

    // Functional inputs
    input  wire in_a,
    input  wire in_b,
    input  wire in_c,

    // Scan signals
    input  wire scan_en,
    input  wire scan_in,
    output wire scan_out,

    // Functional output
    output wire y
);

    reg [3:0] q;

    wire d0;
    wire d1;
    wire d2;
    wire d3;

    // ============================================
    // Functional combinational logic
    // ============================================

    assign d0 = in_a ^ q[3];
    assign d1 = q[0] & in_b;
    assign d2 = q[1] ^ q[0];
    assign d3 = q[2] | in_c;

    // ============================================
    // Scan / functional storage
    // ============================================

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            q <= 4'b0000;
        end
        else if (scan_en) begin

            // Shift mode
            q[0] <= scan_in;
            q[1] <= q[0];
            q[2] <= q[1];
            q[3] <= q[2];

        end
        else begin

            // Functional / capture mode
            q[0] <= d0;
            q[1] <= d1;
            q[2] <= d2;
            q[3] <= d3;

        end
    end

    assign scan_out = q[3];

    assign y = q[3] ^ q[1];

endmodule
