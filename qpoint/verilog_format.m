function y = verilog_format(x,a,b)
%a=number of bits before the decimal point without including the 
%the sign bit
%b is number of bits after
%y=blanks(length(x),a+b+2);
for i=1:size(x,1)
y(i,1:a+1)=x(i,1:a+1);
y(i,a+2)='_';
y(i,a+3:a+b+2)=x(i,a+2:a+b+1);
end


%%%%note that the input should always be in column vector
