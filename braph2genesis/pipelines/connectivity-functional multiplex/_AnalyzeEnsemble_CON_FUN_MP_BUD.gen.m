%% ¡header!
AnalyzeEnsemble_CON_FUN_MP_BUD < AnalyzeEnsemble (a, graph analysis with connectivity and functional multiplex data of fixed density) is an ensemble-based graph analysis using connectivity and functional multiplex data of fixed density.

%%% ¡description!
This graph analysis (AnalyzeEnsemble_CON_FUN_MP_BUD) analyzes connectivity 
and functional multiplex data using binary undirected graphs at fixed densities.

%%% ¡seealso!
SubjectCON_FUN_MP, MultiplexBUD

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_CON_FUN_MP_BUD.ID
%%%% ¡title!
Analysis ID

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_CON_FUN_MP_BUD.LABEL
%%%% ¡title!
Analysis NAME

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_CON_FUN_MP_BUD.WAITBAR
%%%% ¡title!
WAITBAR ON/OFF

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_CON_FUN_MP_BUD.GR
%%%% ¡title!
SUBJECT GROUP

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_CON_FUN_MP_BUD.GRAPH_TEMPLATE
%%%% ¡title!
GRAPH & MEASURE PARAMETERS

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_CON_FUN_MP_BUD.DENSITIES
%%%% ¡title!
DENSITIES [0% ... 100%]

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_CON_FUN_MP_BUD.REPETITION
%%%% ¡title!
REPETITION TIME [s]

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_CON_FUN_MP_BUD.F_MIN
%%%% ¡title!
MIN FREQUENCY [Hz]

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_CON_FUN_MP_BUD.F_MAX
%%%% ¡title!
MAX FREQUENCY [Hz]

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_CON_FUN_MP_BUD.CORRELATION_RULE
%%%% ¡title!
CORRELATION RULE

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_CON_FUN_MP_BUD.NEGATIVE_WEIGHT_RULE
%%%% ¡title!
NEGATIVE WEIGHTS RULE

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_CON_FUN_MP_BUD.ME_DICT
%%%% ¡title!
Group-averaged MEASURES

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_CON_FUN_MP_BUD.G_DICT
%%%% ¡title!
Individual GRAPHS

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_CON_FUN_MP_BUD.NOTES
%%%% ¡title!
Analysis NOTES

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the ensemble-based graph analysis with connectivity and functional multiplex data of fixed density.
%%%% ¡default!
'AnalyzeEnsemble_CON_FUN_MP_BUD'

%%% ¡prop!
NAME (constant, string) is the name of the ensemble-based graph analysis with connectivity and functional multiplex data of fixed density.
%%%% ¡default!
'Multiplex Connectivity-Functional Binary at fixed Densities Analyze Ensemble'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the ensemble-based graph analysis with connectivity and functional multiplex data of fixed density.
%%%% ¡default!
'This graph analysis (AnalyzeEnsemble_CON_FUN_MP_BUD) analyzes connectivity and functional multiplex data using binary undirected graphs at fixed densities.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the ensemble-based graph analysis with connectivity and functional multiplex data of fixed density.
%%%% ¡settings!
'AnalyzeEnsemble_CON_FUN_MP_BUD'

%%% ¡prop!
ID (data, string) is a few-letter code for the ensemble-based graph analysis with connectivity and functional multiplex data of fixed density.
%%%% ¡default!
'AnalyzeEnsemble_CON_FUN_MP_BUD ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the ensemble-based graph analysis with connectivity and functional multiplex data of fixed density.
%%%% ¡default!
'AnalyzeEnsemble_CON_FUN_MP_BUD label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the ensemble-based graph analysis with connectivity and functional multiplex data of fixed density.
%%%% ¡default!
'AnalyzeEnsemble_CON_FUN_MP_BUD notes'

%%% ¡prop!
GR (data, item) is the subject group, which also defines the subject class SubjectCON_FUN_MP.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectCON_FUN_MP')

%%% ¡prop!
GRAPH_TEMPLATE (parameter, item) is the graph template to set all graph and measure parameters.
%%%% ¡settings!
'MultiplexBUD'

%%% ¡prop!
G_DICT (result, idict) is the multiplex (MultiplexBUD) ensemble obtained from this analysis.
%%%% ¡settings!
'MultiplexBUD'
%%%% ¡calculate!
g_dict = IndexedDictionary('IT_CLASS', 'MultiplexBUD');
gr = a.get('GR');
node_labels = '';

T = a.get('REPETITION');
fs = 1 / T;
fmin = a.get('F_MIN');
fmax = a.get('F_MAX');

densities = a.get('DENSITIES'); % this is a vector

for i = 1:1:gr.get('SUB_DICT').get('LENGTH')
	sub = gr.get('SUB_DICT').get('IT', i);
    
    A = cell(1, 2);

    % CON data
    A{1} = sub.get('CON');
    
    % FUN data
    data = sub.get('FUN');
    
    if fmax > fmin && T > 0
        NFFT = 2 * ceil(size(data, 1) / 2);
        ft = fft(data, NFFT);  % Fourier transform
        f = fftshift(fs * abs(-NFFT / 2:NFFT / 2 - 1) / NFFT);  % absolute frequency
        ft(f < fmin | f > fmax, :) = 0;
        data = ifft(ft, NFFT);
    end
    
    A{2} = Correlation.getAdjacencyMatrix(data, a.get('CORRELATION_RULE'), a.get('NEGATIVE_WEIGHT_RULE'));
    
    g = MultiplexBUD( ...
        'ID', ['g ' sub.get('ID')], ...
        'B', A, ...
        'DENSITIES', densities, ...
        'LAYERLABELS', {'CON', 'FUN'}, ...
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
REPETITION (parameter, scalar) is the number of repetitions for functional data.
%%%% ¡default!
1

%%% ¡prop!
F_MIN (parameter, scalar) is the minimum frequency value for functional data.
%%%% ¡default!
0

%%% ¡prop!
F_MAX (parameter, scalar) is the maximum frequency value for functional data.
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

%%% ¡prop!
DENSITIES (parameter, rvector) is the vector of densities.
%%%% ¡default!
[1:1:10]
%%%% ¡gui!
pr = PanelPropRVectorSmart('EL', a, 'PROP', AnalyzeEnsemble_CON_FUN_MP_BUD.DENSITIES, ...
    'MIN', 0, 'MAX', 100, ...
    'DEFAULT', AnalyzeEnsemble_CON_FUN_MP_BUD.getPropDefault('DENSITIES'), ...
    varargin{:});
%%%% ¡postset!
a.memorize('GRAPH_TEMPLATE').set('DENSITIES', a.getCallback('DENSITIES'));

%% ¡tests!

%%% ¡excluded_props!
[AnalyzeEnsemble_CON_BUT.TEMPLATE AnalyzeEnsemble_CON_BUT.GRAPH_TEMPLATE]

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡probability!
.01
%%%% ¡code!
create_data_CON_FUN_MP_XLS()
example_CON_FUN_MP_BUD

%%% ¡test!
%%%% ¡name!
GUI - Analysis
%%%% ¡probability!
.01
%%%% ¡code!
im_ba = ImporterBrainAtlasXLS('FILE', 'desikan_atlas.xlsx');
ba = im_ba.get('BA');

gr = Group('SUB_CLASS', 'SubjectCON_FUN_MP', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON_FUN_MP'));
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

a = AnalyzeEnsemble_CON_FUN_MP_BUD('GR', gr, 'DENSITIES', 5:5:20);

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

a1 = AnalyzeEnsemble_CON_FUN_MP_BUD('GR', gr1, 'DENSITIES', 5:5:20);
a2 = AnalyzeEnsemble_CON_FUN_MP_BUD('GR', gr2, 'TEMPLATE', a1);

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