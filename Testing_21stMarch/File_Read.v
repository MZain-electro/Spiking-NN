`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/19/2022 01:12:54 PM
// Design Name: 
// Module Name: File_Read
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

module File_Read();
 parameter half_cycle = 20;
  localparam width=8;
  localparam SF = 2.0**-7.0;  // Q4.4 scaling factor is 2^-4
  reg data_pixels[4:0]; //5 data_pixels each pixel with 1 bitwdith
  reg signed [7:0] data_weights[1:0][4:0];//5 data_weight each weight with 7 bitwdith
  reg signed [7:0] weights[1:0][4:0];

  reg [width*10-1:0] w;//5*8-1
  reg [4:0] p;//input of pixels  
  reg [7:0] count;
  reg signed [7:0] bias_file [1:0];
  reg [15:0] bias_input;
  reg clk1, clk, pulse;
  reg R;
  wire [1:0] spike;
  integer i,j;
  real Theoretical_sum=0;
  Layer_1 layerone(.L_1_bias(bias_input),.L_1_pexel(p),.L_1_weights(w),.spike(spike),.reset(R),.clk(clk),.pulse(pulse));
//  main_initial
   initial
       begin
        R<=1'b1;clk<=0; count=0;
        $readmemb("D:/Users/Admin/Documents/Hasan Sir/Verilog Code/ReadingFiles/weight.txt",data_weights);
        $readmemb("D:/Users/Admin/Documents/Hasan Sir/Verilog Code/ReadingFiles/weight.txt",weights);
        $readmemb("D:/Users/Admin/Documents/Hasan Sir/Verilog Code/ReadingFiles/pixel.txt",data_pixels);//change this to where the weight are stored in binary as Qpoint
        $readmemb("D:/Users/Admin/Documents/Hasan Sir/Verilog Code/ReadingFiles/bias.txt",bias_file);
        for (i=0; i<5; i=i+1)
            begin
              $display("value of 1st row weight through data  %d is %f",i,data_weights[0][i]*SF);
                p[i]=data_pixels[i];
            end
       $display("value of 1st row bias through data  %d is %f",i,bias_file[0]*SF);
       $display("value of 2nd row bias through data  %d is %f",i,bias_file[1]*SF);
        for (i=0; i<5; i=i+1)
            begin
              $display("value of 2nd row weight through data  %d is %f",i,data_weights[1][i]*SF);
            end
        for (i=0; i<2; i=i+1)
            begin
        bias_input[width*i+:width]=bias_file[i];
         $display("value of %d row bias is %f",i,$signed(bias_input[width*i+:width])*SF);   
                for(j=0;j<5;j=j+1)
                begin
                   w[width*(5*i+j)+:width]=data_weights[i][j];
                    $display("value of %d row weight is %f",i,$signed(w[width*(5*i+j)+:width])*SF);   
                end
            end
//        initial end
      end 
      
  always #5 pulse<= ~pulse;
  always  #10 clk1<= ~clk1;
  always #1 clk<=clk1;  
//   $display("value of sum is %f",sum*SF);
always begin
    #31 R<=0;
end
initial
    begin
      clk1<=1'b0;
      clk<=1'b0;
      pulse<=1'b0;
      R<=1'b1;
      #200 $finish;
    end
       
endmodule
