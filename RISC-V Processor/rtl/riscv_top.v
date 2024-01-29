`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/10/2023 07:19:13 PM
// Design Name: 
// Module Name: rsicv_top
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


module riscv_top #(parameter WIDTH = 32)
    (
    input clk,
    input rst,
    output[WIDTH-1:0] rd
    );
    
    
    // Wires for passing along data processed from engines
    wire[WIDTH-1:0] RS1_data, RS2_data, RD_data;
    
    // FW wires
    wire[4:0] RD, RS2, RS1;
    wire[6:0] Funct7;
    wire[2:0] Funct3;
    wire[6:0] opcode;
    
    
    // Stores instructions in memory & fetches them from processing
    instruction_mem INSTRUCTION_MEMORY(.clk(clk), 
                                       .rst(rst), 
                                       .RD(RD),
                                       .RS1(RS1),
                                       .RS2(RS2),
                                       .Funct3(Funct3),
                                       .Funct7(Funct7),
                                       .opcode(opcode));    
    
    // Register select module 
    register_select REG_FILE_SELECT(.clk(clk), 
                                    .rst(rst), 
                                    .RD_data(RD_data), 
                                    .RS1_data(RS1_data), 
                                    .RS2_data(RS2_data), 
                                    .RS1(RS1),
                                    .RS2(RS2),
                                    .RD(RD));  
                                      
    // ALU engine to perform math calculations
    alu_top ALU_ENGINE(.clk(clk), 
                       .rst(rst), 
                       .RS1(RS1_data), 
                       .RS2(RS2_data), 
                       .Funct3(Funct3), 
                       .Funct7(Funct7), 
                       .RD(RD_data), 
                       .Imm_reg({Funct7, RS2}),
                       .Shamt(RS2),
                       .opcode(opcode));
                 

    // Would have more modules, this is a simple RISC-V ALU design
    
    assign rd = RD_data;
endmodule
