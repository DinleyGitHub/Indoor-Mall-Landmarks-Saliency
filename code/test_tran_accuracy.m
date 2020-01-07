function [predict_data,most_accuracy,all_accuracy,timesum]=test_tran_accuracy(evalstr,rank_data,porp_data,n)

tic;
porp=porp_data; %gp.userdata.xval;
pat = 'x(\d+)';

evalstr1 = regexprep(evalstr,pat,'porp(:,$1)');
geneOutputs ={};
eval(['geneOutputs=' evalstr1 ';']);

%data=gp.userdata.test_rank;
data=rank_data;
predict_data=geneOutputs(:,1);
i = isinf(predict_data); %把无穷大变成0
predict_data(i) = 0;
j = isnan(predict_data); %把空变成0
predict_data(j) = 0;
%get accuracy
 [most_accuracy,all_accuracy]=cal_rank_accuracy(data,predict_data);
 timesum=toc;
end
 








% %get rank
% sum_end=0;most=0;rank_sort=0;
% fid=fopen(['5GP_test\testgp_rank_fold',num2str(n),'.dat'],'w');
% %fid=fopen(['Tran_test\tran_rank',num2str(n),'.dat'],'w');
% fprintf(fid,'%s\n',['Predict','        ','True']);
% rows=size(data,1);
% for i=1:rows
%     one_rank=rmmissing(data(i,:));  % 获得一个场景的排序并去掉空值
%     n=size(one_rank,2);
%     sum_end=sum_end+n;
%     sum_bef=sum_end-n+1;
%     rank_data=predict_data(sum_bef:sum_end,:);
%     [sort_rank_data,id1]=sort(rank_data,'descend'); %从大到小排列之前的位置
%     [big_rank,id3]=sort(one_rank,'descend'); %从大到小排列之前的位置
%     %巧妙避免重复数据
%     [sort_rank_data,id2]=sort(sort_rank_data,'descend'); %从大到小排列现在的位置
%     big_sort_rank_data=sort_rank_data+sort(id2,'descend'); %同一位置放大
%     M1=containers.Map([1,2,3,4],{'A','B','C','D'});
%     M2 = containers.Map(big_sort_rank_data,id1);
%     M3=containers.Map(big_rank,id3);
%     rank=cell(1,n);
%     orank=cell(1,n);
%     for k=1:n  %把计算的值换成1,2,3,4
%         rank{1,k}=M1(M2(big_sort_rank_data(k,:)));
%         m=M3(big_rank(1,k));
%         orank{1,k}=M1(m);
%     end
%     
%     if rank{1,1}==orank{1,1}
%         most=most+1;
%     end
%     
%     if rank{1,1}==orank{1,1}&&rank{1,2}==orank{1,2}&&rank{1,3}==orank{1,3}
%         rank_sort=rank_sort+1;
%     end
%     
%     out_rank=[rank{1,:},'      ',orank{1,:}];
%     fprintf(fid,'%s\n',out_rank);
% end
% fprintf(fid,'%s\n','-------------------------------------');
% %fprintf(fid,'%s\n',['Tradition Fitness Value:',num2str(TestFitness)]);
% fprintf(fid,'%s\n',['TOP1:',num2str(most_accuracy)]);
% fprintf(fid,'%s\n',['SORT:',num2str(all_accuracy)]);
% fprintf(fid,'%s\n',['Same landmarks num:     ',num2str(rank_sort),'/',num2str(rows)]);
% fprintf(fid,'%s\n',['Most salience landmark num:     ',num2str(most),'/',num2str(rows)]);
% fprintf(fid,'%s\n','Model:');
% fprintf(fid,'%s\n',evalstr);
% toc;
% fprintf(fid,'%s\n',['GP耗时: ' num2str(toc)]);
% fclose(fid);
% disp('传统方法生成排序对比文件成功！！！！')

