module sign_ext (
  input[5:0]	dat_in,
  input			mode,
  output logic[7:0]   dat_out);

  always_comb begin
	case(mode)
	  1'b0:		// immed4
		if (dat_in[3] == 0) dat_out = {4'b0000, dat_in[3:0]};
		else				dat_out = {4'b1111, dat_in[3:0]};
	  1'b1:		// immed6
		if (dat_in[5] == 0) dat_out = {2'b00, dat_in[5:0]};
		else				dat_out = {2'b11, dat_in[5:0]};
	endcase
  end


endmodule