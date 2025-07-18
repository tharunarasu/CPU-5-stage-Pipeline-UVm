module mem_stage(
 input logic clk,
  input logic reset,
  input logic mem_read,
  input logic mem_write,
  input logic [31:0] alu_result,
  input logic [31:0] reg2_data,
  
  output logic [31:0] mem_data_out,
  output logic [31:0] alu_result_out);
  
  logic [31:0] data_memory[0:255];  //256 word memory;
  
  initial begin
    data_memory[20] = 32'd100;
  end
  
  always @(posedge clk)
    begin
      if(reset) begin
      end
      else
        begin
          if(mem_write)
            begin
              data_memory[alu_result[9:2]] <= reg2_data;
            end
        end
    end
  
  assign mem_data_out =  (mem_read) ? data_memory[alu_result[9:2]] : 32'd0;
    
    assign alu_result_out=  alu_result;
endmodule


    


