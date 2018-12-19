module zero_one_detector(input clk,
						 input rst,
						 input A,
						 output Y);
	reg [1:0] state,nextstate;//Typedef gives syntax error so I used this method.
	parameter s0 = 2'b00;
	parameter s1 = 2'b01;
	parameter s2 = 2'b10;
	always@(posedge clk,posedge rst)
		if(rst) state <= s0;
		else state <= nextstate;
	always@(*)
		case(state)
			s0:if(A) nextstate = s0;
			   else	 nextstate = s1;
			s1:if(A) nextstate = s2;
				 else  nextstate = s1;
			s2:if(A) nextstate = s0;
				 else  nextstate = s1;
			default  nextstate = s0;
		endcase
	assign Y = (state==s2);//When state is s2 then it gives output as 1 else 0;
endmodule
