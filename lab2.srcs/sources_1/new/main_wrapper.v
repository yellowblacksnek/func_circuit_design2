`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.04.2022 09:09:42
// Design Name: 
// Module Name: main_wrapper
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


module main_wrapper(
        input wire CLK100MHZ,
        input wire [15:0] SW,
        input wire BTNR,
        input wire BTNC,
        output wire [15:0] LED
    );
        
    assign LED[14] = 1;
    assign LED[13] = BTNR;
    assign LED[12] = BTNC;
        
    main main_inst(
        .clk_i(CLK100MHZ),
        .rst_i(BTNR),
        .start_i(BTNC),
        .a_bi(SW[7:0]),
        .b_bi(SW[15:8]),
        
        .busy_o(LED[15]),
        .y_bo(LED[4:0]));
endmodule
