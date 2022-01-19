
module multest;
  reg signed [15:0] W;
  reg I;
  wire signed [15:0] T ;
  mul DUT (W,I,T);
 initial
  begin
   //$dumpfile (".vcd"); $dumpvars (0,alutest);
    $monitor ($time," W=%d, I=%b, T=%d", W, I, T);
    #5 I = 1; W = -16'd34;
     #5 I = 0; W = 16'd44;
    #5 I = 1; W = 16'd24;
    #5 I = 0; W = -16'd14;
   #5 $finish;
  end
endmodule
