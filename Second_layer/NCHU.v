`timescale 1ns / 1ps

module NCHU(input [7:0] mac_out, output spk_out, input clk, input pulse, input reset);
  wire signed [7:0] add_out;
  wire signed [7:0] sub_out;
  wire signed [7:0] Mux_out;
  wire signed [7:0] acc_out; 
  wire signed [7:0] shift; 
  
    parameter threshold = 8'd2,one=1'b1, TT = 8'd2;
    adder ADD (.out(add_out), .a(shift), .b(mac_out));
    Sub SUB (.reg_pre(acc_out),.thresh(TT),.sub_out(sub_out));
   T_FF FF(.q(q),.t(one),.rst(reset),.clk(pulse));
  mux MUX (.In_FF(q),.add(add_out),.sub(sub_out),.mux_out(Mux_out));
  acc Acc (.OUT(acc_out), .mux_out(Mux_out),.shifted(shift),.rst(reset),.clk(clk),.pul(pulse),.spk(spk_out));
    Comparator_and_DFF Comp (.Din(acc_out),.threshold(TT),.spike(spk_out),.clk(clk),.rst(reset));
endmodule
