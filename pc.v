module programCounter(clock, currentpc, nextpc);
	input wire clock;
	output reg [31:0] currentpc;
	input wire [31:0] nextpc;

	initial begin		
		currentpc = 32'h80020000;
		$display("Starting PC: %h",currentpc);
	end
	always @(posedge clock) begin
		currentpc = nextpc;
		$display("current PC: %h",currentpc);
	end
endmodule //pc
