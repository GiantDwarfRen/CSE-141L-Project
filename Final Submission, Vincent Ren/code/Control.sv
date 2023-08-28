// control decoder
module Control #(parameter opwidth = 3, mcodebits = 3)(
  input [mcodebits-1:0] instr,    // subset of machine code (any width you need)
  input 				zeroQ,
  output logic /*RegDst, */Branch, 
     MemtoReg, MemWrite, ALUSrc, RegWrite, se_mode,				// sign_ext mode
  output logic[opwidth-1:0] ALUOp);	   // for up to 8 ALU operations


always_comb begin
// defaults
  // RegDst 	=   'b0;   // 1: not in place  just leave 0
  MemWrite  =	'b0;   // 1: store to memory
  ALUSrc 	=	'b0;   // 1: immediate  0: second reg file output
  RegWrite  =	'b1;   // 0: for store or no op  1: most other operations 
  MemtoReg  =	'b0;   // 1: load -- route memory instead of ALU to reg_file data in
  ALUOp	    =   'b111; // y = a+0;
  se_mode	=	'b0;	// b0 for immed4, b1 for immed6

case(instr)
  3'b000: begin			// LDR
    MemtoReg 	= 'b1;
	ALUOp		= 3'b000;
	Branch 		= 'b0;
	end
  3'b001: begin 		// STR
    MemWrite 	= 'b1;
    RegWrite	= 'b0; 
	ALUOp		= 3'b001;
	Branch 		= 'b0;
	end
  3'b010: begin			// ADDR
    ALUOp		= 3'b010;
	Branch 		= 'b0;
	end
  3'b011: begin			// XOR
    ALUOp		= 3'b011;
	Branch 		= 'b0;
  	end
  3'b100: begin			// MOV
    ALUSrc		= 'b1;
    ALUOp		= 3'b100;
	Branch 		= 'b0;
	end
  3'b101: begin			// LS
    ALUSrc		= 'b1;
    ALUOp		= 3'b101;
	Branch 		= 'b0;
  	end
  3'b110: begin			// ADDI
    ALUSrc		= 'b1;
    ALUOp		= 3'b110;
	Branch 		= 'b0;
  	end
  3'b111: begin			// BR
    RegWrite	= 'b0;
    ALUOp		= 3'b111;
    se_mode		= 'b1;
    Branch 		= zeroQ;	
	end
endcase
end
endmodule