module pattern_1011
(
	input clk, //clock
	input reset, //reset pin
	input DIN, //Data in
	output logic DOUT //output

);

enum int unsigned //Initialize the states of the FSM
{
	S0,
	S1,
	S2,
	S3,
	S4
} state, nextstate;

always_ff @(posedge clk or posedge reset) begin
	if (reset) state <= S0;
	else state <= nextstate;
end

always_comb begin
	nextstate = state;
	DOUT = 1'b0;
	
	case (state)
		S0: begin //Sequence start
			$display("S0");
			if (reset) 
				nextstate = S0;
			else if (DIN) begin
				nextstate = S1;
				DOUT = 1'b0;
			end
			else begin
				nextstate = S0;
				DOUT = 1'b0;
			end
		end
		S1: begin //Sequence built: 1
			$display("S1");
			if (reset) 
				nextstate = S0;
			else if (DIN == 1'b1) begin
				nextstate = S1;
				DOUT = 1'b0;
			end
			else begin
				nextstate = S2;
				DOUT = 1'b0;
			end
		end
		S2: begin //Sequence built: 10
			$display("S2");
			if (reset) 
				nextstate = S0;
			else if (DIN) begin
				nextstate = S3;
				DOUT = 1'b0;
			end
			else begin
				nextstate = S0;
				DOUT = 1'b0;
			end
		end
		S3: begin //Sequence built: 101
			$display("S3");
			if (reset) 
				nextstate = S0;
			else if (DIN) begin
				nextstate = S4;
				DOUT = 1'b0;
			end
			else begin
				nextstate = S2;
				DOUT = 1'b0;
			end
		end
		S4: begin //Sequence built: 1011
			$display("S4");
			if (reset)
				nextstate = S0;
			else if (DIN) begin
				nextstate = S1;
				DOUT = 1'b1;
			end
			else begin
				nextstate = S2;
				DOUT = 1'b1;
			end
		end
	endcase
end

endmodule 

