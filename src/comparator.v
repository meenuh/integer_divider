//if in1 is less than in in2, then true
module comparator (in1, in2, lt_out);
	input[3:0] in1, in2;
	output reg lt_out;
	
	always@(in1 or in2) begin
		if(in1 < in2)
			lt_out = 1;
		else
			lt_out = 0;
	end

endmodule