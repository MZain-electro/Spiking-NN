`timescale 1ns / 1ps


module mac_layer2(output [7:0] sumOut, input [4:0] pixels, input [39:0]weights);

parameter S = 5;
parameter width= 8;

wire [width-1:0]p_out1; wire [width-1:0]p_out2; wire [width-1:0]p_out3; wire [width-1:0]p_out4; wire [width-1:0]p_out5;
wire [width-1:0]add_out1; wire [width-1:0]add_out2; wire [width-1:0]add_out3;

mul #(.OUT_WIDTH(width), .INP_WIDTH(width)) mult1(.T(p_out1[(width-1):0]),.I(pixels[0]),.W(weights[7:0]));   
mul #(.OUT_WIDTH(width), .INP_WIDTH(width)) mult2(.T(p_out2[(width-1):0]),.I(pixels[1]),.W(weights[15:8]));      
mul #(.OUT_WIDTH(width), .INP_WIDTH(width)) mult3(.T(p_out3[(width-1):0]),.I(pixels[2]),.W(weights[23:16]));      
mul #(.OUT_WIDTH(width), .INP_WIDTH(width)) mult4(.T(p_out4[(width-1):0]),.I(pixels[3]),.W(weights[31:24]));      
mul #(.OUT_WIDTH(width), .INP_WIDTH(width)) mult5(.T(p_out5[(width-1):0]),.I(pixels[4]),.W(weights[39:32]));      

adder #(.OUT_WIDTH(width), .INP_WIDTH(width)) add1(.out(add_out1[width-1:0]),.a(p_out1),.b(p_out2));
adder #(.OUT_WIDTH(width), .INP_WIDTH(width)) add2(.out(add_out2[width-1:0]),.a(p_out3),.b(p_out4));

adder #(.OUT_WIDTH(width), .INP_WIDTH(width)) add3(.out(add_out3[width-1:0]),.a(add_out1),.b(add_out2));

adder #(.OUT_WIDTH(width), .INP_WIDTH(width)) add4(.out(sumOut[width-1:0]),.a(add_out3),.b(p_out5));

   
endmodule