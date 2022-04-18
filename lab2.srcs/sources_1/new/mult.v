`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.04.2022 16:25:17
// Design Name: 
// Module Name: mult
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


module mult(
    input clk_i ,
    input rst_i ,
    input [ 7 : 0 ] a_bi ,
    input [ 7 : 0 ] b_bi ,
    input start_i ,
    output busy_o ,
    output reg [ 15 : 0 ] y_bo
    );
    
    localparam IDLE = 2'b00;
    localparam WORK = 2'b01;
    localparam READY = 2'b10;
    
    reg [ 2 : 0 ] ctr ;
    wire [ 2 : 0 ] end_step ;
    wire [ 7 : 0 ] part_sum ;
    wire [ 15 : 0 ] shifted_part_sum ;
    reg [ 7 : 0 ] a , b ;
    reg [ 15 : 0 ] part_res ;
    reg [1:0] state ;
    
    assign part_sum = a & {8{b[ctr]} } ;
    assign shifted_part_sum = part_sum << ctr ;
    assign end_step = ( ctr == 3'h7 ) ;
    assign busy_o = (state != IDLE);

    always @(posedge clk_i)
        if (rst_i) begin
            ctr <= 0;
            part_res <= 0;
            y_bo <= 0;
            
            state <= IDLE;
        end else begin
            case (state)
                IDLE:
                    if(start_i) begin
                        state <= WORK;
                        
                        a <= a_bi;
                        b <= b_bi;
                        ctr <= 0;
                        part_res <= 0;
                    end
                WORK:
                    begin
                        if(end_step) begin
                            state <= READY;
                            y_bo <= part_res;
                        end
                        
                        part_res <= part_res + shifted_part_sum;
                        ctr <= ctr + 1;
                    end
                READY:
                    begin
                        state <= IDLE;
                    end
            endcase
        end
endmodule
