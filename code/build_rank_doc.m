function [preranks]=build_rank_doc(true_data,gp_pre_data,gp_top1,gp_sort,gp_evalstr,gp,runnum,j,gptoc,valid_acc, ...
    zhang_pre_data, zhang_top1,zhang_sort,zhang_evalstr,hao_pre_data,hao_top1,hao_sort,hao_evalstr,svm_pre_data,svm_top1,svm_sort,svm_evalstr,timesum1,timesum2,timesum3)

sum_end=0;most=0;rank_sort=0;
fid=fopen(['5fold_crass\Run',num2str(runnum),'_Rank_Doc_fold',num2str(j),'.dat'],'w');
fprintf(fid,'%s\n',['GP','     ','Zhangxing','     ','Hao','     ','SVM','     ','True']);
rows=size(true_data,1);
preranks=cell(rows,1);
gptop1_most=0;gpsort_rank=0; zhtop1_most=0;zhsort_rank=0; hatop1_most=0;hasort_rank=0; svmtop1_most=0;svmsort_rank=0;
for i=1:rows
    %disp(['正在创建第',num2sr(i),'行！'])
    true_one_rank=rmmissing(true_data(i,:));  % 获得一个场景的排序并去掉空值
    n=size(true_one_rank,2);
    sum_end=sum_end+n;
    sum_bef=sum_end-n+1;
    [sort_true_one_rank,id3]=sort(true_one_rank,'descend'); %从大到小排列之前的位置
    %巧妙避免重复数据
    [sort_true_one_rank,id4]=sort(sort_true_one_rank,'descend'); %从大到小排列现在的位置
    big_sort_true_one_rank=sort_true_one_rank+sort(id4,'descend'); %同一位置放大
    M1=containers.Map([1,2,3,4],{'A','B','C','D'});
    M3=containers.Map(big_sort_true_one_rank,id3);
    orank=cell(1,n);
    for k=1:n  %把计算的值换成1,2,3,4
        m=M3(big_sort_true_one_rank(1,k));
        orank{1,k}=M1(m);
    end
    
    [gp_rank,gp_most,gp_rank_sort,pre_rank1]=pre_rank(gp_pre_data,sum_bef,sum_end,orank,n,M1,gptop1_most,gpsort_rank);
    gptop1_most=gp_most;  gpsort_rank=gp_rank_sort;
    [zhang_rank,zhang_most,zhang_rank_sort,~]=pre_rank(zhang_pre_data,sum_bef,sum_end,orank,n,M1,zhtop1_most,zhsort_rank);
    zhtop1_most=zhang_most;  zhsort_rank=zhang_rank_sort;
    [hao_rank,hao_most,hao_rank_sort,~]=pre_rank(hao_pre_data,sum_bef,sum_end,orank,n,M1,hatop1_most,hasort_rank);
    hatop1_most=hao_most;  hasort_rank=hao_rank_sort;
    [svm_rank,svm_most,svm_rank_sort,~]=pre_rank(svm_pre_data,sum_bef,sum_end,orank,n,M1,svmtop1_most,svmsort_rank);
    svmtop1_most=svm_most;  svmsort_rank=svm_rank_sort;
    preranks{i,1}=pre_rank1;
    out_rank=[gp_rank{1,:},'      ',zhang_rank{1,:},'      ',hao_rank{1,:},'      ',svm_rank{1,:},'      ',orank{1,:}];
    fprintf(fid,'%s\n',out_rank);
end

fprintf(fid,'%s\n','-----------------------------------------');
%fprintf(fid,'%s\n',['Tradition Fitness Value:',num2str(TestFitness)]);
fprintf(fid,'%s\n',['TOP1:                    ',num2str(gp_top1),'  ',num2str(zhang_top1),'  ',num2str(hao_top1),'  ',num2str(svm_top1)]);
fprintf(fid,'%s\n',['SORT:                    ',num2str(gp_sort),'  ',num2str(zhang_sort),'  ',num2str(hao_sort),'  ',num2str(svm_sort)]);
fprintf(fid,'%s\n',['Most landmarks num:      ',num2str(gp_most),'  ',num2str(zhang_most),'  ',num2str(hao_most),'  ',num2str(svm_most),'  ','/',num2str(rows)]);
fprintf(fid,'%s\n',['Sort landmark num:       ',num2str(gp_rank_sort),'  ',num2str(zhang_rank_sort),'  ',num2str(hao_rank_sort),'  ',num2str(svm_rank_sort),'  ','/',num2str(rows)]);
fprintf(fid,'%s\n',['GP Model:                ',gp_evalstr]);

fprintf(fid,'%s\n',['Zhang Model:             ',zhang_evalstr]);

fprintf(fid,'%s\n',['Hao Model:               ',hao_evalstr]);

fprintf(fid,'%s\n',['SVM Model:               ',svm_evalstr]);

fprintf(fid,'%s\n',['Top1 on validation set:  ' num2str(valid_acc)]);
fprintf(fid,'%s\n',['Time(sec):               ' num2str(gptoc),'   ',num2str(timesum1),'   ',num2str(timesum2),'   ',num2str(timesum3)]);
fprintf(fid,'%s\n','-----------------------------------------');
fprintf(fid,'%s\n','Run parameters');
fprintf(fid,'%s\n',['Population size:         ' int2str(gp.runcontrol.pop_size)]);
fprintf(fid,'%s\n',['Number of generations:   ' int2str(gp.runcontrol.num_gen)]);
fprintf(fid,'%s\n',['Number of runs:          ' int2str(gp.runcontrol.runs)]);
fprintf(fid,'%s\n',['Tournament size:         ' int2str(gp.selection.tournament.size)]);
fprintf(fid,'%s\n',['Elite fraction:          ' num2str(gp.selection.elite_fraction)]);
fprintf(fid,'%s\n',['Max tree depth:          ' int2str(gp.treedef.max_depth)]);
fprintf(fid,'%s\n',['Max nodes per tree:      ' int2str(gp.treedef.max_nodes)]);
fprintf(fid,'%s\n',['Number of inputs:        ' int2str(gp.nodes.inputs.num_inp)]);
fprintf(fid,'%s\n',['Max genes:               ' int2str(gp.genes.max_genes)]);
fprintf(fid,'%s\n',['Constants range:         [' num2str(gp.nodes.const.range) ']']);
fprintf(fid,'%s\n',['GP运行的总次数:          ' num2str(runnum)]);
fclose(fid);
disp('生成排序对比文件成功！！！！')
disp(['MostRank accuracy: ',num2str(gp_top1),'  AllRank accuracy: ',num2str(gp_sort)]);
end


function [rank,top1_most,sort_rank,pre_rank1]=pre_rank(pre_data,sum_bef,sum_end,orank,n,M1,top1_most,sort_rank)

pre_rank1=pre_data(sum_bef:sum_end,:);
[sort_gp_pre_rank,id1]=sort(pre_rank1,'descend'); %从大到小排列之前的位置
%巧妙避免重复数据
[sort_gp_pre_rank,id2]=sort(sort_gp_pre_rank,'descend'); %从大到小排列现在的位置
big_sort_gp_pre_rank=sort_gp_pre_rank+sort(id2,'descend'); %同一位置放大

M2 = containers.Map(big_sort_gp_pre_rank,id1);
rank=cell(1,n);

for k=1:n  %把计算的值换成1,2,3,4
    rank{1,k}=M1(M2(big_sort_gp_pre_rank(k,:)));
end

if rank{1,1}==orank{1,1}
    top1_most=top1_most+1;
end

if rank{1,1}==orank{1,1}&&rank{1,2}==orank{1,2}&&rank{1,3}==orank{1,3}
    sort_rank=sort_rank+1;
end

end
