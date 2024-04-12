module mux4(
	input logic [31:0] d0, d1, d2, d3,
 	input logic [1:0] s,
 	output logic [31:0] y);

 	assign y = (s[1] && s[0]) ? d3 : (s[1] ? d2 : (s[0] ? d1: d0)); // Select AluResult, read_data from memory, Branch Target Address or AUIPC

endmodule
