// Code your design here
module ALU (X, Y, Z, Sign, Zero, Carry, Parity, Overflow);
  input signed [15:0] X, Y;
  output signed [15:0] Z;
 output Sign, Zero, Carry, Parity, Overflow;


 assign {Carry, Z} = X + Y; // 16-bit addition
  assign Sign = Z[15];
 assign Zero = ~|Z; // ~| is NOR
 assign Parity = ~^Z; // ~^ is XNOR
  assign Overflow = (X[15] & Y[15] & ~Z[15])|(~X[15] & ~Y[15] & Z[15]);
endmodule
