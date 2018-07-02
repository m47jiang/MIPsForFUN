`define MEM_DEPTH (1024)
module memory (clock, address, data_out);
	input clock;
	input [31:0] address;
	output [31:0] data_out;

	reg [7:0] memory[`MEM_DEPTH/4-1:0];
	reg data_out;
	reg [31:0]start_address = 32'h80020000;
	
	//for loading purposes
	reg [31:0] data [0:`MEM_DEPTH/4];
	integer i;

	always @(*) begin
		data_out = {memory[(address-start_address)],memory[(address-start_address) + 1],memory[(address-start_address)+ 2],memory[(address-start_address)+3]};
	end
	initial begin
		$readmemh("BubbleSort.x", data);

		for(i=0;data[i] || data[i] == 0;i=i+4) begin
			memory[start_address +i] <= data_[i/4][31:24];
			memory[start_address +i + 1] <= data_[i/4][23:16];
			memory[start_address +i + 2] <= data_[i/4][15:8];
			memory[start_address +i + 3] <= data_[i/4][7:0];
			 

		end
	end

endmodule //memory
