%% ¡header!
NNDataset < ConcreteElement (d, neural network data) is a dataset for neural network analysis.

%%% ¡description!
A neural network dataset (NNDataset) represents a dataset containing datapoints whose class is defined by the DP_CLASS property.
NNDataset can contain all the necessary inputs and targets.

%%% ¡seealso!
NNDataPoint, NNDatasetCombine, NNDatasetSplit

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the dataset for neural network analysis.
%%%% ¡default!
'NNDataset'

%%% ¡prop!
NAME (constant, string) is the name of the dataset for neural network analysis.
%%%% ¡default!
'Neural Network Dataset'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the dataset for neural network analysis.
%%%% ¡default!
'A neural network dataset (NNDataset) represents a dataset containing datapoints whose class is defined by the DP_CLASS property. NNDataset can contain all the necessary inputs and targets.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the dataset for neural network analysis.
%%%% ¡settings!
'NNDataset'

%%% ¡prop!
ID (data, string) is a few-letter code for the dataset for neural network analysis.
%%%% ¡default!
'NNDataset ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the dataset for neural network analysis.
%%%% ¡default!
'NNDataset label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the dataset for neural network analysis.
%%%% ¡default!
'NNDataset notes'
    
%% ¡props!

%%% ¡prop!
DP_CLASS (parameter, class) is the class of the data points
%%%% ¡settings!
'NNDataPoint'

%%% ¡prop!
DP_DICT (data, idict) is an indexed dictionary containing the data points.
%%%% ¡settings!
'NNDataPoint'

%%% ¡prop!
INPUTS (result, cell) is a collection of the inputs from all data points.
%%%% ¡calculate!
value = cellfun(@(dp) dp.get('INPUT'), d.get('DP_DICT').get('IT_LIST'), 'UniformOutput', false);

%%% ¡prop!
TARGETS (result, cell) is a collection of the targets from all data points.
%%%% ¡calculate!
value = cellfun(@(dp) dp.get('TARGET'), d.get('DP_DICT').get('IT_LIST'), 'UniformOutput', false);