module mux2 (in1, in2, sel, m2out);
	input[3:0] in1, in2;
	input sel;
	output reg[3:0] m2out;
	
	always @ (in1, in2, sel)
	begin
		if (sel)
			m2out = in1;
		else
			m2out = in2;
	end
endmodule //MUX2