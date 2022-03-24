`timescale 1ns / 1ps

module TestBench_readfiles();
 parameter half_cycle = 20;
  localparam width=8;
  localparam SF = 2.0**-7.0;  // Q4.4 scaling factor is 2^-4
  reg data_pixels[24:0]; //5 data_pixels each pixel with 1 bitwdith
  //data variables implies the 2d arrays in which the data is stored. They will be converted to a single array
  reg signed [7:0] data_weights2[1:0][4:0];//5 data_weight each weight with 7 bitwdith
  reg signed [7:0] weights[1:0][4:0];
  reg signed [7:0] data_weights1[4:0][24:0];//first bracket is rows ( number of neurons in second layer) 
  reg signed [7:0] data_bias1[4:0];//this has 4 rows
  reg signed [7:0] data_bias2 [1:0];
  reg [15:0] b2;
  reg [width*10-1:0] w2;//5*8-1
  reg [width*5*25-1:0] w1;
  reg [width*5-1:0] b1;
  reg [24:0] p;//input of pixels  
  reg [7:0] count;
  reg R;
  wire [1:0] spike;
  integer i,j;
  real Theoretical_sum=0;

   initial
       begin 
       //Reading of data from files
            $readmemb("D:/Users/Admin/Documents/Hasan Sir/Verilog Code/Layer1_to_Update/W2_q.txt",data_weights2);
            $readmemb("D:/Users/Admin/Documents/Hasan Sir/Verilog Code/Layer1_to_Update/W1_q.txt",data_weights1);
            $readmemb("D:/Users/Admin/Documents/Hasan Sir/Verilog Code/ReadingFiles/weight.txt",weights);
            $readmemb("D:/Users/Admin/Documents/Hasan Sir/Verilog Code/Layer1_to_Update/pixel.txt",data_pixels);//change this to where the weight are stored in binary as Qpoint
            $readmemb("D:/Users/Admin/Documents/Hasan Sir/Verilog Code/Layer1_to_Update/B2_q.txt",data_bias2);
            $readmemb("D:/Users/Admin/Documents/Hasan Sir/Verilog Code/Layer1_to_Update/B1_q.txt",data_bias1);
         //end of reading from files   
            for (i=0; i<5; i=i+1)
                begin
                b1[width*i+:width]=data_bias1[i];
                $display(" b1[%0d] = %0f",i,$signed(b1[width*i+:width])*SF);   
                for(j=0;j<25;j=j+1)
                    begin
                    p[i]=data_pixels[i];
                    w1[width*(25*i+j)+:width]=data_weights1[i][j];
                    $display("w1[%0d][%0d] = %0f",i,j,$signed(w1[width*(25*i+j)+:width])*SF);   
                    end
                end
                
            for (i=0; i<2; i=i+1)
                begin
                b2[width*i+:width]=data_bias2[i];
                $display("b2[%0d] = %0f",i,$signed(b2[width*i+:width])*SF);   
                    for(j=0;j<5;j=j+1)
                    begin
                       w2[width*(5*i+j)+:width]=data_weights2[i][j];
                        $display("w2[%0d][%0d] = %0f",i,j,$signed(w2[width*(5*i+j)+:width])*SF);   
                    end
                 end
     end
      
endmodule
