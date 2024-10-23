%% ¡header!
MultilayerWU < Graph (g, multilayer weighted undirected graph) is a multilayer weighted undirected graph.

%%% ¡description!
In a multilayer weighted undirected graph (MultilayerWU) graph, layers could have different number 
 of nodes with within-layer weighted undirected edges, associated with a real 
 number between 0 and 1 and indicating the strength of the connection.
The connectivity matrices are symmetric (within layer).
All node connections are allowed between layers.
On the diagonal of the supra adjacency matrix, matrices are symmetrized, dediagonalized, semipositivized, and standardized.
On the off-diagonal of the supra adjacency matrix, matrices are semipositivized and standardized.

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
MultilayerWU.ID
%%%% ¡title!
Graph ID

%%% ¡prop!
%%%% ¡id!
MultilayerWU.LABEL
%%%% ¡title!
Graph NAME

%%% ¡prop!
%%%% ¡id!
MultilayerWU.LAYERTICKS
%%%% ¡title!
LAYERS ticks

%%% ¡prop!
%%%% ¡id!
MultilayerWU.LAYERLABELS
%%%% ¡title!
LAYERS labels

%%% ¡prop!
%%%% ¡id!
MultilayerWU.NODELABELS
%%%% ¡title!
NODES labels

%%% ¡prop!
%%%% ¡id!
MultilayerWU.B
%%%% ¡title!
Input ADJACENCY MATRIX

%%% ¡prop!
%%%% ¡id!
MultilayerWU.SYMMETRIZE_RULE
%%%% ¡title!
SYMMETRIZATION RULE

%%% ¡prop!
%%%% ¡id!
MultilayerWU.SEMIPOSITIVIZE_RULE
%%%% ¡title!
NEGATIVE EDGE RULE

%%% ¡prop!
%%%% ¡id!
MultilayerWU.STANDARDIZE_RULE
%%%% ¡title!
NORMALIZATION RULE

%%% ¡prop!
%%%% ¡id!
MultilayerWU.RANDOMIZE
%%%% ¡title!
RANDOMIZATION ON/OFF

%%% ¡prop!
%%%% ¡id!
MultilayerWU.RANDOM_SEED
%%%% ¡title!
RANDOMIZATION SEED

%%% ¡prop!
%%%% ¡id!
MultilayerWU.ATTEMPTSPEREDGE
%%%% ¡title!
RANDOMIZATION ATTEMPTS PER EDGE

%%% ¡prop!
%%%% ¡id!
MultilayerWU.NUMBEROFWEIGHTS
%%%% ¡title!
RANDOMIZATION NUMBER OF WEIGHTS

%%% ¡prop!
%%%% ¡id!
MultilayerWU.A
%%%% ¡title!
Weighted Undirected ADJACENCY MATRICES

%%% ¡prop!
%%%% ¡id!
MultilayerWU.PFGA
%%%% ¡title!
Adjacency Matrix Plot

%%% ¡prop!
%%%% ¡id!
MultilayerWU.PFGH
%%%% ¡title!
Graph Histogram

%%% ¡prop!
%%%% ¡id!
MultilayerWU.M_DICT
%%%% ¡title!
Graph MEASURES

%%% ¡prop!
%%%% ¡id!
MultilayerWU.NOTES
%%%% ¡title!
Graph NOTES

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the multilayer weighted undirected graph.
%%%% ¡default!
'MultilayerWU'

%%% ¡prop!
NAME (constant, string) is the name of the multilayer weighted undirected graph.
%%%% ¡default!
'Multilayer Weighted Undirected'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the multilayer weighted undirected graph.
%%%% ¡default!
'In a multilayer weighted undirected graph (MultilayerWU), layers could have different number of nodes with within-layer weighted undirected edges, associated with a real number between 0 and 1 and indicating the strength of the connection. The connectivity matrices are symmetric (within layer). All node connections are allowed between layers. On the diagonal of the supra adjacency matrix, matrices are symmetrized, dediagonalized, semipositivized, and standardized. On the off-diagonal of the supra adjacency matrix, matrices are semipositivized and standardized.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the multilayer weighted undirected graph.
%%%% ¡settings!
'MultilayerWU'

%%% ¡prop!
ID (data, string) is a few-letter code for the multilayer weighted undirected graph.
%%%% ¡default!
'MultilayerWU ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the multilayer weighted undirected graph.
%%%% ¡default!
'MultilayerWU label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the multilayer weighted undirected graph.
%%%% ¡default!
'MultilayerWU notes'

%%% ¡prop!
GRAPH_TYPE (constant, scalar) returns the graph type __Graph.MULTILAYER__.
%%%% ¡default!
Graph.MULTILAYER

%%% ¡prop!
CONNECTIVITY_TYPE (query, smatrix) returns the connectivity type __Graph.WEIGHTED__ * ones(layernumber).
%%%% ¡calculate!
if isempty(varargin)
    layernumber = 1;
else
    layernumber = varargin{1};
end
value = Graph.WEIGHTED * ones(layernumber);

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
A (result, cell) is the cell containing the weighted supra-adjacency matrix of the multilayer weighted undirected graph.
%%%% ¡calculate!
B = g.get('B'); %#ok<PROPLC>
L = length(B); %#ok<PROPLC> % number of layers
A = cell(L, L);
for i = 1:1:L
    M = symmetrize(B{i,i}, 'SymmetrizeRule', g.get('SYMMETRIZE_RULE')); %#ok<PROPLC> % enforces symmetry of adjacency matrix
    M = dediagonalize(M); % removes self-connections by removing diagonal from adjacency matrix, equivalent to dediagonalize(M, 'DediagonalizeRule', 0)
    M = semipositivize(M, 'SemipositivizeRule', g.get('SEMIPOSITIVIZE_RULE')); % removes negative weights
    M = standardize(M, 'StandardizeRule', g.get('STANDARDIZE_RULE')); % rescales adjacency matrix
    A(i, i) = {M};
    if ~isempty(A{i, i})        
        for j = i+1:1:L
            M = semipositivize(B{i, j}, 'SemipositivizeRule', g.get('SEMIPOSITIVIZE_RULE')); % removes negative weights
            M = standardize(M, 'StandardizeRule', g.get('STANDARDIZE_RULE')); % rescales adjacency matrix
            A(i, j) = {M};
            M = semipositivize(B{j, i}, 'SemipositivizeRule', g.get('SEMIPOSITIVIZE_RULE')); % removes negative weights
            M = standardize(M, 'StandardizeRule', g.get('STANDARDIZE_RULE')); % rescales adjacency matrix
            A(j, i) = {M};
        end
    end
end

if g.get('GRAPH_TYPE') ~= 6

else
    if g.get('RANDOMIZE')
        A = g.get('RANDOMIZATION', A);
    end
end
value = A;
%%%% ¡gui!
pr = PanelPropCell('EL', g, 'PROP', MultilayerWU.A, ...
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
getCompatibleMeasures('MultilayerWU')

%% ¡props!

%%% ¡prop!
B (data, cell) is the input cell containing the multilayer adjacency matrices on the diagonal.
%%%% ¡default!
{[] []; [] []}
%%%% ¡gui!
pr = PanelPropCell('EL', g, 'PROP', MultilayerWU.B, ...
    'TABLE_HEIGHT', s(40), ...
    'XSLIDERSHOW', true, ...
    'XSLIDERLABELS', g.get('LAYERLABELS'), ...
    'XSLIDERHEIGHT', s(3.5), ...
    'YSLIDERSHOW', false, ...
    'ROWNAME', g.getCallback('ANODELABELS'), ...
    'COLUMNNAME', g.getCallback('ANODELABELS'), ...
    varargin{:});

%%% ¡prop!
SYMMETRIZE_RULE (parameter, option) determines how to symmetrize the matrix.
%%%% ¡settings!
{'max', 'sum', 'average', 'min'}

%%% ¡prop!
SEMIPOSITIVIZE_RULE (parameter, option) determines how to remove the negative edges.
%%%% ¡settings!
{'zero', 'absolute'}

%%% ¡prop!
STANDARDIZE_RULE (parameter, option) determines how to normalize the weights between 0 and 1.
%%%% ¡settings!
{'threshold' 'range'}

%%% ¡prop!
ATTEMPTSPEREDGE (parameter, scalar) is the attempts to rewire each edge.
%%%% ¡default!
5

%%% ¡prop!
NUMBEROFWEIGHTS (parameter, scalar) specifies the number of weights sorted at the same time.
%%%% ¡default!
10

%%% ¡prop!
RANDOMIZATION (query, cell) performs the randomization of a connectivity matrix.
%%%% ¡calculate!
rng(g.get('RANDOM_SEED'), 'twister')

if isempty(varargin)
    value = {};
    return
end

A = varargin{1};

for i = 1:length(A)
    tmp_a = A{i,i};

    tmp_g = GraphWU();
    tmp_g.set('ATTEMPTSPEREDGE', g.get('ATTEMPTSPEREDGE'));
    tmp_g.set('NUMBEROFWEIGHTS', g.get('NUMBEROFWEIGHTS'));
    random_A = tmp_g.get('RANDOMIZATION', {tmp_a});
    A{i, i} = random_A;
end
value = A;

%% ¡tests!

%%% ¡excluded_props!
[MultilayerWU.PFGA MultilayerWU.PFGH]

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
B = {
    B1                           B12                            B13
    B12'                         B2                             B23
    B13'                         B23'                           B3
    };
g = MultilayerWU('B', B);
g.get('A_CHECK')
A1 = symmetrize(standardize(semipositivize(dediagonalize(B1))));
A2 = symmetrize(standardize(semipositivize(dediagonalize(B2))));
A3 = symmetrize(standardize(semipositivize(dediagonalize(B3))));
A12 =  standardize(semipositivize(B12));
A13 =  standardize(semipositivize(B13));
A23 =  standardize(semipositivize(B23));
B{1, 1} = A1;
B{2, 2} = A2;
B{3, 3} = A3;
B{1, 2} = A12;
B{1, 3} = A13;
B{2, 3} = A23;
B{2, 1} = A12';
B{3, 1} = A13';
B{3, 2} = A23';
A = B;
assert(isequal(g.get('A'), A), ...
    [BRAPH2.STR ':MultilayerWU:' BRAPH2.FAIL_TEST], ...
    'MultilayerWU is not constructing well.')

%%% ¡test!
%%%% ¡name!
Randomize Rules
%%%% ¡probability!
.01
%%%% ¡code!
B1 = rand(randi(10));
B2 = rand(randi(10));
B3 = rand(randi(10));
B12 = rand(size(B1,1),size(B2,2));
B13 = rand(size(B1,1),size(B3,2));
B23 = rand(size(B2,1),size(B3,2));
B = {
    B1                           B12                            B13
    B12'                         B2                             B23
    B13'                         B23'                           B3
    };
g = MultilayerWU('B', B);
g.set('RANDOMIZE', true);
g.set('ATTEMPTSPEREDGE', 4);
g.get('A_CHECK')
A = g.get('A');

assert(isequal(size(A{1}), size(B{1})), ...
    [BRAPH2.STR ':MultilayerWU:' BRAPH2.FAIL_TEST], ...
    'MultilayerBUD Randomize is not functioning well.')

g2 = MultilayerWU('B', B);
g2.set('RANDOMIZE', false);
g2.set('ATTEMPTSPEREDGE', 4);
g2.get('A_CHECK')
A2 = g.get('A');
random_A = g2.get('RANDOMIZATION', A2);

for i = 1:length(A2)
    if all(A2{i, i}==0, "all") %if all nodes are zero, the random matrix is also all zeros
        assert(isequal(A2{i, i}, random_A{i, i}), ...
            [BRAPH2.STR ':MultilayerWU:' BRAPH2.FAIL_TEST], ...
            'MultilayerWU Randomize is not functioning well.')
    elseif isequal((length(A2{i, i}).^2)- length(A2{i, i}), sum(A2{i, i}==1, "all")) %if all nodes (except diagonal) are one, the random matrix is the same as original
        assert(isequal(A2{i, i}, random_A{i, i}), ...
            [BRAPH2.STR ':MultilayerWU:' BRAPH2.FAIL_TEST], ...
            'MultilayerWU Randomize is not functioning well.')
    else
%         assert(~isequal(A2{i, i}, random_A{i, i}), ...
%             [BRAPH2.STR ':MultilayerWU:' BRAPH2.FAIL_TEST], ...
%             'MultilayerWU Randomize is not functioning well.')
    end
    
    assert(isequal(numel(find(A2{i, i})), numel(find(random_A{i, i}))), ... % check same number of nodes
        [BRAPH2.STR ':MultilayerWU:' BRAPH2.FAIL_TEST], ...
        'MultilayerWU Randomize is not functioning well.')

    assert(issymmetric(random_A{i, i}), ... % check symmetry 
    [BRAPH2.STR ':MultilayerWU:' BRAPH2.FAIL_TEST], ...
    'MultilayerWU Randomize is not functioning well.')
end