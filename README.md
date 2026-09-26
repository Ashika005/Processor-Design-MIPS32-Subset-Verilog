# MIPS32 Pipelined Processor — Verilog

A 5-stage pipelined implementation of a subset of the MIPS32 instruction set, written in
Verilog as part of the NPTEL course **"Hardware Modeling using Verilog"** by Prof. Indranil
Sengupta, IIT Kharagpur.

## Overview

The processor (`mips_core.v`) implements the classic 5-stage RISC pipeline:

- **IF** — Instruction Fetch
- **ID** — Instruction Decode / Register Fetch
- **EX** — Execute / Effective Address Calculation
- **MEM** — Memory Access / Branch Completion
- **WB** — Register Write-back

It uses a two-phase clock (`clk1`, `clk2`) as described in the course, with pipeline
registers (`IF_ID_*`, `ID_EX_*`, `EX_MEM_*`, `MEM_WB_*`) modeled as explicit `reg`s rather
than a single struct, since Verilog has no native record/struct type for this.

## Instructions supported

| Type | Instructions |
|---|---|
| Register-register ALU | `ADD`, `SUB`, `AND`, `OR`, `SLT`, `MUL` |
| Register-immediate ALU | `ADDI`, `SUBI`, `SLTI` |
| Memory | `LW`, `SW` |
| Branch | `BEQZ`, `BNEQZ` |
| Misc | `HLT` |

## Files

| File | Description |
|---|---|
| `mips_core.v` | Top-level pipelined processor (self-contained: includes register file and memory array inline) |
| `mips_tb.v` | Testbench — loads a small program and register values, runs the simulation, dumps a VCD waveform |
| `alu.v` | Standalone combinational ALU module (not currently instantiated by `mips_core.v`; included for reference / a modular variant) |
| `reg_bank.v` | Standalone register file module (32 × 32-bit, R0 hardwired to zero) |
| `memory.v` | Standalone unified instruction/data memory module |

> **Note:** `mips_core.v` implements the register file and memory internally as `Reg [0:31]`
> and `Mem [0:1023]` arrays, following the structure taught in the course. `alu.v`,
> `reg_bank.v`, and `memory.v` are provided as separate modular building blocks and are not
> wired into the current top-level design.

## How to run

Requires [Icarus Verilog](http://bleyer.org/icarus/) (`iverilog` + `vvp`).

```bash
# Compile
iverilog -o mips_sim mips_core.v mips_tb.v

# Run
vvp mips_sim
```

This produces `mips.vcd`, which you can inspect with [GTKWave](http://gtkwave.sourceforge.net/):

```bash
gtkwave mips.vcd
```

### Sample test program (in `mips_tb.v`)

```
R1 = 10
R2 = 20
ADD R3, R1, R2   ; R3 = 30
HLT
```

Expected result after simulation: `Reg[3] == 30`, `halted == 1`.

## References

- Prof. Indranil Sengupta, *Hardware Modeling using Verilog*, NPTEL/IIT Kharagpur —
  Lectures 37–40 (Pipeline Implementation of a Processor)
- [NPTEL course page](https://nptel.ac.in/courses/106105165)
