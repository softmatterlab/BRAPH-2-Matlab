%% ¡header!
NNDataPoint_ST_MM_REG < NNDataPoint (dp, structural multimodality regression data point) is a data point for regression with structural multimodality data.

%%% ¡description!
A data point for regression with structural multimodality data (NNDataPoint_ST_MM_REG) 
 contains the input and target for neural network analysis with a subject 
 with structural multiplex data (SubjectST_MP).
The input is the structural multiplex data of the subject.
The target is obtained from the variables of interest of the subject.

%%% ¡seealso!
SubjectST_MP

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the data point for regression with structural multimodality data.
%%%% ¡default!
'NNDataPoint_ST_MM_REG'

%%% ¡prop!
NAME (constant, string) is the name of a data point for regression with structural multimodality data.
%%%% ¡default!
'Neural Network Structural Multimodality Data Point for Regression'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of a data point for regression with structural multimodality data.
%%%% ¡default!
'A data point for regression with structural multimodality data (NNDataPoint_ST_MM_REG) contains the input and target for neural network analysis with a subject with structural multiplex data (SubjectST_MP). The input is the structural multiplex data of the subject. The target is obtained from the variables of interest of the subject.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of a data point for regression with structural multimodality data.
%%%% ¡settings!
'NNDataPoint_ST_MM_REG'

%%% ¡prop!
ID (data, string) is a few-letter code for a data point for regression with structural multimodality data.
%%%% ¡default!
'NNDataPoint_ST_MM_REG ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of a data point for regression with structural multimodality data.
%%%% ¡default!
'NNDataPoint_ST_MM_REG label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about a data point for regression with structural multimodality data.
%%%% ¡default!
'NNDataPoint_ST_MM_REG notes'

%%% ¡prop!
INPUT (result, cell) is the input value for this data point.
%%%% ¡calculate!
value = dp.get('SUB').get('ST_MP');

%%% ¡prop!
TARGET (result, cell) is the target value for this data point.
%%%% ¡calculate!
value = cellfun(@(x) dp.get('SUB').get('VOI_DICT').get('IT', x).get('V'), dp.get('TARGET_IDS'), 'UniformOutput', false);

%% ¡props!

%%% ¡prop!
SUB (data, item) is a subject with structural multimodality data.
%%%% ¡settings!
'SubjectST_MP'

%%% ¡prop!
TARGET_IDS (parameter, stringlist) is a list of variable-of-interest IDs to be used as regression targets.
					
%% ¡tests!

%%% ¡excluded_props!
[NNDataPoint_ST_MM_REG.SUB]

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
create_data_NN_REG_ST_MM_TXT() % only creates files if the example folder doesn't already exist
create_data_NN_REG_ST_MM_XLS() % only creates files if the example folder doesn't already exist

%%% ¡test! 
%%%% ¡name!
Create a NNDataset containg NNDataPoint_ST_MM_REG with simulated data
%%%% ¡code!
% Load BrainAtlas
im_ba = ImporterBrainAtlasTXT( ...
    'FILE', [fileparts(which('NNDataPoint_ST_MM_REG')) filesep 'Example data NN REG ST_MM TXT' filesep 'atlas.txt'], ...
    'WAITBAR', true ...
    );

ba = im_ba.get('BA');

% Load Group of SubjectST_MP
im_gr = ImporterGroupSubjectST_MP_TXT( ...
    'DIRECTORY', [fileparts(which('NNDataPoint_ST_MM_REG')) filesep 'Example data NN REG ST_MM TXT' filesep 'ST_MM_Group_TXT'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr = im_gr.get('GR');

% create a item list of NNDataPoint_ST_MM_REG
it_list = cellfun(@(x) NNDataPoint_ST_MM_REG( ...
    'ID', x.get('ID'), ...
    'SUB', x, ...
    'TARGET_IDS', x.get('VOI_DICT').get('KEYS')), ...
    gr.get('SUB_DICT').get('IT_LIST'), ...
    'UniformOutput', false);

% create a NNDataPoint_ST_MM_REG DICT
dp_list = IndexedDictionary(...
        'IT_CLASS', 'NNDataPoint_ST_MM_REG', ...
        'IT_LIST', it_list ...
        );

% create a NNDataset containing the NNDataPoint_ST_MM_REG DICT
d = NNDataset( ...
    'DP_CLASS', 'NNDataPoint_ST_MM_REG', ...
    'DP_DICT', dp_list ...
    );

% Check whether the number of inputs matches
assert(length(d.get('INPUTS')) == gr.get('SUB_DICT').get('LENGTH'), ...
		[BRAPH2.STR ':NNDataPoint_ST_MM_REG:' BRAPH2.FAIL_TEST], ...
		'NNDataPoint_ST_MM_REG does not construct the dataset correctly. The number of the inputs should be the same as the number of imported subjects.' ...
		)

% Check whether the number of targets matches
assert(length(d.get('TARGETS')) == gr.get('SUB_DICT').get('LENGTH'), ...
		[BRAPH2.STR ':NNDataPoint_ST_MM_REG:' BRAPH2.FAIL_TEST], ...
		'NNDataPoint_ST_MM_REG does not construct the dataset correctly. The number of the targets should be the same as the number of imported subjects.' ...
		)

% Check whether the content of input for a single datapoint matches
for index = 1:1:gr.get('SUB_DICT').get('LENGTH')
    individual_input = d.get('DP_DICT').get('IT', index).get('INPUT');
    known_input = gr.get('SUB_DICT').get('IT', index).get('ST_MP');

    assert(isequal(individual_input, known_input), ...
        [BRAPH2.STR ':NNDataPoint_ST_MM_REG:' BRAPH2.FAIL_TEST], ...
        'NNDataPoint_ST_MM_REG does not construct the dataset correctly. The input value is not derived correctly.' ...
        )
end

%%% ¡test! 
%%%% ¡name!
Example training-test regression
%%%% ¡code!
% ensure the example data is generated
if ~isfile([fileparts(which('NNDataPoint_ST_MM_REG')) filesep 'Example data NN REG ST_MM XLS' filesep 'atlas.xlsx'])
    create_data_NN_REG_ST_MM_XLS() % create example files
end

example_NN_ST_MM_REG

%%% ¡test! 
%%%% ¡name!
Example cross-validation regression
%%%% ¡code!
% ensure the example data is generated
if ~isfile([fileparts(which('NNDataPoint_ST_MM_REG')) filesep 'Example data NN REG ST_MM XLS' filesep 'atlas.xlsx'])
    create_data_NN_REG_ST_MM_XLS() % create example files
end

example_NNCV_ST_MM_REG