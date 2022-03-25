`timescale 1ns / 1ps

////////D Flip Flop////////
module spk_register(input Din,input clk,input reset,output reg Q);

always@(posedge clk)
    begin
    if(reset)// operateds at clear =1
        Q<=0;
    else
        Q<=Din;
    end
endmodule
