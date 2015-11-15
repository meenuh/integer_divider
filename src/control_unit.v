`timescale 1ns/1ps

module control_unit (
                    input clk,
                    input rst,
                    input go,
                    input r_lt_y,
                    input count_equ_0,
                    
                    //for the updown counter
                    output reg ld,
                    output reg ud,
                    output reg ce,
                    //for the shifter x
                    output reg ldx,
                    output reg slx,
                    output reg srx,
                    output reg cex,  
                    //output reg rightin,
                    //nothing for y. y doesn't shift
                    //shifter for R (does right shift)
                    output reg ldr,
                    output reg slr,
                    output reg srr,
                    output reg cer,                  
                    
                    //for the muxes
                    output reg s1,
                    output reg s2,
                    output reg s3,
                    output reg done,
                    output wire [3:0] CS                   
                    );
                                   
    reg [3:0] cs, ns;     
    localparam s0 = 3'b000,
               st1 = 3'b001,
               st2 = 3'b010,
               st3 = 3'b011,
               s4 = 3'b100,
               s5 = 3'b101,
               s6 = 3'b110,
               s7 = 3'b111;
    assign CS = cs;
               
    initial begin
        cs = s0;
    end                 
    //input
    always @(go , r_lt_y, count_equ_0, cs) begin
        case(cs)
            0:
                if(go == 1) ns = st1;
                else ns = s0;
            1: ns = st2;
            2: ns = st3;
            3: 
                if(r_lt_y) ns = s5;
                else ns = s4;
            4:
                if(count_equ_0) ns = st3;
                else ns = s6; 
            5:
                if(count_equ_0) ns = st3;
                else ns = s6;
            6: ns = s7;
            7: ns = s0; 
            default: ns = s0;
        endcase       
    end
    
    //state reg
    always @(posedge clk) begin
        if(rst == 1) cs <= s0;
        else cs <= ns;
    end
    
    // begin ld = 0; ud = 0; ce = 0; ldx = 0; slx = 0; srx = 0; cex = 0; ldr = 0; slr = 0; srr = 0; cer = 0; s1 = 0; s2 = 0; s3 = 0; done = 0; end 
    //output logic 
    always @(r_lt_y, cs) begin
        case(cs)
            0: begin ld = 0; ud = 0; ce = 0; ldx = 0; slx = 0; srx = 0; cex = 0; ldr = 0; slr = 0; srr = 0; cer = 0; s1 = 0; s2 = 0; s3 = 0; done = 0; end 
            1: begin ld = 1; ud = 0; ce = 0; ldx = 1; slx = 0; srx = 0; cex = 0; ldr = 1; slr = 0; srr = 0; cer = 0; s1 = 0; s2 = 0; s3 = 0; done = 0; end
            2: begin ld = 0; ud = 0; ce = 0; ldx = 0; slx = 1; srx = 0; cex = 0; ldr = 0; slr = 1; srr = 0; cer = 0; s1 = 0; s2 = 0; s3 = 0; done = 0; end
            3: begin ld = 0; ud = 0; ce = 1; ldx = 0; slx = 1; srx = 0; cex = 0; ldr = 0; slr = 1; srr = 0; cer = 0; s1 = 0; s2 = 0; s3 = 0; done = 0; end
            4: begin ld = 0; ud = 0; ce = 1; ldx = 0; slx = 0; srx = 0; cex = 0; ldr = 0; slr = 0; srr = 0; cer = 0; s1 = 0; s2 = 0; s3 = 0; done = 0; end
            5: begin ld = 0; ud = 0; ce = 1; ldx = 0; slx = 1; srx = 0; cex = 0; ldr = 0; slr = 1; srr = 0; cer = 0; s1 = 1; s2 = 0; s3 = 0; done = 0; end
            6: begin ld = 0; ud = 0; ce = 0; ldx = 0; slx = 0; srx = 0; cex = 0; ldr = 0; slr = 0; srr = 1; cer = 0; s1 = 0; s2 = 0; s3 = 0; done = 0; end
            7: begin ld = 0; ud = 0; ce = 0; ldx = 0; slx = 0; srx = 0; cex = 0; ldr = 0; slr = 0; srr = 0; cer = 0; s1 = 0; s2 = 0; s3 = 0; done = 1; end
        endcase
    end              


endmodule