%% ¡header!
EccentricityOut < Measure (m, out-eccentricity) is the graph Out-Eccentricity.

%%% ¡description!
The Out-Eccentricity (EccentricityOut) of a node is the maximal shortest out-path length 
between a node and any other node within a layer.

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
EccentricityOut.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
EccentricityOut.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
EccentricityOut.RULE
%%%% ¡title!
Out-Eccentricity rule for calculation in a graph or its subgraph

%%% ¡prop!
%%%% ¡id!
EccentricityOut.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
EccentricityOut.M
%%%% ¡title!
Out-Eccentricity

%%% ¡prop!
%%%% ¡id!
EccentricityOut.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
EccentricityOut.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
EccentricityOut.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs
  
%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Out-Eccentricity.
%%%% ¡default!
'EccentricityOut'

%%% ¡prop!
NAME (constant, string) is the name of the Out-Eccentricity.
%%%% ¡default!
'Out-Eccentricity'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the Out-Eccentricity.
%%%% ¡default!
'The Out-Eccentricity (EccentricityOut) of a node is the maximal shortest out-path length between a node and any other node within a layer.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Out-Eccentricity.
%%%% ¡settings!
'EccentricityOut'

%%% ¡prop!
ID (data, string) is a few-letter code of the Out-Eccentricity.
%%%% ¡default!
'EccentricityOut ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Out-Eccentricity.
%%%% ¡default!
'Out-Eccentricity label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the Out-Eccentricity.
%%%% ¡default!
'Out-Eccentricity notes'

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
M (result, cell) is the Out-Eccentricity.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
L = g.get('LAYERNUMBER');

distance = Distance('G', g).get('M'); 
eccentricityOut = cell(L, 1);
eccentricity_rule = m.get('RULE');

warning('off', 'MATLAB:remoteparfor:ParforWorkerAborted')
parfor li = 1:1:L
    switch lower(eccentricity_rule)
        case {'subgraphs'}
            eccentricityOut(li)  = {max(distance{li}.*(distance{li}~=Inf), [], 2)};
        case {'all'}
            eccentricityOut(li)  = {max(distance{li}, [], 2)};
    end
end
warning('on', 'MATLAB:remoteparfor:ParforWorkerAborted')

value = eccentricityOut;

%% ¡props!

%%% ¡prop! 
RULE (parameter, OPTION)  % calculation in a graph or its subgraph
%%%% ¡settings!
{'all', 'subgraphs'}
%%%% ¡default!
'all'

%% ¡tests!

%%% ¡excluded_props!
[EccentricityOut.PFM]

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

known_eccentricity = {[1 1 1 1 0]'};

g = GraphBD('B', B);

m_outside_g = EccentricityOut('G', g);
m_outside_g.set('RULE', 'subgraphs');

assert(isequal(m_outside_g.get('M'), known_eccentricity), ...
    [BRAPH2.STR ':EccentricityOut:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'EccentricityOut');
m_inside_g.set('RULE', 'subgraphs');
assert(isequal(m_inside_g.get('M'), known_eccentricity), ...
    [BRAPH2.STR ':EccentricityOut:' BRAPH2.FAIL_TEST], ...
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

known_eccentricity = {[10 5 5 10 0]'};

g = GraphWD('B', B);

m_outside_g = EccentricityOut('G', g);
m_outside_g.set('RULE', 'subgraphs');

assert(isequal(m_outside_g.get('M'), known_eccentricity), ...
    [BRAPH2.STR ':EccentricityOut:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'EccentricityOut');
m_inside_g.set('RULE', 'subgraphs');
assert(isequal(m_inside_g.get('M'), known_eccentricity), ...
    [BRAPH2.STR ':EccentricityOut:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexWD
%%%% ¡probability!
.01
%%%% ¡code!
B11  =[
    0   .1  0   0   0
    .2   0  0   0   0
    0    0  0  .2   0
    0    0 .1   0   0
    0    0  0   0   0
    ];

B22  =[
    0   .1  0   0   0
    .2   0  0   0   0
    0    0  0  .2   0
    0    0 .1   0   0
    0    0  0   0   0
    ];

B = {B11 B22};
known_eccentricity = {
    [10 5 5 10 0]'
    [10 5 5 10 0]'
    };

g = MultiplexWD('B', B);

m_outside_g = EccentricityOut('G', g);
m_outside_g.set('RULE', 'subgraphs');

assert(isequal(m_outside_g.get('M'), known_eccentricity), ...
    [BRAPH2.STR ':EccentricityOut:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'EccentricityOut');
m_inside_g.set('RULE', 'subgraphs');
assert(isequal(m_inside_g.get('M'), known_eccentricity), ...
    [BRAPH2.STR ':EccentricityOut:' BRAPH2.FAIL_TEST], ...
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

B22  =[
    0   .1  0   0   0
    .2   0  0   0   0
    0    0  0  .2   0
    0    0 .1   0   0
    0    0  0   0   0
    ];

B = {B11 B22};

known_eccentricity = {
    [1 1 1 1 0]'
    [1 1 1 1 0]'
    };

g = MultiplexBD('B', B);

m_outside_g = EccentricityOut('G', g);
m_outside_g.set('RULE', 'subgraphs');

assert(isequal(m_outside_g.get('M'), known_eccentricity), ...
    [BRAPH2.STR ':EccentricityOut:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'EccentricityOut');
m_inside_g.set('RULE', 'subgraphs');
assert(isequal(m_inside_g.get('M'), known_eccentricity), ...
    [BRAPH2.STR ':EccentricityOut:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
OrdMxWD
%%%% ¡probability!
.01
%%%% ¡code!
B11  =[
    0   .1  0   0   0
    .2   0  0   0   0
    0    0  0  .2   0
    0    0 .1   0   0
    0    0  0   0   0
    ];

B22  =[
    0   .1  0   0   0
    .2   0  0   0   0
    0    0  0  .2   0
    0    0 .1   0   0
    0    0  0   0   0
    ];

B = {B11 B22};
known_eccentricity = {
    [10 5 5 10 0]'
    [10 5 5 10 0]'
    };

g = OrdMxWD('B', B);

m_outside_g = EccentricityOut('G', g);
m_outside_g.set('RULE', 'subgraphs');

assert(isequal(m_outside_g.get('M'), known_eccentricity), ...
    [BRAPH2.STR ':EccentricityOut:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'EccentricityOut');
m_inside_g.set('RULE', 'subgraphs');
assert(isequal(m_inside_g.get('M'), known_eccentricity), ...
    [BRAPH2.STR ':EccentricityOut:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])