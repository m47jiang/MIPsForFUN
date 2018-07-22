module alu(in_s1, in_s2, alu_opcode, zero, res, Branch);	
	input [31:0] in_s1;
	input [31:0] in_s2;
	input [5:0] alu_opcode;
	output reg zero;
	output reg [31:0] res;
	reg [63:0] mul_res;
	reg [31:0] low;
	reg [31:0] high;
	output reg Branch;
	always @(in_s2) begin
		case(alu_opcode)
			4'b0000:begin
			//ADD
				res = in_s1 + in_s2;
				zero = res? 0: 1;
				$display("Add : %h + %h = %h",in_s1, in_s2, res);
			end
			4'b0001:begin
				res = in_s1 - in_s2;
				zero = res? 0: 1;
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
				zero = res? 0: 1;
				$display("SLT : %h : %h : %h",in_s1, in_s2, res);
			end
			4'b0101:begin
				res = in_s1 << in_s2;
				zero = res? 0: 1;
				$display("SLL : %h : %h : %h",in_s1, in_s2, res);
			end
			4'b0110:begin
				res = in_s1 >> in_s2;
				zero = res? 0: 1;
				$display("SRL : %h : %h : %h",in_s1, in_s2, res);
			end
			4'b0111:begin
				res = in_s1 >>> in_s2;
				zero = res? 0: 1;
				$display("SRA : %h : %h : %h",in_s1, in_s2, res);
			end
			4'b1000:begin
				res = in_s1 & in_s2;
				zero = res? 0: 1;
				$display("AND : %h : %h : %h",in_s1, in_s2, res);
			end
			4'b1001:begin
				//OR
				res = in_s1 | in_s2;
				zero = res? 0: 1;
				$display("OR : %h : %h : %h",in_s1, in_s2, res);
			end
			4'b1010:begin
				//XOR
				res = in_s1 ^ in_s2;
				zero = res? 0: 1;
				$display("XOR : %h : %h : %h",in_s1, in_s2, res);
			end
			4'b1011:begin
				res = !(in_s1 | in_s2);
				zero = res? 0: 1;
				$display("NOR : %h : %h : %h",in_s1, in_s2, res);
			end
			4'b1100:begin
				res = in_s2 << 16;
				zero = res? 0: 1;
				$display("LUI : %h : %h",, in_s2, res);
			end
			4'b1101:begin
			//BEQZ
				res = in_s1;
				zero = res? 0: 1;
				Branch = zero;
				$display("BEQZ : %h ",in_s1, res);
			end
			5'b10000:begin
			//JALR
				res = in_s2;
				zero = res? 0: 1;
				$display(" JUMP TO %h",in_s2);
			end
			5'b10001:begin
			//BEQ
				res = in_s1 - in_s2;
				zero = res? 0: 1;
				Branch = zero;
				$display(" JUMP TO %h",in_s1);
			end
			5'b10010:begin
			//BNQZ
				res = in_s1;
				zero = res? 0: 1;
				Branch = zero;
				$display("BNQZ : %h ",in_s1, res);
			end
			5'b10011:begin
			//BNE
				res = in_s1;
				zero = res? 0: 1;
				Branch = zero;
				$display("BNE : %h ",in_s1, res);
			end
			5'b10100:begin
			//BLTZ
				res = in_s1;
				zero = res? 0: 1;
				Branch = zero;
				$display("BLTZ : %h ",in_s1, res);
			end
			5'b10101:begin
			//BGEZ
				res = in_s1;
				zero = res? 0: 1;
				Branch = zero;
				$display("BGEZ : %h ",in_s1, res);
			end
			5'b10110:begin
			//BGTZ
				res = in_s1;
				zero = res? 0: 1;
				Branch = zero;
				$display("BGTZ : %h ",in_s1, res);
			end
			5'b10111:begin
			//BLEZ
				res = in_s1;
				zero = res? 0: 1;
				Branch = zero;
				$display("BLEZ : %h ",in_s1, res);
			end
			5'b11000:begin
			//MFHI
				res = high;
				zero = res? 0: 1;
				$display("MFHI : %h ",in_s1, res);
			end
			5'b11001:begin
			//MFLO
				res = low;
				zero = res? 0: 1;
				$display("MFLO : %h ",in_s1, res);
			end
			5'b11010:begin
			//MOVE
				res = in_s1;
				zero = res? 0: 1;
				$display("MOVE : %h ",in_s1, res);
			end
			5'b11011:begin
			//LW
				res = in_s1 + in_s2;
				zero = res? 0: 1;
				$display("LW : %h ",in_s1, res);
			end
			5'b11100:begin
			//SW
				$display("input1 : %h, input2: %h ",in_s1, in_s2);
				res = in_s1 + in_s2;
				zero = res? 0: 1;
				$display("SW : %h ",in_s1, res);
			end

			default:begin
			//do nothing
			end
		endcase
	end
endmodule //alu
