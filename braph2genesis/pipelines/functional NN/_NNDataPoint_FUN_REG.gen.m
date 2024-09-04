%% ¡header!
NNDataPoint_FUN_REG < NNDataPoint (dp, functional regression data point) is a data point for regression with functional data.

%%% ¡description!
A data point for regression with functional data (NNDataPoint_FUN_REG) 
 contains the input and target for neural network analysis with a subject with functional data (SubjectFUN).
The input is the functional data of the subject.
The target is obtained from the variables of interest of the subject.

%%% ¡seealso!
SubjectFUN

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the data point for regression with functional data.
%%%% ¡default!
'NNDataPoint_FUN_REG'

%%% ¡prop!
NAME (constant, string) is the name of a data point for regression with functional data.
%%%% ¡default!
'Neural Network Functional Data Point for Regression'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of a data point for regression with functional data.
%%%% ¡default!
'A data point for regression with functional data (NNDataPoint_FUN_REG) contains the input and target for neural network analysis with a subject with functional data (SubjectFUN). The input is the functional data of the subject. The target is obtained from the variables of interest of the subject.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of a data point for regression with functional data.
%%%% ¡settings!
'NNDataPoint_FUN_REG'

%%% ¡prop!
ID (data, string) is a few-letter code for a data point for regression with functional data.
%%%% ¡default!
'NNDataPoint_FUN_REG ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of a data point for regression with functional data.
%%%% ¡default!
'NNDataPoint_FUN_REG label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about a data point for regression with functional data.
%%%% ¡default!
'NNDataPoint_FUN_REG notes'

%%% ¡prop!
INPUT (result, cell) is the input value for this data point.
%%%% ¡calculate!
value = {dp.get('SUB').get('FUN')};
    
%%% ¡prop!
TARGET (result, cell) is the target value for this data point.
%%%% ¡calculate!
value = cellfun(@(x) dp.get('SUB').get('VOI_DICT').get('IT', x).get('V'), dp.get('TARGET_IDS'), 'UniformOutput', false);

%% ¡props!

%%% ¡prop!
SUB (data, item) is a subject with functional data.
%%%% ¡settings!
'SubjectFUN'

%%% ¡prop!
TARGET_IDS (parameter, stringlist) is a list of variable-of-interest IDs to be used as regression targets.
					
%% ¡tests!

%%% ¡excluded_props!
[NNDataPoint_FUN_REG.SUB]

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
create_data_NN_REG_FUN_XLS() % only creates files if the example folder doesn't already exist
create_data_NN_REG_FUN_TXT() % only creates files if the example folder doesn't already exist

%%% ¡test! 
%%%% ¡name!
Create a NNDataset containg NNDataPoint_FUN_REG with simulated data
%%%% ¡code!
% Load BrainAtlas
im_ba = ImporterBrainAtlasTXT( ...
    'FILE', [fileparts(which('NNDataPoint_FUN_REG')) filesep 'Example data NN REG FUN TXT' filesep 'atlas.txt'], ...
    'WAITBAR', true ...
    );

ba = im_ba.get('BA');

% Load Group of SubjectFUN
im_gr = ImporterGroupSubjectFUN_TXT( ...
    'DIRECTORY', [fileparts(which('NNDataPoint_FUN_REG')) filesep 'Example data NN REG FUN TXT' filesep 'FUN_Group_TXT'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr = im_gr.get('GR');

% create a item list of NNDataPoint_FUN_REG
it_list = cellfun(@(x) NNDataPoint_FUN_REG( ...
    'ID', x.get('ID'), ...
    'SUB', x, ...
    'TARGET_IDS', x.get('VOI_DICT').get('KEYS')), ...
    gr.get('SUB_DICT').get('IT_LIST'), ...
    'UniformOutput', false);

% create a NNDataPoint_FUN_REG DICT
dp_list = IndexedDictionary(...
        'IT_CLASS', 'NNDataPoint_FUN_REG', ...
        'IT_LIST', it_list ...
        );

% create a NNDataset containing the NNDataPoint_FUN_REG DICT
d = NNDataset( ...
    'DP_CLASS', 'NNDataPoint_FUN_REG', ...
    'DP_DICT', dp_list ...
    );

% Check whether the number of inputs matches
assert(length(d.get('INPUTS')) == gr.get('SUB_DICT').get('LENGTH'), ...
		[BRAPH2.STR ':NNDataPoint_FUN_REG:' BRAPH2.FAIL_TEST], ...
		'NNDataPoint_FUN_REG does not construct the dataset correctly. The number of the inputs should be the same as the number of imported subjects.' ...
		)

% Check whether the number of targets matches
assert(length(d.get('TARGETS')) == gr.get('SUB_DICT').get('LENGTH'), ...
		[BRAPH2.STR ':NNDataPoint_FUN_REG:' BRAPH2.FAIL_TEST], ...
		'NNDataPoint_FUN_REG does not construct the dataset correctly. The number of the targets should be the same as the number of imported subjects.' ...
		)

% Check whether the content of input for a single datapoint matches
for index = 1:1:gr.get('SUB_DICT').get('LENGTH')
    individual_input = d.get('DP_DICT').get('IT', index).get('INPUT');
    known_input = {gr.get('SUB_DICT').get('IT', index).get('FUN')};

    assert(isequal(individual_input, known_input), ...
        [BRAPH2.STR ':NNDataPoint_FUN_REG:' BRAPH2.FAIL_TEST], ...
        'NNDataPoint_FUN_REG does not construct the dataset correctly. The input value is not derived correctly.' ...
        )
end

%%% ¡test! 
%%%% ¡name!
Example training-test regression
%%%% ¡code!
% ensure the example data is generated
if ~isfile([fileparts(which('NNDataPoint_FUN_REG')) filesep 'Example data NN REG FUN XLS' filesep 'atlas.xlsx'])
    create_data_NN_REG_FUN_XLS() % create example files
end

example_NN_FUN_REG