
module mul(W,I,T);
  input signed [15:0] W;
  input I;
  output signed [15:0] T;
  
// initial 
   //begin
     assign T=I?W:16'b0;
   //end
endmodule
  


module iterate(Weight,Input,Tout);
  //input [1:0] in [7:0];// input is array of 8 bit of 2 bit width
  //wire signed [2:0][15:0] o2macinput 
  input [2:0] Weight[15:0];
  input Input;
  output [2:0] Tout[15:0];
 

initial
  begin
    mul m1([0] Weight[15:0],Input,Tout[0][15:0])
    mul m2(Weight[1][15:0],Input,Tout[1][15:0]);
    mul m3(Weight[2][15:0],Input,Tout[2][15:0]);
       //for(i=0;i<25;i=i+1)
    //  begin
       // o2mac[i][15:0]=
      end
 endmodule
