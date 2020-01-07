function gp=symreg_config(gp)

%cd('../../InputSymReg');

%run control
gp.runcontrol.pop_size = 300;				  
gp.runcontrol.num_gen = 600;				                  
%gp.runcontrol.showBestInputs = true;
%gp.runcontrol.showValBestInputs = true;
%gp.runcontrol.timeout = 30;
gp.runcontrol.runs = 3;
gp.runcontrol.parallel.auto = true;

%selection
gp.selection.tournament.size = 30;
gp.selection.tournament.p_pareto = 0.;
gp.selection.elite_fraction = 0.3;

%fitness
gp.fitness.fitfun = @regressmulti_fitfun;
gp.fitness.minimisation = true;

%multigene
gp.genes.multigene = true;
gp.genes.max_genes = 6;

%tree
% gp.treedef.max_depth = 3;
% gp.treedef.max_nodes = 5;
% gp.treedef.max_mutate_depth = 3;

%data
cd('../../InputSymRegLambert');
load lightdir;
load normals;
load fragdepth;
load color;


%allocate to train, validation and test groups
gp.userdata.xtrain = [lightdir(:,:,1), lightdir(:,:,2), lightdir(:,:,3), normals(:,:,1), normals(:,:,2), normals(:,:,3), fragdepth(:,:,3)];
gp.userdata.ytrain = color(:,:,1);

cd('../InputSymRegValLambert');
load lightdir;
load normals;
load fragdepth;
load color;
cd('../gptips2/gptips2'); 

gp.userdata.xval = [lightdir(:,:,1), lightdir(:,:,2), lightdir(:,:,3), normals(:,:,1), normals(:,:,2), normals(:,:,3), fragdepth(:,:,3)];
gp.userdata.yval = color(:,:,1);

%Tell GPTIPS to call validation set once per generation
gp.userdata.user_fcn = @regressmulti_fitfun_validate;

%Define number of inputs
gp.nodes.inputs.num_inp = size(gp.userdata.xtrain,2);
%gp.nodes.inputs.names = {'lightdir.x','lightdir.y','lightdir.z','no rmal.x','normal.y','normal.z','fragdepth'};


%define building block function nodes
gp.nodes.functions.name = {'times','minus','plus','rdivide'};
