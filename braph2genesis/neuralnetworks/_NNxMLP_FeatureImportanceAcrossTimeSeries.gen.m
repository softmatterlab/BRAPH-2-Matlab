%% ¡header!
NNxMLP_FeatureImportanceAcrossTimeSeries < NNxMLP_FeatureImportance (nnfiam, neural network feature importace for multi-layer perceptron) provides feature importance analysis for multi-layer perceptron (MLP) across all included graph measures.

%%% ¡description!
Neural Network Feature Importance Across Graph Measures (NNxMLP_FeatureImportanceAcrossTimeSeries) 
 assesses the importance of graph measures by measuring the increase in model error 
 when specific graph measure values are randomly shuffled.

%%% ¡seealso!
NNxMLP_FeatureImportance, NNDataPoint_Measure_CLA, NNDataPoint_Measure_REG

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportanceAcrossTimeSeries.ID
%%%% ¡title!
Feature Importance MLP ID

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportanceAcrossTimeSeries.LABEL
%%%% ¡title!
Feature Importance MLP LABEL

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportanceAcrossTimeSeries.VERBOSE
%%%% ¡title!
VERBOSE ON/OFF

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportanceAcrossTimeSeries.D
%%%% ¡title!
Neural Networks Dataset

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportanceAcrossTimeSeries.NN
%%%% ¡title!
Neural Networks

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportanceAcrossTimeSeries.P
%%%% ¡title!
Permutation Number

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportanceAcrossTimeSeries.APPLY_BONFERRONI
%%%% ¡title!
Bonferroni Correction ON/OFF

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportanceAcrossTimeSeries.APPLY_CONFIDENCE_INTERVALS
%%%% ¡title!
Confidence Intervals ON/OFF

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportanceAcrossTimeSeries.SIG_LEVEL
%%%% ¡title!
Significant level

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportanceAcrossTimeSeries.FEATURE_IMPORTANCE
%%%% ¡title!
Feature Importance Score

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the feature importance analysis for multi-layer perceptron (MLP) across all included graph measures.
%%%% ¡default!
'NNxMLP_FeatureImportanceAcrossTimeSeries'

%%% ¡prop!
NAME (constant, string) is the name of the feature importance analysis for multi-layer perceptron (MLP) across all included graph measures.
%%%% ¡default!
'Feature Importace for Multi-layer Perceptron Across Graph Measures'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the feature importance analysis for multi-layer perceptron (MLP) across all included graph measures.
%%%% ¡default!
'Neural Network Feature Importance Across Graph Measures (NNxMLP_FeatureImportanceAcrossTimeSeries) assesses the importance of graph measures by measuring the increase in model error when specific graph measure values are randomly shuffled.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the feature importance analysis for multi-layer perceptron (MLP) across all included graph measures.
%%%% ¡settings!
'NNxMLP_FeatureImportanceAcrossTimeSeries'

%%% ¡prop!
ID (data, string) is a few-letter code of the feature importance analysis for multi-layer perceptron (MLP) across all included graph measures.
%%%% ¡default!
'NNxMLP_FeatureImportanceAcrossTimeSeries ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the feature importance analysis for multi-layer perceptron (MLP) across all included graph measures.
%%%% ¡default!
'NNxMLP_FeatureImportanceAcrossTimeSeries label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the feature importance analysis for multi-layer perceptron (MLP) across all included graph measures.
%%%% ¡default!
'NNxMLP_FeatureImportanceAcrossTimeSeries notes'

%%% ¡prop!
FEATURE_IMPORTANCE (result, cell) is determined by applying Bonferroni correction for the permutation and obtaining the value by the average of the permutation number times of shuffled loss, which then in trun are divided by base loss for normalizaiton.
%%%% ¡gui!
input_dataset = nnfiam.get('D');
m_list = input_dataset.get('DP_DICT').get('IT', 1).get('M_LIST');
pr = PanelPropCell('EL', nnfiam, 'PROP', NNxMLP_FeatureImportanceAcrossTimeSeries.FEATURE_IMPORTANCE, ...
    'TABLE_HEIGHT', s(40), ...
    'ROWNAME', {}, ...
    'COLUMNNAME', m_list, ...
    varargin{:});

%%% ¡prop!
COMP_FEATURE_INDICES (result, cell) provides the indices of combined features, represented as a cell array containing sets of feature indices, such as {[1, 2], [2, 3], [1, 3]}.
%%%% ¡calculate!
input_dataset = nnfiam.get('D');
if isa(input_dataset.getr('DP_DICT'), 'NoValue')
    value = {};
    return
end
m_list = input_dataset.get('DP_DICT').get('IT', 1).get('M_LIST');
example_input_cell = input_dataset.get('DP_DICT').get('IT', 1).get('INPUT');
for i = 1:length(m_list)
    single_measure_indexes = nnfiam.get('INPUT_MASK', example_input_cell, i, 1);
    flattened_indexes = nnfiam.get('FLATTEN_CELL', single_measure_indexes);
    comp_feature_indices{i} = find(flattened_indexes);
end

value = comp_feature_indices;

%% ¡props!

%%% ¡prop!
INPUT_MASK (query, empty) creates a mask that covers the top-level index of interest in the input cell array, maintaining the same structure.
%%%% ¡calculate!
if isempty(varargin)
    value = {};
    return
end
cell_array = varargin{1};
index = varargin{2};
current_level = varargin{3};
mask = cell(size(cell_array));

for i = 1:length(cell_array)
    if iscell(cell_array{i})
        if ismember(i, index)
            index_for_cell = 1:1:length(cell_array{i});
        else
            index_for_cell = 0;
        end
        mask{i} = NNxMLP_FeatureImportanceAcrossTimeSeries().get('INPUT_MASK' ,cell_array{i}, index_for_cell, current_level + 1);
    else
        if ismember(i, index)
            mask{i} = ones(size(cell_array{i}));
        else
            mask{i} = zeros(size(cell_array{i}));
        end
    end
end
value = mask;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Test INPUT_MASK the query for simple cell array
%%%% ¡code!
target_cell = {[1 2], [3 4], [5 6 7]};
target_index = [1 2 3];
mask_cell{1} = {[1 1], [0 0], [0 0 0]};
mask_cell{2} = {[0 0], [1 1], [0 0 0]};
mask_cell{3} = {[0 0], [0 0], [1 1 1]};

for i = 1:length(target_index)
    index = target_index(i);
    generated_mask_cell = NNxMLP_FeatureImportanceAcrossTimeSeries().get('INPUT_MASK', target_cell, index, 1);

    assert(isequal(generated_mask_cell, mask_cell{i}), ...
        [BRAPH2.STR ':NNxMLP_FeatureImportanceAcrossTimeSeries:' BRAPH2.FAIL_TEST], ...
        'NNxMLP_FeatureImportanceAcrossTimeSeries does not create the input mask of interest correctly.' ...
        )
end

%%% ¡test!
%%%% ¡name!
Test INPUT_MASK the query for multiple nested cell array
%%%% ¡code!
target_cell = {{[1 2], [3 4], [5 6 7]}, {[8], [9 10]}};
target_index = [1 2];
mask_cell{1} = {{[1 1], [1 1], [1 1 1]}, {[0], [0 0]}};
mask_cell{2} = {{[0 0], [0 0], [0 0 0]}, {[1], [1 1]}};

for i = 1:length(target_index)
    index = target_index(i);
    generated_mask_cell = NNxMLP_FeatureImportanceAcrossTimeSeries().get('INPUT_MASK', target_cell, index, 1);

    assert(isequal(generated_mask_cell, mask_cell{i}), ...
        [BRAPH2.STR ':NNxMLP_FeatureImportanceAcrossTimeSeries:' BRAPH2.FAIL_TEST], ...
        'NNxMLP_FeatureImportanceAcrossTimeSeries does not create the input mask of interest correctly.' ...
        )
end

%%% ¡test!
%%%% ¡name!
Example CON FUN
%%%% ¡code!
create_data_NN_CLA_CON_FUN_MP_XLS() % only creates files if the example folder doesn't already exist

% Load BrainAtlas
im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [fileparts(which('NNDataPoint_CON_FUN_MP_CLA')) filesep 'Example data NN CLA CON_FUN_MP XLS' filesep 'atlas.xlsx'], ...
    'WAITBAR', true ...
    );

ba = im_ba.get('BA');

% Load Groups of SubjectCON
im_gr1 = ImporterGroupSubjectCON_XLS( ...
    'DIRECTORY', [fileparts(which('NNDataPoint_CON_FUN_MP_CLA')) filesep 'Example data NN CLA CON_FUN_MP XLS' filesep 'Connectivity' filesep 'CON_FUN_MP_Group1_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr1_CON = im_gr1.get('GR');

im_gr2 = ImporterGroupSubjectCON_XLS( ...
    'DIRECTORY', [fileparts(which('NNDataPoint_CON_FUN_MP_CLA')) filesep 'Example data NN CLA CON_FUN_MP XLS' filesep 'Connectivity' filesep 'CON_FUN_MP_Group2_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr2_CON = im_gr2.get('GR');

im_gr3 = ImporterGroupSubjectCON_XLS( ...
    'DIRECTORY', [fileparts(which('NNDataPoint_CON_FUN_MP_CLA')) filesep 'Example data NN CLA CON_FUN_MP XLS' filesep 'Connectivity' filesep 'CON_FUN_MP_Group3_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr3_CON = im_gr3.get('GR');

% Load Groups of SubjectFUN
im_gr1 = ImporterGroupSubjectFUN_XLS( ...
    'DIRECTORY', [fileparts(which('NNDataPoint_CON_FUN_MP_CLA')) filesep 'Example data NN CLA CON_FUN_MP XLS' filesep 'Functional' filesep 'CON_FUN_MP_Group1_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr1_FUN = im_gr1.get('GR');

im_gr2 = ImporterGroupSubjectFUN_XLS( ...
    'DIRECTORY', [fileparts(which('NNDataPoint_CON_FUN_MP_CLA')) filesep 'Example data NN CLA CON_FUN_MP XLS' filesep 'Functional' filesep 'CON_FUN_MP_Group2_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr2_FUN = im_gr2.get('GR');

im_gr3 = ImporterGroupSubjectFUN_XLS( ...
    'DIRECTORY', [fileparts(which('NNDataPoint_CON_FUN_MP_CLA')) filesep 'Example data NN CLA CON_FUN_MP XLS' filesep 'Functional' filesep 'CON_FUN_MP_Group3_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr3_FUN = im_gr3.get('GR');

% Combine Groups of SubjectCON with Groups of SubjectFUN
co_gr1 = CombineGroups_CON_FUN_MP( ...
    'GR_CON', gr1_CON, ...
    'GR_FUN', gr1_FUN, ...
    'WAITBAR', true ...
    );
gr1 = co_gr1.get('GR_CON_FUN_MP');

co_gr2 = CombineGroups_CON_FUN_MP( ...
    'GR_CON', gr2_CON, ...
    'GR_FUN', gr2_FUN, ...
    'WAITBAR', true ...
    );
gr2 = co_gr2.get('GR_CON_FUN_MP');

co_gr3 = CombineGroups_CON_FUN_MP( ...
    'GR_CON', gr3_CON, ...
    'GR_FUN', gr3_FUN, ...
    'WAITBAR', true ...
    );
gr3 = co_gr3.get('GR_CON_FUN_MP');

% Analysis CON BUD
densities = 5;

a_BUD1 = AnalyzeEnsemble_CON_FUN_MP_BUD( ...
    'GR', gr1, ...
    'DENSITIES', densities ...
    );

a_BUD2 = AnalyzeEnsemble_CON_FUN_MP_BUD( ...
    'TEMPLATE', a_BUD1, ...
    'GR', gr2, ...
    'DENSITIES', densities ...
    );

a_BUD3 = AnalyzeEnsemble_CON_FUN_MP_BUD( ...
    'TEMPLATE', a_BUD1, ...
    'GR', gr3, ...
    'DENSITIES', densities ...
    );

a_BUD1.get('MEASUREENSEMBLE', 'OverlappingDeg').get('M');
a_BUD1.get('MEASUREENSEMBLE', 'OverlappingDegAv').get('M');
a_BUD1.get('MEASUREENSEMBLE', 'EdgeOverlap').get('M');
a_BUD1.get('MEASUREENSEMBLE', 'Degree').get('M');

a_BUD2.get('MEASUREENSEMBLE', 'OverlappingDeg').get('M');
a_BUD2.get('MEASUREENSEMBLE', 'OverlappingDegAv').get('M');
a_BUD2.get('MEASUREENSEMBLE', 'EdgeOverlap').get('M');
a_BUD2.get('MEASUREENSEMBLE', 'Degree').get('M');

a_BUD3.get('MEASUREENSEMBLE', 'OverlappingDeg').get('M');
a_BUD3.get('MEASUREENSEMBLE', 'OverlappingDegAv').get('M');
a_BUD3.get('MEASUREENSEMBLE', 'EdgeOverlap').get('M');
a_BUD3.get('MEASUREENSEMBLE', 'Degree').get('M');

% Create NNData composed of corresponding NNDataPoints
[~, group_folder_name] = fileparts(im_gr1.get('DIRECTORY'));
it_list1 = cellfun(@(x) NNDataPoint_Measure_CLA( ...
    'ID', x.get('ID'), ...
    'G', x, ...
    'M_LIST', a_BUD1.get('ME_DICT').get('KEYS'), ...
    'TARGET_CLASS', {group_folder_name}), ...
    a_BUD1.get('G_DICT').get('IT_LIST'), ...
    'UniformOutput', false);

[~, group_folder_name] = fileparts(im_gr2.get('DIRECTORY'));
it_list2 = cellfun(@(x) NNDataPoint_Measure_CLA( ...
    'ID', x.get('ID'), ...
    'G', x, ...
    'M_LIST', a_BUD2.get('ME_DICT').get('KEYS'), ...
    'TARGET_CLASS', {group_folder_name}), ...
    a_BUD2.get('G_DICT').get('IT_LIST'), ...
    'UniformOutput', false);

[~, group_folder_name] = fileparts(im_gr3.get('DIRECTORY'));
it_list3 = cellfun(@(x) NNDataPoint_Measure_CLA( ...
    'ID', x.get('ID'), ...
    'G', x, ...
    'M_LIST', a_BUD3.get('ME_DICT').get('KEYS'), ...
    'TARGET_CLASS', {group_folder_name}), ...
    a_BUD3.get('G_DICT').get('IT_LIST'), ...
    'UniformOutput', false);

% create NNDataPoint_Measure_CLA DICT items
dp_list1 = IndexedDictionary(...
        'IT_CLASS', 'NNDataPoint_Measure_CLA', ...
        'IT_LIST', it_list1 ...
        );

dp_list2 = IndexedDictionary(...
        'IT_CLASS', 'NNDataPoint_Measure_CLA', ...
        'IT_LIST', it_list2 ...
        );

dp_list3 = IndexedDictionary(...
        'IT_CLASS', 'NNDataPoint_Measure_CLA', ...
        'IT_LIST', it_list3 ...
        );

% create a NNDataset containing the NNDataPoint_Measure_CLA DICT
d1 = NNDataset( ...
    'DP_CLASS', 'NNDataPoint_Measure_CLA', ...
    'DP_DICT', dp_list1 ...
    );

d2 = NNDataset( ...
    'DP_CLASS', 'NNDataPoint_Measure_CLA', ...
    'DP_DICT', dp_list2 ...
    );

d3 = NNDataset( ...
    'DP_CLASS', 'NNDataPoint_Measure_CLA', ...
    'DP_DICT', dp_list3 ...
    );

% Split the NNData into training set and test set
d_split1 = NNDatasetSplit('D', d1, 'SPLIT', {0.7, 0.3});
d_split2 = NNDatasetSplit('D', d2, 'SPLIT', {0.7, 0.3});
d_split3 = NNDatasetSplit('D', d3, 'SPLIT', {0.7, 0.3});

d_training = NNDatasetCombine('D_LIST', {d_split1.get('D_LIST_IT', 1), d_split2.get('D_LIST_IT', 1), d_split3.get('D_LIST_IT', 1)}).get('D');
d_test = NNDatasetCombine('D_LIST', {d_split1.get('D_LIST_IT', 2), d_split2.get('D_LIST_IT', 2), d_split3.get('D_LIST_IT', 2)}).get('D');

% Create a MLP classifier with training set
nn = NNClassifierMLP('D', d_training, 'LAYERS', [20 20]);
nn.get('TRAIN');

% Evaluate the feature importance
fi = NNxMLP_FeatureImportanceAcrossTimeSeries('D', d_test, 'NN', nn, 'P', 5, 'APPLY_BONFERRONI', false, 'APPLY_CONFIDENCE_INTERVALS', false);
fi_score = fi.get('RESHAPED_FEATURE_IMPORTANCE');
input_measure = it_list1{1}.get('M_LIST');

assert(isequal(size(cell2mat(fi_score)), size(input_measure)), ...
	        [BRAPH2.STR ':NNxMLP_FeatureImportance:' BRAPH2.FAIL_TEST], ...
	        'NNxMLP_FeatureImportance does not have the feature importance score array of the same feature size as the input data.' ...
	        )

fi_composite_indices = fi.get('COMP_FEATURE_INDICES');
input_example = it_list1{1}.get('INPUT');

for i = 1:length(fi_composite_indices)
    index_length_fi = numel(fi_composite_indices{i});
    index_length_input = numel(cell2mat(input_example{i}));
    check(i) = isequal(index_length_fi, index_length_input);
end

assert(all(check), ...
    [BRAPH2.STR ':NNxMLP_FeatureImportanceAcrossTimeSeries:' BRAPH2.FAIL_TEST], ...
    'NNxMLP_FeatureImportanceAcrossTimeSeries does not calculate composite feature indices correctly. ' ...
    )


fi_score = cell2mat(fi_score);
for i = 1:length(input_measure)
    check(i) = ~isequal(fi_score(i), 0);
end
assert(all(check), ...
    [BRAPH2.STR ':NNxMLP_FeatureImportance:' BRAPH2.FAIL_TEST], ...
    'NNxMLP_FeatureImportance does not calculate feature importance score array correctly. Each feature should hold a non-zero number because there is no bonferroni correction.' ...
    )

% Test gui
gui = GUIElement('PE', fi, 'CLOSEREQ', false);
gui.get('DRAW')
gui.get('SHOW')

gui.get('CLOSE')