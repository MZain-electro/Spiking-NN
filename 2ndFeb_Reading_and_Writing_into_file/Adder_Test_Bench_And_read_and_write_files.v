`timescale 1ns / 1ps
module fixedtest();
    reg signed [7:0] a, b;//8 bit numbers to be added
    reg signed [7:0] w [124:0];
    wire signed [8:0] c;
    integer i;
    integer real_values[0:124];
    localparam SF = 2.0**-7.0;  // Q4.4 scaling factor is 2^-4
 
  integer file;
 Qpoint_Adder #(.OUT_WIDTH(9), .INP_WIDTH(8)) DUT (c,a,b);
    initial begin
      
$readmemb("D:/Users/Admin/Documents/Hasan Sir/Verilog Code/QpointAdder/Qpoint_W1.txt",w);//change this to where the weight are stored in binary as Qpoint
file=$fopen("D:/Users/Admin/Documents/Hasan Sir/Verilog Code/QpointAdder/New_Output.txt","w");//output of the Qpoint

   if (file)  $display("File was opened successfully : %0d", file);
    else       $display("File was NOT opened successfully : %0d", file);
    
       #5 a = 8'b0011_1010;  // 3.6250
        b = 8'b0100_0001;  // 4.0625
        for(i=0;i<124;i=i+1)
        begin
       #5 $display("%f \n", w[i]*SF);
        $fwrite(file,"%f \n",$itor(w[i]*SF));
   
       end
       //#5 $display("%f + %f = %f", $itor(a*SF), $itor(b*SF), $itor(c*SF));
    $fdisplay(file);
    $fclose(file);
  
    end
endmodule
