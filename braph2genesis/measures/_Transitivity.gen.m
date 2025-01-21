%% ¡header!
Transitivity < Triangles (m, transitivity) is the graph Transitivity.

%%% ¡description!
The Transitivity (Transitivity) of a graph is the fraction of triangles to the number 
 of (unordered) triplets within a layer.

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
Transitivity.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
Transitivity.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
Transitivity.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
Transitivity.M
%%%% ¡title!
Transitivity

%%% ¡prop!
%%%% ¡id!
Transitivity.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
Transitivity.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
Transitivity.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Transitivity.
%%%% ¡default!
'Transitivity'

%%% ¡prop!
NAME (constant, string) is the name of the Transitivity.
%%%% ¡default!
'Transitivity'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the Transitivity.
%%%% ¡default!
'The Transitivity (Transitivity) of a graph is the fraction of triangles to the number of (unordered) triplets within a layer.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Transitivity.
%%%% ¡settings!
'Transitivity'

%%% ¡prop!
ID (data, string) is a few-letter code of the Transitivity.
%%%% ¡default!
'Transitivity ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Transitivity.
%%%% ¡default!
'Transitivity label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the Transitivity.
%%%% ¡default!
'Transitivity notes'

%%% ¡prop!
SHAPE (constant, scalar) is the measure shape __Measure.NODAL__.
%%%% ¡default!
Measure.GLOBAL

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
{'GraphWU' 'GraphWD' 'GraphBU' 'GraphBD' 'MultigraphBUD' 'MultigraphBUT' 'MultiplexWU' 'MultiplexWD' 'MultiplexBU' 'MultiplexBD' 'MultiplexBUD' 'MultiplexBUT' 'MultilayerWU' 'OrdMlWU'}

%%% ¡prop!
M (result, cell) is the Transitivity.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
L = g.get('LAYERNUMBER');

transitivity = cell(L, 1);
triangles = calculateValue@Triangles(m, prop);

directionality_type =  g.get('DIRECTIONALITY_TYPE', g.get('LAYERNUMBER'));

warning('off', 'MATLAB:remoteparfor:ParforWorkerAborted')
parfor li = 1:1:L      
    Aii = A{li, li};
    if directionality_type == Graph.UNDIRECTED  % undirected graphs
        
        degree = Degree('G', g).get('M');
        
        transitivity_layer = 2 * sum(triangles{li}) ./ sum((degree{li} .* (degree{li} - 1)));
        
    else  % directed graphs
        
        in_degree = DegreeIn('G', g).get('M');
        
        out_degree = DegreeOut('G', g).get('M');
        
        transitivity_layer = sum(triangles{li}) ./ sum(((out_degree{li} + in_degree{li}) .* (out_degree{li} + in_degree{li} - 1) - 2 * diag(Aii^2)));
    end
    transitivity_layer(isnan(transitivity_layer)) = 0;  % Should return zeros, not NaN
    transitivity(li) = {transitivity_layer};
end
warning('on', 'MATLAB:remoteparfor:ParforWorkerAborted')

value = transitivity;

%% ¡tests!

%%% ¡excluded_props!
[Transitivity.PFM]

%%% ¡test!
%%%% ¡name!
GraphWU
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0 1 1 1; 
    1 0 1 0; 
    1 1 0 1; 
    1 0 1 0
    ];

known_transitivity = {3/4};

g = GraphWU('B', B);
m_outside_g = Transitivity('G', g);

assert(isequal(m_outside_g.get('M'), known_transitivity), ...
    [BRAPH2.STR ':Transitivity:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Transitivity');
assert(isequal(m_inside_g.get('M'), known_transitivity), ...
    [BRAPH2.STR ':Transitivity:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
GraphWD
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0 1 1 1; 
    1 0 1 0; 
    1 1 0 1; 
    1 0 1 0
    ];

known_transitivity = {.1875};

g = GraphWD('B', B);
m_outside_g = Transitivity('G', g);

assert(isequal(m_outside_g.get('M'), known_transitivity), ...
    [BRAPH2.STR ':Transitivity:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Transitivity');
assert(isequal(m_inside_g.get('M'), known_transitivity), ...
    [BRAPH2.STR ':Transitivity:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
GraphBU
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0 1 1 1; 
    1 0 1 0; 
    1 1 0 1; 
    1 0 1 0
    ];

known_transitivity = {3/4};

g = GraphBU('B', B);
m_outside_g = Transitivity('G', g);

assert(isequal(m_outside_g.get('M'), known_transitivity), ...
    [BRAPH2.STR ':Transitivity:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Transitivity');
assert(isequal(m_inside_g.get('M'), known_transitivity), ...
    [BRAPH2.STR ':Transitivity:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
GraphBD
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0 1 1 1; 
    1 0 1 0; 
    1 1 0 1; 
    1 0 1 0
    ];

known_transitivity = {.1875};

g = GraphBD('B', B);
m_outside_g = Transitivity('G', g);

assert(isequal(m_outside_g.get('M'), known_transitivity), ...
    [BRAPH2.STR ':Transitivity:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Transitivity');
assert(isequal(m_inside_g.get('M'), known_transitivity), ...
    [BRAPH2.STR ':Transitivity:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultigraphBUD
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0 1 1 1; 
    1 0 1 0; 
    1 1 0 1; 
    1 0 1 0
    ];

known_transitivity = {0; 3/4};
densities = [33 90];

g = MultigraphBUD('B', B, 'DENSITIES', densities);
m_outside_g = Transitivity('G', g);

assert(isequal(m_outside_g.get('M'), known_transitivity), ...
    [BRAPH2.STR ':Transitivity:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Transitivity');
assert(isequal(m_inside_g.get('M'), known_transitivity), ...
    [BRAPH2.STR ':Transitivity:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultigraphBUT
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0 1 1 1; 
    1 0 1 0; 
    1 1 0 1; 
    1 0 1 0
    ];

known_transitivity = {3/4; 0};
thresholds = [0 1];

g = MultigraphBUT('B', B, 'THRESHOLDS', thresholds);
m_outside_g = Transitivity('G', g);

assert(isequal(m_outside_g.get('M'), known_transitivity), ...
    [BRAPH2.STR ':Transitivity:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Transitivity');
assert(isequal(m_inside_g.get('M'), known_transitivity), ...
    [BRAPH2.STR ':Transitivity:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexWU
%%%% ¡probability!
.01
%%%% ¡code!
A11 = [
      0 1 1 1;
      1 0 1 0;
      1 1 0 1;
      1 0 1 0
      ];
A22 = [
      0 1 1 1;
      1 0 1 0;
      1 1 0 1;
      1 0 1 0
      ];
A = {A11 A22};

known_transitivity = {
                 3/4
                 3/4
                 };      

g = MultiplexWU('B', A);
m_outside_g = Transitivity('G', g);

assert(isequal(m_outside_g.get('M'), known_transitivity), ...
    [BRAPH2.STR ':Transitivity:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Transitivity');
assert(isequal(m_inside_g.get('M'), known_transitivity), ...
    [BRAPH2.STR ':Transitivity:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexWD
%%%% ¡probability!
.01
%%%% ¡code!
A11 = [
      0 1 1 1;
      1 0 1 0;
      1 1 0 1;
      1 0 1 0
      ];
A22 = [
      0 1 1 1;
      1 0 1 0;
      1 1 0 1;
      1 0 1 0
      ];
A = {A11 A22};

known_transitivity = {
                 .1875
                 .1875
                 };      

g = MultiplexWD('B', A);
m_outside_g = Transitivity('G', g);

assert(isequal(m_outside_g.get('M'), known_transitivity), ...
    [BRAPH2.STR ':Transitivity:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Transitivity');
assert(isequal(m_inside_g.get('M'), known_transitivity), ...
    [BRAPH2.STR ':Transitivity:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBU
%%%% ¡probability!
.01
%%%% ¡code!
A11 = [
      0 1 1 1;
      1 0 1 0;
      1 1 0 1;
      1 0 1 0
      ];
A22 = [
      0 1 1 1;
      1 0 1 0;
      1 1 0 1;
      1 0 1 0
      ];
A = {A11 A22};

known_transitivity = {
                 3/4
                 3/4
                 };      

g = MultiplexBU('B', A);
m_outside_g = Transitivity('G', g);

assert(isequal(m_outside_g.get('M'), known_transitivity), ...
    [BRAPH2.STR ':Transitivity:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Transitivity');
assert(isequal(m_inside_g.get('M'), known_transitivity), ...
    [BRAPH2.STR ':Transitivity:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBD
%%%% ¡probability!
.01
%%%% ¡code!
A11 = [
      0 1 1 1;
      1 0 1 0;
      1 1 0 1;
      1 0 1 0
      ];
A22 = [
      0 1 1 1;
      1 0 1 0;
      1 1 0 1;
      1 0 1 0
      ];
A = {A11 A22};

known_transitivity = {
                 .1875
                 .1875
                 };      

g = MultiplexBD('B', A);
m_outside_g = Transitivity('G', g);

assert(isequal(m_outside_g.get('M'), known_transitivity), ...
    [BRAPH2.STR ':Transitivity:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Transitivity');
assert(isequal(m_inside_g.get('M'), known_transitivity), ...
    [BRAPH2.STR ':Transitivity:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBUD
%%%% ¡probability!
.01
%%%% ¡code!
A11 = [
      0 1 1 1;
      1 0 1 0;
      1 1 0 1;
      1 0 1 0
      ];
A22 = [
      0 1 1 1;
      1 0 1 0;
      1 1 0 1;
      1 0 1 0
      ];
A = {A11 A22};

densities = [33 90];

known_transitivity = {
    0
    0
    3/4
    3/4
    };

g = MultiplexBUD('B', A, 'DENSITIES', densities);
m_outside_g = Transitivity('G', g);

assert(isequal(m_outside_g.get('M'), known_transitivity), ...
    [BRAPH2.STR ':Transitivity:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Transitivity');
assert(isequal(m_inside_g.get('M'), known_transitivity), ...
    [BRAPH2.STR ':Transitivity:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBUT
%%%% ¡probability!
.01
%%%% ¡code!
A11 = [
      0 1 1 1;
      1 0 1 0;
      1 1 0 1;
      1 0 1 0
      ];
A22 = [
      0 1 1 1;
      1 0 1 0;
      1 1 0 1;
      1 0 1 0
      ];
A = {A11 A22};

thresholds = [0 1];

known_transitivity = {
    3/4
    3/4
    0
    0
    };

g = MultiplexBUT('B', A, 'THRESHOLDS', thresholds);
m_outside_g = Transitivity('G', g);

assert(isequal(m_outside_g.get('M'), known_transitivity), ...
    [BRAPH2.STR ':Transitivity:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Transitivity');
assert(isequal(m_inside_g.get('M'), known_transitivity), ...
    [BRAPH2.STR ':Transitivity:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultilayerWU
%%%% ¡probability!
.01
%%%% ¡code!
A11 = [
      0 1 1 1;
      1 0 1 0;
      1 1 0 1;
      1 0 1 0
      ];
A22 = [
      0 1 1 1;
      1 0 1 0;
      1 1 0 1;
      1 0 1 0
      ];
A12 = rand(size(A11,1),size(A22,2));
A21 = A12';
A = {A11 A12;
     A21 A22};

known_transitivity = {
                 3/4
                 3/4
                 };      

g = MultilayerWU('B', A);
m_outside_g = Transitivity('G', g);

assert(isequal(m_outside_g.get('M'), known_transitivity), ...
    [BRAPH2.STR ':Transitivity:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Transitivity');
assert(isequal(m_inside_g.get('M'), known_transitivity), ...
    [BRAPH2.STR ':Transitivity:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
OrdMlWU
%%%% ¡probability!
.01
%%%% ¡code!
A11 = [
      0 1 1 1;
      1 0 1 0;
      1 1 0 1;
      1 0 1 0
      ];
A22 = [
      0 1 1 1;
      1 0 1 0;
      1 1 0 1;
      1 0 1 0
      ];
A12 = rand(size(A11,1),size(A22,2));
A21 = A12';
A = {A11 A12;
     A21 A22};

known_transitivity = {
                 3/4
                 3/4
                 };      

g = OrdMlWU('B', A);
m_outside_g = Transitivity('G', g);

assert(isequal(m_outside_g.get('M'), known_transitivity), ...
    [BRAPH2.STR ':Transitivity:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Transitivity');
assert(isequal(m_inside_g.get('M'), known_transitivity), ...
    [BRAPH2.STR ':Transitivity:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])