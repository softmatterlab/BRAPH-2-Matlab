%% ¡header!
BetweennessCentrality < Measure (m, betweenness centrality) is the Betweenness Centrality.

%%% ¡description!
The Betweenness Centrality (BetweennessCentrality) of a graph is the fraction of all shortest paths in the 
graph that pass through a given node. Nodes with high values of betweenness 
centrality participate in a large number of shortest paths.

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
BetweennessCentrality.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
BetweennessCentrality.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
BetweennessCentrality.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
BetweennessCentrality.M
%%%% ¡title!
Betweenness Centrality

%%% ¡prop!
%%%% ¡id!
BetweennessCentrality.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
BetweennessCentrality.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
BetweennessCentrality.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Betweenness Centrality.
%%%% ¡default!
'BetweennessCentrality'

%%% ¡prop!
NAME (constant, string) is the name of the Betweenness Centrality.
%%%% ¡default!
'Betweenness Centrality'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the Betweenness Centrality.
%%%% ¡default!
'The Betweenness Centrality (BetweennessCentrality) of a graph is the fraction of all shortest paths in the graph that pass through a given node. Nodes with high values of betweenness centrality participate in a large number of shortest paths.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Betweenness Centrality.
%%%% ¡settings!
'BetweennessCentrality'

%%% ¡prop!
ID (data, string) is a few-letter code of the Betweenness Centrality.
%%%% ¡default!
'BetweennessCentrality ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Betweenness Centrality.
%%%% ¡default!
'Betweenness Centrality label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the Betweenness Centrality.
%%%% ¡default!
'Betweenness Centrality notes'

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
{'GraphBD' 'GraphBU' 'GraphWD' 'GraphWU' 'MultigraphBUD' 'MultigraphBUT' 'MultiplexBD' 'MultiplexBU' 'MultiplexWD' 'MultiplexWU' 'MultiplexBUD' 'MultiplexBUT' 'MultilayerWU' 'OrdMlWU'}

%%% ¡prop!
M (result, cell) is the cell containing Betweenness Centrality.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
L = g.get('LAYERNUMBER');
NN = g.get('NODENUMBER');

betweenness_centrality = cell(L, 1);
connectivity_layer =  g.get('CONNECTIVITY_TYPE', g.get('LAYERNUMBER'));

for li = 1:1:L
    Aii = A{li, li};

    if connectivity_layer == Graph.WEIGHTED  % weighted graphs
        betweenness_centrality_layer = getWeightedCalculation(Aii)/((NN(li)-1)*(NN(li)-2));  % Normalized betweenness centrality
        betweenness_centrality(li) = {betweenness_centrality_layer};
    else  % binary graphs
        betweenness_centrality_layer = getBinaryCalculation(Aii)/((NN(li)-1)*(NN(li)-2));  % Normalized betweenness centrality
        betweenness_centrality(li) = {betweenness_centrality_layer};
    end
end

value = betweenness_centrality;
%%%% ¡calculate_callbacks!
function weighted_betweenness_centrality = getWeightedCalculation(A)
    %GETWEIGHTEDCALCULATION calculates the distance value of a weighted adjacency matrix.
    %
    % WEIGHTED_DISTANCE = GETWEIGHTEDCALCULATION(M, A) returns the value of the
    %  distance of a weighted adjacency matrix A.

    N = size(A, 2);  % number of nodes
    E = find(A);
    A(E) = 1./A(E);  % invert weights
    weighted_betweenness_centrality = zeros(N, 1);  % init vertex betweenness
    
    % Compute the distances and number of
    % shortest paths between all pairs of vertices
    for u = 1:N  % One search for each source vertex u
        D = inf(1, N);
        D(u) = 0;  % distance from u
        NP = zeros(1, N);
        NP(u) = 1;  % number of paths from u
        S = true(1, N);  % distance permanence S (true is temporary)
        P = false(N);  % predecessors P
        Q = zeros(1, N);  % order of non-increasing distance
        q = N;
        G = A;  % graph G
        V = u;  % set of nodes (V) of graph G
        
        % Forward pass:
        % Compute the shortest paths
        % from the source u to all the other nodes in V
        while 1
            S(V) = 0;  % distance u->V is now permanent
            G(:,V) = 0;  % no in-edges as already shortest
            for v = V
                Q(q) = v;
                q = q-1;
                neighbors = find(G(v,:));  % neighbors of v
                for neighbor = neighbors
                    Duw = D(v) + G(v, neighbor);  % Duw path length to be tested
                    if Duw<D(neighbor)  % if new u->w shorter than old
                        D(neighbor) = Duw;
                        NP(neighbor) = NP(v);  % NP(u->w) = NP of new path
                        P(neighbor,:) = 0;
                        P(neighbor, v) = 1;  % v is the only predecessor
                    elseif Duw==D(neighbor)  % if new u->w equal to old
                        NP(neighbor) = NP(neighbor)+NP(v);  % NP(u->w) sum of old and new
                        P(neighbor, v) = 1;  % v is also a predecessor
                    end
                end
            end
            minD = min(D(S));  % shortest distance
            if isempty(minD), break  % all nodes reached, or
            elseif isinf(minD)  % some cannot be reached:
                Q(1:q) = find(isinf(D)); break  % ...these are first-in-line
            end
            V = find(D==minD);
        end
        
        % Compute dependencies (DP)
        DP = zeros(N, 1);
        for n = Q(1:N-1)
            weighted_betweenness_centrality(n) = weighted_betweenness_centrality(n)+DP(n);  % update betweenness
            for v = find(P(n,:))
                DP(v) = DP(v)+(1+DP(n)).*NP(v)./NP(n);  % dependency
            end
        end
    end
end
function binary_betweenness_centrality = getBinaryCalculation(A)
    %GETBINARYCALCULATION calculates the distance value of a binary adjacency matrix.
    %
    % BINARY_DISTANCE = GETBINARYCALCULATION(A) returns the value of the
    %  distance of a binary adjacency matrix A.
    
    N = size(A, 1);  % number of nodes
    I = eye(N)~=0;  % logical identity matrix
    d = 1;  % start path length d
    NPd = A;  % number of paths of length |d|
    NSPd = NPd;  % number of shortest paths of length |d|
    NSP = NSPd;  % number of shortest paths of any length
    NSP(I) = 1;
    L = NSPd;  % length of shortest paths
    L(I) = 1;
    
    % Forward pass: Compute the distance (L) and the number of
    % shortest paths (NSP) between all pairs
    % Compute Path Count:
    while find(NSPd, 1)
        d = d + 1;
        NPd = NPd*A;  % Index value corresponds to number of paths found of length d+1
        NSPd = NPd.*(L==0);
        NSP = NSP + NSPd;  % Add new found shortest paths
        L = L+d.*(NSPd~=0);  % Add new found shortest paths' distance
    end
    L(~L) = inf; L(I) = 0;  % Lenght for disconnected vertices is inf
    NSP(~NSP) = 1;  % NSP for disconnected vertices is 1
    
    % Backward pass: compute the dependencies (DP)
    DP = zeros(N);  % vertex on vertex dependency
    diam = d-1;  % graph diameter
    for d = diam:-1:2  % L == path_length_d is zero for path_length_d = diam
        DPd1 = (((L==d).*(1+DP)./NSP)*(A.')).*((L==(d-1)).*NSP);
        DP = DP + DPd1;  %DPd1: dependencies on vertices |d-1| from source
    end
    binary_betweenness_centrality = sum(DP, 1);  % compute betweenness
    binary_betweenness_centrality = binary_betweenness_centrality';
end         

%% ¡tests!

%%% ¡excluded_props!
[BetweennessCentrality.PFM]

%%% ¡test!
%%%% ¡name!
GraphBD
%%%% ¡probability!
.01
%%%% ¡code!
B_BU = [
    0 1 1;
    1 0 0;
    1 0 0
    ];

bc_BU = {[1, 0, 0]'};

g = GraphBD('B', B_BU);
m_outside_g = BetweennessCentrality('G', g);
assert(isequal(m_outside_g.get('M'), bc_BU), ...
    [BRAPH2.STR ':BetweennessCentrality:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'BetweennessCentrality');
assert(isequal(m_inside_g.get('M'), bc_BU), ...
    [BRAPH2.STR ':BetweennessCentrality:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
GraphBU
%%%% ¡probability!
.01
%%%% ¡code!
B_BU = [
    0 1 1;
    1 0 0;
    1 0 0
    ];

bc_BU = {[1, 0, 0]'};

g = GraphBU('B', B_BU);
m_outside_g = BetweennessCentrality('G', g);
assert(isequal(m_outside_g.get('M'), bc_BU), ...
    [BRAPH2.STR ':BetweennessCentrality:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'BetweennessCentrality');
assert(isequal(m_inside_g.get('M'), bc_BU), ...
    [BRAPH2.STR ':BetweennessCentrality:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
GraphWD
%%%% ¡probability!
.01
%%%% ¡code!
B_WU = [
    0 1 4; 
    1 0 0; 
    4 0 0 
    ];

bc_WU = {[1, 0, 0]'};

g = GraphWD('B', B_WU);

m_outside_g = BetweennessCentrality('G', g);

assert(isequal(m_outside_g.get('M'), bc_WU), ...
    [BRAPH2.STR ':BetweennessCentrality:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'BetweennessCentrality');
assert(isequal(m_inside_g.get('M'), bc_WU), ...
    [BRAPH2.STR ':BetweennessCentrality:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
GraphWU
%%%% ¡probability!
.01
%%%% ¡code!
B_WU = [
    0 1 4; 
    1 0 0; 
    4 0 0 
    ];

bc_WU = {[1, 0, 0]'}; 

g = GraphWU('B', B_WU);

m_outside_g = BetweennessCentrality('G', g);

assert(isequal(m_outside_g.get('M'), bc_WU), ...
    [BRAPH2.STR ':BetweennessCentrality:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'BetweennessCentrality');
assert(isequal(m_inside_g.get('M'), bc_WU), ...
    [BRAPH2.STR ':BetweennessCentrality:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultigraphBUD
%%%% ¡probability!
.01
%%%% ¡code!
B_WU = [
    0 1 4; 
    1 0 0; 
    4 0 0 
    ];
 
densities = [0 50 90];
g = MultigraphBUD('B', B_WU, 'DENSITIES', densities);

known_bc = {[0, 0, 0]'; [0, 0, 0]'; [1, 0, 0]'};

m_outside_g = BetweennessCentrality('G', g);

assert(isequal(m_outside_g.get('M'), known_bc), ...
    [BRAPH2.STR ':BetweennessCentrality:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'BetweennessCentrality');
assert(isequal(m_inside_g.get('M'), known_bc), ...
    [BRAPH2.STR ':BetweennessCentrality:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultigraphBUT
%%%% ¡probability!
.01
%%%% ¡code!
B_WU = [
    0 1 4; 
    1 0 0; 
    4 0 0 
    ];
 
thresholds = [0 1];
g = MultigraphBUT('B', B_WU, 'THRESHOLDS', thresholds);

known_bc = {[1, 0, 0]';  [0, 0, 0]'};

m_outside_g = BetweennessCentrality('G', g);

assert(isequal(m_outside_g.get('M'), known_bc), ...
    [BRAPH2.STR ':BetweennessCentrality:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'BetweennessCentrality');
assert(isequal(m_inside_g.get('M'), known_bc), ...
    [BRAPH2.STR ':BetweennessCentrality:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBD
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0   1   0
    1   0   0
    1   0   0
    ];
B22 = [
    0   1   0
    1   0   0
    0   1   0
    ];
B = {B11 B22};

known_betweenness_centrality = {
    [1/2 0   0]'
    [0   1/2 0]'
    };

g = MultiplexBD('B', B);

m_outside_g = BetweennessCentrality('G', g);
assert(isequal(m_outside_g.get('M'), known_betweenness_centrality), ...
    [BRAPH2.STR ':BetweennessCentrality:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'BetweennessCentrality');
assert(isequal(m_inside_g.get('M'), known_betweenness_centrality), ...
    [BRAPH2.STR ':BetweennessCentrality:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBU
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0   1   0
    1   0   0
    1   0   0
    ];
B22 = [
    0   1   0
    1   0   0
    0   1   0
    ];
B = {B11 B22};

known_betweenness_centrality = {
    [1 0   0]'
    [0   1 0]'
    };

g = MultiplexBU('B', B);

m_outside_g = BetweennessCentrality('G', g);
assert(isequal(m_outside_g.get('M'), known_betweenness_centrality), ...
    [BRAPH2.STR ':BetweennessCentrality:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'BetweennessCentrality');
assert(isequal(m_inside_g.get('M'), known_betweenness_centrality), ...
    [BRAPH2.STR ':BetweennessCentrality:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])


%%% ¡test!
%%%% ¡name!
MultiplexWD
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0   1   0
    1   0   0
    4   0   0
    ];
B22 = [
    0   1   0
    1   0   0
    0   4   0
    ];
B = {B11 B22};

known_betweenness_centrality = {
    [1/2 0   0]'
    [0   1/2 0]'
    };

g = MultiplexWD('B', B);
betweenness_centrality = BetweennessCentrality('G', g);
m_outside_g = BetweennessCentrality('G', g);
assert(isequal(m_outside_g.get('M'), known_betweenness_centrality), ...
    [BRAPH2.STR ':BetweennessCentrality:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'BetweennessCentrality');
assert(isequal(m_inside_g.get('M'), known_betweenness_centrality), ...
    [BRAPH2.STR ':BetweennessCentrality:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexWU
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0   1   0
    1   0   0
    4   0   0
    ];
B22 = [
    0   1   0
    1   0   0
    0   4   0
    ];
B = {B11 B22};

known_betweenness_centrality = {
    [1 0   0]'
    [0   1 0]'
    };

g = MultiplexWU('B', B);
betweenness_centrality = BetweennessCentrality('G', g);
m_outside_g = BetweennessCentrality('G', g);
assert(isequal(m_outside_g.get('M'), known_betweenness_centrality), ...
    [BRAPH2.STR ':BetweennessCentrality:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'BetweennessCentrality');
assert(isequal(m_inside_g.get('M'), known_betweenness_centrality), ...
    [BRAPH2.STR ':BetweennessCentrality:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBUD
%%%% ¡probability!
.01
%%%% ¡code!
B_WU1 = [
    0 1 4; 
    1 0 0; 
    4 0 0 
    ];
B_WU2 = [
    0 1 4; 
    1 0 0; 
    4 0 0 
    ];
B = {B_WU1 B_WU2};
 
densities = [0 50 90];
g = MultiplexBUD('B', B, 'DENSITIES', densities);

known_bc = {[0, 0, 0]'; [0, 0, 0]'; [0, 0, 0]'; [0, 0, 0]'; [1, 0, 0]'; [1, 0, 0]'};

m_outside_g = BetweennessCentrality('G', g);

assert(isequal(m_outside_g.get('M'), known_bc), ...
    [BRAPH2.STR ':BetweennessCentrality:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'BetweennessCentrality');
assert(isequal(m_inside_g.get('M'), known_bc), ...
    [BRAPH2.STR ':BetweennessCentrality:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBUT
%%%% ¡probability!
.01
%%%% ¡code!
B_WU1 = [
    0 1 4; 
    1 0 0; 
    4 0 0 
    ];
B_WU2 = [
    0 1 4; 
    1 0 0; 
    4 0 0 
    ];
B = {B_WU1 B_WU2};
 
thresholds = [0 1];
g = MultiplexBUT('B', B, 'THRESHOLDS', thresholds);

known_bc = {[1, 0, 0]'; [1, 0, 0]'; [0, 0, 0]'; [0, 0, 0]'};

m_outside_g = BetweennessCentrality('G', g);

assert(isequal(m_outside_g.get('M'), known_bc), ...
    [BRAPH2.STR ':BetweennessCentrality:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'BetweennessCentrality');
assert(isequal(m_inside_g.get('M'), known_bc), ...
    [BRAPH2.STR ':BetweennessCentrality:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])