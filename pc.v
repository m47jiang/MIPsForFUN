module programCounter(clock, currentpc, nextpc);
	input wire clock;
	output reg [31:0] currentpc;
	input wire [31:0] nextpc;

	initial begin		
		currentpc = 32'h80020000;
		$display("Starting PC: %h",currentpc);
	end
	always @(posedge clock) begin
		$display("nextPC: %h",nextpc);
		if(currentpc == 32'h80020000)
		begin
			//$display("true PC: %h",currentpc);
			currentpc = currentpc + 4;
		end
		else
		begin
			//$display("false PC: %h",currentpc);
			currentpc = nextpc;
		end
	end
endmodule //pc
