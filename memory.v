
// Module: Data & Instruction Memory (memory.v) 
module memory ( 
    input clk, input mem_read, // Read enable control signal 
    input mem_write, // Write enable control signal 
    input [31:0] address, // Memory address
    input [31:0] write_data, // 32-bit data to write 
    output [31:0] read_data // 32-bit data read out 
);
    reg [31:0] mem [0:1023]; // 1024 memory locations of 32 bits each // Combinational read 

assign read_data = (mem_read) ? mem[address] : 32'b0; // Synchronous write on positive clock edge 

always @(posedge clk) 
begin
    if (mem_write) 
        begin
            mem[address] <= write_data;
        end 
end 
endmodule