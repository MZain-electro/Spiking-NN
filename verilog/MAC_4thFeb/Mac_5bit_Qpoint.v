`timescale 1ns / 1ps
//width is 8 (Q1.7=7+1)
module mac(sumOut,clk, pixelsIn, weightsIn);
    parameter S= 5;
      parameter width= 8;
      parameter adder_layers=3;
      //first two 8 bits numbers would be added to give a 9 bit number (2 adders => 2*9-1)
      //these two would be added to give a 10 bit number(2 adders 2*10-1)
      //these two would be added to give a 11 bit number(single adder)
  output [width+adder_layers-1:0] sumOut;//This is the final sum we are going to get 11bits considering overflow implier 10:0
  	input [(S-1):0] pixelsIn;//This would be 1 and 0 and has 5 registers
  input [(S*8)-1:0] weightsIn;//This would be our weights. They would be for the time being (5*8=40bits)
    input clk;//This is the clock
    
 	reg [(S-1):0] pixels;//intermediate registers
    reg [(S*width)-1:0] weights;//intermediate registers
     wire [(S*width)-1:0]p; //output wire of multiplexer 8 bits
     
  reg [width+adder_layers-1:0] sumOut;//dont kn8ow the use
    reg [135:0] s1reg;     //for pipelining but how?
  wire [width+adder_layers-1:0] sum;//11 bits
  
     
  wire [(2*(width+1))-1:0] s1;//output of first layer of adders
  //Outputs of 1 adder of 18 bit=>17:0
  wire [2*(width+2)-1:0] s2;    //Outputs of 2nd layer of  adders each of 9 bit: 2*9 =>33:0
  wire [(width+2)-1:0] s3;//Outputs of last 1 adder of 10 bits=>9:0
    always @(posedge clk)
    begin
   
        pixels<= pixelsIn;//withe every clock pulse it would take input as pixel to a register
        weights<= weightsIn;//weights would also be stored as registers
//        pr <= p;
       // s1reg <= s1;//dont know what this i s
        sumOut <= sum;//dont know what this is
        
    end
    
    genvar multGen, addGen;
    generate
       for(multGen=0; multGen<=4 ;multGen=multGen+1)
       begin
       //mult insta is instantiation of the module name. 
        mul #(.OUT_WIDTH(width), .INP_WIDTH(width)) multInsta( p[((S*width)-1-width*multGen):((S*width)-1-width*multGen-(width-1))],pixels[(S-1)-1*multGen], weights[((S*width)-1-width*multGen):((S*width)-1-width*multGen-(width-1))]);      
    
    end
    endgenerate
    
    generate
        for(addGen=0; addGen<=1; addGen=addGen+1)
        begin
        //Outputs of 12 adders each of 17 bit: 12*17 =>203:0
          adder #(.OUT_WIDTH(width+1), .INP_WIDTH(width)) addInsta(s1[((width+1)*2-1-(width+1)*addGen):((width+1)*2-1-(width+1)*addGen-width)]  ,p[((S*width)-1-2*width*addGen):((S*width)-1-width*2*addGen-(width-1))],p[((S*width)-1-width*(2*addGen+1)):((S*width)-1-width*(2*addGen+1)-(width-1))]); 
   end
   endgenerate
    
 // adder #(.OUT_WIDTH(18), .INP_WIDTH(17)) adderInsta1(s2[33:17],s1[79:64],s1[63:48]);
 // adder #(.OUT_WIDTH(18), .INP_WIDTH(17)) adderInsta2(s2[16:0],s1[47:32],s1[31:16]);
  adder #(.OUT_WIDTH(width+2), .INP_WIDTH(width+1)) adderInsta3(s3[width+1:0],s1[2*(width+1)-1:width+1],s1[width:0]);
  
  adder #(.OUT_WIDTH(width+3), .INP_WIDTH(width+2)) adderInsta4(sum,s3[width+1:0],{2'b0,p[width-1:0]});
    

endmodule
