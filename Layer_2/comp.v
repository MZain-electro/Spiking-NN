`timescale 1ns / 1ps

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