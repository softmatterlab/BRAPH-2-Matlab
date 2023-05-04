%% ¡header!
MultilayerBUT < MultilayerWU (g, multilayer binary undirected with fixed threaholds graph) is a multilayer binary undirected with fixed threaholds graph.

%%% ¡description!
In a multilayer binary undirected with fixed threaholds (BUT) graph, layers have different number 
 of nodes with within-layer binary undirected (BU) edged matrix  at different thresholds.
There are connections between layers connecting the corresponding nodes.

%% ¡props_update!

%%% ¡prop!

NAME (constant, string) is the name of the multilayer undirected with fixed threaholds graph.
%%%% ¡default!
'MultilayerBUT'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the multilayer undirected with fixed threaholds graph.
%%%% ¡default!
'In a multilayer binary undirected with fixed threaholds (BUT) graph, layers have different number of nodes with within-layer undirected weighted edges binarized at different thresholds. There are connections between layers connecting the corresponding nodes.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the multilayer binarized at different thresholds graph.
%%% ¡_prop!
% % % TEMPLATE (parameter, item) is the graph template to set the graph and measure parameters.
% % % %%%% ¡_settings!
% % % 'MultilayerBUT'

%%% ¡prop!
ID (data, string) is a few-letter code for the multilayer binary  undirected with fixed threaholds graph.
%%%% ¡default!
'MultilayerBUT ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the multilayer binary  undirected with fixed threaholds graph.
%%%% ¡default!
'MultilayerBUT label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the multilayer binary undirected with fixed threaholds graph.
%%%% ¡default!
'MultilayerBUT notes'

%%% ¡prop!
GRAPH_TYPE (constant, scalar) returns the graph type __Graph.MULTILAYER__.
%%%% ¡default!
Graph.MULTILAYER

%%% ¡prop!
CONNECTIVITY_TYPE (query, smatrix) returns the connectivity type __Graph.BINARY__ * ones(layernumber).
%%%% ¡calculate!
if isempty(varargin)
    layernumber = 1;
else
    layernumber = varargin{1};
end
value = Graph.BINARY * ones(layernumber);

%%% ¡prop!
DIRECTIONALITY_TYPE (query, smatrix) returns the directionality type __Graph.UNDIRECTED__ * ones(layernumber).
%%%% ¡calculate!
if isempty(varargin)
    layernumber = 1;
else
    layernumber = varargin{1};
end
value = Graph.UNDIRECTED * ones(layernumber);

%%% ¡prop!
SELFCONNECTIVITY_TYPE (query, smatrix) returns the self-connectivity type __Graph.NONSELFCONNECTED__ on the diagonal and __Graph.SELFCONNECTED__ off diagonal.
%%%% ¡calculate!
if isempty(varargin)
    layernumber = 1;
else
    layernumber = varargin{1};
end
value = Graph.SELFCONNECTED * ones(layernumber);
value(1:layernumber+1:end) = Graph.NONSELFCONNECTED;                

%%% ¡prop!
NEGATIVITY_TYPE (query, smatrix) returns the negativity type __Graph.NONNEGATIVE__ * ones(layernumber).
%%%% ¡calculate!
if isempty(varargin)
    layernumber = 1;
else
    layernumber = varargin{1};
end
value = Graph.NONNEGATIVE * ones(layernumber);

%%% ¡prop!
A (result, cell) is the cell containing the multilayer binary adjacency matrices of the multilayer binary undirected with fixed threaholds graph.
%%%% ¡calculate!
A_WU = calculateValue@MultilayerWU(g, prop);

thresholds = g.get('THRESHOLDS');
L = length(A_WU); % number of layers
A = cell(length(thresholds)*L);

if L > 0 && ~isempty(cell2mat(A_WU))
    A(:, :) = {eye(length(A_WU{1, 1}))};
    for i = 1:1:length(thresholds)
        threshold = thresholds(i);
        for j = (i - 1) * L + 1:1:i * L
	        for k = (i - 1) * L + 1:1:i * L
                A{j, k} = dediagonalize(binarize(A_WU{j, k}, 'threshold', threshold));
            end
        end
    end
end
value = A;

%%%% ¡gui!
pr = PanelPropCell('EL', g, 'PROP', MultilayerBUT.A, ...
    'TABLE_HEIGHT', s(40), ...
    'XYSLIDERLOCK', true, ... 
    'XSLIDERSHOW', false, ...
    'YSLIDERSHOW', true, ...
    'YSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
    'YSLIDERWIDTH', s(5), ...
    'ROWNAME', g.getCallback('ANODELABELS'), ...
    'COLUMNNAME', g.getCallback('ANODELABELS'), ...
    varargin{:});

%%% ¡prop!
PARTITIONS (result, rvector) returns the number of layers in the partitions of the graph.
%%%% ¡calculate!
l = g.get('LAYERNUMBER');
thresholds = g.get('THRESHOLDS');
value = ones(1, length(thresholds)) * l / length(thresholds);

%%% ¡prop!
ALAYERLABELS (query, stringlist) returns the layer labels to be used by the slider.
%%%% ¡calculate!
alayerlabels = g.get('LAYERLABELS');
if ~isa(g.getr('A'), 'NoValue') && length(alayerlabels) ~= g.get('LAYERNUMBER') % ensures that it's not unecessarily calculated
    thresholds = cellfun(@num2str, num2cell(g.get('THRESHOLDS')), 'uniformoutput', false);

    if length(alayerlabels) == length(g.get('B'))
        blayerlabels = alayerlabels;
    else % includes isempty(layerlabels)
        blayerlabels = cellfun(@num2str, num2cell([1:1:length(g.get('B'))]), 'uniformoutput', false);
    end
    
    alayerlabels = {};
    for i = 1:1:length(thresholds)
        for j = 1:1:length(blayerlabels)
            alayerlabels = [alayerlabels, [blayerlabels{j} '|' thresholds{i}]];
        end
    end
end
value = alayerlabels;

%%% ¡prop!
COMPATIBLE_MEASURES (constant, stringlist) is the list of compatible measures.
%%%% ¡default!
getCompatibleMeasures('MultilayerBUT')

%% ¡props!

%%% ¡prop!
THRESHOLDS (parameter, rvector) is the vector of thresholds.
%%%% ¡gui!
pr = PanelPropRVectorSmart('EL', g, 'PROP', MultilayerBUT.THRESHOLDS, 'MAX', 1, 'MIN', -1, varargin{:});

%% ¡tests!

%%% ¡excluded_props!
[MultilayerBUT.PFGA MultilayerBUT.PFGH]

%%% ¡test!
%%%% ¡name!
Constructor - Full
%%%% ¡probability!
.01
%%%% ¡code!
B1 = [
     0 .1 .2 .3 .4 
    .1 0 .1 .2 .3
    .2 .1 0 .1 .2
    .3 .2 .1 0 .1
    .4 .3 .2 .1 0
    ];
B = {B1, B1, B1};
thresholds = [0 .1 .2 .3 .4];
g = MultilayerBUT('B', B, 'THRESHOLDS', thresholds);

g.get('A_CHECK')

A = g.get('A');

for i = 1:1:length(thresholds)
    threshold = thresholds(i);
    for j = (i - 1) * length(B) + 1:1:i * length(B)
        for k = (i - 1) * length(B) + 1:1:i * length(B)
            assert(isequal(A{i, j}, binarize(B1, 'threshold', threshold)), ...
                [BRAPH2.STR ':MultilayerBUT:' BRAPH2.FAIL_TEST], ...
                'MultilayerBUT is not constructing well.')      
        end
    end
end