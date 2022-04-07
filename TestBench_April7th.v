`timescale 1ns / 1ps
//time units is the number of times a single output would be required to enter. 20 is the time period of the clock
module TestBench_readfiles();
 parameter half_cycle = 20;
 parameter examples=2114;
 parameter time_units=15;
  localparam width=8;
  localparam SF = 2.0**-7.0;  // Q1.7 scaling factor is 2^-7
  reg data_pixels[525849:0]; //5 data_pixels each pixel with 1 bitwdith
  //data variables implies the 2d arrays in which the data is stored. They will be converted to a single array
  reg signed [7:0] data_weights2[1:0][4:0];//5 data_weight each weight with 7 bitwdith
  reg signed [7:0] data_weights1[4:0][24:0];//first bracket is rows ( number of neurons in second layer) 
  reg signed [7:0] data_bias1[4:0];//this has 4 rows
  reg signed [7:0] data_bias2 [1:0];
  reg [15:0] b2;
  reg [width*10-1:0] w2;//5*8-1
  reg [width*5*25-1:0] w1;
  reg [width*5-1:0] b1;
  reg [24:0] p;//input of pixels  
  reg [7:0] count;
  reg R;  reg clk1, clk, pulse;
  wire [1:0] spike;
  integer i,j,count_spike0=0,count_spike1=0,loop_counter=0,pixel_i, spike_file,label;
  real Theoretical_sum=0;
  
//  para [114:0] pixel_name="D:/Users/Admin/Documents/Hasan Sir/Verilog Code/Layer1and2_Testing_24th_March/Testing_Combined_25thMarch/pixel.txt";
  integer w1_file, w2_file, b1_file, b2_file;
 Layer1_Layer2 layer_one_and_2(.spk_out_layer2(spike),.clk(clk),.pulse(pulse),.reset(R),.bias_for1(b1),.bias_for2(b2),.total_pixel(p),.weights_for1(w1),.weights_for2(w2));
   initial
       begin 
        R<=1'b1;clk<=1; count=0;
       //Reading of data from files
spike_file=$fopen("D:/Users/Admin/Documents/Hasan Sir/Verilog Code/Layer1and2_Testing_24th_March/Testing_Combined_25thMarch/generated_spike1.csv","w");
w1_file=$fopen("D:/Users/Admin/Documents/Hasan Sir/Verilog Code/Layer1and2_Testing_24th_March/Testing_Combined_25thMarch/Weight1_Quantized.csv","w");
w2_file=$fopen("D:/Users/Admin/Documents/Hasan Sir/Verilog Code/Layer1and2_Testing_24th_March/Testing_Combined_25thMarch/Weigh2_Quantized.csv","w");
b1_file=$fopen("D:/Users/Admin/Documents/Hasan Sir/Verilog Code/Layer1and2_Testing_24th_March/Testing_Combined_25thMarch/Bias1_Quantized.csv","w");
b2_file=$fopen("D:/Users/Admin/Documents/Hasan Sir/Verilog Code/Layer1and2_Testing_24th_March/Testing_Combined_25thMarch/Bias2_Quantized.csv","w");
            $readmemb("D:/Users/Admin/Documents/Hasan Sir/Verilog Code/Layer1and2_Testing_24th_March/Testing_Combined_25thMarch/W2_q.txt",data_weights2);
            $readmemb("D:/Users/Admin/Documents/Hasan Sir/Verilog Code/Layer1and2_Testing_24th_March/Testing_Combined_25thMarch/W1_q.txt",data_weights1);
         //   $readmemb("D:/Users/Admin/Documents/Hasan Sir/Verilog Code/ReadingFiles/weight.txt",weights);
            $readmemb("D:/Users/Admin/Documents/Hasan Sir/Verilog Code/Layer1and2_Testing_24th_March/Testing_Combined_25thMarch/pixel _all.txt",data_pixels);//change this to where the weight are stored in binary as Qpoint
            $readmemb("D:/Users/Admin/Documents/Hasan Sir/Verilog Code/Layer1and2_Testing_24th_March/Testing_Combined_25thMarch/B2_q.txt",data_bias2);
            $readmemb("D:/Users/Admin/Documents/Hasan Sir/Verilog Code/Layer1and2_Testing_24th_March/Testing_Combined_25thMarch/B1_q.txt",data_bias1);
         //end of reading from files   
         
            for (i=0; i<5; i=i+1)
                begin
                b1[width*i+:width]=data_bias1[i];
                $display("b1[%0d] = %0f",i,$signed(b1[width*i+:width])*SF);   
                $fwrite(b1_file, "%0f\n,",$signed(b1[width*i+:width])*SF);
                for(j=0;j<25;j=j+1)
                    begin
                    p[j]=data_pixels[j];
                    w1[width*(25*i+j)+:width]=data_weights1[i][j];
                    $display("w1[%0d][%0d] = %0f",i,j,$signed(w1[width*(25*i+j)+:width])*SF); 
                    $fwrite(w1_file, "%0f,",$signed(w1[width*(25*i+j)+:width])*SF);
                    end
                    $fwrite(w1_file, "\n");
                end
                
            for (i=0; i<2; i=i+1)
                begin
                b2[width*i+:width]=data_bias2[i];
                $display("b2[%0d] = %0f",i,$signed(b2[width*i+:width])*SF);   
                 $fwrite(b2_file, "%0f\n,",$signed(b2[width*i+:width])*SF);
                    for(j=0;j<5;j=j+1)
                    begin
                       w2[width*(5*i+j)+:width]=data_weights2[i][j];
                        $display("w2[%0d][%0d] = %0f",i,j,$signed(w2[width*(5*i+j)+:width])*SF);  
                        $fwrite(w2_file, "%0f,",$signed(w2[width*(5*i+j)+:width])*SF); 
                    end
                    $fwrite(w2_file, "\n");
                 end
                 //initial end
     end
  always #5 pulse<= ~pulse;
  always  #10 clk1<= ~clk1;
  always #1 clk<=clk1;  
  
always
 begin
 //The time for one input simulation is 29+300+1 =330; 
    #29 R<=0;
    #(time_units*20+1) R<=1;
end

initial
    begin
      clk1<=1'b0;
      clk<=1'b0;
      pulse<=1'b0;
      R<=1'b1;
//      $display("Output of Spike 0 is %0d and Spike 1 is %0d",count_spike0,count_spike1);
    end
    
    initial
    begin
     #(((time_units*20+30)*examples)+2)
      $fclose(w1_file);$fclose(w2_file);$fclose(b1_file);$fclose(b2_file);$fclose(spike_file);
      $finish;
    end
    
   always @(posedge clk)
   begin
   if((R==0) & spike[0]==1)
   begin
   count_spike0=count_spike0+1;
   end
   end
   
   
   always @(posedge clk)
   begin
   if((R==0) & spike[1]==1)
   begin
   count_spike1=count_spike1+1;
   end
   end
   
   always
   begin
         for(pixel_i=0;pixel_i<25;pixel_i=pixel_i+1)
         begin
         p[pixel_i]=data_pixels[pixel_i+loop_counter*25];
         $display("index is %0d p[%0d] = %0d",pixel_i+loop_counter*25,pixel_i,p[pixel_i]);  
//       $display("input data pixel at %0d is %0f ",pixel_i+loop_counter*25,data_pixels[pixel_i+loop_counter*25]); 
         end
         loop_counter=loop_counter+1;
         $display("%0d",loop_counter);  
         #(time_units*20+30);
         label=count_spike0<count_spike1;
          //$fwrite(spike_file, "%0d, %0d \n",count_spike0, count_spike1); 
            $fwrite(spike_file, "%0d\n",label); 
         count_spike0=0;count_spike1=0;
   end
   
endmodule
