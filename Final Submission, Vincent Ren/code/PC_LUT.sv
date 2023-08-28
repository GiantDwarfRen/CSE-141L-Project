module PC_LUT #(parameter D=12)(
  input       [ 5:0] addr,	   // target 4 values
  output logic[D-1:0] target);

  always_comb case(addr)
    0: target = 4095;   // done flag
	1: target = 1;  
	2: target = 34;
	3: target = 50;
	4: target = 78;
	5: target = 127;
	6: target = 332;
	7: target = 315;
	8: target = 196;
	9: target = 209;
	10: target = 222;
	11: target = 235;
	12: target = 248;
	13: target = 261;
	14: target = 274;
	15: target = 287;
	16: target = 294;
	17: target = 301;
	18: target = 308;
	19: target = 364;
	20: target = 352;
	21: target = 5; 
	22: target = 16;
	23: target = 157;
	24: target = 30;
	25: target = 31;
	26: target = 37;
	27: target = 38;
	28: target = 44;
	29: target = 45;
	30: target = 51;
	31: target = 52;
	32: target = 74;
	33: target = 86;
	34: target = 94;
	35: target = 106;
	36: target = 114;
	37: target = 126;
	38: target = 134;
	39: target = 146;
	40: target = 154;
	41: target = 163;
	42: target = 164;
	43: target = 170;
	44: target = 171;
	45: target = 177;
	46: target = 178;
	47: target = 184;
	48: target = 185;
  default: target = 'b0;  // hold PC  
  endcase

endmodule

/*

	   pc = 4    0000_0000_0100	  4
	             1111_1111_1111	 -1

                 0000_0000_0011   3

				 (a+b)%(2**12)


   	  1111_1111_1011      -5
      0000_0001_0100     +20
	  1111_1111_1111      -1
	  0000_0000_0000     + 0


  */
