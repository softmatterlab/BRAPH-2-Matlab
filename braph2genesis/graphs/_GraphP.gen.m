%% ¡header!
GraphP < Graph (g, preview weighted undirected graph) is a preview weighted undirected graph.

%%% ¡description!
In a graph with weighted values in the diagonal

%%% ¡graph!
graph = Graph.GRAPH;

%%% ¡connectivity!
connectivity = Graph.WEIGHTED;

%%% ¡directionality!
directionality = Graph.DIRECTED;

%%% ¡selfconnectivity!
selfconnectivity = Graph.SELFCONNECTED;

%%% ¡negativity!
negativity = Graph.NONNEGATIVE;

%% ¡props!

%%% ¡prop!
B (data, matrix) is the input graph adjacency matrix.
%%%% ¡gui!
bas = g.get('BAS');
if ~isempty(bas)
    ba = bas{1};
    br_ids = ba.get('BR_DICT').getKeys();
    rowname = ['{' sprintf('''%s'' ', br_ids{:}) '}'];
else
    rowname = '{}';
end

pr = PanelPropMatrix('EL', g, 'PROP', GraphP.B, ...
    'ROWNAME', rowname, ...
    'COLUMNNAME', rowname, ...
    varargin{:});


%% ¡props_update!

%%% ¡prop!
TEMPLATE (parameter, item) is the graph template to set the graph and measure parameters.
%%%% ¡settings!
'GraphP'

%%% ¡prop!
A (result, cell) is the symmetric non-negative adjacency matrix of the weighted undirected graph.
%%%% ¡calculate!
B = g.get('B');

varargin = {}; %% TODO add props to manage the relevant properties of symmetrize, dediagonalize, semipositivize, standardize
% B = diag(B, varargin{:}); %% this does not make sense, nor its like braph 1
% B = semipositivize(B, varargin{:}); %% removes negative weights
% B = standardize(B, varargin{:}); %% ensures all weights are between 0 and 1

A = {B};
value = A;
%%%% ¡gui!
bas = g.get('BAS');
if ~isempty(bas)
    ba = bas{1};
    br_ids = ba.get('BR_DICT').getKeys();
    rowname = ['{' sprintf('''%s'' ', br_ids{:}) '}'];
else
    rowname = '{}';
end

pr = PanelPropCell('EL', g, 'PROP', GraphP.A, ...
    'TAB_H', 40, ...
    'XSLIDER', false, 'YSLIDER', false, ...
    'ROWNAME', rowname, ...
    'COLUMNNAME', rowname, ...
    varargin{:});
