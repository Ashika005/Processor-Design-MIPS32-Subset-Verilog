
`timescale 1ns/1ns

module mips_tb;
    reg clk1, clk2;

    mips_core uut (
        .clk1(clk1),
        .clk2(clk2)
    );

    initial begin
        clk1 = 0;
        clk2 = 0;
        forever begin
            #5 clk1 = 1; #5 clk1 = 0;
            #5 clk2 = 1; #5 clk2 = 0;
        end
    end

    initial begin
        uut.Reg[0] = 32'h00000000;
        uut.Reg[1] = 32'h0000000A; // R1 = 10
        uut.Reg[2] = 32'h00000014; // R2 = 20

        uut.Mem[0] = 32'h00221800; // ADD R3, R1, R2
        uut.Mem[1] = 32'hfc000000; // HLT

        $dumpfile("mips.vcd");
        $dumpvars(0, mips_tb);

        #300 $finish;
    end
endmodule
