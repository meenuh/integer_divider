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
    
    //ld = 0; ud = 0; ce = 0; ldx = 0; slx = 0; srx = 0; cex = 0; ldr = 0; slr = 0; srr = 0; cer = 0; s1 = 0; s2 = 0; s3 = 0; done = 0;
    wire ld, ud, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done;
    wire [2:0] cs;
    
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
                    .CS(cs)
                    );
    integer i, j;
                 
    initial begin
    go = 0; rst = 0; clk = 0; #10;
    
    if({ld, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done} != 14'b000000000000000)begin
               $display("State %d is incorrect. Should be: 010000000000000 but got %b", cs, {ld, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done});
               $stop;
    end
    clk = 1; #5;
    clk = 0; #5;
            
    go = 1; #5;
    //$display("cs: %d states: %b", cs, {s1, WA, WE, RAA, REA, RAB, REB, C, s2, done});
    if({ld, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done} != 14'b00000000000000)begin
       $display("State %d is incorrect. Should be: 010000000000000 but got %b", cs, {ld, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done});
     $stop;
     end
     clk = 1; #5;
     clk = 0; #5;
    
    for(i = 0 ; i < 4; i = i + 1) begin
        for(j = 0; j < 1; j = j + 1)begin
        r_lt_y = j; #5;
        count_equ_0 = i; #5;
        go = 1; #5;
        while(!cs) begin
        /*
        1: begin ld = 1; ud = 0; ce = 0; ldx = 1; slx = 0; srx = 0; cex = 0; ldr = 1; slr = 0; srr = 0; cer = 0; s1 = 0; s2 = 0; s3 = 0; done = 0; end
                    {1,0,0,1,0,0,0,1,0}
                    2: begin ld = 0; ud = 0; ce = 0; ldx = 0; slx = 1; srx = 0; cex = 0; ldr = 0; slr = 1; srr = 0; cer = 0; s1 = 0; s2 = 0; s3 = 0; done = 0; end
                    3: begin ld = 0; ud = 0; ce = 1; ldx = 0; slx = 1; srx = 0; cex = 0; ldr = 0; slr = 1; srr = 0; cer = 0; s1 = 0; s2 = 0; s3 = 0; done = 0; end
                    4: begin ld = 0; ud = 0; ce = 1; ldx = 0; slx = 0; srx = 0; cex = 0; ldr = 0; slr = 0; srr = 0; cer = 0; s1 = 0; s2 = 0; s3 = 0; done = 0; end
                    5: begin ld = 0; ud = 0; ce = 1; ldx = 0; slx = 1; srx = 0; cex = 0; ldr = 0; slr = 1; srr = 0; cer = 0; s1 = 1; s2 = 0; s3 = 0; done = 0; end
                    6: begin ld = 0; ud = 0; ce = 0; ldx = 0; slx = 0; srx = 0; cex = 0; ldr = 0; slr = 0; srr = 1; cer = 0; s1 = 0; s2 = 0; s3 = 0; done = 0; end
                    7: begin ld = 0; ud = 0; ce = 0; ldx = 0; slx = 0; srx = 0; cex = 0; ldr = 0; slr = 0; srr = 0; cer = 0; s1 = 0; s2 = 0; s3 = 0; done = 1; end
        */
            case(cs)
                1: 
                                    if({ld, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done} != 14'b10010001000000) begin
                                        $display("State %d is incorrect. Should be: 110110000000000 but got %b", cs, {s1, WA, WE, RAA, REA, RAB, REB, C, s2, done});
                                        $stop;
                                    end
                                2: 
                                    if({ld, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done} != 14'bl000010001000000) begin
                                        $display("State %d is incorrect. Should be: 101010000000000 but got %b", cs, {s1, WA, WE, RAA, REA, RAB, REB, C, s2, done});
                                        $stop;
                                    end 
                                3:
                                    if({{ld, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done}!= 14'bl001010001000000) begin
                                        $display("State %d is incorrect. Should be: 010000000000000 but got %b", cs, {s1, WA, WE, RAA, REA, RAB, REB, C, s2, done});
                                        $stop;
                                    end
                                4:
                                    if({ld, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done} != 14'bl001000000000000) begin
                                         $display("State %d is incorrect. Should be: 001110111010000 but got %b", cs, {s1, WA, WE, RAA, REA, RAB, REB, C, s2, done});
                                         $stop;
                                    end
                                5:
                                    if({ld, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done} != 14'bl001010001001000) begin
                                        $display("State %d is incorrect. Should be: 001110111010100 but got %b", cs, {s1, WA, WE, RAA, REA, RAB, REB, C, s2, done});
                                        $stop;
                                    end
                                6:
                                    if({ld, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done} != 14'b000000000100000) begin
                                        $display("State %d is incorrect. Should be: 001110111011000 but got %b", cs, {s1, WA, WE, RAA, REA, RAB, REB, C, s2, done});
                                        $stop;
                                    end                    
                                7:
                                    if({ld, ce, ldx, slx, srx, cex, ldr, slr, srr, cer, s1, s2, s3, done} != 15'b001110111011100) begin
                                        $display("State %d is incorrect. Should be: 001110111011100 but got %b", cs, {s1, WA, WE, RAA, REA, RAB, REB, C, s2, done});
                                        $stop;
                                    end              
            endcase
        end
    end
    end
endmodule
