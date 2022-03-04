`timescale 1ns / 1ps

module NCHU_with_register(input [7:0] mac_out, output spk_out, input clk, input pulse, input reset);
wire spike_inner;
 NCHU nchu(.mac_out(mac_out), .spk_out(spike_inner), .clk(clk), .pulse(pulse),.reset(reset));
 spk_register spk_reg(.Din(spike_inner), .clk(clk), .reset(reset), .Q(spk_out));
endmodule

