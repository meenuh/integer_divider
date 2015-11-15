module dp_tb();
	reg[3:0] in1, in2;
	reg clk, rst, ld_r, ld_x, ld_y, sl, sr, right_in_x, sel1, sel2, ld_cnt, ud, ce, n;
	
	wire[3:0] remainder, quotient;
	wire r_lt_y, cnt_out, error;
	
	integer i;
	
	dp DUT(.in1(in1), .in2(in2), .clk(clk), .rst(rst), .ld_r(ld_r), .ld_x(ld_x), .ld_y(ld_y), .sl(sl), .sr(sr), .right_in_x(right_in_x), .sel1(sel1), .sel2(sel2), .ld_cnt(ld_cnt), .ud(ud), .ce(ce), .n(n), .r_lt_y(r_lt_y), .cnt_out(cnt_out), .quotient(quotient), .remainder(remainder), .error(error));
	
	initial
	begin
		clk = 0;	#10
		
		rst = 0;
		sel1 = 0;
		sel2 = 1;
		sl = 0;
		sr = 0;
		ld_r = 0;
		ld_x = 0;
		ld_y = 0;
		
		clk = 1;	#10
		clk = 0;	#10
		
		in1 = 4'b1101;
		in2 = 4'b0011;
		
		ld_r = 1;
		ld_x = 1;
		ld_y = 1;
		
		clk = 1;	#10
		clk = 0;	#10
				
		//shift r and x
		ld_r = 0;
		ld_x = 0;
		sl = 1;
		right_in_x = 1'b0;
		
		clk = 1;	#10
		clk = 0;	#10
		//endshift

		sl = 0;		
		
		clk = 1;	#10
		clk = 0;	#10

		for(i = 3; i >= 0; i = i - 1) begin
			if(r_lt_y) begin
				right_in_x = 1'b0;	
			end
			else begin
				sel1 = 1;	//changes r to r - y
				ld_r = 1;
				right_in_x = 1'b1;
				
				clk = 1;	#10
				clk = 0;	#10
				
				sel1 = 0;
				ld_r = 0;
			end

			//shift
			sl = 1;

			clk = 1;	#10
			clk = 0;	#10
			
			sl = 0;			
		end
		
		ld_r = 0;
		sr = 1;
		
		clk = 1;	#10
		clk = 0;	#10
		
		ld_r = 1;
		sr = 0;

		$display("Quotient: %d, Remainder: %d", quotient, remainder);
		
	end
endmodule