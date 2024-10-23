%% ¡header!
EccentricityInAv < EccentricityIn (m, average in-eccentricity) is the graph Average In-Eccentricity.

%%% ¡description!
The Average In-Eccentricity (EccentricityInAv) of a node is the sum of the nodal 
in-eccentricities divided by their number within a layer.

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
EccentricityInAv.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
EccentricityInAv.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
EccentricityInAv.RULE
%%%% ¡title!
In-Eccentricity rule for calculation in a graph or its subgraph

%%% ¡prop!
%%%% ¡id!
EccentricityInAv.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
EccentricityInAv.M
%%%% ¡title!
Average In-Eccentricity

%%% ¡prop!
%%%% ¡id!
EccentricityInAv.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
EccentricityInAv.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
EccentricityInAv.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs
  
%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Average In-Eccentricity.
%%%% ¡default!
'EccentricityInAv'

%%% ¡prop!
NAME (constant, string) is the name of the Average In-Eccentricity.
%%%% ¡default!
'Average In-Eccentricity'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the Average In-Eccentricity.
%%%% ¡default!
'The Average In-Eccentricity (EccentricityInAv) of a node is the sum of the nodal in-eccentricities divided by their number within a layer.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Average In-Eccentricity.
%%%% ¡settings!
'EccentricityInAv'

%%% ¡prop!
ID (data, string) is a few-letter code of the Average In-Eccentricity.
%%%% ¡default!
'EccentricityInAv ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Average In-Eccentricity.
%%%% ¡default!
'Average In-Eccentricity label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the Average In-Eccentricity.
%%%% ¡default!
'Average In-Eccentricity notes'

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
{'GraphWD' 'GraphBD' 'MultiplexWD' 'MultiplexBD' 'OrdMxWD'};

%%% ¡prop!
M (result, cell) is the Average In-Eccentricity.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
L = g.get('LAYERNUMBER');

eccentricity = calculateValue@EccentricityIn(m, prop); 

eccentricity_av = cell(L, 1);

parfor li = 1:L
    eccentricity_av(li) = {mean(eccentricity{li})};
end

value = eccentricity_av;

%% ¡tests!

%%% ¡excluded_props!
[EccentricityInAv.PFM]

%%% ¡test!
%%%% ¡name!
GraphWD
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0   .1  0   0   0
    .2   0  0   0   0
    0    0  0  .2   0
    0    0 .1   0   0
    0    0  0   0   0
    ];

known_eccentricity = {mean([5 10 10 5 0]')};

g = GraphWD('B', B);

m_outside_g = EccentricityInAv('G', g);
m_outside_g.set('RULE', 'subgraphs');

assert(isequal(m_outside_g.get('M'), known_eccentricity), ...
    [BRAPH2.STR ':EccentricityInAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'EccentricityInAv');
m_inside_g.set('RULE', 'subgraphs');
assert(isequal(m_inside_g.get('M'), known_eccentricity), ...
    [BRAPH2.STR ':EccentricityInAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
GraphBD
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0   .1  0   0   0
    .2   0  0   0   0
    0    0  0  .2   0
    0    0 .1   0   0
    0    0  0   0   0
    ];

known_eccentricity = {mean([1 1 1 1 0]')};

g = GraphBD('B', B);

m_outside_g = EccentricityInAv('G', g);
m_outside_g.set('RULE', 'subgraphs');

assert(isequal(m_outside_g.get('M'), known_eccentricity), ...
    [BRAPH2.STR ':EccentricityInAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'EccentricityInAv');
m_inside_g.set('RULE', 'subgraphs');
assert(isequal(m_inside_g.get('M'), known_eccentricity), ...
    [BRAPH2.STR ':EccentricityInAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexWD
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0   .1  0   0   0
    .2   0  0   0   0
    0    0  0  .2   0
    0    0 .1   0   0
    0    0  0   0   0
      ];
B22 = [
    0   .1  0   0   0
    .2   0  0   0   0
    0    0  0  .2   0
    0    0 .1   0   0
    0    0  0   0   0
      ];
B = {
    B11 B22
    };

known_eccentricity = {
    mean([5 10 10 5 0]')
    mean([5 10 10 5 0]')
    };

g = MultiplexWD('B', B);

m_outside_g = EccentricityInAv('G', g);
m_outside_g.set('RULE', 'subgraphs');

assert(isequal(m_outside_g.get('M'), known_eccentricity), ...
    [BRAPH2.STR ':EccentricityInAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'EccentricityInAv');
m_inside_g.set('RULE', 'subgraphs');
assert(isequal(m_inside_g.get('M'), known_eccentricity), ...
    [BRAPH2.STR ':EccentricityInAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])


%%% ¡test!
%%%% ¡name!
MultiplexBD
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0   .1  0   0   0
    .2   0  0   0   0
    0    0  0  .2   0
    0    0 .1   0   0
    0    0  0   0   0
      ];
B22 = [
    0   .1  0   0   0
    .2   0  0   0   0
    0    0  0  .2   0
    0    0 .1   0   0
    0    0  0   0   0
      ];
B = {
    B11 B22
    };

known_eccentricity = {
    mean([1 1 1 1 0]')
    mean([1 1 1 1 0]')
    };

g = MultiplexBD('B', B);

m_outside_g = EccentricityInAv('G', g);
m_outside_g.set('RULE', 'subgraphs');

assert(isequal(m_outside_g.get('M'), known_eccentricity), ...
    [BRAPH2.STR ':EccentricityInAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'EccentricityInAv');
m_inside_g.set('RULE', 'subgraphs');
assert(isequal(m_inside_g.get('M'), known_eccentricity), ...
    [BRAPH2.STR ':EccentricityInAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
OrdMxWD
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0   .1  0   0   0
    .2   0  0   0   0
    0    0  0  .2   0
    0    0 .1   0   0
    0    0  0   0   0
    ];
B22 =[
    0   .1  0   0   0
    .2   0  0   0   0
    0    0  0  .2   0
    0    0 .1   0   0
    0    0  0   0   0
    ];
B = {B11 B22};

known_eccentricityAv = {
    mean([5 10 10 5 0])
    mean([5 10 10 5 0])
    };

g = OrdMxWD('B', B);

m_outside_g = EccentricityInAv('G', g);
m_outside_g.set('RULE', 'subgraphs');

assert(isequal(m_outside_g.get('M'), known_eccentricityAv), ...
    [BRAPH2.STR ':EccentricityInAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'EccentricityInAv');
m_inside_g.set('RULE', 'subgraphs');
assert(isequal(m_inside_g.get('M'), known_eccentricityAv), ...
    [BRAPH2.STR ':EccentricityInAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])
