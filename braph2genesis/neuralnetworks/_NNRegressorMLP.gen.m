%% ¡header!
NNRegressorMLP < NNBase (nn, multi-layer perceptron regressor) comprises a multi-layer perceptron regressor model and a given dataset.

%%% ¡description!
A neural network multi-layer perceptron regressor (NNRegressorMLP) comprises 
 a multi-layer perceptron regressor model and a given dataset.
NNRegressorMLP trains the multi-layer perceptron regressor with a formatted
 inputs ("CB", channel and batch) derived from the given dataset.

%%% ¡seealso!
NNDataPoint_CON_REG, NNRegressor_Evaluator

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
NNRegressorMLP.ID
%%%% ¡title!
Neural Networks ID

%%% ¡prop!
%%%% ¡id!
NNRegressorMLP.LABEL
%%%% ¡title!
Neural Networks LABEL

%%% ¡prop!
%%%% ¡id!
NNRegressorMLP.WAITBAR
%%%% ¡title!
WAITBAR ON/OFF

%%% ¡prop!
%%%% ¡id!
NNRegressorMLP.VERBOSE
%%%% ¡title!
VERBOSE ON/OFF

%%% ¡prop!
%%%% ¡id!
NNRegressorMLP.PLOT_TRAINING
%%%% ¡title!
PLOT TRAINING PROGRESS

%%% ¡prop!
%%%% ¡id!
NNRegressorMLP.EPOCHS
%%%% ¡title!
Training EPOCHS

%%% ¡prop!
%%%% ¡id!
NNRegressorMLP.BATCH
%%%% ¡title!
Training BATCH

%%% ¡prop!
%%%% ¡id!
NNRegressorMLP.SHUFFLE
%%%% ¡title!
Training SHUFFLE

%%% ¡prop!
%%%% ¡id!
NNRegressorMLP.SOLVER
%%%% ¡title!
Training SOLVER

%%% ¡prop!
%%%% ¡id!
NNRegressorMLP.D
%%%% ¡title!
DATASET

%%% ¡prop!
%%%% ¡id!
NNRegressorMLP.LAYERS
%%%% ¡title!
Number of Neurons per Layer

%%% ¡prop!
%%%% ¡id!
NNRegressorMLP.MODEL
%%%% ¡title!
Neural Network REGRESSOR

%%% ¡prop!
%%%% ¡id!
NNRegressorMLP.NOTES
%%%% ¡title!
Neural Networks NOTES

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the neural network multi-layer perceptron regressor.
%%%% ¡default!
'NNRegressorMLP'

%%% ¡prop!
NAME (constant, string) is the name of the neural network multi-layer perceptron regressor.
%%%% ¡default!
'Neural Network Multi-layer Perceptron Regressor'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the neural network multi-layer perceptron regressor.
%%%% ¡default!
'A neural network multi-layer perceptron regressor (NNRegressorMLP) comprises a multi-layer perceptron regressor model and a given dataset. NNRegressorMLP trains the multi-layer perceptron regressor with a formatted inputs ("CB", channel and batch) derived from the given dataset.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the neural network multi-layer perceptron regressor.
%%%% ¡settings!
'NNRegressorMLP'

%%% ¡prop!
ID (data, string) is a few-letter code for the neural network multi-layer perceptron regressor.
%%%% ¡default!
'NNRegressorMLP ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the neural network multi-layer perceptron regressor.
%%%% ¡default!
'NNRegressorMLP label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the neural network multi-layer perceptron regressor.
%%%% ¡default!
'NNRegressorMLP notes'

%%% ¡prop!
D (data, item) is the dataset to train the neural network model, and its data point class DP_CLASS defaults to one of the compatible classes within the set of DP_CLASSES.
%%%% ¡settings!
'NNDataset'
%%%% ¡default!
NNDataset('DP_CLASS', 'NNDataPoint_CON_REG')

%%% ¡prop!
DP_CLASSES (parameter, classlist) is the list of compatible data points.
%%%% ¡default!
{'NNDataPoint_CON_REG' 'NNDataPoint_CON_FUN_MP_REG' 'NNDataPoint_FUN_REG' 'NNDataPoint_ST_REG' 'NNDataPoint_ST_MM_REG' 'NNDataPoint_Graph_REG' 'NNDataPoint_Measure_REG'}

%%% ¡prop!
INPUTS (query, cell) constructs the data in the CB (channel-batch) format.
%%%% ¡calculate!
% inputs = nn.get('inputs', D) returns a cell array with the
%  inputs for all data points in dataset D.
if isempty(varargin)
    value = {};
    return
end
d = varargin{1};
inputs_group = d.get('INPUTS');
if isempty(inputs_group)
    value = {};
else
    flattened_inputs_group = [];
    for i = 1:1:length(inputs_group)
        inputs_individual = inputs_group{i};
        flattened_inputs_individual = [];
        while ~isempty(inputs_individual)
            currentData = inputs_individual{end};  % Get the last element from the stack
            inputs_individual = inputs_individual(1:end-1);   % Remove the last element

            if iscell(currentData)
                % If it's a cell array, add its contents to the stack
                inputs_individual = [inputs_individual currentData{:}];
            else
                % If it's numeric or other data, append it to the vector
                flattened_inputs_individual = [currentData(:); flattened_inputs_individual];
            end
        end
        flattened_inputs_group = [flattened_inputs_group; flattened_inputs_individual'];
    end
    value = {flattened_inputs_group};
end

%%% ¡prop!
TARGETS (query, cell) constructs the targets in the CB (channel-batch) format.
%%%% ¡calculate!
% targets = nn.get('PREDICT', D) returns a cell array with the
%  targets for all data points in dataset D.
if isempty(varargin)
    value = {};
    return
end
d = varargin{1};
targets = d.get('TARGETS');
if isempty(targets)
    value = {};
else
    nn_targets = [];
    for i = 1:1:length(targets)
        target = cell2mat(targets{i});
        nn_targets = [nn_targets; target(:)'];
    end
    value = {nn_targets};
end

%%% ¡prop!
MODEL (result, net) is a trained neural network model.
%%%% ¡calculate!
inputs = cell2mat(nn.get('INPUTS', nn.get('D')));
targets = cell2mat(nn.get('TARGETS', nn.get('D')));
if isempty(inputs) || isempty(targets)
    value = network();
else
    number_features = size(inputs, 2);
    number_targets = size(targets, 2);
    layers = nn.get('LAYERS');
    
    nn_architecture = [featureInputLayer(number_features, 'Name', 'Input')];
    for i = 1:1:length(layers)
        nn_architecture = [nn_architecture
            fullyConnectedLayer(layers(i), 'Name', ['Dense_' num2str(i)])
            batchNormalizationLayer('Name', ['BatchNormalization_' num2str(i)])
            dropoutLayer('Name', ['Dropout_' num2str(i)])
            ];
    end
    nn_architecture = [nn_architecture
        reluLayer('Name', 'Relu_output')
        fullyConnectedLayer(number_targets, 'Name', 'Dense_output')
        regressionLayer('Name', 'Output')
        ];
    
    % specify trianing options
    options = trainingOptions( ...
        nn.get('SOLVER'), ...
        'MiniBatchSize', nn.get('BATCH'), ...
        'MaxEpochs', nn.get('EPOCHS'), ...
        'Shuffle', nn.get('SHUFFLE'), ...
        'Plots', nn.get('PLOT_TRAINING'), ...
        'Verbose', nn.get('VERBOSE') ...
        );

    % train the neural network
    value = trainNetwork(inputs, targets, nn_architecture, options);
end

%% ¡props!

%%% ¡prop!
LAYERS (data, rvector) defines the number of layers and their neurons.
%%%% ¡default!
[32 32]
%%%% ¡gui!
pr = PanelPropRVectorSmart('EL', nn, 'PROP', NNRegressorMLP.LAYERS, ...
    'MIN', 0, 'MAX', 2000, ...
    'UNIQUE_VALUE', false, ...
    'DEFAULT', NNRegressorMLP.getPropDefault('LAYERS'), ...
    varargin{:});

%%% ¡prop!
WAITBAR (gui, logical) detemines whether to show the waitbar.
%%%% ¡default!
true

%%% ¡prop!
INTERRUPTIBLE (gui, scalar) sets whether the comparison computation is interruptible for multitasking.
%%%% ¡default!
.001

%%% ¡prop!
FEATURE_IMPORTANCE (query, cell) evaluates the average significance of each feature by iteratively shuffling its values P times and measuring the resulting average decrease in model performance.
%%%% ¡calculate!
% fi = nn.get('FEATURE_IMPORTANCE', D) retrieves a cell array containing
%  the feature importance values for the trained model, as assessed by
%  evaluating it on the input dataset D.
if isempty(varargin)
    value = {};
    return
end
d = varargin{1};
P = varargin{2};
seeds = varargin{3};

inputs = cell2mat(nn.get('INPUTS', d));
if isempty(inputs)
    value = {};
    return
end
targets = cell2mat(nn.get('TARGETS', d));
net = nn.get('MODEL');

number_features = size(inputs, 2);
original_loss = crossentropy(net.predict(inputs), targets);

wb = braph2waitbar(nn.get('WAITBAR'), 0, ['Feature importance permutation ...']);

start = tic;
for i = 1:1:P
    rng(seeds(i), 'twister')
    parfor j = 1:1:number_features
        scrambled_inputs = inputs;
        permuted_value = squeeze(normrnd(mean(inputs(:, j)), std(inputs(:, j)), squeeze(size(inputs(:, j))))) + squeeze(randn(size(inputs(:, j)))) + mean(inputs(:, j));
        scrambled_inputs(:, j) = permuted_value;
        scrambled_loss = crossentropy(net.predict(scrambled_inputs), targets);
        feature_importance(j) = scrambled_loss;
    end

    feature_importance_all_permutations{i} = feature_importance / original_loss;

    braph2waitbar(wb, i / P, ['Feature importance permutation ' num2str(i) ' of ' num2str(P) ' - ' int2str(toc(start)) '.' int2str(mod(toc(start), 1) * 10) 's ...'])
    if nn.get('VERBOSE')
        disp(['** PERMUTATION FEATURE IMPORTANCE - sampling #' int2str(i) '/' int2str(P) ' - ' int2str(toc(start)) '.' int2str(mod(toc(start), 1) * 10) 's'])
    end
    if nn.get('INTERRUPTIBLE')
        pause(nn.get('INTERRUPTIBLE'))
    end
end

braph2waitbar(wb, 'close')

value = feature_importance_all_permutations;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
train the regressor with example data
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

nn = NNRegressorMLP('D', d, 'LAYERS', [20 20]);
trained_model = nn.get('MODEL');

% Check whether the number of fully-connected layer matches (excluding Dense_output layer)
assert(length(nn.get('LAYERS')) == sum(contains({trained_model.Layers.Name}, 'Dense')) - 1, ...
    [BRAPH2.STR ':NNRegressorMLP:' BRAPH2.FAIL_TEST], ...
    'NNRegressorMLP does not construct the layers correctly. The number of the inputs should be the same as the length of dense layers the property.' ...
    )