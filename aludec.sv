module aludec(
	input logic opb5,
 	input logic [2:0] funct3,
 	input logic funct7b5,
 	input logic [1:0] ALUOp,
 	output logic Con_beq,
 	output logic Con_bnq,
 	output logic Con_blt,
 	output logic Con_bgt, 
 	output logic [3:0] ALUControl);

 	logic RtypeSub;
 	assign RtypeSub = funct7b5 & opb5; // TRUE for R_type subtract

	assign Con_beq = (ALUOp)&&(funct3==3'b000);
 	assign Con_bnq = (ALUOp)&&(funct3==3'b001);
 	assign Con_blt = (ALUOp)&&(funct3==3'b100||funct3==3'b110);
 	assign Con_bgt = (ALUOp)&&(funct3==3'b101||funct3==3'b111);

 always_comb
 case(ALUOp)
 2'b00: ALUControl = 4'b0010; // addition for sw,lw,jalr
 2'b01: 
	case(funct3)
		3'b000: ALUControl = 4'b0111;//Con_Beq
		3'b001: ALUControl = 4'b0111;//Con_Bneq
		3'b100: ALUControl = 4'b0110;//Con_Blt
		3'b110: ALUControl = 4'b0111;//Con_Bltu
		3'b101: ALUControl = 4'b0110;//Con_Bge
		3'b111: ALUControl = 4'b0111;//Con_Bgtu
	endcase
 default: case(funct3) // R_type or I_type ALU
 	3'b000: if (RtypeSub)
 			ALUControl = 4'b0111; // sub for R_type
		else
 			ALUControl = 4'b0010; // add, addi
 	3'b010: ALUControl = 4'b1010; // slt, slti
 	3'b110: ALUControl = 4'b0001; // or, ori
 	3'b111: ALUControl = 4'b0000; // and, andi
 	3'b011: ALUControl = 4'b0101; // sltui, sltu
 	3'b100: ALUControl = 4'b0011; // xor, xori
 	3'b001: ALUControl = 4'b0100; // sll, slli
 	3'b101:  if (RtypeSub)
 			ALUControl = 4'b1100; // sra, srai 
 		 else
 			ALUControl = 4'b1000; // srl, srli

 	default: ALUControl = 4'bxxxx; // ???
 	endcase

 2'b11: ALUControl = 4'b1001; // addition for lui
 endcase

endmodule