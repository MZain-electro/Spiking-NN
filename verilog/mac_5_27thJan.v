`timescale 1ns / 1ps

module mac(sumOut,clk, pixelsIn, weightsIn);
    parameter S= 5;
  output [18:0] sumOut;//This is the final sum we are going to get 17bit+18bit = 19bit considering overflow
  	input [(S-1):0] pixelsIn;//This would be 1 and 0 and has 5 registers
  input [(S*16)-1:0] weightsIn;//This would be our weights. They would be for the time being (5*16=80bits)
    input clk;//This is the clock
    
 	reg [(S-1):0] pixels;//dont know the use
    reg [(S*16)-1:0] weights;
     wire [(S*16)-1:0]p; //output wire of multiplexer 16 bits
     
  reg [18:0] sumOut;//dont know the use
    reg [135:0] s1reg;     //for pipelining but how?
  wire [18:0] sum;//19 bits
  
     
  wire [(2*17)-1:0] s1; //Outputs of 2 adders each of 17 bit: 2*17 =>33:0
  wire [33:0] s2; //Outputs of 1 adder of 18 bit=>17:0
  wire [18:0] s3;//Outputs of last 1 adder of 19 bit=>18:0
//      wire [39:0] s4; //outputs of 2 adders each of 20 bits 2*20

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
        mul #(.OUT_WIDTH(16), .INP_WIDTH(16)) multInsta( p[((S*16)-1-16*multGen):((S*16)-1-16*multGen-15)],pixels[(S-1)-1*multGen], weights[((S*16)-1-16*multGen):((S*16)-1-16*multGen-15)]);      
    
    end
    endgenerate
    
    generate
        for(addGen=0; addGen<=1; addGen=addGen+1)
        begin
        //Outputs of 12 adders each of 17 bit: 12*17 =>203:0
          adder #(.OUT_WIDTH(17), .INP_WIDTH(16)) addInsta(s1[(33-17*addGen):(33-17*addGen-16)]  ,p[((S*16)-1-2*16*addGen):((S*16)-1-16*2*addGen-15)],p[((S*16)-1-16*(2*addGen+1)):((S*16)-1-16*(2*addGen+1)-15)]); 
   end
   endgenerate
    
 // adder #(.OUT_WIDTH(18), .INP_WIDTH(17)) adderInsta1(s2[33:17],s1[79:64],s1[63:48]);
 // adder #(.OUT_WIDTH(18), .INP_WIDTH(17)) adderInsta2(s2[16:0],s1[47:32],s1[31:16]);
  adder #(.OUT_WIDTH(18), .INP_WIDTH(17)) adderInsta3(s3[17:0],s1[33:17],s1[16:0]);
  
  adder #(.OUT_WIDTH(19), .INP_WIDTH(18)) adderInsta4(sum,s3[17:0],{2'b0,p[15:0]});
    

endmodule
