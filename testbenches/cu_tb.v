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
    wire ld, ud, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done;
    wire [3:0] cs;
    
    control_unit m1(
                    .r_lt_y(r_lt_y),
                    .count_equ_0(count_equ_0),
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
                    .go(go)
                    );
    integer i, j;
                 
    initial begin
    go = 0; rst = 0; clk = 0; states = 0; #10;
    
     clk = 1; #5;
     clk = 0; #5;
        for(i = 4 ; i >= 0; i = i - 1) begin
            for(j = 0; j < 1; j = j + 1)begin
                r_lt_y = j; #5;
                //count_equ_0 = i; #5;
                count = i; #5;
                go = 1; #5;
                rst = 0; #5;
                
                if(count == 0) count_equ_0 = 1; #5;
                
                while(states != 8'b11111111) begin
                    $display("in here: %d", cs); 
                    states[cs] = 1;
                    clk = 1; #5;
                    clk = 0; #5;         
                    case(cs)
                        0:
                            if({ld, ud, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done} != 15'b00000000000000)begin
                                $display("State %d is incorrect. Should be: 010000000000000 but got %b", cs, {ld, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done});
                                $stop;
                            end
                        1: 
                            if({ld, ud, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done} != 15'b100100010000000) begin
                                $display("State %d is incorrect. Should be: 110110000000000 but got %b", cs, {ld, ud, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done});
                                $stop;
                            end
                        2: 
                            if({ld, ud, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done} != 15'b000010001000000) begin
                                $display("State %d is incorrect. Should be: 101010000000000 but got %b", cs,{ld, ud, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done});
                                $stop;
                            end 
                        3:
                            if({ld, ud, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done}!= 15'b001010001000000) begin
                                $display("State %d is incorrect. Should be: 010000000000000 but got %b", cs, {ld, ud, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done});
                                $stop;
                             end
                        4:
                             if({ld, ud, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done} != 15'b001000000000000) begin
                                $display("State %d is incorrect. Should be: 001110111010000 but got %b", cs, {ld, ud, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done});
                                $stop;
                             end
                        5:
                             if({ld, ud, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done} != 15'b001010001001000) begin
                                $display("State %d is incorrect. Should be: 001110111010100 but got %b", cs, {ld, ud, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done});
                                $stop;
                             end
                        6:
                             if({ld, ud, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done} != 15'b000000000100000) begin
                                $display("State %d is incorrect. Should be: 001110111011000 but got %b", cs, {ld, ud, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done});
                                $stop;
                             end                    
                        7:
                             if({ld, ud, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done} != 15'b000000000000001) begin
                                $display("State %d is incorrect. Should be: 001110111011100 but got %b", cs, {ld, ud, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done});
                                $stop;
                             end   
                                               
                    endcase //end of case
               end //end of while
            end //end of inner for
        end //end of outer for
        $display("All tests passed");
        $finish;
    end //end of initial begin
endmodule
