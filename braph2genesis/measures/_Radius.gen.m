%% ¡header!
Radius < Measure (m, radius) is the graph Radius.

%%% ¡description!
The Radius (Radius) is the minimum eccentricity among the vertices within a layer.

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
Radius.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
Radius.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
Radius.RULE
%%%% ¡title!
Eccentricity rule for calculation in a graph or its subgraph

%%% ¡prop!
%%%% ¡id!
Radius.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
Radius.M
%%%% ¡title!
Radius

%%% ¡prop!
%%%% ¡id!
Radius.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
Radius.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
Radius.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs
  
%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Radius.
%%%% ¡default!
'Radius'

%%% ¡prop!
NAME (constant, string) is the name of the Radius.
%%%% ¡default!
'Radius'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the Radius.
%%%% ¡default!
'The Radius (Radius) is the minimum eccentricity among the vertices within a layer.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Radius.
%%%% ¡settings!
'Radius'

%%% ¡prop!
ID (data, string) is a few-letter code of the Radius.
%%%% ¡default!
'Radius ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Radius.
%%%% ¡default!
'Radius label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the Radius.
%%%% ¡default!
'Radius notes'

%%% ¡prop!
SHAPE (constant, scalar) is the measure shape __Measure.GLOBAL__.
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
{'GraphWU' 'GraphBU' 'MultigraphBUD' 'MultigraphBUT' 'MultiplexWU' 'MultiplexBU' 'MultiplexBUD' 'MultiplexBUT' 'OrdMxWU'};

%%% ¡prop!
M (result, cell) is the Radius.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % cell matrix for graph, multigraph, or multiplex, etc
L = g.get('LAYERNUMBER');
eccentricity = Eccentricity('G', g, 'RULE', m.get('RULE')).get('M');
radius = cell(L, 1);

warning('off', 'MATLAB:remoteparfor:ParforWorkerAborted')
parfor li = 1:1:L
    radius(li) = {min(eccentricity{li})};
end
warning('on', 'MATLAB:remoteparfor:ParforWorkerAborted')

value = radius;

%% ¡props!

%%% ¡prop! 
RULE (parameter, OPTION) % calculation in a graph or its subgraph
%%%% ¡settings!
{'all', 'subgraphs'}
%%%% ¡default!
'all'

%% ¡tests!

%%% ¡excluded_props!
[Radius.PFM]

%%% ¡test!
%%%% ¡name!
GraphWU
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0     .1  .2  .25  0;
    .125  0   0   0    0;
    .2    .5  0   .25  0;
    .125  10  0   0    0;
    0     0   0   0    0
    ];

known_radius_subgraphs = {0};

g = GraphWU('B', B);

m_outside_g = Radius('G', g);
m_outside_g.set('RULE', 'subgraphs');
assert(isequal(m_outside_g.get('M'), known_radius_subgraphs), ...
    [BRAPH2.STR ':Radius:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Radius');
m_inside_g.set('RULE', 'subgraphs');
assert(isequal(m_inside_g.get('M'), known_radius_subgraphs), ...
    [BRAPH2.STR ':Radius:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
GraphBU
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0  1  1  1  0;
    1  0  0  0  0;
    1  1  0  1  0;
    1  1  0  0  0;
    0  0  0  0  0
    ];
known_radius_subgraphs = {0};

g = GraphBU('B', B);

m_outside_g = Radius('G', g);
m_outside_g.set('RULE', 'subgraphs');
assert(isequal(m_outside_g.get('M'), known_radius_subgraphs), ...
    [BRAPH2.STR ':Radius:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Radius');
m_inside_g.set('RULE', 'subgraphs');
assert(isequal(m_inside_g.get('M'), known_radius_subgraphs), ...
    [BRAPH2.STR ':Radius:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultigraphBUT
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0     .1  .2  .25  0;
    .125  0   0   0    0;
    .2    .5  0   .25  0;
    .125  10  0   0    0;
    0     0   0   0    0
    ];
known_radius_subgraphs = {0, 0};
thresholds = [0.1 0.7];

g = MultigraphBUT('B', B, 'THRESHOLDS', thresholds);

m_outside_g = Radius('G', g);
m_outside_g.set('RULE', 'subgraphs');
assert(isequal(m_outside_g.get('M'), known_radius_subgraphs'), ...
    [BRAPH2.STR ':Radius:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Radius');
m_inside_g.set('RULE', 'subgraphs');
assert(isequal(m_inside_g.get('M'), known_radius_subgraphs'), ...
    [BRAPH2.STR ':Radius:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultigraphBUD
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0     .1  .2  .25  0;
    .125  0   0   0    0;
    .2    .5  0   .25  0;
    .125  10  0   0    0;
    0     0   0   0    0
    ];
known_radius_subgraphs = {0, 0};
densities = [10 80];

g = MultigraphBUD('B', B, 'DENSITIES', densities);

m_outside_g = Radius('G', g);
m_outside_g.set('RULE', 'subgraphs');
assert(isequal(m_outside_g.get('M'), known_radius_subgraphs'), ...
    [BRAPH2.STR ':Radius:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Radius');
m_inside_g.set('RULE', 'subgraphs');
assert(isequal(m_inside_g.get('M'), known_radius_subgraphs'), ...
    [BRAPH2.STR ':Radius:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexWU
%%%% ¡code!
B11 = [
      0     .1  .2  .25  0;
      .125  0   0   0    0;
      .2    .5  0   .25  0;
      .125  10  0   0    0;
      0     0   0   0    0
      ];
B22 = [
      0     .1  .2  .25  0;
      .125  0   0   0    0;
      .2    .5  0   .25  0;
      .125  10  0   0    0;
      0     0   0   0    0
      ];
B = {
    B11 B22
    };

known_radius_subgraphs = {
                         0
                         0
                         };

g = MultiplexWU('B', B);

m_outside_g = Radius('G', g);
m_outside_g.set('RULE', 'subgraphs');
assert(isequal(m_outside_g.get('M'), known_radius_subgraphs), ...
    [BRAPH2.STR ':Radius:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Radius');
m_inside_g.set('RULE', 'subgraphs');
assert(isequal(m_inside_g.get('M'), known_radius_subgraphs), ...
    [BRAPH2.STR ':Radius:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBU
%%%% ¡code!
B11 =  [
    0  1  1  1  0;
    1  0  0  0  0;
    1  1  0  1  0;
    1  1  0  0  0;
    0  0  0  0  0
    ];
B22 =  [
    0  1  1  1  0;
    1  0  0  0  0;
    1  1  0  1  0;
    1  1  0  0  0;
    0  0  0  0  0
    ];
B = {
    B11 B22
    };

known_radius_subgraphs = {
                         0
                         0
                         };

g = MultiplexBU('B', B);

m_outside_g = Radius('G', g);
m_outside_g.set('RULE', 'subgraphs');
assert(isequal(m_outside_g.get('M'), known_radius_subgraphs), ...
    [BRAPH2.STR ':Radius:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Radius');
m_inside_g.set('RULE', 'subgraphs');
assert(isequal(m_inside_g.get('M'), known_radius_subgraphs), ...
    [BRAPH2.STR ':Radius:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
OrdMxWU
%%%% ¡code!
B11 = [
      0     .1  .2  .25  0;
      .125  0   0   0    0;
      .2    .5  0   .25  0;
      .125  10  0   0    0;
      0     0   0   0    0
      ];
B22 = [
      0     .1  .2  .25  0;
      .125  0   0   0    0;
      .2    .5  0   .25  0;
      .125  10  0   0    0;
      0     0   0   0    0
      ];
B = {
    B11 B22
    };

known_radius_subgraphs = {
                         0
                         0
                         };

g = OrdMxWU('B', B);

m_outside_g = Radius('G', g);
m_outside_g.set('RULE', 'subgraphs');
assert(isequal(m_outside_g.get('M'), known_radius_subgraphs), ...
    [BRAPH2.STR ':Radius:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Radius');
m_inside_g.set('RULE', 'subgraphs');
assert(isequal(m_inside_g.get('M'), known_radius_subgraphs), ...
    [BRAPH2.STR ':Radius:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])