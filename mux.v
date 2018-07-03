module mux(input1, input2, sel, output1);
	input wire [31:0] input1;
	input wire [31:0] input2;
	input wire sel;
	output reg [31:0] output1;

	always @(*) begin
		//$display("select?: %h",sel);
		output1 = sel? input2: input1;
	end
endmodule //mux
