load('F:\03-code\02-matlab\GP\v20\5fold_crass\zus.mat')

fid=fopen('5fold_crass\TrueSailence.dat','w');
fid_max=fopen('5fold_crass\TrueSailenceMax.dat','w');
for i=1:5
    azu=zus{i,6};
    for j=1:size(azu,1)
        a=azu{j};
        max_a=max(a);
        fprintf(fid,'%g\n',a);
        fprintf(fid_max,'%s\n',num2str(max_a));
    end

end
fclose(fid);
fclose(fid_max);
disp('保存实验预测文件成功！');