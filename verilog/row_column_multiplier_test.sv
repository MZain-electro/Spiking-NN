module iterate_test;
  reg signed [47:0]W ;
  reg I;
  wire signed [47:0]T;
  iterate DUT (W,I,T);
 initial
      begin
        // Apply Inputs
        $monitor ($time," W1=%d, I=%b, T1=%d", W, I, T);
        #5 I = 1; W = {16'd1,16'd2,16'd3}; 
        #5 I = 0; W = {-16'd34,16'd44,16'd24};
       
    end
endmodule
