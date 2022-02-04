`timescale 1ns / 1ps
module mul(T,I,W);
parameter OUT_WIDTH= 1;
parameter INP_WIDTH= 1;
  input signed [INP_WIDTH-1:0] W;
  input I;
  output signed [OUT_WIDTH-1:0] T;
  assign T=I?W:16'b0;
endmodule
