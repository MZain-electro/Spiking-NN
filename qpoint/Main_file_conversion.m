%Coded(size(Weight1,1))
a=0;%only one signed bit
b=7;%7 fractional bits
%%change 0000000 to number of bits if Q1.7=>1+7=8 plus 1 due to _
%change variable name to whatever is you want to convert
var_name='Weight1';
Weight1=[-0.23060082,0.6231102];
Output=repmat('000000000',[size(Weight1,2),1,size(Weight1,1)]);
for i=1:size(Weight1,1)
    temp_weight=Weight1(i,:)';
    verilog_format(qpoint(temp_weight,a,b,'bin'),a,b)
    Output(:,:,i)=verilog_format(qpoint(temp_weight,a,b,'bin'),a,b);
end
