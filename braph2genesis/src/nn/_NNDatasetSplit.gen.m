%% ¡header!
NNDatasetSplit < ConcreteElement (dsp, splitter of a neural network dataset) splits a dataset into several partitioned datasets based on specified indices or proportions.

%%% ¡description!
A dataset splitter (NNDatasetSplit) allows users to split a given dataset into multiple smaller datasets, each forming a partition. 
The splitting can be achieved by providing either specific indices or proportions for the datapoints in each partitioned dataset.
For example usage, to split the dataset into two partitions, one containing datapoints 1 and 2, and the other containing datapoints 3, 4, and 5, the SPLIT property should be set as {[1 2], [3 4 5]}.
Alternatively, using the SPLIT property as {0.2, 0.8}, NNDatasetSplit will randomly assign datapoints to two datasets, with the first dataset containing approximately 20 percent of the total datapoints (datapoints 1 and 3, for instance), and the second dataset containing the remaining 80 percent of the datapoints (datapoints 2, 4, and 5).

%%% ¡seealso!
NNDataset, NNDatasetCombine

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
NNDatasetSplit.ID
%%%% ¡title!
Dataset Splitter ID

%%% ¡prop!
%%%% ¡id!
NNDatasetSplit.LABEL
%%%% ¡title!
Dataset Splitter LABEL

%%% ¡prop!
%%%% ¡id!
NNDatasetSplit.D
%%%% ¡title!
Dataset

%%% ¡prop!
%%%% ¡id!
NNDatasetSplit.SPLIT
%%%% ¡title!
SPLIT

%%% ¡prop!
%%%% ¡id!
NNDatasetSplit.D_LIST
%%%% ¡title!
Splitted Datasets

%%% ¡prop!
%%%% ¡id!
NNDatasetSplit.NOTES
%%%% ¡title!
Dataset Splitter NOTES


%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the splitter of a neural network dataset.
%%%% ¡default!
'NNDatasetSplit'

%%% ¡prop!
NAME (constant, string) is the name of the splitter of a neural network dataset.
%%%% ¡default!
'Neural Network Dataset Splitter'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the splitter of a neural network dataset.
%%%% ¡default!
'A dataset splitter (NNDatasetSplit) allows users to split a given dataset into multiple smaller datasets, each forming a partition. The splitting can be achieved by providing either specific indices or proportions for the datapoints in each partitioned dataset. For example usage, to split the dataset into two partitions, one containing datapoints 1 and 2, and the other containing datapoints 3, 4, and 5, the SPLIT property should be set as {[1 2], [3 4 5]}. Alternatively, using the SPLIT property as {0.2, 0.8}, NNDatasetSplit will randomly assign datapoints to two datasets, with the first dataset containing approximately 20 percent of the total datapoints (datapoints 1 and 3, for instance), and the second dataset containing the remaining 80 percent of the datapoints (datapoints 2, 4, and 5).'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the splitter of a neural network dataset.
%%%% ¡settings!
'NNDatasetSplit'

%%% ¡prop!
ID (data, string) is a few-letter code for the splitter of a neural network dataset.
%%%% ¡default!
'NNDatasetSplit ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the splitter of a neural network dataset.
%%%% ¡default!
'NNDatasetSplit label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the splitter of a neural network dataset.
%%%% ¡default!
'NNDatasetSplit notes'
    
%% ¡props!

%%% ¡prop!
D (data, item) is a dataset for neural network analysis.
%%%% ¡settings!
'NNDataset'
%%%% ¡default!
NNDataset('DP_CLASS', 'NNDataPoint', 'DP_DICT', IndexedDictionary('IT_CLASS', 'NNDataPoint'))

%%% ¡prop!
SPLIT (data, cell) is a cell containing the ratio numbers or the vectors stating which datapoints belong to the splitted neural network datasets.
%%%% ¡check_value!
check = all(cellfun(@(x) all(round(x) == x & all(x <= dsp.get('D').get('DP_DICT').get('LENGTH'))), dsp.get('SPLIT')));
%%%% ¡postset!
value = dsp.get('SPLIT');
if all(cellfun(@isscalar, value)) & sum(cell2mat(value)) <= 1 & sum(cell2mat(value)) > 0 
    num_sub = dsp.get('D').get('DP_DICT').get('LENGTH');
    
    lengths = floor(cell2mat(value) * num_sub);
    for i = 1:1:num_sub - sum(lengths)
        lengths(i) = lengths(i) + 1;
    end
    
    indices = randperm(num_sub);
    
    startIndex = 1;
    value = cell(numel(lengths), 1);
    for i = 1:numel(lengths)
        endIndex = startIndex + lengths(i) - 1;
        value{i} = sort(indices(startIndex:endIndex));
        startIndex = endIndex + 1;
    end
    
    dsp.set('SPLIT', value);
end

%%% ¡prop!
D_LIST (result, itemlist) is the itemlist of splitted neural network datasets.
%%%% ¡calculate!
d = dsp.get('D');
dp_list = d.get('DP_DICT').get('IT_LIST');
split = dsp.get('SPLIT');
value = cellfun(@(x) NNDataset( ...
    'DP_CLASS', d.get('DP_CLASS'), ...
    'DP_DICT', IndexedDictionary(...
    'IT_CLASS', 'NNDataPoint', ...
    'IT_LIST',  dp_list(x) ...
    )), split, 'UniformOutput', false);

%%% ¡prop!
D_LIST_IT (query, item) returns a dataset at a specified index in the itemlist of splitted neural network datasets.
%%%% ¡calculate!
% d = dsp.get('D_LIST_IT', index) returns the NNDataset at the specified 
%  index from the D_LIST property.
if isempty(varargin)
    value = NNDataset();
    return
end
index = varargin{1};

d_list = dsp.get('D_LIST');

value = d_list{index};

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Splitting dataset with assigned indexes
%%%% ¡code!

% create a NNDataPoint itemlist
num_dp = 10; 
dp_ids = cell(1, num_dp);
for i = 1:num_dp
    dp_ids{i} = ['dp_', num2str(i)];
end

dp_list = cellfun(@(x) NNDataPoint('ID', x), dp_ids(1:num_dp), 'UniformOutput', false);

dp_dict = IndexedDictionary(...
        'IT_CLASS', 'NNDataPoint', ...
        'IT_LIST',  dp_list ...
        );

% create NNDataset containing the NNDataPoints
d = NNDataset('DP_DICT', dp_dict);

% create NNDatasetCombine to combine the two NNDataset
split = {[1 3 5 7 9], [2 4 6 8 10]};
d_list = NNDatasetSplit('SPLIT', split, 'D', d).get('D_LIST');

% Check whether the number of dp matches
for i = 1:length(split)
    check(i) = d_list{i}.get('DP_DICT').get('LENGTH') == length(split{i});
end
assert(all(check), ...
    [BRAPH2.STR ':NNDatasetSplit:' BRAPH2.FAIL_TEST], ...
    'NNDatasetSplit does not split the datasets correctly. The number of the datapoint should be the same as the vector length in the specified property SPLIT.' ...
    )

%%% ¡test!
%%%% ¡name!
Splitting dataset with random indexes
%%%% ¡code!

% create a NNDataPoint itemlist
num_dp = 10; 
dp_ids = cell(1, num_dp);
for i = 1:num_dp
    dp_ids{i} = ['dp_', num2str(i)];
end

dp_list = cellfun(@(x) NNDataPoint('ID', x), dp_ids(1:num_dp), 'UniformOutput', false);

dp_dict = IndexedDictionary(...
        'IT_CLASS', 'NNDataPoint', ...
        'IT_LIST',  dp_list ...
        );

% create NNDataset containing the NNDataPoints
d = NNDataset('DP_DICT', dp_dict);

% create NNDatasetCombine to combine the two NNDataset
split = {0.3, 0.7};
dsp = NNDatasetSplit('D', d, 'SPLIT', split);
d_list = dsp.get('D_LIST');

% Check whether the number of dp matches
split = dsp.get('SPLIT');
for i = 1:length(split)
    check(i) = d_list{i}.get('DP_DICT').get('LENGTH') == length(split{i});
end
assert(all(check), ...
    [BRAPH2.STR ':NNDatasetSplit:' BRAPH2.FAIL_TEST], ...
    'NNDatasetSplit does not split the datasets correctly. The number of the datapoint should be the same as the vector length in the specified property SPLIT.' ...
    )
