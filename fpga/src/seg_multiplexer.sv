/*
	Marina Ring, mring@hmc.edu, 9/3/2024
	Module that controls the multiplexing for the seven segment display. Calls the seven segment decoder
	in order to turn the first four or the last four bits of the DIP Switch input into a digit
*/


module seg_multiplexer(
	input 	logic clk,
	input   logic reset,
    input   logic [7:0] s,
	output  logic multi_switch,
	output  logic [3:0] sout

);
	logic [6:0] seg1, seg2;
	logic state, nextstate;
	logic [15:0] counter;
	
	// register 
	always_ff @(posedge clk) begin
		if (reset == 0) begin
			state <= 0;
			counter <= 0;
		end
		else begin
			state <= nextstate;
			counter <= counter + 1;
		end
	end
			
	// next state logic
	always_comb begin
		case (state)
			0: nextstate <= (counter == '1) ? 1 : 0;
			1: nextstate <= (counter == '1) ? 0 : 1;
			default : nextstate <= 1'bx;
		endcase
	end
	
	// output logic
	// state 0 => first digit
	// state 1 => second digit
	assign multi_switch = state;
	assign sout = (state ? s[3:0] : s[7:4]);
	
endmodule