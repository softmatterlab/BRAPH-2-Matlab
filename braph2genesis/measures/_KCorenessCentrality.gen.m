%% ¡header!
KCorenessCentrality < Measure (m, k-coreness centrality) is the graph K-Coreness Centrality.

%%% ¡description!
The K-Coreness Centrality (KCorenessCentrality) of a node is k if the node belongs to the k-core 
but not to the (k+1)-core.

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
KCorenessCentrality.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
LocalEfficiency.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
KCorenessCentrality.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
KCorenessCentrality.M
%%%% ¡title!
K-Coreness Centrality

%%% ¡prop!
%%%% ¡id!
KCorenessCentrality.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
KCorenessCentrality.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
KCorenessCentrality.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the K-Coreness Centrality.
%%%% ¡default!
'KCorenessCentrality'

%%% ¡prop!
NAME (constant, string) is the name of the K-Coreness Centrality.
%%%% ¡default!
'K-Coreness Centrality'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the K-Coreness Centrality.
%%%% ¡default!
'The K-Coreness Centrality (KCorenessCentrality) of a node is k if the node belongs to the k-core but not to the (k+1)-core.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the K-Coreness Centrality.
%%%% ¡settings!
'KCorenessCentrality'

%%% ¡prop!
ID (data, string) is a few-letter code of the K-Coreness Centrality.
%%%% ¡default!
'KCorenessCentrality ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the K-Coreness Centrality.
%%%% ¡default!
'K-Coreness Centrality label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the K-Coreness Centrality.
%%%% ¡default!
'K-Coreness Centrality notes'

%%% ¡prop!
SHAPE (constant, scalar) is the measure shape __Measure.NODAL__.
%%%% ¡default!
Measure.NODAL

%%% ¡prop!
SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.
%%%% ¡default!
Measure.UNILAYER

%%% ¡prop!
PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.
%%%% ¡default!
Measure.NONPARAMETRIC

%%% ¡prop!
COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
%%%% ¡default!
{'GraphWU' 'GraphBU' 'GraphWD' 'GraphBD' 'MultigraphBUD' 'MultigraphBUT' 'MultiplexWU' 'MultiplexBU' 'MultiplexWD' 'MultiplexBD' 'MultiplexBUD' 'MultiplexBUT'};

%%% ¡prop!
M (result, cell) is the K-Coreness Centrality.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
L = g.get('LAYERNUMBER');
N = g.get('NODENUMBER');

k_coreness_centrality = cell(L, 1);
directionality_type =  g.get('DIRECTIONALITY_TYPE', L);

for li = 1:1:L
    Aii = A{li, li};
    directionality_layer = directionality_type(li, li);

    coreness = zeros(1, N(1));
    for k = 1:N(1)
        k_core = calculate_kcore(Aii, k, directionality_layer);
        ss = sum(k_core) > 0;
        coreness(ss) = k;
    end
    k_coreness_centrality(li) = {coreness'};
end
value = k_coreness_centrality;

%%%% ¡calculate_callbacks!
function k_core = calculate_kcore(A, k, directionality_layer)
% CALCULATEKCORE calculates the k-core value of an adjacency matrix
%
% KCORE = CALCULATEKCORE(M, A, k, directionality_layer) returns
% the value of the k-core of an adjacency matrix

iter = 0;
subAii = binarize(A);
while 1
    % get degrees of matrix
    if directionality_layer == Graph.UNDIRECTED  % undirected graphs
        deg = sum(subAii, 1)';  % degree undirected graphs
    else
        deg = (sum(subAii, 1)' + sum(subAii, 2));  % degree directed
    end
    
    % find nodes with degree < k
    low_k_nodes = find((deg < k) & (deg > 0));
    
    % if none found -> stop
    if (isempty(low_k_nodes)) break; end; %#ok<SEPEX>
    
    % peel away found nodes
    iter = iter + 1;
    subAii(low_k_nodes, :) = 0;
    subAii(:, low_k_nodes) = 0;
end
k_core = subAii;  % add k-core of layer li
end


%% ¡tests!

%%% ¡excluded_props!
[KCorenessCentrality.PFM]

%%% ¡test!
%%%% ¡name!
GraphBU
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0  1  1  0; 
    1  0  1  1; 
    1  1  0  0;
    0  1  0  0
    ];

known_k_coreness_centrality = {[2 2 2 1]'};

g = GraphBU('B', B);

m_outside_g = KCorenessCentrality('G', g);
assert(isequal(m_outside_g.get('M'), known_k_coreness_centrality), ...
    [BRAPH2.STR ':KCorenessCentrality:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'KCorenessCentrality');
assert(isequal(m_inside_g.get('M'), known_k_coreness_centrality), ...
    [BRAPH2.STR ':KCorenessCentrality:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
GraphWD
%%%% ¡probability!
.01
%%%% ¡code!
B =  [
    0   1   1  .1;
    .2  0   1  1;
    1   1   0  0;
    0   .3  0  0
    ];

known_k_coreness_centrality = {[4 4 4 3]'};

g = GraphWD('B', B);

m_outside_g = KCorenessCentrality('G', g);
assert(isequal(m_outside_g.get('M'), known_k_coreness_centrality), ...
    [BRAPH2.STR ':KCorenessCentrality:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'KCorenessCentrality');
assert(isequal(m_inside_g.get('M'), known_k_coreness_centrality), ...
    [BRAPH2.STR ':KCorenessCentrality:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBD
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

known_k_coreness_centrality = {
                        [4 4 4 3]'
                        [4 4 4 4]'
                        };

g = MultiplexBD('B', A);
m_outside_g = KCorenessCentrality('G', g);
assert(isequal(m_outside_g.get('M'), known_k_coreness_centrality), ...
    [BRAPH2.STR ':KCorenessCentrality:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'KCorenessCentrality');
assert(isequal(m_inside_g.get('M'), known_k_coreness_centrality), ...
    [BRAPH2.STR ':KCorenessCentrality:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexWU
%%%% ¡code!
A11 = [
    0   .1  1  0; 
    .1  0   1  .8; 
    1   1   0  0;
    0   .8  0  0
    ];

A22 = [
    0   .1  1  1; 
    .1  0   1  .8; 
    1   1   0  0;
    1   .8  0  0
    ];
A = {A11 A22};
             
known_k_coreness_centrality = {
                        [2 2 2 1]'
                        [2 2 2 2]'
                        };        

g = MultiplexWU('B', A);
m_outside_g = KCorenessCentrality('G', g);
assert(isequal(m_outside_g.get('M'), known_k_coreness_centrality), ...
    [BRAPH2.STR ':KCorenessCentrality:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'KCorenessCentrality');
assert(isequal(m_inside_g.get('M'), known_k_coreness_centrality), ...
    [BRAPH2.STR ':KCorenessCentrality:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])
