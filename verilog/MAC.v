`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/23/2022 11:46:31 PM
// Design Name: 
// Module Name: mac
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mac(sumOut,clk, pixelsIn, weightsIn);
     parameter S= 25;
    output [20:0] sumOut;//This is the final sum we are going to get
    input [(S-1):0] pixelsIn;//This would be 1 and 0(25*1 bits). They have used 16*8=128 biyts
    input [(S*25)-1:0] weightsIn;//This would be our weights. They would be for the time being (25*16=400bits)
    input clk;//This is the clock
    
    reg [(S-1):0] pixels;//dont know the use
    reg [(S*25)-1:0] weights;
     wire [(S*25)-1:0]p; //output wire of multiplexer 16 bits
     
    reg [15:0] sumOut;//dont know the use
    reg [135:0] s1reg;     //for pipelining but how?
    wire [20:0] sum;//dont know the use
   
    wire [12*17-1:0] s1; //Outputs of 12 adders each of 17 bit: 12*17 =>203:0
    wire [107:0] s2; //Outputs of 6 adders each of 18 bit: 6*18
    wire [56:0] s3;//Outputs of 3 adders each of 19 bit: 3*19
     wire [39:0] s4; //outputs of 2 adders each of 20 bits 2*20

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
       for(multGen=0; multGen<=24 ;multGen=multGen+1)
       //mult insta is instantiation of the module name. 
        mul #(.OUT_WIDTH(16), .INP_WIDTH(16)) multInsta( p[((S*25)-1-16*multGen):((S*25)-1-16*multGen-15)],pixels[(S-1)-1*multGen], weights[((S*25)-1-16*multGen):((S*25)-1-16*multGen-15)]);      
    endgenerate
    
    generate
        for(addGen=0; addGen<=11; addGen=addGen+1)
        //Outputs of 12 adders each of 17 bit: 12*17 =>203:0
        adder #(.OUT_WIDTH(17), .INP_WIDTH(16)) addInsta(s1[(203-17*addGen):(203-17*addGen-16)]  ,p[((S*25)-1-2*16*addGen):((S*25)-1-16*2*addGen-15)],p[((S*25)-1-16*(2*addGen+1)):((S*25)-1-16*(2*addGen+1)-15)]); 
    endgenerate
    
    adder #(.OUT_WIDTH(18), .INP_WIDTH(17)) adderInsta1(s2[107:90],s1[203:187],s1[186:170]);
     adder #(.OUT_WIDTH(18), .INP_WIDTH(17)) adderInsta2(s2[89:72],s1[169:153],s1[152:136]);
     adder #(.OUT_WIDTH(18), .INP_WIDTH(17)) adderInsta3(s2[71:54],s1[135:119],s1[118:103]);
  // adder #(.OUT_WIDTH(18), .INP_WIDTH(17)) adderInsta2(s2[53:36],s1[101:85],s1[84:68]);
   // adder #(.OUT_WIDTH(18), .INP_WIDTH(17)) adderInsta3(s2[35:18],s1[67:51],s1[50:34]);
    adder #(.OUT_WIDTH(18), .INP_WIDTH(17)) adderInsta4(s2[53:36],s1[102:86],s1[85:69]);
    adder #(.OUT_WIDTH(18), .INP_WIDTH(17)) adderInsta5(s2[35:18],s1[68:52],s1[51:35]);
   adder #(.OUT_WIDTH(18), .INP_WIDTH(17)) adderInsta6(s2[17:0],s1[34:18],s1[17:0]);

    adder #(.OUT_WIDTH(19), .INP_WIDTH(18)) adderInsta7(s3[56:38],s2[107:90],s2[89:72]);
    adder #(.OUT_WIDTH(19), .INP_WIDTH(18)) adderInsta8(s3[37:19],s2[71:54],s2[53:36]);
    adder #(.OUT_WIDTH(19), .INP_WIDTH(18)) adderInsta9(s3[18:0],s2[35:18],s2[17:0]);

    adder #(.OUT_WIDTH(20), .INP_WIDTH(19)) adderInsta10(s4[39:20],s3[56:38],s3[37:19]);
     adder #(.OUT_WIDTH(20), .INP_WIDTH(19)) adderInsta11(s4[19:0],s3[18:0],p[15:0]);
     
      adder #(.OUT_WIDTH(21), .INP_WIDTH(20)) adderInsta12(sum,s4[39:20],s4[19:0]);
    

endmodule
