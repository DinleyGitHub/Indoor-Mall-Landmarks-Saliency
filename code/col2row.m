% 

function zus1=col2row(x,rows)
load('5fold_crass\range_TOP1_data','top1result');
load('5fold_crass\range_Sort_data','sortresult');
sum_end=0;
sum_end2=0;
a=size(rows,1);
cols=cell(a,3);
%对应上预测数据和真实数据
for i=1:a
   onex=rmmissing(rows(i,:));
   n=size(onex,2);
   sum_end=sum_end+n;
   sum_bef=sum_end-n+1;
   col=x(sum_bef:sum_end,1);
   cols{i,1}=(col)';
   cols{i,2}=max(onex);
   cols{i,3}=onex;
end


% 划分范围
[maxmat,id]=sort(cell2mat(cols(:,2)));
b=a/5;
zus=cell(b,1);
for j=1:5
   sum_end2=sum_end2+b;
   sum_bef2=sum_end2-b+1;
   zus{j,1}=maxmat(sum_bef2:sum_end2,1); 
end
zus1=cell2mat(zus);






end