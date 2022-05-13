`timescale 1ns / 1ps

module mult_tb;

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

    reg [8:0] reg1;
    reg [8:0] reg2;
    reg [15:0] exp;
    wire [15:0] y;
    
    mult mult_inst(
        .clk_i(clk_tb),
        .rst_i(rst_tb),
        .a_bi(a_tb), 
        .b_bi(b_tb), 
        .start_i(start_tb),
        .busy_o(busy_tb),
        .y_bo(y));  
            
    reg one_was_bad;
    initial begin
        one_was_bad = 0;
        for(reg1 = 0; reg1 < 128; reg1 = reg1+1) begin            
            a_tb <= reg1;
            for(reg2 = 0; reg2 < 128; reg2 = reg2+1) begin  
                b_tb <= reg2;
                exp <= reg1*reg2;
                reset;
                while(busy_tb != 0) begin
                    #50;     
                end
                if(y == exp) begin
                    $display("good! a: %d b: %d y: %d exp: %d", a_tb, b_tb, y, exp);
                end else begin
                    $display("bad! a: %d b: %d y: %d exp: %d", a_tb, b_tb, y, exp);
                    one_was_bad = 1;
                end
            end
        end
        
        if(one_was_bad) begin $display("not all tests are good"); end
        else begin $display("all tests are good!!"); end
        
        $stop;
    end

endmodule
