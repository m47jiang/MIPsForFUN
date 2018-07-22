module registerfile (clock, address_s1, address_s2, address_d, data_dval, data_s1val, data_s2val, write_enable);
	input clock;
	input [4:0] address_s1;
	input [4:0] address_s2;
	input [4:0] address_d;
	input [31:0] data_dval;
	output reg [31:0] data_s1val;
	output reg [31:0] data_s2val;
	input write_enable;


	reg [31:0] registers [31:0];
	integer i;

	//assign data_s1val = registers[address_s1];
	//assign data_s2val = registers[address_s2];
	
	initial begin
		for(i = 5'b00000; i < 32; i= i+ 1) begin
			registers[i] = i;
			$display("Initialize %h - %h",i, registers[i]);
		end
	end

	always @(negedge clock) begin
	if (write_enable)
		begin
			//write stuff to the registers
			i = address_d;
			registers[i] = data_dval;
			$display("Write	Adress = %h, value = %h",i, data_dval);

		end
	end

	always @(address_s1, address_s2) begin
		
		data_s1val = registers[address_s1];
		data_s2val = registers[address_s2];
		$display("RegRead	Adress1 = %h, value = %h	Adress2 = %h, value = %h",address_s1, registers[address_s1], address_s2, registers[address_s2]);
		for(i = 5'b00000; i < 32; i= i+ 1) begin
			$display("Stored values %h - %h",i, registers[i]);
		end

	end
endmodule //registerfile
