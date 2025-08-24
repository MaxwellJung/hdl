`timescale 1ns / 1ps

module vga_timing_generator_tb ();
    localparam CLK_PERIOD = 100; // 10MHz clock

    logic clk;
    logic reset;
    
    vga_timing_generator dut (
        .clk(clk),
        .reset(reset),

        .h_pxl_count(),
        .v_pxl_count(),

        .h_sync(),
        .v_sync(),

        .h_visible(),
        .v_visible()
    );

    initial clk = 0;
    always #(CLK_PERIOD / 2.0)
        clk = ~clk;

    initial begin
        $dumpfile("vga_timing_generator_tb.vcd");
        $dumpvars(0, vga_timing_generator_tb);

        // hold reset for 10 ns
        reset <= 1;
        #(CLK_PERIOD+10)
        reset <= 0;

        // simulate 3 frames
        #(CLK_PERIOD*1056*628*3)

        // hold reset for 50 ns
        reset <= 1;
        #50
        reset <= 0;

        #20 $finish;
    end

endmodule
