`timescale 1ns / 1ps

module Mac_NCHU_layer1(output spk_out, input clk, input pulse, input reset, input [24:0] pixelsIn, input [199:0] weightsIn, input [7:0] bias);
//   wire [4;0] pixelsIn;
  wire [7:0] mac_to_nchu;
mac_bias_layer1 MAC_Layer1 (.pixels(pixelsIn), .weights(weightsIn),.bias(bias), .final_out(mac_to_nchu));
NCHU_with_register NCHU_1_L2(.mac_out(mac_to_nchu),.spk_out(spk_out), .clk(clk), .pulse(pulse), .reset(reset));

endmodule
