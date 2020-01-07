
clc;
%output=sigmoid1(0.00000005);%15 E
output=sigmoid1(0.0000000002);%16 F
%output=sigmoid1(5);%3 A
%output=sigmoid1(5);%4 B
%output=sigmoid1(5);%5 C
%output=sigmoid1(0.5);%6 D
disp('completed!!!!!!');

function [output]=sigmoid1(k)
train=xlsread('F:\02-thesis\NLandmarkM\属性特征提取标准化.xlsx','Sheet2');
one=train(:,16);
MAX=max(one);
x=linspace(-MAX,MAX);
A =1./(1+exp(-k*x));
plot(x,A)
output =1./(1+exp(-k*one));
%D={'X13',output};
xlswrite('F:\02-thesis\NLandmarkM\属性特征提取标准化.xlsx',output,'Sheet3','F');

end


