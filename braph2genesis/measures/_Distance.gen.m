%% ¡header!
Distance < Measure (m, distance) is the Distance.

%%% ¡description!
The Distance (Distance) of a graph is the shortest path between all pairs of nodes 
 within a layer of the graph.
For weighted graphs, the distance is calculated with the Dijkstra algorithm
 using the inverse weight as the distance associated to the edge.

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
Distance.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
Distance.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
Distance.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
Distance.M
%%%% ¡title!
Distance

%%% ¡prop!
%%%% ¡id!
Distance.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
Distance.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
Distance.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Distance.
%%%% ¡default!
'Distance'

%%% ¡prop!
NAME (constant, string) is the name of the Distance.
%%%% ¡default!
'Distance'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the Distance.
%%%% ¡default!
'The Distance (Distance) of a graph is the shortest path between all pairs of nodes within a layer of the graph. For weighted graphs, the distance is calculated with the Dijkstra algorithm using the inverse weight as the distance associated to the edge.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Distance.
%%%% ¡settings!
'Distance'

%%% ¡prop!
ID (data, string) is a few-letter code of the Distance.
%%%% ¡default!
'Distance ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Distance.
%%%% ¡default!
'Distance label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the Distance.
%%%% ¡default!
'Distance notes'

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
{'GraphBD' 'GraphBU' 'GraphWD' 'GraphWU' 'MultigraphBUD' 'MultigraphBUT' 'MultiplexBD' 'MultiplexBU' 'MultiplexWD' 'MultiplexWU' 'MultiplexBUD' 'MultiplexBUT' 'OrdMxBD' 'OrdMxBUD' 'OrdMxBU' 'OrdMxWD' 'OrdMxWU' 'OrdMxBUT' 'MultilayerWD' 'MultilayerBD' 'MultilayerWU' 'OrdMlWD' 'OrdMlWU' 'OrdMlBD' 'MultilayerBUT' 'MultilayerBU' 'MultilayerBUD' 'OrdMlBU' 'OrdMlBUD' 'OrdMlBUT'};

%%% ¡prop!
M (result, cell) is the Distance.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)

distance = cell(g.get('LAYERNUMBER'), 1);
connectivity_type =  g.get('CONNECTIVITY_TYPE', g.get('LAYERNUMBER'));
connectivity_type = diag(connectivity_type);
Aii_tmp = {};
for li = 1:1:g.get('LAYERNUMBER')
    Aii_tmp{li} = A{li, li}; %#ok<AGROW>
end
for li = 1:1:g.get('LAYERNUMBER')
    Aii = Aii_tmp{li};
    connectivity_layer = connectivity_type(li);

    if connectivity_layer == Graph.WEIGHTED  % weighted graphs
        distance(li) = {getWeightedCalculation(Aii)};
    else  % binary graphs
        distance(li) = {getBinaryCalculation(Aii)};
    end
end

value = distance;
%%%% ¡calculate_callbacks!
function weighted_distance = getWeightedCalculation(A)
    %GETWEIGHTEDCALCULATION calculates the distance value of a weighted adjacency matrix.
    %
    % WEIGHTED_DISTANCE = GETWEIGHTEDCALCULATION(A) returns the value of the
    %  distance of a weighted adjacency matrix A.

    ind = A~=0;
    A(ind) = A(ind).^-1;
    n = length(A);
    D = inf(n);
    D(1:n+1:end) = 0; % distance matrix

    for u = 1:n
        S = true(1, n); % distance permanence (true is temporary)
        L1 = A;
        V = u;

        while 1
            S(V) = 0; % distance u->V is now permanent
            L1(:, V) = 0; % no in-edges as already shortest

            for v = V
                T = find(L1(v, :)); % neighbors of shortest nodes
                [d, ~] = min([D(u, T);D(u, v)+L1(v, T)]);
                D(u, T) = d; % smallest of old/new path lengths
                % ind = T(wi==2); % indices of lengthened paths
            end

            minD = min(D(u, S));
            if isempty(minD) || isinf(minD) % isempty: all nodes reached;
                break % isinf: some nodes cannot be reached
            end

            V = find(D(u,:)==minD);
        end
    end
    weighted_distance = D;
end
function binary_distance = getBinaryCalculation(A)
    %GETBINARYCALCULATION calculates the distance value of a binary adjacency matrix.
    %
    % BINARY_DISTANCE = GETBINARYCALCULATION(A) returns the value of the
    %  distance of a binary adjacency matrix A.

    l = 1; % path length
    D = A; % distance matrix

    Lpath = A;
    Idx = true;
    while any(Idx(:))
        l = l+1;
        Lpath = Lpath * A;
        Idx = (Lpath ~= 0) & (D == 0);
        D(Idx) = l;
    end

    D(~D) = inf; % assign inf to disconnected nodes
    binary_distance = dediagonalize(D); % assign 0 to the diagonal
end     

%% ¡tests!

%%% ¡excluded_props!
[Distance.PFM]

%%% ¡test!
%%%% ¡name!
GraphBD
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0   1	1   1   0
    1	0   0   0   0
    1   1   0   1   0
    1   1   0   0   0
    0	0   0   0   0
    ];

known_distance = {[
    0   1   1   1   Inf
    1   0   2   2   Inf
    1   1   0   1   Inf
    1   1   2   0   Inf
    Inf Inf Inf Inf 0
    ]};

g = GraphBD('B', B);

m_outside_g = Distance('G', g);
assert(isequal(m_outside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Distance');
assert(isequal(m_inside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
GraphBU
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0	1   1	1   0
    1   0   0   1   0
    1   0   0   1   0
    1   1   1   0   0
    0	0	0   0   0
    ];

known_distance = {[
    0   1   1   1   Inf
    1   0   2   1   Inf
    1   2   0   1   Inf
    1   1   1   0   Inf
    Inf Inf Inf Inf 0
    ]};

g = GraphBU('B', B);

m_outside_g = Distance('G', g);
assert(isequal(m_outside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Distance');
assert(isequal(m_inside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
GraphWD
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0     .1  .2  .25  0
    .125  0   0   0    0
    .2    .5  0   .25  0
    .125  10   0   0   0
    0     0   0   0    0
    ];

known_distance = {[
    0   5   5   4   Inf
    8   0   13  12  Inf
    5   2   0   4   Inf
    8   1   13  0   Inf
    Inf Inf Inf Inf 0
    ]};

g = GraphWD('B', B);

m_outside_g = Distance('G', g);
assert(isequal(m_outside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Distance');
assert(isequal(m_inside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
GraphWU
%%%% ¡probability!
.01
%%%% ¡code!
B = [0 0.1 0;
     0.1 0 0.2;
     0 0.2 0];

known_distance = {[0	10	15
                  10     0 	5
                  15	 5	0]};

g = GraphWU('B', B);

m_outside_g = Distance('G', g);
assert(isequal(m_outside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Distance');
assert(isequal(m_inside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultigraphBUD
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0   .2   .7
    .2   0   .1
    .7  .1   0
    ];

densities = [0 33 67 100];

known_distance = {
    [
    0   Inf Inf
    Inf 0   Inf
    Inf Inf 0    
    ]
    [
    0   Inf 1
    Inf 0   Inf
    1   Inf 0
    ]
    [
    0   1   1
    1   0   2
    1   2   0
    ]
    [
    0   1   1
    1   0   1
    1   1   0
    ]
    };

g = MultigraphBUD('B', B, 'DENSITIES', densities);

m_outside_g = Distance('G', g);
assert(isequal(m_outside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Distance');
assert(isequal(m_inside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultigraphBUT
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0   .2   .7
    .2   0   0
    .7   0   0
    ];

thresholds = [0 .5 1];

known_distance = {
    [
    0   1   1
    1   0   2
    1   2   0
    ]
    [
    0   Inf 1
    Inf 0   Inf
    1 Inf 0
    ]
    [
    0   Inf Inf
    Inf 0   Inf
    Inf Inf 0
    ]
    };

g = MultigraphBUT('B', B, 'THRESHOLDS', thresholds);

m_outside_g = Distance('G', g);
assert(isequal(m_outside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Distance');
assert(isequal(m_inside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBD
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0	1   1   1   0;
    1   0   0   0	0; 
    1   1   0   1   0;
    1	1   0   0   0;
    0   0   0   0   0;
    ];
B22 = [
    0	1   1   1   0;
    1   0   0   0	0; 
    1   1   0   1   0;
    1	1   0   0   0;
    0   0   0   0   0;
    ];
B = {B11 B22};
known_distance = {
    [
    0   1   1   1   Inf;
    1   0   2   2   Inf;
    1   1   0   1   Inf;
    1   1   2   0   Inf;
    Inf Inf Inf Inf 0;
    ]
    [
    0   1   1   1   Inf;
    1   0   2   2   Inf;
    1   1   0   1   Inf;
    1   1   2   0   Inf;
    Inf Inf Inf Inf 0;
    ]
    };

g = MultiplexBD('B', B);

m_outside_g = Distance('G', g);
assert(isequal(m_outside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Distance');
assert(isequal(m_inside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBU
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0	1   1  0    0;
    1   0   0  0	0; 
    1   1   0   1   0;
    1	1   0   0   0;
    0   0   0   0   0;
    ];
B22 = [
    0   1   1   1   0; 
    1   0   0   0   0;
    1   1   0   1   0;
    1   1   0   0   0;
    0   0   0   0   0;
    ];
B = {B11 B22};

known_distance = {
    [
    0   1   1   1   Inf;
    1   0   1   1   Inf;
    1   1   0   1   Inf;
    1   1   1   0   Inf;
    Inf Inf Inf Inf 0;
    ]
    [
    0   1   1   1   Inf;
    1   0   1   1   Inf;
    1   1   0   1   Inf;
    1   1   1   0   Inf;
    Inf Inf Inf Inf 0;
    ]
    };

g = MultiplexBU('B', B);

m_outside_g = Distance('G', g);
assert(isequal(m_outside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Distance');
assert(isequal(m_inside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexWD
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0       .1  .2  .25  0;
    .125    0   0   0    0;
    .2      .5  0   .25  0;
    .125    10  0   0    0;
    0       0   0   0    0;
    ];
B22 = [
    0       .1  .2  .25  0;
    .125    0   0   0    0;
    .2      .5  0   .25  0;
    .125    10  0   0    0;
    0       0   0   0    0;
    ];
B = {B11 B22};

known_distance = {
    [
    0   5   5   4   Inf;
    8   0   13  12  Inf;
    5   2   0   4   Inf;
    8   1   13  0   Inf;
    Inf Inf Inf Inf 0;
    ]
    [
    0   5   5   4   Inf;
    8   0   13  12  Inf;
    5   2   0   4   Inf;
    8   1   13  0   Inf;
    Inf Inf Inf Inf 0;
    ]
    };

g = MultiplexWD('B', B);

m_outside_g = Distance('G', g);
assert(isequal(m_outside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Distance');
assert(isequal(m_inside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexWU
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0       .1  .2  .25  0;
    .125    0   0   0    0;
    .2      .5  0   .25  0;
    .125    10  0   0    0;
    0       0   0   0    0;
    ];
B22 = [
    0       .1  .2  .25  0;
    .125    0   0   0    0;
    .2      .5  0   .25  0;
    .125    10  0   0    0;
    0       0   0   0    0;
    ];
B = {B11 B22};

known_distance = {
    [
    0   5   5   4   Inf;
    5   0   2   1   Inf;
    5   2   0   3   Inf;
    4   1   3   0   Inf;
    Inf Inf Inf Inf 0;
	]
    [
    0   5   5   4   Inf;
    5   0   2   1   Inf;
    5   2   0   3   Inf;
    4   1   3   0   Inf;
    Inf Inf Inf Inf 0;
	]
    };

g = MultiplexWU('B', B);

m_outside_g = Distance('G', g);
assert(isequal(m_outside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Distance');
assert(isequal(m_inside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBUD
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0   .2   .7
    .2   0   .1
    .7  .1   0
    ];

densities = [0 33 67 100];

known_distance = {
    [
    0   Inf Inf
    Inf 0   Inf
    Inf Inf 0    
    ]
    [
    0   Inf Inf
    Inf 0   Inf
    Inf Inf 0    
    ]
    [
    0   Inf Inf
    Inf 0   Inf
    Inf Inf 0    
    ]
    [
    0   Inf 1
    Inf 0   Inf
    1   Inf 0
    ]
    [
    0   Inf 1
    Inf 0   Inf
    1   Inf 0
    ]
    [
    0   Inf 1
    Inf 0   Inf
    1   Inf 0
    ]
    [
    0   1   1
    1   0   2
    1   2   0
    ]
    [
    0   1   1
    1   0   2
    1   2   0
    ]
    [
    0   1   1
    1   0   2
    1   2   0
    ]
    [
    0   1   1
    1   0   1
    1   1   0
    ]
    [
    0   1   1
    1   0   1
    1   1   0
    ]
    [
    0   1   1
    1   0   1
    1   1   0
    ]
    };

g = MultiplexBUD('B', {B B B}, 'DENSITIES', densities);

m_outside_g = Distance('G', g);
assert(isequal(m_outside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Distance');
assert(isequal(m_inside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBUT
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0   .2   .7
    .2   0   0
    .7   0   0
    ];

thresholds = [0 .5 1];

known_distance = {
    [
    0   1   1
    1   0   2
    1   2   0
    ]
    [
    0   1   1
    1   0   2
    1   2   0
    ]
    [
    0   1   1
    1   0   2
    1   2   0
    ]
    [
    0   Inf 1
    Inf 0   Inf
    1 Inf 0
    ]
    [
    0   Inf 1
    Inf 0   Inf
    1 Inf 0
    ]
    [
    0   Inf 1
    Inf 0   Inf
    1 Inf 0
    ]
    [
    0   Inf Inf
    Inf 0   Inf
    Inf Inf 0
    ]
    [
    0   Inf Inf
    Inf 0   Inf
    Inf Inf 0
    ]
    [
    0   Inf Inf
    Inf 0   Inf
    Inf Inf 0
    ]
    };

g = MultiplexBUT('B', {B B B}, 'THRESHOLDS', thresholds);

m_outside_g = Distance('G', g);
assert(isequal(m_outside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Distance');
assert(isequal(m_inside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
OrdMxWU
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0       .1  .2  .25  0;
    .125    0   0   0    0;
    .2      .5  0   .25  0;
    .125    10  0   0    0;
    0       0   0   0    0;
    ];
B22 = [
    0       .1  .2  .25  0;
    .125    0   0   0    0;
    .2      .5  0   .25  0;
    .125    10  0   0    0;
    0       0   0   0    0;
    ];
B = {B11 B22};

known_distance = {
    [
    0   5   5   4   Inf;
    5   0   2   1   Inf;
    5   2   0   3   Inf;
    4   1   3   0   Inf;
    Inf Inf Inf Inf 0;
	]
    [
    0   5   5   4   Inf;
    5   0   2   1   Inf;
    5   2   0   3   Inf;
    4   1   3   0   Inf;
    Inf Inf Inf Inf 0;
	]
    };

g = OrdMxWU('B', B);

m_outside_g = Distance('G', g);
assert(isequal(m_outside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Distance');
assert(isequal(m_inside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
OrdMxWD
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0       .1  .2  .25  0;
    .125    0   0   0    0;
    .2      .5  0   .25  0;
    .125    10  0   0    0;
    0       0   0   0    0;
    ];
B22 = [
    0       .1  .2  .25  0;
    .125    0   0   0    0;
    .2      .5  0   .25  0;
    .125    10  0   0    0;
    0       0   0   0    0;
    ];
B = {B11 B22};

known_distance = {
    [
    0   5   5   4   Inf;
    8   0   13  12  Inf;
    5   2   0   4   Inf;
    8   1   13  0   Inf;
    Inf Inf Inf Inf 0;
    ]
    [
    0   5   5   4   Inf;
    8   0   13  12  Inf;
    5   2   0   4   Inf;
    8   1   13  0   Inf;
    Inf Inf Inf Inf 0;
    ]
    };

g = OrdMxWD('B', B);

m_outside_g = Distance('G', g);
assert(isequal(m_outside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Distance');
assert(isequal(m_inside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
OrdMxBD
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0	1   1   1   0;
    1   0   0   0	0; 
    1   1   0   1   0;
    1	1   0   0   0;
    0   0   0   0   0;
    ];
B22 = [
    0	1   1   1   0;
    1   0   0   0	0; 
    1   1   0   1   0;
    1	1   0   0   0;
    0   0   0   0   0;
    ];
B = {B11 B22};
known_distance = {
    [
    0   1   1   1   Inf;
    1   0   2   2   Inf;
    1   1   0   1   Inf;
    1   1   2   0   Inf;
    Inf Inf Inf Inf 0;
    ]
    [
    0   1   1   1   Inf;
    1   0   2   2   Inf;
    1   1   0   1   Inf;
    1   1   2   0   Inf;
    Inf Inf Inf Inf 0;
    ]
    };

g = OrdMxBD('B', B);

m_outside_g = Distance('G', g);
assert(isequal(m_outside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Distance');
assert(isequal(m_inside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
OrdMxBU
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0	1   1  0    0;
    1   0   0  0	0; 
    1   1   0   1   0;
    1	1   0   0   0;
    0   0   0   0   0;
    ];
B22 = [
    0   1   1   1   0; 
    1   0   0   0   0;
    1   1   0   1   0;
    1   1   0   0   0;
    0   0   0   0   0;
    ];
B = {B11 B22};

known_distance = {
    [
    0   1   1   1   Inf;
    1   0   1   1   Inf;
    1   1   0   1   Inf;
    1   1   1   0   Inf;
    Inf Inf Inf Inf 0;
    ]
    [
    0   1   1   1   Inf;
    1   0   1   1   Inf;
    1   1   0   1   Inf;
    1   1   1   0   Inf;
    Inf Inf Inf Inf 0;
    ]
    };

g = OrdMxBU('B', B);

m_outside_g = Distance('G', g);
assert(isequal(m_outside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Distance');
assert(isequal(m_inside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
OrdMxBUT
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0   .2   .7
    .2   0   0
    .7   0   0
    ];

thresholds = [0 .5 1];

known_distance = {
    [
    0   1   1
    1   0   2
    1   2   0
    ]
    [
    0   1   1
    1   0   2
    1   2   0
    ]
    [
    0   1   1
    1   0   2
    1   2   0
    ]
    [
    0   Inf 1
    Inf 0   Inf
    1 Inf 0
    ]
    [
    0   Inf 1
    Inf 0   Inf
    1 Inf 0
    ]
    [
    0   Inf 1
    Inf 0   Inf
    1 Inf 0
    ]
    [
    0   Inf Inf
    Inf 0   Inf
    Inf Inf 0
    ]
    [
    0   Inf Inf
    Inf 0   Inf
    Inf Inf 0
    ]
    [
    0   Inf Inf
    Inf 0   Inf
    Inf Inf 0
    ]
    };

g = OrdMxBUT('B', {B B B}, 'THRESHOLDS', thresholds);

m_outside_g = Distance('G', g);
assert(isequal(m_outside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Distance');
assert(isequal(m_inside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
OrdMxBUD
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0   .2   .7
    .2   0   .1
    .7  .1   0
    ];

densities = [0 33 67 100];

known_distance = {
    [
    0   Inf Inf
    Inf 0   Inf
    Inf Inf 0    
    ]
    [
    0   Inf Inf
    Inf 0   Inf
    Inf Inf 0    
    ]
    [
    0   Inf Inf
    Inf 0   Inf
    Inf Inf 0    
    ]
    [
    0   Inf 1
    Inf 0   Inf
    1   Inf 0
    ]
    [
    0   Inf 1
    Inf 0   Inf
    1   Inf 0
    ]
    [
    0   Inf 1
    Inf 0   Inf
    1   Inf 0
    ]
    [
    0   1   1
    1   0   2
    1   2   0
    ]
    [
    0   1   1
    1   0   2
    1   2   0
    ]
    [
    0   1   1
    1   0   2
    1   2   0
    ]
    [
    0   1   1
    1   0   1
    1   1   0
    ]
    [
    0   1   1
    1   0   1
    1   1   0
    ]
    [
    0   1   1
    1   0   1
    1   1   0
    ]
    };

g = OrdMxBUD('B', {B B B}, 'DENSITIES', densities);

m_outside_g = Distance('G', g);
assert(isequal(m_outside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Distance');
assert(isequal(m_inside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultilayerWU
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0       .1  .2  .25  0  0;
    .125    0   0   0    0  0;
    .2      .5  0   .25  0  0;
    .125    10  0   0    0  0;
    0       0   0   0    0  0;
    0       0   0   0    0  0 
    ];
B22 = [
    0       .1  .2  .25  0;
    .125    0   0   0    0;
    .2      .5  0   .25  0;
    .125    10  0   0    0;
    0       0   0   0    0;
    ];
B12 = rand(size(B11,1),size(B22,2));
B21 = B12';
B= {B11 B12;
    B21 B22};

known_distance = {
    [
    0   5   5   4   Inf Inf;
    5   0   2   1   Inf Inf;
    5   2   0   3   Inf Inf;
    4   1   3   0   Inf Inf;
    Inf Inf Inf Inf 0   Inf;
    Inf Inf Inf Inf Inf   0;
	]
    [
    0   5   5   4   Inf;
    5   0   2   1   Inf;
    5   2   0   3   Inf;
    4   1   3   0   Inf;
    Inf Inf Inf Inf 0;
	]
    };

g = MultilayerWU('B', B);

m_outside_g = Distance('G', g);
assert(isequal(m_outside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Distance');
assert(isequal(m_inside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
OrdMlWU
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0       .1  .2  .25  0  0;
    .125    0   0   0    0  0;
    .2      .5  0   .25  0  0;
    .125    10  0   0    0  0;
    0       0   0   0    0  0;
    0       0   0   0    0  0 
    ];
B22 = [
    0       .1  .2  .25  0;
    .125    0   0   0    0;
    .2      .5  0   .25  0;
    .125    10  0   0    0;
    0       0   0   0    0;
    ];
B12 = rand(size(B11, 1),size(B22, 2));
B21 = B12';
B= {B11 B12;
    B21 B22};

known_distance = {
    [
    0   5   5   4   Inf Inf;
    5   0   2   1   Inf Inf;
    5   2   0   3   Inf Inf;
    4   1   3   0   Inf Inf;
    Inf Inf Inf Inf 0   Inf;
    Inf Inf Inf Inf Inf   0;
	]
    [
    0   5   5   4   Inf;
    5   0   2   1   Inf;
    5   2   0   3   Inf;
    4   1   3   0   Inf;
    Inf Inf Inf Inf 0;
	]
    };

g = OrdMlWU('B', B);

m_outside_g = Distance('G', g);
assert(isequal(m_outside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Distance');
assert(isequal(m_inside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
OrdMlWD
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0       .1  .2  .25  0;
    .125    0   0   0    0;
    .2      .5  0   .25  0;
    .125    10  0   0    0;
    0       0   0   0    0;
    ];
B22 = [
    0       .1  .2  .25  0;
    .125    0   0   0    0;
    .2      .5  0   .25  0;
    .125    10  0   0    0;
    0       0   0   0    0;
    ];

B12 = rand(size(B11,1),size(B22,2));
B21 = B12';
B= {B11 B12;
    B21 B22};

known_distance = {
    [
    0   5   5   4   Inf;
    8   0   13  12  Inf;
    5   2   0   4   Inf;
    8   1   13  0   Inf;
    Inf Inf Inf Inf 0;
    ]
    [
    0   5   5   4   Inf;
    8   0   13  12  Inf;
    5   2   0   4   Inf;
    8   1   13  0   Inf;
    Inf Inf Inf Inf 0;
    ]
    };

g = OrdMlWD('B', B);

m_outside_g = Distance('G', g);
assert(isequal(m_outside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Distance');
assert(isequal(m_inside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultilayerBUT
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0    0.6
    0.6  0
    ];
B22 = [
    0   .2   .7
    .2   0   0
    .7   0   0
    ];
B33 = [
    0   1   0  .2
    1   0   .3  .1
    0  .3   0   0
   .2  .1   0   0
    ];

thresholds = [0 .5 1];

known_distance = {
    [
    0   1
    1   0
    ]
    [
    0   1   1
    1   0   2
    1   2   0
    ]
    [
    0   1   2  1
    1   0   1  1
    2   1   0  2
    1   1   2  0
    ]
    [
    0   1
    1   0
    ]
    [
    0   Inf 1
    Inf 0   Inf
    1 Inf 0
    ]
    [
    0   1   Inf  Inf
    1   0   Inf  Inf
    Inf Inf 0    Inf
    Inf Inf Inf 0
    ]
    [
    0   Inf
    Inf 0
    ]
    [
    0   Inf Inf
    Inf 0   Inf
    Inf Inf 0
    ]
    [
    0   Inf Inf Inf
    Inf 0   Inf Inf
    Inf Inf 0   Inf
    Inf Inf Inf 0
    ]
    };

B12 = rand(size(B11,1),size(B22,2));
B13 = rand(size(B11,1),size(B33,2));
B23 = rand(size(B22,1),size(B33,2));
B21 = B12';
B32 = B23';
B31 = B13';

B= {B11 B12 B13;
    B21 B22 B23;
    B31 B32 B33};

g = MultilayerBUT('B', B, 'THRESHOLDS', thresholds);

m_outside_g = Distance('G', g);
assert(isequal(m_outside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Distance');
assert(isequal(m_inside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
OrdMlBD
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0	1   1   1   0;
    1   0   0   0	0; 
    1   1   0   1   0;
    1	1   0   0   0;
    0   0   0   0   0;
    ];
B22 = [
    0	1   1   1   0;
    1   0   0   0	0; 
    1   1   0   1   0;
    1	1   0   0   0;
    0   0   0   0   0;
    ];
B12 = rand(size(B11,1),size(B22,2));
B21 = B12';
B= {B11 B12;
    B21 B22};
known_distance = {
    [
    0   1   1   1   Inf;
    1   0   2   2   Inf;
    1   1   0   1   Inf;
    1   1   2   0   Inf;
    Inf Inf Inf Inf 0;
    ]
    [
    0   1   1   1   Inf;
    1   0   2   2   Inf;
    1   1   0   1   Inf;
    1   1   2   0   Inf;
    Inf Inf Inf Inf 0;
    ]
    };

g = OrdMlBD('B', B);

m_outside_g = Distance('G', g);
assert(isequal(m_outside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Distance');
assert(isequal(m_inside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultilayerBU
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0	1	1	0	0	0;
    1	0	0	0	0	0; 
    1	1	0	1	0	0;
    1	1	0	0   0	0;
    0	0	0	0   0	0;
    0	0	0	0   0	0;
    ];
B22 = [
    0	1 	1	1	0;
    1	0	0	0	0; 
    1	1	0	1	0;
    1	1	0	0	0;
    0	0	0	0	0;
    ];
B12 = rand(size(B11,1),size(B22,2));
B21 = B12';
B= {B11 B12;
    B21 B22};
known_distance = {
    [
    0   1   1   1   Inf   Inf;
    1   0   1   1   Inf   Inf;
    1   1   0   1   Inf   Inf;
    1   1   1   0   Inf   Inf;
    Inf Inf Inf Inf 0   Inf;
    Inf Inf Inf Inf Inf  0;
    ]
    [
    0   1   1   1   Inf;
    1   0   1   1   Inf;
    1   1   0   1   Inf;
    1   1   1   0   Inf;
    Inf Inf Inf Inf 0;
    ]
    };

g = MultilayerBU('B', B);

m_outside_g = Distance('G', g);
assert(isequal(m_outside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Distance');
assert(isequal(m_inside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultilayerBUD
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0   .2   .7
    .2   0   .1
    .7  .1   0
    ];

B22 = [    
    0   .2   .7 .5
    .2   0   .1 .5
    .7  .1   0  .5
    .5  .5  .5  0
    ];
B12 = rand(size(B11,1),size(B22,2));
B21 = B12';
B= {B11 B12;
    B21 B22};
densities = [0 33 67 100];

known_distance = {
    [
    0   Inf Inf
    Inf 0   Inf
    Inf Inf 0    
    ]
    [
    0   Inf Inf Inf
    Inf 0   Inf Inf
    Inf Inf 0   Inf
    Inf Inf Inf 0
    ]
    [
    0   Inf 1
    Inf 0   Inf
    1 Inf 0    
    ]
    [
    0 Inf 1 Inf
    Inf 0 Inf Inf
    1 Inf 0 Inf
    Inf Inf Inf 0
    ]
    [
    0	1	1
    1	0	2
    1   2	0
    ]
    [
    0 2 1 1
    2 0 2 1
    1 2 0 1
    1 1 1 0
    ]
    [
    0 1 1
    1 0 1
    1 1 0
    ]
    [
    0 1 1 1
    1 0 1 1
    1 1 0 1
    1 1 1 0
    ]
    };

g = MultilayerBUD('B', B, 'DENSITIES', densities);

m_outside_g = Distance('G', g);
assert(isequal(m_outside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Distance');
assert(isequal(m_inside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
OrdMlBU
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0	1   1   0   0   0;
    1   0   0   0	0   0; 
    1   1   0   1   0   0;
    1	1   0   0   0   0;
    0   0   0   0   0   0;
    0   0   0   0   0   0;
    ];
B22 = [
    0	1   1   1   0;
    1   0   0   0	0; 
    1   1   0   1   0;
    1	1   0   0   0;
    0   0   0   0   0;
    ];
B12 = rand(size(B11,1),size(B22,2));
B21 = B12';
B= {B11 B12;
    B21 B22};
known_distance = {
    [
    0   1   1   1   Inf   Inf;
    1   0   1   1   Inf   Inf;
    1   1   0   1   Inf   Inf;
    1   1   1   0   Inf   Inf;
    Inf Inf Inf Inf 0   Inf;
    Inf Inf Inf Inf Inf  0;
    ]
    [
    0   1   1   1   Inf;
    1   0   1   1   Inf;
    1   1   0   1   Inf;
    1   1   1   0   Inf;
    Inf Inf Inf Inf 0;
    ]
    };

g = OrdMlBU('B', B);

m_outside_g = Distance('G', g);
assert(isequal(m_outside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Distance');
assert(isequal(m_inside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
OrdMlBUD
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0   .2   .7
    .2   0   .1
    .7  .1   0
    ];

B22 = [    
    0   .2   .7 .5
    .2   0   .1 .5
    .7  .1   0  .5
    .5  .5  .5  0
    ];
B12 = rand(size(B11,1),size(B22,2));
B21 = B12';
B= {B11 B12;
    B21 B22};
densities = [0 33 67 100];

known_distance = {
    [
    0   Inf Inf
    Inf 0   Inf
    Inf Inf 0    
    ]
    [
    0   Inf Inf Inf
    Inf 0   Inf Inf
    Inf Inf 0   Inf
    Inf Inf Inf 0
    ]
    [
    0   Inf 1
    Inf 0   Inf
    1 Inf 0    
    ]
    [
    0 Inf 1 Inf
    Inf 0 Inf Inf
    1 Inf 0 Inf
    Inf Inf Inf 0
    ]
    [
    0	1	1
    1	0	2
    1   2	0
    ]
    [
    0 2 1 1
    2 0 2 1
    1 2 0 1
    1 1 1 0
    ]
    [
    0 1 1
    1 0 1
    1 1 0
    ]
    [
    0 1 1 1
    1 0 1 1
    1 1 0 1
    1 1 1 0
    ]
    };

g = OrdMlBUD('B', B, 'DENSITIES', densities);

m_outside_g = Distance('G', g);
assert(isequal(m_outside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Distance');
assert(isequal(m_inside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
OrdMlBUT
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0   .2   .7
    .2   0   .1
    .7  .1   0
    ];

B22 = [    
    0   .2   .7 .5
    .2   0   .1 .5
    .7  .1   0  .5
    .5  .5  .5  0
    ];
B12 = rand(size(B11,1),size(B22,2));
B21 = B12';
B= {B11 B12;
    B21 B22};

thresholds = [0 .5 1];

known_distance = {
    [
    0   1   1
    1   0   1
    1   1   0
    ]
    [
    0   1   1	1
    1   0   1   1
    1   1   0   1
    1   1   1   0
    ]
    [
    0   Inf 1
    Inf 0   Inf
    1 Inf 0
    ]
    [
    0 Inf 1 Inf
    Inf 0 Inf Inf
    1 Inf 0 Inf
    Inf Inf Inf 0
    ]
    [
    0  Inf  Inf
    Inf  0  Inf
    Inf  Inf  0
    ]
    [
    0 Inf Inf Inf
    Inf 0 Inf Inf
    Inf Inf 0 Inf
    Inf Inf Inf 0
    ]
    };

g = OrdMlBUT('B', B, 'THRESHOLDS', thresholds);

m_outside_g = Distance('G', g);
assert(isequal(m_outside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Distance');
assert(isequal(m_inside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])