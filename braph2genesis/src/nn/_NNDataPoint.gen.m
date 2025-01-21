%% ¡header!
NNDataPoint < ConcreteElement (dp, neural network data point) is a data point for neural network analysis.

%%% ¡description!
A neural network data point (NNDataPoint) contains a data point with its inputs and targets for neural network analysis.
Instances of this class should not be created. Use one of its subclasses instead.
Its subclasses shall be specifically designed to cater to different use cases such as classification task, regression task, or data generation.

%%% ¡seealso!
NNData

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the data point for neural network analysis .
%%%% ¡default!
'NNDataPoint'

%%% ¡prop!
NAME (constant, string) is the name of the data point for neural network analysis.
%%%% ¡default!
'Neural Network Data Point'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the data point for neural network analysis.
%%%% ¡default!
'A neural network data point (NNDataPoint) contains a data point with its inputs and targets for neural network analysis. Instances of this class should not be created. Use one of its subclasses instead. Its subclasses shall be specifically designed to cater to different use cases such as classification task, regression task, or data generation.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the data point for neural network analysis.
%%%% ¡settings!
'NNDataPoint'

%%% ¡prop!
ID (data, string) is a few-letter code for the data point for neural network analysis.
%%%% ¡default!
'NNDataPoint ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the data point for neural network analysis.
%%%% ¡default!
'NNDataPoint label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the data point for neural network analysis.
%%%% ¡default!
'NNDataPoint notes'

%% ¡props!

%%% ¡prop!
INPUT (result, cell) is the input value for this data point.

%%% ¡prop!
TARGET (result, cell) is the target value for this data point.