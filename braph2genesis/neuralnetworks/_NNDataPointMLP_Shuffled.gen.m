%% ¡header!
NNDataPointMLP_Shuffled < NNDataPoint (dp, shuffled neural network data point for multi-layer perceptron) is a data point with shuffled features for multi-layer perceptron neural network.

%%% ¡description!
A shuffled neural network data point for multi-layer perceptron (NNDataPointMLP_Shuffled) contains a data point with its shuffled inputs and original targets for multi-layer perceptron neural network analysis.
The shuffled inputs are used to evaluate the impact of specific feature (or composite features) on the performance of the multi-layer perceptron neural network.

%%% ¡seealso!
NNDataPoint, NNDataset

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the shuffled data point for neural network analysis .
%%%% ¡default!
'NNDataPointMLP_Shuffled'

%%% ¡prop!
NAME (constant, string) is the name of the shuffled data point for neural network analysis.
%%%% ¡default!
'Shuffled Neural Network Data Point'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the shuffled data point for neural network analysis.
%%%% ¡default!
'A shuffled neural network data point for multi-layer perceptron (NNDataPointMLP_Shuffled) contains a data point with its shuffled inputs and original targets for multi-layer perceptron neural network analysis. The shuffled inputs are used to evaluate the impact of specific feature (or composite features) on the performance of the multi-layer perceptron neural network.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the shuffled data point for neural network analysis.
%%%% ¡settings!
'NNDataPointMLP_Shuffled'

%%% ¡prop!
ID (data, string) is a few-letter code for the shuffled data point for neural network analysis.
%%%% ¡default!
'NNDataPointMLP_Shuffled ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the shuffled data point for neural network analysis.
%%%% ¡default!
'NNDataPointMLP_Shuffled label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the shuffled data point for neural network analysis.
%%%% ¡default!
'NNDataPoint_Permuted notes'

%%% ¡prop!
INPUT (result, cell) is the input value for this data point for neural network analysis.
%%%% ¡calculate!
value = dp.get('SHUFFLED_INPUT');

%% ¡props!
%%% ¡prop!
SHUFFLED_INPUT (data, cell) is the shuffled input value for this data point.

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Assigning shuffiled input data
%%%% ¡code!
shuffled_input = {[1 2 3]};

known_shuffled_input = {[1 2 3]};

shuffled_dp = NNDataPointMLP_Shuffled('SHUFFLED_INPUT', shuffled_input);

calculated_shuffled_input = shuffled_dp.get('INPUT');
assert(isequal(calculated_shuffled_input, known_shuffled_input), ...
    [BRAPH2.STR ':NNDataPointMLP_Shuffled:' BRAPH2.FAIL_TEST], ...
    ['The shuffled input is not being calculated correctly for NNDataPointMLP_Shuffled.'])