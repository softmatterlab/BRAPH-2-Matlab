%% ¡header!
Diameter < Measure (m, diameter) is the graph Diameter.

%%% ¡description!
The Diameter (Diameter) is the maximum eccentricity among the vertices within a layer.

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
Diameter.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
Diameter.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
Diameter.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
Diameter.M
%%%% ¡title!
Diameter

%%% ¡prop!
%%%% ¡id!
Diameter.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
Diameter.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
Diameter.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Diameter.
%%%% ¡default!
'Diameter'

%%% ¡prop!
NAME (constant, string) is the name of the Diameter.
%%%% ¡default!
'Diameter'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the Diameter.
%%%% ¡default!
'The Diameter (Diameter) is the maximum eccentricity among the vertices within a layer.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Diameter.
%%%% !settings!
'Diameter'

%%% ¡prop!
ID (data, string) is a few-letter code of the Diameter.
%%%% ¡default!
'Diameter ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Diameter.
%%%% ¡default!
'Diameter label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the Diameter.
%%%% ¡default!
'Diameter notes'

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
M (result, cell) is the Diameter.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
L = g.get('LAYERNUMBER');

eccentricity = Eccentricity('G', g, 'RULE', m.get('RULE')).get('M'); 
diameter = cell(L, 1);

parfor li = 1:L
    diameter(li) = {max(eccentricity{li})};
end

value = diameter;

%% ¡props!

%%% ¡prop! 
RULE (parameter, OPTION)  % calculation in a graph or its subgraph
%%%% ¡settings!
{'all', 'subgraphs'}
%%%% ¡default!
'all'

%% ¡tests!

%%% ¡excluded_props!
[Diameter.PFM]

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


known_diameter_subgraphs = {5};
g = GraphWU('B', B);

m_outside_g = Diameter('G', g);
m_outside_g.set('RULE', 'subgraphs');

assert(isequal(m_outside_g.get('M'), known_diameter_subgraphs), ...
    [BRAPH2.STR ':Diameter:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Diameter');
m_inside_g.set('RULE', 'subgraphs');
assert(isequal(m_inside_g.get('M'), known_diameter_subgraphs), ...
    [BRAPH2.STR ':Diameter:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
GraphBU
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

known_diameter_subgraphs = {1};

g = GraphBU('B', B);

m_outside_g = Diameter('G', g);
m_outside_g.set('RULE', 'subgraphs');


assert(isequal(m_outside_g.get('M'), known_diameter_subgraphs), ...
    [BRAPH2.STR ':Diameter:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Diameter');
m_inside_g.set('RULE', 'subgraphs');
assert(isequal(m_inside_g.get('M'), known_diameter_subgraphs), ...
    [BRAPH2.STR ':Diameter:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexWU
%%%% ¡probability!
.01
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
B = {B11 B22};

known_diameter_subgraphs = {
    5
    5
    };

g = MultiplexWU('B', B);

m_outside_g = Diameter('G', g);
m_outside_g.set('RULE', 'subgraphs');

assert(isequal(m_outside_g.get('M'), known_diameter_subgraphs), ...
    [BRAPH2.STR ':Diameter:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Diameter');
m_inside_g.set('RULE', 'subgraphs');
assert(isequal(m_inside_g.get('M'), known_diameter_subgraphs), ...
    [BRAPH2.STR ':Diameter:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])


%%% ¡test!
%%%% ¡name!
MultiplexBU
%%%% ¡probability!
.01
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
B = {B11 B22};

known_diameter_subgraphs = {
    1
    1
    };

g = MultiplexBU('B', B);

m_outside_g = Diameter('G', g);
m_outside_g.set('RULE', 'subgraphs');

assert(isequal(m_outside_g.get('M'), known_diameter_subgraphs), ...
    [BRAPH2.STR ':Diameter:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Diameter');
m_inside_g.set('RULE', 'subgraphs');
assert(isequal(m_inside_g.get('M'), known_diameter_subgraphs), ...
    [BRAPH2.STR ':Diameter:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])
