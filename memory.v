module memory (clock, address, data_in, data_out, read_write, enable);
	input clock;
	input [31:0] address;
	input [31:0] data_in;
	output [31:0] data_out;
	input read_write;
	input enable;

	reg [7:0] memory[`MEM_DEPTH/4-1:0];
	reg data_out;
	reg [31:0]start_address = 32'h80020000;

	always @(posedge clock) begin
		if(~read_write & enable) 
			begin
				// compute offset address for memory register
				memory[(address-start_address)] <= data_in[31:24];	
				memory[(address-start_address) + 1] <= data_in[23:16];
				memory[(address-start_address) + 2] <= data_in[15:8];
				memory[(address-start_address) + 3] <= data_in[7:0];

			end
	end
	
	always @(*) begin
		if(read_write & enable)
			begin
				data_out = {memory[(address-start_address)],memory[(address-start_address) + 1],memory[(address-start_address)+ 2],memory[(address-start_address)+3]};
				address = address + 4;
			end
	end

endmodule //memory
