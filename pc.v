module programCounter(clock, currentpc, nextpc);
	output reg [31:0] currentpc;
	input reg [31:0] nextpc;

	always @(posedge clock) begin
		currentpc = nextpc;
	end
endmodule //pc
