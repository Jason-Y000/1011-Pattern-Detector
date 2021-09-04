`timescale 1ns/1ns
module tb();
	logic clk; // Generate the clock
	initial clk = 1'b0;
	always #5 clk = ~clk;

	logic d_in; //instantiate the input
	logic d_out;
	logic reset;
	logic [4:0]count;
	logic [22:0]test;
	
	pattern_1011 DUT
	(
		.clk(clk),
		.reset(reset),
		.DIN(d_in),
		.DOUT(d_out)
	);
	
	initial begin
		test = 23'b10110011101100011011011;
		//test = 4'b1011;
		count = 4'b0;
		reset = 1'b0;
		for (integer x = 0; x < 23; x++) begin
			d_in = test[x];
			
			#10ns // Wait 10ns after the input is assigned
			
			if (d_out) begin
				$display("Sequence detected");
				count = count + 1'b1;
			end
		end
	
		$display("Found sequence %d times",count);
        if (runs == 4'd5)
            $stop();
	end
	
endmodule
