function [Proportion]=build_Range_doc(zus,sort_and_top)

zusNum=cell2mat(zus(:,5));
Proportion=zeros(5,2);
for i=1:5
   Proportion(i,1)=sort_and_top(i,2)/zusNum(i,1);
   Proportion(i,2)=sort_and_top(i,1)/zusNum(i,1);
end

fid=fopen('5fold_crass\Range_Doc_fold.dat','w');
fprintf(fid,'%s\n',['Folds   ',['·¶Î§1 [',num2str(min(cell2mat(zus(1,4)))),',',num2str(max(cell2mat(zus(1,4)))),']'],'        ',['·¶Î§2 [',num2str(min(cell2mat(zus(2,4)))),',',num2str(max(cell2mat(zus(2,4)))),']'],'     ',['·¶Î§3 [',num2str(min(cell2mat(zus(3,4)))),',',num2str(max(cell2mat(zus(3,4)))),']'],'     ',['·¶Î§4 [',num2str(min(cell2mat(zus(4,4)))),',',num2str(max(cell2mat(zus(4,4)))),']'],'     ',['·¶Î§5 [',num2str(min(cell2mat(zus(5,4)))),',',num2str(max(cell2mat(zus(5,4)))),']']]);
fprintf(fid,'%s\n','-----------------------------------------------------------------------------------------------------------------------------');
fprintf(fid,'%s\n',['Total_Number:         ',num2str(zusNum(1,1)),'                ',num2str(zusNum(2,1)),'                     ',num2str(zusNum(3,1)),'                      ',num2str(zusNum(4,1)),'                      ',num2str(zusNum(5,1))]);
fprintf(fid,'%s\n',['TOP1:                 ',num2str(sort_and_top(1,2)),'                ',num2str(sort_and_top(2,2)),'                     ',num2str(sort_and_top(3,2)),'                      ',num2str(sort_and_top(4,2)),'                      ',num2str(sort_and_top(5,2))]);
fprintf(fid,'%s\n',['TOP1_Proportion:      ',num2str(sort_and_top(1,2)/zusNum(1,1)),'             ',num2str(sort_and_top(2,2)/zusNum(2,1)),'                ',num2str(sort_and_top(3,2)/zusNum(3,1)),'                 ',num2str(sort_and_top(4,2)/zusNum(4,1)),'                 ',num2str(sort_and_top(5,2)/zusNum(5,1))]);
fprintf(fid,'%s\n',['Sort:                 ',num2str(sort_and_top(1,1)),'                 ',num2str(sort_and_top(2,1)),'                     ',num2str(sort_and_top(3,1)),'                      ',num2str(sort_and_top(4,1)),'                      ',num2str(sort_and_top(5,1))]);
fprintf(fid,'%s\n',['Sort_Proportion:      ',num2str(sort_and_top(1,1)/zusNum(1,1)),'            ',num2str(sort_and_top(2,1)/zusNum(2,1)),'                ',num2str(sort_and_top(3,1)/zusNum(3,1)),'                 ',num2str(sort_and_top(4,1)/zusNum(4,1)),'                 ',num2str(sort_and_top(5,1)/zusNum(5,1))]);
fprintf(fid,'%s\n','-----------------------------------------------------------------------------------------------------------------------------');
fclose(fid);
disp('Éú³É·¶Î§Ô¤²âÎÄ¼þ³É¹¦£¡')
end