%% ¡header!
EdgeBetwCentr < Measure (m, edge betweenness centrality) is the Edge Betweenness Centrality.

%%% ¡description!
The Edge Betweenness Centrality (EdgeBetwCentr) of a graph is the fraction of all shortest paths in the 
graph that pass through a given edge within a layer. Edges with high values 
of betweenness centrality participate in a large number of shortest paths.

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
EdgeBetwCentr.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
EdgeBetwCentr.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
EdgeBetwCentr.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
EdgeBetwCentr.M
%%%% ¡title!
Edge Betweenness Centrality

%%% ¡prop!
%%%% ¡id!
EdgeBetwCentr.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
EdgeBetwCentr.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
EdgeBetwCentr.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Edge Betweenness Centrality.
%%%% ¡default!
'EdgeBetwCentr'

%%% ¡prop!
NAME (constant, string) is the name of the Edge Betweenness Centrality.
%%%% ¡default!
'Edge Betweenness Centrality'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the Edge Betweenness Centrality.
%%%% ¡default!
'The Edge Betweenness Centrality (EdgeBetwCentr) of a graph is the fraction of all shortest paths in the graph that pass through a given edge within a layer. Edges with high values of betweenness centrality participate in a large number of shortest paths.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Edge Betweenness Centrality.
%%%% ¡settings!
'EdgeBetwCentr'

%%% ¡prop!
ID (data, string) is a few-letter code of the Edge Betweenness Centrality.
%%%% ¡default!
'EdgeBetwCentr ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Edge Betweenness Centrality.
%%%% ¡default!
'Edge Betweenness Centrality label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the Edge Betweenness Centrality.
%%%% ¡default!
'Edge Betweenness Centrality notes'

%%% ¡prop!
SHAPE (constant, scalar) is the measure shape __Measure.BINODAL__.
%%%% ¡default!
Measure.BINODAL

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
{'GraphBD' 'GraphBU' 'GraphWD' 'GraphWU' 'MultigraphBUD' 'MultigraphBUT' 'MultiplexBD' 'MultiplexBU' 'MultiplexWD' 'MultiplexWU' 'MultiplexBUD' 'MultiplexBUT'};

%%% ¡prop!
M (result, cell) is the Edge Betweenness Centrality.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
L = g.get('LAYERNUMBER');

edgebetweennesscentrality = cell(L, 1);
connectivity_type =  g.get('CONNECTIVITY_TYPE', L);
for li = 1:L    
    Aii = A{li, li};
    connectivity_layer = connectivity_type(li, li);   
    
    if connectivity_layer == Graph.WEIGHTED  % weighted graphs
        edge_betweenness_centrality_layer = getWeightedCalculation(Aii);
    else  % binary graphs
        edge_betweenness_centrality_layer = getBinaryCalculation(Aii);
    end
    edgebetweennesscentrality(li) = {edge_betweenness_centrality_layer};
end

value = edgebetweennesscentrality;
%%%% ¡calculate_callbacks!
function binary_edge_betweenness_centrality = getBinaryCalculation(A)
% GETBINARYCALCULATION calculates the edge betweenness centrality value of a binary adjacency matrix
%
% BINARY_EDGE_BETWEENNESS_CENTRALITY = GETBINARYCALCULATION(m, A) returns the value
% of the edge betweenness centrality of a binary adjacency matrix A.

n = length(A);
BC = zeros(n,1);  % vertex betweenness
EBC = zeros(n);  % edge betweenness
for u=1:n
    D = false(1, n); D(u) = 1;  % distance from u
    NP = zeros(1, n); NP(u) = 1;  % number of paths from u
    P = false(n);  % predecessors
    Q = zeros(1, n); q = n;  % order of non-increasing distance
    Gu = A;
    V = u;
    while V
        Gu(:, V) = 0;  % remove remaining in-edges
        for v = V
            Q(q) = v; q = q-1;
            W = find(Gu(v, :));  % neighbors of v
            for w = W
                if D(w)
                    NP(w) = NP(w) + NP(v);  % NP(u->w) sum of old and new
                    P(w, v) = 1;  % v is a predecessor
                else
                    D(w) = 1;
                    NP(w) = NP(v);  % NP(u->w) = NP of new path
                    P(w, v) = 1;  % v is a predecessor
                end
            end
        end
        V = find(any(Gu(V, :), 1));
    end
    if ~all(D)  % if some vertices unreachable,
        Q(1:q) = find(~D);  % ...these are first-in-line
    end
    DP = zeros(n, 1);  % dependency
    for w=Q(1:n-1)
        BC(w) = BC(w) + DP(w);
        for v = find(P(w, :))
            DPvw = (1+DP(w)).*NP(v)./NP(w);
            DP(v) = DP(v) + DPvw;
            EBC(v, w) = EBC(v, w) + DPvw;
        end
    end
end
binary_edge_betweenness_centrality = EBC;
binary_edge_betweenness_centrality(isnan(binary_edge_betweenness_centrality)) = 0;  % Should return zeros, not NaN
end
function weighted_edge_betweenness_centrality = getWeightedCalculation(A)
% GETWEIGHTEDCALCULATION calculates the edge betweenness centrality value of a weighted adjacency matrix
%
% WEIGHTED_EDGE_BETWEENNESS_CENTRALITY  = GETWEIGHTEDCALCULATION(m, A)
% returns the value of the edge betweenness centrality of a weighted
% adjacency matrix A.

n = length(A);
BC = zeros(n,1);  % vertex betweenness
EBC = zeros(n);  % edge betweenness
for u=1:n
    D = inf(1, n); D(u) = 0;  % distance from u
    NP = zeros(1, n); NP(u) = 1;  % number of paths from u
    S = true(1, n);  % distance permanence (true is temporary)
    P = false(n);  % predecessors
    Q = zeros(1, n); q = n;  % order of non-increasing distance
    G1 = A;
    V = u;
    while 1
        S(V) = 0;  % distance u->V is now permanent
        G1(:, V) = 0;  % no in-edges as already shortest
        for v = V
            Q(q) = v; q = q-1;
            W = find(G1(v, :));  % neighbors of v
            for w = W
                Duw = D(v) + G1(v, w);  % path length to be tested
                if Duw < D(w)  % if new u->w shorter than old
                    D(w) = Duw;
                    NP(w) = NP(v);  % NP(u->w) = NP of new path
                    P(w,: ) = 0;
                    P(w, v) = 1;  % v is the only predecessor
                elseif Duw == D(w)  % if new u->w equal to old
                    NP(w) = NP(w) + NP(v);  % NP(u->w) sum of old and new
                    P(w, v) = 1;  % v is also a predecessor
                end
            end
        end
        minD = min(D(S));
        if isempty(minD), break  % all nodes reached, or
        elseif isinf(minD)  % ...some cannot be reached:
            Q(1:q) = find(isinf(D)); break	 % ...these are first-in-line
        end
        V = find(D == minD);
    end
    DP=zeros(n, 1);  % dependency
    for w = Q(1:n-1)
        BC(w) = BC(w) + DP(w);
        for v = find(P(w,:))
            DPvw = (1+DP(w)).*NP(v)./NP(w);
            DP(v) = DP(v) + DPvw;
            EBC(v, w) = EBC(v, w) + DPvw;
        end
    end
end
weighted_edge_betweenness_centrality = EBC;
weighted_edge_betweenness_centrality(isnan(weighted_edge_betweenness_centrality)) = 0;  % Should return zeros, not NaN
end

%% ¡tests!

%%% ¡excluded_props!
[EdgeBetwCentr.PFM]

%%% ¡test!
%%%% ¡name!
GraphBU
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0 1 1; 
    1 0 0; 
    1 0 0
    ];

known_edge_betweenness_centrality = {[
    0 2 2;
    2 0 0;
    2 0 0
    ]};

g = GraphBU('B', B);

m_outside_g = EdgeBetwCentr('G', g);
assert(isequal(m_outside_g.get('M'), known_edge_betweenness_centrality), ...
    [BRAPH2.STR ':EdgeBetwCentr:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'EdgeBetwCentr');
assert(isequal(m_inside_g.get('M'), known_edge_betweenness_centrality), ...
    [BRAPH2.STR ':EdgeBetwCentr:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
GraphBD
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0 1 0; 
    1 0 0; 
    1 0 0
    ];

known_edge_betweenness_centrality = {[
    0 2 0;
    1 0 0;
    2 0 0
    ]};

g = GraphBD('B', B);

m_outside_g = EdgeBetwCentr('G', g);
assert(isequal(m_outside_g.get('M'), known_edge_betweenness_centrality), ...
    [BRAPH2.STR ':EdgeBetwCentr:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'EdgeBetwCentr');
assert(isequal(m_inside_g.get('M'), known_edge_betweenness_centrality), ...
    [BRAPH2.STR ':EdgeBetwCentr:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBU
%%%% ¡probability!
.01
%%%% ¡code!
A11 = [
    0   1   1
    1   0   0
    1   0   0
    ];
A22 = [
    0   1   0
    1   0   1
    0   1   0
    ];
A = {A11 A22};

known_edge_betweenness_centrality = {[
    0 2 2;
    2 0 0;
    2 0 0
    ]
    [
    0 2 0;
    2 0 2;
    0 2 0
    ]};

g = MultiplexBU('B', A);

m_outside_g = EdgeBetwCentr('G', g);
assert(isequal(m_outside_g.get('M'), known_edge_betweenness_centrality), ...
    [BRAPH2.STR ':EdgeBetwCentr:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'EdgeBetwCentr');
assert(isequal(m_inside_g.get('M'), known_edge_betweenness_centrality), ...
    [BRAPH2.STR ':EdgeBetwCentr:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexWD
%%%% ¡probability!
.01
%%%% ¡code!
A11 = [
    0   1   0
    1   0   0
    4   0   0
    ];

A22 = [
    0   1   0
    1   0   0
    0   4   0
    ];
A = {A11 A22};
known_edge_betweenness_centrality = {[
    0 2 0;
    1 0 0;
    2 0 0
    ]
    [
    0 1 0;
    2 0 0;
    0 2 0
    ]};

g = MultiplexWD('B', A);

m_outside_g = EdgeBetwCentr('G', g);
assert(isequal(m_outside_g.get('M'), known_edge_betweenness_centrality), ...
    [BRAPH2.STR ':EdgeBetwCentr:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'EdgeBetwCentr');
assert(isequal(m_inside_g.get('M'), known_edge_betweenness_centrality), ...
    [BRAPH2.STR ':EdgeBetwCentr:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])