`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.04.2022 14:37:14
// Design Name: 
// Module Name: sqrt
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

module sqrt(
    input clk_i ,
    input rst_i ,
    input [7:0] x_bi ,
    input start_i ,
    output busy_o ,
    output reg [3:0] y_bo,
    
    input addsub_ready,
    input [7:0] addsub_res,
    output addsub_req,
    output reg addsub_mode,
    output reg [7:0] addsub_a,
    output reg [7:0] addsub_b
    );
    
    localparam IDLE = 2'b00;
    localparam WORK = 2'b01;
    localparam WAIT_SUB = 2'b10;
    localparam READY = 2'b11;
    
    localparam N = 4'h8;
    
    reg [7:0] x;
    reg [7:0] m;
    reg [7:0] y;
    reg [1:0] state;
    
    wire end_step;
    wire [7:0] b;
    
    assign end_step = ( m == 0 ) ;
    assign busy_o = (state != IDLE);
    assign addsub_req = (state == WAIT_SUB);
    
    assign b = y | m;

    always @(posedge clk_i)
        if (rst_i) begin
            m <= 1 << (N - 2);
            y <= 0;
            y_bo <= 0;
            
            state <= IDLE;
        end else begin
            case (state)
                IDLE:
                    if(start_i) begin
                        state <= WORK;
                        m <= 1 << N - 2;
                        x <= x_bi;
                        y <= 0;
                    end
                WORK:
                    begin
                        if(end_step) begin
                            state <= READY;
                            y_bo <= y[3:0];
                        end else begin 
                            if(x >= b) begin
    //                            x <= (x - b);
                                addsub_mode <= 0;
                                addsub_a <= x;
                                addsub_b <= b;
                                state <= WAIT_SUB;
                                
                                y <= ((y >> 1) | m);
                            end else begin
                                y <= (y >> 1);
                            end
                            m <= m >> 2;
                        end
                    end
                WAIT_SUB:
                    if(addsub_ready == 1) begin
                        x <= addsub_res;
                        state <= WORK;
                    end
                READY:
                    begin
                        state <= IDLE;
                    end
            endcase
        end
endmodule
