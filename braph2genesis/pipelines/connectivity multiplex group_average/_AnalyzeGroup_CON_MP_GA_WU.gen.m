%% ¡header!
AnalyzeGroup_CON_MP_GA_WU < AnalyzeGroup (a, group-based graph analysis with connectivity multiplex data) is a graph analysis using connectivity multiplex data.

%%% ¡description!
This graph analysis uses connectivity multiplex data and analyzes them using weighted undirected graphs,
binary undirected multigraphs with fixed thresholds,
or binary undirected multigraphs with fixed densities.

%%% ¡seealso!
SubjectCON_MP, MultiplexWU

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
AnalyzeGroup_CON_MP_GA_WU.ID
%%%% ¡title!
Analysis ID

%%% ¡prop!
%%%% ¡id!
AnalyzeGroup_CON_MP_GA_WU.LABEL
%%%% ¡title!
Analysis NAME

%%% ¡prop!
%%%% ¡id!
AnalyzeGroup_CON_MP_GA_WU.WAITBAR
%%%% ¡title!
WAITBAR ON/OFF

%%% ¡prop!
%%%% ¡id!
AnalyzeGroup_CON_MP_GA_WU.GR
%%%% ¡title!
SUBJECT GROUP

%%% ¡prop!
%%%% ¡id!
AnalyzeGroup_CON_MP_GA_WU.G
%%%% ¡title!
GRAPH & MEASURES

%%% ¡prop!
%%%% ¡id!
AnalyzeGroup_CON_MP_GA_WU.NOTES
%%%% ¡title!
Analysis NOTES

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the group-based graph analysis with connectivity multiplex data.
%%%% ¡default!
'AnalyzeGroup_CON_MP_GA_WU'

%%% ¡prop!
NAME (constant, string) is the name of the group-based graph analysis with connectivity multiplex data.
%%%% ¡default!
'Multiplex Connectivity Weighted Undirected Group Average Analyze'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the group-based graph analysis with connectivity multiplex data.
%%%% ¡default!
'This graph analysis uses connectivity multiplex data and analyzes them using weighted undirected graphs, binary undirected multigraphs with fixed thresholds, or binary undirected multigraphs with fixed densities.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the group-based graph analysis with connectivity multiplex data.
%%%% ¡settings!
'AnalyzeGroup_CON_MP_GA_WU'

%%% ¡prop!
ID (data, string) is a few-letter code for the group-based graph analysis with connectivity multiplex data.
%%%% ¡default!
'AnalyzeGroup_CON_MP_GA_WU ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the group-based graph analysis with connectivity multiplex data.
%%%% ¡default!
'AnalyzeGroup_CON_MP_GA_WU label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the group-based graph analysis with connectivity multiplex data.
%%%% ¡default!
'AnalyzeGroup_CON_MP_GA_WU notes'

%%% ¡prop!
GR (data, item) is the subject group, which also defines the subject class SubjectCON_MP.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectCON_MP')

%%% ¡prop!
G (result, item) is the average graph (MultiplexWU) obtained from this analysis.
%%%% ¡settings!
'MultiplexWU'
%%%% ¡default!
MultiplexWU()
%%%% ¡calculate!
gr = a.get('GR');
subjects_number = gr.get('SUB_DICT').get('LENGTH');

A_con_mp = cell(1, 2); 
for i = 1:1:subjects_number
    sub = gr.get('SUB_DICT').get('IT', i);
    CON_MP = sub.getr('CON_MP');
    L = sub.get('L');
    
    for j = 1:1:L
        data = CON_MP{j};
        
        if i == 1
            A_con_mp(j) = {data};
        else
            A_con_mp(j) = {A_con_mp{j} + data};
        end
    end
end

L = length(A_con_mp);
g = MultiplexWU( ...
    'ID', ['Graph ' gr.get('ID')], ...
    'B', cellfun(@(a) a / subjects_number, A_con_mp, 'UniformOutput', false), ...
    'LAYERLABELS', cellfun(@(x) ['L' num2str(x)], num2cell([1:1:L]), 'UniformOutput', false) ...
    );

if ~isa(a.getr('TEMPLATE'), 'NoValue') % the analysis has a template
    g.set('TEMPLATE', a.get('TEMPLATE').memorize('G')) % the template is memorized
end

if a.get('GR').get('SUB_DICT').get('LENGTH')
    g.set('NODELABELS', a.get('GR').get('SUB_DICT').get('IT', 1).get('BA').get('BR_DICT').get('KEYS'))
end

value = g;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡probability!
.01
%%%% ¡code!
create_data_CON_MP_XLS() % only creates files if the example folder doesn't already exist
example_CON_MP_GA_WU

%%% ¡test!
%%%% ¡name!
GUI - Analysis
%%%% ¡probability!
.01
%%%% ¡code!
im_ba = ImporterBrainAtlasXLS('FILE', 'aal90_atlas.xlsx');
ba = im_ba.get('BA');

gr = Group('SUB_CLASS', 'SubjectCON_MP', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON_MP'));
for i = 1:1:10
    sub = SubjectCON_MP( ...
        'ID', ['SUB CON_MP ' int2str(i)], ...
        'LABEL', ['Subejct CON_MP ' int2str(i)], ...
        'NOTES', ['Notes on subject CON_MP ' int2str(i)], ...
        'BA', ba, ...
        'L', 3, ...
        'LAYERLABELS', {'L1' 'L2' 'L3'}, ...
        'CON_MP', {rand(ba.get('BR_DICT').get('LENGTH')), rand(ba.get('BR_DICT').get('LENGTH')), rand(ba.get('BR_DICT').get('LENGTH'))} ...
        );
    sub.memorize('VOI_DICT').get('ADD', VOINumeric('ID', 'Age', 'V', 100 * rand()))
    sub.memorize('VOI_DICT').get('ADD', VOICategoric('ID', 'Sex', 'CATEGORIES', {'Female', 'Male'}, 'V', randi(2, 1)))
    gr.get('SUB_DICT').get('ADD', sub)
end

a = AnalyzeGroup_CON_MP_GA_WU('GR', gr);

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
im_ba = ImporterBrainAtlasXLS('FILE', 'aal90_atlas.xlsx');
ba = im_ba.get('BA');

gr1 = Group('SUB_CLASS', 'SubjectCON_MP', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON_MP'));
for i = 1:1:10
    sub = SubjectCON_MP( ...
        'ID', ['SUB CON_MP ' int2str(i)], ...
        'LABEL', ['Subejct CON_MP ' int2str(i)], ...
        'NOTES', ['Notes on subject CON_MP ' int2str(i)], ...
        'BA', ba, ...
        'L', 3, ...
        'LAYERLABELS', {'L1' 'L2' 'L3'}, ...
        'CON_MP', {rand(ba.get('BR_DICT').get('LENGTH')), rand(ba.get('BR_DICT').get('LENGTH')), rand(ba.get('BR_DICT').get('LENGTH'))} ...
        );
    sub.memorize('VOI_DICT').get('ADD', VOINumeric('ID', 'Age', 'V', 100 * rand()))
    sub.memorize('VOI_DICT').get('ADD', VOICategoric('ID', 'Sex', 'CATEGORIES', {'Female', 'Male'}, 'V', randi(2, 1)))
    gr1.get('SUB_DICT').get('ADD', sub)
end

gr2 = Group('SUB_CLASS', 'SubjectCON_MP', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON_MP'));
for i = 1:1:10
    sub = SubjectCON_MP( ...
        'ID', ['SUB CON_MP ' int2str(i)], ...
        'LABEL', ['Subejct CON_MP ' int2str(i)], ...
        'NOTES', ['Notes on subject CON_MP ' int2str(i)], ...
        'BA', ba, ...
        'L', 3, ...
        'LAYERLABELS', {'L1' 'L2' 'L3'}, ...
        'CON_MP', {rand(ba.get('BR_DICT').get('LENGTH')), rand(ba.get('BR_DICT').get('LENGTH')), rand(ba.get('BR_DICT').get('LENGTH'))} ...
        );
    sub.memorize('VOI_DICT').get('ADD', VOINumeric('ID', 'Age', 'V', 100 * rand()))
    sub.memorize('VOI_DICT').get('ADD', VOICategoric('ID', 'Sex', 'CATEGORIES', {'Female', 'Male'}, 'V', randi(2, 1)))
    gr2.get('SUB_DICT').get('ADD', sub)
end

a1 = AnalyzeGroup_CON_MP_GA_WU('GR', gr1);
a2 = AnalyzeGroup_CON_MP_GA_WU('GR', gr2, 'TEMPLATE', a1);

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