`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.04.2022 00:35:03
// Design Name: 
// Module Name: dc2_4
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


module dc2_4(
        input [1:0] i,
        output reg [3:0] out
    );
//    and(out[0], !i[1], !i[0]);
//    and(out[1], !i[1], i[0]);
//    and(out[2], i[1], !i[0]);
//    and(out[3], i[1], i[0]);

    always @* begin
        case(i)
            3: begin out = 4'b1000; end
            2: begin out = 4'b0100; end
            1: begin out = 4'b0010; end
            0: begin out = 4'b0001; end
        endcase
    end
endmodule
