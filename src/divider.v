`timescale 1ns/1ps

module divider(
                input wire go,
                input wire clk,
                input wire rst,
                input wire [3:0] dividend,
                input wire [3:0] divisor,
                input wire [3:0] n,
                
                output wire [3:0] remainder,
                output wire [3:0] quotient,
                output wire error,
                output wire done,
                output wire [3:0] cs
                );
       
    wire [3:0] count;
    wire ld_count, ud_count, ce_count; //for up down counter
    wire ld_x,sl_x, sr_x, ce_x, right_in_x; //for x shifter
    wire ld_r, sl_r, sr_r, ce_r; //for r shifter
    wire ld_y;                  //y does not shift. nothing needed
    wire sel1, sel2, sel3;      //for the 3 muxes. only 2 are used but 3 for clarity
    wire r_lt_y, error;

    control_unit m1(
                    .r_lt_y(r_lt_y),
                    .count(count),
                    .ld(ld_count),
                    .ud(ud_count),
                    .ce(ce_count),
                    .ldx(ld_x),
                    .slx(sl_x),
                    .srx(sr_x),
                    .cex(ce_x),
                    .ldr(ld_r),
                    .slr(sl_r),
                    .srr(sr_r),
                    .cer(ce_r),
                    .s1(sel1),
                    .s2(sel2),
                    .s3(sel3), //not needed
                    .done(done),
                    .CS(cs),
                    .go(go),
                    .clk(clk),
                    .error(error),
                    .right_in_x(right_in_x),
                    .ld_y(ld_y)
                  );
    //module dp(in1, in2, clk, rst, ld_r, ld_x, ld_y, sl, sr, right_in_x, sel1, sel2, ld_cnt, ud, ce, n, r_lt_y, cnt_out, quotient, remainder, error);
    dp m2 (
            .in1(dividend), 
            .in2(divisor), 
            .clk(clk), 
            .rst(rst), 
            .ld_r(ld_r), 
            .ld_x(ld_x), 
            .ld_y(ld_y), 
            .sl_r(sl_r),
            .sl_x(sl_x), 
            .sr(sr_r), 
            .right_in_x(right_in_x), 
            .sel1(sel1), 
            .sel2(sel2), 
            .ld_cnt(ld_count), 
            .ud(ud_count), 
            .ce(ce_count), 
            .n(n), 
            .r_lt_y(r_lt_y), 
            .cnt_out(count), 
            .quotient(quotient), 
            .remainder(remainder), 
            .error(error)
            );
endmodule