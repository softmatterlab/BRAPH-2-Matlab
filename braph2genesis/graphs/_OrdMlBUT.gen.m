%% ¡header!
OrdMlBUT < OrdMlWU (g, ordinal multilayer binary undirected graph with fixed thresholds) is an ordinal multilayer binary undirected graph with fixed thresholds.

%%% ¡description!
In an ordinal multilayer binary undirected graph with fixed thresholds (OrdMlBUT), layers 
 consist of binary undirected multilayer graphs derived from the same 
 weighted supra-connectivity matrices binarized at different thresholds. Layers 
 within the binary undirected multilayer graphs could have different number of nodes 
 with within-layer binary undirected edges. Edges can be either 0 (absence of connection) 
 or 1 (existence of connection).
The supra-connectivity matrix has a number of partitions equal to the number of thresholds.
The layers are connected in an ordinal fashion, i.e., only consecutive layers are connected.
On the diagonal of the supra adjacency matrix, matrices are symmetrized, dediagonalized, semipositivized, and binarized.
On the off-diagonal of the supra adjacency matrix, matrices are semipositivized and binarized.

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
OrdMlBUT.ID
%%%% ¡title!
Graph ID

%%% ¡prop!
%%%% ¡id!
OrdMlBUT.LABEL
%%%% ¡title!
Graph NAME

%%% ¡prop!
%%%% ¡id!
OrdMlBUT.LAYERTICKS
%%%% ¡title!
LAYERS ticks

%%% ¡prop!
%%%% ¡id!
OrdMlBUT.LAYERLABELS
%%%% ¡title!
LAYERS labels

%%% ¡prop!
%%%% ¡id!
OrdMlBUT.PARTITIONLABELS
%%%% ¡title!
PARTITION labels

%%% ¡prop!
%%%% ¡id!
OrdMlBUT.NODELABELS
%%%% ¡title!
NODES labels

%%% ¡prop!
%%%% ¡id!
OrdMlBUT.B
%%%% ¡title!
Input ADJACENCY MATRIX

%%% ¡prop!
%%%% ¡id!
OrdMlBUT.SYMMETRIZE_RULE
%%%% ¡title!
SYMMETRIZATION RULE

%%% ¡prop!
%%%% ¡id!
OrdMlBUT.SEMIPOSITIVIZE_RULE
%%%% ¡title!
NEGATIVE EDGE RULE

%%% ¡prop!
%%%% ¡id!
OrdMlBUT.STANDARDIZE_RULE
%%%% ¡title!
NORMALIZATION RULE

%%% ¡prop!
%%%% ¡id!
OrdMlBUT.THRESHOLDS
%%%% ¡title!
THRESHOLDS [-1 ... 1]

%%% ¡prop!
%%%% ¡id!
OrdMlBUT.RANDOMIZE
%%%% ¡title!
RANDOMIZATION ON/OFF

%%% ¡prop!
%%%% ¡id!
OrdMlBUT.RANDOM_SEED
%%%% ¡title!
RANDOMIZATION SEED

%%% ¡prop!
%%%% ¡id!
OrdMlBUT.ATTEMPTSPEREDGE
%%%% ¡title!
RANDOMIZATION ATTEMPTS PER EDGE

%%% ¡prop!
%%%% ¡id!
OrdMlBUT.A
%%%% ¡title!
Binary Undirected ADJACENCY MATRICES at fixed Thresholds

%%% ¡prop!
%%%% ¡id!
OrdMlBUT.PFGA
%%%% ¡title!
Adjacency Matrix Plot

%%% ¡prop!
%%%% ¡id!
OrdMlBUT.PFGH
%%%% ¡title!
Graph Histogram

%%% ¡prop!
%%%% ¡id!
OrdMlBUT.M_DICT
%%%% ¡title!
Graph MEASURES

%%% ¡prop!
%%%% ¡id!
OrdMlBUT.NOTES
%%%% ¡title!
Graph NOTES

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the ordinal multilayer binary undirected graph with fixed thresholds.
%%%% ¡default!
'OrdMlBUT'

%%% ¡prop!
NAME (constant, string) is the name of the ordinal multilayer binary undirected graph with fixed thresholds.
%%%% ¡default!
'Ordinal Multilayer Binary Undirected Graph at Fixed Thresholds'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the binary undirected multilayer with fixed thresholds.
%%%% ¡default!
'In an ordinal multilayer binary undirected graph with fixed thresholds (OrdMlBUT), layers consist of binary undirected multilayer graphs derived from the same weighted supra-connectivity matrices binarized at different thresholds. Layers within the binary undirected multilayer graphs could have different number of nodes with within-layer binary undirected edges. Edges can be either 0 (absence of connection) or 1 (existence of connection). The supra-connectivity matrix has a number of partitions equal to the number of thresholds. The layers are connected in an ordinal fashion, i.e., only consecutive layers are connected. On the diagonal of the supra adjacency matrix, matrices are symmetrized, dediagonalized, semipositivized, and binarized. On the off-diagonal of the supra adjacency matrix, matrices are semipositivized and binarized.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the ordinal multilayer binary undirected graph with fixed thresholds.
%%%% ¡settings!
'OrdMlBUT'

%%% ¡prop!
ID (data, string) is a few-letter code for the ordinal multilayer binary undirected graph with fixed thresholds.
%%%% ¡default!
'OrdMlBUT ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the ordinal multilayer binary undirected graph with fixed thresholds.
%%%% ¡default!
'OrdMlBUT label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the ordinal multilayer binary undirected graph with fixed thresholds.
%%%% ¡default!
'OrdMlBUT notes'

%%% ¡prop!
GRAPH_TYPE (constant, scalar) returns the graph type __Graph.ORDERED_MULTILAYER__.
%%%% ¡default!
Graph.ORDERED_MULTILAYER

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
A (result, cell) is the cell array containing the multilayer binary supra-adjacency matrices of the binary undirected multilayer. 
%%%% ¡calculate!
A_WU = calculateValue@OrdMlWU(g, prop);

thresholds = g.get('THRESHOLDS');
L = length(A_WU); % number of layers
A = cell(length(thresholds)*L);
if L > 0 && ~isempty(cell2mat(A_WU))
    for i = 1:1:length(A)
        if mod(i, L) == 0
            i_layer = L;
            i_threshold = thresholds(fix(i/L));
        else
            i_layer = mod(i, L);
            i_threshold = thresholds(fix(i/L)+1);
        end
        M = symmetrize(A_WU{i_layer, i_layer}, 'SymmetrizeRule', g.get('SYMMETRIZE_RULE')); %#ok<PROPLC> % enforces symmetry of adjacency matrix
        M = dediagonalize(M); % removes self-connections by removing diagonal from adjacency matrix, equivalent to dediagonalize(M, 'DediagonalizeRule', 0)
        M = semipositivize(M, 'SemipositivizeRule', g.get('SEMIPOSITIVIZE_RULE')); % removes negative weights
        M = binarize(M, 'threshold', i_threshold); % enforces binary adjacency matrix, equivalent to binarize(M, 'threshold', 0, 'bins', [-1:.001:1])
        A(i, i) = {M};
        for j = i+1:1:length(A)
            if mod(j, L) == 0
                j_layer = L;
                j_threshold = thresholds(fix(j/L));
            else
                j_layer = mod(j, L);
                j_threshold = thresholds(fix(j/L)+1);
            end
            if i_threshold == j_threshold && j == i + 1
                    M = semipositivize(A_WU{i_layer, j_layer}, 'SemipositivizeRule', g.get('SEMIPOSITIVIZE_RULE')); % removes negative weights
                    M = binarize(M, 'threshold', i_threshold, 'diagonal', 'include');
                    A(i, j) = {M};
                    M = semipositivize(A_WU{j_layer, i_layer}, 'SemipositivizeRule', g.get('SEMIPOSITIVIZE_RULE')); % removes negative weights
                    M = binarize(M, 'threshold', i_threshold, 'diagonal', 'include');
                    A(j, i) = {M};
            else
                A(i, j) = {zeros(size(A_WU{i_layer, i_layer}, 1), size(A_WU{j_layer, j_layer}, 2))};
                A(j, i) = {zeros(size(A_WU{j_layer, j_layer}, 2), size(A_WU{i_layer, i_layer}, 1))};
            end
        end
    end
end
if g.get('RANDOMIZE')
    A = g.get('RANDOMIZATION', A);
end
value = A;
%%%% ¡gui!
pr = PanelPropCell('EL', g, 'PROP', OrdMlBUT.A, ...
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
PARTITIONS (result, rvector) returns the number of layers for each partition (threshold) of the graph.
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
getCompatibleMeasures('OrdMlBUT')

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
pr = PanelPropRVectorSmart('EL', g, 'PROP', OrdMlBUT.THRESHOLDS, 'MAX', 1, 'MIN', -1, varargin{:});

%% ¡tests!

%%% ¡excluded_props!
[OrdMlBUT.PFGA OrdMlBUT.PFGH]

%%% ¡test!
%%%% ¡name!
Constructor - Full
%%%% ¡probability!
.01
%%%% ¡code!
B1 = rand(randi([2, 10]));
B2 = rand(randi([2, 10]));
B3 = rand(randi([2, 10]));
B12 = rand(size(B1, 1),size(B2, 2));
B13 = rand(size(B1, 1),size(B3, 2));
B23 = rand(size(B2, 1),size(B3, 2));
B = {
    B1                           B12                            B13
    B12'                         B2                             B23
    B13'                         B23'                           B3
    };
thresholds = [0 55 100];
g = OrdMlBUT('B', B, 'THRESHOLDS', thresholds); 
g.get('A_CHECK')
A = g.get('A');
L = length(B); % number of layers

for i = 1:1:length(A)
    if mod(i, L) == 0
        i_layer = L;
        i_threshold = thresholds(fix(i/L));
    else
        i_layer = mod(i, L);
        i_threshold = thresholds(fix(i/L)+1);
    end
    assert(isequal(A{i, i},binarize(symmetrize(dediagonalize(semipositivize(B{i_layer, i_layer}))), 'threshold', i_threshold)), ...
        [BRAPH2.STR ':OrdMlBUT:' BRAPH2.FAIL_TEST], ...
        'OrdMlBUT is not constructing well.')
    for j = i+1:1:length(A)
        if mod(j, L) == 0
            j_layer = L;
            j_threshold = thresholds(fix(j/L));
        else
            j_layer = mod(j, L);
            j_threshold = thresholds(fix(j/L)+1);
        end
        if i_threshold == j_threshold && j == i + 1
            assert(isequal(A{i, j}, binarize(semipositivize(B{i_layer, j_layer}), 'threshold', i_threshold, 'diagonal', 'include')), ...
                [BRAPH2.STR ':OrdMlBUT:' BRAPH2.FAIL_TEST], ...
                'OrdMlBUT is not constructing well.')
            assert(isequal(A{j, i}, binarize(semipositivize(B{j_layer, i_layer}), 'threshold', i_threshold, 'diagonal', 'include')), ...
                [BRAPH2.STR ':OrdMlBUT:' BRAPH2.FAIL_TEST], ...
                'OrdMlBUT is not constructing well.')
        else
            assert(isequal(A{i, j}, zeros(size(B{i_layer, i_layer}, 1), size(B{j_layer, j_layer}, 2))), ...
                [BRAPH2.STR ':OrdMlBUT:' BRAPH2.FAIL_TEST], ...
                'OrdMlBUT is not constructing well.')
            assert(isequal(A{j, i}, zeros(size(B{j_layer, j_layer}, 1), size(B{i_layer, i_layer}, 2))), ...
                [BRAPH2.STR ':OrdMlBUT:' BRAPH2.FAIL_TEST], ...
                'OrdMlBUT is not constructing well.')
        end
    end
end

%%% ¡test!
%%%% ¡name!
Randomize Rules
%%%% ¡probability!
.01
%%%% ¡code!
B1 = rand(randi([2, 10]));
B2 = rand(randi([2, 10]));
B3 = rand(randi([2, 10]));
B12 = rand(size(B1, 1),size(B2, 2));
B13 = rand(size(B1, 1),size(B3, 2));
B23 = rand(size(B2, 1),size(B3, 2));
B = {
    B1                           B12                            B13
    B12'                         B2                             B23
    B13'                         B23'                           B3
    };
thresholds = [0 55 100];
g = OrdMlBUT('B', B, 'THRESHOLDS', thresholds); 

g.set('RANDOMIZE', true);
g.set('ATTEMPTSPEREDGE', 4);
g.get('A_CHECK')

A = g.get('A');

assert(isequal(size(A{1}), size(B{1})), ...
    [BRAPH2.STR ':OrdMlBUT:' BRAPH2.FAIL_TEST], ...
    'OrdMlBUT Randomize is not functioning well.')

g2 = OrdMlBUT('B', B, 'THRESHOLDS', thresholds); 
g2.set('RANDOMIZE', false);
g2.set('ATTEMPTSPEREDGE', 4);
A2 = g2.get('A');
random_A = g2.get('RANDOMIZATION', A2);

for i = 1:length(A2)
    if all(A2{i, i}==0, "all") %if all nodes are zero, the random matrix is also all zeros
        assert(isequal(A2{i, i}, random_A{i, i}), ...
            [BRAPH2.STR ':OrdMlBUT:' BRAPH2.FAIL_TEST], ...
            'OrdMlBUT Randomize is not functioning well.')
    elseif isequal((length(A2{i, i}).^2)- length(A2{i, i}), sum(A2{i, i}==1, "all")) %if all nodes (except diagonal) are one, the random matrix is the same as original
        assert(isequal(A2{i, i}, random_A{i, i}), ...
            [BRAPH2.STR ':OrdMlBUT:' BRAPH2.FAIL_TEST], ...
            'OrdMlBUT Randomize is not functioning well.')
    else
%         assert(~isequal(A2{i, i}, random_A{i, i}), ...
%             [BRAPH2.STR ':OrdMlBUT:' BRAPH2.FAIL_TEST], ...
%             'OrdMlBUT Randomize is not functioning well.')
    end

    assert(isequal(numel(find(A2{i, i})), numel(find(random_A{i, i}))), ... % check same number of nodes
        [BRAPH2.STR ':OrdMlBUT:' BRAPH2.FAIL_TEST], ...
        'OrdMlBUT Randomize is not functioning well.')

    assert(issymmetric(random_A{i, i}), ... % check symmetry 
    [BRAPH2.STR ':OrdMlBUT:' BRAPH2.FAIL_TEST], ...
    'OrdMlBUT Randomize is not functioning well.')
end
