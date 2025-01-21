%% ¡header!
MultigraphBUT < GraphWU (g, binary undirected multigraph with fixed thresholds) is a binary undirected multigraph with fixed thresholds.

%%% ¡description!
In a binary undirected multigraph with fixed thresholds (MultigraphBUT), all the layers 
 consist of binary undirected graphs derived from the same 
 weighted connectivity matrix binarized at different thresholds.
There are no connections between layers.

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
MultigraphBUT.ID
%%%% ¡title!
Graph ID

%%% ¡prop!
%%%% ¡id!
MultigraphBUT.LABEL
%%%% ¡title!
Graph NAME

%%% ¡prop!
%%%% ¡id!
MultigraphBUT.PARTITIONLABELS
%%%% ¡title!
PARTITION labels

%%% ¡prop!
%%%% ¡id!
MultigraphBUT.NODELABELS
%%%% ¡title!
NODES labels

%%% ¡prop!
%%%% ¡id!
MultigraphBUT.B
%%%% ¡title!
Input ADJACENCY MATRIX

%%% ¡prop!
%%%% ¡id!
MultigraphBUT.SYMMETRIZE_RULE
%%%% ¡title!
SYMMETRIZATION RULE

%%% ¡prop!
%%%% ¡id!
MultigraphBUT.SEMIPOSITIVIZE_RULE
%%%% ¡title!
NEGATIVE EDGE RULE

%%% ¡prop!
%%%% ¡id!
MultigraphBUT.STANDARDIZE_RULE
%%%% ¡title!
NORMALIZATION RULE

%%% ¡prop!
%%%% ¡id!
MultigraphBUT.THRESHOLDS
%%%% ¡title!
THRESHOLDS [-1 ... 1]

%%% ¡prop!
%%%% ¡id!
MultigraphBUT.RANDOMIZE
%%%% ¡title!
RANDOMIZATION ON/OFF

%%% ¡prop!
%%%% ¡id!
MultigraphBUT.RANDOM_SEED
%%%% ¡title!
RANDOMIZATION SEED

%%% ¡prop!
%%%% ¡id!
MultigraphBUT.ATTEMPTSPEREDGE
%%%% ¡title!
RANDOMIZATION ATTEMPTS PER EDGE

%%% ¡prop!
%%%% ¡id!
MultigraphBUT.A
%%%% ¡title!
Binary Undirected ADJACENCY MATRICES at fixed Thresholds

%%% ¡prop!
%%%% ¡id!
MultigraphBUT.PFGA
%%%% ¡title!
Adjacency Matrix Plot

%%% ¡prop!
%%%% ¡id!
MultigraphBUT.PFGH
%%%% ¡title!
Graph Histogram

%%% ¡prop!
%%%% ¡id!
MultigraphBUT.M_DICT
%%%% ¡title!
Graph MEASURES

%%% ¡prop!
%%%% ¡id!
MultigraphBUT.NOTES
%%%% ¡title!
Graph NOTES

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the binary undirected multigraph with fixed thresholds.
%%%% ¡default!
'MultigraphBUT'

%%% ¡prop!
NAME (constant, string) is the name of the binary undirected multigraph with fixed thresholds.
%%%% ¡default!
'Multigraph Binary Undirected at fixed Thresholds'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the binary undirected multigraph with fixed thresholds.
%%%% ¡default!
'In a binary undirected multigraph with fixed thresholds (MultigraphBUT), all the layers consist of binary undirected graphs derived from the same weighted connectivity matrix binarized at different thresholds. There are no connections between layers.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the binary undirected multigraph with fixed thresholds.
%%%% ¡settings!
'MultigraphBUT'

%%% ¡prop!
ID (data, string) is a few-letter code for the binary undirected multigraph with fixed thresholds.
%%%% ¡default!
'MultigraphBUT ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the binary undirected multigraph with fixed thresholds.
%%%% ¡default!
'MultigraphBUT label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the binary undirected multigraph with fixed thresholds.
%%%% ¡default!
'MultigraphBUT notes'

%%% ¡prop!
GRAPH_TYPE (constant, scalar) returns the graph type __Graph.MULTIGRAPH__.
%%%% ¡default!
Graph.MULTIGRAPH

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
SELFCONNECTIVITY_TYPE (query, smatrix) returns the self-connectivity type __Graph.NONSELFCONNECTED__ * ones(layernumber).
%%%% ¡calculate!
if isempty(varargin)
    layernumber = 1;
else
    layernumber = varargin{1};
end
value = Graph.NONSELFCONNECTED * ones(layernumber);

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
A (result, cell) is the cell array with the symmetric binary adjacency matrices of the binary undirected multigraph.
%%%% ¡calculate!
A_WU = calculateValue@GraphWU(g, prop);

thresholds = g.get('THRESHOLDS');
A = cell(length(thresholds));

for i = 1:1:length(thresholds)
    threshold = thresholds(i);
    tmp_A = dediagonalize(binarize(cell2mat(A_WU), 'threshold', threshold));
    A{i, i} = tmp_A;
end
if g.get('RANDOMIZE')
    A = g.get('RANDOMIZATION', A);
end
value = A;
%%%% ¡gui!
pr = PanelPropCell('EL', g, 'PROP', MultigraphBUT.A, ...
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
PARTITIONS (result, rvector) returns the number of layers (1) for each partition (threshold) of the graph.
%%%% ¡calculate!
l = g.get('LAYERNUMBER');
thresholds = g.get('THRESHOLDS');
value = ones(1, length(thresholds)) * l / length(thresholds);

%%% ¡prop!
ALAYERLABELS (query, stringlist) returns the layer labels to be used by the slider.
%%%% ¡calculate!
alayerlabels = g.get('LAYERLABELS');
if isempty(alayerlabels) && ~isa(g.getr('A'), 'NoValue') % ensures that it's not unecessarily calculated
    alayerlabels = cellfun(@(x) [num2str(x) '%'], num2cell(g.get('THRESHOLDS')), 'uniformoutput', false);
end
value = alayerlabels;

%%% ¡prop!
APARTITIONLABELS (query, stringlist) returns the partition (threshold) labels for A.
%%%% ¡calculate!
apartitionlabels = g.get('PARTITIONLABELS');
if ~isa(g.getr('A'), 'NoValue') && length(apartitionlabels) ~= length(g.get('THRESHOLDS')) % ensures that it's not unecessarily calculated
    apartitionlabels = cellfun(@num2str, num2cell(g.get('THRESHOLDS')), 'uniformoutput', false);
end
value = apartitionlabels;

%%% ¡prop!
ALAYERTICKS (query, rvector) returns the layer tick values.
%%%% ¡calculate!
alayerticks = g.get('LAYERTICKS');
if length(alayerticks) ~= (g.get('LAYERNUMBER') / length(g.get('THRESHOLDS'))) % ensures that it's not unecessarily calculated
    l = g.get('LAYERNUMBER');
    thresholds = g.get('THRESHOLDS');
    alayerticks = [1:1:(l / length(thresholds))];
end
value = alayerticks;

%%% ¡prop!
APARTITIONTICKS (query, rvector) returns the partition (threshold) ticks for A.
%%%% ¡calculate!
value = g.get('THRESHOLDS');

%%% ¡prop!
COMPATIBLE_MEASURES (constant, classlist) is the list of compatible measures.
%%%% ¡default!
getCompatibleMeasures('MultigraphBUT')

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

    random_g = GraphBU();
    random_g.set('ATTEMPTSPEREDGE', g.get('ATTEMPTSPEREDGE'));
    random_A = random_g.get('RANDOMIZATION', {tmp_a});
    A{i, i} = random_A;
end
value = A;

%% ¡props!

%%% ¡prop!
THRESHOLDS (parameter, rvector) is the vector of thresholds.
%%%% ¡gui!
pr = PanelPropRVectorSmart('EL', g, 'PROP', MultigraphBUT.THRESHOLDS, 'MAX', 1, 'MIN', -1, varargin{:});



%% ¡tests!

%%% ¡excluded_props!
[MultigraphBUT.PFGA MultigraphBUT.PFGH]

%%% ¡test!
%%%% ¡name!
Constructor - Empty
%%%% ¡probability!
.01
%%%% ¡code!

% 1
B = [];
g = MultigraphBUT('B', B, 'THRESHOLDS', []);

g.get('A_CHECK')

A = {};
assert(isequal(g.get('A'), A), ...
    [BRAPH2.STR ':MultigraphBUT:' BRAPH2.FAIL_TEST], ...
    'MultigraphBUT is not constructing well.')

% 2
B = [];
g = MultigraphBUT('B', B, 'THRESHOLDS', [0 .1 .2 .3 .4 .5]);

g.get('A_CHECK')

A = g.get('A');
assert(isequal(A{1, 1}, []) && isequal(A{2, 2}, []) && isequal(A{3, 3}, []) && isequal(A{4, 4}, []) && isequal(A{5, 5}, []) && isequal(A{6, 6}, []), ...
    [BRAPH2.STR ':MultigraphBUT:' BRAPH2.FAIL_TEST], ...
    'MultigraphBUT is not constructing well.')

% 3
B = [
    0 .1 .2 .3 .4
    .1 0 .1 .2 .3
    .2 .1 0 .1 .2
    .3 .2 .1 0 .1
    .4 .3 .2 .1 0
    ];
g = MultigraphBUT('B', B, 'THRESHOLDS', []);

g.get('A_CHECK')
A = {};
assert(isequal(g.get('A'), A), ...
    [BRAPH2.STR ':MultigraphBUT:' BRAPH2.FAIL_TEST], ...
    'MultigraphBUT is not constructing well.')

%%% ¡test!
%%%% ¡name!
Constructor - Full
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0 .1 .2 .3 .4
    .1 0 .1 .2 .3
    .2 .1 0 .1 .2
    .3 .2 .1 0 .1
    .4 .3 .2 .1 0
    ];
g = MultigraphBUT('B', B, 'THRESHOLDS', [0 .1 .2 .3 .4 .5]);

g.get('A_CHECK')

A = g.get('A');
assert(isequal( ...
    A{1, 1}, ...
    [
    0 1 1 1 1
    1 0 1 1 1
    1 1 0 1 1
    1 1 1 0 1
    1 1 1 1 0
    ]) ...
    && ...
    isequal( ...
    A{2, 2}, ...
    [
    0 0 1 1 1
    0 0 0 1 1
    1 0 0 0 1
    1 1 0 0 0
    1 1 1 0 0
    ]) ...
    && ...
    isequal( ...
    A{3, 3}, ...
    [
    0 0 0 1 1
    0 0 0 0 1
    0 0 0 0 0
    1 0 0 0 0
    1 1 0 0 0
    ]) ...
    && ...
    isequal( ...
    A{4, 4}, ...
    [
    0 0 0 0 1
    0 0 0 0 0
    0 0 0 0 0
    0 0 0 0 0
    1 0 0 0 0
    ]) ...
    && ...
    isequal( ...
    A{5, 5}, ...
    [
    0 0 0 0 0
    0 0 0 0 0
    0 0 0 0 0
    0 0 0 0 0
    0 0 0 0 0
    ]) ...
    && ...
    isequal( ...
    A{6, 6}, ...
    [
    0 0 0 0 0
    0 0 0 0 0
    0 0 0 0 0
    0 0 0 0 0
    0 0 0 0 0
    ]), ...
    [BRAPH2.STR ':MultigraphBUT:' BRAPH2.FAIL_TEST], ...
    'MultigraphBUT is not constructing well.')


%%% ¡test!
%%%% ¡name!
Randomize Rules
%%%% ¡probability!
.01
%%%% ¡code!
B = randn(10);
g = MultigraphBUT('B', B, 'THRESHOLDS', [0 .1 .2 .3 .4 .5]);

g.set('RANDOMIZE', true);
g.set('ATTEMPTSPEREDGE', 4);
g.get('A_CHECK')

A = g.get('A');

assert(isequal(size(A{1}), size(B)), ...
    [BRAPH2.STR ':MultigraphBUT:' BRAPH2.FAIL_TEST], ...
    'MultigraphBUT Randomize is not functioning well.')

g2 = MultigraphBUT('B', B, 'THRESHOLDS', [0 .1 .2 .3 .4 .5]);
g2.set('RANDOMIZE', false);
g2.set('ATTEMPTSPEREDGE', 4);
g2.get('A_CHECK')

A2 = g2.get('A');
random_A = g2.get('RANDOMIZATION', A2);

for i = 1:length(A2)
    if all(A2{i, i}==0, "all") %if all nodes are zero, the random matrix is also all zeros
        assert(isequal(A2{i, i}, random_A{i, i}), ...
            [BRAPH2.STR ':MultigraphBUT:' BRAPH2.FAIL_TEST], ...
            'MultigraphBUT Randomize is not functioning well.')
    elseif isequal((length(A2{i, i}).^2)- length(A2{i, i}), sum(A2{i, i}==1, "all")) %if all nodes (except diagonal) are one, the random matrix is the same as original
        assert(isequal(A2{i, i}, random_A{i, i}), ...
            [BRAPH2.STR ':MultigraphBUT:' BRAPH2.FAIL_TEST], ...
            'MultigraphBUT Randomize is not functioning well.')
    else
%         assert(~isequal(A2{i, i}, random_A{i, i}), ...
%             [BRAPH2.STR ':MultigraphBUT:' BRAPH2.FAIL_TEST], ...
%             'MultigraphBUT Randomize is not functioning well.')
    end

    assert(isequal(numel(find(A2{i, i})), numel(find(random_A{i, i}))), ... % check same number of nodes
        [BRAPH2.STR ':MultigraphBUT:' BRAPH2.FAIL_TEST], ...
        'MultigraphBUT Randomize is not functioning well.')
        
    assert(issymmetric(random_A{i, i}), ... % check symmetry 
    [BRAPH2.STR ':MultigraphBUT:' BRAPH2.FAIL_TEST], ...
    'MultigraphBUT Randomize is not functioning well.')
end