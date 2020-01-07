function [y]=one_col(gpdata)
%把矩阵转置为一列
% for i=1:size(gpdata,1)
%     a=rmmissing(gpdata(i,:));
%    if numel(a)==4
%        for j=1:4
%            if a(j)==4
%                a(j)=3;
%            else
%                if a(j)==3
%                    a(j)=2;
%                else
%                    if a(j)==2
%                        a(j)=1.5;
%                    end
%                end
%            end
%        end
%        gpdata(i,:)=a;
%    end
%        
% end

ss=gpdata';
y = reshape(ss,numel(ss),1);
y=rmmissing(y);
end