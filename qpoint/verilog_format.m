function y = verilog_format(x,a,b)
%a=number of bits before the decimal point without including the 
%the sign bit
%b is number of bits after the decimal
y=blanks(a+b+2);
y(1:a+1)=x(1:a+1);
y(a+2)='_';
y(a+3:a+b+2)=x(a+2:a+b+1);
