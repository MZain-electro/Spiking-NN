// Code your testbench here
// or browse Examples
module alutest;
  reg signed [15:0] X, Y;
  wire signed [15:0] Z; wire S, ZR, CY, P, V;
 ALU DUT (X, Y, Z, S, ZR, CY, P, V);
 initial
  begin
   $dumpfile ("alu.vcd"); $dumpvars (0,alutest);
    $monitor ($time," X=%d, Y=%d, Z=%d, S=%b, Z=%b, CY=%b, P=%b,V=%b", X, Y, Z, S, ZR, CY, P, V);
    #5 X = -16'd5; Y = -16'd10;
   #5 $finish;
  end
endmodule
