function build_result_doc(top1result,sortresult,runnum)
fid=fopen(['5fold_crass\Run',num2str(runnum),'_ResultComp_Doc.dat'],'w');
fprintf(fid,'%s\n',['Folds_Top1','     ','GP','     ','Zhangxing','     ','Hao','     ','SVM']);
rows=size(top1result,1);
for i=1:rows
    out_rank1=[['Fold',num2str(i)],'          ',num2str(top1result(i,1)),'      ',num2str(top1result(i,2)),'      ',num2str(top1result(i,3)),'      ',num2str(top1result(i,4))];
    fprintf(fid,'%s\n',out_rank1);
end
averagetop=mean(top1result,1);
out_rank1=['Average','        ',num2str(averagetop(1,1)),'      ',num2str(averagetop(1,2)),'      ',num2str(averagetop(1,3)),'      ',num2str(averagetop(1,4))];
fprintf(fid,'%s\n',out_rank1);
fprintf(fid,'%s\n','-----------------------------------------------------');

fprintf(fid,'%s\n',['Folds_Sort','     ','GP','     ','Zhangxing','     ','Hao','     ','SVM']);
for i=1:rows
    out_rank2=[['Fold',num2str(i)],'          ',num2str(sortresult(i,1)),'      ',num2str(sortresult(i,2)),'      ',num2str(sortresult(i,3)),'      ',num2str(sortresult(i,4))];
    fprintf(fid,'%s\n',out_rank2);
end
averagesort=mean(sortresult,1);
out_rank2=['Average','        ',num2str(averagesort(1,1)),'      ',num2str(averagesort(1,2)),'      ',num2str(averagesort(1,3)),'      ',num2str(averagesort(1,4))];
fprintf(fid,'%s\n',out_rank2);
fprintf(fid,'%s\n','-----------------------------------------------------');
fclose(fid);
disp('生成实验对比文件成功！')
end
