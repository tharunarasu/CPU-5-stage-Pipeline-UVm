module wb_stage(
  input logic [31:0] alu_result,
  input logic [31:0] mem_data,
  input logic mem_to_reg,
  output logic [31:0] write_data
);
  
  assign write_data = mem_to_reg ? mem_data: alu_result;
endmodule
