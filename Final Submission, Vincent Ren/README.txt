Hello this is Vincent. I've demo my project during class time to Professor Eldon. 
He asks me to submit this folders with brief instructions.


From root, you would find a final submission pdf "CSE 141L Milestone 4, Vincent Ren".
You can see any design details in it.

Under "images" folder, you would find all source pictures used in submission pdf

Under "code" folder, you would find all things needed for the project, including:
  - Assembly Code. named "programX_assembly", where "X" stands for 1, 2, 3
  - Machine code. named "mach_code_X", where "X" stands for 1, 2, 3
  - Hardware code. all files ending with .sv
  - C++ Assemblier "Assembly_translate.c++"
  - some other files for ModelSim and Quartus.

Top_level:
  There are 2 input signals and 1 output signals
  - clk. clock signal
  - reset. reseting the program
  - done. If 1 means program is done; 0 otherwise.

Lanch program 1:
  1. open "instr_ROM", change line 10 to 
	$readmemb("mach_code_1.txt",core);
  2. recompile and run test bench

Lanch program 2:
  1. open "instr_ROM", change line 10 to 
	$readmemb("mach_code_2.txt",core);
  2. recompile and run test bench

Lanch program 3:
  1. open "instr_ROM", change line 10 to 
	$readmemb("mach_code_3.txt",core);
  2. recompile and run test bench

