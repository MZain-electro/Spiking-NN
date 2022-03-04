`timescale 1ns / 1ps

  
module mac_bias(input wire [7:0] bias, input wire [(S-1):0] pixels, input wire [(S*width)-1:0] weights, output [7:0] final_out );
    parameter width= 8;
     parameter adder_layers=3;
        parameter S= 25;
    wire signed [7:0] sumOut;
    mac #(.S(25), .width(8)) MAC (.sumOut(sumOut), .pixels(pixels), .weights(weights));
    adder #(.OUT_WIDTH(8), .INP_WIDTH(8)) ADD(.out(final_out), .a(bias), .b(sumOut));

endmodule