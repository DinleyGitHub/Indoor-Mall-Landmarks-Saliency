function gp=GP_config(gp,train_porp,train_rank,test_porp,test_rank,val_porp,val_rank)

% Main run control parameters
% --------------------------
gp.runcontrol.pop_size=500;				    % Population size
gp.runcontrol.num_gen=30;				    % Number of generations to run for including generation zero
gp.runcontrol.showBestInputs = false;
gp.runcontrol.showValBestInputs = false;
gp.runcontrol.verbose=40;                    % Set to n to display run information to screen every n generations
gp.runcontrol.runs=1;
%gp.runcontrol.timeout = 30;   %默认滤掉耗时很长的模型
gp.runcontrol.parallel.enable = false; %并行

% Selection method options
gp.selection.tournament.size=10;
gp.selection.elite_fraction=0.02; %记录fitness最高的10棵树创建新的种群500*0.02=10

% Tree build options
gp.treedef.max_depth=6;                % Maximum depth of trees
%gp.treedef.max_nodes =6;  %改动

% Multiple gene settings
gp.genes.max_genes=6;                  % The absolute maximum number of genes allowed in an individual.
gp.genes.multigene = true;  
%constants终端配置。[0=无常数，0.5=半常数半输入,1=无输入]
gp.nodes.const.p_ERC = 0.5;
%gp.nodes.const.range = [-10 10];     %ERC range    

% Fitness function specification
gp.fitness.fitfun=@regressmulti_fitfun;
gp.fitness.minimisation=true;                % Set to true if you want to minimise the fitness function (if false it is maximised).

%[train_porp,train_rank,test_porp,test_rank,val_porp,val_rank]=cross_validation(n); %导入数据
gp.userdata.xtrain=train_porp;
gp.userdata.ytrain=one_col(train_rank);  % train 49% of total data;把排序去掉空值变成一列，方便后面regressmulti_fitfun计算theta
gp.userdata.train_rank=train_rank; %原始的排序
gp.userdata.xtest=test_porp;
gp.userdata.ytest=one_col(test_rank);  % test 30% of total data
gp.userdata.test_rank=test_rank;
gp.userdata.xval=val_porp;
gp.userdata.yval=one_col(val_rank);  % val 21% of total data
gp.userdata.val_rank=val_rank;

gp.userdata.user_fcn=@regressmulti_fitfun_validate; %enables hold out validation set
%gp.data.fold=n;  %自己加的当前fold数
% Input configuration
%gp.nodes.inputs.num_inp=size(gp.userdata.xtrain,2);  % This sets the number of inputs (i.e. the size of the terminal set NOT including constants)

gp.operators.about='Genetic operator configuration';
gp.operators.mutation.p_mutate=0.1;  
gp.operators.crossover.p_cross=0.88;   
gp.operators.directrepro.p_direct=0.02; 
gp.operators.mutation.mutate_par=[0.9 0.05 0.05 0 0 0];
gp.operators.mutation.gaussian.std_dev=0.1;  % if mutate_type 3 (constant perturbation) is used this is the standard deviation of the Gaussian used.
gp.operators.mutation=orderfields(gp.operators.mutation);
%共14种属性
%gp.nodes.inputs.names = {'p1','p2','p3','p4','p5','p6','p7','p8','p9','p10','p11','p12','p13','p14'};
gp.nodes.inputs.names = {'x1','x2','x3','x4','x5','x6','x7','x8','x9','x10','x11','x12','x13','x14'};
%Function name                                     Number of arguments
gp.nodes.functions.name{1}='times'      ;
gp.nodes.functions.name{2}='minus'      ;
gp.nodes.functions.name{3}='plus'       ;
gp.nodes.functions.name{4}='rdivide'    ;            % unprotected divide (may cause NaNs)
gp.nodes.functions.name{5}='psqroot'    ;            % protected sqrt
gp.nodes.functions.name{6}='plog'       ;            % protected natural log
gp.nodes.functions.name{7}='square'     ;            % .^2 square
gp.nodes.functions.name{8}='tanh'       ;            % tanh function
gp.nodes.functions.name{9}='pdivide'   ;            % protected divide function
gp.nodes.functions.name{10}='iflte'     ;            % IF-THEN-ELSE function
gp.nodes.functions.name{11}='sin'       ;
gp.nodes.functions.name{12}='cos'       ;
gp.nodes.functions.name{13}='exp'       ;

% Active functions
% particular run. 手动将函数节点设置为“不活动”允许您在特定运行中排除函数节点。
gp.nodes.functions.active(1)=1;
gp.nodes.functions.active(2)=1;
gp.nodes.functions.active(3)=1;
gp.nodes.functions.active(4)=1;
gp.nodes.functions.active(5)=1;%
gp.nodes.functions.active(6)=1;%
gp.nodes.functions.active(7)=1;
gp.nodes.functions.active(8)=0;
gp.nodes.functions.active(9)=1;
gp.nodes.functions.active(10)=0;
gp.nodes.functions.active(11)=0;%
gp.nodes.functions.active(12)=0;%
gp.nodes.functions.active(13)=0;%

gp.nodes.const.range = [0,1];     %ERC range    
