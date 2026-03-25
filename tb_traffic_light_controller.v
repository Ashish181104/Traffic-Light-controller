`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.03.2026 12:26:24
// Design Name: 
// Module Name: tb_traffic_light_controller
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_traffic_light_controller(
// ================== INPUTS ==================
reg clk;
reg reset;

// ================== OUTPUTS ==================
wire [2:0] M1;
wire [2:0] M2;
wire [2:0] Mt;
wire [2:0] S;

// ================== DUT ==================
traffic_light_controller uut (
    .clk(clk),
    .reset(reset),
    .M1(M1),
    .M2(M2),
    .Mt(Mt),
    .S(S)
);

// ================== CLOCK GENERATION ==================
initial begin
    clk = 0;
end

always #5 clk = ~clk;   // 10ns clock (100 MHz)

// ================== RESET + STIMULUS ==================
initial begin
    // Initialize
    reset = 1;

    // Hold reset for some time
    #20;
    reset = 0;

    // Run simulation long enough
    #500;

    $finish;
end

// ================== MONITOR ==================
initial begin
    $display("Time\tclk\treset\tM1\tM2\tMt\tS\tps\tdur\tt1");
    $monitor("%0t\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%d\t%b",
              $time, clk, reset, M1, M2, Mt, S,
              uut.ps, uut.dur, uut.t1);
end

    );
endmodule
