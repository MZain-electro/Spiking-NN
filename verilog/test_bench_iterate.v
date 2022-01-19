// Code your testbench here
// or browse Examples

module iterate_test;
  reg signed [2:0]W[15:0] ;
 // reg signed W[1][15:0];
 // reg signed W[2][15:0];
  
  reg I;
  wire signed [2:0]T[15:0]  ;
  //wire signed T[1][15:0]  ;
  //wire signed T[2][15:0]  ;
  iterate DUT (W,I,T);
 initial
  begin
   //$dumpfile (".vcd"); $dumpvars (0,alutest);
    $monitor ($time," W=%d, I=%b, T=%d", W, I, T);
    #5 I = 1; W[0] = -16'd34;
    #5 I = 0; W[1] = 16'd44;
    #5 I = 1; W[2] = 16'd24;
  //  #5 I = 0; W = -16'd14;
   #5 $finish;
  end
endmodule
