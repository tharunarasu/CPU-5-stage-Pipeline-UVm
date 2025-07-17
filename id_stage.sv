module id_stage (
  input  logic        clk,
  input  logic        reset,
  input  logic [31:0] instr_in,      // From IF stage

  output logic [4:0]  rs,
  output logic [4:0]  rt,
  output logic [4:0]  rd,
  output logic [15:0] imm,

  output logic [31:0] reg1_data,
  output logic [31:0] reg2_data
);

  // Decode instruction fields
  assign rs  = instr_in[25:21];
  assign rt  = instr_in[20:16];
  assign rd  = instr_in[15:11];
  assign imm = instr_in[15:0];

  // Instantiate register file
  reg_file rf (
    .clk(clk),
    .reset(reset),
    .rs(rs),
    .rt(rt),
    .reg1(reg1_data),
    .reg2(reg2_data)
  );

endmodule

// reg_file.v
module reg_file (
  input  logic        clk,
  input  logic        reset,
  input  logic [4:0]  rs, rt,
  output logic [31:0] reg1, reg2
);

  logic [31:0] regs[0:31];

  // Initialize registers with dummy values for testing
  initial begin
    integer i;
    for (i = 0; i < 32; i++)
      regs[i] = i;
  end

  // Read logic — synchronous
  always_ff @(posedge clk) begin
    reg1 <= regs[rs];
    reg2 <= regs[rt];
  end

endmodule
