`timescale 1ns / 1ps

module alu_top#(parameter WIDTH = 32)
(
    input clk,
    input rst,
    input signed[WIDTH-1:0] RS1,
    input signed[WIDTH-1:0] RS2,
    input[2:0] Funct3,
    input[6:0] Funct7,
    input[6:0] opcode,
    input[11:0] Imm_reg,
    input[4:0] Shamt,
    output [WIDTH-1:0] RD

);

    localparam ADD = 0, SLL = 1, SLT = 2, SLTU = 3, XOR = 4, SRL = 5, OR = 6, AND = 7, NOP = 8; 

    reg[WIDTH-1:0] temp_RD;
    
    always@(*)begin  
        if(rst)
            temp_RD <= 0;
        
        // Register Operations
        else if(opcode == 7'b0110011)begin
            case(Funct3)
                ADD:  temp_RD <=(Funct7 == 7'h20) ? RS1 - RS2 : RS1 + RS2; //Add SUB based on Funct7
                SLL:  temp_RD <= RS1 << RS2;
                SLT:  temp_RD <= (RS1 < RS2) ? 1'b1:1'b0;
                SLTU: temp_RD <= (RS1 < RS2) ? 1'b1:1'b0;
                XOR:  temp_RD <= RS1 ^ RS2; 
                SRL:  temp_RD <= (Funct7 == 7'h20) ? RS1 >>> RS2 : RS1 >> RS2;
                OR:   temp_RD <= RS1 | RS2;
                AND:  temp_RD <= RS1 & RS2;
                default: temp_RD <= temp_RD;
            endcase
        end
        
        // Immediate Operations
        else if(opcode == 7'b0010011) begin
            case(Funct3)
                ADD:  temp_RD <= (Funct7 == 7'h20) ? RS1 - Imm_reg : RS1 + Imm_reg; //Add SUB based on Funct7
                SLL:  temp_RD <= RS1 << Shamt;
                SLT:  temp_RD <= (Imm_reg < RS1) ? 1'b1:1'b0;
                SLTU: temp_RD <= (Imm_reg < RS1) ? 1'b1:1'b0;
                XOR:  temp_RD <= Imm_reg ^ RS1; 
                SRL:  temp_RD <= (Funct7 == 7'h20) ? RS1 >>> Shamt : RS1 >> Shamt;
                OR:   temp_RD <= Imm_reg | RS1;
                AND:  temp_RD <= Imm_reg & RS1;
                default: temp_RD <= temp_RD;
            endcase
        end
        
        else
            temp_RD <= 0;
    end

    assign RD = temp_RD;
    
endmodule