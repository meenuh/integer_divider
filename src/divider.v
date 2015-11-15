`timescale 1ns/1ps

module divider(
                input wire go,
                input wire clk,
                input wire rst,
                input wire [3:0] dividend,
                input wire [3:0] divisor,
                input wire n,
                
                output wire [3:0] remainder,
                output wire [3:0] quotient,
                output wire error,
                output wire done,
                output wire [3:0] cs
                );
                
    wire [18:0] bus; //for signals between dp and cu
    //in the order as they appear in control_unit m1
    
    control_unit m1(
                    .r_lt_y(bus[0]),
                    .count_equ_0(bus[1]),
                    .ld(bus[2]),
                    .ud(bus[3]),
                    .ce(bus[4]),
                    .ldx(bus[5]),
                    .slx(bus[6]),
                    .srx(bus[7]),
                    .cex(bus[8]),
                    .ldr(bus[9]),
                    .slr(bus[10]),
                    .srr(bus[11]),
                    .cer(bus[12]),
                    .s1(bus[13]),
                    .s2(bus[14]),
                    .s3(bus[15]),
                    .done(done),
                    .CS(cs),
                    .go(go),
                    .clk(clk)
                  );
    //module dp(in1, in2, clk, rst, ld_r, ld_x, ld_y, sl, sr, right_in_x, sel1, sel2, ld_cnt, ud, ce, n, r_lt_y, cnt_out, quotient, remainder, error);
    dp m2 (
            .in1(dividend), 
            .in2(divisor), 
            .clk(clk), 
            .rst(rst), 
            .ld_r(bus[9]), 
            .ld_x(bus[5]), 
            .ld_y(bus[16]), 
            .sl(), 
            .sr(), 
            .right_in_x(), 
            .sel1(bus[13]), 
            .sel2(bus[14]), 
            .ld_cnt(bus[2]), 
            .ud(bus[3]), 
            .ce(bus[4]), 
            .n(n), 
            .r_lt_y(bus[0]), 
            .cnt_out(bus[1]), 
            .quotient(quotient), 
            .remainder(remainder), 
            .error(error)
            );
endmodule