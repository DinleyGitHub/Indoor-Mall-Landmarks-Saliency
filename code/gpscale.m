function [data_norn]=gpscale(data)

%[data_norn]=scalematrix(data);
[data_norn]=minmaxmatrix(data);
end

function [z,mu,sigma]=scalematrix(x)
mu =mean(x,2); 
sigma=std(x,0,2); 
z = x-repmat(mu,1,size(x,2)); 
z=   z ./(repmat(sigma,1,size(x,2)));
end


function [z]=minmaxmatrix(x)
%Min-Max Normalization 归一化
Min=min(x,[],2);
Max=max(x,[],2);

%将数据映射到[0,1]
z = x-repmat(Min,1,size(x,2));
z=z./(repmat(Max-Min,1,size(x,2)));
end
