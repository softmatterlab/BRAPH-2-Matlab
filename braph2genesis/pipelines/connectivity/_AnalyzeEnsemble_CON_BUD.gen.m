%% ¡header!
AnalyzeEnsemble_CON_BUD < AnalyzeEnsemble (a, graph analysis with connectivity data of fixed density) is an ensemble-based graph analysis using connectivity data of fixed density.

%%% ¡description!
This ensemble-based graph analysis (AnalyzeEnsemble_CON_BUD) analyzes 
connectivity data using binary undirected multigraphs with fixed densities.

%%% ¡seealso!
SubjectCON, MultigraphBUD

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_CON_BUD.ID
%%%% ¡title!
Analysis ID

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_CON_BUD.LABEL
%%%% ¡title!
Analysis NAME

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_CON_BUD.WAITBAR
%%%% ¡title!
WAITBAR ON/OFF

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_CON_BUD.GR
%%%% ¡title!
SUBJECT GROUP

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_CON_BUD.GRAPH_TEMPLATE
%%%% ¡title!
GRAPH & MEASURE PARAMETERS

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_CON_BUD.DENSITIES
%%%% ¡title!
DENSITIES [0% ... 100%]

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_CON_BUD.ME_DICT
%%%% ¡title!
Group-averaged MEASURES

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_CON_BUD.G_DICT
%%%% ¡title!
Individual GRAPHS

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_CON_BUD.NOTES
%%%% ¡title!
Analysis NOTES

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the ensemble-based graph analysis using connectivity data of fixed density.
%%%% ¡default!
'AnalyzeEnsemble_CON_BUD'

%%% ¡prop!
NAME (constant, string) is the name of the ensemble-based graph analysis using connectivity data of fixed density.
%%%% ¡default!
'Connectivity Binary Undirected at fixed Density Analyze Ensemble'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the ensemble-based graph analysis using connectivity data of fixed density.
%%%% ¡default!
'This ensemble-based graph analysis (AnalyzeEnsemble_CON_BUD) analyzes connectivity data using binary undirected multigraphs with fixed densities.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the ensemble-based graph analysis using connectivity data of fixed density.
%%%% ¡settings!
'AnalyzeEnsemble_CON_BUD'

%%% ¡prop!
ID (data, string) is a few-letter code for the ensemble-based graph analysis using connectivity data of fixed density.
%%%% ¡default!
'AnalyzeEnsemble_CON_BUD ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the ensemble-based graph analysis using connectivity data of fixed density.
%%%% ¡default!
'AnalyzeEnsemble_CON_BUD label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the ensemble-based graph analysis using connectivity data of fixed density.
%%%% ¡default!
'AnalyzeEnsemble_CON_BUD notes'

%%% ¡prop!
GR (data, item) is the subject group, which also defines the subject class SubjectCON.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectCON')

%%% ¡prop!
GRAPH_TEMPLATE (parameter, item) is the graph template to set all graph and measure parameters.
%%%% ¡settings!
'MultigraphBUD'

%%% ¡prop!
G_DICT (result, idict) is the graph (MultigraphBUD) ensemble obtained from this analysis.
%%%% ¡settings!
'MultigraphBUD'
%%%% ¡calculate!
g_dict = IndexedDictionary('IT_CLASS', 'MultigraphBUD');
gr = a.get('GR');
densities = a.get('DENSITIES');

for i = 1:1:gr.get('SUB_DICT').get('LENGTH')
	sub = gr.get('SUB_DICT').get('IT', i);
    g = MultigraphBUD( ...
        'ID', ['graph ' sub.get('ID')], ...
        'B', sub.getCallback('CON'), ...
        'DENSITIES', densities, ...
        'LAYERLABELS', cellfun(@(x) [num2str(x) '%'], num2cell(densities), 'UniformOutput', false), ...
        'NODELABELS', a.get('GR').get('SUB_DICT').get('IT', 1).get('BA').get('BR_DICT').get('KEYS') ...
        );
    g_dict.get('ADD', g)
end

if ~isa(a.get('GRAPH_TEMPLATE'), 'NoValue')
    for i = 1:1:g_dict.get('LENGTH')
        g_dict.get('IT', i).set('TEMPLATE', a.get('GRAPH_TEMPLATE'))
    end
end

value = g_dict;

%%% ¡prop!
ME_DICT (result, idict) contains the calculated measures of the graph ensemble.

%% ¡props!

%%% ¡prop!
DENSITIES (parameter, rvector) is the vector of densities.
%%%% ¡default!
[1:1:10]
%%%% ¡gui!
pr = PanelPropRVectorSmart('EL', a, 'PROP', AnalyzeEnsemble_CON_BUD.DENSITIES, ...
    'MIN', 0, 'MAX', 100, ...
    'DEFAULT', AnalyzeEnsemble_CON_BUD.getPropDefault('DENSITIES'), ...
    varargin{:});
%%%% ¡postset!
a.memorize('GRAPH_TEMPLATE').set('DENSITIES', a.getCallback('DENSITIES'));

%% ¡tests!

%%% ¡excluded_props!
[AnalyzeEnsemble_CON_BUD.TEMPLATE AnalyzeEnsemble_CON_BUD.GRAPH_TEMPLATE]

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡probability!
.01
%%%% ¡code!
create_data_CON_XLS() % only creates files if the example folder doesn't already exist

example_CON_BUD

%%% ¡test!
%%%% ¡name!
GUI - Analysis
%%%% ¡probability!
.01
%%%% ¡code!
im_ba = ImporterBrainAtlasXLS('FILE', 'desikan_atlas.xlsx');
ba = im_ba.get('BA');

gr = Group('SUB_CLASS', 'SubjectCON', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON'));
for i = 1:1:50
    sub = SubjectCON( ...
        'ID', ['SUB CON ' int2str(i)], ...
        'LABEL', ['Subejct CON ' int2str(i)], ...
        'NOTES', ['Notes on subject CON ' int2str(i)], ...
        'BA', ba, ...
        'CON', rand(ba.get('BR_DICT').get('LENGTH')) ...
        );
    sub.memorize('VOI_DICT').get('ADD', VOINumeric('ID', 'Age', 'V', 100 * rand()))
    sub.memorize('VOI_DICT').get('ADD', VOICategoric('ID', 'Sex', 'CATEGORIES', {'Female', 'Male'}, 'V', randi(2, 1)))
    gr.get('SUB_DICT').get('ADD', sub)
end

a = AnalyzeEnsemble_CON_BUD('GR', gr, 'DENSITIES', 5:5:20);

gui = GUIElement('PE', a, 'CLOSEREQ', false);
gui.get('DRAW')
gui.get('SHOW')

gui.get('CLOSE')

%%% ¡test!
%%%% ¡name!
GUI - Comparison
%%%% ¡probability!
.01
%%%% ¡code!
im_ba = ImporterBrainAtlasXLS('FILE', 'desikan_atlas.xlsx');
ba = im_ba.get('BA');

gr1 = Group('SUB_CLASS', 'SubjectCON', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON'));
for i = 1:1:50
    sub = SubjectCON( ...
        'ID', ['SUB CON ' int2str(i)], ...
        'LABEL', ['Subejct CON ' int2str(i)], ...
        'NOTES', ['Notes on subject CON ' int2str(i)], ...
        'BA', ba, ...
        'CON', rand(ba.get('BR_DICT').get('LENGTH')) ...
        );
    sub.memorize('VOI_DICT').get('ADD', VOINumeric('ID', 'Age', 'V', 100 * rand()))
    sub.memorize('VOI_DICT').get('ADD', VOICategoric('ID', 'Sex', 'CATEGORIES', {'Female', 'Male'}, 'V', randi(2, 1)))
    gr1.get('SUB_DICT').get('ADD', sub)
end

gr2 = Group('SUB_CLASS', 'SubjectCON', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON'));
for i = 1:1:50
    sub = SubjectCON( ...
        'ID', ['SUB CON ' int2str(i)], ...
        'LABEL', ['Subejct CON ' int2str(i)], ...
        'NOTES', ['Notes on subject CON ' int2str(i)], ...
        'BA', ba, ...
        'CON', rand(ba.get('BR_DICT').get('LENGTH')) ...
        );
    sub.memorize('VOI_DICT').get('ADD', VOINumeric('ID', 'Age', 'V', 100 * rand()))
    sub.memorize('VOI_DICT').get('ADD', VOICategoric('ID', 'Sex', 'CATEGORIES', {'Female', 'Male'}, 'V', randi(2, 1)))
    gr2.get('SUB_DICT').get('ADD', sub)
end

a1 = AnalyzeEnsemble_CON_BUD('GR', gr1, 'DENSITIES', 5:5:20);
a2 = AnalyzeEnsemble_CON_BUD('GR', gr2, 'TEMPLATE', a1);

c = CompareEnsemble( ...
    'P', 10, ...
    'A1', a1, ...
    'A2', a2, ...
    'WAITBAR', true, ...
    'VERBOSE', false, ...
    'MEMORIZE', true ...
    );

gui = GUIElement('PE', c, 'CLOSEREQ', false);
gui.get('DRAW')
gui.get('SHOW')

gui.get('CLOSE')