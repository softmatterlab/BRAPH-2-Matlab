%% ¡header!
EccentricityIn < Measure (m, in-eccentricity) is the graph In-Eccentricity.

%%% ¡description!
The In-Eccentricity (EccentricityIn) of a node is the maximal shortest in-path length 
between a node and any other node within a layer.

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
EccentricityIn.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
EccentricityIn.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
EccentricityIn.RULE
%%%% ¡title!
In-Eccentricity rule for calculation in a graph or its subgraph

%%% ¡prop!
%%%% ¡id!
EccentricityIn.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
EccentricityIn.M
%%%% ¡title!
In-Eccentricity

%%% ¡prop!
%%%% ¡id!
EccentricityIn.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
EccentricityIn.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
EccentricityIn.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs
  
%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the In-Eccentricity.
%%%% ¡default!
'EccentricityIn'

%%% ¡prop!
NAME (constant, string) is the name of the In-Eccentricity.
%%%% ¡default!
'In-Eccentricity'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the In-Eccentricity.
%%%% ¡default!
'The In-Eccentricity (EccentricityIn) of a node is the maximal shortest in-path length between a node and any other node within a layer.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the In-Eccentricity.
%%%% ¡settings!
'EccentricityIn'

%%% ¡prop!
ID (data, string) is a few-letter code of the In-Eccentricity.
%%%% ¡default!
'EccentricityIn ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the In-Eccentricity.
%%%% ¡default!
'In-Eccentricity label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the In-Eccentricity.
%%%% ¡default!
'In-Eccentricity notes'

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
{'GraphWD' 'GraphBD' 'MultiplexWD' 'MultiplexBD' 'OrdMxWD'} ;

%%% ¡prop!
M (result, cell) is the In-Eccentricity.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
L = g.get('LAYERNUMBER');

distance = Distance('G', g).get('M'); 
eccentricityIn = cell(L, 1);
eccentricity_rule = m.get('RULE');

warning('off', 'MATLAB:remoteparfor:ParforWorkerAborted')
parfor li = 1:1:L
    switch lower(eccentricity_rule)
        case {'subgraphs'}
            eccentricityIn(li)  = {max(distance{li}.*(distance{li}~=Inf), [], 1)};
        case {'all'}
            eccentricityIn(li)  = {max(distance{li}, [], 1)};
    end
end
warning('on', 'MATLAB:remoteparfor:ParforWorkerAborted')

value = eccentricityIn;

%% ¡props!

%%% ¡prop! 
RULE (parameter, OPTION)  % calculation in a graph or its subgraph
%%%% ¡settings!
{'all', 'subgraphs'}
%%%% ¡default!
'all'

%% ¡tests!

%%% ¡excluded_props!
[EccentricityIn.PFM]

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

known_eccentricity = {[1 1 1 1 0]};

g = GraphBD('B', B);

m_outside_g = EccentricityIn('G', g);
m_outside_g.set('RULE', 'subgraphs');

assert(isequal(m_outside_g.get('M'), known_eccentricity), ...
    [BRAPH2.STR ':EccentricityIn:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'EccentricityIn');
m_inside_g.set('RULE', 'subgraphs');
assert(isequal(m_inside_g.get('M'), known_eccentricity), ...
    [BRAPH2.STR ':EccentricityIn:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

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

known_eccentricity = {[5 10 10 5 0]};

g = GraphWD('B', B);

m_outside_g = EccentricityIn('G', g);
m_outside_g.set('RULE', 'subgraphs');

assert(isequal(m_outside_g.get('M'), known_eccentricity), ...
    [BRAPH2.STR ':EccentricityIn:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'EccentricityIn');
m_inside_g.set('RULE', 'subgraphs');
assert(isequal(m_inside_g.get('M'), known_eccentricity), ...
    [BRAPH2.STR ':EccentricityIn:' BRAPH2.FAIL_TEST], ...
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
B22 =[
    0   .1  0   0   0
    .2   0  0   0   0
    0    0  0  .2   0
    0    0 .1   0   0
    0    0  0   0   0
    ];
B = {B11 B22};

known_eccentricity = {
    [5 10 10 5 0]
    [5 10 10 5 0]
    };

g = MultiplexWD('B', B);

m_outside_g = EccentricityIn('G', g);
m_outside_g.set('RULE', 'subgraphs');

assert(isequal(m_outside_g.get('M'), known_eccentricity), ...
    [BRAPH2.STR ':EccentricityIn:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'EccentricityIn');
m_inside_g.set('RULE', 'subgraphs');
assert(isequal(m_inside_g.get('M'), known_eccentricity), ...
    [BRAPH2.STR ':EccentricityIn:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])


%%% ¡test!
%%%% ¡name!
MultiplexBD
%%%% ¡probability!
.01
%%%% ¡code!
B11 =[
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

known_eccentricity = {
    [1 1 1 1 0]
    [1 1 1 1 0]
    };

g = MultiplexBD('B', B);

m_outside_g = EccentricityIn('G', g);
m_outside_g.set('RULE', 'subgraphs');

assert(isequal(m_outside_g.get('M'), known_eccentricity), ...
    [BRAPH2.STR ':EccentricityIn:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'EccentricityIn');
m_inside_g.set('RULE', 'subgraphs');
assert(isequal(m_inside_g.get('M'), known_eccentricity), ...
    [BRAPH2.STR ':EccentricityIn:' BRAPH2.FAIL_TEST], ...
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

known_eccentricity = {
    [5 10 10 5 0]
    [5 10 10 5 0]
    };

g = OrdMxWD('B', B);

m_outside_g = EccentricityIn('G', g);
m_outside_g.set('RULE', 'subgraphs');

assert(isequal(m_outside_g.get('M'), known_eccentricity), ...
    [BRAPH2.STR ':EccentricityIn:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'EccentricityIn');
m_inside_g.set('RULE', 'subgraphs');
assert(isequal(m_inside_g.get('M'), known_eccentricity), ...
    [BRAPH2.STR ':EccentricityIn:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])
