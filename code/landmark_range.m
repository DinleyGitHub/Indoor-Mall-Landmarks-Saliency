
% 根据最大显著度把200个场景划分五组

function [zus,sort_and_top]=landmark_range()
testrank=load('5fold_crass\testrank');
testrank=struct2cell(testrank);
testrank=testrank{1,1};
a=5;
data_sence=cell(200,5);

for s=1:5
    test_rank_testrank=testrank{s,1};
    preranks_testrank=testrank{s,2};
    if s==1
        for d=1:40
            data_sence{d,4}=test_rank_testrank(d,:);
            data_sence{d,5}=preranks_testrank{d,:};
        end
    elseif s==2
        for d=41:80
            data_sence{d,4}=test_rank_testrank(d-40,:);
            data_sence{d,5}=preranks_testrank{d-40,:};
        end
    elseif s==3
        for d=81:120
            data_sence{d,4}=test_rank_testrank(d-80,:);
            data_sence{d,5}=preranks_testrank{d-80,:};
        end
    elseif s==4
        for d=121:160
            data_sence{d,4}=test_rank_testrank(d-120,:);
            data_sence{d,5}=preranks_testrank{d-120,:};
        end
    else
        for d=161:200
            data_sence{d,4}=test_rank_testrank(d-160,:);
            data_sence{d,5}=preranks_testrank{d-160,:};
        end
    end
end
rank=cell2mat(data_sence(:,4));
for i=1:size(rank, 1)
    one_sence=rmmissing(rank(i,:));
    [one_sence_rank,id]=sort(one_sence,'descend');
    data_sence{i,1}=one_sence;
    data_sence{i,2}=one_sence_rank(1);
    data_sence{i,3}=i;
end
data_sence_mat_rank=data_sence(:,1);
pre_ranks=data_sence(:,5);
data_sence_mat=cell2mat(data_sence(:,2));

id2=cell2mat(data_sence(:,3));    % 从小到大排序
rmax=max(data_sence_mat);
rmin=min(data_sence_mat);
cha=(rmax-rmin)/a; 
zus=cell(a,7);
% 划分范围
for j=1:a
   acha=rmin+cha*(j-1);
   bcha=rmin+cha*j;
   rang1=[acha,bcha];
   if j<5
       inda=(acha<=data_sence_mat)&(data_sence_mat<bcha);
       zus{j,1}=data_sence_mat(inda); 
       zus{j,2}=id2(inda); 
       zus{j,5}=sum(inda);
       zus{j,6}=data_sence_mat_rank(inda);
       zus{j,7}=pre_ranks(inda);
   else
       inda=(acha<=data_sence_mat)&(data_sence_mat<=bcha);
       zus{j,1}=data_sence_mat(inda); 
       zus{j,2}=id2(inda); 
       zus{j,5}=sum(inda);
       zus{j,6}=data_sence_mat_rank(inda);
       zus{j,7}=pre_ranks(inda);
   end
   zus{j,3}=j; 
   zus{j,4}=rang1; 
end
orl_rank= zus(:,6);
pre_rank= zus(:,7);
sort_and_top=zeros(5,2);
for m=1:5
    ma=orl_rank{m,1};
    mb=pre_rank{m,1};
    [sort_rank,top1_most]=cla_a_range(ma,mb);
    sort_and_top(m,1)=sort_rank;
    sort_and_top(m,2)=top1_most;
end
end


function [sort_rank,top1_most]=cla_a_range(true_ranks,pre_ranks)

sort_rank=0;
top1_most=0;
for k=1:size(true_ranks,1)
    a_true_rank=cell2mat(true_ranks(k,1));
    n=size(a_true_rank,2);
    a_pre_rank=cell2mat(pre_ranks(k,1));
    M3=containers.Map([1,2,3,4],{'A','B','C','D'});
    [a_true_rank_des,id_true]=sort(a_true_rank,'descend');
    [a_pre_rank_des,id_pre]=sort(a_pre_rank,'descend');
    trank=cell(1,n);
    prank=cell(1,n);
    
    for g=1:n  %把计算的值换成1,2,3,4
        trank{1,g}=M3(id_true(1,g));
        prank{1,g}=M3(id_pre(g,1));
    end
    
    if trank{1,1}==prank{1,1}
        top1_most=top1_most+1;
    end

    if trank{1,1}==prank{1,1}&&trank{1,2}==prank{1,2}&&trank{1,3}==prank{1,3}
        sort_rank=sort_rank+1;
    end
    
end

% 调用方法的画图函数
% draw_plot(data_sence_mat(:,2));
% draw_plot(all_salience);

end

function [rank,top1_most,sort_rank]=cal_rank(pre_data,sum_bef,sum_end,orank,n,M1)
top1_most=0;
sort_rank=0;
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
    top1_most=1;
end

if rank{1,1}==orank{1,1}&&rank{1,2}==orank{1,2}&&rank{1,3}==orank{1,3}
    sort_rank=1;
end

end