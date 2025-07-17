module ex_stage(
input logic clk,
  input logic reset,
  input logic [31:0] reg1_data,
  input logic [31:0] reg2_data,
  input logic [15:0] imm,
  input logic [2:0] alu_op,
  input logic alu_src,
  input logic reg_dst,
  input logic[4:0] rs,
  input logic [4:0] rt,
  
  output logic [31:0] alu_result,
  output logic zero,
  output logic [4:0] write_reg
);
  
  logic [31:0] sign_ext_imm;
  logic [31:0] operand_b;
  //Sign extend immediate
  assign sign_ext_imm = {{16{imm[15]}},imm};
     
  assign operand_b = alu_src ? sign_ext_imm : reg2_data;
  
  alu alu_inst (
    .a(reg1_data),
    .b(operand_b),
    .alu_op(alu_op),
    .result(alu_result),
    .zero(zero)
  );

  // Destination register selection
  assign write_reg = (reg_dst) ? rs : rt;

endmodule
  

module alu(
  input logic [31:0] a,
  input logic [31:0] b,
  input logic [2:0] alu_op,
  output logic [31:0] result,
  output logic zero
);
  always_comb begin
    case(alu_op)
      3'b000 : result = a+b;
      3'b001 : result = a-b;
      3'b010 : result = a&b;
      3'b011 : result = a | b;
      3'b010 : result = (a<b) ? 32'd1 : 32'd0;
      3'b101: result = a ^ b;
      3'b110: result = ~(a | b);
      default: result = 32'd0;
    endcase
  end
  assign zero = (result == 32'd0);

endmodule



