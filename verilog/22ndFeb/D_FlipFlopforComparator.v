module D_FF(Din,clk,clear,Q);
input signed [7:0]Din;
input clk,clear;
output reg signed [7:0] Q;
always@(posedge clk)
begin
  if(clear)// operateds at clear =0
Q<=0;
else
Q<=Din;
end
endmodule
