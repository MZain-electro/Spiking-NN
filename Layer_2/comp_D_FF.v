`timescale 1ns / 1ps

////////////Comparator with D_FF/////////
module Comparator_and_DFF(input signed [7:0] Din,input clk,input rst, input signed [7:0] threshold,output spike);
    wire [7:0] output_d;
    D_FF d_flip_flop(Din,clk,rst,output_d);
    comp compare(.acc_out(output_d),.threshold(threshold),.spk(spike));
endmodule