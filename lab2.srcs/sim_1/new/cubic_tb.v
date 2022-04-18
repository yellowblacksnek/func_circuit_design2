//`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////////
//// Company: 
//// Engineer: 
//// 
//// Create Date: 05.04.2022 22:33:25
//// Design Name: 
//// Module Name: cubic_tb
//// Project Name: 
//// Target Devices: 
//// Tool Versions: 
//// Description: 
//// 
//// Dependencies: 
//// 
//// Revision:
//// Revision 0.01 - File Created
//// Additional Comments:
//// 
////////////////////////////////////////////////////////////////////////////////////


//module cubic_tb;

//    reg clk_tb, rst_tb, start_tb;
//    reg [7:0] x_tb;
//    wire busy_tb;
//    wire [7:0] y_tb;
    
//    reg [7:0] a_array[0:7];

//    always begin
//        #10 clk_tb = !clk_tb;
//    end
    
//    initial begin
//        clk_tb = 1'b0;
//    end

//    task reset; begin
//        rst_tb = 1'b1;
//        start_tb = 1'b1;
//        #20 rst_tb = 1'b0;
//        #20 start_tb = 1'b0;
//    end endtask

//    reg [7:0] i;
//    reg [4:0] exp;
//    wire [2:0] y;
//    reg [7:0] x_i;
//    initial begin
//        a_array[0] = 0;
//        for(i = 1; i < 7; i = i+1) begin
//          a_array[i] = i;
//        end
        
////         a_tb <= 1;
////         b_tb <= 0;
////        exp = a_array[i%7]+b_array[i];
////        reset;
        
//        for(i = 0; i < 7; i = i+1) begin
//            x_i = a_array[i];
            
//            x_tb <= x_i*x_i*x_i;
//            exp = a_array[i];
//            reset;
//            #300
//            if(y == exp) begin
//                $display("good! x: %d y: %d exp: %d", x_tb, y, exp);
//            end else begin
//                $display("bad! x: %d y: %d exp: %d", x_tb, y, exp);
//            end
//        end
        
//        $stop;
//    end
    
    
//    cubic cubic_inst(
//        .clk_i(clk_tb),
//        .rst_i(rst_tb),
//        .x_bi(x_tb), 
//        .start_i(start_tb),
//        .busy_o(busy_tb),
//        .y_bo(y));

//endmodule
