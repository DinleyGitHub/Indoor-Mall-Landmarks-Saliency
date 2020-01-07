function [gp_pre_data,gp_top1,gp_sort,gp_evalstr,gp,runnum,gptoc,valid_acc]=GP(runnum,n,train_porp,train_rank,test_porp,test_rank,val_porp,val_rank)
tic;
name='valbest';    %valbest    testbest    best
accuracy_out={runnum,4}; 

for i=1:runnum
    disp(['第',num2str(n),'折  ','第',num2str(i),'遍/共',num2str(runnum),'遍']);
    [evalstr1,gp]=run(name,train_porp,train_rank,test_porp,test_rank,val_porp,val_rank); %输出验证集中最好的模型预测的精度
    accuracy_out{i,1}=evalstr1;
    accuracy_out{i,2}=gp.results.valbest.valfitness;
    if gp.results.valbest.valfitness>1
      pause;
    end
    accuracy_out{i,3}=gp.results.valbest.returnvalues;
    accuracy_out{i,4}=gp.results.valbest.eval_individual;
end
%dlmwrite (['5fold_crass\Fold',num2str(n),'valbestreturnvalues.txt'],num2str(gp.results.valbest.returnvalues),'delimiter','\t','newline','pc');
dlmwrite (['5fold_crass\Fold',num2str(n),'valid_accuracy.txt'],cell2mat(accuracy_out(:,2)),'delimiter','\t','newline','pc');
%dlmwrite (['5fold_crass\Fold',num2str(n),'gp_valid_accuracy.txt'],cell2mat(accuracy_out(:,3)),'delimiter','\t','newline','pc');
save (['5fold_crass\Fold',num2str(n),'gp_train_out']);
[valid_acc,index]=max(cell2mat(accuracy_out(:,2)));
gp_evalstr=accuracy_out{index,1};
returnvalues=accuracy_out{index,3};
eval_individual=accuracy_out{index,4};
[gp_top1,gp_sort,gp_pre_data]=test_accuracy(returnvalues,eval_individual,gp.userdata.test_rank,gp.userdata.xtest,gp.userdata.ytest);
gptoc=toc;

disp(['验证集最大值',num2str(valid_acc)]);
end

function [evalstr,gp]=run(name,train_porp,train_rank,test_porp,test_rank,val_porp,val_rank)
gp=rungp('GP_config',train_porp,train_rank,test_porp,test_rank,val_porp,val_rank);
disp(['>>gppretty(gp,',name,');']); %验证集上最好的个体也是曾经训练集上最好的个体，所以用验证集上最好的
disp('-----------------------------------------------------------');
exprSym=gppretty(gp,name,0,1,0,1);
evalstr=char(vpa(exprSym,4));
end

function report(gp,name)

%显示GP中所有模型的输入频率条形图，
%来源于训练集上的R2 >= 0.6，其中R2为模型在训练数据上的判定系数。
gppopvars(gp,0.75);

%plot the best and mean fitness, 来源于训练集上的
%绘制运行过程中的最佳(log值)和平均适应度。
summary(gp);  

%输出当前总体中的“最佳”个体的行为。测试集中或者验证集上的
runtree(gp,name);

%为在训练数据上执行得最好的模型生成一个报告(如果该数据存在的话)。 modelreport.htm
%为在验证数据上执行得最好的模型生成一个报告(如果该数据存在的话)。
%为在测试数据上执行得最好的模型生成一个报告(如果该数据存在的话)。
gpmodelreport(gp,name); 

%生成一个名为pareto的HTML报告。htm对GPTIPS数据结构GP
%中多基因符号回归模型表达复杂性/R2帕累托前的研究 pareto.htm
paretoreport(gp); 

%对在测试数据上执行得最好的个体(如果该数据存在)画树。 trees.htm
drawtrees(gp,name); 

end