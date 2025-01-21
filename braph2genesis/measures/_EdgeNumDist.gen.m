%% ¡header!
EdgeNumDist < Measure (m, edge number distance) is the Edge Number Distance.

%%% ¡description!
The Edge Number Distance (EdgeNumDist) of a graph is the number of edges in the shortest 
weighted path between two nodes within a layer.

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
EdgeNumDist.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
EdgeNumDist.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
EdgeNumDist.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
EdgeNumDist.M
%%%% ¡title!
Edge Number Distance

%%% ¡prop!
%%%% ¡id!
EdgeNumDist.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
EdgeNumDist.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
EdgeNumDist.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Edge Number Distance.
%%%% ¡default!
'EdgeNumDist'

%%% ¡prop!
NAME (constant, string) is the name of the Edge Number Distance.
%%%% ¡default!
'Edge Number Distance'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the Edge Number Distance.
%%%% ¡default!
'The Edge Number Distance (EdgeNumDist) of a graph is the number of edges in the shortest weighted path between two nodes within a layer.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Edge Number Distance.
%%%% ¡settings!
'EdgeNumDist'

%%% ¡prop!
ID (data, string) is a few-letter code of the Edge Number Distance.
%%%% ¡default!
'EdgeNumDist ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Edge Number Distance.
%%%% ¡default!
'Edge Number Distance label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the Edge Number Distance.
%%%% ¡default!
'Edge Number Distance notes'

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
{'GraphWD' 'GraphWU' 'MultiplexWD' 'MultiplexWU'};

%%% ¡prop!
M (result, cell) is the Edge Number Distance.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
L = g.get('LAYERNUMBER');
edge_number_distance = cell(L, 1);

for li = 1:L
    Aii = A{li, li};
    edge_number_distance(li) = {getEdgeNumDistance(Aii)};
end

value = edge_number_distance;

%%%% ¡calculate_callbacks!
function edge_number_distance = getEdgeNumDistance(A)
    %GETEDGENUMBERDISTANCE calculates the edge distance number of a graph.
    
    ind = A~=0;
    A(ind) = A(ind).^-1;
    n = length(A);
    D = inf(n);
    D(1:n+1:end) = 0; % distance matrix
    B = zeros(n); % number of edges matrix
    
    for u = 1:n
        S = true(1, n); % distance permanence (true is temporary)
        L1 = A;
        V = u;
    
        while 1
            S(V) = 0; % distance u->V is now permanent
            L1(:, V) = 0; % no in-edges as already shortest
    
            for v = V
                T = find(L1(v, :)); % neighbors of shortest nodes
                [d, wi] = min([D(u, T);D(u, v)+L1(v, T)]);
                D(u, T) = d; % smallest of old/new path lengths
                ind = T(wi==2); % indices of lengthened paths
                B(u, ind) = B(u, v) + 1; % increment no. of edges in lengthened paths
            end
    
            minD = min(D(u, S));
            if isempty(minD) || isinf(minD) % isempty: all nodes reached;
                break % isinf: some nodes cannot be reached
            end
    
            V = find(D(u,:)==minD);
        end
    end
    edge_number_distance = B;
end

%% ¡tests!

%%% ¡excluded_props!
[EdgeNumDist.PFM]

%%% ¡test!
%%%% ¡name!
GraphWU
%%%% ¡probability!
.01
%%%% ¡code!
A = [
    0 .1 .2 .25 0;
    .125 0 0 0  0;
    .2 .5 0 .25 0;
    .125 10 0 0 0;
    0  0  0  0  0
    ];

known_value = {[
    0 2 1 1 0;
    2 0 1 1 0;
    1 1 0 2 0;
    1 1 2 0 0;
    0 0 0 0 0;
    ]};

g = GraphWU('B', A);

m_outside_g = EdgeNumDist('G', g);
assert(isequal(m_outside_g.get('M'), known_value), ...
    [BRAPH2.STR ':EdgeNumDist:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'EdgeNumDist');
assert(isequal(m_inside_g.get('M'), known_value), ...
    [BRAPH2.STR ':EdgeNumDist:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexWD
%%%% ¡probability!
.01
%%%% ¡code!
A11 = [
        0 .1 .2 .25 0;
        .125 0 0 0  0;
        .2 .5 0 .25 0;
        .125 10 0 0 0;
        0  0  0  0  0
       ];
A22 = [
        0 .1 .2 .25 0;
        .125 0 0 0  0;
        .2 .5 0 .25 0;
        .125 10 0 0 0;
        0  0  0  0  0
       ];
A = {A11 A22};

known_value = {[
    0 2 1 1 0;
    1 0 2 2 0;
    1 1 0 1 0;
    1 1 2 0 0;
    0 0 0 0 0;
    ]
    [
    0 2 1 1 0;
    1 0 2 2 0;
    1 1 0 1 0;
    1 1 2 0 0;
    0 0 0 0 0;
    ]};

g = MultiplexWD('B', A);

m_outside_g = EdgeNumDist('G', g);
assert(isequal(m_outside_g.get('M'), known_value), ...
    [BRAPH2.STR ':EdgeNumDist:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'EdgeNumDist');
assert(isequal(m_inside_g.get('M'), known_value), ...
    [BRAPH2.STR ':EdgeNumDist:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])