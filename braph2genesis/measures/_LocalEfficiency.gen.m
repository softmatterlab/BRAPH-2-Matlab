%% ¡header!
LocalEfficiency < Measure (m, local efficiency) is the graph Local Efficiency.

%%% ¡description!
The Local Efficiency (LocalEfficiency) is the average inverse shortest path length with 
  local nodes within each layer.

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
LocalEfficiency.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
LocalEfficiency.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
LocalEfficiency.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
LocalEfficiency.M
%%%% ¡title!
Local Efficiency

%%% ¡prop!
%%%% ¡id!
LocalEfficiency.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
LocalEfficiency.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
LocalEfficiency.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Local Efficiency.
%%%% ¡default!
'LocalEfficiency'

%%% ¡prop!
NAME (constant, string) is the name of the Local Efficiency.
%%%% ¡default!
'Local Efficiency'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the Local Efficiency.
%%%% ¡default!
'The Local Efficiency (LocalEfficiency) is the average inverse shortest path length with local nodes within each layer.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Local Efficiency.
%%%% ¡settings!
'LocalEfficiency'

%%% ¡prop!
ID (data, string) is a few-letter code of the Local Efficiency.
%%%% ¡default!
'LocalEfficiency ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Local Efficiency.
%%%% ¡default!
'Local Efficiency label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the Local Efficiency.
%%%% ¡default!
'Local Efficiency notes'

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
{'GraphWU' 'GraphBU' 'MultigraphBUD' 'MultigraphBUT' 'MultiplexWU' 'MultiplexBU' 'MultiplexBUD' 'MultiplexBUT'};

%%% ¡prop!
M (result, cell) is the Local Efficiency.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
L = g.get('LAYERNUMBER');
local_efficiency = cell(L, 1);
N = g.get('NODENUMBER');

for li = 1:L
    Aii = A{li, li};    
    local_efficiency_layer = zeros(N(li), 1);
    for i = 1:1:N(li)
        nodes = find(Aii(i, :)  | Aii(:, i).');  % neighbors of u
        if numel(nodes) > 1
           sub_graph_Aii = Aii(nodes, nodes);
           global_efficiency = global_Efficiency(sub_graph_Aii, g, li);
           local_efficiency_layer(i) = mean(global_efficiency);
        end
    end
    local_efficiency(li) = {local_efficiency_layer};
end

value = local_efficiency;
%%%% ¡calculate_callbacks!
function global_efficiency = global_Efficiency(A, g, li)
    N_A = length(A);
    distance = local_efficiency_distance(A, g, li);
    inverse_distance = distance.^-1;  % inverse distance
    inverse_distance(1:N_A+1:end) = 0;
    global_efficiency = (sum(inverse_distance, 2) / (N_A - 1));
end
function distance = local_efficiency_distance(A, g, li)
    connectivity_type =  g.get('CONNECTIVITY_TYPE', g.get('LAYERNUMBER'));
    connectivity_type = diag(connectivity_type);
    connectivity_layer = connectivity_type(li);
    if connectivity_layer == Graph.WEIGHTED  % weighted graphs
        distance = getWeightedCalculation(A);
    else  % binary graphs
        distance = getBinaryCalculation(A);
    end
end
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
[LocalEfficiency.PFM]

%%% ¡test!
%%%% ¡name!
GraphWU
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0   .2  .2  .1
    .2  0   .3  0
    .2  .3  0   .3
    .1  0   .3  0
    ];

known_local_efficiency = {round([1/4 1/5 .1222 1/5]', 3)};

g = GraphWU('B', B);

m_outside_g = LocalEfficiency('G', g);
tmp_val = m_outside_g.get('M');
assert(isequal(round(tmp_val{1}, 3), known_local_efficiency{1}), ...
    [BRAPH2.STR ':LocalEfficiency:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'LocalEfficiency');
tmp_val = m_inside_g.get('M');
assert(isequal(round(tmp_val{1}, 3), known_local_efficiency{1}), ...
    [BRAPH2.STR ':LocalEfficiency:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
GraphBU
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0  1  1  1
    1  0  1  0
    1  1  0  1
    1  0  1  0
    ];

known_local_efficiency = {[5/6 1 5/6 1]'};

g = GraphBU('B', B);

m_outside_g = LocalEfficiency('G', g);
assert(isequal(m_outside_g.get('M'), known_local_efficiency), ...
    [BRAPH2.STR ':LocalEfficiency:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'LocalEfficiency');
assert(isequal(m_inside_g.get('M'), known_local_efficiency), ...
    [BRAPH2.STR ':LocalEfficiency:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultigraphBUD
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0  1  1  1
    1  0  1  0
    1  1  0  1
    1  0  1  0
    ];

known_local_efficiency = {...
    [0   0 0   0]'
    [5/6 1 5/6 1]'
    };

densities = [10 90];
g = MultigraphBUD('B', B, 'DENSITIES', densities);

m_outside_g = LocalEfficiency('G', g);
assert(isequal(m_outside_g.get('M'), known_local_efficiency), ...
    [BRAPH2.STR ':LocalEfficiency:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'LocalEfficiency');
assert(isequal(m_inside_g.get('M'), known_local_efficiency), ...
    [BRAPH2.STR ':LocalEfficiency:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultigraphBUT
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0  1  1  1
    1  0  1  0
    1  1  0  1
    1  0  1  0
    ];

known_local_efficiency = {...
        [5/6 1 5/6 1]'
	    [0   0 0   0]'	    
	    };

thresholds = [0 1];
g = MultigraphBUT('B', B, 'THRESHOLDS', thresholds);

m_outside_g = LocalEfficiency('G', g);
assert(isequal(m_outside_g.get('M'), known_local_efficiency), ...
    [BRAPH2.STR ':LocalEfficiency:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'LocalEfficiency');
assert(isequal(m_inside_g.get('M'), known_local_efficiency), ...
    [BRAPH2.STR ':LocalEfficiency:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexWU
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0   .2  .2  .1
    .2  0   .3  0
    .2  .3  0   .3
    .1  0   .3  0
    ];
B22 = [
    0   .2  .2  .1
    .2  0   .3  0
    .2  .3  0   .3
    .1  0   .3  0
    ];
B = {B11 B22};

known_local_efficiency = {
    round([1/4 1/5 .1222 1/5]', 3)
    round([1/4 1/5 .1222 1/5]', 3)
    };

g = MultiplexWU('B', B);

m_outside_g = LocalEfficiency('G', g);
tmp_val = m_outside_g.get('M');
tmp_val = cellfun(@(x) round(x, 3), tmp_val, 'UniformOutput', false);
assert(isequal(tmp_val, known_local_efficiency), ...
    [BRAPH2.STR ':LocalEfficiency:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'LocalEfficiency');
tmp_val = m_inside_g.get('M');
tmp_val = cellfun(@(x) round(x, 3), tmp_val, 'UniformOutput', false);
assert(isequal(tmp_val, known_local_efficiency), ...
    [BRAPH2.STR ':LocalEfficiency:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBU
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0  1  1  1
    1  0  1  0
    1  1  0  1
    1  0  1  0
    ];

B22 = [
    0  1  1  1
    1  0  1  0
    1  1  0  1
    1  0  1  0
    ];
B = {B11 B22};

known_local_efficiency = {
    [5/6 1 5/6 1]'
    [5/6 1 5/6 1]'
    };

g = MultiplexBU('B', B);

m_outside_g = LocalEfficiency('G', g);
assert(isequal(m_outside_g.get('M'), known_local_efficiency), ...
    [BRAPH2.STR ':LocalEfficiency:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'LocalEfficiency');
assert(isequal(m_inside_g.get('M'), known_local_efficiency), ...
    [BRAPH2.STR ':LocalEfficiency:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBUD
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
       0  1  1  1
       1  0  1  0
       1  1  0  1
       1  0  1  0
      ];

B22 = [
       0  1  1  1
       1  0  1  0
       1  1  0  1
       1  0  1  0
      ];
B = {B11 B22};

known_local_efficiency = {                         
                         [0   0 0   0]'
                         [0   0 0   0]' 
                         [5/6 1 5/6 1]'
                         [5/6 1 5/6 1]'
                         };

g = MultiplexBUD('B', B, 'DENSITIES', [10 90]);

m_outside_g = LocalEfficiency('G', g);
assert(isequal(m_outside_g.get('M'), known_local_efficiency), ...
    [BRAPH2.STR ':LocalEfficiency:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'LocalEfficiency');
assert(isequal(m_inside_g.get('M'), known_local_efficiency), ...
    [BRAPH2.STR ':LocalEfficiency:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBUT
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
       0  1  1  1
       1  0  1  0
       1  1  0  1
       1  0  1  0
      ];

B22 = [
       0  1  1  1
       1  0  1  0
       1  1  0  1
       1  0  1  0
      ];
B = {B11 B22};

known_local_efficiency = {
                         [5/6 1 5/6 1]'
                         [5/6 1 5/6 1]'
                         [0   0 0   0]'
                         [0   0 0   0]'                         
                         };
thresholds = [0 1];
g = MultiplexBUT('B', B, 'THRESHOLDS', thresholds);

m_outside_g = LocalEfficiency('G', g);
assert(isequal(m_outside_g.get('M'), known_local_efficiency), ...
    [BRAPH2.STR ':LocalEfficiency:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'LocalEfficiency');
assert(isequal(m_inside_g.get('M'), known_local_efficiency), ...
    [BRAPH2.STR ':LocalEfficiency:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])
