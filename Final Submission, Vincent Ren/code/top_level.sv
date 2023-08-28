// sample top level design
module top_level(
  input        clk, reset,  
  output logic done);
  parameter D = 12,             // program counter width
    A = 3;             		  // ALU command bit width
  wire[D-1:0] target, 			  // jump 
              prog_ctr;
  wire        RegWrite;
  wire[7:0]   datA,datB,		  // from RegFile
              muxB,				  // for ALU_Src
              muxC, 			  // for MemtoReg
			  rslt,				  // alu output
			  regfile_dat;		  // mem data_out
  wire[5:0]   immed6;
  logic /*sc_in, */ 			  // shift/carry out from/to ALU
   		pariQ,              	  // registered parity flag from ALU
		zeroQ;                    // registered zero flag from ALU 
  logic  absj;                     // from control to PC; relative jump enable
  wire /*sc_clr,
		sc_en,*/
        MemWrite,
        ALUSrc,		              // immediate switch
 		MemtoReg;

  wire[A-1:0] alu_cmd;
  wire[8:0]   mach_code;          // machine code
  wire[1:0] rd_addrA, 
  			rd_addrB;    // address pointers to reg_file
  wire		se_mode;	// for sign_ext electing between offset2, immed4, and immed6
  logic[7:0] se_out;	// sign_ext output

// fetch subassembly
  PC #(.D(D)) 					  // D sets program counter width
     pc1 (.reset            ,
         .clk              ,
		 //.reljump_en (relj),
		 .absjump_en (absj),
		 .target           ,
		 .prog_ctr          );

// lookup table to facilitate jumps/branches
  PC_LUT #(.D(D))
    pl1 (.addr  (mach_code[5:0]),
         .target          );   

// contains machine code
  instr_ROM ir1(.prog_ctr,
               .mach_code);

// control decoder
  Control ctl1(.instr(mach_code[8:6]),
  //.RegDst  (),
  .zeroQ, 
  .Branch(absj),  
  .MemWrite , 
  .ALUSrc   , 
  .RegWrite   ,     
  .MemtoReg,
  .se_mode,
  .ALUOp(alu_cmd));
								   
  assign rd_addrA = mach_code[5:4];
  assign rd_addrB = mach_code[3:2];
  assign alu_cmd  = mach_code[8:6];
  
  assign immed6   = mach_code[5:0];

  reg_file #(.pw(2)) rf1(
  			  .dat_in(muxC),	   // loads, most ops
              .clk         ,
              .wr_en   (RegWrite),
              .rd_addrA,
              .rd_addrB,
              .datA_out(datA),
              .datB_out(datB)); 
  
  sign_ext se(.dat_in(immed6), 
  			  .mode(se_mode), 
  			  .dat_out(se_out));

  assign muxB = ALUSrc? se_out : datB;
  assign muxC = MemtoReg? regfile_dat : rslt;

  alu alu1(
		 .clk,
  		 .alu_cmd,
         .inA    (datA),
		 .inB    (muxB),
		 //.sc_i   (sc),   // output from sc register
		 .rslt       ,
		 //.sc_o   (sc_o), // input to sc register
		 .zeroQ   ,
		 .pariQ   );  

  dat_mem dm1(.dat_in(datB)  ,  // from reg_file
             .clk           ,
			 .wr_en  (MemWrite), // stores
			 .addr   (rslt),			   
             .dat_out (regfile_dat));


  assign done = prog_ctr == 4095;
 
endmodule