`timescale 1ns / 1ps

  
module mac_bias_layer1(input wire [7:0] bias, input wire [(S-1):0] pixels, input wire [(S*width)-1:0] weights, output [7:0] final_out );
    parameter width= 8;
     parameter adder_layers=3;
        parameter S= 25;
    wire signed [7:0] sumOut;
    mac_layer1 MAC_layer1 (.sumOut(sumOut), .pixels(pixels), .weights(weights));
    adder #(.OUT_WIDTH(8), .INP_WIDTH(8)) ADD(.out(final_out), .a(bias), .b(sumOut));

endmodule