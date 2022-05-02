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


module mult_tb;

    reg clk_tb, rst_tb, start_tb;
    reg [7:0] a_tb;
    reg [7:0] b_tb;
//    reg [7:0] x_tb;
    wire busy_tb;
//    wire [7:0] y_tb;
    
    reg [7:0] a_array[0:7];
    reg [7:0] b_array[0:16];

    always begin
        #5 clk_tb = !clk_tb;
    end
    
    initial begin
        clk_tb = 1'b0;
        rst_tb = 1'b1;
        #10 rst_tb = 1'b0;
    end

    task reset; begin
//        rst_tb = 1'b1;
        start_tb = 1'b1;
//        #20 rst_tb = 1'b0;
        #10 start_tb = 1'b0;
    end endtask

    reg [8:0] regg;
    reg [7:0] i;
    reg [4:0] exp;
    wire [4:0] y;
    reg [7:0] a_i;
    reg [7:0] b_i;
    initial begin
        a_array[0] = 0;
        for(i = 1; i < 7; i = i+1) begin
          a_array[i] = i;
        end
        
        b_array[0] = 0;
        for(i = 1; i < 16; i = i+1) begin
          b_array[i] = i;
        end
        
//         a_tb <= 1;
//         b_tb <= 0;
//        exp = a_array[i%7]+b_array[i];
//        reset;
        
        for(i = 0; i < 16; i = i+1) begin
            a_i = a_array[i%7];
            b_i = b_array[i];
            
            a_tb <= a_i*a_i*a_i;
            b_tb <= b_i*b_i;
            exp = a_array[i%7]+b_array[i];
            reset;
            #50;
            while(busy_tb != 0) begin
                #50;     
            end
            if(y == exp) begin
                $display("good! a: %d b: %d y: %d exp: %d", a_tb, b_tb, y, exp);
            end else begin
                $display("bad! a: %d b: %d y: %d exp: %d", a_tb, b_tb, y, exp);
            end
        end
        
//        for(regg = 0; regg < 256; regg = regg+1) begin            
//            a_tb <= 0;
//            b_tb <= regg;
//            exp = 0;
//            reset;
//            #50;
//            while(busy_tb != 0) begin
//                #50;     
//            end
//            if(y == exp) begin
//                $display("good! a: %d b: %d y: %d exp: %d", a_tb, b_tb, y, exp);
//            end else begin
//                $display("bad! a: %d b: %d y: %d exp: %d", a_tb, b_tb, y, exp);
//            end
//        end
        
        $stop;
    end
    
    
//    cubic cubic_inst(
//        .clk_i(clk_tb),
//        .rst_i(rst_tb),
//        .x_bi(x_tb), 
//        .start_i(start_tb),
//        .busy_o(busy_tb),
//        .y_bo(y_tb));
        
//    sqrt sqrt_inst(
//        .clk_i(clk_tb),
//        .rst_i(rst_tb),
//        .x_bi(x_tb), 
//        .start_i(start_tb),
//        .busy_o(busy_tb),
//        .y_bo(y_tb));  
    
//    wire [3:0] addsub_req;
//    wire [3:0] addsub_ready;
//    wire [1:0] addsub_addr;

//    wire addsub_ready0 = addsub_ready[0];
//    wire addsub_ready1 = addsub_ready[1];
//    wire addsub_ready2 = addsub_ready[2];
//    wire addsub_ready3 = addsub_ready[3];

    
    main main_inst(
        .clk_i(clk_tb),
        .rst_i(rst_tb),
        .a_bi(a_tb), 
        .b_bi(b_tb), 
        .start_i(start_tb),
        .busy_o(busy_tb),
        .y_bo(y));
//        .addsub_req(addsub_req),
//        .addsub_ready(addsub_ready),
//        .addsub_addr(addsub_addr));    

endmodule
