`timescale 1ns/1ps

module control_unit (
                    input wire clk,
                    input wire rst,
                    input wire go,
                    input wire r_lt_y,
                    input wire [3:0] count, //to check if count is 0
                    input wire error,
                    
                    //for the updown counter
                    output reg ld,
                    output reg ud,
                    output reg ce,
                    //for the shifter x
                    output reg ldx,
                    output reg slx,
                    output reg srx, //x only shifts left. not needed
                    output reg cex,  
                    output reg right_in_x,
					output reg ld_y,
                    //output reg rightin,
                    //nothing for y. y doesn't shift
                    /*
                    output reg sly,
                    output reg sry,
                    output reg cey,
                    */
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
    localparam s0 = 4'b0000,
               st1 = 4'b0001,
               st2 = 4'b0010,
               st3 = 4'b0011,
               s4 = 4'b0100,
               s5 = 4'b0101,
               s6 = 4'b0110,
               s7 = 4'b0111;
    assign CS = cs;
               
    initial begin
        cs = s0;
    end                 
    //input
    always @(go , r_lt_y, count, cs, error) begin
        case(cs)
            0:begin
                if(go) begin
					if(error == 1) ns = s0;
					else ns = st1;
				end
                else begin
					ns = s0;
				end
			  end
            1: ns = st2;
            2: ns = st3;
            3: 
                if(r_lt_y) ns = s5;
                else ns = s4;
            4: 
                if(count == 4'b0000) ns = s6;
                else ns = st3; 
            5: 
                if(count == 4'b0000) ns = s6;
                else ns = st3; 
            6: ns = s7;
            7: ns = s0; 
            default: ns = s0;
        endcase       
    end
    
    //state reg
    always @(posedge clk) begin
        if(rst == 1) cs = s0;
        else cs = ns;
    end
    
    // begin ld = 0; ud = 0; ce = 0; ldx = 0; slx = 0; srx = 0; cex = 0; ldr = 0; slr = 0; srr = 0; cer = 0; s1 = 0; s2 = 0; s3 = 0; done = 0; end 
    //output logic 
    always @(r_lt_y, cs) begin
        case(cs)
            0: begin ld = 0; ud = 0; ce = 0; ldx = 0; slx = 0; srx = 0; cex = 0; ldr = 0; slr = 0; srr = 0; cer = 0; s1 = 0; s2 = 0; s3 = 0; done = 0; ld_y = 0; right_in_x = 0; end 
            1: begin ld = 1; ud = 0; ce = 1; ldx = 1; slx = 0; srx = 0; cex = 0; ldr = 1; slr = 0; srr = 0; cer = 0; s1 = 0; s2 = 0; s3 = 0; done = 0; ld_y = 1; right_in_x = 0;end
            2: begin ld = 0; ud = 0; ce = 1; ldx = 0; slx = 1; srx = 0; cex = 0; ldr = 0; slr = 1; srr = 0; cer = 0; s1 = 0; s2 = 0; s3 = 0; done = 0; ld_y = 1; right_in_x = 0;end
            3: begin
					ld = 0; ud = 0; ce = 0; ldx = 0; slx = 0; srx = 0; cex = 0; slr = 0; srr = 0; cer = 0; s2 = 0; s3 = 0; done = 0; ld_y = 1;
					if(r_lt_y) begin
						s1 = 0; ldr = 0; right_in_x = 0;
					end else begin
						s1 = 1; ldr = 1; right_in_x = 1;	 
					end
				end
            4: begin ld = 0; ud = 0; ce = 1; ldx = 0; slx = 1; srx = 0; cex = 0; ldr = 0; slr = 1; srr = 0; cer = 0; s1 = 0; s2 = 0; s3 = 0; done = 0; ld_y = 1; right_in_x = 1;end
            5: begin ld = 0; ud = 0; ce = 1; ldx = 0; slx = 1; srx = 0; cex = 0; ldr = 0; slr = 1; srr = 0; cer = 0; s1 = 1; s2 = 0; s3 = 0; done = 0; ld_y = 1; right_in_x = 0;end
            6: begin ld = 0; ud = 0; ce = 0; ldx = 0; slx = 0; srx = 0; cex = 0; ldr = 0; slr = 0; srr = 1; cer = 0; s1 = 0; s2 = 0; s3 = 0; done = 0; ld_y = 1; right_in_x = 0;end
            7: begin ld = 0; ud = 0; ce = 0; ldx = 0; slx = 0; srx = 0; cex = 0; ldr = 0; slr = 0; srr = 0; cer = 0; s1 = 0; s2 = 1; s3 = 1; done = 1; ld_y = 1; right_in_x = 0;end
        endcase
    end              


endmodule