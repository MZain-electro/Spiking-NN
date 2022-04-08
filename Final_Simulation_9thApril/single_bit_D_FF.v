`timescale 1ns / 1ps

////////D Flip Flop////////
module spk_register(input Din,input clk,input reset,input pul, output reg Q);

always@(posedge pul)
    begin
    if(reset)// operateds at clear =1
        Q<=0;
    else if(clk==0)
        Q<=Din;
    end
endmodule
