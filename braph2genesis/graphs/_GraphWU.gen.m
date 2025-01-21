%% ¡header!
GraphWU < Graph (g, weighted undirected graph) is a weighted undirected graph.

%%% ¡description!
In a weighted undirected graph (GraphWU), the edges are are undirected and associated 
 with a real number between 0 and 1 indicating the strength of the connection.
The connectivity matrix is symmetric.

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
GraphWU.ID
%%%% ¡title!
Graph ID

%%% ¡prop!
%%%% ¡id!
GraphWU.LABEL
%%%% ¡title!
Graph NAME

%%% ¡prop!
%%%% ¡id!
GraphWU.NODELABELS
%%%% ¡title!
NODES labels

%%% ¡prop!
%%%% ¡id!
GraphWU.B
%%%% ¡title!
Input ADJACENCY MATRIX

%%% ¡prop!
%%%% ¡id!
GraphWU.SYMMETRIZE_RULE
%%%% ¡title!
SYMMETRIZATION RULE

%%% ¡prop!
%%%% ¡id!
GraphWU.SEMIPOSITIVIZE_RULE
%%%% ¡title!
NEGATIVE WEIGHTS RULE

%%% ¡prop!
%%%% ¡id!
GraphWU.STANDARDIZE_RULE
%%%% ¡title!
NORMALIZATION RULE

%%% ¡prop!
%%%% ¡id!
GraphWU.RANDOMIZE
%%%% ¡title!
RANDOMIZATION ON/OFF

%%% ¡prop!
%%%% ¡id!
GraphWU.RANDOM_SEED
%%%% ¡title!
RANDOMIZATION SEED

%%% ¡prop!
%%%% ¡id!
GraphWU.ATTEMPTSPEREDGE
%%%% ¡title!
RANDOMIZATION ATTEMPTS PER EDGE

%%% ¡prop!
%%%% ¡id!
GraphWU.NUMBEROFWEIGHTS
%%%% ¡title!
RANDOMIZATION NUMBER OF WEIGHTS

%%% ¡prop!
%%%% ¡id!
GraphWU.A
%%%% ¡title!
Weighted Undirected ADJACENCY MATRIX

%%% ¡prop!
%%%% ¡id!
GraphWU.PFGA
%%%% ¡title!
Adjacency Matrix Plot

%%% ¡prop!
%%%% ¡id!
GraphWU.PFGH
%%%% ¡title!
Graph Histogram

%%% ¡prop!
%%%% ¡id!
GraphWU.M_DICT
%%%% ¡title!
Graph MEASURES

%%% ¡prop!
%%%% ¡id!
GraphWU.NOTES
%%%% ¡title!
Graph NOTES

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the weighted undirected graph.
%%%% ¡default!
'GraphWU'

%%% ¡prop!
NAME (constant, string) is the name of the weighted undirected graph.
%%%% ¡default!
'Graph Weighted Undirected'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the weighted undirected graph.
%%%% ¡default!
'In a weighted undirected graph (GraphWU), the edges are are undirected and associated with a real number between 0 and 1 indicating the strength of the connection. The connectivity matrix is symmetric.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the weighted undirected graph.
%%%% ¡settings!
'GraphWU'

%%% ¡prop!
ID (data, string) is a few-letter code for the weighted undirected graph.
%%%% ¡default!
'GraphWU ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the weighted undirected graph.
%%%% ¡default!
'GraphWU label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the weighted undirected graph.
%%%% ¡default!
'GraphWU notes'

%%% ¡prop!
GRAPH_TYPE (constant, scalar) returns the graph type __Graph.GRAPH__.
%%%% ¡default!
Graph.GRAPH

%%% ¡prop!
CONNECTIVITY_TYPE (query, smatrix) returns the connectivity type __Graph.WEIGHTED__.
%%%% ¡calculate!
value = Graph.WEIGHTED;

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
A (result, cell) is the symmetric non-negative adjacency matrix of the weighted undirected graph.
%%%% ¡calculate!
B = g.get('B'); %#ok<PROPLC>

B = symmetrize(B, 'SymmetrizeRule', g.get('SYMMETRIZE_RULE')); %#ok<PROPLC> % enforces symmetry of adjacency matrix
B = dediagonalize(B); %#ok<PROPLC> % removes self-connections by removing diagonal from adjacency matrix, equivalent to dediagonalize(B, 'DediagonalizeRule', 0)
B = semipositivize(B, 'SemipositivizeRule', g.get('SEMIPOSITIVIZE_RULE')); %#ok<PROPLC> % removes negative weights
B = standardize(B, 'StandardizeRule', g.get('STANDARDIZE_RULE')); %#ok<PROPLC> % ensures all weights are between 0 and 1

A = {B}; %#ok<PROPLC>

if g.get('GRAPH_TYPE') ~= 1

else
    if g.get('RANDOMIZE')
        random_A = g.get('RANDOMIZATION', A);
        A = {random_A};
    end
end
value = A;
%%%% ¡gui!
pr = PanelPropCell('EL', g, 'PROP', GraphWU.A, ...
    'TABLE_HEIGHT', s(40), ...
    'XSLIDERSHOW', false, ...
    'YSLIDERSHOW', false, ...
    'ROWNAME', g.getCallback('ANODELABELS'), ...
    'COLUMNNAME', g.getCallback('ANODELABELS'), ...
    varargin{:});

%%% ¡prop!
COMPATIBLE_MEASURES (constant, classlist) is the list of compatible measures.
%%%% ¡default!
getCompatibleMeasures('GraphWU')

%% ¡props!

%%% ¡prop!
B (data, smatrix) is the input graph adjacency matrix.
%%%% ¡gui!
pr = PanelPropMatrix('EL', g, 'PROP', GraphWU.B, ...
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

A = cell2mat(varargin{1});

if g.get('GRAPH_TYPE') ~= 1
    value = A;
    return;
end

attempts_per_edge = g.get('ATTEMPTSPEREDGE');
number_of_weights = g.get('NUMBEROFWEIGHTS');

W = A;  % swaps with A
tmp_g = GraphBU('ATTEMPTSPEREDGE', attempts_per_edge);
W = tmp_g.get('RANDOMIZATION', {W});

% remove self connections
W(1:length(W)+1:numel(W)) = 0;
W_bin = W > 0;
N = size(W,1); % number of nodes
random_A = zeros(N); % intialize null model matrix

S = sum(W,2); % nodal strength
W_sorted = sort(W(triu(W_bin))); % sorted weights vector
% find all the edges
[I_edges, J_edges] = find(triu(W));
edges = I_edges + (J_edges-1)*N;
% expected weights matrix
P = (S*S.');

for m = numel(W_sorted):-number_of_weights:1

    % sort the expected weights matrix
    [~, ind] = sort(P(edges));

    % random index of sorted expected weight
    selected_indices = randperm(m, min(m,number_of_weights)).';
    selected_edges = ind(selected_indices);

    % assign corresponding sorted weight at this index
    random_A(edges(selected_edges)) = W_sorted(selected_indices);

    % recalculate expected weight for node I_edges(selected_edge)
    % cumulative weight
    WA = accumarray([I_edges(selected_edges); J_edges(selected_edges)], W_sorted([selected_indices; selected_indices]), [N,1]);
    IJu = any(WA,2);
    F = 1 - WA(IJu)./S(IJu);
    F = F(:,ones(1,N));
    % readjust expected weight probabilities
    P(IJu,:) = P(IJu,:).*F;
    P(:,IJu) = P(:,IJu).*F.';
    % re-adjust strengths
    S(IJu) = S(IJu) - WA(IJu);

    % remove the edge/weight from further consideration
    selected_edges = ind(selected_indices);
    edges(selected_edges) = [];
    I_edges(selected_edges) = [];
    J_edges(selected_edges) = [];
    W_sorted(selected_indices) = [];
end

% calculate the final matrix
random_A = (random_A + transpose(random_A))/2;

% calculate correlation of original vs reassinged strength
% rpos = corrcoef(sum(W), sum(random_A));
% correlation_coefficients = rpos(2);
value = random_A;

%% ¡tests!

%%% ¡excluded_props!
[GraphWU.PFGA GraphWU.PFGH]

%%% ¡test!
%%%% ¡name!
Constructor - Empty
%%%% ¡probability!
.01
%%%% ¡code! 
B = [];
g = GraphWU('B', []);

g.get('A_CHECK')

A = {[]};
assert(isequal(g.get('A'), A), ...
    [BRAPH2.STR ':GraphWU:' BRAPH2.FAIL_TEST], ...
    'GraphWU is not constructing well.')

%%% ¡test!
%%%% ¡name!
Constructor - Full
%%%% ¡probability!
.01
%%%% ¡code! 
B = rand(randi(10));
g = GraphWU('B', B);

g.get('A_CHECK')

A = {standardize(symmetrize(semipositivize(dediagonalize(B))))};
assert(isequal(g.get('A'), A), ...
    [BRAPH2.STR ':GraphWU:' BRAPH2.FAIL_TEST], ...
    'GraphWU is not constructing well.')

%%% ¡test!
%%%% ¡name!
Symmetrize, Semipositivize and Standardize Rules
%%%% ¡probability!
.01
%%%% ¡code!
B = 10 * rand(randi(10) + 5) - 5; % random number in U(-5, 5)

g0 = GraphWU('B', B); % 'SYMMETRIZE_RULE', 'max', 'SEMIPOSITIVIZE_RULE', 'zero', 'STANDARDIZE_RULE', 'threshold'
A0 = max(B, B');
A0(A0 < 0) = 0;
A0(A0 > 1) = 1;
A0 = {dediagonalize(A0)};
assert(isequal(g0.get('A'), A0), ...
    [BRAPH2.STR ':GraphWD:' BRAPH2.FAIL_TEST], ...
    'GraphWD is not constructing well.')

symmetrize_rules = GraphWU.getPropSettings('SYMMETRIZE_RULE');
semipositivize_rules = GraphWU.getPropSettings('SEMIPOSITIVIZE_RULE');
standardize_rules = GraphWU.getPropSettings('STANDARDIZE_RULE');

for i = 1:1:length(symmetrize_rules)
    symmetrize_rule = symmetrize_rules{i};
    for j = 1:1:length(semipositivize_rules)
        semipositivize_rule = semipositivize_rules{j};
        for k = 1:1:length(standardize_rules)
            standardize_rule = standardize_rules{k};
            g0 = GraphWU('B', B, 'SYMMETRIZE_RULE', symmetrize_rule, 'SEMIPOSITIVIZE_RULE', semipositivize_rule, 'STANDARDIZE_RULE', standardize_rule);
        end
    end
end

%%% ¡test!
%%%% ¡name!
Randomize Rules
%%%% ¡probability!
.01
%%%% ¡code!
B = randn(10);

g = GraphWU('B', B);
g.set('RANDOMIZE', true);
g.set('ATTEMPTSPEREDGE', 4);

A = g.get('A');

assert(isequal(size(A{1}), size(B)), ...
    [BRAPH2.STR ':GraphBU:' BRAPH2.FAIL_TEST], ...
    'GraphBU Randomize is not functioning well.')

g2 = GraphWU('B', B);
g2.set('RANDOMIZE', false);
g2.set('ATTEMPTSPEREDGE', 4);
A2 = g2.get('A');
random_A = g2.get('RANDOMIZATION', A2);

if all(A2{1}==0, "all") %if all nodes are zero, the random matrix is also all zeros
    assert(isequal(A2{1}, random_A), ...
        [BRAPH2.STR ':GraphWU:' BRAPH2.FAIL_TEST], ...
        'GraphWU Randomize is not functioning well.')
elseif isequal((length(A2{1}).^2)- length(A2{1}), sum(A2{1}==1, "all")) %if all nodes (except diagonal) are one, the random matrix is the same as original
    assert(isequal(A2{1}, random_A), ...
        [BRAPH2.STR ':GraphWU:' BRAPH2.FAIL_TEST], ...
        'GraphWU Randomize is not functioning well.')
else
%     assert(~isequal(A2{1}, random_A), ...
%         [BRAPH2.STR ':GraphWU:' BRAPH2.FAIL_TEST], ...
%         'GraphWU Randomize is not functioning well.')
end

assert(isequal(numel(find(A2{1})), numel(find(random_A))), ... % check same number of nodes
    [BRAPH2.STR ':GraphBD:' BRAPH2.FAIL_TEST], ...
    'GraphWU Randomize is not functioning well.')

assert(issymmetric(random_A), ... % check symmetry 
    [BRAPH2.STR ':GraphWU:' BRAPH2.FAIL_TEST], ...
    'GraphWU Randomize is not functioning well.')

d1 = g.get('MEASURE', 'Degree');
d2 = g2.get('MEASURE', 'Degree');

assert(isequal(d1.get('M'), d2.get('M')), ...
    [BRAPH2.STR ':GraphWU:' BRAPH2.FAIL_TEST], ...
    'GraphWU Randomize is not functioning well.')