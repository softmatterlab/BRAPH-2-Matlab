%% ¡header!
OrdMxBUD < OrdMxWU (g, ordinal multiplex binary undirected graph with fixed densities) is a ordinal multiplex binary undirected graph with fixed densities.

%%% ¡description!
In an ordinal multiplex binary undirected graph with fixed densities (OrdMxBUD), the layers are 
 those of binary undirected multiplex graphs derived from the same 
 weighted supra-adjacency matrices binarized at different densities.
The supra-adjacency matrix has a number of partitions equal to the number of densities.
The layers are connected in an ordinal fashion, i.e., only consecutive layers are connected.

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
OrdMxBUD.ID
%%%% ¡title!
Graph ID

%%% ¡prop!
%%%% ¡id!
OrdMxBUD.LABEL
%%%% ¡title!
Graph NAME

%%% ¡prop!
%%%% ¡id!
OrdMxBUD.LAYERTICKS
%%%% ¡title!
LAYERS ticks

%%% ¡prop!
%%%% ¡id!
OrdMxBUD.LAYERLABELS
%%%% ¡title!
LAYERS labels

%%% ¡prop!
%%%% ¡id!
OrdMxBUD.PARTITIONLABELS
%%%% ¡title!
PARTITION labels

%%% ¡prop!
%%%% ¡id!
OrdMxBUD.NODELABELS
%%%% ¡title!
NODES labels

%%% ¡prop!
%%%% ¡id!
OrdMxBUD.B
%%%% ¡title!
Input ADJACENCY MATRIX

%%% ¡prop!
%%%% ¡id!
OrdMxBUD.SYMMETRIZE_RULE
%%%% ¡title!
SYMMETRIZATION RULE

%%% ¡prop!
%%%% ¡id!
OrdMxBUD.SEMIPOSITIVIZE_RULE
%%%% ¡title!
NEGATIVE EDGE RULE

%%% ¡prop!
%%%% ¡id!
OrdMxBUD.STANDARDIZE_RULE
%%%% ¡title!
NORMALIZATION RULE

%%% ¡prop!
%%%% ¡id!
OrdMxBUD.DENSITIES
%%%% ¡title!
DENSITIES [0% ... 100%]

%%% ¡prop!
%%%% ¡id!
OrdMxBUD.RANDOMIZE
%%%% ¡title!
RANDOMIZATION ON/OFF

%%% ¡prop!
%%%% ¡id!
OrdMxBUD.RANDOM_SEED
%%%% ¡title!
RANDOMIZATION SEED

%%% ¡prop!
%%%% ¡id!
OrdMxBUD.ATTEMPTSPEREDGE
%%%% ¡title!
RANDOMIZATION ATTEMPTS PER EDGE

%%% ¡prop!
%%%% ¡id!
OrdMxBUD.A
%%%% ¡title!
Binary Undirected ADJACENCY MATRICES at fixed Densities

%%% ¡prop!
%%%% ¡id!
OrdMxBUD.PFGA
%%%% ¡title!
Adjacency Matrix Plot

%%% ¡prop!
%%%% ¡id!
OrdMxBUD.PFGH
%%%% ¡title!
Graph Histogram

%%% ¡prop!
%%%% ¡id!
OrdMxBUD.M_DICT
%%%% ¡title!
Graph MEASURES

%%% ¡prop!
%%%% ¡id!
OrdMxBUD.NOTES
%%%% ¡title!
Graph NOTES

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the ordinal multiplex binary undirected with fixed densities.
%%%% ¡default!
'OrdMxBUD'

%%% ¡prop!
NAME (constant, string) is the name of the ordinal multiplex binary undirected graph with fixed densities.
%%%% ¡default!
'Ordinal Multiplex Binary Undirected Graph at Fixed Densities'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the ordinal multiplex binary undirected graph with fixed densities.
%%%% ¡default!
'In an ordinal multiplex binary undirected graph with fixed densities (OrdMxBUD), the layers are those of binary undirected multiplex graphs derived from the same weighted supra-adjacency matrix binarized at different densities. The supra-adjacency matrix has a number of partitions equal to the number of densities.The layers are connected in an ordinal fashion, where just consecutive layers are connected'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the ordinal multiplex binary undirected graph with fixed densities.
%%%% ¡settings!
'OrdMxBUD'

%%% ¡prop!
ID (data, string) is a few-letter code for the ordinal multiplex binary undirected graph with fixed densities.
%%%% ¡default!
'OrdMxBUD ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the ordinal multiplex binary undirected graph with fixed densities.
%%%% ¡default!
'OrdMxBUD label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the ordinal multiplex binary undirected graph with fixed densities.
%%%% ¡default!
'OrdMxBUD notes'

%%% ¡prop!
GRAPH_TYPE (constant, scalar) returns the graph type __Graph.ORDERED_MULTIPLEX__.
%%%% ¡default!
Graph.ORDERED_MULTIPLEX

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
A (result, cell) is the cell array containing the multiplex binary supra-adjacency matrices of the binary undirected multiplex. 
%%%% ¡calculate!
A_WU = calculateValue@OrdMxWU(g, prop);

densities = g.get('DENSITIES');
L = length(A_WU); % number of layers of MultiplexWU
A = cell(length(densities) * L); % the new g.layernumber() will be equal to = L*length(densities)

if L > 0 && ~isempty(cell2mat(A_WU))
    A(:, :) = {eye(length(A_WU{1, 1}))};
    for i = 1:1:length(densities)
        density = densities(i);
        layer = 1;
        for j = (i - 1) * L + 1:1:i * L
            A{j, j} = dediagonalize(binarize(A_WU{layer, layer}, 'density', density));
            layer = layer + 1;
        end
    end
end
if g.get('RANDOMIZE')
    A = g.get('RANDOMIZATION', A);
end
value = A;
%%%% ¡gui!
pr = PanelPropCell('EL', g, 'PROP', OrdMxBUD.A, ...
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
PARTITIONS (result, rvector) returns the number of multiplex layers for each partition (density) of the graph.
%%%% ¡calculate!
l = g.get('LAYERNUMBER');
densities = g.get('DENSITIES');
value = ones(1, length(densities)) * l / length(densities);

%%% ¡prop!
ALAYERLABELS (query, stringlist) returns the layer labels for A.
%%%% ¡calculate!
alayerlabels = g.get('LAYERLABELS');
if ~isa(g.getr('A'), 'NoValue') && length(alayerlabels) ~= g.get('LAYERNUMBER') % ensures that it's not unecessarily calculated
    densities = cellfun(@(x) [num2str(x) '%'], num2cell(g.get('DENSITIES')), 'uniformoutput', false);

    if length(alayerlabels) == length(g.get('B'))
        blayerlabels = alayerlabels;
    else % includes isempty(layerlabels)
        blayerlabels = cellfun(@num2str, num2cell([1:1:length(g.get('B'))]), 'uniformoutput', false);
    end
    
    alayerlabels = {};
    for i = 1:1:length(densities)
        for j = 1:1:length(blayerlabels)
            alayerlabels = [alayerlabels, [blayerlabels{j} '|' densities{i}]];
        end
    end
end
value = alayerlabels;

%%% ¡prop!
APARTITIONLABELS (query, stringlist) returns the partition (density) labels for A.
%%%% ¡calculate!
apartitionlabels = g.get('PARTITIONLABELS');
if ~isa(g.getr('A'), 'NoValue') && length(apartitionlabels) ~= length(g.get('DENSITIES')) % ensures that it's not unecessarily calculated
    apartitionlabels = cellfun(@(x) [num2str(x) '%'], num2cell(g.get('DENSITIES')), 'uniformoutput', false);
end
value = apartitionlabels;

%%% ¡prop!
ALAYERTICKS (query, rvector) returns the layer tick values.
%%%% ¡calculate!
alayerticks = g.get('LAYERTICKS');
if length(alayerticks) ~= (g.get('LAYERNUMBER') / length(g.get('DENSITIES'))) % ensures that it's not unecessarily calculated
    l = g.get('LAYERNUMBER');
    densities = g.get('DENSITIES');
    alayerticks = [1:1:(l / length(densities))];
end
value = alayerticks;

%%% ¡prop!
APARTITIONTICKS (query, rvector) returns the partition (density) ticks for A.
%%%% ¡calculate!
value = g.get('DENSITIES');

%%% ¡prop!
COMPATIBLE_MEASURES (constant, classlist) is the list of compatible measures.
%%%% ¡default!
getCompatibleMeasures('OrdMxBUD')

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
DENSITIES (parameter, rvector) is the vector of densities.
%%%% ¡gui!
pr = PanelPropRVectorSmart('EL', g, 'PROP', MultiplexBUD.DENSITIES, 'MAX', 100, 'MIN', 0, varargin{:});

%% ¡tests!

%%% ¡excluded_props!
[OrdMxBUD.PFGA OrdMxBUD.PFGH]

%%% ¡test!
%%%% ¡name!
Constructor - Full
%%%% ¡probability!
.01
%%%% ¡code!
B1 = [
     0 .1 .2 .3 .4
    .1  0 .5 .6 .7
    .2 .5  0 .8 .9
    .3 .6 .8  0  1
    .4 .7 .9  1  0
    ];
B = {B1, B1, B1};
densities = [0 55 100];
g = OrdMxBUD('B', B, 'DENSITIES', [0 55 100]);

g.get('A_CHECK')

A = g.get('A');
for i = 1:1:length(B) * length(densities)
    for j = 1:1:length(B) * length(densities)
        if i == j
            density = densities(floor((i - 1) / length(B)) + 1);
            assert(isequal(A{i, i}, binarize(B1, 'density', density)), ...
                [BRAPH2.STR ':OrdMxBUD:' BRAPH2.FAIL_TEST], ...
                'OrdMxBUD is not constructing well.')
        else
            assert(isequal(A{i, j}, eye(length(B1))), ...
                [BRAPH2.STR ':OrdMxBUD:' BRAPH2.FAIL_TEST], ...
                'OrdMxBUD is not constructing well.')            
        end
    end
end

%%% ¡test!
%%%% ¡name!
Randomize Rules
%%%% ¡probability!
.01
%%%% ¡code!
B1 = randn(10);
B = {B1, B1, B1};
densities = [0 55 100];
g = OrdMxBUD('B', B, 'DENSITIES', [0 55 100]);

g.set('RANDOMIZE', true);
g.set('ATTEMPTSPEREDGE', 4);
g.get('A_CHECK')

A = g.get('A');

assert(isequal(size(A{1}), size(B{1})), ...
    [BRAPH2.STR ':OrdMxBUD:' BRAPH2.FAIL_TEST], ...
    'OrdMxBUD Randomize is not functioning well.')

g2 = OrdMxBUD('B', B, 'DENSITIES', [0 55 100]);
g2.set('RANDOMIZE', false);
g2.set('ATTEMPTSPEREDGE', 4);
A2 = g2.get('A');
random_A = g2.get('RANDOMIZATION', A2);

for i = 1:length(A2)
    if all(A2{i, i}==0, "all") %if all nodes are zero, the random matrix is also all zeros
        assert(isequal(A2{i, i}, random_A{i, i}), ...
            [BRAPH2.STR ':OrdMxBUD:' BRAPH2.FAIL_TEST], ...
            'OrdMxBUD Randomize is not functioning well.')
    elseif isequal((length(A2{i, i}).^2)- length(A2{i, i}), sum(A2{i, i}==1, "all")) %if all nodes (except diagonal) are one, the random matrix is the same as original
        assert(isequal(A2{i, i}, random_A{i, i}), ...
            [BRAPH2.STR ':OrdMxBUD:' BRAPH2.FAIL_TEST], ...
            'OrdMxBUD Randomize is not functioning well.')
    else
%         assert(~isequal(A2{i, i}, random_A{i, i}), ...
%             [BRAPH2.STR ':OrdMxBUD:' BRAPH2.FAIL_TEST], ...
%             'OrdMxBUD Randomize is not functioning well.')
    end
    
    assert(isequal(numel(find(A2{i, i})), numel(find(random_A{i, i}))), ... % check same number of nodes
        [BRAPH2.STR ':OrdMxBUD:' BRAPH2.FAIL_TEST], ...
        'OrdMxBUD Randomize is not functioning well.')

    assert(issymmetric(random_A{i, i}), ... % check symmetry 
    [BRAPH2.STR ':OrdMxBUD:' BRAPH2.FAIL_TEST], ...
    'OrdMxBUD Randomize is not functioning well.')
end
