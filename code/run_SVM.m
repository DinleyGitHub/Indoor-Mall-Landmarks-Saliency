function [svm_pre_data,svm_top1,svm_sort,svm_evalstr,timesum]=run_SVM(train_porp,train_rank,test_porp,test_rank,val_porp,val_rank,n)
tic;
data=[train_porp;val_porp];
rank=[train_rank;val_rank];
nameStr1=['SVM_test_data\5FoldSVMtrain',num2str(n),'.dat'];
nameStr2=['SVM_test_data\5FoldSVMtest',num2str(n),'.dat'];

build_SVM_dat(data,rank,nameStr1)
build_SVM_dat(test_porp,test_rank,nameStr2)

mycmd1=['svm_rank_learn -c 3 SVM_test_data\5FoldSVMtrain',num2str(n),'.dat', ' SVM_test_data\5FoldSVMmodel',num2str(n),'.dat'];
system(mycmd1);
mycmd2=['svm_rank_classify SVM_test_data\5FoldSVMtest',num2str(n),'.dat',' SVM_test_data\5FoldSVMmodel',num2str(n),'.dat',' SVM_test_data\5FoldSVMpredictions',num2str(n),'.dat'];
system(mycmd2);

fid1=fopen(['SVM_test_data\5FoldSVMpredictions',num2str(n),'.dat'],'r');
svm_pre_data=textscan(fid1,'%f');
svm_evalstr=[' SVM_test_data\5FoldSVMmodel',num2str(n),'.dat'];
[svm_top1,svm_sort]=predict_rank(svm_pre_data,test_rank);
timesum=toc;
end


function [svm_top1,svm_sort]=predict_rank(svm_pre_data,test_rank)
predict_data=svm_pre_data{1};
sum=0;most=0;rank_sort=0;
rows=size(test_rank,1);
for i=1:rows
    one_test=rmmissing(test_rank(i,:));
    a=numel(one_test);
    sum=sum+a;
    one_rank=predict_data(sum-a+1:sum,:);
    [big_one_rank,id]=sort(one_rank,'descend');
    [big_test_rank,id2]=sort(one_test,'descend');
    %big_big_one_rank=sort(big_one_rank)+sort(id,'descend');
%     M1=containers.Map(big_big_one_rank,a:-1:1);
    M2=containers.Map([1,2,3,4],{'A','B','C','D'});
    out=cell(1,a);
    test_out=cell(1,a);
    for j=1:a
        m2=M2(id(j));
        out{1,j}=m2;
        
        m1=M2(id2(j));
        test_out{1,j}=m1;
    end
    
    if out{1,1}==test_out{1,1}
        most=most+1;
    end
    
    if out{1,1}==test_out{1,1}&&out{1,2}==test_out{1,2}&&out{1,3}==test_out{1,3}
        rank_sort=rank_sort+1;
    end
    
end

svm_top1=most/rows;
svm_sort=rank_sort/rows;

end