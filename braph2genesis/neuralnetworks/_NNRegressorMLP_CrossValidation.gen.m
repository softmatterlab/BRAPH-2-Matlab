%% ¡header!
NNRegressorMLP_CrossValidation < NNCrossValidation (nncv, neural network cross-validation for MLP regressors) is a process for evaluating multi-layer perceptron regressors using cross-validation.

%%% ¡description!
A cross validation for multi-layer perceptron regressors (NNRegressorMLP_CrossValidation) is a process that facilitates the evaluation of multi-layer perceptron regressors using cross-validation. 
 It involves splitting a dataset into multiple subsets (folds), training the model on some folds while validating on others, and then repeating the process for all combinations of folds. 
 This helps in assessing the generalization performance of the model and detecting overfitting.

To train all the neural networks for all folds, use: nncv.get('TRAIN')

%%% ¡seealso!
NNDataPoint, NNDataset, NNEvaluator

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
NNRegressorMLP_CrossValidation.ID
%%%% ¡title!
Cross Validation ID

%%% ¡prop!
%%%% ¡id!
NNRegressorMLP_CrossValidation.LABEL
%%%% ¡title!
Cross Validation LABEL

%%% ¡prop!
%%%% ¡id!
NNRegressorMLP_CrossValidation.VERBOSE
%%%% ¡title!
VERBOSE ON/OFF

%%% ¡prop!
%%%% ¡id!
NNRegressorMLP_CrossValidation.PLOT_TRAINING
%%%% ¡title!
PLOT TRAINING PROGRESS

%%% ¡prop!
%%%% ¡id!
NNRegressorMLP_CrossValidation.EPOCHS
%%%% ¡title!
Training EPOCHS

%%% ¡prop!
%%%% ¡id!
NNRegressorMLP_CrossValidation.BATCH
%%%% ¡title!
Training BATCH

%%% ¡prop!
%%%% ¡id!
NNRegressorMLP_CrossValidation.SHUFFLE
%%%% ¡title!
Training SHUFFLE

%%% ¡prop!
%%%% ¡id!
NNRegressorMLP_CrossValidation.SOLVER
%%%% ¡title!
Training SOLVER

%%% ¡prop!
%%%% ¡id!
NNRegressorMLP_CrossValidation.NN_TEMPLATE
%%%% ¡title!
Template for Neural Network Regressor

%%% ¡prop!
%%%% ¡id!
NNRegressorMLP_CrossValidation.NNEVALUATOR_TEMPLATE
%%%% ¡title!
Template for Neural Network Evaluator

%%% ¡prop!
%%%% ¡id!
NNRegressorMLP_CrossValidation.D_LIST
%%%% ¡title!
Dataset List

%%% ¡prop!
%%%% ¡id!
NNRegressorMLP_CrossValidation.NN_LIST
%%%% ¡title!
Neural Network Regressor List

%%% ¡prop!
%%%% ¡id!
NNRegressorMLP_CrossValidation.EVALUATOR_LIST
%%%% ¡title!
Neural Network Evaluator List

%%% ¡prop!
%%%% ¡id!
NNRegressorMLP_CrossValidation.PFSP
%%%% ¡title!
Scatter Plot

%%% ¡prop!
%%%% ¡id!
NNRegressorMLP_CrossValidation.AV_CORR
%%%% ¡title!
Average of Correlation Coefficient

%%% ¡prop!
%%%% ¡id!
NNRegressorMLP_CrossValidation.AV_DET
%%%% ¡title!
Average of Coefficient of Determination

%%% ¡prop!
%%%% ¡id!
NNRegressorMLP_CrossValidation.AV_MAE
%%%% ¡title!
Average of Mean Absolute Error

%%% ¡prop!
%%%% ¡id!
NNRegressorMLP_CrossValidation.AV_MSE
%%%% ¡title!
Average of Mean Squared Error

%%% ¡prop!
%%%% ¡id!
NNRegressorMLP_CrossValidation.AV_RMSE
%%%% ¡title!
Average of Root Mean Squared Error

%%% ¡prop!
%%%% ¡id!
NNRegressorMLP_CrossValidation.NOTES
%%%% ¡title!
Cross Validation NOTES

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the cross-validation.
%%%% ¡default!
'NNRegressorMLP_CrossValidation'

%%% ¡prop!
NAME (constant, string) is the name of the cross-validation.
%%%% ¡default!
'Neural Network Cross-Validation for Multi-layer Perceptron Regressors'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the cross-validation.
%%%% ¡default!
'A cross validation for multi-layer perceptron regressors (NNRegressorMLP_CrossValidation) is a process that facilitates the evaluation of multi-layer perceptron regressors using cross-validation. It involves splitting a dataset into multiple subsets (folds), training the model on some folds while validating on others, and then repeating the process for all combinations of folds. This helps in assessing the generalization performance of the model and detecting overfitting.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the nerual cross-validation.
%%%% ¡settings!
'NNRegressorMLP_CrossValidation'

%%% ¡prop!
ID (data, string) is a few-letter code for the cross-validation.
%%%% ¡default!
'NNRegressorMLP_CrossValidation ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the cross-validation.
%%%% ¡default!
'NNRegressorMLP_CrossValidation label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the cross-validation.
%%%% ¡default!
'NNRegressorMLP_CrossValidation notes'

%%% ¡prop!
NN_TEMPLATE (parameter, item) is the neural network template to set all neural network parameters.
%%%% ¡settings!
'NNRegressorMLP'

%%% ¡prop!
NNEVALUATOR_TEMPLATE (parameter, item) is the neural network evaluator template to set all evalutor parameters.
%%%% ¡settings!
'NNRegressorMLP_Evaluator'

%%% ¡prop!
NN_LIST (result, itemlist) contains the neural network models corresponding to k folds.
%%%% ¡calculate!
d_list = nncv.get('D_LIST');

if isempty(d_list)
    value = {};
else
    for i = 1:length(d_list)
        d_training_set{i} = d_list;
        d_training_set{i}(i) = [];  % Exclude the i-th element
        d_training_set{i} = NNDatasetCombine('D_LIST', d_training_set{i}).get('D');
    end

    d_training_set = d_training_set';

    if ~isa(nncv.getr('NN_TEMPLATE'), 'NoValue')
        nn_template = nncv.get('NN_TEMPLATE');
    else
        nn_template = NNRegressorMLP( ...
            'EPOCHS', nncv.get('EPOCHS'), ...
            'BATCH', nncv.get('BATCH'), ...
            'SHUFFLE', nncv.get('SHUFFLE'), ...
            'SOLVER', nncv.get('SOLVER'), ...
            'VERBOSE', nncv.get('VERBOSE'), ...
            'PLOT_TRAINING', nncv.get('PLOT_TRAINING'));
    end
    
    value = cellfun(@(d) NNRegressorMLP( ...
        'TEMPLATE', nn_template, 'D', d), ...
        d_training_set, 'UniformOutput', false);
end

%%% ¡prop!
EVALUATOR_LIST (result, itemlist) contains the evaluators corresponding to k folds.
%%%% ¡calculate!
%%% ¡prop!
EVALUATOR_LIST (result, itemlist) contains the evaluators corresponding to k folds.
%%%% ¡calculate!
d_list = nncv.get('D_LIST');
nn_list = nncv.get('NN_LIST');

if ~isa(nncv.getr('NNEVALUATOR_TEMPLATE'), 'NoValue')
    nne_template = nncv.get('NNEVALUATOR_TEMPLATE');
else
    nne_template = NNRegressorMLP_Evaluator();
end

value = cellfun(@(d, nn) NNRegressorMLP_Evaluator('TEMPLATE', nne_template, 'D', d, 'NN', nn), ...
    d_list, nn_list, 'UniformOutput', false);

%% ¡props!

%%% ¡prop!
AV_CORR (result, rvector) provides the metric of the correlation of coefficients.
%%%% ¡calculate!
e_list = nncv.get('EVALUATOR_LIST');

value = cellfun(@(e) e.get('CORR'), ...
    e_list, 'UniformOutput', false);

if isempty(value)
    value = [];
else
    value = mean(cell2mat(value), 1);
end

%%% ¡prop!
AV_DET (result, rvector) provides the coefficient of determination, a measure showing how well the predictions are replicated by the model.
%%%% ¡calculate!
e_list = nncv.get('EVALUATOR_LIST');

value = cellfun(@(e) e.get('DET'), ...
    e_list, 'UniformOutput', false);

if isempty(value)
    value = [];
else
    value = mean(cell2mat(value), 1);
end

%%% ¡prop!
AV_MAE (result, rvector) provides the metric of the mean absolute error.
%%%% ¡calculate!
e_list = nncv.get('EVALUATOR_LIST');

value = cellfun(@(e) e.get('MAE'), ...
    e_list, 'UniformOutput', false);

if isempty(value)
    value = [];
else
    value = mean(cell2mat(value), 1);
end

%%% ¡prop!
AV_MSE (result, rvector) provides the metric of the mean squared error.
%%%% ¡calculate!
e_list = nncv.get('EVALUATOR_LIST');

value = cellfun(@(e) e.get('MSE'), ...
    e_list, 'UniformOutput', false);

if isempty(value)
    value = [];
else
    value = mean(cell2mat(value), 1);
end

%%% ¡prop!
AV_RMSE (result, rvector) provides the metric of the root mean squared error.
%%%% ¡calculate!
e_list = nncv.get('EVALUATOR_LIST');

value = cellfun(@(e) e.get('RMSE'), ...
    e_list, 'UniformOutput', false);

if isempty(value)
    value = [];
else
    value = mean(cell2mat(value), 1);
end

%%% ¡prop!
PFSP (gui, item) contains the panel figure of the scatter plot for regression model.
%%%% ¡settings!
'NNRegressorMLP_CrossValidationPF_Scatter'
%%%% ¡postprocessing!
if isa(nncv.getr('PFSP'), 'NoValue')
    nncv.set('PFSP', NNRegressorMLP_CrossValidationPF_Scatter('NNCV', nncv));
end
%%%% ¡gui!
pr = PanelPropItem('EL', nncv, 'PROP', NNRegressorMLP_CrossValidation.PFSP, ...
    'GUICLASS', 'GUIFig', ...
	'BUTTON_TEXT', ['Scatter Plot'], ...
    varargin{:});

%% ¡tests!

%%% ¡excluded_props!
[NNRegressorMLP_CrossValidation.PFSP]

%%% ¡test!
%%%% ¡name!
evaluate a regressor cross-validation with the example data
%%%% ¡code!
% ensure the example data is generated
if ~isfile([fileparts(which('NNDataPoint_CON_REG')) filesep 'Example data NN REG CON XLS' filesep 'atlas.xlsx'])
    create_data_NN_REG_CON_XLS() % create example files
end

% Load BrainAtlas
im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [fileparts(which('NNDataPoint_CON_REG')) filesep 'Example data NN REG CON XLS' filesep 'atlas.xlsx'], ...
    'WAITBAR', true ...
    );

ba = im_ba.get('BA');

% Load Groups of SubjectCON
im_gr = ImporterGroupSubjectCON_XLS( ...
    'DIRECTORY', [fileparts(which('NNDataPoint_CON_REG')) filesep 'Example data NN REG CON XLS' filesep 'CON_Group_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr = im_gr.get('GR');

% create a item list of NNDataPoint_CON_REG
it_list = cellfun(@(x) NNDataPoint_CON_REG( ...
    'ID', x.get('ID'), ...
    'SUB', x, ...
    'TARGET_IDS', x.get('VOI_DICT').get('KEYS')), ...
    gr.get('SUB_DICT').get('IT_LIST'), ...
    'UniformOutput', false);

% create a NNDataPoint_CON_REG DICT
dp_list = IndexedDictionary(...
        'IT_CLASS', 'NNDataPoint_CON_REG', ...
        'IT_LIST', it_list ...
        );

% create a NNData containing the NNDataPoint_CON_REG DICT
d = NNDataset( ...
    'DP_CLASS', 'NNDataPoint_CON_REG', ...
    'DP_DICT', dp_list ...
    );

kfolds = 3;
nncv = NNRegressorMLP_CrossValidation('KFOLDS', kfolds, 'D', {d});

nn_list = nncv.get('NN_LIST');
assert(length(nn_list) == kfolds, ...
    [BRAPH2.STR ':NNRegressorMLP_CrossValidation:' BRAPH2.FAIL_TEST], ...
    'NNRegressorMLP_CrossValidation does not calculate the neural network list correctly.' ...
    )
e_list = nncv.get('EVALUATOR_LIST');
assert(length(e_list) == kfolds, ...
    [BRAPH2.STR ':NNRegressorMLP_CrossValidation:' BRAPH2.FAIL_TEST], ...
    'NNRegressorMLP_CrossValidation does not calculate the evaluator list correctly.' ...
    )