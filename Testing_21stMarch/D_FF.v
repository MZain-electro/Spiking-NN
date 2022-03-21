`timescale 1ns / 1ps

////////D Flip Flop////////
module D_FF(input signed [7:0]Din,input clk,input rst,output reg signed [7:0] Q);

always@(posedge clk)
    begin
    if(rst)// operateds at clear =1
        Q<=0;
    else
        Q<=Din;
    end
endmodule
