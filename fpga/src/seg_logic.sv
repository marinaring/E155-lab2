/*
	Marina Ring, mring@hmc.edu, 9/1/2024
	Module that houses just the combinational logic to control a seven-segment display. 
	Decodes a four bit input into the corresponding hexidecimal digit.
*/
module seg_logic(
	input logic [3:0] s,
	output logic [6:0] seg
);
	
	always_comb 
		case(s)
			// 			 abc_defg
			0: seg =  7'b111_1110;
			1: seg =  7'b011_0000;
			2: seg =  7'b110_1101; 
			3: seg =  7'b111_1001; 
			4: seg =  7'b011_0011;
			5: seg =  7'b101_1011;
			6: seg =  7'b101_1111;
			7: seg =  7'b111_0000;
			8: seg =  7'b111_1111;
			9: seg =  7'b111_0011;
			10: seg = 7'b111_0111;
			11: seg = 7'b001_1111;
			12: seg = 7'b100_1110;
			13: seg = 7'b011_1101;
			14: seg = 7'b100_1111;
			15: seg = 7'b100_0111;
			default: seg = 7'b000_0000;
		endcase
endmodule