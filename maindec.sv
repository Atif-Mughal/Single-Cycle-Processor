module maindec(
	input logic [6:0] op,
	output logic [1:0] ResultSrc,
	output logic MemWrite,
	output logic Branch, ALUSrc,
	output logic RegWrite, Jump,
	output logic [2:0] ImmSrc,
	output logic [1:0] ALUOp);

	always_comb
		case(op) 

			7'b0000011:  // lw
				begin
		 			RegWrite = 1'b1;
		 			ImmSrc = 3'b000;
		 			ALUSrc = 1'b1;
		 			MemWrite = 1'b0;
		 			ResultSrc = 2'b01;
		 			Branch = 1'b0;
		 			ALUOp = 2'b00;
		 			Jump = 1'b0;
				end
			7'b0100011: // sw
				begin
		 			RegWrite = 1'b0;
		 			ImmSrc = 3'b001;
		 			ALUSrc = 1'b1;
		 			MemWrite = 1'b1;
		 			ResultSrc = 2'b00;
		 			Branch = 1'b0;
		 			ALUOp = 2'b00;
		 			Jump = 1'b0;
				end
			7'b0110011:  // R_type
				begin
		 			RegWrite = 1'b1;
		 			ImmSrc = 3'bxxx;
		 			ALUSrc = 1'b0;
		 			MemWrite = 1'b0;
		 			ResultSrc = 2'b00;
		 			Branch = 1'b0;
		 			ALUOp = 2'b10;
		 			Jump = 1'b0;
				end
			7'b1100011:  // branch
				begin
		 			RegWrite = 1'b0;
		 			ImmSrc = 3'b010;
		 			ALUSrc = 1'b0;
		 			MemWrite = 1'b0;
		 			ResultSrc = 2'b00;
		 			Branch = 1'b1;
		 			ALUOp = 2'b01;
		 			Jump = 1'b0;
				end
			7'b0010011:  // I_type 
				begin
		 			RegWrite = 1'b1;
		 			ImmSrc = 3'b000;
		 			ALUSrc = 1'b1;
		 			MemWrite = 1'b0;
		 			ResultSrc = 2'b00;
		 			Branch = 1'b0;
		 			ALUOp = 2'b10;
		 			Jump = 1'b0;
				end
			7'b1101111:  // jal
				begin
		 			RegWrite = 1'b1;
		 			ImmSrc = 3'b011;
		 			ALUSrc = 1'bx;
		 			MemWrite = 1'b0;
		 			ResultSrc = 2'b10;
		 			Branch = 1'b0;
		 			ALUOp = 2'b00;
		 			Jump = 1'b1;
				end
			7'b0010111: //auipc
				begin
		 			RegWrite = 1'b1;
		 			ImmSrc = 3'b100; //same as lui
		 			ALUSrc = 1'bx;
		 			MemWrite = 1'b0;
		 			ResultSrc = 2'b11; // 4:1 mux
		 			Branch = 1'b0;
		 			ALUOp = 2'bxx;
		 			Jump = 1'b0;
				end
			7'b0110111:  // lui
				begin
		 			RegWrite = 1'b1;
		 			ImmSrc = 3'b100;
		 			ALUSrc = 1'b1;
		 			MemWrite = 1'b0;
		 			ResultSrc = 2'b00;
		 			Branch = 1'b0;
		 			ALUOp = 2'b11;
		 			Jump = 1'b0;
				end
			7'b1100111:  // jalr
				begin
		 			RegWrite = 1'b1;
		 			ImmSrc = 3'b000; // same as I_type
		 			ALUSrc = 1'b1;
		 			MemWrite = 1'b0;
		 			ResultSrc = 2'b10;
		 			Branch = 1'b0;
		 			ALUOp = 2'b00;
		 			Jump = 1'b1;
				end
			default:  // ???
				begin
		 			RegWrite = 1'bx;
		 			ImmSrc = 3'bxxx;
		 			ALUSrc = 1'bx;
		 			MemWrite = 1'bx;
		 			ResultSrc = 2'bxx;
		 			Branch = 1'bx;
		 			ALUOp = 2'bxx;
		 			Jump = 1'bx;
				end
		endcase

endmodule
