`timescale 1ns / 1ps

module Layer1_Layer2(input clk, input pulse, input reset, input [24:0]total_pixel,output wire [1:0] spk_out_layer2 );

wire [4:0]spk_out_layer1;
reg [79:0]weights_for2=80'b11101110111101011111011111110111111111011111111100000110000001100000111100010010;
reg [999:0]weights_for1=1000'hfe0707ff04060bff0a020107fb09000404070900fb0003fefe05040505fd06070401fa0402f40501fc0805090103fc05fefd03070505050802ff0a040204f90e05090a0a0afd0303fffe03fd0304fffcfe03fd03040505fb07fc02090a00f9fc04fd0102040202000403080503050a09f60dfe0706040bfe0403feff03;
reg [39:0]bias_for1=40'h0308020205;
reg [15:0]bias_for2=16'h13f8;

//wire [1:0]spk_out_layer2;
Layer_1 layer1_combined(.clk(clk), .pulse(pulse), .reset(reset), .L_1_pexel(total_pixel[24:0]), .L_1_weights(weights_for1[999:0]), .L_1_bias(bias_for1[39:0]), .spike(spk_out_layer1));

Layer_2 layer2_combined(.clk(clk), .pulse(pulse), .reset(reset), .L_1_pexel(spk_out_layer1[4:0]), .L_1_weights(weights_for2[79:0]), .L_1_bias(bias_for2[15:0]), .spike(spk_out_layer2));
    
endmodule
