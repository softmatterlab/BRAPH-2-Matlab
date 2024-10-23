%% ¡header!
AnalyzeGroup_ST_MP_BUT < AnalyzeGroup (a, graph analysis with structural multiplex data of fixed threshold) is a graph analysis using structural multiplex data of fixed threshold.

%%% ¡description!
This graph analysis uses structural multiplex data of fixed threshold and 
analyzes them using binary undirected graphs.

%%% ¡seealso!
SubjectST_MP, MultiplexBUT

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
AnalyzeGroup_ST_MP_BUT.ID
%%%% ¡title!
Analysis ID

%%% ¡prop!
%%%% ¡id!
AnalyzeGroup_ST_MP_BUT.LABEL
%%%% ¡title!
Analysis NAME

%%% ¡prop!
%%%% ¡id!
AnalyzeGroup_ST_MP_BUT.WAITBAR
%%%% ¡title!
WAITBAR ON/OFF

%%% ¡prop!
%%%% ¡id!
AnalyzeGroup_ST_MP_BUT.GR
%%%% ¡title!
SUBJECT GROUP

%%% ¡prop!
%%%% ¡id!
AnalyzeGroup_ST_MP_BUT.CORRELATION_RULE
%%%% ¡title!
CORRELATION RULE

%%% ¡prop!
%%%% ¡id!
AnalyzeGroup_ST_MP_BUT.NEGATIVE_WEIGHT_RULE
%%%% ¡title!
NEGATIVE WEIGHTS RULE

%%% ¡prop!
%%%% ¡id!
AnalyzeGroup_ST_MP_BUT.THRESHOLDS
%%%% ¡title!
THRESHOLDS [-1 ... 1]

%%% ¡prop!
%%%% ¡id!
AnalyzeGroup_ST_MP_BUT.G
%%%% ¡title!
GRAPH & MEASURES

%%% ¡prop!
%%%% ¡id!
AnalyzeGroup_ST_MP_BUT.NOTES
%%%% ¡title!
Analysis NOTES

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the graph analysis with structural multiplex data of fixed threshold.
%%%% ¡default!
'AnalyzeGroup_ST_MP_BUT'

%%% ¡prop!
NAME (constant, string) is the name of the graph analysis with structural multiplex data of fixed threshold.
%%%% ¡default!
'Multiplex Structural Binary Undirected at fixed Thresholds Analyze Group'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the graph analysis with structural multiplex data of fixed threshold.
%%%% ¡default!
'This graph analysis uses structural multiplex data of fixed threshold and analyzes them using binary undirected graphs.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the graph analysis with structural multiplex data of fixed threshold.
%%%% ¡settings!
'AnalyzeGroup_ST_MP_BUT'

%%% ¡prop!
ID (data, string) is a few-letter code for the graph analysis with structural multiplex data of fixed threshold.
%%%% ¡default!
'AnalyzeGroup_ST_MP_BUT ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the graph analysis with structural multiplex data of fixed threshold.
%%%% ¡default!
'AnalyzeGroup_ST_MP_BUT label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the graph analysis with structural multiplex data of fixed threshold.
%%%% ¡default!
'AnalyzeGroup_ST_MP_BUT notes'

%%% ¡prop!
GR (data, item) is the subject group, which also defines the subject class SubjectST_MP.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectST_MP')

%%% ¡prop!
G (result, item) is the graph obtained from this analysis.
%%%% ¡settings!
'MultiplexBUT'
%%%% ¡default!
MultiplexBUT()
%%%% ¡calculate!
gr = a.get('GR');
data_list = cellfun(@(x) x.get('ST_MP'), gr.get('SUB_DICT').get('IT_LIST'), 'UniformOutput', false);

if isempty(data_list)
    A ={[], []};
    L = 2;
else
    L = gr.get('SUB_DICT').get('IT', 1).get('L');  % number of layers
    br_number = gr.get('SUB_DICT').get('IT', 1).get('BA').get('BR_DICT').get('LENGTH');  % number of regions
    data = cell(L, 1);
    for i = 1:1:L
        data_layer = zeros(length(data_list), br_number);
        for j=1:length(data_list)
            sub_cell = data_list{j};
            data_layer(j, :) = sub_cell{i}';
        end
        data(i) = {data_layer};
    end
    
    layerlabels = {};
    A = cell(1, L);
    thresholds = a.get('THRESHOLDS'); 
    for i = 1:1:length(thresholds)
        layerlabels = [layerlabels, cellfun(@(x) ['L' num2str(x) ' ' num2str(thresholds(i))], num2cell(1:L), 'UniformOutput', false)];
    end
    
    for i = 1:1:L
        if any(strcmp(a.get('CORRELATION_RULE'), {Correlation.PEARSON_CV, Correlation.SPEARMAN_CV}))
            A(i) = {Correlation.getAdjacencyMatrix(data{i}, a.get('CORRELATION_RULE'), a.get('NEGATIVE_WEIGHT_RULE'), gr.get('COVARIATES'))};
        else
            A(i) = {Correlation.getAdjacencyMatrix(data{i}, a.get('CORRELATION_RULE'), a.get('NEGATIVE_WEIGHT_RULE'))};
        end
    end
end
thresholds = a.get('THRESHOLDS'); % this is a vector

g = MultiplexBUT( ...
    'ID', ['Graph ' gr.get('ID')], ...
    'B', A, ...
    'THRESHOLDS', thresholds, ...
    'LAYERLABELS', cellfun(@(x) ['L' num2str(x)], num2cell([1:1:L]), 'UniformOutput', false) ...
    );

if ~isa(a.getr('TEMPLATE'), 'NoValue') % the analysis has a template
    g.set('TEMPLATE', a.get('TEMPLATE').memorize('G')) % the template is memorized - overwrite thresholds
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
THRESHOLDS (parameter, rvector) is the vector of thresholds.
%%%% ¡default!
[-1:.5:1]
%%%% ¡gui!
pr = PanelPropRVectorSmart('EL', a, 'PROP', AnalyzeGroup_ST_BUD.DENSITIES, ...
    'MIN', -1, 'MAX', 1, ...
    'DEFAULT', AnalyzeGroup_ST_BUT.getPropDefault('THRESHOLDS'), ...
    varargin{:});

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡probability!
.01
%%%% ¡code!
create_data_ST_MP_XLS() % only creates files if the example folder doesn't already exist
example_ST_MP_BUT

%%% ¡test!
%%%% ¡name!
GUI - Analysis
%%%% ¡probability!
.01
%%%% ¡code!
im_ba = ImporterBrainAtlasXLS('FILE', 'destrieux_atlas.xlsx');
ba = im_ba.get('BA');

gr = Group('SUB_CLASS', 'SubjectST_MP', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectST_MP'));
for i = 1:1:10
    sub = SubjectST_MP( ...
        'ID', ['SUB ST_MP ' int2str(i)], ...
        'LABEL', ['Subejct ST_MP ' int2str(i)], ...
        'NOTES', ['Notes on subject ST_MP ' int2str(i)], ...
        'BA', ba, ...
        'L', 3, ...
        'LAYERLABELS', {'L1' 'L2' 'L3'}, ...
        'ST_MP', {rand(ba.get('BR_DICT').get('LENGTH'), 1), rand(ba.get('BR_DICT').get('LENGTH'), 1), rand(ba.get('BR_DICT').get('LENGTH'), 1)} ...
        );
    sub.memorize('VOI_DICT').get('ADD', VOINumeric('ID', 'Age', 'V', 100 * rand()))
    sub.memorize('VOI_DICT').get('ADD', VOICategoric('ID', 'Sex', 'CATEGORIES', {'Female', 'Male'}, 'V', randi(2, 1)))
    gr.get('SUB_DICT').get('ADD', sub)
end

a = AnalyzeGroup_ST_MP_BUT('GR', gr, 'THRESHOLDS', .7:.1:.9);

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

gr1 = Group('SUB_CLASS', 'SubjectST_MP', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectST_MP'));
for i = 1:1:10
    sub = SubjectST_MP( ...
        'ID', ['SUB ST_MP ' int2str(i)], ...
        'LABEL', ['Subejct ST_MP ' int2str(i)], ...
        'NOTES', ['Notes on subject ST_MP ' int2str(i)], ...
        'BA', ba, ...
        'L', 3, ...
        'LAYERLABELS', {'L1' 'L2' 'L3'}, ...
        'ST_MP', {rand(ba.get('BR_DICT').get('LENGTH'), 1), rand(ba.get('BR_DICT').get('LENGTH'), 1), rand(ba.get('BR_DICT').get('LENGTH'), 1)} ...
        );
    sub.memorize('VOI_DICT').get('ADD', VOINumeric('ID', 'Age', 'V', 100 * rand()))
    sub.memorize('VOI_DICT').get('ADD', VOICategoric('ID', 'Sex', 'CATEGORIES', {'Female', 'Male'}, 'V', randi(2, 1)))
    gr1.get('SUB_DICT').get('ADD', sub)
end

gr2 = Group('SUB_CLASS', 'SubjectST_MP', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectST_MP'));
for i = 1:1:10
    sub = SubjectST_MP( ...
        'ID', ['SUB ST_MP ' int2str(i)], ...
        'LABEL', ['Subejct ST_MP ' int2str(i)], ...
        'NOTES', ['Notes on subject ST_MP ' int2str(i)], ...
        'BA', ba, ...
        'L', 3, ...
        'LAYERLABELS', {'L1' 'L2' 'L3'}, ...
        'ST_MP', {rand(ba.get('BR_DICT').get('LENGTH'), 1), rand(ba.get('BR_DICT').get('LENGTH'), 1), rand(ba.get('BR_DICT').get('LENGTH'), 1)} ...
        );
    sub.memorize('VOI_DICT').get('ADD', VOINumeric('ID', 'Age', 'V', 100 * rand()))
    sub.memorize('VOI_DICT').get('ADD', VOICategoric('ID', 'Sex', 'CATEGORIES', {'Female', 'Male'}, 'V', randi(2, 1)))
    gr2.get('SUB_DICT').get('ADD', sub)
end

a1 = AnalyzeGroup_ST_MP_BUT('GR', gr1, 'THRESHOLDS', .7:.1:.9);
a2 = AnalyzeGroup_ST_MP_BUT('GR', gr2, 'TEMPLATE', a1);

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