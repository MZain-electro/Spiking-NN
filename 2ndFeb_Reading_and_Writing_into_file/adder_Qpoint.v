`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: 
// 
// Create Date: 02/02/2022 04:30:14 PM
// Design Name: 
// Module Name: Qpoint_Adder
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


module Qpoint_Adder(out, a,b);
    
    parameter OUT_WIDTH= 1;
    parameter INP_WIDTH= 1;
    input signed [INP_WIDTH-1:0] a; // [n,q]
    input signed [INP_WIDTH-1:0] b; // [p,q]
    output signed [OUT_WIDTH-1:0] out; // [max(n+p)+1,q]
    wire signed [OUT_WIDTH-1:0] a_ext = {a[INP_WIDTH-1],a};
    wire signed [OUT_WIDTH-1:0] b_ext = {b[INP_WIDTH-1],b};
    assign out = a_ext + b_ext;
    
endmodule
