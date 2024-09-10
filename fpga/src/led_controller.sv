/*
	Marina Ring, mring@g.hmc.edu, 9/3/24
	Module to control 5 LEDs to display the sum of the two digits.
*/

module led_controller(
	input   logic reset,
    input   logic [7:0] s,
	output  logic [4:0] led
);

	assign led = s[3:0] + s[7:4];
	
endmodule
