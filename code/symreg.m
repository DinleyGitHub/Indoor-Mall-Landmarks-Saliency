gp = rungp(@symreg_config);


disp('>>summary(gp);');
disp(' ');
disp('Press a key to continue');
disp(' ');
pause;
summary(gp);  

%cd('../../OutputSymReg ');save('gp_2016_06_28_13_45_lam', 'gp' );cd('../gptips2/gptips2');
%
%

%
%writing symbolic math object to file
%mymodel = gpmodel2sym(gp, 'valbest');
%fid =fopen('2016_06_28_13_45_lam.txt', 'wt');fprintf(fid, '%s\n', char(mymodel));fclose(fid);


% if gp.info.toolbox.symbolic
%     disp('>>gppretty(gp,best)');
%     disp(' ');
%     disp('Press a key to continue');
%     disp(' ');
%     gppretty(gp,'best');
%     [gene_latex_expr, full_latex_expr] = gppretty(gp, 'best'); 
%     % renderLatex(gp, 'best');
% end

% if gp.info.toolbox.symbolic
%     disp('>>paretoreport(gp);');
%     disp(' ');
%     disp('Press a key to continue');
%     disp(' ');
%     pause;
%     paretoreport(gp);
% end

% disp('>>popbrowser(gp);');
% disp(' ');
% disp('Press a key to continue');
% disp(' ');
% pause;
% popbrowser(gp);
% 
% disp('>>drawtrees(gp,best);');
% disp(' ');
% disp('Press a key to continue');
% disp(' ');
% pause;
% drawtrees(gp,'best');

% if gp.info.toolbox.symbolic  
%     disp('>>gpmodelreport(gp,best);');
%     disp(' ');
%     disp('Press a key to continue');
%     disp(' ');
%     gpmodelreport(gp,'best');
% end

%  
% disp('>>runtree(gp,best)');
% disp(' ');
% disp('Press a key to continue');
% disp(' ');
% pause;
% runtree(gp,'best');


