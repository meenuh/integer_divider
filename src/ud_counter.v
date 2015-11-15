module ud_counter(clk, rst, ud, ce, ld, d, q);
	input[3:0] d; //d is current
	input clk, rst, ud, ce, ld;
	output reg[3:0] q;
	
	always@ (posedge clk, negedge rst) begin
		if(!rst)
			q = 4'b0;
		else if(ce) begin
			if(ld)
				q = d;
			else if(ud)
				q = q + 4'b0001;
			else
				q = q - 4'b0001;
		end
		else
			q = q;
	end
endmodule