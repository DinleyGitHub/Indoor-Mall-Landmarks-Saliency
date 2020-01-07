function [most_accuracy,all_accuracy,predict_data]=test_accuracy(returnvalues,eval_individual,rank_data,porp_data,ydata)

porp=porp_data; %gp.userdata.xval;
pat = 'x(\d+)';
evalstr1 = regexprep(eval_individual,pat,'porp(:,$1)');

numDataPoints = size(ydata,1);
numGenes = length(eval_individual);

%set up a matrix to store the tree outputs plus a bias column of ones
gene_outputs = ones(numDataPoints,numGenes+1);

%eval each gene in the current individual
for i=1:numGenes
    ind = i + 1;
    eval(['gene_outputs(:,ind)=' evalstr1{i} ';']);
    
end
%calc. prediction of validation data set using the retreived weights
predict_data = gene_outputs * returnvalues;

%get accuracy
 [most_accuracy,all_accuracy]=cal_rank_accuracy(rank_data,predict_data);
end