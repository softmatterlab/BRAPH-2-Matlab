# Implement a New Neural Network Regressor

[![Tutorial Implement a New Neural Network Regressor](https://img.shields.io/badge/PDF-Download-red?style=flat-square&logo=adobe-acrobat-reader)](dev_nn_reg.pdf)

This is the developer tutorial for implementing a new neural network regressor. 
In this tutorial, you will learn how to create the generator file "*.gen.m" for a new neural network regressor, which can then be compiled by `braph2genesis`. All kinds of neural network models are (direct or indirect) extensions of the base element `NNBase`. Here, you will use as example the neural network regressor `NNRegressorMLP` (multi-layer perceptron regressor).


## Table of Contents
> [Implementation of a neural network regressor (`NNRegressorMLP`)](#Implementation-of-a-neural-network-regressor-NNRegressorMLP)
>



<a id="Implementation-of-a-neural-network-regressor-NNRegressorMLP"></a>
## Implementation of a neural network regressor (`NNRegressorMLP`)  [⬆](#Table-of-Contents)

You will start by implementing in detail `NNRegressorMLP`, which is a direct extension of `NNBase`.
A multi-layer perceptron regressor `NNRegressorMLP` comprises a multi-layer perceptron regressor model and a given dataset.


> **Code 1.** **NNRegressorMLP element header.**
> 		The `header` section of the generator code in "_NNRegressorMLP.gen.m" provides the general information about the `NNRegressorMLP` element.
> ````matlab
> %% ¡header!
> NNRegressorMLP < NNBase (nn, multi-layer perceptron regressor) comprises a multi-layer perceptron regressor model and a given dataset.  ①
> 
> %%% ¡description!
> A neural network multi-layer perceptron regressor (NNRegressorMLP) comprises a multi-layer perceptron regressor model and a given dataset.
> NNRegressorMLP trains the multi-layer perceptron regressor with a formatted inputs ("CB", channel and batch) derived from the given dataset.
> 
> %%% ¡build!
> 1
> ````
> 
> ① defines `NNRegressorMLP` as a subclass of `NNBase`. The moniker will be `nn`.
> 


> **Code 2.** **NNRegressorMLP element prop update.**
> 		The `props_update` section of the generator code in "_NNRegressorMLP.gen.m" updates the properties of the `NNRegressorMLP` element. This defines the core properties of the data point.
> ````matlab
> %% ¡props_update!
> 
> %%% ¡prop!
> NAME (constant, string) is the name of the neural network multi-layer perceptron regressor.
> %%%% ¡default!
> 'NNRegressorMLP'
> 
> %%% ¡prop!
> DESCRIPTION (constant, string) is the description of the neural network multi-layer perceptron regressor.
> %%%% ¡default!
> 'A neural network multi-layer perceptron regressor (NNRegressorMLP) comprises a multi-layer perceptron regressor model and a given dataset. NNRegressorMLP trains the multi-layer perceptron regressor with a formatted inputs ("CB", channel and batch) derived from the given dataset.'
> 
> %%% ¡prop!
> TEMPLATE (parameter, item) is the template of the neural network multi-layer perceptron regressor.
> %%%% ¡settings!
> 'NNRegressorMLP'
> 
> %%% ¡prop!
> ID (data, string) is a few-letter code for the neural network multi-layer perceptron regressor.
> %%%% ¡default!
> 'NNRegressorMLP ID'
> 
> %%% ¡prop!
> LABEL (metadata, string) is an extended label of the neural network multi-layer perceptron regressor.
> %%%% ¡default!
> 'NNRegressorMLP label'
> 
> %%% ¡prop!
> NOTES (metadata, string) are some specific notes about the neural network multi-layer perceptron regressor.
> %%%% ¡default!
> 'NNRegressorMLP notes'
> 
> %%% ¡prop!   ①
> D (data, item) is the dataset to train the neural network model, and its data point class DP_CLASS defaults to one of the compatible classes within the set of DP_CLASSES.
> %%%% ¡settings!
> 'NNDataset'
> %%%% ¡default!
> NNDataset('DP_CLASS', 'NNDataPoint_CON_REG')
> 
> %%% ¡prop!
> DP_CLASSES (parameter, classlist) is the list of compatible data points.
> %%%% ¡default!  ②
> {'NNDataPoint_CON_REG' 'NNDataPoint_CON_FUN_MP_REG' 'NNDataPoint_Graph_REG' 'NNDataPoint_Measure_REG'}
> 
> %%% ¡prop!
> INPUTS (query, cell) constructs the data in the CB (channel-batch) format.
> %%%% ¡calculate!  ③
> % inputs = nn.get('inputs', D) returns a cell array with the
> %  inputs for all data points in dataset D.
> if isempty(varargin)
>     value = {};
>     return
> end
> d = varargin{1};
> inputs_group = d.get('INPUTS');
> if isempty(inputs_group)
>     value = {};
> else
>     flattened_inputs_group = [];
>     for i = 1:1:length(inputs_group)
>         inputs_individual = inputs_group{i};
>         flattened_inputs_individual = [];
>         while ~isempty(inputs_individual)
>             currentData = inputs_individual{end};  % Get the last element from the stack
>             inputs_individual = inputs_individual(1:end-1);   % Remove the last element
> 
>             if iscell(currentData)
>                 % If it's a cell array, add its contents to the stack
>                 inputs_individual = [inputs_individual currentData{:}];
>             else
>                 % If it's numeric or other data, append it to the vector
>                 flattened_inputs_individual = [currentData(:); flattened_inputs_individual];
>             end
>         end
>         flattened_inputs_group = [flattened_inputs_group; flattened_inputs_individual'];
>     end
>     value = {flattened_inputs_group};
> end
> 
> %%% ¡prop!
> TARGETS (query, cell) constructs the targets in the CB (channel-batch) format.
> %%%% ¡calculate!  ④
> % targets = nn.get('PREDICT', D) returns a cell array with the
> %  targets for all data points in dataset D.
> if isempty(varargin)
>     value = {};
>     return
> end
> d = varargin{1};
> targets = d.get('TARGETS');
> if isempty(targets)
>     value = {};
> else
>     nn_targets = [];
>     for i = 1:1:length(targets)
>         target = cell2mat(targets{i});
>         nn_targets = [nn_targets; target(:)'];
>     end
>     value = {nn_targets};
> end
> 
> %%% ¡prop!
> MODEL (result, net) is a trained neural network model.
> %%%% ¡calculate!  ⑤
> inputs = cell2mat(nn.get('INPUTS', nn.get('D')));   ⑥
> targets = cell2mat(nn.get('TARGETS', nn.get('D')));   ⑦
> if isempty(inputs) || isempty(targets)
>     value = network();
> else
>     number_features = size(inputs, 2);
>     number_targets = size(targets, 2);
>     layers = nn.get('LAYERS'); ⑧
>     
>     nn_architecture = [featureInputLayer(number_features, 'Name', 'Input')];
>     for i = 1:1:length(layers)
>         nn_architecture = [nn_architecture
>             fullyConnectedLayer(layers(i), 'Name', ['Dense_' num2str(i)])
>             batchNormalizationLayer('Name', ['BatchNormalization_' num2str(i)])
>             dropoutLayer('Name', ['Dropout_' num2str(i)])
>             ];
>     end
>     nn_architecture = [nn_architecture
>         reluLayer('Name', 'Relu_output')
>         fullyConnectedLayer(number_targets, 'Name', 'Dense_output')
>         regressionLayer('Name', 'Output')
>         ];
>     
>     % specify trianing options   ⑨
>     options = trainingOptions( ...
>         nn.get('SOLVER'), ...
>         'MiniBatchSize', nn.get('BATCH'), ...
>         'MaxEpochs', nn.get('EPOCHS'), ...
>         'Shuffle', nn.get('SHUFFLE'), ...
>         'Plots', nn.get('PLOT_TRAINING'), ...
>         'Verbose', nn.get('VERBOSE') ...
>         );
> 
>     % train the neural network   ⑩
>     value = trainNetwork(inputs, targets, nn_architecture, options);
> end
> ````
> 
> ① defines `NNDataset` which contains the `NNDataPoint` to train this regressor.
> 
> ② defines the compatible `NNDataPoint` classes with this `NNRegressorMLP`.
> 
> ③ is a query that transforms the input data of `NNDataPoint` to the CB (channel-batch) format by flattening its included cells.
> 
> ④ is a query that collects all the target values from all data points.
> 
> ⑤ trains the regressor.
> 
> ⑥ and ⑦ extract the inputs and targets.
> 
> ⑧ defines the neural network architecture with user-specified number of neurons and number of layers.
> 
> ⑨ defines the neural network training options.
> 
> ⑩ trains the model with those parameters and the neural network architecture.
> 


> **Code 3.** **NNRegressorMLP element props.**
> 		The `props` section of generator code in "_NNRegressorMLP.gen.m" defines the properties to be used in "NNRegressorMLP".
> ````matlab
> %% ¡props!
> 
> %%% ¡prop!  ①
> LAYERS (data, rvector) defines the number of layers and their neurons.
> %%%% ¡default!
> [32 32]
> %%%% ¡gui!
> pr = PanelPropRVectorSmart('EL', nn, 'PROP', NNRegressorMLP.LAYERS, ...
>     'MIN', 0, 'MAX', 2000, ...
>     'DEFAULT', NNRegressorMLP.getPropDefault('LAYERS'), ...
>     varargin{:});
> 
> %%% ¡prop!
> WAITBAR (gui, logical) detemines whether to show the waitbar.
> %%%% ¡default!
> true
> ````
> 
> ① defines the number of neuron per layer. For example, `[32 32]` represents two layers, each containing 32 neurons.
> 




> **Code 4.** **NNRegressprMLP element tests.**
> 		The `tests` section from the element generator "_NNRegressprMLP.gen.m".
> 		A test for creating example files should be prepared to test the properties of the data point. Furthermore, an additional test should be prepared for validating the value of input and target for the data point.
> ````matlab
> %% ¡tests!
> 
> %%% ¡test!
> %%%% ¡name!
> train the regressor with example data
> %%%% ¡code!
> 
> % ensure the example data is generated
> if ~isfile([fileparts(which('NNDataPoint_CON_REG')) filesep 'Example data NN REG CON XLS' filesep 'atlas.xlsx'])
>     create_data_NN_REG_CON_XLS() % create example files
> end
> 
> % Load BrainAtlas
> im_ba = ImporterBrainAtlasXLS( ...
>     'FILE', [fileparts(which('NNDataPoint_CON_REG')) filesep 'Example data NN REG CON XLS' filesep 'atlas.xlsx'], ...
>     'WAITBAR', true ...
>     );
> 
> ba = im_ba.get('BA');
> 
> % Load Groups of SubjectCON
> im_gr = ImporterGroupSubjectCON_XLS( ...
>     'DIRECTORY', [fileparts(which('NNDataPoint_CON_REG')) filesep 'Example data NN REG CON XLS' filesep 'CON_Group_XLS'], ...
>     'BA', ba, ...
>     'WAITBAR', true ...
>     );
> 
> gr = im_gr.get('GR');
> 
> % create a item list of NNDataPoint_CON_REG
> it_list = cellfun(@(x) NNDataPoint_CON_REG( ...
>     'ID', x.get('ID'), ...
>     'SUB', x, ...
>     'TARGET_IDS', x.get('VOI_DICT').get('KEYS')), ...
>     gr.get('SUB_DICT').get('IT_LIST'), ...
>     'UniformOutput', false);
> 
> % create a NNDataPoint_CON_REG DICT
> dp_list = IndexedDictionary(...
>         'IT_CLASS', 'NNDataPoint_CON_REG', ...
>         'IT_LIST', it_list ...
>         );
> 
> % create a NNData containing the NNDataPoint_CON_REG DICT
> d = NNDataset( ...
>     'DP_CLASS', 'NNDataPoint_CON_REG', ...
>     'DP_DICT', dp_list ...
>     );
> 
> nn = NNRegressorMLP('D', d, 'LAYERS', [20 20]);
> trained_model = nn.get('MODEL');
> 
> % Check whether the number of fully-connected layers matches (excluding Dense_output layer) ①
> assert(length(nn.get('LAYERS')) == sum(contains({trained_model.Layers.Name}, 'Dense')) - 1, ...
>     [BRAPH2.STR ':NNRegressorMLP:' BRAPH2.FAIL_TEST], ...
>     'NNRegressorMLP does not construct the layers correctly. The number of the inputs should be the same as the length of dense layers the property.' ...
>     )
> ````
> 
> ① checks whether the number of layers from the trained model is correctly set.
>
