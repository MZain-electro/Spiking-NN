%Coded(size(Weight1,1))
  
  %weigth 1
a=0;%only one signed bit
b=7;%7 fractional bits
%%change 0000000 to number of bits if Q1.7=>1+7=8
%change variable name to whatever is you want to convert
var_name='Weight1';
Output=repmat('000000000',[size(Weight1,2),1,size(Weight1,1)]);
for i=1:size(Weight1,1)
    temp_weight=Weight1(i,:)';
    verilog_format(qpoint(temp_weight,a,b,'bin'),a,b)Output2_Bias=repmat('000000000',[size(Bias2,2),1,size(Bias2,1)]);
for i=1:size(Bias2,1)
    temp_weight=Bias2(i,:)';
    verilog_format(qpoint(temp_weight,a,b,'bin'),a,b)
    Output2_Bias(:,:,i)=verilog_format(qpoint(temp_weight,a,b,'bin'),a,b);
end
    Output(:,:,i)=verilog_format(qpoint(temp_weight,a,b,'bin'),a,b);
end

%weight 2
Output2=repmat('000000000',[size(Weight2,2),1,size(Weight2,1)]);
for i=1:size(Weight2,1)
    temp_weight=Weight2(i,:)';
    verilog_format(qpoint(temp_weight,a,b,'bin'),a,b)
    Output2(:,:,i)=verilog_format(qpoint(temp_weight,a,b,'bin'),a,b);
end
%Bias 1
Output1_Bias=repmat('000000000',[size(Bias1,2),1,size(Bias1,1)]);
for i=1:size(Bias1,1)
    temp_weight=Bias1(i,:)';
    verilog_format(qpoint(temp_weight,a,b,'bin'),a,b)
    Output1_Bias(:,:,i)=verilog_format(qpoint(temp_weight,a,b,'bin'),a,b);
end

%%BIAS 2
Output2_Bias=repmat('000000000',[size(Bias2,2),1,size(Bias2,1)]);
for i=1:size(Bias2,1)
    temp_weight=Bias2(i,:)';
    verilog_format(qpoint(temp_weight,a,b,'bin'),a,b)
    Output2_Bias(:,:,i)=verilog_format(qpoint(temp_weight,a,b,'bin'),a,b);
end

