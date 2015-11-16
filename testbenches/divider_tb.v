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
    integer i, j, expected, exp_remain;
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
        divisor = 0;
        dividend = 0;
        rst = 0;
        n = 4;
        go = 1;
        #100;
        
        for(i = 1; i < 4'b1111; i = i+1) begin
            for(j = 0; j < 4'b1111; j = j + 1) begin
                n = 4; #5;    
                divisor = i;
                dividend = j; #10;
                expected = j / i; #5;
                exp_remain = j % i; #5;
                while(!done)begin
                    clk = 1; #5;
                    clk = 0; #5;
                end

                if(expected != quotient)begin
                    $display("Incorrect quotient. Expected %d but got %d", expected, quotient);
                    $stop;
                end
                
                if(exp_remain != remainder) begin
                    $display("incorrect remainder");
                    $stop;
                end
                
                clk = 1; #5;
                clk = 0; #5;
            end //inner for
        end //outer for
        $display("done");
        $finish;

    end//end initial 
endmodule
