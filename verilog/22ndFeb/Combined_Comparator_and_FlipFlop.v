module Comparator_and_DFF(input signed [7:0] Din,input clk,input clear, input signed [7:0] threshold,output spike);
  wire [7:0] output_d;
D_FF d_flip_flop(Din,clk,clear,output_d);
comparator compare(output_d,threshold,spike);
endmodule
