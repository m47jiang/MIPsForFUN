`include "decoder.v"
`include "registerfile.v"
`include "mux.v"
`include "alu.v"
`include "memory.v"
`include "pc.v"
`include "intruction_cache.v"

module dut;
	reg clock = 1;
	wire [31:0] pc;
	wire [31:0] nextpc;
	wire [31:0] branchOutput; 
	wire [31:0] instruction;
	wire read_write, enable; 
	integer a;
	integer i;
	integer register;

	//Decoder wires
	wire [4:0] address_s1;
    	wire [4:0] address_s2;
   	wire [4:0] address_d;	
	wire [31:0] immediate;
	wire [5:0] alu_opcode;
	wire sel;

	//Control signals
	wire Jump;	// Done, this is Jump select
	wire Branch;	// Done, this is branch select
	wire ALUSrc;  	// Done, this is mux select for second input to ALU
	wire ALUOp;	// Don't need this, look at alu_opcode
	wire MemEnable;	// Done, this enable Data cache memory read/write
	wire RegWrite; 	// Done, this is write enable to register
	wire RegToImmediate;	// output value from register file
	wire MemtoReg;	// Done, this is value selection from ALU or memory which one writes back to registerfile
	wire isByte;

	//Alu wires
	wire [31:0] in_s2;
	wire [31:0] in_s1;
	wire [31:0] data_s2val;
	wire [31:0] data_dval;
	wire [31:0] res;
	wire zero;

	//Data Cache wires
	wire [31:0] memory_output;

	//Registers for multiplication

	wire [31:0] incrementedpc;
	wire [31:0] branchingAddress;
	wire [31:0] jumpAddress;
	wire [31:0] jumpInput;

	initial begin
		$dumpfile("alu.vcd");
		$dumpvars(0, myDecoder); 
		$dumpvars(0, myRegFile); 
		$dumpvars(0, myAlu); 
		$dumpvars(0, myPC); 
		$dumpvars(0, icache); 
		$dumpvars(0, dut); 
		
		//nextpc = 32'h80020000;
		
		for(i = 0; i < 20; i =i+1) begin
			#10;
		end
		
		//initializing registers

		//Creating the memory
/*
		enable = 1;
		base_address = 32'h80020000;
		a = 0;
		for(i=0;data[i] || data[i] == 0;i=i+1) begin
			a = a+1;
			data_in = data[i];
			#10 base_address = base_address + 4;
		end*/
		$finish;
	end
	always begin
		//We're creating out clock here
		#5 clock = ~clock;
	end

	//Branching mux
	assign incrementedpc = pc + 4;
	assign branchingAddress = incrementedpc + immediate;
	mux pcBranchMux(.input1(incrementedpc), .input2(branchingAddress), .sel(Branch), .output1(branchOutput));

	//Jump Mux
	assign jumpAddress = jumpInput << 2;
	mux pcJumpMux(.input1(branchOutput), .input2(jumpAddress), .sel(Jump), .output1(nextpc)); 

	//PC
	programCounter myPC(.clock(clock), .currentpc(pc), .nextpc(nextpc));

	//Instruction Cache
	icache icache(.clock(clock), .address(pc), .data_out(instruction));

	//Mux input for address_d NOT SURE IF NEEDED
	//mux dataAddressInputMux(.input1(address_s2), input2(immediate), .sel(RegDst), .output1(address_d));

	//Making decoder
	decoder myDecoder(.instruction(instruction), .pc(pc), .address_s1(address_s1), .address_s2(address_s2), .address_d(address_d), .immediate(immediate), .ALUSrc(ALUSrc), .alu_opcode(alu_opcode), .readwrite(read_write), .Branch(Branch), .MemEnable(MemEnable), .RegWrite(RegWrite), .MemtoReg(MemtoReg), .Jump(Jump), .isByte(isByte));

	//Making Register file
	registerfile myRegFile(.clock(clock), .address_s1(address_s1), .address_s2(address_s2), .address_d(address_d), .data_dval(data_dval), .data_s1val(in_s1), .data_s2val(data_s2val), .write_enable(RegWrite));
	
	//Making mux (register file and intruction decoder, outputs to alu)
	mux aluInputMux(.input1(data_s2val), .input2(immediate), .sel(ALUSrc), .output1(in_s2));
	// connect regfile to immidiate
	mux immediateOuputMux (.input1(immediate), .input2(data_s2val), .sel(RegToImmediate), .output1(jumpInput));

	//Making Alu
	alu myAlu(.in_s1(in_s1), .in_s2(in_s2), .alu_opcode(alu_opcode), .zero(zero), .res(res));

	//Making data cache
	memory dataCache(.clock(clock), .address(res), .data_in(data_s2val), .data_out(memory_output), .read_write(read_write), .enable(MemEnable));

	//Making mux (alu and data cache input, outputs to register file
	mux writebackInputMux(.input1(res), .input2(memory_output), .sel(MemtoReg), .output1(data_dval));



endmodule //dut





