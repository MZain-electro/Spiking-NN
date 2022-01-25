// Code your testbench here
// or browse Examples
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/07/2020 02:07:10 PM
// Design Name: 
// Module Name: mac_tb
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


module mac_tb();
    parameter half_cycle = 20;
    reg [1:0] data_pixels[24:0]; //40 data_pixels each pixel with 128 bitwdith
    reg [15:0] data_weights[24:0];
    wire [19:0] sum;
    
    reg [399:0] w;
    reg [24:0] p; 
    reg [7:0] count;
    reg clk;
    wire clk2;
    
    integer outFile1;
         integer i;
  integer Theoretical_sum=0;
    
    assign #2 clk2 = clk;
    
    mac macInsta(sum,clk,p,w);

    
    initial
    begin
        data_weights[0] = 16'd1;   data_pixels[0] = 1'd1;  
      data_weights[1] = 16'd1;  data_pixels[1] = 1'd1;  
      data_weights[2] = 16'd5;  data_pixels[2] = 1'd1;  
      data_weights[3] = 16'd1; data_pixels[3] = 1'd1;  
      data_weights[4] = 16'd8;  data_pixels[4] = 1'd0;  
      data_weights[5] = 16'd6; data_pixels[5] = 1'd0;  
      data_weights[6] = 16'd5; data_pixels[6] = 1'd0;  
      data_weights[7] = 16'd2; data_pixels[7] = 1'd1;  
      data_weights[8] = 16'd5; data_pixels[8] = 1'd0;  
      data_weights[9] = 16'd1; data_pixels[9] = 1'd1;  
      data_weights[10] = 16'd3; data_pixels[10] = 1'd1;  
      data_weights[11] = 16'd1; data_pixels[11] = 1'd0;  
      data_weights[12] = 16'd2; data_pixels[12] = 1'd1;  
      data_weights[13] = 16'd3; data_pixels[13] = 1'd0;  
      data_weights[14] = 16'd7; data_pixels[14] = 1'd0;  
      data_weights[15] = 16'd5; data_pixels[15] = 1'd1;  
      data_weights[16] = 16'd4; data_pixels[16] = 1'd0;  
      data_weights[17] = 16'd2; data_pixels[17] = 1'd1;  
      data_weights[18] = 16'd4; data_pixels[18] = 1'd1;  
      data_weights[19] = 16'd6; data_pixels[19] = 1'd1;  
      data_weights[20] = 16'd7; data_pixels[20] = 1'd0;  
      data_weights[21] = 16'd8; data_pixels[21] = 1'd1;  
      data_weights[22] = 16'd4; data_pixels[22] = 1'd0;  
      data_weights[23] = 16'd3; data_pixels[23] = 1'd1;  
      data_weights[24] = 16'd2; data_pixels[24] = 1'd1;  
        
        outFile1 = $fopen("simout.txt","w");
        clk=0;
        count=0;

      for (i=0; i<25; i=i+1)
    begin
      Theoretical_sum=data_weights[i]*data_pixels[i]+Theoretical_sum;
        //#1 $display("value of data_weights sum is %d",data_weights[i]);
    end
    #1 $display("value of Theoretical sum is %d",Theoretical_sum);
    end
    
    always #half_cycle clk= !clk;
    
    //write to file
    always @(posedge clk)
    if (count >0)
        $fdisplay(outFile1, "%h",sum);
        
    always @(posedge clk2)
    begin
        p= data_pixels[count];
      #1 $display("value of data_pixels is %d",p);
        w= data_weights[count];
      #1 $display("value of weights is %d",w);
        count = count+1;
        if (count==25)
        begin
          #10 $display("value of sum_out is %d",sum);
            $fclose(outFile1);
            $finish;
        end
    end
 
  
endmodule
