module mul(W,I,T);
  input signed [15:0] W;
  input I;
  output signed [15:0] T;

     assign T=I?W:16'b0;
endmodule
  


module iterate(Weight,Input,Tout);
  input signed [47:0] Weight; //A
  input Input; //B
  output signed [47:0] Tout; //Res
 //Internal Variables
  wire [47:0] Tout;
  reg [15:0] A1 [2:0];
  wire [15:0] res1 [2:0];  
//   Weight = {A1[0],A1[1],A[2]};
//   Tout = {B1[0],B1[1],B[2]};

 always @(Weight)
   begin
     {A1[0],A1[1],A1[2]} = Weight;
//      {res1[0],res1[1],res1[2]} = 48'd0;
   end
genvar itr;
    generate
      for (itr = 0 ; itr <= 2; itr = itr+1)
        mul m1(A1[itr],Input,res1[itr]);
    endgenerate
    assign Tout = {res1[0],res1[1],res1[2]} ;	
 endmodule
