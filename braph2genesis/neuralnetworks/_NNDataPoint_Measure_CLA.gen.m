%% ¡header!
NNDataPoint_Measure_CLA < NNDataPoint (dp, measure classification data point) is a data point for classification with graph measures.

%%% ¡description!
A data point for classification with graph measures (NNDataPoint_Measure_CLA) 
 contains both input and target for neural network analysis.
The input is the value of the graph measures (e.g. Degree, DegreeAv, and Distance), 
 calculated from the derived graph of the subject.
The target is obtained from the variables of interest of the subject.

%%% ¡seealso!
NNDataPoint_Measure_REG, NNDataPoint_Graph_REG, NNDataPoint_Graph_CLA

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the data point for classification with graph measures.
%%%% ¡default!
'NNDataPoint_Measure_CLA'

%%% ¡prop!
NAME (constant, string) is the name of the data point for classification with graph measures.
%%%% ¡default!
'Neural Network Data Point for Classification with Graph Measures'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the data point for classification with graph measures.
%%%% ¡default!
'A data point for classification with graph measures (NNDataPoint_Measure_CLA) contains both input and target for neural network analysis. The input is the value of the graph measures (e.g. Degree, DegreeAv, and Distance), calculated from the derived graph of the subject. The target is obtained from the variables of interest of the subject.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the data point for classification with graph measures.
%%%% ¡settings!
'NNDataPoint_Measure_CLA'

%%% ¡prop!
ID (data, string) is a few-letter code for the data point for classification with graph measures.
%%%% ¡default!
'NNDataPoint_Measure_CLA ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the data point for classification with graph measures.
%%%% ¡default!
'NNDataPoint_Measure_CLA label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the data point for classification with graph measures.
%%%% ¡default!
'NNDataPoint_Measure_CLA notes'

%%% ¡prop!
INPUT (result, cell) is the input value for this data point.
%%%% ¡calculate!
value = cellfun(@(m_class) dp.get('G').get('MEASURE', m_class).get('M'), dp.get('M_LIST'), 'UniformOutput', false);
    
%%% ¡prop!
TARGET (result, cell) is the target values for this data point.
%%%% ¡calculate!
value = cellfun(@(c) sum(double(c)), dp.get('TARGET_CLASS'), 'UniformOutput', false);

%% ¡props!

%%% ¡prop!
G (data, item) is a graph containing the added graph measures (M_DICT).
%%%% ¡settings!
'Graph'

%%% ¡prop!
M_LIST (parameter, classlist) is a list of graph measure to be used as the input.

%%% ¡prop!
TARGET_CLASS (parameter, stringlist) is a list of variable-of-interest IDs to be used as the class targets.

%% ¡tests!

%%% ¡excluded_props!
[NNDataPoint_Measure_CLA.G]

%%% ¡test!
%%%% ¡name!
Construct the data point with the graph measures derived from its weighted undirected graph (GraphWU) 
%%%% ¡code!
% ensure the example data is generated
if ~isfile([fileparts(which('NNDataPoint_CON_CLA')) filesep 'Example data NN CLA CON XLS' filesep 'atlas.xlsx'])
    create_data_NN_CLA_CON_XLS() % create example files
end

% Load BrainAtlas
im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [fileparts(which('NNDataPoint_CON_CLA')) filesep 'Example data NN CLA CON XLS' filesep 'atlas.xlsx'], ...
    'WAITBAR', true ...
    );

ba = im_ba.get('BA');

% Load Groups of SubjectCON
im_gr1 = ImporterGroupSubjectCON_XLS( ...
    'DIRECTORY', [fileparts(which('NNDataPoint_CON_CLA')) filesep 'Example data NN CLA CON XLS' filesep 'CON_Group_1_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr1 = im_gr1.get('GR');

im_gr2 = ImporterGroupSubjectCON_XLS( ...
    'DIRECTORY', [fileparts(which('NNDataPoint_CON_CLA')) filesep 'Example data NN CLA CON XLS' filesep 'CON_Group_2_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr2 = im_gr2.get('GR');

% Analysis CON WU
a_WU1 = AnalyzeEnsemble_CON_WU( ...
    'GR', gr1 ...
    );

a_WU2 = AnalyzeEnsemble_CON_WU( ...
    'TEMPLATE', a_WU1, ...
    'GR', gr2 ...
    );

a_WU1.get('MEASUREENSEMBLE', 'Degree').get('M');
a_WU1.get('MEASUREENSEMBLE', 'DegreeAv').get('M');
a_WU1.get('MEASUREENSEMBLE', 'Distance').get('M');

a_WU2.get('MEASUREENSEMBLE', 'Degree').get('M');
a_WU2.get('MEASUREENSEMBLE', 'DegreeAv').get('M');
a_WU2.get('MEASUREENSEMBLE', 'Distance').get('M');

% create item lists of NNDataPoint_Graph_CLA
[~, group_folder_name] = fileparts(im_gr1.get('DIRECTORY'));
it_list1 = cellfun(@(x) NNDataPoint_Measure_CLA( ...
    'ID', x.get('ID'), ...
    'G', x, ...
    'M_LIST', {'Degree' 'DegreeAv' 'Distance'}, ...
    'TARGET_CLASS', {group_folder_name}), ...
    a_WU1.get('G_DICT').get('IT_LIST'), ...
    'UniformOutput', false);

[~, group_folder_name] = fileparts(im_gr2.get('DIRECTORY'));
it_list2 = cellfun(@(x) NNDataPoint_Measure_CLA( ...
    'ID', x.get('ID'), ...
    'G', x, ...
    'M_LIST', {'Degree' 'DegreeAv' 'Distance'}, ...
    'TARGET_CLASS', {group_folder_name}), ...
    a_WU2.get('G_DICT').get('IT_LIST'), ...
    'UniformOutput', false);

% create NNDataPoint_Graph_CLA DICT items
dp_list1 = IndexedDictionary(...
        'IT_CLASS', 'NNDataPoint_Measure_CLA', ...
        'IT_LIST', it_list1 ...
        );

dp_list2 = IndexedDictionary(...
        'IT_CLASS', 'NNDataPoint_Measure_CLA', ...
        'IT_LIST', it_list2 ...
        );

% create a NNDataset containing the NNDataPoint_Measure_CLA DICT
d1 = NNDataset( ...
    'DP_CLASS', 'NNDataPoint_Measure_CLA', ...
    'DP_DICT', dp_list1 ...
    );

d2 = NNDataset( ...
    'DP_CLASS', 'NNDataPoint_Measure_CLA', ...
    'DP_DICT', dp_list2 ...
    );

% Check whether the content of input for a single datapoint matches
for index = 1:1:gr1.get('SUB_DICT').get('LENGTH')
    individual_input = d1.get('DP_DICT').get('IT', index).get('INPUT');
    known_input = cellfun(@(m) m.get('M'), a_WU1.get('G_DICT').get('IT', index).get('M_DICT').get('IT_LIST'), 'UniformOutput', false);

    assert(isequal(individual_input, known_input), ...
        [BRAPH2.STR ':NNDataPoint_Measure_CLA:' BRAPH2.FAIL_TEST], ...
        'NNDataPoint_Measure_CLA does not construct the dataset correctly. The input value is not derived correctly.' ...
        )
end

for index = 1:1:gr2.get('SUB_DICT').get('LENGTH')
    individual_input = d2.get('DP_DICT').get('IT', index).get('INPUT');
    known_input = cellfun(@(m) m.get('M'), a_WU2.get('G_DICT').get('IT', index).get('M_DICT').get('IT_LIST'), 'UniformOutput', false);

    assert(isequal(individual_input, known_input), ...
        [BRAPH2.STR ':NNDataPoint_Measure_CLA:' BRAPH2.FAIL_TEST], ...
        'NNDataPoint_Measure_CLA does not construct the dataset correctly. The input value is not derived correctly.' ...
        )
end

%%% ¡test!
%%%% ¡name!
Construct the data point with the graph measures derived from its binary undirected multigraph with fixed densities (MultigraphBUD)
%%%% ¡code!
% ensure the example data is generated
if ~isfile([fileparts(which('NNDataPoint_CON_CLA')) filesep 'Example data NN CLA CON XLS' filesep 'atlas.xlsx'])
    create_data_NN_CLA_CON_XLS() % create example files
end

% Load BrainAtlas
im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [fileparts(which('NNDataPoint_CON_CLA')) filesep 'Example data NN CLA CON XLS' filesep 'atlas.xlsx'], ...
    'WAITBAR', true ...
    );

ba = im_ba.get('BA');

% Load Groups of SubjectCON
im_gr1 = ImporterGroupSubjectCON_XLS( ...
    'DIRECTORY', [fileparts(which('NNDataPoint_CON_CLA')) filesep 'Example data NN CLA CON XLS' filesep 'CON_Group_1_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr1 = im_gr1.get('GR');

im_gr2 = ImporterGroupSubjectCON_XLS( ...
    'DIRECTORY', [fileparts(which('NNDataPoint_CON_CLA')) filesep 'Example data NN CLA CON XLS' filesep 'CON_Group_2_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr2 = im_gr2.get('GR');

% Analysis CON WU
densities = 0:25:100;

a_BUD1 = AnalyzeEnsemble_CON_BUD( ...
    'DENSITIES', densities, ...
    'GR', gr1 ...
    );

a_BUD2 = AnalyzeEnsemble_CON_BUD( ...
    'TEMPLATE', a_BUD1, ...
    'GR', gr2 ...
    );

a_BUD1.get('MEASUREENSEMBLE', 'Degree').get('M');
a_BUD1.get('MEASUREENSEMBLE', 'DegreeAv').get('M');
a_BUD1.get('MEASUREENSEMBLE', 'Distance').get('M');

a_BUD2.get('MEASUREENSEMBLE', 'Degree').get('M');
a_BUD2.get('MEASUREENSEMBLE', 'DegreeAv').get('M');
a_BUD2.get('MEASUREENSEMBLE', 'Distance').get('M');

% create item lists of NNDataPoint_Graph_CLA
[~, group_folder_name] = fileparts(im_gr1.get('DIRECTORY'));
it_list1 = cellfun(@(x) NNDataPoint_Measure_CLA( ...
    'ID', x.get('ID'), ...
    'G', x, ...
    'M_LIST', {'Degree' 'DegreeAv' 'Distance'}, ...
    'TARGET_CLASS', {group_folder_name}), ...
    a_BUD1.get('G_DICT').get('IT_LIST'), ...
    'UniformOutput', false);

[~, group_folder_name] = fileparts(im_gr2.get('DIRECTORY'));
it_list2 = cellfun(@(x) NNDataPoint_Measure_CLA( ...
    'ID', x.get('ID'), ...
    'G', x, ...
    'M_LIST', {'Degree' 'DegreeAv' 'Distance'}, ...
    'TARGET_CLASS', {group_folder_name}), ...
    a_BUD2.get('G_DICT').get('IT_LIST'), ...
    'UniformOutput', false);

% create NNDataPoint_Graph_CLA DICT items
dp_list1 = IndexedDictionary(...
        'IT_CLASS', 'NNDataPoint_Measure_CLA', ...
        'IT_LIST', it_list1 ...
        );

dp_list2 = IndexedDictionary(...
        'IT_CLASS', 'NNDataPoint_Measure_CLA', ...
        'IT_LIST', it_list2 ...
        );

% create a NNDataset containing the NNDataPoint_Measure_CLA DICT
d1 = NNDataset( ...
    'DP_CLASS', 'NNDataPoint_Measure_CLA', ...
    'DP_DICT', dp_list1 ...
    );

d2 = NNDataset( ...
    'DP_CLASS', 'NNDataPoint_Measure_CLA', ...
    'DP_DICT', dp_list2 ...
    );

% Check whether the content of input for a single datapoint matches
for index = 1:1:gr1.get('SUB_DICT').get('LENGTH')
    individual_input = d1.get('DP_DICT').get('IT', index).get('INPUT');
    known_input = cellfun(@(m) m.get('M'), a_BUD1.get('G_DICT').get('IT', index).get('M_DICT').get('IT_LIST'), 'UniformOutput', false);

    assert(isequal(individual_input, known_input), ...
        [BRAPH2.STR ':NNDataPoint_Measure_CLA:' BRAPH2.FAIL_TEST], ...
        'NNDataPoint_Measure_CLA does not construct the dataset correctly. The input value is not derived correctly.' ...
        )
end

for index = 1:1:gr2.get('SUB_DICT').get('LENGTH')
    individual_input = d2.get('DP_DICT').get('IT', index).get('INPUT');
    known_input = cellfun(@(m) m.get('M'), a_BUD2.get('G_DICT').get('IT', index).get('M_DICT').get('IT_LIST'), 'UniformOutput', false);

    assert(isequal(individual_input, known_input), ...
        [BRAPH2.STR ':NNDataPoint_Measure_CLA:' BRAPH2.FAIL_TEST], ...
        'NNDataPoint_Measure_CLA does not construct the dataset correctly. The input value is not derived correctly.' ...
        )
end

%%% ¡test!
%%%% ¡name!
Construct the data point with the graph measures derived from its multiplex weighted undirected graph (MultiplexWU) 
%%%% ¡code!
% ensure the example data is generated
if ~isfile([fileparts(which('NNDataPoint_CON_FUN_MP_CLA')) filesep 'Example data NN CLA CON_FUN_MP XLS' filesep 'atlas.xlsx'])
    create_data_NN_CLA_CON_FUN_MP_XLS() % create example files
end

% Load BrainAtlas
im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [fileparts(which('NNDataPoint_CON_FUN_MP_CLA')) filesep 'Example data NN CLA CON_FUN_MP XLS' filesep 'atlas.xlsx'], ...
    'WAITBAR', true ...
    );

ba = im_ba.get('BA');

% Load Groups of SubjectCON
im_gr1 = ImporterGroupSubjectCON_XLS( ...
    'DIRECTORY', [fileparts(which('NNDataPoint_CON_FUN_MP_CLA')) filesep 'Example data NN CLA CON_FUN_MP XLS' filesep 'Connectivity' filesep 'CON_FUN_MP_Group1_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr1_CON = im_gr1.get('GR');

im_gr2 = ImporterGroupSubjectCON_XLS( ...
    'DIRECTORY', [fileparts(which('NNDataPoint_CON_FUN_MP_CLA')) filesep 'Example data NN CLA CON_FUN_MP XLS' filesep 'Connectivity' filesep 'CON_FUN_MP_Group2_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr2_CON = im_gr2.get('GR');

% Load Groups of SubjectFUN
im_gr1 = ImporterGroupSubjectFUN_XLS( ...
    'DIRECTORY', [fileparts(which('NNDataPoint_CON_FUN_MP_CLA')) filesep 'Example data NN CLA CON_FUN_MP XLS' filesep 'Functional' filesep 'CON_FUN_MP_Group1_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr1_FUN = im_gr1.get('GR');

im_gr2 = ImporterGroupSubjectFUN_XLS( ...
    'DIRECTORY', [fileparts(which('NNDataPoint_CON_FUN_MP_CLA')) filesep 'Example data NN CLA CON_FUN_MP XLS' filesep 'Functional' filesep 'CON_FUN_MP_Group2_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr2_FUN = im_gr2.get('GR');

% Combine Groups of SubjectCON with Groups of SubjectFUN
co_gr1 = CombineGroups_CON_FUN_MP( ...
    'GR_CON', gr1_CON, ...
    'GR_FUN', gr1_FUN, ...
    'WAITBAR', true ...
    );

gr1 = co_gr1.get('GR_CON_FUN_MP');

co_gr2 = CombineGroups_CON_FUN_MP( ...
    'GR_CON', gr2_CON, ...
    'GR_FUN', gr2_FUN, ...
    'WAITBAR', true ...
    );

gr2 = co_gr2.get('GR_CON_FUN_MP');

% Analysis CON FUN MP WU
a_WU1 = AnalyzeEnsemble_CON_FUN_MP_WU( ...
    'GR', gr1 ...
    );

a_WU2 = AnalyzeEnsemble_CON_FUN_MP_WU( ...
    'TEMPLATE', a_WU1, ...
    'GR', gr2 ...
    );

% To be added the multiplex measures
a_WU1.get('MEASUREENSEMBLE', 'Degree').get('M');
a_WU1.get('MEASUREENSEMBLE', 'DegreeAv').get('M');
a_WU1.get('MEASUREENSEMBLE', 'Distance').get('M');

a_WU2.get('MEASUREENSEMBLE', 'Degree').get('M');
a_WU2.get('MEASUREENSEMBLE', 'DegreeAv').get('M');
a_WU2.get('MEASUREENSEMBLE', 'Distance').get('M');

% create item lists of NNDataPoint_Graph_CLA
[~, group_folder_name] = fileparts(im_gr1.get('DIRECTORY'));
it_list1 = cellfun(@(x) NNDataPoint_Measure_CLA( ...
    'ID', x.get('ID'), ...
    'G', x, ...
    'M_LIST', {'Degree' 'DegreeAv' 'Distance'}, ...
    'TARGET_CLASS', {group_folder_name}), ...
    a_WU1.get('G_DICT').get('IT_LIST'), ...
    'UniformOutput', false);

[~, group_folder_name] = fileparts(im_gr2.get('DIRECTORY'));
it_list2 = cellfun(@(x) NNDataPoint_Measure_CLA( ...
    'ID', x.get('ID'), ...
    'G', x, ...
    'M_LIST', {'Degree' 'DegreeAv' 'Distance'}, ...
    'TARGET_CLASS', {group_folder_name}), ...
    a_WU2.get('G_DICT').get('IT_LIST'), ...
    'UniformOutput', false);

% create NNDataPoint_Graph_CLA DICT items
dp_list1 = IndexedDictionary(...
        'IT_CLASS', 'NNDataPoint_Measure_CLA', ...
        'IT_LIST', it_list1 ...
        );

dp_list2 = IndexedDictionary(...
        'IT_CLASS', 'NNDataPoint_Measure_CLA', ...
        'IT_LIST', it_list2 ...
        );

% create a NNDataset containing the NNDataPoint_Measure_CLA DICT
d1 = NNDataset( ...
    'DP_CLASS', 'NNDataPoint_Measure_CLA', ...
    'DP_DICT', dp_list1 ...
    );

d2 = NNDataset( ...
    'DP_CLASS', 'NNDataPoint_Measure_CLA', ...
    'DP_DICT', dp_list2 ...
    );

% Check whether the content of input for a single datapoint matches
for index = 1:1:gr1.get('SUB_DICT').get('LENGTH')
    individual_input = d1.get('DP_DICT').get('IT', index).get('INPUT');
    known_input = cellfun(@(m) m.get('M'), a_WU1.get('G_DICT').get('IT', index).get('M_DICT').get('IT_LIST'), 'UniformOutput', false);

    assert(isequal(individual_input, known_input), ...
        [BRAPH2.STR ':NNDataPoint_Measure_CLA:' BRAPH2.FAIL_TEST], ...
        'NNDataPoint_Measure_CLA does not construct the dataset correctly. The input value is not derived correctly.' ...
        )
end

for index = 1:1:gr2.get('SUB_DICT').get('LENGTH')
    individual_input = d2.get('DP_DICT').get('IT', index).get('INPUT');
    known_input = cellfun(@(m) m.get('M'), a_WU2.get('G_DICT').get('IT', index).get('M_DICT').get('IT_LIST'), 'UniformOutput', false);

    assert(isequal(individual_input, known_input), ...
        [BRAPH2.STR ':NNDataPoint_Measure_CLA:' BRAPH2.FAIL_TEST], ...
        'NNDataPoint_Measure_CLA does not construct the dataset correctly. The input value is not derived correctly.' ...
        )
end

%%% ¡test!
%%%% ¡name!
Example script for binary undirected graph at fixed densities (GraphBUD) using connectivity data
%%%% ¡code!
if ~isfile([fileparts(which('NNDataPoint_CON_CLA')) filesep 'Example data NN CLA CON XLS' filesep 'atlas.xlsx'])
    create_data_NN_CLA_CON_XLS() % create example files
end
example_NNCV_CON_BUD_M_CLA

%%% ¡test!
%%%% ¡name!
Example script for binary undirected graph at fixed thresholds (MultigraphBUT) using connectivity data
%%%% ¡code!
if ~isfile([fileparts(which('NNDataPoint_CON_CLA')) filesep 'Example data NN CLA CON XLS' filesep 'atlas.xlsx'])
    create_data_NN_CLA_CON_XLS() % create example files
end
example_NNCV_CON_BUT_M_CLA

%%% ¡test!
%%%% ¡name!
Example script for binary undirected graph at fixed densities (MultigraphBUD) using connectivity data
%%%% ¡code!
if ~isfile([fileparts(which('NNDataPoint_CON_CLA')) filesep 'Example data NN CLA CON XLS' filesep 'atlas.xlsx'])
    create_data_NN_CLA_CON_XLS() % create example files
end
example_NNCV_CON_BUD_M_CLA

%%% ¡test!
%%%% ¡name!
Example script for binary undirected multiplex at fixed densities (MultiplexBUD) using connectivity data and functional data
%%%% ¡code!
if ~isfile([fileparts(which('NNDataPoint_CON_FUN_MP_CLA')) filesep 'Example data NN CLA CON_FUN_MP XLS' filesep 'atlas.xlsx'])
    create_data_NN_CLA_CON_FUN_MP_XLS() % create example files
end
example_NNCV_CON_FUN_MP_BUD_M_CLA

%%% ¡test!
%%%% ¡name!
Example script for binary undirected multiplex at fixed thresholds (MultiplexBUT) using connectivity data and functional data
%%%% ¡code!
if ~isfile([fileparts(which('NNDataPoint_CON_FUN_MP_CLA')) filesep 'Example data NN CLA CON_FUN_MP XLS' filesep 'atlas.xlsx'])
    create_data_NN_CLA_CON_FUN_MP_XLS % create example files
end
example_NNCV_CON_FUN_MP_BUT_M_CLA

%%% ¡test!
%%%% ¡name!
Example script for binary undirected multigraph at fixed densities (MultiplexBUD) using functional data
%%%% ¡code!
if ~isfile([fileparts(which('NNDataPoint_FUN_CLA')) filesep 'Example data NN CLA FUN XLS' filesep 'atlas.xlsx'])
    create_data_NN_CLA_FUN_XLS() % create example files
end
example_NNCV_FUN_BUD_M_CLA

%%% ¡test!
%%%% ¡name!
Example script for binary undirected multigraph at fixed thresholds (MultiplexBUT) using functional data
%%%% ¡code!
if ~isfile([fileparts(which('NNDataPoint_FUN_CLA')) filesep 'Example data NN CLA FUN XLS' filesep 'atlas.xlsx'])
    create_data_NN_CLA_FUN_XLS() % create example files
end
example_NNCV_FUN_BUT_M_CLA