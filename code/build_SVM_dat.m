
function build_SVM_dat(data,rank,nameStr)

fid=fopen(nameStr,'w');
sum=0;

for i=1:size(rank,1)
    one_rank=rank(i,:);
    str=['# query ',num2str(i)];
    fprintf(fid,'%s\n',str);
    a=numel(rmmissing(one_rank));
    sum=sum+a;
    one_data=data(sum-a+1:sum,:);
    for j=1:a
        value=[num2str(one_rank(j)),' qid:',num2str(i)];
        fprintf(fid,'%s',value);
        for k=1:size(one_data,2)
            value=[' ',num2str(k),':',num2str(one_data(j,k))];
            fprintf(fid,'%s',value);
        end
        fprintf(fid,'\n');
    end
end

disp('The Build Work is OK!!!!');

end





