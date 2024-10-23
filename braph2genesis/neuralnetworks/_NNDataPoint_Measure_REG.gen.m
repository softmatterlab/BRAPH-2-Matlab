%% ¡header!
NNDataPoint_Measure_REG < NNDataPoint (dp, measure regression data point)  is a data point for regression with graph measures.

%%% ¡description!
A data point for regression with graph measures (NNDataPoint_Measure_REG) 
 contains both input and target for neural network analysis.
The input is the value of the graph measures (e.g. Degree, DegreeAv, and Distance), 
 calculated from the derived graph of the subject.
The target is obtained from the variables of interest of the subject.

%%% ¡seealso!
NNDataPoint_Graph_REG, NNDataPoint_Graph_REG, NNDataPoint_Measure_CLA

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the data point for regression with graph measures.
%%%% ¡default!
'NNDataPoint_Measure_REG'

%%% ¡prop!
NAME (constant, string) is the name of the data point for regression with graph measures.
%%%% ¡default!
'Neural Network Data Point for Regression with Graph Measures'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the data point for regression with graph measures.
%%%% ¡default!
'A data point for regression with graph measures (NNDataPoint_Measure_REG) contains both input and target for neural network analysis. The input is the value of the graph measures (e.g. Degree, DegreeAv, and Distance), calculated from the derived graph of the subject. The target is obtained from the variables of interest of the subject.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the data point for regression with graph measures.
%%%% ¡settings!
'NNDataPoint_Measure_REG'

%%% ¡prop!
ID (data, string) is a few-letter code for the data point for regression with graph measures.
%%%% ¡default!
'NNDataPoint_Measure_REG ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the data point for regression with graph measures.
%%%% ¡default!
'NNDataPoint_Measure_REG label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the data point for regression with graph measures.
%%%% ¡default!
'NNDataPoint_Measure_REG notes'

%%% ¡prop!
INPUT (result, cell) is the input value for this data point.
%%%% ¡calculate!
value = cellfun(@(m_class) dp.get('G').get('MEASURE', m_class).get('M'), dp.get('M_LIST'), 'UniformOutput', false);
    
%%% ¡prop!
TARGET (result, cell) is the target value for this data point.
%%%% ¡calculate!
value = cellfun(@(x) dp.get('SUB').get('VOI_DICT').get('IT', x).get('V'), dp.get('TARGET_IDS'), 'UniformOutput', false);

%% ¡props!

%%% ¡prop!
G (data, item) is a graph containing the added graph measures (M_DICT).
%%%% ¡settings!
'Graph'

%%% ¡prop!
M_LIST (parameter, classlist) is a list of graph measure to be used as the input

%%% ¡prop!
SUB (data, item) is a subject.
%%%% ¡settings!
'Subject'
		
%%% ¡prop!
TARGET_IDS (parameter, stringlist) is a list of variable-of-interest IDs to be used as the class targets.

%% ¡tests!

%%% ¡excluded_props!
[NNDataPoint_Measure_REG.G NNDataPoint_Measure_REG.SUB]

%%% ¡test!
%%%% ¡name!
Construct the data point with the adjacency matrix derived from its weighted undirected graph (GraphWU) 
%%%% ¡code!
% ensure the example data is generated
if ~isfile([fileparts(which('NNDataPoint_CON_REG')) filesep 'Example data NN REG CON XLS' filesep 'atlas.xlsx'])
    create_data_NN_REG_CON_XLS() % create example files
end

% Load BrainAtlas
im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [fileparts(which('NNDataPoint_CON_REG')) filesep 'Example data NN REG CON XLS' filesep 'atlas.xlsx'], ...
    'WAITBAR', true ...
    );

ba = im_ba.get('BA');

% Load Groups of SubjectCON
im_gr = ImporterGroupSubjectCON_XLS( ...
    'DIRECTORY', [fileparts(which('NNDataPoint_CON_REG')) filesep 'Example data NN REG CON XLS' filesep 'CON_Group_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr = im_gr.get('GR');

% Analysis CON WU
a_WU = AnalyzeEnsemble_CON_WU( ...
    'GR', gr ...
    );

a_WU.get('MEASUREENSEMBLE', 'Degree').get('M');
a_WU.get('MEASUREENSEMBLE', 'DegreeAv').get('M');
a_WU.get('MEASUREENSEMBLE', 'Distance').get('M');

% create item lists of NNDataPoint_Measure_REG
it_list = cellfun(@(g, sub) NNDataPoint_Measure_REG( ...
    'ID', sub.get('ID'), ...
    'G', g, ...
    'M_LIST', {'Degree' 'DegreeAv' 'Distance'}, ...
    'SUB', sub, ...
    'TARGET_IDS', sub.get('VOI_DICT').get('KEYS')), ...
    a_WU.get('G_DICT').get('IT_LIST'), gr.get('SUB_DICT').get('IT_LIST'),...
    'UniformOutput', false);

% create NNDataPoint_Measure_REG DICT items
dp_list = IndexedDictionary(...
        'IT_CLASS', 'NNDataPoint_Measure_REG', ...
        'IT_LIST', it_list ...
        );

% create a NNDataset containing the NNDataPoint_Measure_REG DICT
d = NNDataset( ...
    'DP_CLASS', 'NNDataPoint_Measure_REG', ...
    'DP_DICT', dp_list ...
    );

% Check whether the content of input for a single datapoint matches
for index = 1:1:gr.get('SUB_DICT').get('LENGTH')
    individual_input = d.get('DP_DICT').get('IT', index).get('INPUT');
    known_input = cellfun(@(m) m.get('M'), a_WU.get('G_DICT').get('IT', index).get('M_DICT').get('IT_LIST'), 'UniformOutput', false);

    assert(isequal(individual_input, known_input), ...
        [BRAPH2.STR ':NNDataPoint_Measure_REG:' BRAPH2.FAIL_TEST], ...
        'NNDataPoint_Measure_REG does not construct the dataset correctly. The input value is not derived correctly.' ...
        )
end

%%% ¡test!
%%%% ¡name!
Construct the data point with the adjacency matrix derived from its binary undirected multigraph with fixed densities (MultigraphBUD)
%%%% ¡code!
% ensure the example data is generated
if ~isfile([fileparts(which('NNDataPoint_CON_REG')) filesep 'Example data NN REG CON XLS' filesep 'atlas.xlsx'])
    create_data_NN_REG_CON_XLS() % create example files
end

% Load BrainAtlas
im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [fileparts(which('NNDataPoint_CON_REG')) filesep 'Example data NN REG CON XLS' filesep 'atlas.xlsx'], ...
    'WAITBAR', true ...
    );

ba = im_ba.get('BA');

% Load Groups of SubjectCON
im_gr = ImporterGroupSubjectCON_XLS( ...
    'DIRECTORY', [fileparts(which('NNDataPoint_CON_REG')) filesep 'Example data NN REG CON XLS' filesep 'CON_Group_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr = im_gr.get('GR');

% Analysis CON WU
densities = 0:25:100;

a_BUD = AnalyzeEnsemble_CON_BUD( ...
    'DENSITIES', densities, ...
    'GR', gr ...
    );

a_BUD.get('MEASUREENSEMBLE', 'Degree').get('M');
a_BUD.get('MEASUREENSEMBLE', 'DegreeAv').get('M');
a_BUD.get('MEASUREENSEMBLE', 'Distance').get('M');

% create item lists of NNDataPoint_Measure_REG
it_list = cellfun(@(g, sub) NNDataPoint_Measure_REG( ...
    'ID', sub.get('ID'), ...
    'G', g, ...
    'M_LIST', {'Degree' 'DegreeAv' 'Distance'}, ...
    'SUB', sub, ...
    'TARGET_IDS', sub.get('VOI_DICT').get('KEYS')), ...
    a_BUD.get('G_DICT').get('IT_LIST'), gr.get('SUB_DICT').get('IT_LIST'),...
    'UniformOutput', false);

% create NNDataPoint_CON_CLA DICT items
dp_list = IndexedDictionary(...
        'IT_CLASS', 'NNDataPoint_Measure_REG', ...
        'IT_LIST', it_list ...
        );

% create a NNDataset containing the NNDataPoint_Measure_REG DICT
d = NNDataset( ...
    'DP_CLASS', 'NNDataPoint_Measure_REG', ...
    'DP_DICT', dp_list ...
    );

% Check whether the content of input for a single datapoint matches
for index = 1:1:gr.get('SUB_DICT').get('LENGTH')
    individual_input = d.get('DP_DICT').get('IT', index).get('INPUT');
    known_input = cellfun(@(m) m.get('M'), a_BUD.get('G_DICT').get('IT', index).get('M_DICT').get('IT_LIST'), 'UniformOutput', false);

    assert(isequal(individual_input, known_input), ...
        [BRAPH2.STR ':NNDataPoint_Measure_REG:' BRAPH2.FAIL_TEST], ...
        'NNDataPoint_Measure_REG does not construct the dataset correctly. The input value is not derived correctly.' ...
        )
end

%%% ¡test!
%%%% ¡name!
Construct the data point with the adjacency matrix derived from its multiplex weighted undirected graph (MultiplexWU) 
%%%% ¡code!
% ensure the example data is generated
if ~isfile([fileparts(which('NNDataPoint_CON_FUN_MP_REG')) filesep 'Example data NN REG CON_FUN_MP XLS' filesep 'atlas.xlsx'])
    create_data_NN_REG_CON_FUN_MP_XLS() % create example files
end

% Load BrainAtlas
im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [fileparts(which('NNDataPoint_CON_FUN_MP_REG')) filesep 'Example data NN REG CON_FUN_MP XLS' filesep 'atlas.xlsx'], ...
    'WAITBAR', true ...
    );

ba = im_ba.get('BA');

% Load Groups of SubjectCON
im_gr = ImporterGroupSubjectCON_XLS( ...
    'DIRECTORY', [fileparts(which('NNDataPoint_CON_FUN_MP_REG')) filesep 'Example data NN REG CON_FUN_MP XLS' filesep 'Connectivity' filesep 'CON_FUN_MP_Group_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr_CON = im_gr.get('GR');

% Load Groups of SubjectFUN
im_gr = ImporterGroupSubjectFUN_XLS( ...
    'DIRECTORY', [fileparts(which('NNDataPoint_CON_FUN_MP_REG')) filesep 'Example data NN REG CON_FUN_MP XLS' filesep 'Functional' filesep 'CON_FUN_MP_Group_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr_FUN = im_gr.get('GR');

% Combine Groups of SubjectCON with Groups of SubjectFUN
co_gr = CombineGroups_CON_FUN_MP( ...
    'GR_CON', gr_CON, ...
    'GR_FUN', gr_FUN, ...
    'WAITBAR', true ...
    );

gr = co_gr.get('GR_CON_FUN_MP');

% Analysis CON FUN MP WU
a_WU = AnalyzeEnsemble_CON_FUN_MP_WU( ...
    'GR', gr ...
    );

% To be added the multiplex measures
a_WU.get('MEASUREENSEMBLE', 'Degree').get('M');
a_WU.get('MEASUREENSEMBLE', 'DegreeAv').get('M');
a_WU.get('MEASUREENSEMBLE', 'Distance').get('M');

% create item lists of NNDataPoint_Measure_REG
it_list = cellfun(@(g, sub) NNDataPoint_Measure_REG( ...
    'ID', sub.get('ID'), ...
    'G', g, ...
    'M_LIST', {'Degree' 'DegreeAv' 'Distance'}, ...
    'SUB', sub, ...
    'TARGET_IDS', sub.get('VOI_DICT').get('KEYS')), ...
    a_WU.get('G_DICT').get('IT_LIST'), gr.get('SUB_DICT').get('IT_LIST'),...
    'UniformOutput', false);

% create NNDataPoint_Measure_REG DICT items
dp_list = IndexedDictionary(...
        'IT_CLASS', 'NNDataPoint_Measure_REG', ...
        'IT_LIST', it_list ...
        );

% create a NNDataset containing the NNDataPoint_Measure_REG DICT
d = NNDataset( ...
    'DP_CLASS', 'NNDataPoint_Measure_REG', ...
    'DP_DICT', dp_list ...
    );

% Check whether the content of input for a single datapoint matches
for index = 1:1:gr.get('SUB_DICT').get('LENGTH')
    individual_input = d.get('DP_DICT').get('IT', index).get('INPUT');
    known_input = cellfun(@(m) m.get('M'), a_WU.get('G_DICT').get('IT', index).get('M_DICT').get('IT_LIST'), 'UniformOutput', false);

    assert(isequal(individual_input, known_input), ...
        [BRAPH2.STR ':NNDataPoint_Measure_REG:' BRAPH2.FAIL_TEST], ...
        'NNDataPoint_Measure_REG does not construct the dataset correctly. The input value is not derived correctly.' ...
        )
end

%%% ¡test!
%%%% ¡name!
Example script for weighted undirected graph (GraphWU) using connectivity data
%%%% ¡code!
if ~isfile([fileparts(which('NNDataPoint_CON_REG')) filesep 'Example data NN REG CON XLS' filesep 'atlas.xlsx'])
    create_data_NN_REG_CON_XLS() % create example files
end
example_NNCV_CON_WU_M_REG

%%% ¡test!
%%%% ¡name!
Example script for weighted undirected multiplex (MultiplexWU) using connectivity data and functional data
%%%% ¡code!
if ~isfile([fileparts(which('NNDataPoint_CON_FUN_MP_REG')) filesep 'Example data NN REG CON_FUN_MP XLS' filesep 'atlas.xlsx'])
    create_data_NN_REG_CON_FUN_MP_XLS() % create example files
end
example_NNCV_CON_FUN_MP_WU_M_REG

%%% ¡test!
%%%% ¡name!
Example script for weighted undirected graph (GraphWU) using functional data
%%%% ¡code!
if ~isfile([fileparts(which('NNDataPoint_FUN_REG')) filesep 'Example data NN REG FUN XLS' filesep 'atlas.xlsx'])
    create_data_NN_REG_FUN_XLS() % create example files
end
example_NNCV_FUN_WU_M_REG