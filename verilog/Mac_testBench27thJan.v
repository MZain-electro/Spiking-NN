
`timescale 1ns / 1ps

module mac_tb();
    parameter half_cycle = 20;
    reg data_pixels[4:0]; //5 data_pixels each pixel with 1 bitwdith
    reg [15:0] data_weights[4:0];//5 data_weight each weight with 16 bitwdith
  wire [18:0] sum;
    
    reg [79:0] w;//5*16-1
    reg [4:0] p;//input of pixels  
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
      data_weights[1] = 16'd1;  data_pixels[1] = 1'd0;  
      data_weights[2] = 16'd5;  data_pixels[2] = 1'd1;  
      data_weights[3] = 16'd1; data_pixels[3] = 1'd1;  
      data_weights[4] = 16'd8;  data_pixels[4] = 1'd0;  
        clk=0;
        count=0;
      for (i=0; i<5; i=i+1)
    begin
      Theoretical_sum=data_weights[i]*data_pixels[i]+Theoretical_sum;
    end
    #1 $display("value of Theoretical sum is %d",Theoretical_sum);
    for (i=0; i<5; i=i+1)
    begin
      w[16*i+:16]=data_weights[i];
      $display("value of weight %d is %d",i,w[16*i+:16]);
      p[i]=data_pixels[i];
      $display("value of pixel %d is %d",i,p[i]);
    end
    end//end of first begin
    
    always #half_cycle clk= !clk;
    always @(posedge clk)
    if (count >0)
        #1000
      $display("value of sum is %d",sum);
initial begin
    #10000
    $display("value of sum is %d",sum);
  $finish;
end

  
endmodule
