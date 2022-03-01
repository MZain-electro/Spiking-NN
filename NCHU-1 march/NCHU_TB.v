`timescale 1ns / 1ps

module NCHU_TB;
 reg signed [7:0] mac_output;
 reg R;
 wire spike;
reg clk1, clk, pulse;
    initial 
    begin
      clk1<=1'b0;
      clk<=1'b0;
      pulse<=1'b0;
    end
always #5 pulse<= ~pulse;
 always  #10 clk1<= ~clk1;
 always #1 clk<=clk1;
  NCHU NCHU_test(.mac_out(mac_output),.clk(clk),.pulse(pulse),.reset(R),.spk_out(spike));
 initial 
begin
$dumpfile("dump.vcd"); $dumpvars;
  R<=1'b1;clk<=0;
#31 mac_output<=8'd3;

#200 $finish;
end
    always
    begin
    #31 R=1'b0;
      #20 mac_output =8'd1;
      #20 mac_output=8'd5;
      #20 mac_output=8'd2;
    end   
   
endmodule
