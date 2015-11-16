`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/09/2015 04:38:22 PM
// Design Name: 
// Module Name: cu_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module cu_tb;
    reg go, rst, clk, r_lt_y, count_equ_0;
    reg [3:0] count;
    reg [7:0] states; //keep track of which states we've gone through
    
    //ld = 0; ud = 0; ce = 0; ldx = 0; slx = 0; srx = 0; cex = 0; ldr = 0; slr = 0; srr = 0; cer = 0; s1 = 0; s2 = 0; s3 = 0; done = 0;
    wire ld, ud, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done, ld_y, right_in_x;
    wire [3:0] cs;
    
    control_unit m1(
                    .r_lt_y(r_lt_y),
                    .count(count),
                    .ld(ld),
                    .ud(ud),
                    .ce(ce),
                    .ldx(ldx),
                    .slx(slx),
                    .srx(srx),
                    .cex(cex),
                    .ldr(ldr),
                    .slr(slr),
                    .srr(srr),
                    .cer(cer),
                    .s1(s1),
                    .s2(s2),
                    .s3(s3),
                    .done(done),
                    .CS(cs),
                    .go(go),
                    .clk(clk),
                    .ld_y(ld_y),
                    .right_in_x(right_in_x)
                    );
    integer i, j;
                 
    initial begin
		go = 0; rst = 0; clk = 0; states = 0; #10;
    
		clk = 1; #5;
		clk = 0; #5;
                
		while(states != 8'b11111111) begin
			go = 1; #5;
			states[cs] = 1;
			clk = 1; #5;
			clk = 0; #5;  
			if(cs == 3)begin 
			for(i = 3; i >=0; i = i - 1 )begin
			     r_lt_y = 1; #5;
			     count = i; #5;
			     clk = 1; #5;
			     clk = 0; #5;
			
			end   end    
			/*case(cs)
				0:
					if({ld, ud, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done, ld_y, right_in_x} != 15'b0000000000000000)begin
						$display("State %d is incorrect. Should be: 010000000000000 but got %b", cs, {ld, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done});
						$stop;
					end
				1: 
					if({ld, ud, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done, ld_y, right_in_x} != 15'b10010001000000010) begin
						$display("State %d is incorrect. Should be: 110110000000000 but got %b", cs, {ld, ud, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done});
						$stop;
					end
				2: 
					if({ld, ud, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done, ld_y, right_in_x} != 15'b000010001000000) begin
						$display("State %d is incorrect. Should be: 101010000000000 but got %b", cs,{ld, ud, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done});
						$stop;
					end 
				3:
					if({ld, ud, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done, ld_y, right_in_x}!= 15'b001010001000000) begin
						$display("State %d is incorrect. Should be: 010000000000000 but got %b", cs, {ld, ud, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done});
						$stop;
					 end
				4:
					 if({ld, ud, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done, ld_y, right_in_x} != 15'b001000000000000) begin
						$display("State %d is incorrect. Should be: 001110111010000 but got %b", cs, {ld, ud, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done});
						$stop;
					 end
				5:
					 if({ld, ud, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done, ld_y, right_in_x} != 15'b001010001001000) begin
						$display("State %d is incorrect. Should be: 001110111010100 but got %b", cs, {ld, ud, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done});
						$stop;
					 end
				6:
					 if({ld, ud, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done, ld_y, right_in_x} != 15'b000000000100000) begin
						$display("State %d is incorrect. Should be: 001110111011000 but got %b", cs, {ld, ud, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done});
						$stop;
					 end                    
				7:
					 if({ld, ud, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done, ld_y, right_in_x} != 15'b000000000000001) begin
						$display("State %d is incorrect. Should be: 001110111011100 but got %b", cs, {ld, ud, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done});
						$stop;
					 end   
			endcase //end of case
			if(cs == 3) begin
                for(i = 0; i < 2; i = i + 1) begin
                    states[cs] = 1;
                    if(i == 1) r_lt_y = 1;
                    clk = 1; #5;
                    clk = 0; #5;
                    if(cs == 3)
						if({ld, ud, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done, ld_y, right_in_x}!= 15'b001010001000000) begin
							$display("State %d is incorrect. Should be: 010000000000000 but got %b", cs, {ld, ud, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done});
							$stop;
						 end
					else if(cs ==4)
						 if({ld, ud, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done, ld_y, right_in_x} != 15'b001000000000000) begin
							$display("State %d is incorrect. Should be: 001110111010000 but got %b", cs, {ld, ud, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done});
							$stop;
						 end
					else if(cs == 5) 
						 if({ld, ud, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done, ld_y, right_in_x} != 15'b001010001001000) begin
							$display("State %d is incorrect. Should be: 001110111010100 but got %b", cs, {ld, ud, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done});
							$stop;
						 end
                end // end for
            end // end if
            else if(cs == 4 || cs == 5) begin
                for(j = 4; j <= 0; j = j - 1)begin
                    if(j == 0) count_equ_0 = 1;
                    clk = 1; #5;
                    clk = 0; #5;
					if(cs == 3)
						if({ld, ud, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done, ld_y, right_in_x}!= 15'b001010001000000) begin
							$display("State %d is incorrect. Should be: 010000000000000 but got %b", cs, {ld, ud, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done});
							$stop;
						 end
                    else if(cs == 6)
						 if({ld, ud, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done, ld_y, right_in_x} != 15'b000000000100000) begin
							$display("State %d is incorrect. Should be: 001110111011000 but got %b", cs, {ld, ud, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done});
							$stop;
						 end                    
                    states[cs] = 1;
                end // end for
            end // end else if */
	   end //end of while
        
        $display("All tests passed");
        $finish;
    end //end of initial begin
endmodule
