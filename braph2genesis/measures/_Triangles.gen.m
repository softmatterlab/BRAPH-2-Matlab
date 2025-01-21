%% ¡header!
Triangles < Measure(m, triangles) is the graph Triangles.

%%% ¡description!
The Triangles (Triangles) are calculated as the number of neighbors of a node that are 
 also neighbors of each other within a layer. In weighted graphs, the triangles are 
 calculated as the geometric mean of the weights of the edges forming the triangle.

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
Triangles.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
Triangles.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
Triangles.RULE
%%%% ¡title!
Triangle rule for directed graphs

%%% ¡prop!
%%%% ¡id!
Triangles.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
Triangles.M
%%%% ¡title!
Triangles

%%% ¡prop!
%%%% ¡id!
Triangles.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
Triangles.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
Triangles.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Triangles.
%%%% ¡default!
'Triangles'

%%% ¡prop!
NAME (constant, string) is the name of the Triangles.
%%%% ¡default!
'Triangles'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the Triangles.
%%%% ¡default!
'The Triangles (Triangles) are calculated as the number of neighbors of a node that are also neighbors of each other within a layer. In weighted graphs, the triangles are calculated as the geometric mean of the weights of the edges forming the triangle.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Triangles.
%%%% ¡settings!
'Triangles'

%%% ¡prop!
ID (data, string) is a few-letter code of the Triangles.
%%%% ¡default!
'Triangles ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Triangles.
%%%% ¡default!
'Triangles label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the Triangles.
%%%% ¡default!
'Triangles notes'

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
{'GraphWU' 'GraphWD' 'GraphBU' 'GraphBD' 'MultigraphBUD' 'MultigraphBUT' 'MultiplexWU' 'MultiplexWD' 'MultiplexBU' 'MultiplexBD' 'MultiplexBUD' 'MultiplexBUT' 'OrdMxWU' 'OrdMxWD' 'OrdMxBU' 'OrdMxBD' 'OrdMxBUT' 'MultilayerWD' 'MultilayerBD'};

%%% ¡prop!
M (result, cell) is the Triangles.
%%%% ¡calculate!
g = m.get('G');  % graph from measure class
A = g.get('A');  % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.) 
L = g.get('LAYERNUMBER');

triangles = cell(L, 1);
            
directionality_type =   g.get('DIRECTIONALITY_TYPE', L);
for li = 1:1:L        
    Aii = A{li, li};    
    
    if directionality_type == Graph.UNDIRECTED  % undirected graphs
        triangles_layer = diag((Aii.^(1/3))^3) / 2;
        triangles_layer(isnan(triangles_layer)) = 0;  % Should return zeros, not NaN
        triangles(li) = {triangles_layer};
        
    else  % directed graphs
        directed_triangles_rule = m.get('RULE');
        switch lower(directed_triangles_rule)
            case 'all'  % all rule
                triangles_layer = diag((Aii.^(1/3) + transpose(Aii).^(1/3))^3) / 2;
            case 'middleman'  % middleman rule
                triangles_layer = diag(Aii.^(1/3) * transpose(Aii).^(1/3) * Aii.^(1/3));
            case 'in'  % in rule
                triangles_layer = diag(transpose(Aii).^(1/3) * (Aii.^(1/3))^2);
            case 'out'  % out rule
                triangles_layer = diag((Aii.^(1/3))^2 * transpose(Aii).^(1/3));
            otherwise  % {'cycle'}  % cycle rule
                triangles_layer = diag((Aii.^(1/3))^3);
        end
        triangles_layer(isnan(triangles_layer)) = 0;  % Should return zeros, not NaN
        triangles(li) = {triangles_layer};
    end
end
value = triangles;

%% ¡props!

%%% ¡prop! 
RULE (parameter, option) is the rule to determine what is a triangle in a directed graph.
%%%% ¡settings!
{'all' 'middleman' 'in' 'out' 'cycle'}
%%%% ¡default!
'cycle'

%% ¡tests!

%%% ¡excluded_props!
[Triangles.PFM]

%%% ¡test!
%%%% ¡name!
GraphWU
%%%% ¡probability!
.01
%%%% ¡code!
B = [
	0 .2 .3 .4;
	.2 0 .5 0;
	.3 .5 0 .6;
	.4 0 .6 0
	];

known_triangles = diag((B.^(1/3))^3); % formula for cycle triangles
known_triangles = known_triangles / 2; % because since the graph is undirected, we only need the upper or lower connections of the matrix

g = GraphWU('B', B);
m_outside_g = Triangles('G', g);
assert(isequal(cell2mat(m_outside_g.get('M')), known_triangles), ...
    [BRAPH2.STR ':Triangles:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g)  ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Triangles');
m_inside_g = cell2mat(m_inside_g.get('M'));
assert(isequal(m_inside_g, known_triangles), ...
    [BRAPH2.STR ':Triangles:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g)  ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
GraphWD
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0 .2 .3 .4;
    .2 0 .5 0;
    .3 .5 0 .6;
    .4 0 .6 0
    ];

known_triangles = diag((B.^(1/3))^3); % formula for cycle triangles

g = GraphWD('B', B);
m_outside_g = Triangles('G', g);
assert(isequal(cell2mat(m_outside_g.get('M')), known_triangles), ...
    [BRAPH2.STR ':Triangles:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g)  ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Triangles');
m_inside_g = cell2mat(m_inside_g.get('M'));
assert(isequal(m_inside_g, known_triangles), ...
    [BRAPH2.STR ':Triangles:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g)  ' is not being calculated correctly for ' class(g) '.'])

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

known_triangles = {[2 1 2 1]'};

g = GraphBU('B', B);
m_outside_g = Triangles('G', g);
assert(isequal(m_outside_g.get('M'), known_triangles), ...
    [BRAPH2.STR ':Triangles:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g)  ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Triangles');
assert(isequal(m_inside_g.get('M'), known_triangles), ...
    [BRAPH2.STR ':Triangles:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g)  ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
GraphBD
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0 0 1; 
    1 0 0; 
    0 1 0 
    ];

% cycle rule - default
known_triangles_default_cycle = {[1 1 1]'};

g = GraphBD('B', B);
m_outside_g = Triangles('G', g);
assert(isequal(m_outside_g.get('M'), known_triangles_default_cycle), ...
    [BRAPH2.STR ':Triangles:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g)  ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Triangles');
assert(isequal(m_inside_g.get('M'), known_triangles_default_cycle), ...
    [BRAPH2.STR ':Triangles:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g)  ' is not being calculated correctly for ' class(g) '.'])

% in rule 
B = [
    0 1 0;
    0 0 0;
    1 1 0
    ];
known_triangles_in = {[0 1 0]'};

g = GraphBD('B', B);
m_outside_g = Triangles('G', g, 'RULE', 'in');
assert(isequal(m_outside_g.get('M'), known_triangles_in), ...
    [BRAPH2.STR ':Triangles:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g)  ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Triangles');
m_inside_g.set('RULE', 'in');
assert(isequal(m_inside_g.get('M'), known_triangles_in), ...
    [BRAPH2.STR ':Triangles:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g)  ' is not being calculated correctly for ' class(g) '.'])

% out rule 
known_triangles_out = {[0 0 1]'};

g = GraphBD('B', B);
m_outside_g = Triangles('G', g, 'RULE', 'out');
assert(isequal(m_outside_g.get('M'), known_triangles_out), ...
    [BRAPH2.STR ':Triangles:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g)  ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Triangles');
m_inside_g.set('RULE', 'out');
assert(isequal(m_inside_g.get('M'), known_triangles_out), ...
    [BRAPH2.STR ':Triangles:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g)  ' is not being calculated correctly for ' class(g) '.'])

% middleman rule
known_triangles_middleman = {[1 0 0]'};

g = GraphBD('B', B);
m_outside_g = Triangles('G', g, 'RULE', 'middleman');
assert(isequal(m_outside_g.get('M'), known_triangles_middleman), ...
    [BRAPH2.STR ':Triangles:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g)  ' is not being calculated correctly for ' class(g) '.'])


m_inside_g = g.get('MEASURE', 'Triangles');
m_inside_g.set('RULE', 'middleman');
assert(isequal(m_inside_g.get('M'), known_triangles_middleman), ...
    [BRAPH2.STR ':Triangles:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g)  ' is not being calculated correctly for ' class(g) '.'])

% all rule 
B = [
    0 0 1;
    1 0 0;
    0 1 0
    ];
known_triangles_all = {[1 1 1]'};

g = GraphBD('B', B);
m_outside_g = Triangles('G', g, 'RULE', 'all');
assert(isequal(m_outside_g.get('M'), known_triangles_all), ...
    [BRAPH2.STR ':Triangles:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g)  ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Triangles');
m_inside_g.set('RULE', 'all');
assert(isequal(m_inside_g.get('M'), known_triangles_all), ...
    [BRAPH2.STR ':Triangles:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g)  ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultigraphBUD
%%%% ¡probability!
.01
%%%% ¡code!
densities = [70 80 90];
B = [
      0 1 1 1;
      1 0 1 0;
      1 1 0 1;
      1 0 1 0
      ];

known_triangles = {
                 [0 0 0 0]'
                 [2 1 2 1]'
                 [2 1 2 1]'
                 };

g = MultigraphBUD('B', B, 'DENSITIES', densities);

m_outside_g = Triangles('G', g);
assert(isequal(m_outside_g.get('M'), known_triangles), ...
    [BRAPH2.STR ':Triangles:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g)  ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Triangles');
assert(isequal(m_inside_g.get('M'), known_triangles), ...
    [BRAPH2.STR ':Triangles:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g)  ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultigraphBUT
%%%% ¡probability!
.01
%%%% ¡code!
thresholds = [.1 .2 .3];
B = [
      0 1 1 1;
      1 0 1 0;
      1 1 0 1;
      1 0 1 0
      ];

known_triangles = {
                 [2 1 2 1]'
                 [2 1 2 1]'
                 [2 1 2 1]'
                 };   

g = MultigraphBUT('B', B, 'THRESHOLDS', thresholds);

m_outside_g = Triangles('G', g);
assert(isequal(m_outside_g.get('M'), known_triangles), ...
    [BRAPH2.STR ':Triangles:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g)  ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Triangles');
assert(isequal(m_inside_g.get('M'), known_triangles), ...
    [BRAPH2.STR ':Triangles:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g)  ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexWU
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0 .2 .3 .4;
    .2 0 .5 0;
    .3 .5 0 .6;
    .4 0 .6 0
    ];
B22 = [
    0 .2 .3 .4;
    .2 0 .5 0;
    .3 .5 0 .6;
    .4 0 .6 0
    ];
B = {B11 B22};

known_triangles = {
    diag((B11.^(1/3))^3)/2
    diag((B22.^(1/3))^3)/2
    };

g = MultiplexWU('B', B);
m_outside_g = Triangles('G', g);
assert(isequal(m_outside_g.get('M'), known_triangles), ...
    [BRAPH2.STR ':Triangles:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g)  ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Triangles');
assert(isequal(m_inside_g.get('M'), known_triangles), ...
    [BRAPH2.STR ':Triangles:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g)  ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBU
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
      0 1 1 1;
      1 0 1 0;
      1 1 0 1;
      1 0 1 0
      ];
B22 = [
      0 1 1 1;
      1 0 1 0;
      1 1 0 1;
      1 0 1 0
      ];
B = {B11 B22};

known_triangles = {
                 [2 1 2 1]'
                 [2 1 2 1]'
                 };      

g = MultiplexBU('B', B);

m_outside_g = Triangles('G', g);
assert(isequal(m_outside_g.get('M'), known_triangles), ...
    [BRAPH2.STR ':Triangles:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g)  ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Triangles');
assert(isequal(m_inside_g.get('M'), known_triangles), ...
    [BRAPH2.STR ':Triangles:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g)  ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBD
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0 0 1;
    1 0 0;
    0 1 0
    ];
B22 = [
    0 0 1;
    1 0 0;
    0 1 0
    ];
B = {B11 B22};

known_triangles = {
                 [1 1 1]'
                 [1 1 1]'
                 };      

g = MultiplexBD('B', B);

m_outside_g = Triangles('G', g);
assert(isequal(m_outside_g.get('M'), known_triangles), ...
    [BRAPH2.STR ':Triangles:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g)  ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Triangles');
assert(isequal(m_inside_g.get('M'), known_triangles), ...
    [BRAPH2.STR ':Triangles:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g)  ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBUD
%%%% ¡probability!
.01
%%%% ¡code!
densities = [70 80 90];
B11 = [
      0 1 1 1;
      1 0 1 0;
      1 1 0 1;
      1 0 1 0
      ];
B22 = [
      0 1 1 1;
      1 0 1 0;
      1 1 0 1;
      1 0 1 0
      ];

B = {B11 B22};

known_triangles = {
                 [0 0 0 0]'
                 [0 0 0 0]'
                 [2 1 2 1]'
                 [2 1 2 1]'                 
                 [2 1 2 1]'
                 [2 1 2 1]'
                 }; % this is because it is calculted per density first

g = MultiplexBUD('B', B, 'DENSITIES', densities);

m_outside_g = Triangles('G', g);
assert(isequal(m_outside_g.get('M'), known_triangles), ...
    [BRAPH2.STR ':Triangles:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g)  ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Triangles');
assert(isequal(m_inside_g.get('M'), known_triangles), ...
    [BRAPH2.STR ':Triangles:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g)  ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBUT
%%%% ¡probability!
.01
%%%% ¡code!
thresholds = [.1 .2 .3];
B11 = [
      0 1 1 1;
      1 0 1 0;
      1 1 0 1;
      1 0 1 0
      ];

B22 = [
      0 1 1 1;
      1 0 1 0;
      1 1 0 1;
      1 0 1 0
      ];

B = {B11 B22};

known_triangles = {
                 [2 1 2 1]'
                 [2 1 2 1]'
                 [2 1 2 1]'
                 [2 1 2 1]'
                 [2 1 2 1]'
                 [2 1 2 1]'
                 };   

g = MultiplexBUT('B', B, 'THRESHOLDS', thresholds);

m_outside_g = Triangles('G', g);
assert(isequal(m_outside_g.get('M'), known_triangles), ...
    [BRAPH2.STR ':Triangles:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g)  ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Triangles');
assert(isequal(m_inside_g.get('M'), known_triangles), ...
    [BRAPH2.STR ':Triangles:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g)  ' is not being calculated correctly for ' class(g) '.'])
