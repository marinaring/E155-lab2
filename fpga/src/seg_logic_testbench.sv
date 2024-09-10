/*
	Marina Ring, mring@hmc.edu, 9/1/24
	Module to test the signals for the seven segment generator
	
*/

module seg_testbench();
	logic clk, reset;
	logic [3:0] s;
	logic [6:0] seg, seg_expected;
	logic [31:0] vectornum, errors;
	logic [11:0] testvectors[10000:0];
	
	seg_logic seg_test(s, seg);
	
	always 
		begin
			clk = 1; #5; clk = 0; #5;
		end
	
	initial 
		begin
			$readmemb("seg_test.txt", testvectors);
			vectornum = 0; errors = 0;
			reset = 1; #22; reset = 0;
		end
	
	always @(posedge clk)
		begin
			#1; {s, seg_expected} = testvectors[vectornum];
		end
		
	always @(negedge clk)
		if (~reset) begin // skip during reset
			if (seg != seg_expected) begin // check result
				$display("Error: input = %b", {s});
				$display(" outputs = %b (%b expected)", seg, seg_expected);
				errors = errors + 1;
			end
			vectornum = vectornum + 1;
			if (testvectors[vectornum] === 11'bx) begin
				$display("%d tests completed with %d errors", vectornum, errors);
				$stop;
			end
		end
endmodule
