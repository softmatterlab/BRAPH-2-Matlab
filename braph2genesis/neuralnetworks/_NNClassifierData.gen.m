%% ¡header!
NNClassifierData < NNData (nnd, data of a neural network classifier) produces a dataset to train or test a neural netowrk classifier.  

%% ¡description!
This dataset produce the NN Groups to train or test a neural network classifier.
The input for training a neural network classifer can be obtained direcly
from the structual data, the adjacency matrices, or the graph measures.
Feature selection procedure can be implemented.  
Instances of this class should not be created. 
Use one of its subclasses instead.

%% ¡props!
%%% ¡prop!
GR1 (data, item) is a group of subjects.
%%%% ¡settings!
'Group'

%%% ¡prop!
GR2 (data, item) is a group of subjects.
%%%% ¡settings!
'Group'

%%% ¡prop!
TARGET_NAME (data, string) is the name of the traget.
%%%% ¡default!
'diagnosis'

%%% ¡prop!
SPLIT_GR1 (data, rvector) is a ratio or a vector stating which subjects belong to validation set.
%%%% ¡conditioning!
if length(value) == 1 & value < 1
    num_val = floor(value * nnd.get('GR1').get('SUB_DICT').length());
    num_train = nnd.get('GR1').get('SUB_DICT').length() - num_val;
    value = [ones(1, num_val), zeros(1, num_train)];
    value = value(randperm(length(value)));
    value = find(value == 1);
end

%%% ¡prop!
SPLIT_GR2 (data, rvector) is a ratio or a vector stating which subjects belong to validation set.
%%%% ¡conditioning!
if length(value) == 1 & value < 1
    num_val = floor(value * nnd.get('GR2').get('SUB_DICT').length());
    num_train = nnd.get('GR2').get('SUB_DICT').length() - num_val;
    value = [ones(1, num_val), zeros(1, num_train)];
    value = value(randperm(length(value)));
    value = find(value == 1);
end

%%% ¡prop!
FEATURE_MASK (data, cell) is a given mask or a percentile for selecting relevant features.
%%%% ¡default!
num2cell(0.05)
%%%% ¡conditioning!
if ~iscell(value) & isnumeric(value)
    value = num2cell(value);
end

%%% ¡prop!
NN_GR1 (result, item) is a group of NN subjects.
%%%% ¡settings!
'NNGroup'

%%% ¡prop!
NN_GR2 (result, item) is a group of NN subjects.
%%%% ¡settings!
'NNGroup'

%%% ¡prop!
TRAIN_NN_GR (result, item) is a group of NN subjects for training set.
%%%% ¡settings!
'NNGroup'
%%%% ¡calculate!
% init a NNGroup
nnGroup = 'NN_GR1';
train_nn_gr = NNGroup( ...
    'SUB_CLASS', nnd.get(nnGroup).get('SUB_CLASS'), ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'Subject') ...
    );

train_nn_gr.set( ...
    'ID', nnd.get(nnGroup).get('ID'), ...
    'LABEL', nnd.get(nnGroup).get('LABEL'), ...
    'NOTES', nnd.get(nnGroup).get('NOTES') ...
    );

% add subejcts from all groups
sub_dict = train_nn_gr.get('SUB_DICT');

if nnd.memorize('NN_GR1').get('SUB_DICT').length() > 0
    subs = nnd.memorize('NN_GR1').get('SUB_DICT').getItems();
    selected_idx = setdiff(1:length(subs), nnd.get('SPLIT_GR1'));
    selected_subs = subs(selected_idx);
    for i = 1:1:length(selected_subs)
        sub = selected_subs{i};
        sub_dict.add(sub);
    end
end

if nnd.memorize('NN_GR2').get('SUB_DICT').length() > 0
    subs = nnd.memorize('NN_GR2').get('SUB_DICT').getItems();
    selected_idx = setdiff(1:length(subs), nnd.get('SPLIT_GR2'));
    selected_subs = subs(selected_idx);
    for i = 1:1:length(selected_subs)
        sub = selected_subs{i};
        sub_dict.add(sub);
    end
end

if sub_dict.length() > 0
    target_names = cellfun(@(x) x.get('TARGET_NAME'), sub_dict.getItems(), 'UniformOutput', false);
    targets = onehotencode(categorical(target_names), 1);
    for i = 1:1:sub_dict.length()
        sub_dict.getItem(i).set('TARGET', {targets(:, i)});
    end
end

train_nn_gr.set('SUB_DICT', sub_dict);

value = train_nn_gr;

%%% ¡prop!
VAL_NN_GR (result, item) is a group of NN subjects for validation set.
%%%% ¡settings!
'NNGroup'
%%%% ¡calculate!
% init a NNGroup
nnGroup = 'NN_GR1';
val_nn_gr = NNGroup( ...
    'SUB_CLASS', nnd.get(nnGroup).get('SUB_CLASS'), ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'Subject') ...
    );

val_nn_gr.set( ...
    'ID', nnd.get(nnGroup).get('ID'), ...
    'LABEL', nnd.get(nnGroup).get('LABEL'), ...
    'NOTES', nnd.get(nnGroup).get('NOTES') ...
    );

% add subejcts from all groups
sub_dict = val_nn_gr.get('SUB_DICT');

if nnd.memorize('NN_GR1').get('SUB_DICT').length() > 0
    subs = nnd.memorize('NN_GR1').get('SUB_DICT').getItems();
    selected_idx = nnd.get('SPLIT_GR1');
    selected_subs = subs(selected_idx);
    for i = 1:1:length(selected_subs)
        sub = selected_subs{i};
        sub_dict.add(sub);
    end
end

if nnd.memorize('NN_GR2').get('SUB_DICT').length() > 0
    subs = nnd.memorize('NN_GR2').get('SUB_DICT').getItems();
    selected_idx = nnd.get('SPLIT_GR2');
    selected_subs = subs(selected_idx);
    for i = 1:1:length(selected_subs)
        sub = selected_subs{i};
        sub_dict.add(sub);
    end
end

if sub_dict.length() > 0
    target_names = cellfun(@(x) x.get('TARGET_NAME'), sub_dict.getItems(), 'UniformOutput', false);
    targets = onehotencode(categorical(target_names), 1);
    for i = 1:1:sub_dict.length()
        sub_dict.getItem(i).set('TARGET', {targets(:, i)});
    end
end

val_nn_gr.set('SUB_DICT', sub_dict);

value = val_nn_gr;

%%% ¡prop!
FEATURE_SELECTION_ANALYSIS (result, cell) is an analysis for generating a feature mask.
%%%% ¡calculate!
percentile = cell2mat(nnd.get('FEATURE_MASK'));
data = cellfun(@(x) x.get('INPUT'), nnd.get('TRAIN_NN_GR').get('SUB_DICT').getItems(), 'UniformOutput', false);

if nnd.get('TRAIN_NN_GR').get('SUB_DICT').length == 0
    value = {};
else
    y = cellfun(@(x) cell2mat(x.get('TARGET')), nnd.get('TRAIN_NN_GR').get('SUB_DICT').getItems(), 'UniformOutput', false);
    y = cell2mat(y);
    label = y(1, :);
    num_feature_cluster = length(data{1});
    value = cell(size(data{1}));
    for k = 1:1:num_feature_cluster
        data_per_cluster = cellfun(@(v)v{k}, data, 'UniformOutput', false);
        mask = zeros(size(data_per_cluster{k}));
        if ~isempty(mask)
            for i = 1:numel(mask)
                data_per_feature = cellfun(@(v)v(i), data_per_cluster);
                if(any(isinf(data_per_feature)))
                    mask(i) = 0;
                else
                    mask(i) = nnd.mutual_information_analysis(data_per_feature, label, 5);
                end
            end

            [~, idx_all] = sort(mask(:), 'descend');
            num_top_idx = ceil(percentile * numel(mask));
            mask(idx_all(1:num_top_idx)) = 1;
            mask(idx_all(num_top_idx:end)) = 0;
        end
        value{k} = mask;
    end
end

%%% ¡prop!
TRAIN_NN_GR_FS (result, item) is a group of NN subjects with feature selection for training set.
%%%% ¡settings!
'NNGroup'
%%%% ¡default!
NNGroup('SUB_CLASS', 'NNSubject', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'NNSubject'))
%%%% ¡calculate!
nn_gr_copy = nnd.memorize('TRAIN_NN_GR');
feature_mask = nnd.get('FEATURE_MASK');
if length(feature_mask) == 1 && length(cell2mat(feature_mask(1))) == 1 % given percentile
    feature_mask = nnd.memorize('FEATURE_SELECTION_ANALYSIS');
end

if isempty(feature_mask)
    value = NNGroup();
else
    for i = 1:1:nn_gr_copy.get('SUB_DICT').length()
        input = nn_gr_copy.get('SUB_DICT').getItem(i).get('INPUT');
        num_feature_cluster = length(input);
        input_masked = cell(size(input));
        for j = 1:1:num_feature_cluster
            input_per_cluster = input{j};
            mask_per_cluster = feature_mask{j};
            input_per_cluster(mask_per_cluster == 0) = 0;
            input_masked{j} = input_per_cluster;
        end
        %nn_gr_copy.get('SUB_DICT').getItem(i).set('INPUT_FS', input_masked);
        nn_gr_copy.get('SUB_DICT').getItem(i).set('FEATURE_MASK', feature_mask);
    end
    value = nn_gr_copy;
end

%%% ¡prop!
VAL_NN_GR_FS (result, item) is a group of NN subjects with feature selection for validation set.
%%%% ¡settings!
'NNGroup'
%%%% ¡default!
NNGroup('SUB_CLASS', 'NNSubject', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'NNSubject'))
%%%% ¡calculate!
nn_gr_copy = nnd.memorize('VAL_NN_GR');
feature_mask = nnd.get('FEATURE_MASK');
if length(feature_mask) == 1 && length(cell2mat(feature_mask(1))) == 1 % given percentile
    feature_mask = nnd.memorize('FEATURE_SELECTION_ANALYSIS');
end

if isempty(feature_mask)
    value = NNGroup();
else
    for i = 1:1:nn_gr_copy.get('SUB_DICT').length()
        input = nn_gr_copy.get('SUB_DICT').getItem(i).get('INPUT');
        num_feature_cluster = length(input);
        input_masked = cell(size(input));
        for j = 1:1:num_feature_cluster
            input_per_cluster = input{j};
            mask_per_cluster = feature_mask{j};
            input_per_cluster(mask_per_cluster == 0) = 0;
            input_masked{j} = input_per_cluster;
        end
        %nn_gr_copy.get('SUB_DICT').getItem(i).set('INPUT_FS', input_masked);
        nn_gr_copy.get('SUB_DICT').getItem(i).set('FEATURE_MASK', feature_mask);
    end
    value = nn_gr_copy;
end