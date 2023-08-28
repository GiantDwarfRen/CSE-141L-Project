module milestone2_quicktest_tb();

bit clk, reset;
wire done;
logic error[6];

top_level dut(
  .clk,
  .reset,
  .done);


always begin
  #5 clk = 1;
  #5 clk = 0;
end

initial begin
  /*dut.dm1.core[0] = 8'b11110000;
  dut.dm1.core[1] = 8'b11001100;
  dut.dm1.core[3] =	8'b11000011;
  dut.dm1.core[4] = 8'b01010101;
  #10 reset = 1;
  #10 reset = 0;
  #10 wait(done);
  #10 error[0] = (8'b11110000 ^ 8'b11001100) != dut.dm1.core[2];
  #10 error[1] = (8'b11000011 & 8'b01010101) != dut.dm1.core[5];
  #10 $display(error[0],,,error[1]);
  $stop;
  */
/*
  Test commend:
  MOV r0,  1							dm1[0] 	= 0101 0101
  LDR r1, r0							r1     	= 0101 0101
  MOV r2,  2							r2     	= 0000 0010
  ADR r1, r2						r1		= 0101 0111
  STR r1, r0							dm1[1]	= 0101 0111
  XOR r1, r2							r1		= 0101 0101
  MOV r0,  2
  STR r1, r0							dm1[2]  = 0101 0101
  LSH r1,  1							r1		= 1010 1010
  MOV r0,  3															
  STR r1, r0,						dm1[3]	= 1010 1010
  LSH r1, -3						r1		= 0001 0101
  MOV r0,  4
  STR r1, r0						dm1[4]	= 0001 0101
  ADI r1, -1						r1		= 0001 0100
  MOV r0, -8						get pari, should be 0
  MOV r0,  5
  STR r1, r0						dm1[5]	= 0001 0100
  BRC  -1								testing branch should fail
  MOV r0,  0
  BRC  0								pc		= #128, should success
*/

  dut.dm1.core[1] = 8'b01010101;
  #10 reset = 1;
  #10 reset = 0;			  
  #10 wait(done);
  #10 error[1] = 8'b01010111 != dut.dm1.core[1];
  #10 error[2] = 8'b01010101 != dut.dm1.core[2];
  #10 error[3] = 8'b10101010 != dut.dm1.core[3];
  #10 error[4] = 8'b00010101 != dut.dm1.core[4];
  #10 error[5] = 8'b00010100 != dut.dm1.core[5];
  #10 $display(error[1],,,error[2],,,error[3],,,error[4],,,error[5]);
  $stop;

end    

endmodule