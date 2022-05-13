`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.04.2022 16:41:19
// Design Name: 
// Module Name: mult_tb
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


module main_tb;

    reg clk_tb, rst_tb, start_tb;
    reg [7:0] a_tb;
    reg [7:0] b_tb;
    wire busy_tb;


    always begin
        #5 clk_tb = !clk_tb;
    end
    
    initial begin
        clk_tb = 1'b0;
        rst_tb = 1'b1;
        #10 rst_tb = 1'b0;
    end

    task reset; begin
        start_tb = 1'b1;
        #10 start_tb = 1'b0;
    end endtask

    reg [8:0] regg;
    reg [7:0] i;
    reg [7:0] j;
    reg [15:0] exp;
    wire [4:0] y;
    
    reg one_was_bad;
    initial begin
    one_was_bad = 0;
        #10
        for(i = 0; i < 16; i = i+1) begin
            for(j = 0; j < 7; j = j+1) begin
                a_tb <= j*j*j;
                b_tb <= i*i;

                reset;
                #10;
                while(busy_tb != 0) begin
                    #10;     
                end
                exp = i+j;
                if(y == exp[4:0]) begin
                    $display("i: %d good! a: %d b: %d y: %d exp: %d", i*7+j+1, a_tb, b_tb, y, exp);
                end else begin
                    $display("i: %d bad! a: %d b: %d y: %d exp: %d", i*7+j+1, a_tb, b_tb, y, exp);
                    one_was_bad = 1;
                end
            end
        end
        
        if(one_was_bad) begin $display("not all tests are good"); end
        else begin $display("all tests are good!!"); end
        
        $stop;
    end
    
    main main_inst(
        .clk_i(clk_tb),
        .rst_i(rst_tb),
        .a_bi(a_tb), 
        .b_bi(b_tb), 
        .start_i(start_tb),
        .busy_o(busy_tb),
        .y_bo(y)); 

endmodule
