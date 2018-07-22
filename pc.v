module programCounter(clock, currentpc, nextpc);
	input wire clock;
	output reg [31:0] currentpc;
	input wire [31:0] nextpc;

	reg isFirstTime = 1;

	initial begin		
		currentpc = 32'h80020000 - 4;
		$display("Starting PC: %h",currentpc);
	end
	always @(posedge clock) begin
	  //$display("currentPC: %h",currentpc);
		//$display("nextPC: %h",nextpc);
		if(isFirstTime == 1)
		begin
			//$display("true PC: %h",currentpc);
			isFirstTime = 0;
		end
		else
		begin
			//$display("false PC: %h",currentpc);
			currentpc = nextpc;
			$display("currentPC: %h",currentpc);
			//$display("nextPC: %h",nextpc);
		end
	end
endmodule //pc
