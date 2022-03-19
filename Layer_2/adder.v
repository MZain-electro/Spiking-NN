`timescale 1ns / 1ps

//////////Adder/////////////
module adder(out, a,b);
    
    parameter OUT_WIDTH= 8;
    parameter INP_WIDTH= 8;
    input signed [INP_WIDTH-1:0] a; // [n,q]
    input signed [INP_WIDTH-1:0] b; // [p,q]
    output signed [OUT_WIDTH-1:0] out; // [max(n+p)+1,q]
    wire signed [OUT_WIDTH-1:0] a_ext = {a[INP_WIDTH-1],a};
    wire signed [OUT_WIDTH-1:0] b_ext = {b[INP_WIDTH-1],b};
  assign out = a + b;
    
endmodule
