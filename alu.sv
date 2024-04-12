module alu(
        input logic [31:0]    SrcA,
        input logic [31:0]    SrcB,
	input logic [3:0]  ALUControl,

        output logic[31:0] ALUResult,
        output logic zero, 
        output logic Con_BGT,
        output logic Con_BLT
        );


        always_comb
        begin
            ALUResult = 'd0;
            Con_BLT = 'b0;
            Con_BGT = 'b0;
            zero = 'b0;
            case(ALUControl)
            4'b0000:        // AND
                    ALUResult = SrcA & SrcB;
            4'b0001:        //OR
                    ALUResult = SrcA | SrcB;
            4'b0011:        //XOR
                    ALUResult = SrcA ^ SrcB;
            4'b0010:        //ADD
                    ALUResult = SrcA + SrcB;
            4'b0110: begin       //Subtract for bgt,blt
                    ALUResult = $signed(SrcA) - $signed(SrcB);
                    Con_BLT = ($signed(ALUResult) < $signed(1'd0));
                    Con_BGT = ($signed(ALUResult) > $signed(1'd0));
                    zero = ($signed(ALUResult) == $signed(1'd0));
                    end
            4'b0100:        //SLL
                    ALUResult = SrcA << SrcB;
            4'b0101:        //SLTU
                    ALUResult = SrcA < SrcB;
            4'b1010:	   //SLT
                    ALUResult = ($signed(SrcA)<$signed(SrcB));
            4'b0111:
                    begin       //Unsigned branch for bltu,bgtu, beq, bnq
                    ALUResult = SrcA - SrcB;
                    Con_BLT = SrcA < SrcB;
                    Con_BGT = SrcA > SrcB;
                    zero = (ALUResult == 1'd0);
                    end
            4'b1000:        //SRL
                    ALUResult = SrcA >> SrcB;
            4'b1100:        //SRA
                    ALUResult = $signed(SrcA) >>> SrcB;
            4'b1001:        //LUI
                    ALUResult = 'b0 + SrcB;
		default: 
                    ALUResult = 'b0;
            endcase
        end
endmodule

