`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/22/2022 11:53:43 AM
// Design Name: 
// Module Name: ComparatorandD_ff_TB
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ComparatorandD_ff_TB;
 reg signed [7:0] accumulator_output;
 reg clk;
 reg signed [7:0] threshold;
 wire spike;
 reg clear;
  Comparator_and_DFF CandD(accumulator_output,clk,clear,threshold, spike);
 initial 
begin

accumulator_output<=8'd3;
clk<=0;
threshold<=8'd2;
clear=1;
#20 $finish;
end
  // Generate clock  
    always #2 clk = ~clk; 
    
    always
    begin
    #2 clear<=0;
    #6 accumulator_output =1;
    end

                
   
endmodule
