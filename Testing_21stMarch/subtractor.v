`timescale 1ns / 1ps

////////////Subtractor/////////////
module Sub(input [7:0] thresh, input signed [7:0] reg_pre,output signed [7:0] sub_out);
    
    assign sub_out = reg_pre - thresh;
endmodule