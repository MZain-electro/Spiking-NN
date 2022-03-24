`timescale 1ns / 1ps

module layer1_layer2(input clk, input pulse, input reset,input [39:0]bias_for1, input [15:0]bias_for2, input [24:0]total_pixel, input [999:0]weights_for1, input [79:0]weights_for2);

wire [4:0]spk_out_layer1;
wire [1:0]spk_out_layer2;
Layer_1 layer1_combined(.clk(clk), .pulse(pulse), .reset(reset), .L_1_pexel(total_pixel[24:0]), .L_1_weights(weights_for1[999:0]), .L_1_bias(bias_for1[39:0]), .spike(spk_out_layer1));

Layer_2 layer2_combined(.clk(clk), .pulse(pulse), .reset(reset), .L_1_pexel(spk_out_layer1[4:0]), .L_1_weights(weights_for2[79:0]), .L_1_bias(bias_for2[15:0]), .spike(spk_out_layer2));
    
endmodule