module tb_mem_stage;
  
  logic clk;
  logic reset;
  logic mem_read;
  logic mem_write;
  
  //Inputs
  logic [31:0] alu_result;
  logic [31:0] reg2_data;
  
  logic [31:0] mem_data_out;
  logic [31:0] alu_result_out;
  
  	mem_stage dut (
    .clk(clk),
    .reset(reset),
    .mem_read(mem_read),
    .mem_write(mem_write),
    .alu_result(alu_result),
    .reg2_data(reg2_data),
    .mem_data_out(mem_data_out),
    .alu_result_out(alu_result_out)
  );

  
  initial 
    clk=0;
  always #5 clk = ~clk;
  
  initial begin
    reset = 1;
    mem_read =0 ;
    mem_write =0;
    alu_result = 0;
    reg2_data=0;
    
    #10
    reset =0;
    
    
    //Test -1 Pre load memory
    alu_result = 32'd80;
    mem_read = 1;
    #10;
     $display("READ @80: mem_data_out = %0d (expected 100)", mem_data_out);
    mem_read = 0;
    
    
    
    //Test -2 Write then read back
    
    alu_result = 32'd4;
    reg2_data = 32'd123;
    mem_write =1;
    #10;                    // capture on rising edge
    mem_write   = 0;

    // Step B: read it back
    mem_read    = 1;
    #1;                     // small delay for combinational read
    $display("READ @4:  mem_data_out = %0d (expected 123)", mem_data_out);

    $finish;
  end
  
endmodule
