`define MEM_DEPTH (100000)
module icache (clock, address, data_out);
	input clock;
	input [31:0] address;
	output [31:0] data_out;

	reg [7:0] memory[`MEM_DEPTH/4-1:0];
	reg data_out;
	reg [31:0]start_address = 32'h80020000;
	
	//for loading purposes
	reg [31:0] data [0:`MEM_DEPTH/4];
	integer i;
	initial begin
		$readmemh("BubbleSort.x", data);

		for(i=0; i < `MEM_DEPTH/4;i=i+4) begin
			memory[i] = data[i/4][31:24];
			memory[i + 1] = data[i/4][23:16];
			memory[i + 2] = data[i/4][15:8];
			memory[i + 3] = data[i/4][7:0];

		end
		$display("Finish reading");

	end
	always @(posedge clock | address) begin
		
		data_out = {memory[(address-start_address)],memory[(address-start_address) + 1],memory[(address-start_address)+ 2],memory[(address-start_address)+3]};
		// $display("IC: adress = %h, instruction = %h", address, data_out);
	end


endmodule //memory
