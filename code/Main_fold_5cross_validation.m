function Main_fold_5cross_validation()
clear;
data=xlsread('..\data\landmarkDataSets.xlsx','featuresAttributes');  % read the attributes of landmarks
data=gpscale(data); %normalization
rank=xlsread('..\data\landmarkDataSets.xlsx','questionnairesResult');  % 读取比例排序
sum_end=0;
runnum=5;
dataset=cell(200,2);
testrank=cell(5,2);
top1result=zeros(5,4);
sortresult=zeros(5,4);
zhang_evalstr='2*(x1+x2+x3+x4+x5)+x6+x7+x8+x9+x10+x11+x12+x13+x14';  %Vir 0.5, Semi 0.25, Stru 0.25
hao_evalstr='x1+x2+x3+x4+x5+x6+x7+x8+x9+x10+x11+x12+x13+x14';  %Vir 1, Semi 1, Stru 1
for j=1:size(rank,1)
    one_rank=rmmissing(rank(j,:));  % 获得一个场景的排序并去掉空值
    n=size(one_rank,2);
    sum_end=sum_end+n;
    sum_bef=sum_end-n+1;
    rank_data=data(sum_bef:sum_end,:);
    dataset{j,1}=rank_data;
    dataset{j,2}=rank(j,:);
end
save('5fold_crass\data\dataset','dataset');
indices = crossvalind('Kfold', 200, 5);
for i = 1 : 5
    % 获取第i份测试数据的索引逻辑值
    test = (indices == i);
    % 取反，获取第i份训练和验证数据的索引逻辑值
    temp_train = ~test;
         % 获取验证数据
        indices2 = crossvalind('Kfold',sum(temp_train~=0) , 5);
         % 随机获取验证数据的索引逻辑值
        valid=(indices2==randperm(5,1));
         % 取反，获取第i份训练数据的索引逻辑值
        train=~valid;

    test_porp = cell2mat(dataset(test,1));
    test_rank = cell2mat(dataset(test,2));
    
    train_porp = cell2mat(dataset(train,1));
    train_rank = cell2mat(dataset(train,2));
    
    val_porp = cell2mat(dataset(valid,1));
    val_rank = cell2mat(dataset(valid,2));
    
    save (['5fold_crass\data\Fold',num2str(i),'test_porp'],'test_porp');
    save (['5fold_crass\data\Fold',num2str(i),'test_rank'],'test_rank');
    save (['5fold_crass\data\Fold',num2str(i),'train_porp'],'train_porp');
    save (['5fold_crass\data\Fold',num2str(i),'train_rank'],'train_rank');
    save (['5fold_crass\data\Fold',num2str(i),'val_porp'],'val_porp');
    save (['5fold_crass\data\Fold',num2str(i),'val_rank'],'val_rank');
    %多种方法测试
    disp(['第',num2str(i),'折/共',num2str(5),'折:']);
    disp('运行GP方法：');
    [gp_pre_data,gp_top1,gp_sort,gp_evalstr,gp,runnum,gptoc,valid_acc]=GP(runnum,i,train_porp,train_rank,test_porp,test_rank,val_porp,val_rank);
    disp('运行传统Zhang方法：');
    [zhang_pre_data, zhang_top1,zhang_sort,timesum1]=test_tran_accuracy(zhang_evalstr,test_rank,test_porp,i);
    disp('运行传统Hao方法：');
    [hao_pre_data,hao_top1,hao_sort,timesum2]=test_tran_accuracy(hao_evalstr,test_rank,test_porp,i);
    disp('运行SVM方法：');
    [svm_pre_data,svm_top1,svm_sort,svm_evalstr,timesum3]=run_SVM(train_porp,train_rank,test_porp,test_rank,val_porp,val_rank,i);
    disp('----------------------------------------');
    %生成结果文件
    build_predata_doc(gp_pre_data,zhang_pre_data,hao_pre_data,svm_pre_data{1,1},i);
    save(['5fold_crass\Fold',num2str(i),'gp_pre_data'],'gp_pre_data');
    disp('开始创建排序文件：');
    [preranks]=build_rank_doc(test_rank,gp_pre_data,gp_top1,gp_sort,gp_evalstr,gp,runnum,i,gptoc,valid_acc, ...
    zhang_pre_data, zhang_top1,zhang_sort,zhang_evalstr,hao_pre_data,hao_top1,hao_sort,hao_evalstr,svm_pre_data{1,1},svm_top1,svm_sort,svm_evalstr,timesum1,timesum2,timesum3);
    top1result(i,:)=[gp_top1,zhang_top1,hao_top1,svm_top1];
    sortresult(i,:)=[gp_sort,zhang_sort,hao_sort,svm_sort];
    testrank{i,1}=test_rank;
    testrank{i,2}=preranks;
end
save('5fold_crass\range_TOP1_data','top1result');
save('5fold_crass\range_Sort_data','sortresult');
save('5fold_crass\testrank','testrank');
build_result_doc(top1result,sortresult,runnum);
[zus,sort_and_top]=landmark_range();
save('5fold_crass\sort_and_top','sort_and_top');
save('5fold_crass\zus','zus');
[Proportion]=build_Range_doc(zus,sort_and_top);
draw_plot(Proportion);
end
