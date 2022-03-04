`timescale 1ns / 1ps
module Layer_1(input clk, input pulse, input reset, input [24:0]L_1_pexel, input [999:0] L_1_weights, input [39:0] L_1_bias, output [4:0] spike);

genvar i;
generate
       for(i=0; i<=4 ;i=i+1)
       begin
        Mac_NCHU (.spk_out(spike[i]), .clk(clk), .pulse(pulse), .reset(reset), .pixelsIn(L_1_pexel[24:0]), .weightsIn(L_1_weights[(200*(i+1)-1):(200*i)]), .bias(L_1_bias[(8*(1+i)-1):(i*8)]));      
    end
endgenerate

endmodule
