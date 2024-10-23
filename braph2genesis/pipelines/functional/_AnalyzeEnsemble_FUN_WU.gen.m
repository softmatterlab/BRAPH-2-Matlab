%% ¡header!
AnalyzeEnsemble_FUN_WU < AnalyzeEnsemble (a, graph analysis with functional data) is an ensemble-based graph analysis using functional data.

%%% ¡description!
This graph analysis (AnalyzeEnsemble_FUN_WU) analyzes functional data 
using weighted undirected graphs.

%%% ¡seealso!
SubjectFUN, GraphWU

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_FUN_WU.ID
%%%% ¡title!
Analysis ID

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_FUN_WU.LABEL
%%%% ¡title!
Analysis NAME

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_FUN_WU.WAITBAR
%%%% ¡title!
WAITBAR ON/OFF

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_FUN_WU.GR
%%%% ¡title!
SUBJECT GROUP

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_FUN_WU.GRAPH_TEMPLATE
%%%% ¡title!
GRAPH & MEASURE PARAMETERS

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_FUN_WU.REPETITION
%%%% ¡title!
REPETITION TIME [s]

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_FUN_WU.F_MIN
%%%% ¡title!
MIN FREQUENCY [Hz]

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_FUN_WU.F_MAX
%%%% ¡title!
MAX FREQUENCY [Hz]

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_FUN_WU.CORRELATION_RULE
%%%% ¡title!
CORRELATION RULE

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_FUN_WU.NEGATIVE_WEIGHT_RULE
%%%% ¡title!
NEGATIVE WEIGHTS RULE

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_FUN_WU.ME_DICT
%%%% ¡title!
Group-averaged MEASURES

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_FUN_WU.G_DICT
%%%% ¡title!
Individual GRAPHS

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_FUN_WU.NOTES
%%%% ¡title!
Analysis NOTES

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the ensemble-based graph analysis with functional data.
%%%% ¡default!
'AnalyzeEnsemble_FUN_WU'

%%% ¡prop!
NAME (constant, string) is the name of the ensemble-based graph analysis with functional data.
%%%% ¡default!
'Functional Weighted Undirected Analyze Ensemble'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the ensemble-based graph analysis with functional data.
%%%% ¡default!
'This graph analysis (AnalyzeEnsemble_FUN_WU) analyzes functional data using weighted undirected graphs.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the ensemble-based graph analysis with functional data.
%%% ¡settings!
'AnalyzeEnsemble_FUN_WU'

%%% ¡prop!
ID (data, string) is a few-letter code for the ensemble-based graph analysis with functional data.
%%%% ¡default!
'AnalyzeEnsemble_FUN_WU ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the ensemble-based graph analysis with functional data.
%%%% ¡default!
'AnalyzeEnsemble_FUN_WU label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the ensemble-based graph analysis with functional data.
%%%% ¡default!
'AnalyzeEnsemble_FUN_WU notes'

%%% ¡prop!
GR (data, item) is the subject group, which also defines the subject class SubjectFUN.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectFUN')

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

T = a.get('REPETITION');
fs = 1 / T;
fmin = a.get('F_MIN');
fmax = a.get('F_MAX');

for i = 1:1:gr.get('SUB_DICT').get('LENGTH')
	sub = gr.get('SUB_DICT').get('IT', i);
    data = sub.getr('FUN');

    if fmax > fmin && T > 0
        NFFT = 2 * ceil(size(data, 1) / 2);
        ft = fft(data, NFFT);  % Fourier transform
        f = fftshift(fs * abs(-NFFT / 2:NFFT / 2 - 1) / NFFT);  % absolute frequency
        ft(f < fmin | f > fmax, :) = 0;
        data = ifft(ft, NFFT);
    end    
    
    A = Correlation.getAdjacencyMatrix(data, a.get('CORRELATION_RULE'), a.get('NEGATIVE_WEIGHT_RULE'));
    
    g = GraphWU( ...
        'ID', ['g ' sub.get('ID')], ...
        'B', A, ... 
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
REPETITION (parameter, scalar) is the number of repetitions.
%%%% ¡default!
1

%%% ¡prop!
F_MIN (parameter, scalar) is the minimum frequency value.
%%%% ¡default!
0

%%% ¡prop!
F_MAX (parameter, scalar) is the maximum frequency value.
%%%% ¡default!
Inf

%%% ¡prop!
CORRELATION_RULE (parameter, option) is the correlation type.
%%%% ¡settings!
Correlation.CORRELATION_RULE_LIST(1:3)
%%%% ¡default!
Correlation.CORRELATION_RULE_LIST{1}

%%% ¡prop!
NEGATIVE_WEIGHT_RULE (parameter, option) determines how to deal with negative weights.
%%%% ¡settings!
Correlation.NEGATIVE_WEIGHT_RULE_LIST
%%%% ¡default!
Correlation.NEGATIVE_WEIGHT_RULE_LIST{1}

%% ¡tests!

%%% ¡excluded_props!
[AnalyzeEnsemble_FUN_WU.TEMPLATE AnalyzeEnsemble_FUN_WU.GRAPH_TEMPLATE]

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡probability!
.01
%%%% ¡code!
create_data_FUN_XLS() % only creates files if the example folder doesn't already exist

example_FUN_WU

%%% ¡test!
%%%% ¡name!
GUI - Analysis
%%%% ¡probability!
.01
%%%% ¡code!
im_ba = ImporterBrainAtlasXLS('FILE', 'aal90_atlas.xlsx');
ba = im_ba.get('BA');

gr = Group('SUB_CLASS', 'SubjectFUN', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectFUN'));
for i = 1:1:50
    sub = SubjectFUN( ...
        'ID', ['SUB FUN ' int2str(i)], ...
        'LABEL', ['Subejct FUN ' int2str(i)], ...
        'NOTES', ['Notes on subject FUN ' int2str(i)], ...
        'BA', ba, ...
        'FUN', rand(10, ba.get('BR_DICT').get('LENGTH')) ...
        );
    sub.memorize('VOI_DICT').get('ADD', VOINumeric('ID', 'Age', 'V', 100 * rand()))
    sub.memorize('VOI_DICT').get('ADD', VOICategoric('ID', 'Sex', 'CATEGORIES', {'Female', 'Male'}, 'V', randi(2, 1)))
    gr.get('SUB_DICT').get('ADD', sub)
end

a = AnalyzeEnsemble_FUN_WU('GR', gr);

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

gr1 = Group('SUB_CLASS', 'SubjectFUN', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectFUN'));
for i = 1:1:50
    sub = SubjectFUN( ...
        'ID', ['SUB FUN ' int2str(i)], ...
        'LABEL', ['Subejct FUN ' int2str(i)], ...
        'NOTES', ['Notes on subject FUN ' int2str(i)], ...
        'BA', ba, ...
        'FUN', rand(10, ba.get('BR_DICT').get('LENGTH')) ...
        );
    sub.memorize('VOI_DICT').get('ADD', VOINumeric('ID', 'Age', 'V', 100 * rand()))
    sub.memorize('VOI_DICT').get('ADD', VOICategoric('ID', 'Sex', 'CATEGORIES', {'Female', 'Male'}, 'V', randi(2, 1)))
    gr1.get('SUB_DICT').get('ADD', sub)
end

gr2 = Group('SUB_CLASS', 'SubjectFUN', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectFUN'));
for i = 1:1:50
    sub = SubjectFUN( ...
        'ID', ['SUB FUN ' int2str(i)], ...
        'LABEL', ['Subejct FUN ' int2str(i)], ...
        'NOTES', ['Notes on subject FUN ' int2str(i)], ...
        'BA', ba, ...
        'FUN', rand(10, ba.get('BR_DICT').get('LENGTH')) ...
        );
    sub.memorize('VOI_DICT').get('ADD', VOINumeric('ID', 'Age', 'V', 100 * rand()))
    sub.memorize('VOI_DICT').get('ADD', VOICategoric('ID', 'Sex', 'CATEGORIES', {'Female', 'Male'}, 'V', randi(2, 1)))
    gr2.get('SUB_DICT').get('ADD', sub)
end

a1 = AnalyzeEnsemble_FUN_WU('GR', gr1);
a2 = AnalyzeEnsemble_FUN_WU('GR', gr2, 'TEMPLATE', a1);

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