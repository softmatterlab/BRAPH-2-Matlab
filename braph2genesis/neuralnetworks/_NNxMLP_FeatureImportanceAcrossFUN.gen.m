%% ¡header!
NNxMLP_FeatureImportanceAcrossFUN < NNxMLP_FeatureImportance (nnfiam, neural network feature importace for multi-layer perceptron) provides feature importance analysis for multi-layer perceptron (MLP) across all functional time series.

%%% ¡description!
Neural Network Feature Importance Across Functional Data (NNxMLP_FeatureImportanceAcrossFUN) 
 assesses the importance of brain regions by measuring the increase in model error 
 when its corresponding functional time series values are randomly shuffled.

%%% ¡seealso!
NNDataPoint_FUN_CLA, NNDataPoint_FUN_REG, NNxMLP_FeatureImportanceAcrossMeasures

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportanceAcrossFUN.ID
%%%% ¡title!
Feature Importance MLP ID

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportanceAcrossFUN.LABEL
%%%% ¡title!
Feature Importance MLP LABEL

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportanceAcrossFUN.VERBOSE
%%%% ¡title!
VERBOSE ON/OFF

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportanceAcrossFUN.D
%%%% ¡title!
Neural Networks Dataset

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportanceAcrossFUN.NN
%%%% ¡title!
Neural Networks

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportanceAcrossFUN.P
%%%% ¡title!
Permutation Number

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportanceAcrossFUN.APPLY_BONFERRONI
%%%% ¡title!
Bonferroni Correction ON/OFF

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportanceAcrossFUN.APPLY_CONFIDENCE_INTERVALS
%%%% ¡title!
Confidence Intervals ON/OFF

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportanceAcrossFUN.SIG_LEVEL
%%%% ¡title!
Significant level

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportanceAcrossFUN.FEATURE_IMPORTANCE
%%%% ¡title!
Feature Importance Score

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the feature importance analysis for multi-layer perceptron (MLP) across all included graph measures.
%%%% ¡default!
'NNxMLP_FeatureImportanceAcrossFUN'

%%% ¡prop!
NAME (constant, string) is the name of the feature importance analysis for multi-layer perceptron (MLP) across all included graph measures.
%%%% ¡default!
'Feature Importace for Multi-layer Perceptron Across Functional Time Series'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the feature importance analysis for multi-layer perceptron (MLP) across all included graph measures.
%%%% ¡default!
'Neural Network Feature Importance Across Functional Data (NNxMLP_FeatureImportanceAcrossFUN) assesses the importance of brain regions by measuring the increase in model error when its corresponding functional time series values are randomly shuffled.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the feature importance analysis for multi-layer perceptron (MLP) across all included graph measures.
%%%% ¡settings!
'NNxMLP_FeatureImportanceAcrossFUN'

%%% ¡prop!
ID (data, string) is a few-letter code of the feature importance analysis for multi-layer perceptron (MLP) across all included graph measures.
%%%% ¡default!
'NNxMLP_FeatureImportanceAcrossFUN ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the feature importance analysis for multi-layer perceptron (MLP) across all included graph measures.
%%%% ¡default!
'NNxMLP_FeatureImportanceAcrossFUN label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the feature importance analysis for multi-layer perceptron (MLP) across all included graph measures.
%%%% ¡default!
'NNxMLP_FeatureImportanceAcrossFUN notes'

%%% ¡prop!
COMP_FEATURE_INDICES (result, cell) provides the indices of brain regions, represented as a cell array containing sets of feature indices, such as {[1], [2], [3], ...}.
%%%% ¡calculate!

% yuxin do it from here
comp_feature_indices = [];
value = comp_feature_indices;
% yuxin do it until here

%%% ¡prop!
D_SHUFFLED (query, item) generates a shuffled version of the dataset where the time series of one brain region is replaced with random values drawn from a distribution with the same mean and standard deviation as the orginal ones.
%%%% ¡settings!
'NNDataset'
%%%% ¡calculate!

% yuxin do it from here
if isempty(varargin)
    value = NNDataset();
    return
end
comp_feature_combination = varargin{1}; % the composite indexes to be shuffled

d = nnfi.get('D');
dp_it_list = d.get('DP_DICT').get('IT_LIST');
P = nnfi.get('P');

inputs = cell2mat(nnfi.memorize('BASELINE_INPUTS'));
shuffled_inputs = inputs;
for i = 1:length(comp_feature_combination)
    feature_idx = comp_feature_combination(i);
    permuted_value = squeeze(normrnd(mean(inputs(:, feature_idx)), std(inputs(:, feature_idx)), squeeze(size(inputs(:, feature_idx)))));
    shuffled_inputs(:, feature_idx) = permuted_value;
end

for i = 1:length(dp_it_list)
    dp = dp_it_list{i};
    shuffled_input = {shuffled_inputs(i, :)};
    shuffled_dp_list{i} = NNDataPointMLP_Shuffled('SHUFFLED_INPUT', shuffled_input);
end

shuffled_dp_dict = IndexedDictionary(...
        'IT_CLASS', 'NNDataPointMLP_Shuffled', ...
        'IT_LIST', shuffled_dp_list ...
        );

value = NNDataset( ...
    'DP_CLASS', 'NNDataPointMLP_Shuffled', ...
    'DP_DICT', shuffled_dp_dict ...
    );

% yuxin do it until here

%% ¡props!

%%% ¡prop!
GR_FUN_LIST (data, item) is the list of FUN group, which also defines the subject class SubjectFUN.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectFUN')

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GUI
%%%% ¡code!
gui = GUIElement('PE', fi, 'CLOSEREQ', false);
gui.get('DRAW')
gui.get('SHOW')

gui.get('CLOSE')

%%% ¡test!
%%%% ¡name!
Sanity check
%%%% ¡code!
% Load BrainAtlas
im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [fileparts(which('NNDataPoint_FUN_CLA')) filesep 'Example data NN CLA FUN XLS' filesep 'atlas.xlsx'], ...
    'WAITBAR', true ...
    );

ba = im_ba.get('BA');

% Load Groups of SubjectFUN
im_gr1 = ImporterGroupSubjectFUN_XLS( ...
    'DIRECTORY', [fileparts(which('NNDataPoint_FUN_CLA')) filesep 'Example data NN CLA FUN XLS' filesep 'FUN_Group_1_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr1 = im_gr1.get('GR');

im_gr2 = ImporterGroupSubjectFUN_XLS( ...
    'DIRECTORY', [fileparts(which('NNDataPoint_FUN_CLA')) filesep 'Example data NN CLA FUN XLS' filesep 'FUN_Group_2_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr2 = im_gr2.get('GR');

% Analysis FUN WU
a_WU1 = AnalyzeEnsemble_FUN_WU( ...
    'GR', gr1 ...
    );

a_WU2 = AnalyzeEnsemble_FUN_WU( ...
    'TEMPLATE', a_WU1, ...
    'GR', gr2 ...
    );

a_WU1.memorize('G_DICT');
a_WU2.memorize('G_DICT');

%% Create NNData composed of corresponding NNDataPoints
% create item lists of NNDataPoint_Graph_CLA
it_list1 = cellfun(@(x) NNDataPoint_Graph_CLA( ...
    'ID', x.get('ID'), ...
    'G', x, ...
    'TARGET_CLASS', {gr1.get('ID')}), ...
    a_WU1.get('G_DICT').get('IT_LIST'), ...
    'UniformOutput', false);

it_list2 = cellfun(@(x) NNDataPoint_Graph_CLA( ...
    'ID', x.get('ID'), ...
    'G', x, ...
    'TARGET_CLASS', {gr2.get('ID')}), ...
    a_WU2.get('G_DICT').get('IT_LIST'), ...
    'UniformOutput', false);

% create NNDataPoint_Graph_CLA DICT items
it_class = 'NNDataPoint_Graph_CLA';
dp_list1 = IndexedDictionary(...
        'IT_CLASS', it_class, ...
        'IT_LIST', it_list1 ...
        );

dp_list2 = IndexedDictionary(...
        'IT_CLASS', it_class, ...
        'IT_LIST', it_list2 ...
        );

% create a NNDataset containing the NNDataPoint_FUN_CLA DICT
d1 = NNDataset( ...
    'DP_CLASS', it_class, ...
    'DP_DICT', dp_list1 ...
    );

d2 = NNDataset( ...
    'DP_CLASS', it_class, ...
    'DP_DICT', dp_list2 ...
    );

% Split the NNData into training set and test set
d_split1 = NNDatasetSplit('D', d1, 'SPLIT', {0.7, 0.3});
d_split2 = NNDatasetSplit('D', d2, 'SPLIT', {0.7, 0.3});

d_training = NNDatasetCombine('D_LIST', {d_split1.get('D_LIST_IT', 1), d_split2.get('D_LIST_IT', 1)).get('D');
d_test = NNDatasetCombine('D_LIST', {d_split1.get('D_LIST_IT', 2), d_split2.get('D_LIST_IT', 2)).get('D');

% Train a NN
nn = NNClassifierMLP('D', d_training, 'LAYERS', [20 20]);
nn.get('TRAIN');

% Evaluate the feature importance
fi = NNxMLP_FeatureImportanceAcrossFUN('D', d_test, 'NN', nn, 'GR_FUN_LIST', {gr1, gr2}, 'P', 5, 'APPLY_BONFERRONI', true, 'APPLY_CONFIDENCE_INTERVALS', true);
fi_score = fi.get('FEATURE_IMPORTANCE');
num_br = ba.get('BR_DICT').get('LENGTH');

assert(isequal(length(cell2mat(fi_score)), num_br), ...
	        [BRAPH2.STR ':NNxMLP_FeatureImportanceAcrossFUN:' BRAPH2.FAIL_TEST], ...
	        'NNxMLP_FeatureImportanceAcrossFUN does not have the feature importance score array as intended.' ...
	        )