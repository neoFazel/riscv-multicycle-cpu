`timescale 1ns / 1ps

module ALU_decoder(
    input        op5,           //5th's bit of op      
    input [1:0]  ALUOp,
    input [2:0]  func3,
    input        func7,         // 5th's bit of func7 bit fields
    output reg [2:0] ALUControl  
    );
    
always@(*)
begin   
    
    case(ALUOp)
        2'b00: ALUControl = 3'b000;         // lw, sw instruction (Addition)
        2'b01: ALUControl = 3'b001;         // beq instruction (Subtraction/Comparison)
        
        2'b10: begin                        // R-type instruction
            case(func3)
                3'b000: begin               // ADD or SUB   
                    if (op5 == 1'b1) 
                        ALUControl = 3'b001; // SUB
                    else 
                        ALUControl = 3'b000; // ADD
                end
                
                3'b110: ALUControl = 3'b011; // OR
                3'b111: ALUControl = 3'b010; // AND
                
                default: ALUControl = 3'b000; 
            endcase  
        end  
        
        default: ALUControl = 3'b000;       
    endcase
end      

endmodule  


