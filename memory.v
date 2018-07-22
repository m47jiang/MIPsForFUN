module memory (clock, address, data_in, data_out, read_write, enable, isByte);
	input clock;
	input [31:0] address;
	input [31:0] data_in;
	input isByte;
	output reg [31:0] data_out;
	input read_write;
	input enable;

	reg [7:0] memory[1024/4-1:0];
	reg [31:0]start_address = 32'h80020000;

	always @(posedge clock) begin
		if(read_write & enable & ~isByte) 
			begin
				$display("Writing to memory: %h at location %h", data_in, (address));
				// compute offset address for memory register
				memory[(address-start_address)] <= data_in[31:24];	
				memory[(address-start_address) + 1] <= data_in[23:16];
				memory[(address-start_address) + 2] <= data_in[15:8];
				memory[(address-start_address) + 3] <= data_in[7:0];

			end
		if(read_write & enable & isByte) 
			begin
			  $display("Writing to memory: %h at location %h", data_in, (address));
				// compute offset address for memory register
				memory[(address-start_address)] <= data_in[31:24];	
				memory[(address-start_address) + 1] <= 8'h00;
				memory[(address-start_address) + 2] <= 8'h00;
				memory[(address-start_address) + 3] <= 8'h00;

			end
	end
	
	always @(negedge clock) begin
		if(~read_write & enable & ~isByte)
			begin
				data_out = {memory[(address-start_address)],memory[(address-start_address) + 1],memory[(address-start_address)+ 2],memory[(address-start_address)+3]};
				$display("reading from memory: %h", data_out);
			end
		if(~read_write & enable & isByte)
			begin
				data_out = {memory[(address-start_address)]};
				$display("reading from memory: %h", data_out);
			end
	end


endmodule //memory
