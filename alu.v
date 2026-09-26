
// Module: Arithmetic Logic Unit (alu.v)// Module: Arithmetic Logic Unit (alu.v)
module alu (
     input [31:0] A, // First 32-bit operand
     input [31:0] B, // Second 32-bit operand 
     input [5:0] opcode, // 6-bit opcode
     output reg [31:0] result // 32-bit execution result
);

always @(*)
    begin
        case (opcode) 
         6'b000000: result = A + B; // ADD 
         6'b000001: result = A - B; // SUB
         6'b000010: result = A & B; // Bitwise AND
         6'b000011: result = A | B; // Bitwise OR
         6'b000100: result = (A < B) ? 32'b1 : 32'b0; // Set on Less Than (SLT)
         6'b000101: result = A * B; // Multiply (MUL) 
        default: result = 32'b0; // Default output 
        endcase
    end
endmodule