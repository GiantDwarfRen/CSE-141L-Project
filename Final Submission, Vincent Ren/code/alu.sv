// combinational -- no clock
// sample -- change as desired
module alu(
  input 	 clk,
  input[2:0] alu_cmd,    // ALU instructions
  input[7:0] inA, inB,	 // 8-bit wide data path
  // input      sc_i,       // shift_carry in
  output logic[7:0] rslt,
  output logic /*sc_o,*/     // shift_carry out
               pariQ,     // reduction XOR (output)
			   zeroQ      // NOR (output)
);

always_comb begin                
  // sc_o = 'b0;    
  case(alu_cmd)
	3'b000:  	// LDR
	  rslt = inB;
	3'b001: 		// STR
	  rslt = inA;
	3'b010: 		// ADDR
	  rslt = inA + inB;
	3'b011: 		// XOR
	  rslt = inA ^ inB;
	3'b100:		// MOV
	  if (inB[3:0] == 4'b1000) rslt = pariQ; 
	  else rslt = inB[3:0];
	3'b101:		// LS
	  case(inB[3:0])
		4'b0001: rslt = {inA[6:0], 1'b0};
		4'b0010: rslt = {inA[5:0], 2'b0};
		4'b0011: rslt = {inA[4:0], 3'b0};
		4'b0100: rslt = {inA[3:0], 4'b0};
		4'b0101: rslt = {inA[2:0], 5'b0};
		4'b0110: rslt = {inA[1:0], 6'b0};
		4'b0111: rslt = {inA[0:0], 7'b0};
		4'b1111: rslt = {1'b0, inA[7:1]};
		4'b1110: rslt = {2'b0, inA[7:2]};
		4'b1101: rslt = {3'b0, inA[7:3]};
		4'b1100: rslt = {4'b0, inA[7:4]};
		4'b1011: rslt = {5'b0, inA[7:5]};
		4'b1010: rslt = {6'b0, inA[7:6]};
		4'b1001: rslt = {7'b0, inA[7:7]};
	 	default: rslt = inA; 
	   endcase
	3'b110:		// ADDI
	  	rslt = inA + inB;
	3'b111: 		// BR
	 	rslt = 'b0;
  endcase
end
  
// registered flags from ALU
  always_ff @(posedge clk) begin
    pariQ <= ^rslt;
	zeroQ <= !rslt;
	end

endmodule