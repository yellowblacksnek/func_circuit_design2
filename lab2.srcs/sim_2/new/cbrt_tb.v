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
    reg [7:0] a_tb;
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
    reg [2:0] exp;
    wire [2:0] y;
    
    wire [1:0] addsub_addr = 2'b0;

    wire [7:0] addsub_res;
    wire [16:0] addsub_i0;
    addsub addsub_inst(
        .i0(addsub_i0),
        .addr(addsub_addr),
        .out(addsub_res));
    
    
    cubic cubic_inst(
            .clk_i(clk_tb),
            .rst_i(rst_tb),
            .x_bi(a_tb), 
            .start_i(start_tb),
            .busy_o(busy_tb),
            .y_bo(y),
            
            .addsub_ready(1'b1),
            .addsub_res(addsub_res),
            .addsub_mode(addsub_i0[16]),
            .addsub_a(addsub_i0[15:8]),
            .addsub_b(addsub_i0[7:0]));
            
    reg one_was_bad;        
    initial begin
        one_was_bad = 0;
        #10
        for(regg = 0; regg < 256; regg = regg+1) begin            
            a_tb <= regg;
            reset;
            #10;
            while(busy_tb != 0) begin
                #10;     
            end
            
            if(regg == 0) begin exp = 0; end
            else if(regg < 8) begin exp = 1; end
            else if(regg < 27) begin exp = 2; end
            else if(regg < 64) begin exp = 3; end
            else if(regg < 125) begin exp = 4; end
            else if(regg < 216) begin exp = 5; end
            else if(regg < 256) begin exp = 6; end
            else begin exp = 7; end
            
            if(y == exp) begin
                $display("good! a: %d y: %d exp: %d", a_tb, y, exp);
            end else begin
                $display("bad! a: %d y: %d exp: %d", a_tb, y, exp);
                one_was_bad = 1;
            end
        end
        
        if(one_was_bad) begin $display("not all tests are good"); end
        else begin $display("all tests are good!!"); end
        
        $stop;
    end

endmodule
