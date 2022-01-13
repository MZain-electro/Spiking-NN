
`timescale 1ns / 1ps
module multiplier_testbench;
reg clk, start;
reg signed [7:0] a, b;
wire signed [15:0] ab;
wire busy;
 multiplier multiplier1(ab, busy, a, b, clk, start);
 // 
initial begin
clk = 0;
 //$dumpfile ("mul.vcd"); $dumpvars (0, multiplier_testbench);
$display("first example: a = 3 b = 17");
a = -16'd5; b = -17; start = 1; #50 start = 0;
#80 $display("first example done"); 
  $display ("Answer is A=%d, B=%d, AB=%d", a, b, ab);
$finish;
end
always #5 clk = !clk;
always @(posedge clk) $strobe("ab: %d busy: %d at time=%t", ab, busy, $stime);
endmodule
