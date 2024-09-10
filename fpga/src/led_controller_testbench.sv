/*
	Marina Ring, mring@g.hmc.edu, 9/3/2024
	A testbench for the led_controller module. 
*/

module led_controller_testbench();
	logic clk, reset;
	logic [7:0] s;
	logic [4:0] led, led_expected;
	logic [31:0] vectornum, errors;
	logic [12:0] testvectors[10000:0];
	
	led_controller led_test(reset, s, led);

	always 
		begin
			clk = 1; #5; clk = 0; #5;
		end
	 
	
	initial 
		begin
			$readmemb("led_controller_test.txt", testvectors);
			vectornum = 0; errors = 0;
			reset = 0; #22; reset = 1;
		end
	
	always @(posedge clk)
		begin
			#1; {s, led_expected} = testvectors[vectornum];
		end
		
	always @(negedge clk)
		if (reset) begin // skip during reset
			if (led != led_expected) begin // check result
				$display("Error: input = %b", {s});
				$display(" outputs = %b (%b expected)", led, led_expected);
				errors = errors + 1;
			end
			vectornum = vectornum + 1;
			if (testvectors[vectornum] === 13'bx) begin
				$display("%d tests completed with %d errors", vectornum, errors);
				$stop;
			end
		end
endmodule
