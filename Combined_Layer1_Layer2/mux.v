`timescale 1ns / 1ps

////////////MUX/////////////
module mux(input In_FF, input [7:0]add, input [7:0]sub, output [7:0]mux_out);
    
    assign mux_out = (In_FF)?(sub):(add); 
    
endmodule
