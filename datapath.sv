module datapath(
	input logic clk, reset,
 	input logic [1:0] ResultSrc,
	input logic PCSrc, ALUSrc,
	input logic RegWrite, //Jump,
	input logic [2:0] ImmSrc,
	input logic [3:0] ALUControl,
	output logic Zero,
	output logic Con_BGT, 
	output logic Con_BLT,
	output logic [31:0] PC,
	input logic [31:0] Instr,
	output logic [31:0] ALUResult, WriteData,
	input logic [31:0] ReadData);

 	logic [31:0] PCNext, PCPlus4, PCTarget;
 	logic [31:0] ImmExt;
 	logic [31:0] SrcA, SrcB;
 	logic [31:0] Result;

 // Next PC logic
 flopr pcreg(clk, reset, PCNext, PC);
 adder pcadd4(PC, 32'd4, PCPlus4);
 adder pcaddbranch(PC, ImmExt, PCTarget);
 mux2  pcmux(PCPlus4, PCTarget, PCSrc, PCNext);

 // Register file logic
 regfile rf(clk, RegWrite, Instr[19:15], Instr[24:20],
 Instr[11:7], Result, SrcA, WriteData);
 
 //Immediate Extender
 extend ext(Instr[31:7], ImmSrc, ImmExt);

 // ALU logic
 mux2 srcbmux(WriteData, ImmExt, ALUSrc, SrcB);
 alu alu_module(SrcA, SrcB, ALUControl, ALUResult, Zero,Con_BGT,Con_BLT);
 //mux2 jalr_PC_source(ALUResult, PCTarget, Jump); 
 mux4 resultmux(ALUResult, ReadData, PCPlus4, PCTarget,
		ResultSrc, Result);

endmodule
