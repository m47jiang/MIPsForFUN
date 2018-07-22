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

module specialMux(input1, input2, sel, output1);
	input wire [31:0] input1;
	input wire [31:0] input2;
	input wire sel;
	output reg [31:0] output1;

	initial begin		
		output1 = 32'h80020000;
		$display("nextpc: %h",output1);
	end

	always @(*) begin
		if (sel == 1) 
		begin
			//$display("input1 address: %h, input2 address: %h", input1, input2);
		end
		output1 = sel? input2|32'h80000000 : input1;
	end
endmodule //mux


module immediateMux(input1, input2, sel, output1);
	input wire [31:0] input1;
	input wire [31:0] input2;
	input wire sel;
	output reg [31:0] output1;

	always @(*) begin
		//$display("input1: %h, input2: %h, sel: %d",input1, input2, sel);
		output1 = sel? input2: input1;
	end
endmodule //mux


