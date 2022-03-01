`timescale 1ns / 1ps

module NCHU(input [7:0] mac_out, output spk_out, input clk, input pulse, input reset);
  wire signed [7:0] add_out;
  wire signed [7:0] sub_out;
  wire signed [7:0] Mux_out;
  wire signed [7:0] acc_out; 
  wire signed [7:0] shift; 
  
    parameter threshold = 8'd2,one=1'b1, TT = 8'd2;
    adder ADD (.add_out(add_out), .a(shift), .b(mac_out));
    Sub SUB (.reg_pre(acc_out),.thresh(TT),.sub_out(sub_out));
   T_FF FF(.q(q),.t(one),.rst(reset),.clk(pulse));
  mux MUX (.In_FF(q),.add(add_out),.sub(sub_out),.mux_out(Mux_out));
  acc Acc (.OUT(acc_out), .mux_out(Mux_out),.shifted(shift),.rst(reset),.clk(clk),.pul(pulse),.spk(spk_out));
    Comparator_and_DFF Comp (.Din(acc_out),.threshold(TT),.spike(spk_out),.clk(clk),.rst(reset));
endmodule


////////////MUX/////////////
module mux(input In_FF, input [7:0]add, input [7:0]sub, output [7:0]mux_out);
    
    assign mux_out = (In_FF)?(sub):(add); 
    
endmodule

////////D Flip Flop////////
module D_FF(input signed [7:0]Din,input clk,input rst,output reg signed [7:0] Q);

always@(posedge clk)
    begin
    if(rst)// operateds at clear =1
        Q<=0;
    else
        Q<=Din;
    end
endmodule

////////////Comparator with D_FF/////////
module Comparator_and_DFF(input signed [7:0] Din,input clk,input rst, input signed [7:0] threshold,output spike);
    wire [7:0] output_d;
    D_FF d_flip_flop(Din,clk,rst,output_d);
    comp compare(.acc_out(output_d),.threshold(threshold),.spk(spike));
endmodule

////////////Comparator/////////
module comp(input [7:0] acc_out, input signed [7:0] threshold, output spk);
  wire signed [7:0] sub;
  wire less;
  wire greater; wire equal;
    assign sub = acc_out - threshold;
    nor(equal, sub[0], sub[1], sub[2], sub[3], sub[4], sub[5], sub[6], sub[7]);
    assign less = sub[7];
    nor(greater, less, equal);
    or(f_out, equal, greater);
    or(spk, equal, greater);
endmodule

//////ACC/////////
module acc(output reg signed [7:0]OUT, input clk, input rst, input signed [7:0] mux_out, output wire signed [7:0] shifted, input pul, input spk);
    
  reg [21:0] accReg;
    
  always @(posedge pul) 
    begin
      
    if (rst) OUT<= 0;
    else
      begin
    if (clk == 1)
        OUT <= mux_out;
    else if(clk == 0 && spk == 1)
        OUT <= mux_out;
    end
      
  end
  assign shifted = (OUT>>>1) + (OUT>>>2);  

 endmodule
 
 //////////T Flip Flop/////////////
 module T_FF (input clk, input rst, input t,output reg q); ///if Reset =1, T_FF is reseated to 0

  always @ (negedge clk) begin  
    if (rst)  
      q <= 0;  
    else  
        if (t)  
            q <= ~q;  
        else  
            q <= q;  
  end  
endmodule

//////////Adder/////////////
module adder(add_out, a,b);
    
    parameter OUT_WIDTH= 8;
    parameter INP_WIDTH= 8;
    input signed [INP_WIDTH-1:0] a; // [n,q]
    input signed [INP_WIDTH-1:0] b; // [p,q]
    output signed [OUT_WIDTH-1:0] add_out; // [max(n+p)+1,q]
    wire signed [OUT_WIDTH-1:0] a_ext = {a[INP_WIDTH-1],a};
    wire signed [OUT_WIDTH-1:0] b_ext = {b[INP_WIDTH-1],b};
  assign add_out = a + b;
    
endmodule

////////////Subtractor/////////////
module Sub(input [7:0] thresh, input signed [7:0] reg_pre,output signed [7:0] sub_out);
    
    assign sub_out = reg_pre - thresh;
endmodule
