module decoder (instruction, pc, address_s1, address_s2, address_d, immediate, sel, alu_opcode, readwrite);
	input [31:0] instruction;
	input [31:0] pc;

	wire [5:0] opcode = instruction[31:26];
	wire [4:0] rs = instruction[25:21];
	wire [4:0] base = instruction[25:21];
	wire [25:0] target = instruction[25:0];
	wire [4:0] rt = instruction[20:16];
	wire [4:0] rd = instruction[15:11];
	wire [15:0] offset = instruction[15:0];
	wire [15:0] immed = instruction[15:0];
	wire [5:0] sa = instruction[10:6];
	wire [5:0] sOpcode = instruction[5:0];

	output reg [4:0] address_s1;
	output reg [4:0] address_s2;
	output reg [4:0] address_d;
	output reg [31:0] immediate;
	output reg [5:0] alu_opcode;
	output reg sel;
	output reg readwrite;


	always @(instruction) begin
		sel = 0;
		case(opcode)
			6'b000000:begin
				case(sOpcode)
					6'b100000:begin
						$display("%h    %h    ADD R%0d, R%0d, R%0d", pc , pc , instruction, rs, rt, rd); 
						address_s1 = rs;
						address_s2 = rt;
						address_d = rd;
						alu_opcode = 4'b0000;
						sel = 0;
					end
					6'b100001:begin
						$display("%h    %h    ADDU R%0d, R%0d, R%0d", pc , pc , instruction, rs, rt, rd);
						address_s1 = rs;
						address_s2 = rt;
						address_d = rd;
						alu_opcode = 4'b0000;
						sel = 0;
					end
					6'b100010:begin
						$display("%h    %h    SUB R%0d, R%0d, R%0d", pc , pc , instruction, rs, rt, rd);
						address_s1 = rs;
						address_s2 = rt;
						address_d = rd;
						alu_opcode = 4'b0001;
						sel = 0;
					end
					6'b100011:begin
						$display("%h    %h    SUBU R%0d, R%0d, R%0d", pc , pc , instruction, rs, rt, rd);
						address_s1 = rs;
						address_s2 = rt;
						address_d = rd;
						alu_opcode = 4'b0001;
						sel = 0;
					end
					6'b011000:begin
						$display("%h    %h    MULT R%0d, R%0d", pc , pc , instruction, rs, rt);
						address_s1 = rs;
						address_s2 = rt;
						address_d = rd;
						alu_opcode = 4'b0010;
						sel = 0;
					end
					6'b011001:begin
						$display("%h    %h    MULTU R%0d, R%0d", pc , pc , instruction, rs, rt);
						address_s1 = rs;
						address_s2 = rt;
						address_d = rd;
						alu_opcode = 4'b0010;
						sel = 0;
					end
					6'b011010:begin
						$display("%h    %h    DIV R%0d, R%0d", pc , pc , instruction, rs, rt);
						address_s1 = rs;
						address_s2 = rt;
						address_d = rd;
						alu_opcode = 4'b0011;
						sel = 0;
					end
					6'b011011:begin
						$display("%h    %h    DIVU R%0d, R%0d", pc , pc , instruction, rs, rt);	
						address_s1 = rs;
						address_s2 = rt;
						address_d = rd;
						alu_opcode = 4'b0011;
						sel = 0;
					end
					6'b010000:begin
						$display("%h    %h    MFHI R%0d", pc , pc , instruction, rd);
					end
					6'b010010:begin
						$display("%h    %h    MFLO R%0d", pc , instruction, rd);
					end
					6'b101010:begin
						$display("%h    %h    SLT R%0d, R%0d, R%0d", pc , instruction, rs, rt, rd);
						address_s1 = rs;
						address_s2 = rt;
						address_d = rd;
						alu_opcode = 4'b0100;
						sel = 0;
					end
					6'b101011:begin
						$display("%h    %h    SLTU R%0d, R%0d, R%0d", pc , instruction, rs, rt, rd);
						address_s1 = rs;
						address_s2 = rt;
						address_d = rd;
						alu_opcode = 4'b0100;
						sel = 0;
					end
					6'b000000:begin
						$display("%h    %h    SLL R%0d, R%0d, 0x%h", pc , instruction, rt, rd, sa);
						address_s1 = rt;
						immediate = sa;
						address_d = rd;
						alu_opcode = 4'b0101;
						sel = 1;
					end
					6'b000100:begin
						$display("%h    %h    SLLV R%0d, R%0d, R%0d", pc , instruction, rs, rt, rd);
						address_s1 = rt;
						address_s2 = rs;
						address_d = rd;
						alu_opcode = 4'b0101;
						sel = 0;
					end
					6'b000010:begin
						$display("%h    %h    SRL R%0d, R%0d, R%0d", pc , instruction, rt, rd, sa);
						address_s1 = rt;
						immediate = sa;
						address_d = rd;
						alu_opcode = 4'b0110;
						sel = 1;
					end
					6'b000110:begin
						$display("%h    %h    SRLV R%0d, R%0d, R%0d", pc , instruction, rs, rt, rd);
						address_s1 = rt;
						address_s2 = rs;
						address_d = rd;
						alu_opcode = 4'b0110;
						sel = 0;
					end
					6'b000011:begin
						$display("%h    %h    SRA R%0d, R%0d, 0x%h", pc , instruction, rt, rd, sa);
						address_s1 = rt;
						immediate = sa;
						address_d = rd;
						alu_opcode = 4'b0111;
						sel = 1;
					end
					6'b000111:begin
						$display("%h    %h    SRAV R%0d, R%0d, R%0d", pc , instruction, rd, rt, rs);
						address_s1 = rt;
						address_s2 = rs;
						address_d = rd;
						alu_opcode = 4'b0111;
						sel = 0;
					end
					6'b100100:begin
						$display("%h    %h    AND R%0d, R%0d, R%0d", pc , instruction, rs, rt, rd);
						address_s1 = rs;
						address_s2 = rt;
						address_d = rd;
						alu_opcode = 4'b1000;
						sel = 0;
					end
					6'b100101:begin
						case(rt)
							5'b00000:begin
								$display("%h    %h    MOVE R%0d, R%0d", pc , instruction, rd, rs);
							end
							default:begin
								$display("%h    %h    OR R%0d, R%0d, R%0d", pc , instruction, rd, rs, rt);
								address_s1 = rs;
								address_s2 = rt;
								address_d = rd;
								alu_opcode = 4'b1001;
								sel = 0;
							end	
						endcase
					end
					6'b100110:begin
						$display("%h    %h    XOR R%0d, R%0d, R%0d", pc , instruction, rd, rs, rt);
						address_s1 = rs;
						address_s2 = rt;
						address_d = rd;
						alu_opcode = 4'b1010;
						sel = 0;
					end
					6'b100111:begin
						$display("%h    %h    NOR R%0d, R%0d, R%0d", pc , instruction, rd, rs, rt);
						address_s1 = rs;
						address_s2 = rt;
						address_d = rd;
						alu_opcode = 4'b1011;
						sel = 0;
					end
					6'b001001:begin
						$display("%h    %h    JALR R%0d, R%0d", pc , instruction, rd, rs);
						address_s1 = rs;
						address_d = rd;
						sel = 0;
						alu_opcode = 5'b10000;
					end
					6'b001000:begin
						$display("%h    %h    JR R%0d", pc , instruction, rs);
						address_s1 = rs;
						address_d = rd;
						sel = 0;
						alu_opcode = 5'b10000;
					end
				endcase	
			end
			6'b001001:begin
				$display("%h    %h    ADDIU R%0d, R%0d, 0x%h", pc , instruction, rt, rs, immed);
					address_s1 = rs;
					immediate = immed;
					address_d = rt;
					alu_opcode = 4'b0000;
					sel = 1;
			end
			6'b001010:begin
				$display("%h    %h    SLTI R%0d, R%0d , 0x%h", pc , instruction, rt, rs, immed);
				address_s1 = rs;
				immediate = immed;
				address_d = rt;
				alu_opcode = 4'b0100;
				sel = 1;
				
			end
			6'b001011:begin
				$display("%h    %h    SLTIU R%0d, R%0d, 0x%h", pc , instruction, rt, rs, immed);
				address_s1 = rs;
				immediate = immed;
				address_d = rt;
				alu_opcode = 4'b0100;
				sel = 1;
			end
			6'b001101:begin
				$display("%h    %h    ORI R%0d, R%0d, 0x%h", pc , instruction, rt, rs, immed);
				address_s1 = rs;
				immediate = immed;
				address_d = rt;
				alu_opcode = 4'b1001;
				sel = 1;
			end
			6'b001110:begin
				$display("%h    %h    XORI R%0d, R%0d, 0x%h", pc , instruction, rt, rs, immed);
				address_s1 = rs;
				immediate = immed;
				address_d = rt;
				alu_opcode = 4'b1010;
				sel = 1;
			end
			6'b100011:begin
				$display("%h    %h    LW R%0d, %d(R%0d)", pc , instruction, rt, offset, base);
				readwrite = 0;
			end
			6'b101011:begin
				$display("%h    %h    SW R%0d, %d(R%0d)", pc , instruction, rt, offset, base);
				readwrite = 1;
			end
			6'b001111:begin
				$display("%h    %h    LUI R%0d, 0x%h", pc , instruction, rt, immed);				
				immediate = immed;
				address_d = rt;
				alu_opcode = 4'b1100;
				sel = 1;
			end
			6'b100000:begin
				$display("%h    %h    LB R%0d, %d(R%0d)", pc , instruction, rt, offset, base);
				immediate = pc;
				alu_opcode = 4'b0000;
				address_d = rs;
				sel = 1;
			end
			6'b101000:begin
				$display("%h    %h    SB R%0d, %d(R%0d)", pc , instruction, rt, offset, base);
				immediate = pc;
				alu_opcode = 4'b0000;
				address_d = rt;
				sel = 1;
			end
			6'b100100:begin
				$display("%h    %h    LBU R%0d, %d(R%0d)", pc , instruction, rt, offset, base);
				immediate = pc;
				alu_opcode = 4'b0000;
				address_d = rt;
				sel = 1;
			end
			6'b000010:begin
				$display("%h    %h    J 0x%h", pc , instruction, target);
				immediate = target;
				alu_opcode = 5'b10001;
				address_d = rt;
				sel = 1;
			end
			6'b000011:begin
				$display("%h    %h    JAL 0x%h", pc , instruction, target);
				immediate = target;
				alu_opcode = 5'b10001;
				address_d = rt;
				sel = 1;
			end
			6'b000100:begin
				case(rt)
					6'b000000:begin
						$display("%h    %h    BEQZ R%0d, 0x%h", pc , instruction, rs, offset);
						address_s1 = rs;
						sel= 0;
						alu_opcode = 4'b1101;
						
					end
					default : begin 
						$display("%h    %h    BEQ R%0d, R%0d, 0x%h", pc , instruction, rs, rt, offset);
						address_s1 = rs;
						address_s2 = rt;
						sel = 0;
						alu_opcode = 4'b0001;
					end
				endcase
			end
			6'b000101:begin
				case(rt)
					6'b000000:begin
						$display("%h    %h    BNEZ R%0d, 0x%h", pc , instruction, rs, offset);
						address_s1 = rs;
						sel= 0;
						alu_opcode = 4'b1101;
					end
					default : begin
						$display("%h    %h    BNE R%0d, R%0d, 0x%h", pc , instruction, rs, rt, offset);
						address_s1 = rs;
						address_s2 = rt;
						sel = 0;
						alu_opcode = 4'b0001;
					end
				endcase
			end
			6'b000001:begin
				case(rt)
					5'b00000:begin
						$display("%h    %h    BLTZ R%0d, 0x%h", pc , instruction, rs, offset);
					end
					5'b00001:begin
						$display("%h    %h    BGEZ R%0d, 0x%h", pc , instruction, rs, offset);
					end
				endcase
			end
			6'b000111:begin
				$display("%h    %h    BGTZ R%0d, 0x%h", pc , instruction, rs, offset);
			end
			6'b000110:begin
				$display("%h    %h    BLEZ R%0d, 0x%h", pc , instruction, rs, offset);
			end
			6'b000000:begin
				$display("%h    %h    NOP", pc , instruction);
			end
		endcase
	end
endmodule



