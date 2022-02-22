`timescale 1ns / 1ps

module NCHU(input [7:0] mac_out, output spk_out);
    parameter threshold = 8'b0_11001101, one = 8'b1_1111111, One = 1'b1;
    adder ADD (.out(add_out), .a(shift), .b(mac_out));
    Sub SUB (.reg_pre(acc_out),.thresh(threshold),.sub_out(sub_out));
    T_FF FF(.q(q),.t(one));
    mux MUX (.In_FF(q),.add(add_out),.sub(sub_out),.mux_out(Mux_out));
    acc Acc (.OUT(acc_out), .mux_out(Mux_out),.shifted(shift));
    Comparator_and_DFF Comp (.Din(acc_out),.threshold(threshold),.spike(spk_out));
endmodule

////////D Flip Flop////////
module D_FF(input signed [7:0]Din,input clk,input clear,output reg signed [7:0] Q);

always@(posedge clk)
    begin
    if(clear)// operateds at clear =1
        Q<=0;
    else
        Q<=Din;
    end
endmodule

////////////Comparator with D_FF/////////
module Comparator_and_DFF(input signed [7:0] Din,input clk,input clear, input signed [7:0] threshold,output spike);
    wire [7:0] output_d;
    D_FF d_flip_flop(Din,clk,clear,output_d);
    comp compare(.acc_out(output_d),.threshold(threshold),.spk(spike));
endmodule

////////////Comparator/////////
module comp(input [7:0] acc_out, input signed [7:0] threshold, output spk,wire signed [7:0] sub, wire less, wire greater, wire equal);
    assign sub = acc_out - threshold;
    nor(equal, sub[0], sub[1], sub[2], sub[3], sub[4], sub[5], sub[6], sub[7]);
    assign less = sub[7];
    nor(greater, less, equal);
    or(f_out, equal, greater);
    or(spk, equal, greater);
endmodule

//////ACC/////////
module acc(output reg signed [7:0]OUT, input clk, input rst, 
input signed [7:0] mux_out, output wire signed [7:0] shifted
    );
    
  reg [21:0] accReg;
    
  always @(posedge clk) begin
    if (rst) OUT<= 0;
    else
        OUT <= mux_out;
  end
  
  assign shifted = (mux_out>>>1) + (mux_out>>>2);  

 endmodule
 
 //////////T Flip Flop/////////////
 module T_FF (input clk, input rst, input t,output reg q); 

  always @ (posedge clk) begin  
    if (!rst)  
      q <= 0;  
    else  
        if (t)  
            q <= ~q;  
        else  
            q <= q;  
  end  
endmodule

//////////Adder/////////////
module adder(out, a,b);
    
    parameter OUT_WIDTH= 1;
    parameter INP_WIDTH= 1;
    input signed [INP_WIDTH-1:0] a; // [n,q]
    input signed [INP_WIDTH-1:0] b; // [p,q]
    output signed [OUT_WIDTH-1:0] out; // [max(n+p)+1,q]
    wire signed [OUT_WIDTH-1:0] a_ext = {a[INP_WIDTH-1],a};
    wire signed [OUT_WIDTH-1:0] b_ext = {b[INP_WIDTH-1],b};
    assign out = a_ext + b_ext;
    
endmodule

////////////Subtractor/////////////
module Sub(input [7:0] reg_pre, input signed [7:0] thresh, output signed [7:0] sub_out);
    
    assign sub_out = thresh - reg_pre;
endmodule


////////////MUX/////////////
module mux(input In_FF, input [7:0]add, input [7:0]sub, output [7:0]mux_out);
    
    assign mux_out = (In_FF)?(sub):(add); 
    
endmodule

////////////Shift-adder//////////
module Shift_adder(input signed [7:0] last_mem, input signed [7:0] mac_out, output signed [7:0] shift_out);
wire [7:0 ]RC_decay;
    assign RC_decay = (last_mem>>>1) + (last_mem>>>2);
   
    initial begin
    $display("RC_decay= %b",RC_decay);  
    end
       adder #(.OUT_WIDTH(8), .INP_WIDTH(8)) adder1(shift_out,mac_out,RC_decay);  
  //  assign shift_out = mac_out + RC_decay; 
endmodule
