%% ¡header!
NNxMLP_FeatureImportance < ConcreteElement (nnfi, neural network feature importace for multi-layer perceptron) provides feature importance analysis for multi-layer perceptron (MLP) using shuffled feature method.

%%% ¡description!
A neural network feature importace for multi-layer perceptron (NNxMLP_FeatureImportance) 
 assesses the importance of features by measuring the increase in model error when the feature values are randomly shuffled. 
It introduces the permutation method to establish the significance of each feature (or composite features) by comparing the 
 original model loss to the distribution of losses obtained from several shuffled iterations, providing a robust statistical 
 analysis of feature importance using a user-defined confidence interval and adjusting for multiple comparisons with the Bonferroni correction.

%%% ¡seealso!
NNDataset, NNDataPointMLP_Shuffled, NNRegressorMLP, NNClassifierMLP, NNxMLP_FeatureImportanceAcrossMeasures

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportance.ID
%%%% ¡title!
Feature Importance MLP ID

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportance.LABEL
%%%% ¡title!
Feature Importance MLP LABEL

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportance.VERBOSE
%%%% ¡title!
VERBOSE ON/OFF

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportance.D
%%%% ¡title!
Neural Networks Dataset

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportance.NN
%%%% ¡title!
Neural Networks

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportance.P
%%%% ¡title!
Permutation Number

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportance.APPLY_BONFERRONI
%%%% ¡title!
Bonferroni Correction ON/OFF

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportance.APPLY_CONFIDENCE_INTERVALS
%%%% ¡title!
Confidence Interval ON/OFF

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportance.SIG_LEVEL
%%%% ¡title!
Significant Level

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportance.FEATURE_IMPORTANCE
%%%% ¡title!
Feature Importance Score

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the feature importance analysis.
%%%% ¡default!
'NNxMLP_FeatureImportance'

%%% ¡prop!
NAME (constant, string) is the name of the feature importance analysis.
%%%% ¡default!
'Neural Network Feature Importace for Multi-layer Perceptron'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the feature importance analysis.
%%%% ¡default!
'A neural network feature importace for multi-layer perceptron (NNxMLP_FeatureImportance) assesses the importance of features by measuring the increase in model error when the feature values are randomly shuffled. It introduces the permutation method to establish the significance of each feature (or composite features) by comparing the original model loss to the distribution of losses obtained from several shuffled iterations, providing a robust statistical analysis of feature importance using a user-defined confidence interval and adjusting for multiple comparisons with the Bonferroni correction.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the feature importance analysis.
%%%% ¡settings!
'NNxMLP_FeatureImportance'

%%% ¡prop!
ID (data, string) is a few-letter code of the feature importance analysis.
%%%% ¡default!
'NNxMLP_FeatureImportance ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the feature importance analysis.
%%%% ¡default!
'NNxMLP_FeatureImportance label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the feature importance analysis.
%%%% ¡default!
'NNxMLP_FeatureImportance notes'

%% ¡props!

%%% ¡prop!
D (data, item) is the neural networks dataset for feature importance analysis.
%%%% ¡settings!
'NNDataset'

%%% ¡prop!
NN (data, item) contains a trained neural network multi-layer perceptron classifier or regressor.
%%%% ¡settings!
'NNBase'
%%%% ¡check_prop!
check = any(strcmp(value.get('ELCLASS'), {'NNBase', 'NNClassifierMLP', 'NNRegressorMLP'}));

%%% ¡prop!
P (parameter, scalar) is the permutation number that determines the statistical significance of the specific feature. 
%%%% ¡default!
1e+2
%%%% ¡check_prop!
check = value > 0 && value == round(value);

%%% ¡prop!
PERM_SEEDS (result, rvector) is the list of seeds for the random permutations.
%%%% ¡calculate!
value = randi(intmax('uint32'), 1, nnfi.get('P'));

%%% ¡prop!
APPLY_CONFIDENCE_INTERVALS (parameter, logical) determines whether to apply user-defined percent confidence interval.
%%%% ¡default!
true

%%% ¡prop!
SIG_LEVEL (parameter, scalar) determines the significant level.
%%%% ¡default!
0.05

%%% ¡prop!
APPLY_BONFERRONI (parameter, logical) determines whether to apply Bonferroni correction.
%%%% ¡default!
true

%%% ¡prop!
BASELINE_INPUTS (result, cell) retrieves the input data to be shuffled.
%%%% ¡calculate!
value = nnfi.get('NN').get('INPUTS', nnfi.get('D'));

%%% ¡prop!
COMP_FEATURE_INDICES (result, cell) provides the indices of combined features, represented as a cell array containing sets of feature indices, such as {[1], [2], [3]} by default, or {[1, 2], [2, 3], [1, 3]}.
%%%% ¡calculate!
inputs = cell2mat(nnfi.memorize('BASELINE_INPUTS'));
num_feature = size(inputs, 2);
value = num2cell(1:num_feature);

%%% ¡prop!
D_SHUFFLED (query, item) generates a shuffled version of the dataset where the features of given indexes are replaced with random values drawn from a distribution with the same mean and standard deviation as the orginal ones.
%%%% ¡settings!
'NNDataset'
%%%% ¡calculate!
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

%%% ¡prop!
BASELINE_LOSS (result, scalar) is the loss value obtained from original dataset, acting as a baseline loss value for evaluating the feature importance.
%%%% ¡calculate!
d = nnfi.get('D');
nn = nnfi.get('NN');
net = nn.get('MODEL');
inputs = cell2mat(nnfi.memorize('BASELINE_INPUTS'));
targets = nn.get('TARGETS', d);
if isempty(inputs)
    baseline_loss = 0;
else
    baseline_loss = crossentropy(net.predict(inputs), targets);
end
value = baseline_loss;

%%% ¡prop!
SHUFFLED_LOSS (query, rvector) is the loss value obtained from shuffled datasets.
%%%% ¡calculate!
if isempty(varargin)
    value = [];
    return
end
seed = varargin{1};
rng(seed, 'twister')

shuffled_loss = [];
d = nnfi.get('D');
if isa(d.getr('DP_DICT'), 'NoValue')
    value = shuffled_loss;
    return
end

nn = nnfi.get('NN');
targets = nn.get('TARGETS', d);

comp_feature_indices = nnfi.get('COMP_FEATURE_INDICES');
num_comp_feature_combinations = length(comp_feature_indices);
leap_parallel = 2^10;
shuffled_loss = [];

start = tic;
for j = 1:leap_parallel:num_comp_feature_combinations
    for i = j:min(j+leap_parallel, num_comp_feature_combinations)
        comp_feature_combination = comp_feature_indices{i};
        d_perm = nnfi.get('D_SHUFFLED', comp_feature_combination);
        predictions = nn.get('PREDICT', d_perm);
        scrambled_loss = crossentropy(predictions, targets);
        shuffled_loss(i) = scrambled_loss;
    end
    if nnfi.get('VERBOSE')
        disp(['** PERMUTATION FEATURE IMPORTANCE - (composite) features #' int2str(min(j+leap_parallel-1, num_comp_feature_combinations)) '/' int2str(num_comp_feature_combinations) ' - ' int2str(toc(start)) '.' int2str(mod(toc(start), 1) * 10) 's'])
    end
    if nnfi.get('INTERRUPTIBLE')
        pause(nnfi.get('INTERRUPTIBLE'))
    end
end

value = shuffled_loss;

%%% ¡prop!
PERM_SHUFFLED_LOSS (result, cell) is the permutation test for obtaining shuffled loss for a number of times in order to establish confidence interval.
%%%% ¡calculate!
nnfi.memorize('BASELINE_INPUTS');
p = nnfi.get('P');
seeds = nnfi.get('PERM_SEEDS');
value = {};
leap_parallel = 2^5;
wb = braph2waitbar(nnfi.get('WAITBAR'), 0, ['Feature importance permutation ...']);

% % % delete(gcp('nocreate')); parpool('Threads'); % add a property to config Threads or Processes for the profile 
start = tic;
for j = 1:leap_parallel:p
    parfor i = j:min(j+leap_parallel, p)
        perm_shuflled_loss{i} = nnfi.get('SHUFFLED_LOSS', seeds(i));
    end
    if nnfi.get('VERBOSE')
        disp(['** PERMUTATION FEATURE IMPORTANCE - sampling #' int2str(min(j+leap_parallel-1, p)) '/' int2str(p) ' - ' int2str(toc(start)) '.' int2str(mod(toc(start), 1) * 10) 's'])
    end
    if nnfi.get('INTERRUPTIBLE')
        pause(nnfi.get('INTERRUPTIBLE'))
    end
    braph2waitbar(wb, .15 + .85 * min(j+leap_parallel-1, p) / p, ['Permutation sampling # ' num2str(min(j+leap_parallel-1, p)) ' of ' num2str(p) ' ...'])
end

braph2waitbar(wb, 'close')

value = perm_shuflled_loss;

%%% ¡prop!
CONFIDENCE_INTERVALS (query, rvector) derives the 95 percent of confidence interval for the permuation of shuffled loss values.
%%%% ¡calculate!
if isempty(varargin)
    value = [];
    return
end
data = varargin{1};
sig_level = varargin{2};
sampleMean = mean(data); % Mean of the data
sampleStd = std(data); % Std of the data
n = numel(data);  % Sample size
z = norminv(1 - sig_level/2);  % Z-score for the desired confidence level
marginError = z * sampleStd / sqrt(n);  % Margin of error
value = [sampleMean - marginError, sampleMean + marginError];

%%% ¡prop!
STAT_SIG_MASK (result, rvector) provides the statistical significance mask for composite features indicating which composite features has significant contribution.
%%%% ¡calculate!
perm_shuffled_loss = nnfi.memorize('PERM_SHUFFLED_LOSS');
perm_shuffled_loss = cell2mat(perm_shuffled_loss.');
baseline_loss = nnfi.get('BASELINE_LOSS');

comp_feature_indices = nnfi.get('COMP_FEATURE_INDICES');
num_comp_feature_combinations = length(comp_feature_indices);

sig_level = nnfi.get('SIG_LEVEL');
if nnfi.get('APPLY_BONFERRONI')
    sig_level = sig_level / num_comp_feature_combinations;
end

significant_flags = [];
for i = 1:num_comp_feature_combinations
    perm_values = squeeze(perm_shuffled_loss(:, i));
    confidenceInterval = nnfi.get('CONFIDENCE_INTERVALS', perm_values, sig_level);
    if confidenceInterval(1) - baseline_loss > 1e-04
        significant_flag = 1;
    else
        significant_flag = 0;
    end
    significant_flags(i) = significant_flag;
end

value = significant_flags;

%%% ¡prop!
FEATURE_IMPORTANCE (result, cell) is determined by applying Bonferroni correction for the permutation and obtaining the value by the average of the permutation number times of shuffled loss, which then in trun are divided by base loss for normalizaiton.
%%%% ¡calculate!
nnfi.memorize('BASELINE_INPUTS');
baseline_loss = nnfi.memorize('BASELINE_LOSS');
perm_shuffled_loss = nnfi.memorize('PERM_SHUFFLED_LOSS');
perm_shuffled_loss = cell2mat(perm_shuffled_loss.');

comp_feature_indices = nnfi.get('COMP_FEATURE_INDICES');
num_comp_feature_combinations = length(comp_feature_indices);

fi_value = mean(perm_shuffled_loss, 1)/baseline_loss;

if nnfi.get('APPLY_CONFIDENCE_INTERVALS') 
    statistic_significance_mask = nnfi.get('STAT_SIG_MASK');
    fi_value(~statistic_significance_mask) = 0;
end

value = {fi_value};

%%% ¡prop!
RESHAPED_FEATURE_IMPORTANCE (query, empty) reshapes the cell of feature importances with the input data.
%%%% ¡calculate!
cell1 = nnfi.get('FEATURE_IMPORTANCE');
d = nnfi.get('D');
if isa(d.getr('DP_DICT'), 'NoValue')
    value = {};
    return
end
cell2 = d.get('DP_DICT').get('IT', 1).get('INPUT');
if ~isequal(numel(cell2mat(cell1)), numel(cell2)) 
    cell1 = nnfi.get('MAP_TO_CELL', cell2mat(cell1), cell2);
end

value = cell1;

%%% ¡prop!
MAP_TO_CELL (query, empty) maps a single vector back to the original cell array structure.
%%%% ¡calculate!
if isempty(varargin)
    value = {};
    return
end
vector = varargin{1};
cell_template = varargin{2};
mappedCellArray = cell_template;
index = 1;
for i = 1:numel(cell_template)
    cellData = cell_template{i};
    if iscell(cellData)
        % Map the vector to nested cell arrays recursively
        numElements = nnfi.get('COUNT_ELEMENTS', cellData);
        nestedVector = vector(index:index + numElements - 1);
        mappedCellArray{i} = nnfi.get('MAP_TO_CELL', nestedVector, cellData);
        index = index + numElements;
    else
        % Assign elements from the vector to cells
        numElements = numel(cellData);
        mappedCellArray{i} = reshape(vector(index:index + numElements - 1), size(cellData));
        index = index + numElements;
    end
end

value = mappedCellArray;

%%% ¡prop!
COUNT_ELEMENTS (query, empty) counts the total number of elements within a nested cell array.
%%%% ¡calculate!
if isempty(varargin)
    value = {};
    return
end
cell_data = varargin{1};
count = 0;
for i = 1:numel(cell_data)
    if iscell(cell_data{i})
        count = count + nnfi.get('COUNT_ELEMENTS', cell_data{i});
    else
        count = count + numel(cell_data{i});
    end
end

value = count;

%%% ¡prop!
FLATTEN_CELL (query, empty) flattens a cell array into to a single vector.
%%%% ¡calculate!
if isempty(varargin)
    value = {};
    return
end
cell_input = varargin{1};
flattened_input = [];
while ~isempty(cell_input)
    currentData = cell_input{end};  % Get the last element from the stack
    cell_input = cell_input(1:end-1);   % Remove the last element

    if iscell(currentData)
        % If it's a cell array, add its contents to the stack
        cell_input = [cell_input currentData{:}];
    else
        % If it's numeric or other data, append it to the vector
        flattened_input = [currentData(:); flattened_input];
    end
end
value = flattened_input;

%%% ¡prop!
VERBOSE (gui, logical) is an indicator to display permutation progress information.
%%%% ¡default!
false

%%% ¡prop!
WAITBAR (gui, logical) determines whether to show the waitbar.
%%%% ¡default!
true

%%% ¡prop!
INTERRUPTIBLE (gui, scalar) sets whether the permutation computation is interruptible for multitasking.
%%%% ¡default!
.001

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Map a vector to a simple cell array
%%%% ¡code!
target_cell = {[1 2], [3 4], [5 6 7]};
input_vector = [1; 2; 3; 4; 5; 6; 7];

flattened_cell = NNxMLP_FeatureImportance().get('FLATTEN_CELL', target_cell);

assert(isequal(flattened_cell, input_vector), ...
        [BRAPH2.STR ':NNxMLP_FeatureImportance:' BRAPH2.FAIL_TEST], ...
        'NNxMLP_FeatureImportance does not flatten the simple cell array correctly.' ...
        )

mapped_cell = NNxMLP_FeatureImportance().get('MAP_TO_CELL', input_vector, target_cell);

assert(isequal(mapped_cell, target_cell), ...
        [BRAPH2.STR ':NNxMLP_FeatureImportance:' BRAPH2.FAIL_TEST], ...
        'NNxMLP_FeatureImportance does not reshape the data to simple cell array correctly.' ...
        )

%%% ¡test!
%%%% ¡name!
Map a vector to a nested cell array
%%%% ¡code!
target_cell = {[1 2], [3 4], [5 6 7]};
target_cell = {target_cell};
input_vector = [1; 2; 3; 4; 5; 6; 7];

flattened_cell = NNxMLP_FeatureImportance().get('FLATTEN_CELL', target_cell);

assert(isequal(flattened_cell, input_vector), ...
        [BRAPH2.STR ':NNxMLP_FeatureImportance:' BRAPH2.FAIL_TEST], ...
        'NNxMLP_FeatureImportance does not flatten the simple cell array correctly.' ...
        )

mapped_cell = NNxMLP_FeatureImportance().get('MAP_TO_CELL', input_vector, target_cell);

assert(isequal(mapped_cell, target_cell), ...
        [BRAPH2.STR ':NNxMLP_FeatureImportance:' BRAPH2.FAIL_TEST], ...
        'NNxMLP_FeatureImportance does not reshape the data to nested cell array shape correctly.' ...
        )

%%% ¡test!
%%%% ¡name!
Map a vector to a multiple nested cell array
%%%% ¡code!
target_cell = {{[1 2], [3 4], [5 6 7]}, {[8], [9 10]}};
input_vector = [1; 2; 3; 4; 5; 6; 7; 8; 9; 10];

flattened_cell = NNxMLP_FeatureImportance().get('FLATTEN_CELL', target_cell);

assert(isequal(flattened_cell, input_vector), ...
        [BRAPH2.STR ':NNxMLP_FeatureImportance:' BRAPH2.FAIL_TEST], ...
        'NNxMLP_FeatureImportance does not flatten the simple cell array correctly.' ...
        )

mapped_cell = NNxMLP_FeatureImportance().get('MAP_TO_CELL', input_vector, target_cell);

assert(isequal(mapped_cell, target_cell), ...
        [BRAPH2.STR ':NNxMLP_FeatureImportance:' BRAPH2.FAIL_TEST], ...
        'NNxMLP_FeatureImportance does not reshape the data to multiple nested cell array shape correctly.' ...
        )

%%% ¡test!
%%%% ¡name!
Map a vector to a deep nested cell array
%%%% ¡code!
target_cell = {{{[11 12]}, {[13]}}};
input_vector = [11; 12; 13];

flattened_cell = NNxMLP_FeatureImportance().get('FLATTEN_CELL', target_cell);

assert(isequal(flattened_cell, input_vector), ...
        [BRAPH2.STR ':NNxMLP_FeatureImportance:' BRAPH2.FAIL_TEST], ...
        'NNxMLP_FeatureImportance does not flatten the simple cell array correctly.' ...
        )

mapped_cell = NNxMLP_FeatureImportance().get('MAP_TO_CELL', input_vector, target_cell);

assert(isequal(mapped_cell, target_cell), ...
        [BRAPH2.STR ':NNxMLP_FeatureImportance:' BRAPH2.FAIL_TEST], ...
        'NNxMLP_FeatureImportance does not reshape the data to deep nested cell array shape correctly.' ...
        )

%%% ¡test!
%%%% ¡name!
Example ST
%%%% ¡code!
create_data_NN_CLA_ST_XLS() % only creates files if the example folder doesn't already exist

% Load BrainAtlas
im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [fileparts(which('NNDataPoint_ST_CLA')) filesep 'Example data NN CLA ST XLS' filesep 'atlas.xlsx'], ...
    'WAITBAR', true ...
    );

ba = im_ba.get('BA');

% Load Groups of SubjectST
im_gr1 = ImporterGroupSubjectST_XLS( ...
    'FILE', [fileparts(which('NNDataPoint_ST_CLA')) filesep 'Example data NN CLA ST XLS' filesep 'ST_Group_1.xlsx'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr1 = im_gr1.get('GR');

im_gr2 = ImporterGroupSubjectST_XLS( ...
    'FILE', [fileparts(which('NNDataPoint_ST_CLA')) filesep 'Example data NN CLA ST XLS' filesep 'ST_Group_2.xlsx'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr2 = im_gr2.get('GR');

im_gr3 = ImporterGroupSubjectST_XLS( ...
    'FILE', [fileparts(which('NNDataPoint_ST_CLA')) filesep 'Example data NN CLA ST XLS' filesep 'ST_Group_3.xlsx'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr3 = im_gr3.get('GR');

% Training-test split
% create item lists of NNDataPoint_ST_CLA
it_list1 = cellfun(@(x) NNDataPoint_ST_CLA( ...
    'ID', x.get('ID'), ...
    'SUB', x, ...
    'TARGET_CLASS', {gr1.get('ID')}), ...
    gr1.get('SUB_DICT').get('IT_LIST'), ...
    'UniformOutput', false);

it_list2 = cellfun(@(x) NNDataPoint_ST_CLA( ...
    'ID', x.get('ID'), ...
    'SUB', x, ...
    'TARGET_CLASS', {gr2.get('ID')}), ...
    gr2.get('SUB_DICT').get('IT_LIST'), ...
    'UniformOutput', false);

it_list3 = cellfun(@(x) NNDataPoint_ST_CLA( ...
    'ID', x.get('ID'), ...
    'SUB', x, ...
    'TARGET_CLASS', {gr3.get('ID')}), ...
    gr3.get('SUB_DICT').get('IT_LIST'), ...
    'UniformOutput', false);

% create NNDataPoint_ST_CLA DICT items
dp_list1 = IndexedDictionary(...
        'IT_CLASS', 'NNDataPoint_ST_CLA', ...
        'IT_LIST', it_list1 ...
        );

dp_list2 = IndexedDictionary(...
        'IT_CLASS', 'NNDataPoint_ST_CLA', ...
        'IT_LIST', it_list2 ...
        );

dp_list3 = IndexedDictionary(...
        'IT_CLASS', 'NNDataPoint_ST_CLA', ...
        'IT_LIST', it_list3 ...
        );

% create a NNDataset containing the NNDataPoint_ST_CLA DICT
d1 = NNDataset( ...
    'DP_CLASS', 'NNDataPoint_ST_CLA', ...
    'DP_DICT', dp_list1 ...
    );

d2 = NNDataset( ...
    'DP_CLASS', 'NNDataPoint_ST_CLA', ...
    'DP_DICT', dp_list2 ...
    );

d3 = NNDataset( ...
    'DP_CLASS', 'NNDataPoint_ST_CLA', ...
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
fi = NNxMLP_FeatureImportance('D', d_test, 'NN', nn, 'P', 5, 'APPLY_BONFERRONI', true, 'APPLY_CONFIDENCE_INTERVALS', true);
fi_score = fi.get('RESHAPED_FEATURE_IMPORTANCE');
input_dp = it_list1{1}.get('INPUT');

assert(isequal(size(cell2mat(fi_score)), size(cell2mat(input_dp))), ...
	        [BRAPH2.STR ':NNxMLP_FeatureImportance:' BRAPH2.FAIL_TEST], ...
	        'NNxMLP_FeatureImportance does not have the feature importance score array of the same feature size as the input data.' ...
	        )

%%% ¡test!
%%%% ¡name!
Example CON
%%%% ¡code!
create_data_NN_REG_CON_XLS() % only creates files if the example folder doesn't already exist

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

% Create NNData composed of corresponding NNDataPoints
% create a item list of NNDataPoint_CON_REG
it_list = cellfun(@(x) NNDataPoint_CON_REG( ...
    'ID', x.get('ID'), ...
    'SUB', x, ...
    'TARGET_IDS', x.get('VOI_DICT').get('KEYS')), ...
    gr.get('SUB_DICT').get('IT_LIST'), ...
    'UniformOutput', false);

% create a NNDataPoint_CON_REG DICT
dp_dict = IndexedDictionary(...
        'IT_CLASS', 'NNDataPoint_CON_REG', ...
        'IT_LIST', it_list ...
        );

% create a NNData containing the NNDataPoint_CON_REG DICT
d = NNDataset( ...
    'DP_CLASS', 'NNDataPoint_CON_REG', ...
    'DP_DICT', dp_dict ...
    );

% Split the NNData into training set and test set
d_split = NNDatasetSplit('D', d, 'SPLIT', {0.7, 0.3});
d_training = d_split.get('D_LIST_IT', 1);
d_test = d_split.get('D_LIST_IT', 2);

% Create a MLP regressor with training set
nn = NNRegressorMLP('D', d_training, 'LAYERS', [20 20]);
nn.get('TRAIN');

% Evaluate the feature importance
fi = NNxMLP_FeatureImportance('D', d_test, 'NN', nn, 'P', 5, 'APPLY_BONFERRONI', true, 'APPLY_CONFIDENCE_INTERVALS', true);
fi_score = fi.get('RESHAPED_FEATURE_IMPORTANCE');
input_dp = it_list{1}.get('INPUT');

assert(isequal(size(cell2mat(fi_score)), size(cell2mat(input_dp))), ...
	        [BRAPH2.STR ':NNxMLP_FeatureImportance:' BRAPH2.FAIL_TEST], ...
	        'NNxMLP_FeatureImportance does not have the feature importance score array of the same feature size as the input data.' ...
	        )