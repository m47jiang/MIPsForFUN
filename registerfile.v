module registerfile (clock, address_s1, address_s2, address_d, data_dval, data_s1val, data_s2val, write_enable);
	input clock;
	input [4:0] address_s1;
	input [4:0] address_s2;
	input [4:0] address_d;
	input [31:0] data_dval;
	output reg [31:0] data_s1val;
	output reg [31:0] data_s2val;
	input write_enable;


	reg [4:0] registers [31:0];
	integer i;
	
	initial begin
		for(i = 4'b0000; i < 32; i= i+ 1) begin
			registers[i] = i;
			$display("Initialize %h - %h",i, registers[i]);
		end
	end

	always @(posedge clock) begin
	if (write_enable)
		begin
			//write stuff to the registers
			
			registers[address_d] <= data_dval;
			$display("Write	Adress = %h, value = %h",address_d, data_dval);


		end
	end

	always @(negedge clock) begin
		
		data_s1val = registers[address_s1];
		data_s2val = registers[address_s2];
		$display("Read	Adress1 = %h, value = %h	Adress2 = %h, value = %h",address_s1, data_s1val, address_s2, data_s2val);

	end
endmodule //registerfile
