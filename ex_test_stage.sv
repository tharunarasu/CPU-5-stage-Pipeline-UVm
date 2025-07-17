`timescale 1ns/1ps


module ed_test_stage;
  logic clk;
  logic reset;
  logic [31:0] reg1_data;
  logic [31:0] reg2_data;
  logic [15:0] imm;
  logic alu_src;
  logic [2:0] alu_op;
  
  logic [31:0] alu_result;
  
  
  ex_stage dut(
     .clk(clk),
    .reset(reset),
    .reg1_data(reg1_data),
    .reg2_data(reg2_data),
    .imm(imm),
    .alu_src(alu_src),
    .alu_op(alu_op),
    .alu_result(alu_result)
  );
  initial clk = 0;
  always #5 clk = ~clk;
  
  initial begin
    $monitor("Time=%0t | alu_src=%0b | alu_op=%0b | R1=%0d | R2=%0d | Imm=%0d | Result=%0d",
             $time, alu_src, alu_op, reg1_data, reg2_data, imm, alu_result);
    reset = 1; #10;
    reset = 0;
    
     // -------------------------
    // Test R-type: add (R1 + R2)
    reg1_data = 10;
    reg2_data = 5;
    imm       = 16'd0;   // ignored
    alu_src   = 0;       // select reg2
    alu_op    = 3'b000;  // ADD
    #10;
    
    
    // Test R-type: sub (R1 - R2)
    alu_op = 3'b001;
    #10;
    
    
     // -------------------------
    // Test I-type: addi (R1 + imm)
    alu_src = 1;         // select imm
    imm     = 16'd8;
    alu_op  = 3'b000;    // ADD
    #10;

    // Test AND immediate
    alu_op  = 3'b010;
    #10;

    // Test OR immediate
    alu_op  = 3'b011;
    #10;
    
    $finish;
  end 
endmodule

