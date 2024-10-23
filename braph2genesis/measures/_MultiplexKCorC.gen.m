%% ¡header!
MultiplexKCorC < Measure (m, multiplex k-coreness centrality) is the graph Multiplex K-Coreness Centrality.

%%% ¡description!
The Multiplex K-Coreness Centrality (MultiplexKCorC) of a node is k if the node belongs to the k-core 
but not to the (k+1)-core.

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
MultiplexKCorC.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
MultiplexKCorC.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
MultiplexKCorC.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
MultiplexKCorC.M
%%%% ¡title!
Multiplex K-Coreness Centrality

%%% ¡prop!
%%%% ¡id!
MultiplexKCorC.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
MultiplexKCorC.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
MultiplexKCorC.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Multiplex K-Coreness Centrality.
%%%% ¡default!
'MultiplexKCorC'

%%% ¡prop!
NAME (constant, string) is the name of the Multiplex K-Coreness Centrality.
%%%% ¡default!
'Multiplex K-Coreness Centrality'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the Multiplex K-Coreness Centrality.
%%%% ¡default!
'The Multiplex K-Coreness Centrality (MultiplexKCorC) of a node is k if the node belongs to the k-core but not to the (k+1)-core.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Multiplex K-Coreness Centrality.
%%%% ¡settings!
'MultiplexKCorC'

%%% ¡prop!
ID (data, string) is a few-letter code of the Multiplex K-Coreness Centrality.
%%%% ¡default!
'MultiplexKCorC ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Multiplex K-Coreness Centrality.
%%%% ¡default!
'Multiplex K-Coreness Centrality label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the Multiplex K-Coreness Centrality.
%%%% ¡default!
'Multiplex K-Coreness Centrality notes'

%%% ¡prop!
SHAPE (constant, scalar) is the measure shape __Measure.NODAL__.
%%%% ¡default!
Measure.NODAL

%%% ¡prop!
SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.
%%%% ¡default!
Measure.SUPERGLOBAL

%%% ¡prop!
PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.
%%%% ¡default!
Measure.NONPARAMETRIC

%%% ¡prop!
COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
%%%% ¡default!
{'MultiplexWU' 'MultiplexWD' 'MultiplexBU' 'MultiplexBD' 'OrdMxWU'};

%%% ¡prop!
M (result, cell) is the Multiplex K-Coreness Centrality.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
l = g.get('LAYERNUMBER');
ls = g.get('PARTITIONS');  


if l == 0
    value = {};
else
    N = g.get('NODENUMBER');
    multiplex_k_coreness_centrality = cell(length(ls), 1);
    directionality_layer = g.get('DIRECTIONALITY_TYPE', l);
    for i = 1:1:length(ls)
        A_sum = zeros(N(1), N(1));
        for j = 1:1:length(l)
            A_sum = A_sum + A{j, j};
        end
        multiplex_coreness = zeros(1, N(1));
        for k = 1:N(1)
            m_k_core = calculate_multiplexkcore(A_sum, k, directionality_layer);
            ss = sum(m_k_core) > 0;
            multiplex_coreness(ss) = k;
        end
        multiplex_k_coreness_centrality(i) = {multiplex_coreness'};
    end
    value = multiplex_k_coreness_centrality;
end
%%%% ¡calculate_callbacks!
function m_k_core = calculate_multiplexkcore(A, k, directionality_layer)
    % CALCULATE MKCORE calculates the multiplex k-core value of a supra-adjacency matrix
    %
    % MKCORE = CALCULATEMULTIPLEXKCORE(M, A, k, directionality_layer) returns
    % the value of the multiplex k-core of a supra-adjacency matrix
    
    iter = 0;
    subAii = binarize(A);
    while 1
        % get degrees of matrix
        if directionality_layer == Graph.UNDIRECTED  % undirected graphs
            ovdeg = sum(subAii, 1)';  % degree undirected graphs
        else
            ovdeg = (sum(subAii, 1)' + sum(subAii, 2));  % degree directed
        end
    
        % find nodes with degree < k
        low_k_nodes = find((ovdeg < k) & (ovdeg > 0));
    
        % if none found -> stop
        if (isempty(low_k_nodes)) break; end; %#ok<SEPEX>
    
        % peel away found nodes
        iter = iter + 1;
        subAii(low_k_nodes, :) = 0;
        subAii(:, low_k_nodes) = 0;
    end
    m_k_core = subAii;  % add k-core of layer li
end

%% ¡tests!

%%% ¡excluded_props!
[MultiplexKCorC.PFM]

%%% ¡test!
%%%% ¡name!
MultiplexWU
%%%% ¡probability!
.01
%%%% ¡code!
A11 = [
    0   .1  1  0; 
    .1  0   1  .8; 
    1   1   0  0;
    0   .8  0  0
    ];

A22 = [
    0   .1  1  0; 
    .1  0   1  .8; 
    1   1   0  0;
    1   .8  0  0
    ];
A = {A11 A22};
             
known_multiplexk_coreness_centrality = {
    [2 2 2 1]'
    };

g = MultiplexWU('B', A);
m_outside_g = MultiplexKCorC('G', g);

assert(isequal(m_outside_g.get('M'), known_multiplexk_coreness_centrality), ...
    [BRAPH2.STR ':MultiplexKCorC:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'MultiplexKCorC');
assert(isequal(m_inside_g.get('M'), known_multiplexk_coreness_centrality), ...
    [BRAPH2.STR ':MultiplexKCorC:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBD
%%%% ¡probability!
.01
%%%% ¡code!
A11 = [
    0  1  1  1; 
    1  0  1  1; 
    1  1  0  0;
    0  1  0  0
    ];

A22 = [
    0  1  1  1; 
    1  0  1  1; 
    1  1  0  0;
    0  1  1  0
    ];
A = {A11 A22};

known_multiplexk_coreness_centrality = {
    [4 4 4 3]'
    };

g = MultiplexBD('B', A);
m_outside_g = MultiplexKCorC('G', g);

assert(isequal(m_outside_g.get('M'), known_multiplexk_coreness_centrality), ...
    [BRAPH2.STR ':MultiplexKCorC:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'MultiplexKCorC');
assert(isequal(m_inside_g.get('M'), known_multiplexk_coreness_centrality), ...
    [BRAPH2.STR ':MultiplexKCorC:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
OrdMxWU
%%%% ¡probability!
.01
%%%% ¡code!
A11 = [
    0   .1  1  0; 
    .1  0   1  .8; 
    1   1   0  0;
    0   .8  0  0
    ];

A22 = [
    0   .1  1  0; 
    .1  0   1  .8; 
    1   1   0  0;
    1   .8  0  0
    ];
A = {A11 A22};
             
known_multiplexk_coreness_centrality = {
    [2 2 2 1]'
    };

g = OrdMxWU('B', A);
m_outside_g = MultiplexKCorC('G', g);

assert(isequal(m_outside_g.get('M'), known_multiplexk_coreness_centrality), ...
    [BRAPH2.STR ':MultiplexKCorC:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'MultiplexKCorC');
assert(isequal(m_inside_g.get('M'), known_multiplexk_coreness_centrality), ...
    [BRAPH2.STR ':MultiplexKCorC:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])