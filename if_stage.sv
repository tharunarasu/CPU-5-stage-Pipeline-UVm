module if_stage(
  input  logic        clk,
  input  logic        reset,
  input  logic        stall,
  input  logic        pc_src,
  input  logic [31:0] next_pc,
  output logic [31:0] pc_out,
  output logic [31:0] instr_out
);

  logic [31:0] PC;
  logic [31:0] instr_mem [0:255];

  // Load memory from file
  initial begin
    $readmemh("program.mem", instr_mem);
  end

  // PC update logic
  always_ff @(posedge clk or posedge reset) begin
    if (reset)
      PC <= 32'd0;
    else if (!stall)
      PC <= pc_src ? next_pc : PC + 4;
  end

  assign pc_out    = PC;
  assign instr_out = instr_mem[PC[9:2]];

endmodule
