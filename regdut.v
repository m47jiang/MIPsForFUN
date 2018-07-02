
`include "registerfile.v"

module dut;
	reg clock = 1;
	reg [31:0] pc;
	reg [31:0] data_in;
	//wire [31:0] data_out;
	reg read_write, enable; 

	integer a;
	integer i;
	integer register;


	reg [4:0] address_s1;
    reg [4:0] address_s2;
    reg [4:0] address_d;
	wire [31:0] immediate;
	wire sel;
	wire zero;
	reg write_enable;
	wire [5:0] alu_opcode;
	wire [31:0] in_s2;
	wire [31:0] in_s1;
	wire [31:0] data_s2val;
	reg [31:0] data_dval;

	reg [31:0] HI;
	reg [31:0] LO;

	initial begin
		$dumpfile("reg.vcd");
		$dumpvars(0, myRegFile); 
		
		#10;
		write_enable = 0;
		address_s1 = 4'b1000;

		#10;
		write_enable = 1;
		address_d = 4'b1000;
		address_s1 = 4'b1000;
		data_dval = 5'b1111;
		#10;
		write_enable = 0;
		address_s1 = 4'b1000;
		#10;
		

		$finish;
	end
	always begin
		//We're creating out clock here
		#5 clock = ~clock;
	end

	//initialize our module
	//main_memory mymem (.clock(clock), .address(pc), .data_in(data_in), .data_out(data_out), .read_write(read_write), .enable(enable));

	registerfile myRegFile(.clock(clock), .address_s1(address_s1), .address_s2(address_s2), .address_d(address_d), .data_dval(data_dval), .data_s1val(in_s1), .data_s2val(data_s2val), .write_enable(write_enable));

endmodule //dut
