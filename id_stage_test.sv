`timescale 1ns / 1ps

module tb_id_stage;

  logic clk, reset;
  logic [31:0] instr_in;
  logic [4:0] rs, rt, rd;
  logic [15:0] imm;
  logic [31:0] reg1_data, reg2_data;

  // Instantiate the ID stage
  id_stage uut (
    .clk(clk),
    .reset(reset),
    .instr_in(instr_in),
    .rs(rs),
    .rt(rt),
    .rd(rd),
    .imm(imm),
    .reg1_data(reg1_data),
    .reg2_data(reg2_data)
  );

  // Clock generation
  always #5 clk = ~clk;

  initial begin
    $display("Time\tInstr\t\trs\trt\trd\timm\treg1_data\treg2_data");

    // Init
    clk = 0;
    reset = 1;
    instr_in = 32'b0;

    #10;
    reset = 0;

    // Load addi $t1, $t0, 5 -> opcode=001000, rs=8, rt=9, imm=5
    instr_in = 32'h21090005; // addi $t1, $t0, 5
    #10;

    $display("%0t\t%h\t%d\t%d\t%d\t%h\t%d\t%d", 
             $time, instr_in, rs, rt, rd, imm, reg1_data, reg2_data);

    // Optional: Try another instruction (like R-type: add $9, $8, $7)
    instr_in = 32'b000000_01000_00111_01001_00000_100000; // add $9, $8, $7
    #10;

    $display("%0t\t%h\t%d\t%d\t%d\t%h\t%d\t%d", 
             $time, instr_in, rs, rt, rd, imm, reg1_data, reg2_data);

    $finish;
  end

endmodule
