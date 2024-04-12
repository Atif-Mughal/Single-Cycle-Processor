module regfile(
  	input logic clk, we,
  	input logic [4:0] a1,
  	input logic [4:0] a2,
  	input logic [4:0] wa,
  	input logic [31:0] wd,
  	output logic [31:0] rd1,
  	output logic [31:0] rd2);

 	logic [31:0] reg_file [31:0];
  

  assign rd1 = reg_file[a1];
  assign rd2 = reg_file[a2];
  always_ff @(posedge clk)
	 begin
    		reg_file[0] = 32'h0;
    		if (we) begin
      			reg_file[wa] <= wd;
    			end
  	 end

endmodule

