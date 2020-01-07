function GP()
clc;
name='valbest';    %valbest    testbest    best
runnum=0;  err=0; i=0;  iteration=3;
rank_rate2=0;
accuracy_out={};
while true
    runnum=runnum+1;   %统计遗传规划运行了多少次
    [rank_rate,gp]=run(name,runnum); %输出测试集中最好的模型预测的精度
%     rank_rate1=rank_rate;
     accuracy_out{runnum,1}=rank_rate;
%     
%     if rank_rate1-rank_rate2>=err   %计算邻近两次的误差
%         i=i+1;   %统计满足邻近两次的误差的个数
%     else          
%         i=0;   %如果有一次运行的误差不满足要求，i重新归为0，保证了连续性
%     end
%     rank_rate2=rank_rate1;
%     
%     if i==iteration   %达到迭代次数就停下
%         break;
%     end
    
    save accuracy_out;
    if rank_rate>0.7
        break;
    end
end

%report(gp,name);
disp(['运行次数',num2str(runnum)]);
end


function [rank_rate,gp]=run(name,runnum)

disp('>>rungp(''GP_config'');');
%人口生成并验证
[gp,n]=rungp('GP_config');

disp(['>>runtree(gp,',name,');']);

%在Matlab命令窗口中显示种群中(仅用于符号回归问题)最佳模型(单基因或多基因)的数学简化版本。
%简化在测试数据上执行得最好的模型(如果存在的话)。这个最佳个体是重点，后面的测试需要他
disp(['>>gppretty(gp,',name,');']); %验证集上最好的个体也是曾经训练集上最好的个体，所以用验证集上最好的
exprSym=gppretty(gp,name,0,1,0,1);
evalstr=strrep(char(vpa(exprSym,4)),'*','.*');
evalstr=strrep(evalstr,'^','.^');
%evalstr=strrep(evalstr,'x','p');
rank_rate=test_accuracy(evalstr,gp,n,runnum);    %直接测试

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