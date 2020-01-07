
function nDCG = NDCG(pred_relevance, y)

% M3 = containers.Map([1,2,3,4],{'A','B','C','D'});  %建立映射
% y1={};
% pred_relevance=[];
% a=numel(y);
% for i=1:a
%     y1{i}=M3(y(i));
% end
% M4 = containers.Map(y1,(a:-1:1));  %建立映射
% length_pred=numel(pred_relevance0);
% for j=1:length_pred
%     pred_relevance(j)=M4(pred_relevance0{j});
%     
% end


%% The actual computation
% nDCG is commonly calculated only for top k items, get the k.
len = length(pred_relevance);

% Get "Discounted Cumulative Gain" for the provided ranking.
DCG = sum(pred_relevance./log2(1+(1:len)));

% Get ideal ranking for the top k items.
sorted = sort(y, 'descend');  % 采用降序排序
ideal = sorted(1:len);

% Get "Discounted Cumulative Gain" for the ideal ranking.
IDCG = sum(ideal./log2(1+(1:len)));

% Get the normalized result.
nDCG = DCG/IDCG;
end