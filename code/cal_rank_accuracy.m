function [most_accuracy,all_accuracy]=cal_rank_accuracy(data,predict_data)
sum=0;
most=0;
rank_sort=0;
rows=size(data,1);

for i=1:rows
    one_test=rmmissing(data(i,:));
    a=numel(one_test);
    sum=sum+a;
    one_rank=predict_data(sum-a+1:sum,:);
    [big_one_rank,id]=sort(one_rank,'descend');
    [big_test_rank,id2]=sort(one_test,'descend');
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

most_accuracy=most/rows;
all_accuracy=rank_sort/rows;

end