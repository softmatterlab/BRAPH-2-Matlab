%% ¡header!
AnalyzeGroup_ST_WU < AnalyzeGroup (a, graph analysis with structural data) is a graph analysis using structural data.

%%% ¡description!
AnalyzeGroup_ST_WU uses structural data and analyzes them using weighted undirected graphs.

%%% ¡seealso!
SubjectST, GraphWU

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
AnalyzeGroup_ST_WU.ID
%%%% ¡title!
Analysis ID

%%% ¡prop!
%%%% ¡id!
AnalyzeGroup_ST_WU.LABEL
%%%% ¡title!
Analysis NAME

%%% ¡prop!
%%%% ¡id!
AnalyzeGroup_ST_WU.WAITBAR
%%%% ¡title!
WAITBAR ON/OFF

%%% ¡prop!
%%%% ¡id!
AnalyzeGroup_ST_WU.GR
%%%% ¡title!
SUBJECT GROUP

%%% ¡prop!
%%%% ¡id!
AnalyzeGroup_ST_WU.CORRELATION_RULE
%%%% ¡title!
CORRELATION RULE

%%% ¡prop!
%%%% ¡id!
AnalyzeGroup_ST_WU.NEGATIVE_WEIGHT_RULE
%%%% ¡title!
NEGATIVE WEIGHTS RULE

%%% ¡prop!
%%%% ¡id!
AnalyzeGroup_ST_WU.G
%%%% ¡title!
GRAPH & MEASURES

%%% ¡prop!
%%%% ¡id!
AnalyzeGroup_ST_WU.NOTES
%%%% ¡title!
Analysis NOTES

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the group-based graph analysis with structural data.
%%%% ¡default!
'AnalyzeGroup_ST_WU'

%%% ¡prop!
NAME (constant, string) is the name of the group-based graph analysis with structural data.
%%%% ¡default!
'Structural Weighted Undirected Analyze Group'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the group-based graph analysis with structural data.
%%%% ¡default!
'AnalyzeGroup_ST_WU uses structural data and analyzes them using weighted undirected graphs.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the group-based graph analysis with structural data.
%%%% ¡settings!
'AnalyzeGroup_ST_WU'

%%% ¡prop!
ID (data, string) is a few-letter code for the group-based graph analysis with structural data.
%%%% ¡default!
'AnalyzeGroup_ST_WU ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the group-based graph analysis with structural data.
%%%% ¡default!
'AnalyzeGroup_ST_WU label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the group-based graph analysis with structural data.
%%%% ¡default!
'AnalyzeGroup_ST_WU notes'

%%% ¡prop!
GR (data, item) is the subject group, which also defines the subject class SubjectST.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectST')

%%% ¡prop!
G (result, item) is the graph obtained from this analysis.
%%%% ¡settings!
'GraphWU'
%%%% ¡calculate!
gr = a.get('GR');
data_list = cellfun(@(x) x.get('ST'), gr.get('SUB_DICT').get('IT_LIST'), 'UniformOutput', false);
data = cat(2, data_list{:})'; % correlation is a column based operation

if any(strcmp(a.get('CORRELATION_RULE'), {Correlation.PEARSON_CV, Correlation.SPEARMAN_CV}))
    A = Correlation.getAdjacencyMatrix(data, a.get('CORRELATION_RULE'), a.get('NEGATIVE_WEIGHT_RULE'), gr.get('COVARIATES'));
else
    A = Correlation.getAdjacencyMatrix(data, a.get('CORRELATION_RULE'), a.get('NEGATIVE_WEIGHT_RULE'));
end

g = GraphWU( ...
    'ID', ['Graph ' gr.get('ID')], ...
    'B', A ...
    );

if ~isa(a.getr('TEMPLATE'), 'NoValue') % the analysis has a template
    g.set('TEMPLATE', a.get('TEMPLATE').memorize('G')) % the template is memorized
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

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡probability!
.01
%%%% ¡code!
create_data_ST_XLS() % only creates files if the example folder doesn't already exist

example_ST_WU

%%% ¡test!
%%%% ¡name!
Template for Graphs and Measures
%%%% ¡probability!
.01
%%%% ¡code!
create_data_ST_TXT() % only creates files if the example folder doesn't already exist

ba = ImporterBrainAtlasTXT('FILE', [fileparts(which('SubjectST')) filesep 'Example data ST TXT' filesep 'atlas.txt']).get('BA');
gr1 = ImporterGroupSubjectST_TXT('FILE', [fileparts(which('SubjectST')) filesep 'Example data ST TXT' filesep 'ST_Group_1.txt'], 'BA', ba).get('GR');
gr2 = ImporterGroupSubjectST_TXT('FILE', [fileparts(which('SubjectST')) filesep 'Example data ST TXT' filesep 'ST_Group_2.txt'], 'BA', ba).get('GR');

% check that analysis parameters are correclty templated between analysis 1 and 2
negative_weight_rule = Correlation.ABS;
correlation_rule = Correlation.SPEARMAN;
a_WU1 = AnalyzeGroup_ST_WU('GR', gr1, 'NEGATIVE_WEIGHT_RULE', negative_weight_rule, 'CORRELATION_RULE', correlation_rule);
a_WU2 = AnalyzeGroup_ST_WU('TEMPLATE', a_WU1, 'GR', gr2);
assert(isequal(a_WU2.get('NEGATIVE_WEIGHT_RULE'), negative_weight_rule))
assert(isequal(a_WU2.get('CORRELATION_RULE'), correlation_rule))

% check that graph parameters are correclty templated between analysis 1 and 2
randomize = true;
random_seed = 42;
symmetrize_rule = 'min';
semipositivize_rule = 'absolute';
standardize_rule = 'range';
attemptsperedge = 1000;
numberofweights = 25;
g_WU2 = a_WU2.get('G');
g_WU1 = a_WU1.get('G'); % it has been memorized in the previous line (!) when calculating the templated graph.
g_WU1.set( ...
    'RANDOMIZE', randomize, ...
    'RANDOM_SEED', random_seed, ...
    'SYMMETRIZE_RULE', symmetrize_rule, ...
    'SEMIPOSITIVIZE_RULE', semipositivize_rule, ...
    'STANDARDIZE_RULE', standardize_rule, ...
    'ATTEMPTSPEREDGE', attemptsperedge, ...
    'NUMBEROFWEIGHTS', numberofweights ...
    )
assert(isequal(g_WU2.get('RANDOMIZE'), randomize))
assert(isequal(g_WU2.get('RANDOM_SEED'), random_seed))
assert(isequal(g_WU2.get('SYMMETRIZE_RULE'), symmetrize_rule))
assert(isequal(g_WU2.get('SEMIPOSITIVIZE_RULE'), semipositivize_rule))
assert(isequal(g_WU2.get('STANDARDIZE_RULE'), standardize_rule))
assert(isequal(g_WU2.get('ATTEMPTSPEREDGE'), attemptsperedge))
assert(isequal(g_WU2.get('NUMBEROFWEIGHTS'), numberofweights))

% check that measure parameters are correclty templated between analysis 1 and 2
triangles_rule = 'middleman';
m_triangles_WU1 = g_WU1.get('MEASURE', 'Triangles');
m_triangles_WU1.set('RULE', triangles_rule)
m_triangles_WU2 = g_WU2.get('MEASURE', 'Triangles');
assert(isequal(m_triangles_WU2.get('RULE'), triangles_rule))

% check that analysis parameters are correclty templated to permutation analyses
permutations = 10;
c_WU = CompareGroup('P', permutations, 'A1', a_WU1, 'A2', a_WU2);
a_WU_perms = c_WU.get('PERM', randi(permutations));
a_WU1_perm = a_WU_perms{1};
assert(isequal(a_WU1_perm.get('NEGATIVE_WEIGHT_RULE'), negative_weight_rule))
assert(isequal(a_WU1_perm.get('CORRELATION_RULE'), correlation_rule))
a_WU2_perm = a_WU_perms{2};
assert(isequal(a_WU2_perm.get('NEGATIVE_WEIGHT_RULE'), negative_weight_rule))
assert(isequal(a_WU2_perm.get('CORRELATION_RULE'), correlation_rule))

% check that graph parameters are correclty templated to permutation analyses
g_WU1_perm = a_WU1_perm.get('G');
g_WU2_perm = a_WU2_perm.get('G');
assert(isequal(g_WU1_perm.get('RANDOMIZE'), randomize))
assert(isequal(g_WU1_perm.get('RANDOM_SEED'), random_seed))
assert(isequal(g_WU1_perm.get('SYMMETRIZE_RULE'), symmetrize_rule))
assert(isequal(g_WU1_perm.get('SEMIPOSITIVIZE_RULE'), semipositivize_rule))
assert(isequal(g_WU1_perm.get('STANDARDIZE_RULE'), standardize_rule))
assert(isequal(g_WU1_perm.get('ATTEMPTSPEREDGE'), attemptsperedge))
assert(isequal(g_WU1_perm.get('NUMBEROFWEIGHTS'), numberofweights))
assert(isequal(g_WU2_perm.get('RANDOMIZE'), randomize))
assert(isequal(g_WU2_perm.get('RANDOM_SEED'), random_seed))
assert(isequal(g_WU2_perm.get('SYMMETRIZE_RULE'), symmetrize_rule))
assert(isequal(g_WU2_perm.get('SEMIPOSITIVIZE_RULE'), semipositivize_rule))
assert(isequal(g_WU2_perm.get('STANDARDIZE_RULE'), standardize_rule))
assert(isequal(g_WU2_perm.get('ATTEMPTSPEREDGE'), attemptsperedge))
assert(isequal(g_WU2_perm.get('NUMBEROFWEIGHTS'), numberofweights))

% check that measure parameters are correclty templated to permutation analyses
m_triangles_WU1_perm = g_WU1_perm.get('MEASURE', 'Triangles');
m_triangles_WU1_perm.set('RULE', triangles_rule)
m_triangles_WU2_perm = g_WU2_perm.get('MEASURE', 'Triangles');
assert(isequal(m_triangles_WU2_perm.get('RULE'), triangles_rule))

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

a = AnalyzeGroup_ST_WU('GR', gr, 'CORRELATION_RULE', Correlation.PEARSON);

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

a1 = AnalyzeGroup_ST_WU('GR', gr1, 'CORRELATION_RULE', Correlation.PEARSON);
a2 = AnalyzeGroup_ST_WU('GR', gr2, 'TEMPLATE', a1);

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