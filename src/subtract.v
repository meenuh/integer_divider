module subtract(in1, in2, sub_out);
	input[3:0] in1, in2;
	output[3:0] sub_out;
	
	assign sub_out = in1 - in2;
endmodule