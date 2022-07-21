%EXAMPLE_NN_CON_FUN_MP_WU_CLASSIFICATION_GRAPHMEASURES
% Script example pipeline for NN classification with the input of graph measures

clear variables %#ok<*NASGU>

%% Load brain atlas
im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [fileparts(which('example_CON_FUN_MP_WU')) filesep 'example data CON-FUN_MP' filesep 'desikan_atlas.xlsx'], ...
    'WAITBAR', true ...
    );

ba = im_ba.get('BA');

%% Load groups of SubjectCON
im_gr1 = ImporterGroupSubjectCON_XLS( ...
    'DIRECTORY', [fileparts(which('example_CON_FUN_MP_WU')) filesep 'example data CON-FUN_MP' filesep 'xls' filesep 'connectivity' filesep 'GroupName1'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr1_CON = im_gr1.get('GR');

im_gr2 = ImporterGroupSubjectCON_XLS( ...
    'DIRECTORY', [fileparts(which('example_CON_FUN_MP_WU')) filesep 'example data CON-FUN_MP' filesep 'xls' filesep 'connectivity' filesep 'GroupName2'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr2_CON = im_gr2.get('GR');

%% Load groups of SubjectFUN
im_gr1 = ImporterGroupSubjectFUN_XLS( ...
    'DIRECTORY', [fileparts(which('example_CON_FUN_MP_WU')) filesep 'example data CON-FUN_MP' filesep 'xls' filesep 'functional' filesep 'GroupName1'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr1_FUN = im_gr1.get('GR');

im_gr2 = ImporterGroupSubjectFUN_XLS( ...
    'DIRECTORY', [fileparts(which('example_CON_FUN_MP_WU')) filesep 'example data CON-FUN_MP' filesep 'xls' filesep 'functional' filesep 'GroupName2'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr2_FUN = im_gr2.get('GR');

%% Combine groups of SubjectCON with groups of SubjectFUN
co_gr1 = CombineGroups_CON_FUN( ...
    'GR1', gr1_CON, ...
    'GR2', gr1_FUN, ...
    'WAITBAR', true ...
    );

gr1 = co_gr1.get('GR');

co_gr2 = CombineGroups_CON_FUN( ...
    'GR1', gr2_CON, ...
    'GR2', gr2_FUN, ...
    'WAITBAR', true ...
    );

gr2 = co_gr2.get('GR');

%% Construct the dataset
nnd1 = NNData_CON_FUN_MP_WU( ...
    'GR', gr1, ...
    'INPUT_TYPE', 'graph_measures', ...
    'MEASURES', {'DegreeAv' 'Degree' 'Distance'}, ...
    'TARGET_NAME', gr1.get('ID') ...
    );

gr1_nn = nnd1.get('GR_NN');

nnd2 = NNData_CON_FUN_MP_WU( ...
    'GR', gr2, ...
    'INPUT_TYPE', 'graph_measures', ...
    'MEASURES', {'DegreeAv' 'Degree' 'Distance'}, ...
    'TARGET_NAME', gr2.get('ID') ...
    );

gr2_nn = nnd2.get('GR_NN');

%% Split the dataset
nnds = NNClassifierDataSplit( ...
    'GR1', gr1_nn, ...
    'GR2', gr2_nn, ...
    'SPLIT_GR1', 0.2, ...
    'SPLIT_GR2', 0.2 ...
    );

gr_train = nnds.get('GR_TRAIN_FS');
gr_val = nnds.get('GR_VAL_FS');

%% Train the neural network classifier with the training set
classifier = NNClassifierDNN( ...
    'GR', gr_train, ...
    'VERBOSE', false, ...
    'PLOT_TRAINING', false, ...
    'SHUFFLE', 'every-epoch' ...
    );
classifier.memorize('MODEL');

%% Evaluate the classifier for the training set
nne_train = NNClassifierEvaluator( ...
    'GR', gr_train, ...
    'NN', classifier ...
    );

auc_train = nne_train.get('AUC');
cm_train = nne_train.get('CONFUSION_MATRIX');

%% Evaluate the classifier for the validation set
nne_val = NNClassifierEvaluator( ...
    'GR', gr_val, ...
    'NN', classifier ...
    );

auc_val = nne_val.get('AUC');
cm_val = nne_val.get('CONFUSION_MATRIX');

close all