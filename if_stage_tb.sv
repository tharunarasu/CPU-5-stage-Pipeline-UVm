// Code your testbench here
// or browse Examples

module tb_if_stage;
  logic clk, reset, stall, pc_src;
  logic [31:0] next_pc;
  logic [31:0] pc_out, instr_out;
  
  if_stage dut(
    .clk(clk),
    .reset(reset),
    .stall(stall),
    .pc_src(pc_src),
    .next_pc(next_pc),
    .pc_out(pc_out),
    .instr_out(instr_out));
  
  always #5 clk = ~clk;
  
  initial begin 
    $display("---Starting IF Stage Simulation ----");
    clk =0;reset = 1; stall = 0; pc_src =0 ; next_pc = 32'd0;
    
    
    #10 reset =0;
    #10;
    #10;
    pc_src =1 ;next_pc = 32'h12;
    #10;
    pc_src=0;
    stall=1;
    #10;
    stall=0;
    #10;
    #10;
    
    $finish;
  end
  always @(posedge clk) begin
        $display("Time: %0t | PC: 0x%0h | Instruction: 0x%0h", $time, pc_out, instr_out);
    end
  initial begin
        $dumpfile("if_stage.vcd");
        $dumpvars(0, tb_if_stage);
    end
endmodule


    