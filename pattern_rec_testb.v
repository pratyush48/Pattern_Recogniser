module LFSR(out,clk,rst);
output  reg[4:0] out;
input clk,rst;
wire feedback;
assign feedback = ~(out[2]^out[4]);
always@(posedge  clk,posedge rst)
	begin
		if(rst)
			out = 5'b0;
		else
			out = {out[3:0],feedback};
	end
endmodule
module test_zero_one;
reg clk,rst,A;
wire Y;
wire random;
wire [4:0] out;
integer i;
zero_one_detector dut(clk,rst,A,Y);
LFSR shifter(out,clk,rst);
assign random = shifter.out[0];
initial
begin
		rst = 1;
	#5 rst = 0;
end
initial
begin
	$dumpfile("dump.vcd");//for creating waveform.
	$dumpvars(0,dut);
	for(i = 0;i <= 15;i = i+1)
	begin
		A = random;
		#2 clk = 1;
		#2 clk = 0;
		$display("Current State = ",dut.state," Input = ",A," Output = ",Y);
	end
	$finish;
end
endmodule
