%% ¡header!
GraphBU < Graph (g, binary undirected graph) is a binary undirected graph.

%%% ¡description!
In a binary undirected graph (GraphBU) , the edges are undirected and can be 
 either 0 (absence of connection) or 1 (existence of connection).
The connectivity matrix is symmetric.

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
GraphBU.ID
%%%% ¡title!
Graph ID

%%% ¡prop!
%%%% ¡id!
GraphBU.LABEL
%%%% ¡title!
Graph NAME

%%% ¡prop!
%%%% ¡id!
GraphBU.NODELABELS
%%%% ¡title!
NODES labels

%%% ¡prop!
%%%% ¡id!
GraphBU.B
%%%% ¡title!
Input ADJACENCY MATRIX

%%% ¡prop!
%%%% ¡id!
GraphBU.SYMMETRIZE_RULE
%%%% ¡title!
SYMMETRIZATION RULE

%%% ¡prop!
%%%% ¡id!
GraphBU.SEMIPOSITIVIZE_RULE
%%%% ¡title!
NEGATIVE WEIGHTS RULE

%%% ¡prop!
%%%% ¡id!
GraphBU.RANDOMIZE
%%%% ¡title!
RANDOMIZATION ON/OFF

%%% ¡prop!
%%%% ¡id!
GraphBU.RANDOM_SEED
%%%% ¡title!
RANDOMIZATION SEED

%%% ¡prop!
%%%% ¡id!
GraphBU.ATTEMPTSPEREDGE
%%%% ¡title!
RANDOMIZATION ATTEMPTS PER EDGE

%%% ¡prop!
%%%% ¡id!
GraphBU.A
%%%% ¡title!
Binary Undirected ADJACENCY MATRIX

%%% ¡prop!
%%%% ¡id!
GraphBU.PFGA
%%%% ¡title!
Adjacency Matrix Plot

%%% ¡prop!
%%%% ¡id!
GraphBU.PFGH
%%%% ¡title!
Graph Histogram

%%% ¡prop!
%%%% ¡id!
GraphBU.M_DICT
%%%% ¡title!
Graph MEASURES

%%% ¡prop!
%%%% ¡id!
GraphBU.NOTES
%%%% ¡title!
Graph NOTES

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the binary undirected graph.
%%%% ¡default!
'GraphBU'

%%% ¡prop!
NAME (constant, string) is the name of the binary undirected graph.
%%%% ¡default!
'Graph Binary Undirected'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the binary undirected graph.
%%%% ¡default!
'In a binary undirected graph (GraphBU), the edges are undirected and can be either 0 (absence of connection) or 1 (existence of connection). The connectivity matrix is symmetric.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the binary undirected graph.
%%%% ¡settings!
'GraphBU'

%%% ¡prop!
ID (data, string) is a few-letter code for the binary undirected graph.
%%%% ¡default!
'GraphBU ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the binary undirected graph.
%%%% ¡default!
'GraphBU label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the binary undirected graph.
%%%% ¡default!
'GraphBU notes'

%%% ¡prop!
GRAPH_TYPE (constant, scalar) returns the graph type __Graph.GRAPH__.
%%%% ¡default!
Graph.GRAPH

%%% ¡prop!
CONNECTIVITY_TYPE (query, smatrix) returns the connectivity type __Graph.BINARY__.
%%%% ¡calculate!
value = Graph.BINARY;

%%% ¡prop!
DIRECTIONALITY_TYPE (query, smatrix) returns the directionality type __Graph.UNDIRECTED__.
%%%% ¡calculate!
value = Graph.UNDIRECTED;

%%% ¡prop!
SELFCONNECTIVITY_TYPE (query, smatrix) returns the self-connectivity type __Graph.NONSELFCONNECTED__.
%%%% ¡calculate!
value = Graph.NONSELFCONNECTED;

%%% ¡prop!
NEGATIVITY_TYPE (query, smatrix) returns the negativity type __Graph.NONNEGATIVE__.
%%%% ¡calculate!
value = Graph.NONNEGATIVE;

%%% ¡prop!
A (result, cell) is the symmetric binary adjacency matrix of the binary undirected graph.
%%%% ¡calculate!
B = g.get('B'); %#ok<PROPLC>

B = symmetrize(B, 'SymmetrizeRule', g.get('SYMMETRIZE_RULE')); %#ok<PROPLC> % enforces symmetry of adjacency matrix
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
pr = PanelPropCell('EL', g, 'PROP', GraphBU.A, ...
    'TABLE_HEIGHT', s(40), ...
    'XSLIDERSHOW', false, ...
    'YSLIDERSHOW', false, ...
    'ROWNAME', g.getCallback('ANODELABELS'), ...
    'COLUMNNAME', g.getCallback('ANODELABELS'), ...
    varargin{:});

%%% ¡prop!
COMPATIBLE_MEASURES (constant, classlist) is the list of compatible measures.
%%%% ¡default!
getCompatibleMeasures('GraphBU')

%% ¡props!

%%% ¡prop!
B (data, smatrix) is the input graph adjacency matrix.
%%%% ¡gui!
pr = PanelPropMatrix('EL', g, 'PROP', GraphBU.B, ...
    'TABLE_HEIGHT', s(40), ...
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
A(1:length(A) + 1:numel(A)) = 0;
[I_edges, J_edges] = find(triu(A)); % find the edges
E = length(I_edges); % number of edges

if E == 0
    value = A;
    swaps = 0;
    return
end

if E == 1
    r_ab_1 = A(I_edges(1), J_edges(1));
    r_ab_2 = A(J_edges(1), I_edges(1));
    A(I_edges(1), J_edges(1)) = 0;
    A(J_edges(1), I_edges(1)) = 0;
    selected_nodes = randperm(size(A, 1), 2);
    A(selected_nodes(1), selected_nodes(2)) = r_ab_1;
    A(selected_nodes(2), selected_nodes(1)) = r_ab_2;
    value = A;
    swaps = 1;
    return
end

random_A = A;
swaps = 0; % number of successful edge swaps
for attempt = 1:1:attempts_per_edge * E

    % select two edges
    selected_edges = randperm(E, 2);
    node_start_1 = I_edges(selected_edges(1));
    node_end_1 = J_edges(selected_edges(1));
    node_start_2 = I_edges(selected_edges(2));
    node_end_2 = J_edges(selected_edges(2));

    if rand(1) > .5
        I_edges(selected_edges(2)) = node_end_2;
        J_edges(selected_edges(2)) = node_start_2;

        node_start_2 = I_edges(selected_edges(2));
        node_end_2 = J_edges(selected_edges(2));
    end

    r_1 = random_A(node_start_1, node_end_1);
    r_3 = random_A(node_end_1, node_start_1);
    r_2 = random_A(node_start_2, node_end_2);
    r_4 = random_A(node_end_2, node_start_2);

    % Swap edges if:
    % 1) no edge between node_start_1 and node_end_2
    % 2) no edge between node_start_2 and node_end_1
    % 3) node_start_1 ~= node_start_2
    % 4) node_end_1 ~= node_end_2
    % 5) node_start_1 ~= node_end_2
    % 6) node_start_2 ~= node_end_1

    if ~random_A(node_start_1, node_end_2) && ...
            ~random_A(node_start_2, node_end_1) && ...
            node_start_1 ~= node_start_2 && ...
            node_end_1 ~= node_end_2 && ...
            node_start_1 ~= node_end_2 && ...
            node_start_2 ~= node_end_1

        % erase old edges
        random_A(node_start_1, node_end_1) = 0;
        random_A(node_end_1, node_start_1) = 0;

        random_A(node_start_2, node_end_2) = 0;
        random_A(node_end_2, node_start_2) = 0;

        % write new edges

        random_A(node_start_1, node_end_2) = r_1;
        random_A(node_end_2, node_start_1) = r_3;

        random_A(node_start_2, node_end_1) = r_2;
        random_A(node_end_1, node_start_2) = r_4;

        % update edge list
        J_edges(selected_edges(1)) = node_end_2;
        J_edges(selected_edges(2)) = node_end_1;

        swaps = swaps + 1;
    end
end
value = random_A;

%% ¡tests!

%%% ¡excluded_props!
[GraphBU.PFGA GraphBU.PFGH]

%%% ¡test!
%%%% ¡name!
Constructor - Empty
%%%% ¡probability!
.01
%%%% ¡code!
B = [];
g = GraphBU('B', B);

g.get('A_CHECK');

A = {symmetrize(binarize(semipositivize(dediagonalize(B))))};
assert(isequal(g.get('A'), A), ...
       [BRAPH2.STR ':GraphBU:' BRAPH2.FAIL_TEST], ...
       'GraphBU is not constructing well.')
   
%%% ¡test!
%%%% ¡name!
Constructor - Full
%%%% ¡probability!
.01
%%%% ¡code!
B = randn(randi(10));
g = GraphBU('B', B);

g.get('A_CHECK')

A = {symmetrize(binarize(semipositivize(dediagonalize(B))))};
assert(isequal(g.get('A'), A), ...
       [BRAPH2.STR ':GraphBU:' BRAPH2.FAIL_TEST], ...
       'GraphBU is not constructing well.')

%%% ¡test!
%%%% ¡name!
Symmetrize and Semipositivize Rules
%%%% ¡probability!
.01
%%%% ¡code!
B = randn(randi(10));

g0 = GraphBU('B', B); % 'SEMIPOSITIVIZE_RULE', 'zero', 'SYMMETRIZE_RULE', 'max'
A0 = {dediagonalize(max(B, B') > 0)};
assert(isequal(g0.get('A'), A0), ...
    [BRAPH2.STR ':GraphBU:' BRAPH2.FAIL_TEST], ...
    'GraphBU is not constructing well.')

g_max = GraphBU('B', B, 'SYMMETRIZE_RULE', 'max'); % 'SEMIPOSITIVIZE_RULE', 'zero'
A_max = {dediagonalize(max(B, B') > 0)};
assert(isequal(g_max.get('A'), A_max), ...
    [BRAPH2.STR ':GraphBU:' BRAPH2.FAIL_TEST], ...
    'GraphBU is not constructing well.')

g_sum = GraphBU('B', B, 'SYMMETRIZE_RULE', 'sum'); % 'SEMIPOSITIVIZE_RULE', 'zero'
A_sum = {dediagonalize(B + B' > 0)};
assert(isequal(g_sum.get('A'), A_sum), ...
    [BRAPH2.STR ':GraphBU:' BRAPH2.FAIL_TEST], ...
    'GraphBU is not constructing well.')

g_average = GraphBU('B', B, 'SYMMETRIZE_RULE', 'average'); % 'SEMIPOSITIVIZE_RULE', 'zero'
A_average = {dediagonalize((B + B') / 2 > 0)};
assert(isequal(g_average.get('A'), A_average), ...
    [BRAPH2.STR ':GraphBU:' BRAPH2.FAIL_TEST], ...
    'GraphBU is not constructing well.')

g_min = GraphBU('B', B, 'SYMMETRIZE_RULE', 'min'); % 'SEMIPOSITIVIZE_RULE', 'zero'
A_min = {dediagonalize(min(B, B') > 0)};
assert(isequal(g_min.get('A'), A_min), ...
    [BRAPH2.STR ':GraphBU:' BRAPH2.FAIL_TEST], ...
    'GraphBU is not constructing well.')

g_zero = GraphBU('B', B, 'SEMIPOSITIVIZE_RULE', 'zero'); % 'SYMMETRIZE_RULE', 'max'
A_zero = {dediagonalize(max(B, B') > 0)};
assert(isequal(g_zero.get('A'), A_zero), ...
    [BRAPH2.STR ':GraphBU:' BRAPH2.FAIL_TEST], ...
    'GraphBU is not constructing well.')

g_zero_max = GraphBU('B', B, 'SEMIPOSITIVIZE_RULE', 'zero', 'SYMMETRIZE_RULE', 'max');
A_zero_max = {dediagonalize(max(B, B') > 0)};
assert(isequal(g_zero_max.get('A'), A_zero_max), ...
    [BRAPH2.STR ':GraphBU:' BRAPH2.FAIL_TEST], ...
    'GraphBU is not constructing well.')

g_zero_sum = GraphBU('B', B, 'SEMIPOSITIVIZE_RULE', 'zero', 'SYMMETRIZE_RULE', 'sum');
A_zero_sum = {dediagonalize(B + B' > 0)};
assert(isequal(g_zero_sum.get('A'), A_zero_sum), ...
    [BRAPH2.STR ':GraphBU:' BRAPH2.FAIL_TEST], ...
    'GraphBU is not constructing well.')

g_zero_average = GraphBU('B', B, 'SEMIPOSITIVIZE_RULE', 'zero', 'SYMMETRIZE_RULE', 'average');
A_zero_average = {dediagonalize((B + B') / 2 > 0)};
assert(isequal(g_zero_average.get('A'), A_zero_average), ...
    [BRAPH2.STR ':GraphBU:' BRAPH2.FAIL_TEST], ...
    'GraphBU is not constructing well.')

g_zero_min = GraphBU('B', B, 'SEMIPOSITIVIZE_RULE', 'zero', 'SYMMETRIZE_RULE', 'min');
A_zero_min = {dediagonalize(min(B, B') > 0)};
assert(isequal(g_zero_min.get('A'), A_zero_min), ...
    [BRAPH2.STR ':GraphBU:' BRAPH2.FAIL_TEST], ...
    'GraphBU is not constructing well.')

g_absolute = GraphBU('B', B, 'SEMIPOSITIVIZE_RULE', 'absolute'); % 'SYMMETRIZE_RULE', 'max'
A_absolute = {dediagonalize(max(B, B') ~= 0)};
assert(isequal(g_absolute.get('A'), A_absolute), ...
    [BRAPH2.STR ':GraphBU:' BRAPH2.FAIL_TEST], ...
    'GraphBU is not constructing well.')

g_absolute_max = GraphBU('B', B, 'SEMIPOSITIVIZE_RULE', 'absolute', 'SYMMETRIZE_RULE', 'max');
A_absolute_max = {dediagonalize(max(B, B') ~= 0)};
assert(isequal(g_absolute_max.get('A'), A_absolute_max), ...
    [BRAPH2.STR ':GraphBU:' BRAPH2.FAIL_TEST], ...
    'GraphBU is not constructing well.')

g_absolute_sum = GraphBU('B', B, 'SEMIPOSITIVIZE_RULE', 'absolute', 'SYMMETRIZE_RULE', 'sum');
A_absolute_sum = {dediagonalize(B + B' ~= 0)};
assert(isequal(g_absolute_sum.get('A'), A_absolute_sum), ...
    [BRAPH2.STR ':GraphBU:' BRAPH2.FAIL_TEST], ...
    'GraphBU is not constructing well.')

g_absolute_average = GraphBU('B', B, 'SEMIPOSITIVIZE_RULE', 'absolute', 'SYMMETRIZE_RULE', 'average');
A_absolute_average = {dediagonalize((B + B') / 2~= 0)};
assert(isequal(g_absolute_average.get('A'), A_absolute_average), ...
    [BRAPH2.STR ':GraphBU:' BRAPH2.FAIL_TEST], ...
    'GraphBU is not constructing well.')

g_absolute_min = GraphBU('B', B, 'SEMIPOSITIVIZE_RULE', 'absolute', 'SYMMETRIZE_RULE', 'min');
A_absolute_min = {dediagonalize(min(B, B') ~= 0)};
assert(isequal(g_absolute_min.get('A'), A_absolute_min), ...
    [BRAPH2.STR ':GraphBU:' BRAPH2.FAIL_TEST], ...
    'GraphBU is not constructing well.')

%%% ¡test!
%%%% ¡name!
Randomize Rules
%%%% ¡probability!
.01
%%%% ¡code!
B = randn(10);

g = GraphBU('B', B);
g.set('RANDOMIZE', true);
g.set('ATTEMPTSPEREDGE', 4);

A = g.get('A');

assert(isequal(size(A{1}), size(B)), ... % check equal size
    [BRAPH2.STR ':GraphBU:' BRAPH2.FAIL_TEST], ...
    'GraphBU Randomize is not functioning well.')

g2 = GraphBU('B', B);
g2.set('RANDOMIZE', false);
g2.set('ATTEMPTSPEREDGE', 4);
A2 = g2.get('A');
random_A = g2.get('RANDOMIZATION', A2);

if all(A2{1}==0, "all") %if all nodes are zero, the random matrix is also all zeros
    assert(isequal(A2{1}, random_A), ...
        [BRAPH2.STR ':GraphBU:' BRAPH2.FAIL_TEST], ...
        'GraphBU Randomize is not functioning well.')
elseif isequal((length(A2{1}).^2)- length(A2{1}), sum(A2{1}==1, "all")) %if all nodes (except diagonal) are one, the random matrix is the same as original
    assert(isequal(A2{1}, random_A), ...
        [BRAPH2.STR ':GraphBU:' BRAPH2.FAIL_TEST], ...
        'GraphBU Randomize is not functioning well.')
else
%     assert(~isequal(A2{1}, random_A), ...
%         [BRAPH2.STR ':GraphBU:' BRAPH2.FAIL_TEST], ...
%         'GraphBU Randomize is not functioning well.')
end

d1 = g.get('MEASURE', 'Degree');
d2 = g2.get('MEASURE', 'Degree');

assert(isequal(d1.get('M'), d2.get('M')), ...
    [BRAPH2.STR ':GraphBU:' BRAPH2.FAIL_TEST], ...
    'GraphBU Randomize is not functioning well.')
    
assert(isequal(numel(find(A2{1})), numel(find(random_A))), ... % check same number of nodes
    [BRAPH2.STR ':GraphBU:' BRAPH2.FAIL_TEST], ...
    'GraphBU Randomize is not functioning well.')

assert(issymmetric(random_A), ... % check symmetry 
[BRAPH2.STR ':GraphBU:' BRAPH2.FAIL_TEST], ...
'GraphBU Randomize is not functioning well.')

deg_A = sum(A2{1});
deg_B = sum(random_A);
[h, p, ks2stat] = kstest2(deg_A, deg_B);

assert(isequal(0, h), ... % check same degree distribution
    [BRAPH2.STR ':GraphBU:' BRAPH2.FAIL_TEST], ...
    'GraphBU Randomize is not functioning well.')