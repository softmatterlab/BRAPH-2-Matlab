%% ¡header!
MultilayerBD < Graph (g, multilayer binary directed graph) is a multilayer binary directed graph.

%%% ¡description!
In a multilayer binary directed graph (MultilayerBD), layers could have different number 
of nodes with within-layer directed edges. Edges can be either 0 (absence of connection) 
or 1 (existence of connection).
All node connections are allowed between layers.
On the diagonal of the supra adjacency matrix, matrices are dediagonalized, semipositivized, and binarized.
On the off-diagonal of the supra adjacency matrix, matrices are semipositivized and binarized.

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
MultilayerBD.ID
%%%% ¡title!
Graph ID

%%% ¡prop!
%%%% ¡id!
MultilayerBD.LABEL
%%%% ¡title!
Graph NAME

%%% ¡prop!
%%%% ¡id!
MultilayerBD.LAYERTICKS
%%%% ¡title!
LAYERS ticks

%%% ¡prop!
%%%% ¡id!
MultilayerBD.LAYERLABELS
%%%% ¡title!
LAYERS labels

%%% ¡prop!
%%%% ¡id!
MultilayerBD.NODELABELS
%%%% ¡title!
NODES labels

%%% ¡prop!
%%%% ¡id!
MultilayerBD.B
%%%% ¡title!
Input ADJACENCY MATRIX

%%% ¡prop!
%%%% ¡id!
MultilayerBD.SEMIPOSITIVIZE_RULE
%%%% ¡title!
NEGATIVE EDGE RULE

%%% ¡prop!
%%%% ¡id!
MultilayerBD.RANDOMIZE
%%%% ¡title!
RANDOMIZATION ON/OFF

%%% ¡prop!
%%%% ¡id!
MultilayerBD.RANDOM_SEED
%%%% ¡title!
RANDOMIZATION SEED

%%% ¡prop!
%%%% ¡id!
MultilayerBD.ATTEMPTSPEREDGE
%%%% ¡title!
RANDOMIZATION ATTEMPTS PER EDGE

%%% ¡prop!
%%%% ¡id!
MultilayerBD.A
%%%% ¡title!
Binary Directed ADJACENCY MATRICES

%%% ¡prop!
%%%% ¡id!
MultilayerBD.PFGA
%%%% ¡title!
Adjacency Matrix Plot

%%% ¡prop!
%%%% ¡id!
MultilayerBD.PFGH
%%%% ¡title!
Graph Histogram

%%% ¡prop!
%%%% ¡id!
MultilayerBD.M_DICT
%%%% ¡title!
Graph MEASURES

%%% ¡prop!
%%%% ¡id!
MultilayerBD.NOTES
%%%% ¡title!
Graph NOTES

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the multilayer weighted directed graph.
%%%% ¡default!
'MultilayerBD'

%%% ¡prop!
NAME (constant, string) is the name of the multilayer weighted directed graph.
%%%% ¡default!
'Multilayer Binary Directed'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the multilayer weighted directed graph.
%%%% ¡default!
'In a multilayer binary directed graph (MultilayerBD), layers could have different number of nodes with within-layer directed edges. Edges can be either 0 (absence of connection) or 1 (existence of connection). All node connections are allowed between layers.On the diagonal of the supra adjacency matrix, matrices are dediagonalized, semipositivized, and binarized. On the off-diagonal of the supra adjacency matrix, matrices are semipositivized and binarized.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the multilayer binary directed graph.
%%%% ¡settings!
'MultilayerBD'

%%% ¡prop!
ID (data, string) is a few-letter code for the multilayer binary directed graph.
%%%% ¡default!
'MultilayerBD ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the multilayer binary directed graph.
%%%% ¡default!
'MultilayerBD label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the multilayer binary directed graph.
%%%% ¡default!
'MultilayerBD notes'

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
DIRECTIONALITY_TYPE (query, smatrix) returns the directionality type __Graph.DIRECTED__ * ones(layernumber).
%%%% ¡calculate!
if isempty(varargin)
    layernumber = 1;
else
    layernumber = varargin{1};
end
value = Graph.DIRECTED * ones(layernumber);

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
A (result, cell) is the cell containing the within-layer binary adjacency matrices of the multilayer binary directed graph and the connections between layers.
%%%% ¡calculate!
B = g.get('B'); %#ok<PROPLC>
L = length(B); %#ok<PROPLC> % number of layers
A = cell(L, L);
for i = 1:1:L
    M = dediagonalize(B{i,i}); % removes self-connections by removing diagonal from adjacency matrix, equivalent to dediagonalize(M, 'DediagonalizeRule', 0)
    M = semipositivize(M, 'SemipositivizeRule', g.get('SEMIPOSITIVIZE_RULE')); % removes negative weights
    M = binarize(M, varargin{:}); % enforces binary adjacency matrix, equivalent to binarize(M, 'threshold', 0, 'bins', [-1:.001:1])
    A(i, i) = {M};
    if ~isempty(A{i, i})
        for j = i+1:1:L
            M = semipositivize(B{i,j}, 'SemipositivizeRule', g.get('SEMIPOSITIVIZE_RULE')); % removes negative weights
            M = binarize(M, varargin{:}); % enforces binary adjacency matrix, equivalent to binarize(M, 'threshold', 0, 'bins', [-1:.001:1])
            A(i, j) = {M};
            M = semipositivize(B{j,i}, 'SemipositivizeRule', g.get('SEMIPOSITIVIZE_RULE')); % removes negative weights
            M = binarize(M, varargin{:}); % enforces binary adjacency matrix, equivalent to binarize(M, 'threshold', 0, 'bins', [-1:.001:1])
            A(j, i) = {M};
        end
    end    
end
if g.get('RANDOMIZE')
    A = g.get('RANDOMIZATION', A);
end
value = A;
%%%% ¡gui!
pr = PanelPropCell('EL', g, 'PROP', MultilayerBD.A, ...
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
ALAYERLABELS (query, stringlist) returns the layer labels to be used by the slider.
%%%% ¡calculate!
alayerlabels = g.get('LAYERLABELS');
if isempty(alayerlabels) && ~isa(g.getr('A'), 'NoValue') % ensures that it's not unecessarily calculated
    alayerlabels = cellfun(@num2str, num2cell([1:1:g.get('LAYERNUMBER')]), 'uniformoutput', false);
end
value = alayerlabels;

%%% ¡prop!
COMPATIBLE_MEASURES (constant, classlist) is the list of compatible measures.
%%%% ¡default!
getCompatibleMeasures('MultilayerBD')

%% ¡props!

%%% ¡prop!
B (data, cell) is the input cell containing the multiplex adjacency matrices.
%%%% ¡default!
{[] []; [] []}
%%%% ¡gui!
pr = PanelPropCell('EL', g, 'PROP', MultilayerBD.B, ...
    'TABLE_HEIGHT', s(40), ...
    'XSLIDERSHOW', true, ...
    'XSLIDERLABELS', g.get('LAYERLABELS'), ...
    'XSLIDERHEIGHT', s(3.5), ...
    'YSLIDERSHOW', false, ...
    'ROWNAME', g.getCallback('ANODELABELS'), ...
    'COLUMNNAME', g.getCallback('ANODELABELS'), ...
    varargin{:});

%%% ¡prop!
SEMIPOSITIVIZE_RULE (parameter, option) determines how to remove the negative edges.
%%%% ¡settings!
{'zero', 'absolute'}

%%% ¡prop!
ATTEMPTSPEREDGE (parameter, scalar) is the attempts to rewire each edge.
%%%% ¡default!
5

%%% ¡prop!
RANDOMIZATION (query, cell) performs the randomization of a connectivity matrix.
%%%% ¡calculate!
rng(g.get('RANDOM_SEED'), 'twister')

if isempty(varargin)
    value = {};
    return
end

A = varargin{1};
attempts_per_edge = g.get('ATTEMPTSPEREDGE');

for i = 1:length(A)
    tmp_a = A{i,i};

    tmp_g = GraphBD();
    tmp_g.set('ATTEMPTSPEREDGE', g.get('ATTEMPTSPEREDGE'));
    random_A = tmp_g.get('RANDOMIZATION', {tmp_a});
    A{i, i} = random_A;
end
value = A;

%% ¡tests!

%%% ¡excluded_props!
[MultilayerBD.PFGA MultilayerBD.PFGH]

%%% ¡test!
%%%% ¡name!
Constructor - Full
%%%% ¡probability!
.01
%%%% ¡code!
B1 = rand(randi(10));
B2 = rand(randi(10));
B3 = rand(randi(10));
B12 = rand(size(B1,1),size(B2,2));
B13 = rand(size(B1,1),size(B3,2));
B23 = rand(size(B2,1),size(B3,2));
B21 = rand(size(B2,1),size(B1,2));
B31 = rand(size(B3,1),size(B1,2));
B32 = rand(size(B3,1),size(B2,2));
B = {
    B1                           B12                            B13
    B21                          B2                             B23
    B31                          B32                            B3
    };
g = MultilayerBD('B', B);
g.get('A_CHECK')
A1 = binarize(semipositivize(dediagonalize(B1)));
A2 = binarize(semipositivize(dediagonalize(B2)));
A3 = binarize(semipositivize(dediagonalize(B3)));
A12 = binarize(semipositivize(B12));
A13 = binarize(semipositivize(B13));
A23 = binarize(semipositivize(B23));
A21 = binarize(semipositivize(B21));
A31 = binarize(semipositivize(B31));
A32 = binarize(semipositivize(B32));
B{1,1} = A1;
B{2,2} = A2;
B{3,3} = A3;
B{1,2} = A12;
B{1,3} = A13;
B{2,3} = A23;
B{2,1} = A21;
B{3,1} = A31;
B{3,2} = A32;
A = B;
assert(isequal(g.get('A'), A), ...
    [BRAPH2.STR ':MultilayerBD:' BRAPH2.FAIL_TEST], ...
    'MultilayerBD is not constructing well.')

% %%% ¡test!
% %%%% ¡name!
% Semipositivize Rule
% %%%% ¡probability!
% .01
% %%%% ¡code!

%%% ¡test!
%%%% ¡name!
Randomize Rules
%%%% ¡probability!
.01
%%%% ¡code!
B1 = randn(10);
B2 = randn(10);
B3 = randn(10);
B12 = rand(size(B1, 1),size(B2, 2));
B13 = rand(size(B1, 1),size(B3, 2));
B23 = rand(size(B2, 1),size(B3, 2));
B21 = rand(size(B2, 1),size(B1, 2));
B31 = rand(size(B3, 1),size(B1, 2));
B32 = rand(size(B3, 1),size(B2, 2));
B = {
    B1                           B12                            B13
    B21                          B2                             B23
    B31                          B32                            B3
    };
g = MultilayerBD('B', B);
g.set('RANDOMIZE', true);
g.set('ATTEMPTSPEREDGE', 4);
g.get('A_CHECK')

A = g.get('A');

assert(isequal(size(A{1}), size(B{1})), ...
    [BRAPH2.STR ':MultilayerBD:' BRAPH2.FAIL_TEST], ...
    'MultilayerBD Randomize is not functioning well.')

g2 = MultilayerBD('B', B);
g2.set('RANDOMIZE', false);
g2.set('ATTEMPTSPEREDGE', 4);
g2.get('A_CHECK')
A2 = g2.get('A');
random_A = g2.get('RANDOMIZATION', A2);

for i = 1:length(A2)
    if all(A2{i, i}==0, "all") %if all nodes are zero, the random matrix is also all zeros
        assert(isequal(A2{i, i}, random_A{i, i}), ...
            [BRAPH2.STR ':MultilayerBD:' BRAPH2.FAIL_TEST], ...
            'MultilayerBD Randomize is not functioning well.')
    elseif isequal((length(A2{i, i}).^2)- length(A2{i, i}), sum(A2{i, i}==1, "all")) %if all nodes (except diagonal) are one, the random matrix is the same as original
        assert(isequal(A2{i, i}, random_A{i, i}), ...
            [BRAPH2.STR ':MultilayerBD:' BRAPH2.FAIL_TEST], ...
            'MultilayerBD Randomize is not functioning well.')
    else
%         assert(~isequal(A2{i, i}, random_A{i, i}), ...
%             [BRAPH2.STR ':MultilayerBD:' BRAPH2.FAIL_TEST], ...
%             'MultilayerBD Randomize is not functioning well.')
    end

    assert(isequal(numel(find(A2{i, i})), numel(find(random_A{i, i}))), ... % check same number of nodes
        [BRAPH2.STR ':MultilayerBD:' BRAPH2.FAIL_TEST], ...
        'MultilayerBD Randomize is not functioning well.')

end