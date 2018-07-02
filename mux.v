module mux(input1, input2, sel, output1);
	input [31:0] input1;
	input [31:0] input2;
	input sel;
	output reg [31:0] output1;

	always @(*) begin
		output1 = sel? input2: input1;
	end
endmodule //mux
