/*
	Marina Ring, mring@g.hmc.edu, 9/3/2024
	A testbench for the led_controller module. Test specifically when the counter is 2 bits, so the multiplexer
	switches between displayes every 4 clock cycles. 
*/

module seg_multiplexer_testbench();
	logic clk, reset;
	logic [7:0] s;
	logic [6:0] seg, seg_expected;
	logic multi_switch, multi_switch_expected;
	logic [31:0] vectornum, errors;
	logic [15:0] testvectors[10000:0];
	
	seg_multiplexer seg_test(clk, reset, s, multi_switch, seg);

	always 
		begin
			clk = 1; #5; clk = 0; #5;
		end
	 
	
	initial 
		begin
			$readmemb("seg_multiplexer_neg_test.txt", testvectors);
			vectornum = 0; errors = 0;
			reset = 0; #22; reset = 1;
		end
	
	always @(posedge clk)
		begin
			#1; {s, multi_switch_expected, seg_expected} = testvectors[vectornum];
		end
		
	always @(negedge clk)
		if (reset) begin // skip during reset
			if (seg != seg_expected || multi_switch != multi_switch_expected) begin // check result
				$display("Error: input = %b", {s});
				$display(" outputs = %b (%b expected)", seg, seg_expected);
				$display(" outputs = %b (%b expected)", multi_switch, multi_switch_expected);
				errors = errors + 1;
			end
			vectornum = vectornum + 1;
			if (testvectors[vectornum] === 16'bx) begin
				$display("%d tests completed with %d errors", vectornum, errors);
				$stop;
			end
		end
endmodule