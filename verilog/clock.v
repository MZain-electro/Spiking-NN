`timescale 1ns/1ps
module clock(); 
reg clk1, clk2, clk3;
initial 
begin
     $dumpfile("dump.vcd");
  $dumpvars;
  clk1<=1'b0;
  clk2<=1'b0;
  clk3<=1'b0;
  #100 $finish;
end
always
#5 clk2<= ~clk2;
  always
    #10 clk1<= ~clk1;
    always
        #1 clk3<=clk1;

endmodule
