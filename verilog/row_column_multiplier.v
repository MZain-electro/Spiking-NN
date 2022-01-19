// Code your design here
module mul(W,I,T);
  input signed [15:0] W;
  input I;
  output signed [15:0] T;
  
     assign T=I?W:16'b0;
endmodule
  
