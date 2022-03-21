`timescale 1ns / 1ps

 //////////T Flip Flop/////////////
 module T_FF (input clk, input rst, input t,output reg q); ///if Reset =1, T_FF is reseated to 0

  always @ (negedge clk) begin  
    if (rst)  
      q <= 0;  
    else  
        if (t)  
            q <= ~q;  
        else  
            q <= q;  
  end  
endmodule