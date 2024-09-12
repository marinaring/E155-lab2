/*
	Marina Ring, mring@hmc.edu, 9/3/2024
	Module to control two seven segment displays and LEDs using an FPGA. Uses time multiplexing. 
*/

module lab2_mr(
	input   logic reset,
    input   logic [7:0] s,
	output  logic [1:0] transistor,
	output  logic [4:0] led,
	output  logic [6:0] seg
);
	
	logic multi_switch; 
	logic [6:0] not_seg;
	logic [3:0] s_seg;
	
	// dig_oscillator clk_generator(reset, m_clk);
	
	logic int_osc;

	// Initialize high-speed oscillator to 24 MHz signal
	HSOSC #(.CLKHF_DIV(2'b01)) 
         hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));
	

	// output logic
	seg_multiplexer seg_display(int_osc, reset, s, multi_switch, s_seg);
	led_controller led_display(reset, s, led);
	seg_logic digit1(s_seg, not_seg);
		

	// turning a pin on corresponds to turning a segment off, so we need to switch all bits.
	// digit powers on when transistor pin is low 
	assign seg = ~not_seg;
	assign transistor[0] = multi_switch;
	assign transistor[1] = ~multi_switch;
  
endmodule