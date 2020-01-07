function [train_porp,train_rank,test_porp,test_rank,val_porp,val_rank]=cross_validation(n)

crossValidation=5;
num=200/crossValidation;
data=xlsread('..\data\landmarkDataSets.xlsx','featuresAttributes');  % 读取属性特征值
data=gpscale(data); %归一化或标准化
rank=xlsread('..\data\landmarkDataSets.xlsx','questionnairesResult');  % 读取比例排序

b=(n-1)*num+1;
if n<5
c=n*num;
else
c=197;
end

group_rank=rank(b:c,:);
test_rank=group_rank;
test_porp=data(numel(one_col(rank(1:b-1,:)))+1:numel(one_col(rank(1:c,:))),:);

data(numel(one_col(rank(1:b-1,:)))+1:numel(one_col(rank(1:c,:))),:)=[];
rank(b:c,:)=[];

remain_rank=rank;
remain_data=data;

a=round(size(remain_rank,1)*0.75);
train_rank=remain_rank(1:a,:);
train_porp=remain_data(1:numel(one_col(train_rank)),:);

val_rank=remain_rank(a+1:end,:);
val_porp=remain_data(numel(one_col(train_rank))+1:end,:);

end





