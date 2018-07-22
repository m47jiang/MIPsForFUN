module decoder (instruction, pc, address_s1, address_s2, address_d, immediate, alu_opcode, readwrite, Jump, Branch, ALUSrc, MemEnable, RegWrite, RegToImmediate, MemtoReg, Jump, isByte, linkAddress, linkSignal);
	input [31:0] instruction;
	input [31:0] pc;

	reg [5:0] opcode;
	reg [4:0] rs;
	reg [4:0] base;
	reg [25:0] target;
	reg [4:0] rt;
  reg [4:0] rd;
	reg [15:0] offset;
	reg [15:0] immed;
	reg [5:0] sa;
	reg [5:0] sOpcode;
	
	output reg [4:0] address_s1;
	output reg [4:0] address_s2;
	output reg [4:0] address_d;
	output reg [31:0] immediate;
	output reg [31:0] linkAddress;
	output reg [5:0] alu_opcode;
	output reg readwrite;
	output reg Jump;		
	output reg Branch;	
  output reg ALUSrc;  	
	output reg MemEnable;	
	output reg RegWrite; 	
	output reg RegToImmediate;
	output reg MemtoReg;	
	output reg isByte;
	output reg linkSignal;
	
	initial begin
		Jump = 0;	
		Branch = 0;
		ALUSrc = 0;
		MemEnable = 0;
		RegWrite = 0;
		MemtoReg = 0;		
		RegToImmediate = 0;
		readwrite = 0;
		isByte = 0;
		linkSignal = 0;
	end

	
	always @(instruction) begin
		opcode = instruction[31:26];
		rs = instruction[25:21];
		base = instruction[25:21];
		target = instruction[25:0];
		rt = instruction[20:16];
  	rd = instruction[15:11];
		offset = instruction[15:0];
		immed = instruction[15:0];
		sa = instruction[10:6];
		sOpcode = instruction[5:0];

		Jump = 0;	
		Branch = 0;
		ALUSrc = 0;
		MemEnable = 0;
		RegWrite = 0;
		MemtoReg = 0;		
		RegToImmediate = 0;
		readwrite = 0;
		isByte = 0;
		linkSignal = 0;
		$display("Instruction: %h", instruction);
		$display("Opcode: %h", opcode);
		case(opcode)
			6'b000000:begin
				case(sOpcode)
					6'b100000:begin
						$display("%h    %h    ADD R%0d, R%0d, R%0d", pc , instruction, rd, rs, rt); 
						address_s1 = rs;
						address_s2 = rt;
						address_d = rd;
						alu_opcode = 4'b0000;
						RegWrite = 1;
					end
					6'b100001:begin
						$display("%h    %h    ADDU R%0d, R%0d, R%0d", pc , instruction, rd, rs, rt);
						address_s1 = rs;
						address_s2 = rt;
						address_d = rd;
						alu_opcode = 4'b0000;						
						RegWrite = 1;
					end
					6'b100010:begin
						$display("%h    %h    SUB R%0d, R%0d, R%0d", pc , instruction, rs, rt, rd);
						address_s1 = rs;
						address_s2 = rt;
						address_d = rd;
						alu_opcode = 4'b0001;
						RegWrite = 1;
					end
					6'b100011:begin
						$display("%h    %h    SUBU R%0d, R%0d, R%0d", pc , instruction, rs, rt, rd);
						address_s1 = rs;
						address_s2 = rt;
						address_d = rd;
						alu_opcode = 4'b0001;
						RegWrite = 1;
					end
					6'b011000:begin
						$display("%h    %h    MULT R%0d, R%0d", pc , pc , instruction, rs, rt);
						address_s1 = rs;
						address_s2 = rt;
						address_d = rd;
						alu_opcode = 4'b0010;
						RegWrite = 1;
						
						
					end
					6'b011001:begin
						$display("%h    %h    MULTU R%0d, R%0d", pc , pc , instruction, rs, rt);
						address_s1 = rs;
						address_s2 = rt;
						address_d = rd;
						alu_opcode = 4'b0010;
						RegWrite = 1;
					end
					6'b011010:begin
						$display("%h    %h    DIV R%0d, R%0d", pc , pc , instruction, rs, rt);
						address_s1 = rs;
						address_s2 = rt;
						address_d = rd;
						alu_opcode = 4'b0011;
						RegWrite = 1;
					end
					6'b011011:begin
						$display("%h    %h    DIVU R%0d, R%0d", pc , pc , instruction, rs, rt);	
						address_s1 = rs;
						address_s2 = rt;
						address_d = rd;
						alu_opcode = 4'b0011;
						RegWrite = 1;
					end
					6'b010000:begin
						$display("%h    %h    MFHI R%0d", pc , pc , instruction, rd);
						RegWrite = 1;
						address_d = rd;
						alu_opcode = 5'b11000;
						
					end
					6'b010010:begin
						$display("%h    %h    MFLO R%0d", pc , instruction, rd);
						RegWrite = 1;
						address_d = rd;
						alu_opcode = 5'b11001;
					end
					6'b101010:begin
						$display("%h    %h    SLT R%0d, R%0d, R%0d", pc , instruction, rs, rt, rd);
						address_s1 = rs;
						address_s2 = rt;
						address_d = rd;
						alu_opcode = 4'b0100;
						RegWrite = 1;
						
					end
					6'b101011:begin
						$display("%h    %h    SLTU R%0d, R%0d, R%0d", pc , instruction, rs, rt, rd);
						address_s1 = rs;
						address_s2 = rt;
						address_d = rd;
						alu_opcode = 4'b0100;
						RegWrite = 1;
					end
					6'b000000:begin
						$display("%h    %h    SLL R%0d, R%0d, 0x%h", pc , instruction, rt, rd, sa);
						address_s1 = rt;
						immediate = sa;
						address_d = rd;
						alu_opcode = 4'b0101;
						RegWrite = 1;
						ALUSrc = 1;
					end
					6'b000100:begin
						$display("%h    %h    SLLV R%0d, R%0d, R%0d", pc , instruction, rs, rt, rd);
						address_s1 = rt;
						address_s2 = rs;
						address_d = rd;
						alu_opcode = 4'b0101;
						RegWrite = 1;
					end
					6'b000010:begin
						$display("%h    %h    SRL R%0d, R%0d, R%0d", pc , instruction, rt, rd, sa);
						address_s1 = rt;
						immediate = sa;
						address_d = rd;
						alu_opcode = 4'b0110;
						RegWrite = 1;
						ALUSrc =1;
					end
					6'b000110:begin
						$display("%h    %h    SRLV R%0d, R%0d, R%0d", pc , instruction, rs, rt, rd);
						address_s1 = rt;
						address_s2 = rs;
						address_d = rd;
						alu_opcode = 4'b0110;
						RegWrite = 1;
					end
					6'b000011:begin
						$display("%h    %h    SRA R%0d, R%0d, 0x%h", pc , instruction, rt, rd, sa);
						address_s1 = rt;
						immediate = sa;
						address_d = rd;
						alu_opcode = 4'b0111;
						RegWrite = 1;
						ALUSrc = 1;
					end
					6'b000111:begin
						$display("%h    %h    SRAV R%0d, R%0d, R%0d", pc , instruction, rd, rt, rs);
						address_s1 = rt;
						address_s2 = rs;
						address_d = rd;
						alu_opcode = 4'b0111;
						RegWrite = 1;
					end
					6'b100100:begin
						$display("%h    %h    AND R%0d, R%0d, R%0d", pc , instruction, rs, rt, rd);
						address_s1 = rs;
						address_s2 = rt;
						address_d = rd;
						alu_opcode = 4'b1000;
						RegWrite = 1;
					end
					6'b100101:begin
						case(rt)
							5'b00000:begin
								$display("%h    %h    MOVE R%0d, R%0d", pc , instruction, rd, rs);
								address_d = rd;
								address_s1 = rs;
								RegWrite = 1;
								alu_opcode = 5'b11010;
							end
							default:begin
								$display("%h    %h    OR R%0d, R%0d, R%0d", pc , instruction, rd, rs, rt);
								address_s1 = rs;
								address_s2 = rt;
								address_d = rd;
								alu_opcode = 4'b1001;
								RegWrite = 1;
							end	
						endcase
					end
					6'b100110:begin
						$display("%h    %h    XOR R%0d, R%0d, R%0d", pc , instruction, rd, rs, rt);
						address_s1 = rs;
						address_s2 = rt;
						address_d = rd;
						alu_opcode = 4'b1010;
						RegWrite = 1;
					end
					6'b100111:begin
						$display("%h    %h    NOR R%0d, R%0d, R%0d", pc , instruction, rd, rs, rt);
						address_s1 = rs;
						address_s2 = rt;
						address_d = rd;
						alu_opcode = 4'b1011;
						RegWrite = 1;
					end
					6'b001001:begin
						$display("%h    %h    JALR R%0d, R%0d", pc , instruction, rd, rs);
						address_d = rd;						
						address_s2 = rs;						
						alu_opcode = 5'b10000;
						Jump = 1;
						RegToImmediate = 1;
						RegWrite = 1;
						immediate = pc;
						ALUSrc = 1;						
					end
					6'b001000:begin
						$display("%h    %h    JR R%0d", pc , instruction, rs);										
						alu_opcode = 5'b10000;
						address_s2 = rs;
						Jump = 1;
						RegToImmediate = 1;
					end
				endcase	
			end
			6'b001001:begin
				$display("%h    %h    ADDIU R%0d, R%0d, 0x%h", pc , instruction, rt, rs, immed);
					address_s1 = rs;
					immediate = immed;
					address_d = rt;
					alu_opcode = 4'b0000;
					RegWrite = 1;
					ALUSrc = 1;
			end
			6'b001010:begin
				$display("%h    %h    SLTI R%0d, R%0d , 0x%h", pc , instruction, rt, rs, immed);
				address_s1 = rs;
				immediate = immed;
				address_d = rt;
				alu_opcode = 4'b0100;
				RegWrite = 1;
				ALUSrc = 1;
				
			end
			6'b001011:begin
				$display("%h    %h    SLTIU R%0d, R%0d, 0x%h", pc , instruction, rt, rs, immed);
				address_s1 = rs;
				immediate = immed;
				address_d = rt;
				alu_opcode = 4'b0100;
				RegWrite = 1;
				ALUSrc = 1;
			end
			6'b001101:begin
				$display("%h    %h    ORI R%0d, R%0d, 0x%h", pc , instruction, rt, rs, immed);
				address_s1 = rs;
				immediate = immed;
				address_d = rt;
				alu_opcode = 4'b1001;
				RegWrite = 1;
				ALUSrc = 1;
			end
			6'b001110:begin
				$display("%h    %h    XORI R%0d, R%0d, 0x%h", pc , instruction, rt, rs, immed);
				address_s1 = rs;
				immediate = immed;
				address_d = rt;
				alu_opcode = 4'b1010;
				RegWrite = 1;
				ALUSrc = 1;
			end
			6'b100011:begin
				$display("%h    %h    LW R%0d, %d(R%0d)", pc , instruction, rt, offset, base);
				MemEnable = 1;
				RegWrite = 1;
				MemtoReg = 1;
				ALUSrc = 1;
				address_s1 = base;
				address_d = rt;
				immediate = offset;
				alu_opcode = 5'b11011;
			end
			6'b101011:begin
				$display("%h    %h    SW R%0d, %d(R%0d)", pc , instruction, rt, offset, base);
				readwrite = 1;
				MemEnable = 1;
				ALUSrc = 1;
				$display("base: %h, address_s2: %h", base, rt);
				address_s1 = base;
				address_s2 = rt;
				immediate = offset;
				alu_opcode = 5'b11100;
			end
			6'b001111:begin
				$display("%h    %h    LUI R%0d, 0x%h", pc , instruction, rt, immed);				
				immediate = immed;
				address_d = rt;
				alu_opcode = 4'b1100;
				RegWrite = 1;
				ALUSrc = 1;
			end
			6'b100000:begin
				$display("%h    %h    LB R%0d, %d(R%0d)", pc , instruction, rt, offset, base);
				MemEnable = 1;
				RegWrite = 1;
				MemtoReg = 1;
				ALUSrc = 1;
				address_s1 = base;
				address_d = rt;
				immediate = offset;
				isByte = 1;
				alu_opcode = 5'b11011;

			end
			6'b101000:begin
				$display("%h    %h    SB R%0d, %d(R%0d)", pc , instruction, rt, offset, base);
				readwrite = 1;
				MemtoReg = 1;
				ALUSrc = 1;
				address_s1 = base;
				address_s2 = rt;
				immediate = offset;
				isByte = 1;
				alu_opcode = 5'b11100;
			end
			6'b100100:begin
				$display("%h    %h    LBU R%0d, %d(R%0d)", pc , instruction, rt, offset, base);
				MemEnable = 1;
				RegWrite = 1;
				MemtoReg = 1;
				ALUSrc = 1;
				address_s1 = base;
				address_d = rt;
				immediate = offset;
				isByte = 1;
				alu_opcode = 5'b11011;
				//TODO signed unsigned
			end
			6'b000010:begin
				$display("%h    %h    J 0x%h", pc , instruction, target);
				immediate = (target << 2)|(pc & 32'hF0000000);
				alu_opcode = 5'b10001;
				//address_d = rt;
				Jump =1;			
				
			end
			6'b000011:begin
				
				address_d = 32'd31;						
				//address_s2 = rs;						
				alu_opcode = 5'b10000;
				Jump = 1;
				//RegToImmediate = 1;
				RegWrite = 1;
				immediate = (target << 2)|(pc & 32'hF0000000);
				ALUSrc = 1;			
				linkSignal = 1;
				linkAddress = pc+8;	
				$display("%h    %h    JAL 0x%h, immediate = %h", pc , instruction, target, immediate);
				//TODO;
			end
			6'b000100:begin
				case(rt)
					6'b000000:begin
						$display("%h    %h    BEQZ R%0d, 0x%h", pc , instruction, rs, offset);
						address_s1 = rs;	
						alu_opcode = 4'b1101;
						immediate = offset;
					end
					default : begin 
						$display("%h    %h    BEQ R%0d, R%0d, 0x%h", pc , instruction, rs, rt, offset);
						address_s1 = rs;
						address_s2 = rt;
						immediate = offset;
						alu_opcode = 5'b10001;
					end
				endcase
			end
			6'b000101:begin
				case(rt)
					6'b000000:begin
						$display("%h    %h    BNEZ R%0d, 0x%h", pc , instruction, rs, offset);
						address_s1 = rs;
						alu_opcode = 5'b10010;
						immediate = offset;
					end
					default : begin
						$display("%h    %h    BNE R%0d, R%0d, 0x%h", pc , instruction, rs, rt, offset);
						address_s1 = rs;
						address_s2 = rt;
						immediate = offset;
						alu_opcode = 5'b10011;
					end
				endcase
			end
			6'b000001:begin
				case(rt)
					5'b00000:begin
						$display("%h    %h    BLTZ R%0d, 0x%h", pc , instruction, rs, offset);
						address_s1 = rs;
						alu_opcode = 5'b10100;
						immediate = offset;
					end
					5'b00001:begin
						$display("%h    %h    BGEZ R%0d, 0x%h", pc , instruction, rs, offset);
						address_s1 = rs;
						alu_opcode = 5'b10101;
						immediate = offset;
					end
				endcase
			end
			6'b000111:begin
				$display("%h    %h    BGTZ R%0d, 0x%h", pc , instruction, rs, offset);
				address_s1 = rs;
				alu_opcode = 5'b10110;
				immediate = offset;
			end
			6'b000110:begin
				$display("%h    %h    BLEZ R%0d, 0x%h", pc , instruction, rs, offset);
				address_s1 = rs;
				alu_opcode = 5'b10111;
				immediate = offset;
			end
			6'b000000:begin
				$display("%h    %h    NOP", pc , instruction);
			end
		endcase
	end
endmodule



