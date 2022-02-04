 
`timescale 1ns / 1ps
//The follwoing code takes in five 8 bit (Q1.7 format weights) and multiples with pixels( five 1 bit) and output as a wire of 11 bits
//the parameter width is number of bits in weight
module mac_tb();
    parameter half_cycle = 20;
    localparam width=8;
    localparam SF = 2.0**-7.0;  // Q4.4 scaling factor is 2^-4
    reg data_pixels[4:0]; //5 data_pixels each pixel with 1 bitwdith
    reg signed [7:0] data_weights[4:0];//5 data_weight each weight with 7 bitwdith
    wire signed [7:0] sum;//output sum =1 number of layer adders+ initial weights
    reg [width*5-1:0] w;//5*8-1
    reg [4:0] p;//input of pixels  
    reg [7:0] count;
    reg clk;
    wire clk2;
   
  integer file,i,outFile;
  real signed Theoretical_sum=0;
    assign #2 clk2 = clk;
    mac macInsta(sum,clk,p,w);
    initial
    begin
    $readmemb("D:/Users/Admin/Documents/Hasan Sir/Verilog Code/MaC2/Qpoint_W1_FirstFive.txt",data_weights);//change this to where the weight are stored in binary as Qpoint
file=$fopen("D:/Users/Admin/Documents/Hasan Sir/Verilog Code/MaC2/Output_of_Mac.txt","w");//output of the Qpoint

   if (file)  $display("File was opened successfully : %0d", file);
    else       $display("File was NOT opened successfully : %0d", file);
     
       data_pixels[0] = 1'd1;  
       data_pixels[1] = 1'd0;  
       data_pixels[2] = 1'd1;  
       data_pixels[3] = 1'd1;  
       data_pixels[4] = 1'd1;  
        clk=0;
        count=0;
      for (i=0; i<5; i=i+1)
    begin
      Theoretical_sum=(data_weights[i]*SF*data_pixels[i])+Theoretical_sum;
       //$display("value of data weights %f , pixels %d and theoretical sum %f is \n",data_weights[i]*SF,data_pixels[i],Theoretical_sum);
    end
    #1 $display("value of Theoretical sum is %f",Theoretical_sum);
    for (i=0; i<5; i=i+1)
    begin
      $display("value of weight through data  %d is %f",i,data_weights[i]*SF);
      w[width*i+:width]=data_weights[i];
      $display("value of weight in weight is %f is %f",i,w[width*i+:width]*SF);
      p[i]=data_pixels[i];
      $display("value of pixel %d is %d",i,p[i]);
    end
    end
    
    always #half_cycle clk= !clk;
    always @(posedge clk)
    if (count >0)
        #1000
   $display("value of sum is %f",sum*SF);
initial begin
    #100
    $display("value of sum is %f",sum*SF);
  $finish;
end

  
endmodule
