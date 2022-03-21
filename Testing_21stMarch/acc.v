`timescale 1ns / 1ps

//////ACC/////////
module acc(output reg signed [7:0]OUT, input clk, input rst, input signed [7:0] mux_out, output wire signed [7:0] shifted, input pul, input spk);
    

    
  always @(posedge pul) 
    begin
    if (rst) OUT<= 0;
    else
      begin
    if (clk == 1)
        OUT <= mux_out;
    else if(clk == 0 && spk == 1)
        OUT <= mux_out;
    end
      
  end
  assign shifted = (OUT>>>1) + (OUT>>>2);  

 endmodule
