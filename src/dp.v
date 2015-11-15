module dp(in1, in2, clk, rst, ld_r, ld_x, ld_y, sl, sr, right_in_x, sel1, sel2, ld_cnt, ud, ce, n, r_lt_y, cnt_out, quotient, remainder, error);
	input[3:0] in1, in2;
	input clk, rst, ld_r, ld_x, ld_y, sl, sr, right_in_x, sel1, sel2, ld_cnt, ud, ce, n;
	
	output[3:0] remainder, quotient;
	output r_lt_y, cnt_out;
	output reg error;
	
	wire[4:0] r_out;
	wire[3:0] x_out, y_out, sub_out, u0_out;
	
	always @ (in2) begin
		if(in2 == 0)
			error = 1;
		else
			error = 0;
	end
	
	mux2 U0(.in1(sub_out), .in2(4'b0000), .sel(sel1), .m2out(u0_out));
	shift_reg5 U1(.clk(clk), .rst(rst), .sl(sl), .sr(sr), .ld(ld_r), .left_in(1'b0), .right_in(x_out[3]), .d(u0_out), .q(r_out));
	shift_reg4 U2(.clk(clk), .rst(rst), .sl(sl), .sr(1'b0), .ld(ld_x), .left_in(1'b0), .right_in(right_in_x), .d(in1), .q(x_out));
	shift_reg4 U3(.clk(clk), .rst(rst), .sl(sl), .sr(1'b0), .ld(ld_y), .left_in(1'b0), .right_in(1'b0), .d(in2), .q(y_out));
	comparator U4(.in1(r_out[3:0]), .in2(y_out), .lt_out(r_lt_y));
	subtract U5(.in1(r_out[3:0]), .in2(y_out), .sub_out(sub_out));
	mux2 U6(.in1(r_out[3:0]), .in2(4'b0000), .sel(sel2), .m2out(remainder));	
	mux2 U7(.in1(x_out), .in2(4'b0000), .sel(sel2), .m2out(quotient));
	ud_counter U8(.clk(clk), .rst(rst), .ud(ud), .ce(ce), .ld(ld_cnt), .d(n), .q(cnt_out));	//set cnt_out = n after
endmodule