`timescale 1ns/1ps

module tiny_core_scan_tb;

    reg clk;
    reg rst_n;

    reg in_a;
    reg in_b;
    reg in_c;

    reg scan_en;
    reg scan_in;

    wire scan_out;
    wire y;

    integer errors;

    tiny_core_scan dut (
        .clk(clk),
        .rst_n(rst_n),

        .in_a(in_a),
        .in_b(in_b),
        .in_c(in_c),

        .scan_en(scan_en),
        .scan_in(scan_in),
        .scan_out(scan_out),

        .y(y)
    );

    // 10 ns clock period
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // --------------------------------------------
    // Shift one bit into the scan chain
    // --------------------------------------------
    task shift_in_bit;
        input bit_value;
        begin
            @(negedge clk);
            scan_in = bit_value;

            @(posedge clk);
            #1;

            $display(
                "[SHIFT-IN] SI=%b  q=%b",
                bit_value,
                dut.q
            );
        end
    endtask

    // --------------------------------------------
    // Check one scan-out bit, then shift once
    // --------------------------------------------
    task check_shift_out;
        input expected_bit;
        begin
            @(negedge clk);

            if (scan_out !== expected_bit) begin
                $display(
                    "[FAIL] scan_out expected=%b actual=%b",
                    expected_bit,
                    scan_out
                );
                errors = errors + 1;
            end
            else begin
                $display(
                    "[PASS] scan_out=%b",
                    scan_out
                );
            end

            scan_in = 1'b0;

            @(posedge clk);
            #1;
        end
    endtask

    initial begin

        $dumpfile("wave.vcd");
        $dumpvars(0, tiny_core_scan_tb);

        errors = 0;

        rst_n   = 0;
        in_a    = 0;
        in_b    = 0;
        in_c    = 0;
        scan_en = 0;
        scan_in = 0;

        // ========================================
        // 1. RESET
        // ========================================

        #12;
        rst_n = 1;

        $display("");
        $display("========== RESET DONE ==========");

        // ========================================
        // 2. SHIFT-IN 1010
        // ========================================

        scan_en = 1;

        shift_in_bit(1);
        shift_in_bit(0);
        shift_in_bit(1);
        shift_in_bit(0);

        if (dut.q !== 4'b1010) begin
            $display(
                "[FAIL] Shift-In expected q=1010 actual=%b",
                dut.q
            );
            errors = errors + 1;
        end
        else begin
            $display(
                "[PASS] Shift-In loaded q=1010"
            );
        end

        // ========================================
        // 3. CAPTURE
        // ========================================

        @(negedge clk);

        scan_en = 0;

        in_a = 1;
        in_b = 1;
        in_c = 0;

        @(posedge clk);
        #1;

        $display("");
        $display("========== CAPTURE ==========");
        $display("Captured q = %b", dut.q);

        if (dut.q !== 4'b0100) begin
            $display(
                "[FAIL] Capture expected q=0100 actual=%b",
                dut.q
            );
            errors = errors + 1;
        end
        else begin
            $display(
                "[PASS] Capture result q=0100"
            );
        end

        // ========================================
        // 4. SHIFT-OUT 0100
        // ========================================

        scan_en = 1;

        $display("");
        $display("========== SHIFT-OUT ==========");

        // q = 0100
        // scan_out = q[3]
        // expected serial order:
        // 0 -> 1 -> 0 -> 0

        check_shift_out(0);
        check_shift_out(1);
        check_shift_out(0);
        check_shift_out(0);

        // ========================================
        // FINAL RESULT
        // ========================================

        $display("");

        if (errors == 0)
            $display("========== E05 PASS ==========");
        else
            $display(
                "========== E05 FAIL: %0d errors ==========",
                errors
            );

        #10;
        $finish;

    end

endmodule
