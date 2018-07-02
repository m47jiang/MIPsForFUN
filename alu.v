module alu(in_s1, in_s2, alu_opcode, zero);	
	input [31:0] in_s1;
	input [31:0] in_s2;
	input [5:0] alu_opcode;
	output reg zero;
	reg [31:0] res;
	reg [63:0] mul_res;
	reg [31:0] low;
	reg [31:0] high;
	always @(*) begin
		case(alu_opcode)
			4'b0000:begin
			//ADD
				res = in_s1 + in_s2;
				zero = res? 1: 0;
				$display("Add : %h + %h = %h",in_s1, in_s2, res);
			end
			4'b0001:begin
				res = in_s1 - in_s2;
				zero = res? 1: 0;
				$display("Sub : %h , %h = %h",in_s1, in_s2, res);
			end
			4'b0010:begin
				mul_res = in_s1 * in_s2;
				zero = mul_res? 1:0;
				$display("Mul : %h : %h : %h",in_s1, in_s2, mul_res);
			end
			4'b0011:begin
				low = in_s1/in_s2;
				high = in_s1 % in_s2;
				$display("Div : %h : %h : %h",in_s1, in_s2, low);
			end
			4'b0100:begin
				res = in_s1 < in_s2;
				zero = res? 1: 0;
				$display("SLT : %h : %h : %h",in_s1, in_s2, res);
			end
			4'b0101:begin
				res = in_s1 << in_s2;
				zero = res? 1: 0;
				$display("SLL : %h : %h : %h",in_s1, in_s2, res);
			end
			4'b0110:begin
				res = in_s1 >> in_s2;
				zero = res? 1: 0;
				$display("SRL : %h : %h : %h",in_s1, in_s2, res);
			end
			4'b0111:begin
				res = in_s1 >>> in_s2;
				zero = res? 1: 0;
				$display("SRA : %h : %h : %h",in_s1, in_s2, res);
			end
			4'b1000:begin
				res = in_s1 & in_s2;
				zero = res? 1: 0;
				$display("AND : %h : %h : %h",in_s1, in_s2, res);
			end
			4'b1001:begin
				//OR
				res = in_s1 | in_s2;
				zero = res? 1: 0;
				$display("OR : %h : %h : %h",in_s1, in_s2, res);
			end
			4'b1010:begin
				//XOR
				res = in_s1 ^ in_s2;
				zero = res? 1: 0;
				$display("XOR : %h : %h : %h",in_s1, in_s2, res);
			end
			4'b1011:begin
				res = !(in_s1 | in_s2);
				zero = res? 1: 0;
				$display("NOR : %h : %h : %h",in_s1, in_s2, res);
			end
			4'b1100:begin
				res = in_s2 << 16;
				zero = res? 1: 0;
				$display("LUT : %h : %h",, in_s2, res);
			end
			4'b1101:begin
			//BEQZ
				res = in_s1;
				zero = res? 1: 0;
				$display("BEQZ : %h ",in_s1, res);
			end
			5'b10000:begin
			//JALR
				res = in_s1;
				zero = res? 1: 0;
				$display(" JUMP TO %h",in_s1);
			end
			5'b10001:begin
			//J
				res = in_s2;
				zero = res? 1: 0;
				$display(" JUMP TO %h",in_s2);
			end
			

		endcase
	end
endmodule //alu
