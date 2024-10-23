%% ¡header!
NNBase < ConcreteElement (nn, neural network) comprises a neural network model with a dataset.

%%% ¡description!
A Neural Network Base (NNBase) comprises a neural network model with a specific dataset.
 Instances of this class should not be created. Use one of its subclasses instead.

Its subclasses need to implement the props MODEL, INPUTS and TARGETS.
 Each subclass is typically optimized to work with the subclasses of NNDataPoint in the prop DP_CLASSES.

To train a neural network nn use: nn.get('TRAIN')
To obtain the prediction on a dataset D use: predictions = nn.get('PREDICT', D)

%%% ¡seealso!
NNDataPoint, NNDataset, NNEvaluator

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the neural network base.
%%%% ¡default!
'NNBase'

%%% ¡prop!
NAME (constant, string) is the name of the neural network base.
%%%% ¡default!
'Neural Network Base'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the neural network base.
%%%% ¡default!
'A Neural Network Base (NNBase) comprises a neural network model with a specific dataset. Instances of this class should not be created. Use one of its subclasses instead. Its subclasses need to implement the props MODEL, INPUTS and TARGETS.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the neural network base.
%%%% ¡settings!
'NNBase'

%%% ¡prop!
ID (data, string) is a few-letter code for the neural network base.
%%%% ¡default!
'NNBase ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the neural network base.
%%%% ¡default!
'NNBase label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the neural network base.
%%%% ¡default!
'NNBase notes'
    
%% ¡props!

%%% ¡prop!
D (data, item) is the dataset to train the neural network model, and its data point class DP_CLASS defaults to one of the compatible classes within the set of DP_CLASSES.
%%%% ¡settings!
'NNDataset'
%%%% ¡default!
NNDataset('DP_CLASS', 'NNDataPoint')
%%%% ¡check_value!
check = ismember(value.get('DP_CLASS'), nn.get('DP_CLASSES'));

%%% ¡prop!
DP_CLASSES (parameter, classlist) is the list of compatible data points.
%%%% ¡default!
{'NNDataPoint'}

%%% ¡prop!
EPOCHS (parameter, scalar) is the maximum number of epochs.
%%%% ¡default!
20

%%% ¡prop!
BATCH (parameter, scalar) is the size of the mini-batch used for each training iteration.
%%%% ¡default!
8

%%% ¡prop!
SHUFFLE (parameter, option) is an option for data shuffling.
%%%% ¡settings!
{'once' 'never' 'every-epoch'}

%%% ¡prop!
SOLVER (parameter, option) is an option for the solver.
%%%% ¡settings!
{'adam' 'sgdm' 'rmsprop'}

%%% ¡prop!
MODEL (result, net) is a trained neural network model with the given dataset.
%%%% ¡calculate!
value = network();

%%% ¡prop!
INPUTS (query, cell) constructs the cell array of the data.
%%%% ¡calculate!
% inputs = nn.get('inputs', D) returns a cell array with the
%  inputs for all data points in dataset D.
value = {};

%%% ¡prop!
TARGETS (query, cell) constructs the cell array of the targets.
%%%% ¡calculate!
% targets = nn.get('PREDICT', D) returns a cell array with the
%  targets for all data points in dataset D.
value = {};

%%% ¡prop!
TRAIN (query, empty) trains the neural network model with the given dataset.
%%%% ¡calculate!
nn.memorize('MODEL');
value = [];

%%% ¡prop!
VERBOSE (gui, logical) is an indicator to display training progress information.
%%%% ¡default!
false

%%% ¡prop!
PLOT_TRAINING (metadata, option) determines whether to plot the training progress.
%%%% ¡settings!
{'none' 'training-progress'}

%%% ¡prop!
PREDICT (query, cell) returns the predictions of the trained neural network for a dataset.
%%%% ¡calculate!
% PREDICTIONS = nn.get('PREDICT', D) returns a cell array with the
%  predictions for all data points in dataset D.
if isempty(varargin)
    value = {};
    return
end

d = varargin{1};
inputs = nn.get('INPUTS', d);
if isempty(cell2mat(inputs))
    predictions = {};
else
    net = nn.get('MODEL');
    predictions = {net.predict(cell2mat(inputs))};
end
value = predictions;