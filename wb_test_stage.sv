

module tb_wb_stage;
  logic [31:0] alu_result;
  logic [31:0] mem_data;
  logic mem_to_reg;
  logic [31:0] write_data;

  wb_stage dut (
    .alu_result(alu_result),
    .mem_data(mem_data),
    .mem_to_reg(mem_to_reg),
    .write_data(write_data)
  );

  initial begin
    // Test 1: ALU result selected
    alu_result = 32'hA5A5A5A5;
    mem_data = 32'hDEADBEEF;
    mem_to_reg = 0;
    #10;
    $display("Test 1: mem_to_reg=0 | write_data = %h (Expected: A5A5A5A5)", write_data);

    // Test 2: Memory data selected
    mem_to_reg = 1;
    #10;
    $display("Test 2: mem_to_reg=1 | write_data = %h (Expected: DEADBEEF)", write_data);

    $finish;
  end
endmodule















Test 1: mem_to_reg=0 | write_data = a5a5a5a5 (Expected: A5A5A5A5)
# Test 2: mem_to_reg=1 | write_data = deadbeef (Expected: DEADBEEF)