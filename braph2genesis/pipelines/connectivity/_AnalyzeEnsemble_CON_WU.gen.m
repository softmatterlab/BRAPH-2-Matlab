%% ¡header!
AnalyzeEnsemble_CON_WU < AnalyzeEnsemble (a, graph analysis with connectivity data) is a ensemble-based graph analysis using connectivity data.

%%% ¡description!
This ensemble-based graph analysis (AnalyzeEnsemble_CON_WU) analyzes connectivity data using weighted undirected graphs.

%%% ¡seealso!
SubjectCON, GraphWU

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_CON_WU.ID
%%%% ¡title!
Analysis ID

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_CON_WU.LABEL
%%%% ¡title!
Analysis NAME

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_CON_WU.WAITBAR
%%%% ¡title!
WAITBAR ON/OFF

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_CON_WU.GR
%%%% ¡title!
SUBJECT GROUP

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_CON_WU.GRAPH_TEMPLATE
%%%% ¡title!
GRAPH & MEASURE PARAMETERS

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_CON_WU.ME_DICT
%%%% ¡title!
Group-averaged MEASURES

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_CON_WU.G_DICT
%%%% ¡title!
Individual GRAPHS

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_CON_WU.NOTES
%%%% ¡title!
Analysis NOTES

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the ensemble-based graph analysis using connectivity data.
%%%% ¡default!
'AnalyzeEnsemble_CON_WU'

%%% ¡prop!
NAME (constant, string) is the name of the ensemble-based graph analysis using connectivity data.
%%%% ¡default!
'Connectivity Weigthed Undirected Analyze Ensemble'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the ensemble-based graph analysis using connectivity data.
%%%% ¡default!
'This ensemble-based graph analysis (AnalyzeEnsemble_CON_WU) analyzes connectivity data using weighted undirected graphs.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the ensemble-based graph analysis using connectivity data.
%%%% ¡settings!
'AnalyzeEnsemble_CON_WU'

%%% ¡prop!
ID (data, string) is a few-letter code for the ensemble-based graph analysis using connectivity data.
%%%% ¡default!
'AnalyzeEnsemble_CON_WU ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the ensemble-based graph analysis using connectivity data.
%%%% ¡default!
'AnalyzeEnsemble_CON_WU label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the ensemble-based graph analysis using connectivity data.
%%%% ¡default!
'AnalyzeEnsemble_CON_WU notes'

%%% ¡prop!
GR (data, item) is the subject group, which also defines the subject class SubjectCON.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectCON')

%%% ¡prop!
GRAPH_TEMPLATE (parameter, item) is the graph template to set all graph and measure parameters.
%%%% ¡settings!
'GraphWU'

%%% ¡prop!
G_DICT (result, idict) is the graph (GraphWU) ensemble obtained from this analysis.
%%%% ¡settings!
'GraphWU'
%%%% ¡calculate!
g_dict = IndexedDictionary('IT_CLASS', 'GraphWU');
gr = a.get('GR');

for i = 1:1:gr.get('SUB_DICT').get('LENGTH')
	sub = gr.get('SUB_DICT').get('IT', i);
    g = GraphWU( ...
        'ID', ['graph ' sub.get('ID')], ...
        'B', sub.getCallback('CON'), ...
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

%% ¡tests!

%%% ¡excluded_props!
[AnalyzeEnsemble_CON_WU.TEMPLATE AnalyzeEnsemble_CON_WU.GRAPH_TEMPLATE]

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡probability!
.01
%%%% ¡code!
create_data_CON_TXT() % only creates files if the example folder doesn't already exist
example_CON_WU

%%% ¡test!
%%%% ¡name!
Template for Graphs and Measures
%%%% ¡probability!
.01
%%%% ¡code!
if ~isfile([fileparts(which('SubjectCON')) filesep 'Example data CON TXT' filesep 'atlas.txt'])
    test_ImporterGroupSubjectCON_TXT % create example files
end

ba = ImporterBrainAtlasTXT('FILE', [fileparts(which('SubjectCON')) filesep 'Example data CON TXT' filesep 'atlas.txt']).get('BA');
gr1 = ImporterGroupSubjectCON_TXT('DIRECTORY', [fileparts(which('SubjectCON')) filesep 'Example data CON TXT' filesep 'CON_Group_1_TXT'], 'BA', ba).get('GR');
gr2 = ImporterGroupSubjectCON_TXT('DIRECTORY', [fileparts(which('SubjectCON')) filesep 'Example data CON TXT' filesep 'CON_Group_2_TXT'], 'BA', ba).get('GR');

% check that analysis parameters are correclty templated between analysis 1 and 2
a_WU1 = AnalyzeEnsemble_CON_WU('GR', gr1);
a_WU2 = AnalyzeEnsemble_CON_WU('TEMPLATE', a_WU1, 'GR', gr2); % also memorizes the graph in a_WU1 (!)

% check that graph parameters are correclty templated between analysis 1 and 2
randomize = true;
random_seed = 42;
symmetrize_rule = 'min';
semipositivize_rule = 'absolute';
standardize_rule = 'range';
attemptsperedge = 1000;
numberofweights = 25;
g_template_WU1 = a_WU1.get('GRAPH_TEMPLATE'); 
g_template_WU1.set( ...
    'RANDOMIZE', randomize, ...
    'RANDOM_SEED', random_seed, ...
    'SYMMETRIZE_RULE', symmetrize_rule, ...
    'SEMIPOSITIVIZE_RULE', semipositivize_rule, ...
    'STANDARDIZE_RULE', standardize_rule, ...
    'ATTEMPTSPEREDGE', attemptsperedge, ...
    'NUMBEROFWEIGHTS', numberofweights ...
    )
g_template_WU2 = a_WU2.get('GRAPH_TEMPLATE'); 
assert(isequal(g_template_WU2.get('RANDOMIZE'), randomize))
assert(isequal(g_template_WU2.get('RANDOM_SEED'), random_seed))
assert(isequal(g_template_WU2.get('SYMMETRIZE_RULE'), symmetrize_rule))
assert(isequal(g_template_WU2.get('SEMIPOSITIVIZE_RULE'), semipositivize_rule))
assert(isequal(g_template_WU2.get('STANDARDIZE_RULE'), standardize_rule))
assert(isequal(g_template_WU2.get('ATTEMPTSPEREDGE'), attemptsperedge))
assert(isequal(g_template_WU2.get('NUMBEROFWEIGHTS'), numberofweights))

% check that measure parameters are correclty templated between analysis 1 and 2
triangles_rule = 'middleman';
m_triangles_WU1 = g_template_WU1.get('MEASURE', 'Triangles');
m_triangles_WU1.set('RULE', triangles_rule)
m_triangles_WU2 = g_template_WU2.get('MEASURE', 'Triangles');
assert(isequal(m_triangles_WU2.get('RULE'), triangles_rule))

% check that graph and measure parameters are correctly propagated to graph and measure dictionaries
me_triangles_WU1 = a_WU1.get('MEASUREENSEMBLE', 'Triangles'); % calculates G_DICT and Triangles for each graph
me_triangles_WU2 = a_WU2.get('MEASUREENSEMBLE', 'Triangles'); % calculates G_DICT and Triangles for each graph

i = randi(a_WU1.get('G_DICT').get('LENGTH'));

g_WU1_i = a_WU1.get('G_DICT').get('IT', i);
assert(isequal(g_WU1_i.get('RANDOMIZE'), randomize))
assert(isequal(g_WU1_i.get('RANDOM_SEED'), random_seed))
assert(isequal(g_WU1_i.get('SYMMETRIZE_RULE'), symmetrize_rule))
assert(isequal(g_WU1_i.get('SEMIPOSITIVIZE_RULE'), semipositivize_rule))
assert(isequal(g_WU1_i.get('STANDARDIZE_RULE'), standardize_rule))
assert(isequal(g_WU1_i.get('ATTEMPTSPEREDGE'), attemptsperedge))
assert(isequal(g_WU1_i.get('NUMBEROFWEIGHTS'), numberofweights))

assert(isequal(g_WU1_i.get('MEASURE', 'Triangles').get('RULE'), triangles_rule))

g_WU2_i = a_WU2.get('G_DICT').get('IT', i);
assert(isequal(g_WU2_i.get('RANDOMIZE'), randomize))
assert(isequal(g_WU2_i.get('RANDOM_SEED'), random_seed))
assert(isequal(g_WU2_i.get('SYMMETRIZE_RULE'), symmetrize_rule))
assert(isequal(g_WU2_i.get('SEMIPOSITIVIZE_RULE'), semipositivize_rule))
assert(isequal(g_WU2_i.get('STANDARDIZE_RULE'), standardize_rule))
assert(isequal(g_WU2_i.get('ATTEMPTSPEREDGE'), attemptsperedge))
assert(isequal(g_WU2_i.get('NUMBEROFWEIGHTS'), numberofweights))

assert(isequal(g_WU2_i.get('MEASURE', 'Triangles').get('RULE'), triangles_rule))

% check that analysis parameters are correclty templated to permutation analyses
permutations = 10;
c_WU = CompareEnsemble('P', permutations, 'A1', a_WU1, 'A2', a_WU2);
a_WU_perms = c_WU.get('PERM', randi(permutations));
a_WU1_perm = a_WU_perms{1};
a_WU2_perm = a_WU_perms{2};

% check that graph parameters are correclty templated to permutation analyses
g_template_WU1_perm = a_WU1_perm.get('GRAPH_TEMPLATE');
g_template_WU2_perm = a_WU2_perm.get('GRAPH_TEMPLATE');
assert(isequal(g_template_WU1_perm.get('RANDOMIZE'), randomize))
assert(isequal(g_template_WU1_perm.get('RANDOM_SEED'), random_seed))
assert(isequal(g_template_WU1_perm.get('SYMMETRIZE_RULE'), symmetrize_rule))
assert(isequal(g_template_WU1_perm.get('SEMIPOSITIVIZE_RULE'), semipositivize_rule))
assert(isequal(g_template_WU1_perm.get('STANDARDIZE_RULE'), standardize_rule))
assert(isequal(g_template_WU1_perm.get('ATTEMPTSPEREDGE'), attemptsperedge))
assert(isequal(g_template_WU1_perm.get('NUMBEROFWEIGHTS'), numberofweights))
assert(isequal(g_template_WU2_perm.get('RANDOMIZE'), randomize))
assert(isequal(g_template_WU2_perm.get('RANDOM_SEED'), random_seed))
assert(isequal(g_template_WU2_perm.get('SYMMETRIZE_RULE'), symmetrize_rule))
assert(isequal(g_template_WU2_perm.get('SEMIPOSITIVIZE_RULE'), semipositivize_rule))
assert(isequal(g_template_WU2_perm.get('STANDARDIZE_RULE'), standardize_rule))
assert(isequal(g_template_WU2_perm.get('ATTEMPTSPEREDGE'), attemptsperedge))
assert(isequal(g_template_WU2_perm.get('NUMBEROFWEIGHTS'), numberofweights))

g_WU1_perm_i = a_WU1_perm.get('G_DICT').get('IT', i);
g_WU2_perm_i = a_WU2_perm.get('G_DICT').get('IT', i);
assert(isequal(g_WU1_perm_i.get('RANDOMIZE'), randomize))
assert(isequal(g_WU1_perm_i.get('RANDOM_SEED'), random_seed))
assert(isequal(g_WU1_perm_i.get('SYMMETRIZE_RULE'), symmetrize_rule))
assert(isequal(g_WU1_perm_i.get('SEMIPOSITIVIZE_RULE'), semipositivize_rule))
assert(isequal(g_WU1_perm_i.get('STANDARDIZE_RULE'), standardize_rule))
assert(isequal(g_WU1_perm_i.get('ATTEMPTSPEREDGE'), attemptsperedge))
assert(isequal(g_WU1_perm_i.get('NUMBEROFWEIGHTS'), numberofweights))
assert(isequal(g_WU2_perm_i.get('RANDOMIZE'), randomize))
assert(isequal(g_WU2_perm_i.get('RANDOM_SEED'), random_seed))
assert(isequal(g_WU2_perm_i.get('SYMMETRIZE_RULE'), symmetrize_rule))
assert(isequal(g_WU2_perm_i.get('SEMIPOSITIVIZE_RULE'), semipositivize_rule))
assert(isequal(g_WU2_perm_i.get('STANDARDIZE_RULE'), standardize_rule))
assert(isequal(g_WU2_perm_i.get('ATTEMPTSPEREDGE'), attemptsperedge))
assert(isequal(g_WU2_perm_i.get('NUMBEROFWEIGHTS'), numberofweights))
 
% check that measure parameters are correclty templated to permutation analyses
assert(isequal(g_WU1_perm_i.get('MEASURE', 'Triangles').get('RULE'), triangles_rule))
assert(isequal(g_WU2_perm_i.get('MEASURE', 'Triangles').get('RULE'), triangles_rule))

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

a = AnalyzeEnsemble_CON_WU('GR', gr);

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

a1 = AnalyzeEnsemble_CON_WU('GR', gr1);
a2 = AnalyzeEnsemble_CON_WU('GR', gr2, 'TEMPLATE', a1);

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