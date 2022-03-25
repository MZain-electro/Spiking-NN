`timescale 1ns / 1ps
module Layer_1(input clk, input pulse, input reset, input [4:0]L_1_pexel, input [79:0] L_1_weights, input [15:0] L_1_bias, output [1:0] spike);

genvar i;
generate
       for(i=0; i<=1 ;i=i+1)
       begin
        Mac_NCHU (.spk_out(spike[i]), .clk(clk), .pulse(pulse), .reset(reset), .pixelsIn(L_1_pexel[4:0]), .weightsIn(L_1_weights[(40*(i+1)-1):(40*i)]), .bias(L_1_bias[(8*(1+i)-1):(i*8)]));      
    end
endgenerate

endmodule
