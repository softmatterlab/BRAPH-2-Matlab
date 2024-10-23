%% ¡header!
NNDataPoint_CON_CLA < NNDataPoint (dp, connectivity classification data point) is a data point for classification with connectivity data.

%%% ¡description!
A data point for classification with connectivity data (NNDataPoint_CON_CLA) 
contains the input and target for neural network analysis with a subject with connectivity data (SubjectCON).
The input is the connectivity data of the subject.
The target is obtained from the variables of interest of the subject.

%%% ¡seealso!
SubjectCON

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the data point for classification with connectivity data.
%%%% ¡default!
'NNDataPoint_CON_CLA'

%%% ¡prop!
NAME (constant, string) is the name of a data point for classification with connectivity data.
%%%% ¡default!
'Neural Network Connectivity Data Point Classification'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of a data point for classification with connectivity data.
%%%% ¡default!
'A data point for classification with connectivity data (NNDataPoint_CON_CLA) contains the input and target for neural network analysis with a subject with connectivity data (SubjectCON). The input is the connectivity data of the subject. The target is obtained from the variables of interest of the subject.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of a data point for classification with connectivity data.
%%%% ¡settings!
'NNDataPoint_CON_CLA'

%%% ¡prop!
ID (data, string) is a few-letter code for a data point for classification with connectivity data.
%%%% ¡default!
'NNDataPoint_CON_CLA ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of a data point for classification with connectivity data.
%%%% ¡default!
'NNDataPoint_CON_CLA label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about a data point for classification with connectivity data.
%%%% ¡default!
'NNDataPoint_CON_CLA notes'

%%% ¡prop!
INPUT (result, cell) is the input value for this data point.
%%%% ¡calculate!
value = {dp.get('SUB').get('CON')};
    
%%% ¡prop!
TARGET (result, cell) is the target values for this data point.
%%%% ¡calculate!
value = cellfun(@(c) sum(double(c)), dp.get('TARGET_CLASS'), 'UniformOutput', false);

%% ¡props!

%%% ¡prop!
SUB (data, item) is a subject with connectivity data.
%%%% ¡settings!
'SubjectCON'

%%% ¡prop!
TARGET_CLASS (parameter, stringlist) is a list of variable-of-interest IDs to be used as the class targets.
					
%% ¡tests!

%%% ¡excluded_props!
[NNDataPoint_CON_CLA.SUB]

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
create_data_NN_CLA_CON_XLS() % only creates files if the example folder doesn't already exist
create_data_NN_CLA_CON_TXT() % only creates files if the example folder doesn't already exist

%%% ¡test! 
%%%% ¡name!
Create a NNDataset containg NNDataPoint_CON_CLA with simulated data
%%%% ¡code!
% Load BrainAtlas
im_ba = ImporterBrainAtlasTXT( ...
    'FILE', [fileparts(which('NNDataPoint_CON_CLA')) filesep 'Example data NN CLA CON TXT' filesep 'atlas.txt'], ...
    'WAITBAR', true ...
    );

ba = im_ba.get('BA');

% Load Groups of SubjectCON
im_gr1 = ImporterGroupSubjectCON_TXT( ...
    'DIRECTORY', [fileparts(which('NNDataPoint_CON_CLA')) filesep 'Example data NN CLA CON TXT' filesep 'CON_Group_1_TXT'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr1 = im_gr1.get('GR');

im_gr2 = ImporterGroupSubjectCON_TXT( ...
    'DIRECTORY', [fileparts(which('NNDataPoint_CON_CLA')) filesep 'Example data NN CLA CON TXT' filesep 'CON_Group_2_TXT'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr2 = im_gr2.get('GR');

% create item lists of NNDataPoint_CON_CLA
[~, group_folder_name] = fileparts(im_gr1.get('DIRECTORY'));
it_list1 = cellfun(@(x) NNDataPoint_CON_CLA( ...
    'ID', x.get('ID'), ...
    'SUB', x, ...
    'TARGET_CLASS', {group_folder_name}), ...
    gr1.get('SUB_DICT').get('IT_LIST'), ...
    'UniformOutput', false);

[~, group_folder_name] = fileparts(im_gr2.get('DIRECTORY'));
it_list2 = cellfun(@(x) NNDataPoint_CON_CLA( ...
    'ID', x.get('ID'), ...
    'SUB', x, ...
    'TARGET_CLASS', {group_folder_name}), ...
    gr2.get('SUB_DICT').get('IT_LIST'), ...
    'UniformOutput', false);

% create NNDataPoint_CON_CLA DICT items
dp_list1 = IndexedDictionary(...
        'IT_CLASS', 'NNDataPoint_CON_CLA', ...
        'IT_LIST', it_list1 ...
        );

dp_list2 = IndexedDictionary(...
        'IT_CLASS', 'NNDataPoint_CON_CLA', ...
        'IT_LIST', it_list2 ...
        );

% create a NNDataset containing the NNDataPoint_CON_CLA DICT
d1 = NNDataset( ...
    'DP_CLASS', 'NNDataPoint_CON_CLA', ...
    'DP_DICT', dp_list1 ...
    );

d2 = NNDataset( ...
    'DP_CLASS', 'NNDataPoint_CON_CLA', ...
    'DP_DICT', dp_list2 ...
    );

% Check whether the number of inputs matches
assert(length(d1.get('INPUTS')) == gr1.get('SUB_DICT').get('LENGTH'), ...
		[BRAPH2.STR ':NNDataPoint_CON_CLA:' BRAPH2.FAIL_TEST], ...
		'NNDataPoint_CON_CLA does not construct the dataset correctly. The number of the inputs should be the same as the number of imported subjects of group 1.' ...
		)

assert(length(d2.get('INPUTS')) == gr2.get('SUB_DICT').get('LENGTH'), ...
		[BRAPH2.STR ':NNDataPoint_CON_CLA:' BRAPH2.FAIL_TEST], ...
		'NNDataPoint_CON_CLA does not construct the dataset correctly. The number of the inputs should be the same as the number of imported subjects of group 2.' ...
		)

% Check whether the number of targets matches
assert(length(d1.get('TARGETS')) == gr1.get('SUB_DICT').get('LENGTH'), ...
		[BRAPH2.STR ':NNDataPoint_CON_CLA:' BRAPH2.FAIL_TEST], ...
		'NNDataPoint_CON_CLA does not construct the dataset correctly. The number of the targets should be the same as the number of imported subjects of group 1.' ...
		)

assert(length(d2.get('TARGETS')) == gr2.get('SUB_DICT').get('LENGTH'), ...
		[BRAPH2.STR ':NNDataPoint_CON_CLA:' BRAPH2.FAIL_TEST], ...
		'NNDataPoint_CON_CLA does not construct the dataset correctly. The number of the targets should be the same as the number of imported subjects of group 2.' ...
		)

% Check whether the content of input for a single datapoint matches
for index = 1:1:gr1.get('SUB_DICT').get('LENGTH')
    individual_input = d1.get('DP_DICT').get('IT', index).get('INPUT');
    known_input = {gr1.get('SUB_DICT').get('IT', index).get('CON')};

    assert(isequal(individual_input, known_input), ...
        [BRAPH2.STR ':NNDataPoint_CON_CLA:' BRAPH2.FAIL_TEST], ...
        'NNDataPoint_CON_CLA does not construct the dataset correctly. The input value is not derived correctly.' ...
        )
end

for index = 1:1:gr2.get('SUB_DICT').get('LENGTH')
    individual_input = d2.get('DP_DICT').get('IT', index).get('INPUT');
    known_input = {gr2.get('SUB_DICT').get('IT', index).get('CON')};

    assert(isequal(individual_input, known_input), ...
        [BRAPH2.STR ':NNDataPoint_CON_CLA:' BRAPH2.FAIL_TEST], ...
        'NNDataPoint_CON_CLA does not construct the dataset correctly. The input value is not derived correctly.' ...
        )
end

%%% ¡test! 
%%%% ¡name!
Example training-test classification
%%%% ¡code!
% ensure the example data is generated
if ~isfile([fileparts(which('NNDataPoint_CON_CLA')) filesep 'Example data NN CLA CON XLS' filesep 'atlas.xlsx'])
    create_data_NN_CLA_CON_XLS() % create example files
end

example_NN_CON_CLA