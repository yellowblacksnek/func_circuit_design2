`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.04.2022 22:33:25
// Design Name: 
// Module Name: cbrt_tb
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


module cbrt_tb;

    reg clk_tb, rst_tb, start_tb;
    reg [7:0] x_tb;
    wire busy_tb;
//    wire [2:0] y_tb;
    
    reg [7:0] a_array[0:7];

    always begin
        #10 clk_tb = !clk_tb;
    end
    
    initial begin
        clk_tb = 1'b0;
    end

    task reset; begin
        rst_tb = 1'b1;
        start_tb = 1'b1;
        #20 rst_tb = 1'b0;
        #20 start_tb = 1'b0;
    end endtask

    reg [7:0] i;
    reg [4:0] exp;
    wire [2:0] y;
    reg [7:0] x_i;
    initial begin
//        x_tb <= 70;
//        exp = 4;
//        reset;
//        #100;
//        while(busy_tb != 0) begin
//            #100;     
//        end
//        if(y == exp) begin
//            $display("good! x: %b y: %b exp: %b", x_tb, y, exp);
//        end else begin
//            $display("bad! x: %b y: %b exp: %b", x_tb, y, exp);
//        end
//        $stop;
        
        a_array[0] = 0;
        for(i = 1; i < 7; i = i+1) begin
          a_array[i] = i;
        end
        
        for(i = 0; i < 7; i = i+1) begin
            x_i = a_array[i];
            
            x_tb <= x_i*x_i*x_i;
            exp = a_array[i];
            reset;
            #100;
                while(busy_tb != 0) begin
                    #100;     
                end
            if(y == exp) begin
                $display("good! x: %d y: %d exp: %d", x_tb, y, exp);
            end else begin
                $display("bad! x: %d y: %d exp: %d", x_tb, y, exp);
            end
        end
        
        $stop;
    end
    
    wire [7:0] bb;
    wire [7:0] xx;
    wire [2:0] mm;
    wire [15:0] mult_y;
    wire mult_rst;
    wire mult_start;
    wire mult_busy;
    wire mult_done;
    cubic cubic_inst(
        .clk_i(clk_tb),
        .rst_i(rst_tb),
        .x_bi(x_tb), 
        .start_i(start_tb),
        .busy_o(busy_tb),
        .y_bo(y),
        .b_out(bb),
        .x_out(xx),
        .m_out(mm),
        .mult_out(mult_y),
        .mult_rst_out(mult_rst),
        .mult_start_out(mult_start),
        .mult_busy_out(mult_busy),
        .mult_done_out(mult_done));

endmodule
