`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/12/2023 03:05:08 PM
// Design Name: 
// Module Name: riscv_tb
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


module riscv_tb();
    
    parameter WIDTH = 32;
    reg clk, rst;
    wire[WIDTH-1:0] rd;
    
    riscv_top #(WIDTH) UUT(.clk(clk), .rst(rst), .rd(rd));
    
    /*
    TESTED RISCV ISA Assembly code
    
    ADDI x1, x1, 10
    ADDI x2, x2, 10
    ADD x3, x1, x2
    SLT x4, x2, x3
    SRLI x5, x1, 1
    SLLI x6, x2, 2
    AND x7, x5, x3
    OR x8, x5, x3
    XOR x9, x5, x3
    SUB x10, x2, x6
    SRL x11, x2, x4
    SLL x12, x2, x4
    SRAI x13, x10, 5
    SRA x14, x10, x5
    */
    
    initial
    begin
    
        clk = 1;
        rst = 1;
        #20;
        rst = 0;
        
    end
    
    always #10 clk = ~clk;
endmodule
