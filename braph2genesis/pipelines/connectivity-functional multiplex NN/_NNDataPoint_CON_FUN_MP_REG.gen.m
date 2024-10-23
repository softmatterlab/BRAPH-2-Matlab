%% ¡header!
NNDataPoint_CON_FUN_MP_REG < NNDataPoint (dp, connectivity-functional multiplex regression data point) is a data point for regression with connectivity-functional multiplex data.

%%% ¡description!
A data point for regression with connectivity-functional multiplex data (NNDataPoint_CON_FUN_MP_REG) 
 contains the input and target for neural network analysis with a subject 
 with connectivity-functional multiplex data (SubjectCON_FUN_MP).
The input is the connectivity-functional multiplex data of the subject.
The target is obtained from the variables of interest of the subject.

%%% ¡seealso!
SubjectCON_FUN_MP

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the data point for regression with connectivity-functional multiplex data.
%%%% ¡default!
'NNDataPoint_CON_FUN_MP_REG'

%%% ¡prop!
NAME (constant, string) is the name of a data point for regression with connectivity-functional multiplex data.
%%%% ¡default!
'Neural Network Multiplex Connectivity-Functional Data Point for Regression'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of a data point for regression with connectivity-functional multiplex data.
%%%% ¡default!
'A data point for regression with connectivity-functional multiplex data (NNDataPoint_CON_FUN_MP_REG) contains the input and target for neural network analysis with a subject with connectivity-functional multiplex data (SubjectCON_FUN_MP). The input is the connectivity-functional multiplex data of the subject. The target is obtained from the variables of interest of the subject.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of a data point for regression with connectivity-functional multiplex data.
%%%% ¡settings!
'NNDataPoint_CON_FUN_MP_REG'

%%% ¡prop!
ID (data, string) is a few-letter code for a data point for regression with connectivity-functional multiplex data.
%%%% ¡default!
'NNDataPoint_CON_FUN_MP_REG ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of a data point for regression with connectivity-functional multiplex data.
%%%% ¡default!
'NNDataPoint_CON_FUN_MP_REG label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about a data point for regression with connectivity-functional multiplex data.
%%%% ¡default!
'NNDataPoint_CON_FUN_MP_REG notes'

%%% ¡prop!
INPUT (result, cell) is the input value for this data point.
%%%% ¡calculate!
A = cell(1, 2);
A{1} = dp.get('SUB').get('CON');
A{2} = dp.get('SUB').get('FUN');
value = A;
    
%%% ¡prop!
TARGET (result, cell) is the target value for this data point.
%%%% ¡calculate!
value = cellfun(@(x) dp.get('SUB').get('VOI_DICT').get('IT', x).get('V'), dp.get('TARGET_IDS'), 'UniformOutput', false);

%% ¡props!

%%% ¡prop!
SUB (data, item) is a subject with connectivity-functional multiplex data.
%%%% ¡settings!
'SubjectCON_FUN_MP'

%%% ¡prop!
TARGET_IDS (parameter, stringlist) is a list of variable-of-interest IDs to be used as regression targets.
					
%% ¡tests!

%%% ¡excluded_props!
[NNDataPoint_CON_FUN_MP_REG.SUB]

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
create_data_NN_REG_CON_FUN_MP_TXT() % only creates files if the example folder doesn't already exist
create_data_NN_REG_CON_FUN_MP_XLS() % only creates files if the example folder doesn't already exist

%%% ¡test! 
%%%% ¡name!
Create a NNDataset containg NNDataPoint_CON_FUN_MP_REG with simulated data
%%%% ¡code!
% Load BrainAtlas
im_ba = ImporterBrainAtlasTXT( ...
    'FILE', [fileparts(which('NNDataPoint_CON_FUN_MP_REG')) filesep 'Example data NN REG CON_FUN_MP TXT' filesep 'atlas.txt'], ...
    'WAITBAR', true ...
    );

ba = im_ba.get('BA');

% Load Group of SubjectCON
im_gr = ImporterGroupSubjectCON_TXT( ...
    'DIRECTORY', [fileparts(which('NNDataPoint_CON_FUN_MP_REG')) filesep 'Example data NN REG CON_FUN_MP TXT' filesep 'Connectivity' filesep 'CON_FUN_MP_Group_TXT'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr_CON = im_gr.get('GR');

% Load Group of SubjectFUN
im_gr = ImporterGroupSubjectFUN_TXT( ...
    'DIRECTORY', [fileparts(which('NNDataPoint_CON_FUN_MP_REG')) filesep 'Example data NN REG CON_FUN_MP TXT' filesep 'Functional' filesep 'CON_FUN_MP_Group_TXT'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr_FUN = im_gr.get('GR');

% Combine Group of SubjectCON with Group of SubjectFUN
co_gr = CombineGroups_CON_FUN_MP( ...
    'GR_CON', gr_CON, ...
    'GR_FUN', gr_FUN, ...
    'WAITBAR', true ...
    );

gr = co_gr.get('GR_CON_FUN_MP');

% create a item list of NNDataPoint_CON_FUN_MP_REG
it_list = cellfun(@(x) NNDataPoint_CON_FUN_MP_REG( ...
    'ID', x.get('ID'), ...
    'SUB', x, ...
    'TARGET_IDS', x.get('VOI_DICT').get('KEYS')), ...
    gr.get('SUB_DICT').get('IT_LIST'), ...
    'UniformOutput', false);

% create a NNDataPoint_CON_FUN_MP_REG DICT
dp_list = IndexedDictionary(...
        'IT_CLASS', 'NNDataPoint_CON_FUN_MP_REG', ...
        'IT_LIST', it_list ...
        );

% create a NNDataset containing the NNDataPoint_CON_FUN_MP_REG DICT
d = NNDataset( ...
    'DP_CLASS', 'NNDataPoint_CON_FUN_MP_REG', ...
    'DP_DICT', dp_list ...
    );

% Check whether the number of inputs matches
assert(length(d.get('INPUTS')) == gr.get('SUB_DICT').get('LENGTH'), ...
		[BRAPH2.STR ':NNDataPoint_CON_FUN_MP_FUN_MP_REG:' BRAPH2.FAIL_TEST], ...
		'NNDataPoint_CON_FUN_MP_REG does not construct the dataset correctly. The number of the inputs should be the same as the number of imported subjects.' ...
		)

% Check whether the number of targets matches
assert(length(d.get('TARGETS')) == gr.get('SUB_DICT').get('LENGTH'), ...
		[BRAPH2.STR ':NNDataPoint_CON_FUN_MP_REG:' BRAPH2.FAIL_TEST], ...
		'NNDataPoint_CON_FUN_MP_REG does not construct the dataset correctly. The number of the targets should be the same as the number of imported subjects.' ...
		)

% Check whether the content of input for a single datapoint matches
for index = 1:1:gr.get('SUB_DICT').get('LENGTH')
    individual_input = d.get('DP_DICT').get('IT', index).get('INPUT');
    A = cell(1, 2);
    A{1} = gr.get('SUB_DICT').get('IT', index).get('CON');
    A{2} = gr.get('SUB_DICT').get('IT', index).get('FUN');
    known_input = A;

    assert(isequal(individual_input, known_input), ...
        [BRAPH2.STR ':NNDataPoint_CON_FUN_MP_REG:' BRAPH2.FAIL_TEST], ...
        'NNDataPoint_CON_FUN_MP_REG does not construct the dataset correctly. The input value is not derived correctly.' ...
        )
end

%%% ¡test! 
%%%% ¡name!
Example training-test regression
%%%% ¡code!
% ensure the example data is generated
if ~isfile([fileparts(which('NNDataPoint_CON_FUN_MP_REG')) filesep 'Example data NN REG CON_FUN_MP XLS' filesep 'atlas.xlsx'])
    create_data_NN_REG_CON_FUN_XLS() % create example files
end

example_NN_CON_FUN_MP_REG

%%% ¡test! 
%%%% ¡name!
Example cross-validation regression WU
%%%% ¡code!
% ensure the example data is generated
if ~isfile([fileparts(which('NNDataPoint_CON_FUN_MP_REG')) filesep 'Example data NN REG CON_FUN_MP XLS' filesep 'atlas.xlsx'])
    create_data_NN_REG_CON_FUN_XLS() % create example files
end

example_NNCV_CON_FUN_MP_WU_M_REG