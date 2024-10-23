%% ¡header!
AnalyzeGroup_CON_FUN_MP_GA_WU < AnalyzeGroup(a, graph analysis with connectivity and functional multiplex data) is a graph analysis using connectivity and functional multiplex data.

%%% ¡description!
This graph analysis uses connectivity and functional multiplex data and analyzes 
them using weighted undirected graphs,
binary undirected multigraphs with fixed thresholds,
or binary undirected multigraphs with fixed densities.

%%% ¡seealso!
SubjectCON_FUN_MP, MultiplexWU

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
AnalyzeGroup_CON_FUN_MP_GA_WU.ID
%%%% ¡title!
Analysis ID

%%% ¡prop!
%%%% ¡id!
AnalyzeGroup_CON_FUN_MP_GA_WU.LABEL
%%%% ¡title!
Analysis NAME

%%% ¡prop!
%%%% ¡id!
AnalyzeGroup_CON_FUN_MP_GA_WU.WAITBAR
%%%% ¡title!
WAITBAR ON/OFF

%%% ¡prop!
%%%% ¡id!
AnalyzeGroup_CON_FUN_MP_GA_WU.GR
%%%% ¡title!
SUBJECT GROUP

%%% ¡prop!
%%%% ¡id!
AnalyzeGroup_CON_FUN_MP_GA_WU.REPETITION
%%%% ¡title!
REPETITION TIME [s]

%%% ¡prop!
%%%% ¡id!
AnalyzeGroup_CON_FUN_MP_GA_WU.F_MIN
%%%% ¡title!
MIN FREQUENCY [Hz]

%%% ¡prop!
%%%% ¡id!
AnalyzeGroup_CON_FUN_MP_GA_WU.F_MAX
%%%% ¡title!
MAX FREQUENCY [Hz]

%%% ¡prop!
%%%% ¡id!
AnalyzeGroup_CON_FUN_MP_GA_WU.CORRELATION_RULE
%%%% ¡title!
CORRELATION RULE

%%% ¡prop!
%%%% ¡id!
AnalyzeGroup_CON_FUN_MP_GA_WU.NEGATIVE_WEIGHT_RULE
%%%% ¡title!
NEGATIVE WEIGHTS RULE

%%% ¡prop!
%%%% ¡id!
AnalyzeGroup_CON_FUN_MP_GA_WU.G
%%%% ¡title!
GRAPH & MEASURES

%%% ¡prop!
%%%% ¡id!
AnalyzeGroup_CON_FUN_MP_GA_WU.NOTES
%%%% ¡title!
Analysis NOTES

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the graph analysis with connectivity and functional multiplex data.
%%%% ¡default!
'AnalyzeGroup_CON_FUN_MP_GA_WU'

%%% ¡prop!
NAME (constant, string) is the name of the graph analysis with connectivity and functional multiplex data.
%%%% ¡default!
'Multiplex Connectivity-Functional Weighted Undirected Group Average Analyze'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the graph analysis with connectivity and functional multiplex data.
%%%% ¡default!
'This graph analysis uses connectivity and functional multiplex data and analyzes them using weighted undirected graphs, binary undirected multigraphs with fixed thresholds, or binary undirected multigraphs with fixed densities.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the graph analysis with connectivity and functional multiplex data.
%%%% ¡settings!
'AnalyzeGroup_CON_FUN_MP_GA_WU'

%%% ¡prop!
ID (data, string) is a few-letter code for the graph analysis with connectivity and functional multiplex data.
%%%% ¡default!
'AnalyzeGroup_CON_FUN_MP_GA_WU ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the graph analysis with connectivity and functional multiplex data.
%%%% ¡default!
'AnalyzeGroup_CON_FUN_MP_GA_WU label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the graph analysis with connectivity and functional multiplex data.
%%%% ¡default!
'AnalyzeGroup_CON_FUN_MP_GA_WU notes'

%%% ¡prop!
GR (data, item) is the subject group, which also defines the subject class SubjectCON_FUN_MP.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectCON_FUN_MP')

%%% ¡prop!
G (result, item) is the average multiplex graph obtained from this analysis.
%%%% ¡settings!
'MultiplexWU'
%%%% ¡default!
MultiplexWU()
%%%% ¡calculate!
gr = a.get('GR');
T = a.get('REPETITION');
fmin = a.get('F_MIN');
fmax = a.get('F_MAX');
A = cell(1, 2);
data = cell(1, 2);

for i = 1:1:gr.get('SUB_DICT').get('LENGTH')
    sub = gr.get('SUB_DICT').get('IT', i);
    
    % FUN data
    data_fun = sub.get('FUN');
    fs = 1 / T;
    
    if fmax > fmin && T > 0
        NFFT = 2 * ceil(size(data_fun, 1) / 2);
        ft = fft(data_fun, NFFT);  % Fourier transform
        f = fftshift(fs * abs(-NFFT / 2:NFFT / 2 - 1) / NFFT);  % absolute frequency
        ft(f < fmin | f > fmax, :) = 0;
        data_fun = ifft(ft, NFFT);
    end
    
    A_fun = Correlation.getAdjacencyMatrix(data_fun, a.get('CORRELATION_RULE'), a.get('NEGATIVE_WEIGHT_RULE'));
    
    % CON data
    if i == 1
        data{1} = sub.get('CON');
        data{2} = A_fun;
    else
        data{1} = data{1} + sub.get('CON');
        data{2} = data{2} + A_fun;
    end
    
end

A{1} = data{1} / gr.get('SUB_DICT').get('LENGTH');
A{2} = data{2} / gr.get('SUB_DICT').get('LENGTH');

g = MultiplexWU( ...
    'ID', ['Graph ' gr.get('ID')], ...
    'B', A, ...
    'LAYERLABELS', {'CON', 'FUN'} ...
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
REPETITION (parameter, scalar) is the number of repetitions for functional data
%%%% ¡default!
1

%%% ¡prop!
F_MIN (parameter, scalar) is the minimum frequency value for functional data
%%%% ¡default!
0

%%% ¡prop!
F_MAX (parameter, scalar) is the maximum frequency value for functional data
%%%% ¡default!
Inf

%%% ¡prop!
CORRELATION_RULE (parameter, option) is the correlation type for functional data.
%%%% ¡settings!
Correlation.CORRELATION_RULE_LIST(1:3)
%%%% ¡default!
Correlation.CORRELATION_RULE_LIST{1}

%%% ¡prop!
NEGATIVE_WEIGHT_RULE (parameter, option) determines how to deal with negative weights of functional data.
%%%% ¡settings!
Correlation.NEGATIVE_WEIGHT_RULE_LIST
%%%% ¡default!
Correlation.NEGATIVE_WEIGHT_RULE_LIST{1}

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡probability!
.01
%%%% ¡code!
create_data_CON_FUN_MP_XLS()  % only creates files if the example folder doesn't already exist 
example_CON_FUN_MP_GA_WU

%%% ¡test!
%%%% ¡name!
GUI - Analysis
%%%% ¡probability!
.01
%%%% ¡code!
im_ba = ImporterBrainAtlasXLS('FILE', 'desikan_atlas.xlsx');
ba = im_ba.get('BA');

gr= Group('SUB_CLASS', 'SubjectCON_FUN_MP', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON_FUN_MP'));
for i = 1:1:50
    sub = SubjectCON_FUN_MP( ...
        'ID', ['SUB CON ' int2str(i)], ...
        'LABEL', ['Subejct CON ' int2str(i)], ...
        'NOTES', ['Notes on subject CON ' int2str(i)], ...
        'BA', ba, ...
        'CON', rand(ba.get('BR_DICT').get('LENGTH')), ...
        'FUN', rand(10, ba.get('BR_DICT').get('LENGTH')) ...
        );
    sub.memorize('VOI_DICT').get('ADD', VOINumeric('ID', 'Age', 'V', 100 * rand()))
    sub.memorize('VOI_DICT').get('ADD', VOICategoric('ID', 'Sex', 'CATEGORIES', {'Female', 'Male'}, 'V', randi(2, 1)))
    gr.get('SUB_DICT').get('ADD', sub)
end

a = AnalyzeGroup_CON_FUN_MP_GA_WU('GR', gr);

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

gr1 = Group('SUB_CLASS', 'SubjectCON_FUN_MP', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON_FUN_MP'));
for i = 1:1:50
    sub = SubjectCON_FUN_MP( ...
        'ID', ['SUB CON ' int2str(i)], ...
        'LABEL', ['Subejct CON ' int2str(i)], ...
        'NOTES', ['Notes on subject CON ' int2str(i)], ...
        'BA', ba, ...
        'CON', rand(ba.get('BR_DICT').get('LENGTH')), ...
        'FUN', rand(10, ba.get('BR_DICT').get('LENGTH')) ...
        );
    sub.memorize('VOI_DICT').get('ADD', VOINumeric('ID', 'Age', 'V', 100 * rand()))
    sub.memorize('VOI_DICT').get('ADD', VOICategoric('ID', 'Sex', 'CATEGORIES', {'Female', 'Male'}, 'V', randi(2, 1)))
    gr1.get('SUB_DICT').get('ADD', sub)
end

gr2 = Group('SUB_CLASS', 'SubjectCON_FUN_MP', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON_FUN_MP'));
for i = 1:1:50
    sub = SubjectCON_FUN_MP( ...
        'ID', ['SUB CON ' int2str(i)], ...
        'LABEL', ['Subejct CON ' int2str(i)], ...
        'NOTES', ['Notes on subject CON ' int2str(i)], ...
        'BA', ba, ...
        'CON', rand(ba.get('BR_DICT').get('LENGTH')), ...
        'FUN', rand(10, ba.get('BR_DICT').get('LENGTH')) ...
        );
    sub.memorize('VOI_DICT').get('ADD', VOINumeric('ID', 'Age', 'V', 100 * rand()))
    sub.memorize('VOI_DICT').get('ADD', VOICategoric('ID', 'Sex', 'CATEGORIES', {'Female', 'Male'}, 'V', randi(2, 1)))
    gr2.get('SUB_DICT').get('ADD', sub)
end

a1 = AnalyzeGroup_CON_FUN_MP_GA_WU('GR', gr1);
a2 = AnalyzeGroup_CON_FUN_MP_GA_WU('GR', gr2, 'TEMPLATE', a1);

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