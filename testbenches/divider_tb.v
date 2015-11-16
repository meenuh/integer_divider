`timescale 1ns/1ps

module divider_tb;
    /*
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
    */
    
    reg go, clk, rst;
    reg [3:0] n;
    wire error, done;
    reg [3:0] dividend, divisor;
    wire [3:0] remainder, quotient, cs, count;
    divider test(
                .go(go),
                .clk(clk),
                .rst(rst),
                .n(n),
                .error(error),
                .done(done),
                .dividend(dividend),
                .divisor(divisor),
                .remainder(remainder),
                .quotient(quotient),
                .cs(cs)
                );
                
    initial begin
        divisor = 3;
        dividend = 4;
        rst = 0;
        n = 4;
        go = 1;
        #100;
        while(!done)begin
        
        clk = 1; #5;
        clk = 0; #5;
        end
        $display("done");
        $finish;

    end//end initial 
endmodule
