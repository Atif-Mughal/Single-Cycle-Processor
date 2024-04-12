module controller(
	input logic [6:0] op,
 	input logic [2:0] funct3,
 	input logic funct7b5,
 	input logic Zero,
 	input logic Con_BGT, 
 	input logic Con_BLT,
 	output logic [1:0] ResultSrc,
 	output logic MemWrite,
 	output logic PCSrc, ALUSrc,
 	output logic RegWrite, Jump,
 	output logic [2:0] ImmSrc,
 	output logic [3:0] ALUControl);

	logic [1:0] ALUOp;
	logic Branch; 


	logic Con_beq;
	logic Con_bnq;
	logic Con_blt;
	logic Con_bgt;


	maindec maindec_module(op, ResultSrc, MemWrite, Branch,
 				ALUSrc, RegWrite, Jump, ImmSrc, ALUOp);

	aludec alude_module(op[5], funct3, funct7b5, ALUOp,  Con_beq, Con_bnq, Con_blt, Con_bgt, ALUControl);

	assign PCSrc = (Branch && ((Con_beq&&Zero)||(Con_bnq&&!Zero)||(Con_bgt&&Con_BGT)||(Con_blt&&Con_BLT))) | Jump; // BRANCH LOGIC

endmodule
