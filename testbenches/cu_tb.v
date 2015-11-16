`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/09/2017 04:38:22 PM
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
    reg go, rst, clk, r_lt_y;
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
		go = 0; rst = 0; clk = 0; states = 0; count = 4'b0100; #10;
        clk = 1; #5;
		clk = 0; #5;     
		r_lt_y = 0; #5;		
		while(states != 8'b11111111) begin
			go = 1; #5;
			states[cs] = 1;  
			case(cs)
				0:
					if({ld, ud, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done, ld_y, right_in_x} != 17'b00000000000000000)begin
						$display("State %d is incorrect. Should be: 010000000000000 but got %b", cs, {ld, ud, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done, ld_y, right_in_x});
						$stop;
					end
				1: 
					if({ld, ud, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done, ld_y, right_in_x} != 17'b10110001000000010) begin
						$display("State %d is incorrect. Should be: 110110000000000 but got %b", cs, {ld, ud, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done, ld_y, right_in_x});
						$stop;
					end
				2: 
					if({ld, ud, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done, ld_y, right_in_x} != 17'b00101000100000010) begin
						$display("State %d is incorrect. Should be: 101010000000000 but got %b", cs,{ld, ud, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done, ld_y, right_in_x});
						$stop;
					end 
				3: begin
						if(r_lt_y == 1)begin
							if({ld, ud, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done, ld_y, right_in_x} != 17'b00000000000000010) begin
									$display("State %d is incorrect. Should be: 001110111011100 but got %b", cs, {ld, ud, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done, ld_y, right_in_x});
									$stop;
							end 
						end else begin
							if({ld, ud, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done, ld_y, right_in_x} != 17'bb00000001000100011) begin
								$display("State %d is incorrect. Should be: 001110111011100 but got %b", cs, {ld, ud, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done, ld_y, right_in_x});
								$stop;
							end
						end
						if(count == 1) begin 
							r_lt_y = 1;
						end else begin 
							r_lt_y = 0;
						end
						if(count != 0) count = count - 4'b0001;
                         else count = 0; #5;
					end
				4:	begin
						 if({ld, ud, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done, ld_y, right_in_x} != 17'b00101000100000011) begin
								$display("State %d is incorrect. Should be: 001110111011100 but got %b", cs, {ld, ud, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done, ld_y, right_in_x});
								$stop;
						end 
					end //end case 4
				5:
					 if({ld, ud, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done, ld_y, right_in_x} != 17'b00101000100100010) begin
								$display("State %d is incorrect. Should be: 001110111011100 but got %b", cs, {ld, ud, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done, ld_y, right_in_x});
								$stop;
					end 
				6:
					 if({ld, ud, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done, ld_y, right_in_x} != 17'b00000000010000010) begin
						$display("State %d is incorrect. Should be: 001110111011000 but got %b", cs, {ld, ud, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done, ld_y, right_in_x});
						$stop;
					 end                    
				7:
					 if({ld, ud, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done, ld_y, right_in_x} != 17'b00000000000011110) begin
						$display("State %d is incorrect. Should be: 001110111011100 but got %b", cs, {ld, ud, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done, ld_y, right_in_x});
						$stop;
					 end   
			endcase //end of case
			clk = 1; #5;
			clk = 0; #5; 
	   end //end of while
        
        $display("All tests passed");
        $finish;
    end //end of initial begin
endmodule
