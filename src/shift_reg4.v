module shift_reg4(clk, rst, sl, sr, ld, left_in, right_in, d, q);
	parameter width = 4;
	
	input clk, rst, sl, sr, ld, left_in, right_in;
	input[width-1:0] d;
	output reg[width-1:0] q;
	
	always@ (posedge clk) begin
		if(rst) //active high
			q = 0;
		else if(ld) begin //active low?
			q = d;
			//$display("q: %d, d: %d", q, d);
		end
		else if(sl) begin
			q[width-1:1] = q[width-2:0];
			q[0] = right_in;
			$display("shift left");
		end
		else if(sr) begin
			q[width-2:0] = q[width-1:1];
			q[width-1] = left_in;
		end
		else
			q = q;
	end
endmodule