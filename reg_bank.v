
// Module: Register Bank (reg_bank.v)
module reg_bank (
    input clk,
    input reg_write,             // Write enable signal
    input [4:0] rs,              // Read address for Source Register 1
    input [4:0] rt,              // Read address for Source Register 2
    input [4:0] rd,              // Write address for Destination Register
    input [31:0] write_data,     // 32-bit data to write
    output [31:0] reg_data1,     // 32-bit output read from rs
    output [31:0] reg_data2      // 32-bit output read from rt
);
    reg [31:0] registers [0:31]; // Array of 32 registers (32-bit width)

    // Register R0 is hardwired to 0
    assign reg_data1 = (rs == 5'b0) ? 32'b0 : registers[rs];
    assign reg_data2 = (rt == 5'b0) ? 32'b0 : registers[rt];

    // Synchronous write on positive clock edge
    always @(posedge clk) begin
        if (reg_write && (rd != 5'b0)) begin
            registers[rd] <= write_data;
        end
    end
endmodule