%% ¡header!
EccentricityAv < Eccentricity (m, average eccentricity) is the graph Average Eccentricity.

%%% ¡description!
The Average Eccentricity (EccentricityAv) of a graph is the sum of the nodal eccentricities divided by their number within a layer.

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
EccentricityAv.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
EccentricityAv.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
EccentricityAv.RULE
%%%% ¡title!
EccentricityAv rule for calculation in a graph or its subgraph

%%% ¡prop!
%%%% ¡id!
EccentricityAv.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
EccentricityAv.M
%%%% ¡title!
Average Eccentricity

%%% ¡prop!
%%%% ¡id!
EccentricityAv.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
EccentricityAv.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
EccentricityAv.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs
  
%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Average Eccentricity.
%%%% ¡default!
'EccentricityAv'

%%% ¡prop!
NAME (constant, string) is the name of the Average Eccentricity.
%%%% ¡default!
'Average Eccentricity'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the Average Eccentricity.
%%%% ¡default!
'The Average Eccentricity (EccentricityAv) of a graph is the sum of the nodal eccentricities divided by their number within a layer.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Average Eccentricity.
%%%% ¡settings!
'EccentricityAv'

%%% ¡prop!
ID (data, string) is a few-letter code of the Average Eccentricity.
%%%% ¡default!
'EccentricityAv ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Average Eccentricity.
%%%% ¡default!
'Average Eccentricity label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the Average Eccentricity.
%%%% ¡default!
'Average Eccentricity notes'

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
M (result, cell) is the Average Eccentricity.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
L = g.get('LAYERNUMBER');

eccentricity = calculateValue@Eccentricity(m, prop); 

eccentricity_av = cell(L, 1);

warning('off', 'MATLAB:remoteparfor:ParforWorkerAborted')
parfor li = 1:L
    eccentricity_av(li) = {mean(eccentricity{li})};
end
warning('on', 'MATLAB:remoteparfor:ParforWorkerAborted')

value = eccentricity_av;

%% ¡tests!

%%% ¡excluded_props!
[EccentricityAv.PFM]

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

known_eccentricity = {mean([5 5 5 4 0]')};

g = GraphWU('B', B);

m_outside_g = EccentricityAv('G', g);
m_outside_g.set('RULE', 'subgraphs');

assert(isequal(m_outside_g.get('M'), known_eccentricity), ...
    [BRAPH2.STR ':EccentricityAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'EccentricityAv');
m_inside_g.set('RULE', 'subgraphs');
assert(isequal(m_inside_g.get('M'), known_eccentricity), ...
    [BRAPH2.STR ':EccentricityAv:' BRAPH2.FAIL_TEST], ...
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

known_eccentricity = {mean([1 1 1 1 0]')};

g = GraphBU('B', B);

m_outside_g = EccentricityAv('G', g);
m_outside_g.set('RULE', 'subgraphs');

assert(isequal(m_outside_g.get('M'), known_eccentricity), ...
    [BRAPH2.STR ':EccentricityAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'EccentricityAv');
m_inside_g.set('RULE', 'subgraphs');
assert(isequal(m_inside_g.get('M'), known_eccentricity), ...
    [BRAPH2.STR ':EccentricityAv:' BRAPH2.FAIL_TEST], ...
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

known_eccentricity = {
    mean([5 5 5 4 0]')
    mean([5 5 5 4 0]')
    };

g = MultiplexWU('B', B);

m_outside_g = EccentricityAv('G', g);
m_outside_g.set('RULE', 'subgraphs');

assert(isequal(m_outside_g.get('M'), known_eccentricity), ...
    [BRAPH2.STR ':EccentricityAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'EccentricityAv');
m_inside_g.set('RULE', 'subgraphs');
assert(isequal(m_inside_g.get('M'), known_eccentricity), ...
    [BRAPH2.STR ':EccentricityAv:' BRAPH2.FAIL_TEST], ...
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

known_eccentricity = {
    mean([1 1 1 1 0]')
    mean([1 1 1 1 0]')
    };

g = MultiplexBU('B', B);

m_outside_g = EccentricityAv('G', g);
m_outside_g.set('RULE', 'subgraphs');

assert(isequal(m_outside_g.get('M'), known_eccentricity), ...
    [BRAPH2.STR ':EccentricityAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'EccentricityAv');
m_inside_g.set('RULE', 'subgraphs');
assert(isequal(m_inside_g.get('M'), known_eccentricity), ...
    [BRAPH2.STR ':EccentricityAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
OrdMxWU
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

known_EccentricityAv = {
    mean([5 5 5 4 0]')
    mean([5 5 5 4 0]')
    };

g = OrdMxWU('B', B);

m_outside_g = EccentricityAv('G', g);
m_outside_g.set('RULE', 'subgraphs');

assert(isequal(m_outside_g.get('M'), known_EccentricityAv), ...
    [BRAPH2.STR ':EccentricityAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'EccentricityAv');
m_inside_g.set('RULE', 'subgraphs');
assert(isequal(m_inside_g.get('M'), known_EccentricityAv), ...
    [BRAPH2.STR ':EccentricityAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])
