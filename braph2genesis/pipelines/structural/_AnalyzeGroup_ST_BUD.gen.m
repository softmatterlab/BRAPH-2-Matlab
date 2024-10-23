%% ¡header!
AnalyzeGroup_ST_BUD < AnalyzeGroup (a, graph analysis with structural data at fixed density) is a graph analysis using structural data at fixed density.

%%% ¡description!
AnalyzeGroup_ST_BUD uses structural data at fixed density and analyzes them using binary undirected graphs.

%%% ¡seealso!
SubjectST, MultigraphBUD

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
AnalyzeGroup_ST_BUD.ID
%%%% ¡title!
Analysis ID

%%% ¡prop!
%%%% ¡id!
AnalyzeGroup_ST_BUD.LABEL
%%%% ¡title!
Analysis NAME

%%% ¡prop!
%%%% ¡id!
AnalyzeGroup_ST_BUD.WAITBAR
%%%% ¡title!
WAITBAR ON/OFF

%%% ¡prop!
%%%% ¡id!
AnalyzeGroup_ST_BUD.GR
%%%% ¡title!
SUBJECT GROUP

%%% ¡prop!
%%%% ¡id!
AnalyzeGroup_ST_BUD.CORRELATION_RULE
%%%% ¡title!
CORRELATION RULE

%%% ¡prop!
%%%% ¡id!
AnalyzeGroup_ST_BUD.NEGATIVE_WEIGHT_RULE
%%%% ¡title!
NEGATIVE WEIGHTS RULE

%%% ¡prop!
%%%% ¡id!
AnalyzeGroup_ST_BUD.DENSITIES
%%%% ¡title!
DENSITIES [0% ... 100%]

%%% ¡prop!
%%%% ¡id!
AnalyzeGroup_ST_BUD.G
%%%% ¡title!
GRAPH & MEASURES

%%% ¡prop!
%%%% ¡id!
AnalyzeGroup_ST_BUD.NOTES
%%%% ¡title!
Analysis NOTES

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the group-based graph analysis with structural data at fixed density.
%%%% ¡default!
'AnalyzeGroup_ST_BUD'

%%% ¡prop!
NAME (constant, string) is the name of the group-based graph analysis with structural data at fixed density.
%%%% ¡default!
'Structural Binary Undirected at fixed Densities Analyze Group'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the group-based graph analysis with structural data at fixed density.
%%%% ¡default!
'AnalyzeGroup_ST_BUD uses structural data at fixed density and analyzes them using binary undirected graphs.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the group-based graph analysis with structural data at fixed density.
%%%% ¡settings!
'AnalyzeGroup_ST_BUD'

%%% ¡prop!
ID (data, string) is a few-letter code for the group-based graph analysis with structural data at fixed density.
%%%% ¡default!
'AnalyzeGroup_ST_BUD ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the group-based graph analysis with structural data at fixed density.
%%%% ¡default!
'AnalyzeGroup_ST_BUD label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the group-based graph analysis with structural data at fixed density.
%%%% ¡default!
'AnalyzeGroup_ST_BUD notes'

%%% ¡prop!
GR (data, item) is the subject group, which also defines the subject class SubjectST.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectST')

%%% ¡prop!
G (result, item) is the graph obtained from this analysis.
%%%% ¡settings!
'MultigraphBUD'
%%%% ¡calculate!
gr = a.get('GR');
data_list = cellfun(@(x) x.get('ST'), gr.get('SUB_DICT').get('IT_LIST'), 'UniformOutput', false);
data = cat(2, data_list{:})'; % correlation is a column based operation

if any(strcmp(a.get('CORRELATION_RULE'), {Correlation.PEARSON_CV, Correlation.SPEARMAN_CV}))
	A = Correlation.getAdjacencyMatrix(data, a.get('CORRELATION_RULE'), a.get('NEGATIVE_WEIGHT_RULE'), gr.get('COVARIATES'));
else
    A = Correlation.getAdjacencyMatrix(data, a.get('CORRELATION_RULE'), a.get('NEGATIVE_WEIGHT_RULE'));
end

densities = a.get('DENSITIES'); % this is a vector

g = MultigraphBUD( ...
    'ID', ['Graph ' gr.get('ID')], ...
    'B', A, ...
    'DENSITIES', densities, ... 
    'LAYERLABELS', cellfun(@(x) [num2str(x) '%'], num2cell(densities), 'UniformOutput', false) ...
    );

if ~isa(a.getr('TEMPLATE'), 'NoValue') % the analysis has a template
    g.set('TEMPLATE', a.get('TEMPLATE').memorize('G')) % the template is memorized - overwrite densities
end

if a.get('GR').get('SUB_DICT').get('LENGTH')
    g.set('NODELABELS', a.get('GR').get('SUB_DICT').get('IT', 1).get('BA').get('BR_DICT').get('KEYS'))
end

value = g;

%% ¡props!

%%% ¡prop!
CORRELATION_RULE (parameter, option) is the correlation type.
%%%% ¡settings!
Correlation.CORRELATION_RULE_LIST
%%%% ¡default!
Correlation.PEARSON

%%% ¡prop!
NEGATIVE_WEIGHT_RULE (parameter, option) determines how to deal with negative weights.
%%%% ¡settings!
Correlation.NEGATIVE_WEIGHT_RULE_LIST
%%%% ¡default!
Correlation.ZERO

%%% ¡prop!
DENSITIES (parameter, rvector) is the vector of densities.
%%%% ¡default!
[1:1:10]
%%%% ¡gui!
pr = PanelPropRVectorSmart('EL', a, 'PROP', AnalyzeGroup_ST_BUD.DENSITIES, ...
    'MIN', 0, 'MAX', 100, ...
    'DEFAULT', AnalyzeGroup_ST_BUD.getPropDefault('DENSITIES'), ...
    varargin{:});

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡probability!
.01
%%%% ¡code!
create_data_ST_XLS() % only creates files if the example folder doesn't already exist

example_ST_BUD

%%% ¡test!
%%%% ¡name!
GUI - Analysis
%%%% ¡probability!
.01
%%%% ¡code!
im_ba = ImporterBrainAtlasXLS('FILE', 'destrieux_atlas.xlsx');
ba = im_ba.get('BA');

gr = Group('SUB_CLASS', 'SubjectST', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectST'));
for i = 1:1:50
    sub = SubjectST( ...
        'ID', ['SUB ST ' int2str(i)], ...
        'LABEL', ['Subejct ST ' int2str(i)], ...
        'NOTES', ['Notes on subject ST ' int2str(i)], ...
        'BA', ba, ...
        'ST', rand(ba.get('BR_DICT').get('LENGTH'), 1) ...
        );
    sub.memorize('VOI_DICT').get('ADD', VOINumeric('ID', 'Age', 'V', 100 * rand()))
    sub.memorize('VOI_DICT').get('ADD', VOICategoric('ID', 'Sex', 'CATEGORIES', {'Female', 'Male'}, 'V', randi(2, 1)))
    gr.get('SUB_DICT').get('ADD', sub)
end

a = AnalyzeGroup_ST_BUD('GR', gr, 'DENSITIES', 5:10:35);

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
im_ba = ImporterBrainAtlasXLS('FILE', 'destrieux_atlas.xlsx');
ba = im_ba.get('BA');

gr1 = Group('SUB_CLASS', 'SubjectST', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectST'));
for i = 1:1:50
    sub = SubjectST( ...
        'ID', ['SUB ST ' int2str(i)], ...
        'LABEL', ['Subejct ST ' int2str(i)], ...
        'NOTES', ['Notes on subject ST ' int2str(i)], ...
        'BA', ba, ...
        'ST', rand(ba.get('BR_DICT').get('LENGTH'), 1) ...
        );
    sub.memorize('VOI_DICT').get('ADD', VOINumeric('ID', 'Age', 'V', 100 * rand()))
    sub.memorize('VOI_DICT').get('ADD', VOICategoric('ID', 'Sex', 'CATEGORIES', {'Female', 'Male'}, 'V', randi(2, 1)))
    gr1.get('SUB_DICT').get('ADD', sub)
end

gr2 = Group('SUB_CLASS', 'SubjectST', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectST'));
for i = 1:1:50
    sub = SubjectST( ...
        'ID', ['SUB ST ' int2str(i)], ...
        'LABEL', ['Subejct ST ' int2str(i)], ...
        'NOTES', ['Notes on subject ST ' int2str(i)], ...
        'BA', ba, ...
        'ST', rand(ba.get('BR_DICT').get('LENGTH'), 1) ...
        );
    sub.memorize('VOI_DICT').get('ADD', VOINumeric('ID', 'Age', 'V', 100 * rand()))
    sub.memorize('VOI_DICT').get('ADD', VOICategoric('ID', 'Sex', 'CATEGORIES', {'Female', 'Male'}, 'V', randi(2, 1)))
    gr2.get('SUB_DICT').get('ADD', sub)
end

a1 = AnalyzeGroup_ST_BUD('GR', gr1, 'DENSITIES', 5:10:35);
a2 = AnalyzeGroup_ST_BUD('GR', gr2, 'TEMPLATE', a1);

c = CompareGroup( ...
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