function build_predata_doc(gp_pre_data,zhang_pre_data,hao_pre_data,svm_pre_data,runnum)
fid=fopen(['5fold_crass\Fold',num2str(runnum),'_PreData_Doc.dat'],'w');
fprintf(fid,'%s\n',[ 'gp_pre_data','     ','zhang_pre_data','     ','hao_pre_data','     ','svm_pre_data']);
rows=size(gp_pre_data,1);

for i=1:rows
    out_rank1=[num2str(gp_pre_data(i,1)),'     ',num2str(zhang_pre_data(i,1)),'     ',num2str(hao_pre_data(i,1)),'     ',num2str(svm_pre_data(i,1))];
    fprintf(fid,'%s\n',out_rank1);
end

fclose(fid);
disp('保存实验预测文件成功！');
end

