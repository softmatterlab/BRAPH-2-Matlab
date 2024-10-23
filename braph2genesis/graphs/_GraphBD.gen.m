%% ¡header!
GraphBD < Graph (g, binary directed graph) is a binary directed graph.

%%% ¡description!
In a binary directed graph (GraphBD), the edges are directed and they can be 
 either 0 (absence of connection) or 1 (existence of connection).

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
GraphBD.ID
%%%% ¡title!
Graph ID

%%% ¡prop!
%%%% ¡id!
GraphBD.LABEL
%%%% ¡title!
Graph NAME

%%% ¡prop!
%%%% ¡id!
GraphBD.NODELABELS
%%%% ¡title!
NODES labels

%%% ¡prop!
%%%% ¡id!
GraphBD.B
%%%% ¡title!
Input ADJACENCY MATRIX

%%% ¡prop!
%%%% ¡id!
GraphBD.SEMIPOSITIVIZE_RULE
%%%% ¡title!
NEGATIVE WEIGHTS RULE

%%% ¡prop!
%%%% ¡id!
GraphBD.RANDOMIZE
%%%% ¡title!
RANDOMIZATION ON/OFF

%%% ¡prop!
%%%% ¡id!
GraphBD.RANDOM_SEED
%%%% ¡title!
RANDOMIZATION SEED

%%% ¡prop!
%%%% ¡id!
GraphBD.ATTEMPTSPEREDGE
%%%% ¡title!
RANDOMIZATION ATTEMPTS PER EDGE

%%% ¡prop!
%%%% ¡id!
GraphBD.A
%%%% ¡title!
Binary Directed ADJACENCY MATRIX

%%% ¡prop!
%%%% ¡id!
GraphBD.PFGA
%%%% ¡title!
Adjacency Matrix Plot

%%% ¡prop!
%%%% ¡id!
GraphBD.PFGH
%%%% ¡title!
Graph Histogram

%%% ¡prop!
%%%% ¡id!
GraphBD.M_DICT
%%%% ¡title!
Graph MEASURES

%%% ¡prop!
%%%% ¡id!
GraphBD.NOTES
%%%% ¡title!
Graph NOTES

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the binary directed graph.
%%%% ¡default!
'GraphBD'

%%% ¡prop!
NAME (constant, string) is the name of the binary directed graph.
%%%% ¡default!
'Graph Binary Directed'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the binary directed graph.
%%%% ¡default!
'In a binary directed graph (GraphBD), the edges are directed and they can be either 0 (absence of connection) or 1 (existence of connection).'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the binary directed graph.
%%%% ¡settings!
'GraphBD'

%%% ¡prop!
ID (data, string) is a few-letter code for the binary directed graph.
%%%% ¡default!
'GraphBD ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the binary directed graph.
%%%% ¡default!
'GraphBD label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the binary directed graph.
%%%% ¡default!
'GraphBD notes'

%%% ¡prop!
GRAPH_TYPE (constant, scalar) returns the graph type __Graph.GRAPH__.
%%%% ¡default!
Graph.GRAPH

%%% ¡prop!
CONNECTIVITY_TYPE (query, smatrix) returns the connectivity type __Graph.BINARY__.
%%%% ¡calculate!
value = Graph.BINARY;

%%% ¡prop!
DIRECTIONALITY_TYPE (query, smatrix) returns the directionality type __Graph.DIRECTED__.
%%%% ¡calculate!
value = Graph.DIRECTED;

%%% ¡prop!
SELFCONNECTIVITY_TYPE (query, smatrix) returns the self-connectivity type __Graph.NONSELFCONNECTED__.
%%%% ¡calculate!
value = Graph.NONSELFCONNECTED;

%%% ¡prop!
NEGATIVITY_TYPE (query, smatrix) returns the negativity type __Graph.NONNEGATIVE__.
%%%% ¡calculate!
value = Graph.NONNEGATIVE;

%%% ¡prop!
A (result, cell) is the binary adjacency matrix of the binary directed graph.
%%%% ¡calculate!
B = g.get('B'); %#ok<PROPLC>

B = dediagonalize(B); %#ok<PROPLC> % removes self-connections by removing diagonal from adjacency matrix, equivalent to dediagonalize(B, 'DediagonalizeRule', 0)
B = semipositivize(B, 'SemipositivizeRule', g.get('SEMIPOSITIVIZE_RULE')); %#ok<PROPLC> % removes negative weights
B = binarize(B); %#ok<PROPLC> % enforces binary adjacency matrix, equivalent to binarize(B, 'threshold', 0, 'bins', [-1:.001:1])

A = {B}; %#ok<PROPLC>
if g.get('RANDOMIZE')
    random_A = g.get('RANDOMIZATION', A);
    A = {random_A};
end
value = A;
%%%% ¡gui!
pr = PanelPropCell('EL', g, 'PROP', GraphBD.A, ...
    'TABLE_HEIGHT', s(40), ...
    'XSLIDERSHOW', false, ...
    'YSLIDERSHOW', false, ...
    'ROWNAME', g.getCallback('ANODELABELS'), ...
    'COLUMNNAME', g.getCallback('ANODELABELS'), ...
    varargin{:} ...
    );

%%% ¡prop!
COMPATIBLE_MEASURES (constant, classlist) is the list of compatible measures.
%%%% ¡default!
getCompatibleMeasures('GraphBD')

%% ¡props!

%%% ¡prop!
B (data, smatrix) is the input graph adjacency matrix.
%%%% ¡gui!
pr = PanelPropMatrix('EL', g, 'PROP', GraphBD.B, ...
    'TABLE_HEIGHT', s(40), ...
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

A = cell2mat(varargin{1});
attempts_per_edge = g.get('ATTEMPTSPEREDGE');
% remove self connections
A(1:length(A)+1:numel(A)) = 0;
[I_edges, J_edges] = find(A); % find all the edges
E = length(I_edges); % number of edges

if E == 0
    value = A;
    swaps = 0;
    return
end

if E == 1
    r_ab = A(I_edges(1), J_edges(1));
    A(I_edges(1), J_edges(1)) = 0;
    selected_nodes = randperm(size(A, 1), 2);
    A(selected_nodes(1), selected_nodes(2)) = r_ab;
    value = A;
    swaps = 1;
    return
end

random_A = A;
swaps = 0; % number of successful edge swaps
for attempt = 1:1:attempts_per_edge*E

    % select two edges
    selected_edges = randperm(E,2);
    node_start_1 = I_edges(selected_edges(1));
    node_end_1 = J_edges(selected_edges(1));
    node_start_2 = I_edges(selected_edges(2));
    node_end_2 = J_edges(selected_edges(2));
    
    
    r_1 = random_A(node_start_1, node_end_1);
    r_2 = random_A(node_start_2, node_end_2);

    r_1 = random_A(node_start_1, node_end_1);
    r_2 = random_A(node_start_2, node_end_2);

    % Swap edges if:
    % 1) no edge between node_start_2 and node_end_1
    % 2) no edge between node_start_1 and node_end_2
    % 3) node_start_1 ~= node_start_2
    % 4) node_end_1 ~= node_end_2
    % 5) node_start_1 ~= node_end_2
    % 6) node_start_2 ~= node_end_1
    if ~random_A(node_start_1, node_end_2) && ...
            ~random_A(node_start_2, node_end_1) && ...
            node_start_1~=node_start_2 && ...
            node_end_1~=node_end_2 && ...
            node_start_1~=node_end_2 && ...
            node_start_2~=node_end_1
        % erase old edges
        random_A(node_start_1, node_end_1) = 0;
        random_A(node_start_2, node_end_2) = 0;

        % write new edges
        random_A(node_start_1, node_end_2) = r_1;
        random_A(node_start_2, node_end_1) = r_2;

        % update edge list
        J_edges(selected_edges(1)) = node_end_2;
        J_edges(selected_edges(2)) = node_end_1;

        swaps = swaps+1;
    end
end
value = random_A;

%% ¡tests!

%%% ¡excluded_props!
[GraphBD.PFGA GraphBD.PFGH]

%%% ¡test!
%%%% ¡name!
Constructor - Empty
%%%% ¡probability!
.01
%%%% ¡code!
B = [];
g = GraphBD('B', B);

g.get('A_CHECK')

A = {binarize(semipositivize(dediagonalize(B)))};
assert(isequal(g.get('A'), A), ...
    [BRAPH2.STR ':GraphBD:' BRAPH2.FAIL_TEST], ...
    'GraphBD is not constructing well.')

%%% ¡test!
%%%% ¡name!
Constructor - Full
%%%% ¡probability!
.01
%%%% ¡code!
B = randn(randi(10));
g = GraphBD('B', B);

g.get('A_CHECK')

A = {binarize(semipositivize(dediagonalize(B)))};
assert(isequal(g.get('A'), A), ...
    [BRAPH2.STR ':GraphBD:' BRAPH2.FAIL_TEST], ...
    'GraphBD is not constructing well.')

%%% ¡test!
%%%% ¡name!
Semipositivize Rules
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    -2 -1 0 1 2
    -1 0 1 2 -2
    0 1 2 -2 -1
    1 2 -2 -1 0
    2 -2 -1 0 1
    ];

g0 = GraphBD('B', B);
A0 = {[
    0 0 0 1 1
    0 0 1 1 0
    0 1 0 0 0
    1 1 0 0 0
    1 0 0 0 0
    ]};
assert(isequal(g0.get('A'), A0), ...
    [BRAPH2.STR ':GraphBD:' BRAPH2.FAIL_TEST], ...
    'GraphBD is not constructing well.')

g_zero = GraphBD('B', B, 'SEMIPOSITIVIZE_RULE', 'zero');
A_zero = {[
    0 0 0 1 1
    0 0 1 1 0
    0 1 0 0 0
    1 1 0 0 0
    1 0 0 0 0
    ]};
assert(isequal(g_zero.get('A'), A_zero), ...
    [BRAPH2.STR ':GraphBD:' BRAPH2.FAIL_TEST], ...
    'GraphBD is not constructing well.')

g_absolute = GraphBD('B', B, 'SEMIPOSITIVIZE_RULE', 'absolute');
A_absolute = {[
    0 1 0 1 1
    1 0 1 1 1
    0 1 0 1 1
    1 1 1 0 0
    1 1 1 0 0
    ]};
assert(isequal(g_absolute.get('A'), A_absolute), ...
    [BRAPH2.STR ':GraphBD:' BRAPH2.FAIL_TEST], ...
    'GraphBD is not constructing well.')

%%% ¡test!
%%%% ¡name!
Randomize Rules
%%%% ¡probability!
.01
%%%% ¡code!
B = randn(10);

g = GraphBD('B', B);
g.set('RANDOMIZE', true);
g.set('ATTEMPTSPEREDGE', 4);

A = g.get('A');

assert(isequal(size(A{1}), size(B)), ... % check equal size
    [BRAPH2.STR ':GraphBD:' BRAPH2.FAIL_TEST], ...
    'GraphBD Randomize is not functioning well.')

g2 = GraphBD('B', B);
g2.set('RANDOMIZE', false);
g2.set('ATTEMPTSPEREDGE', 4);
A2 = g2.get('A');
random_A = g2.get('RANDOMIZATION', A2);

if all(A2{1}==0, "all") %if all nodes are zero, the random matrix is also all zeros
    assert(isequal(A2{1}, random_A), ...
        [BRAPH2.STR ':GraphBD:' BRAPH2.FAIL_TEST], ...
        'GraphBD Randomize is not functioning well.')
elseif isequal((length(A2{1}).^2)- length(A2{1}), sum(A2{1}==1, "all")) %if all nodes (except diagonal) are one, the random matrix is the same as original
    assert(isequal(A2{1}, random_A), ...
        [BRAPH2.STR ':GraphBD:' BRAPH2.FAIL_TEST], ...
        'GraphBD Randomize is not functioning well.')
else
    % sometimes swaps dont occur
%     assert(~isequal(A2{1}, random_A), ...
%         [BRAPH2.STR ':GraphBD:' BRAPH2.FAIL_TEST], ...
%         'GraphBD Randomize is not functioning well.')
end

assert(isequal(numel(find(A2{1})), numel(find(random_A))), ... % check same number of nodes
    [BRAPH2.STR ':GraphBD:' BRAPH2.FAIL_TEST], ...
    'GraphBD Randomize is not functioning well.')

deg_A = sum(A2{1}, 2);
deg_B = sum(random_A, 2);
[h, p, ks2stat] = kstest2(deg_A, deg_B);

assert(isequal(0, h), ... % check same degree distribution
    [BRAPH2.STR ':GraphBD:' BRAPH2.FAIL_TEST], ...
    'GraphBD Randomize is not functioning well.')