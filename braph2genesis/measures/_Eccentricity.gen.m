%% ¡header!
Eccentricity < Measure (m, eccentricity) is the graph Eccentricity.

%%% ¡description!
The Eccentricity (Eccentricity) of a node is the maximal shortest path length between a node and any other node within a layer.

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
Eccentricity.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
Eccentricity.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
Eccentricity.RULE
%%%% ¡title!
Eccentricity rule for calculation in a graph or its subgraph

%%% ¡prop!
%%%% ¡id!
Eccentricity.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
Eccentricity.M
%%%% ¡title!
Eccentricity

%%% ¡prop!
%%%% ¡id!
Eccentricity.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
Eccentricity.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
Eccentricity.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs
  
%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Eccentricity.
%%%% ¡default!
'Eccentricity'

%%% ¡prop!
NAME (constant, string) is the name of the Eccentricity.
%%%% ¡default!
'Eccentricity'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the Eccentricity.
%%%% ¡default!
'The Eccentricity (Eccentricity) of a node is the maximal shortest path length between a node and any other node within a layer.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Eccentricity.
%%%% ¡settings!
'Eccentricity'

%%% ¡prop!
ID (data, string) is a few-letter code of the Eccentricity.
%%%% ¡default!
'Eccentricity ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Eccentricity.
%%%% ¡default!
'Eccentricity label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the Eccentricity.
%%%% ¡default!
'Eccentricity notes'

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
{'GraphWU' 'GraphBU' 'MultigraphBUD' 'MultigraphBUT' 'MultiplexWU' 'MultiplexBU' 'MultiplexBUD' 'MultiplexBUT' 'OrdMxWU'};

%%% ¡prop!
M (result, cell) is the Eccentricity.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
L = g.get('LAYERNUMBER');

distance = Distance('G', g).get('M'); 
eccentricity = cell(L, 1);
eccentricity_rule = m.get('RULE');

parfor li = 1:1:L
    switch lower(eccentricity_rule)
        case {'subgraphs'}
            eccentricity(li)  = {max(distance{li}.*(distance{li}~=Inf), [], 2)};
        case {'all'}
            eccentricity(li)  = {max(distance{li}, [], 2)};
    end
end

value = eccentricity;


%% ¡props!

%%% ¡prop! 
RULE (parameter, OPTION)  % calculation in a graph or its subgraph
%%%% ¡settings!
{'all', 'subgraphs'}
%%%% ¡default!
'all'

%% ¡tests!

%%% ¡excluded_props!
[Eccentricity.PFM]

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

known_eccentricity = {[5 5 5 4 0]'};

g = GraphWU('B', B);

m_outside_g = Eccentricity('G', g);
m_outside_g.set('RULE', 'subgraphs');

assert(isequal(m_outside_g.get('M'), known_eccentricity), ...
    [BRAPH2.STR ':Eccentricity:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Eccentricity');
m_inside_g.set('RULE', 'subgraphs');
assert(isequal(m_inside_g.get('M'), known_eccentricity), ...
    [BRAPH2.STR ':Eccentricity:' BRAPH2.FAIL_TEST], ...
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

known_eccentricity = {[1 1 1 1 0]'};

g = GraphBU('B', B);

m_outside_g = Eccentricity('G', g);
m_outside_g.set('RULE', 'subgraphs');

assert(isequal(m_outside_g.get('M'), known_eccentricity), ...
    [BRAPH2.STR ':Eccentricity:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Eccentricity');
m_inside_g.set('RULE', 'subgraphs');
assert(isequal(m_inside_g.get('M'), known_eccentricity), ...
    [BRAPH2.STR ':Eccentricity:' BRAPH2.FAIL_TEST], ...
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
    [5 5 5 4 0]'
    [5 5 5 4 0]'
    };

g = MultiplexWU('B', B);

m_outside_g = Eccentricity('G', g);
m_outside_g.set('RULE', 'subgraphs');

assert(isequal(m_outside_g.get('M'), known_eccentricity), ...
    [BRAPH2.STR ':Eccentricity:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Eccentricity');
m_inside_g.set('RULE', 'subgraphs');
assert(isequal(m_inside_g.get('M'), known_eccentricity), ...
    [BRAPH2.STR ':Eccentricity:' BRAPH2.FAIL_TEST], ...
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
    [1 1 1 1 0]'
    [1 1 1 1 0]'
    };

g = MultiplexBU('B', B);

m_outside_g = Eccentricity('G', g);
m_outside_g.set('RULE', 'subgraphs');

assert(isequal(m_outside_g.get('M'), known_eccentricity), ...
    [BRAPH2.STR ':Eccentricity:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Eccentricity');
m_inside_g.set('RULE', 'subgraphs');
assert(isequal(m_inside_g.get('M'), known_eccentricity), ...
    [BRAPH2.STR ':Eccentricity:' BRAPH2.FAIL_TEST], ...
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

known_eccentricity = {
    [5 5 5 4 0]'
    [5 5 5 4 0]'
    };

g = OrdMxWU('B', B);

m_outside_g = Eccentricity('G', g);
m_outside_g.set('RULE', 'subgraphs');

assert(isequal(m_outside_g.get('M'), known_eccentricity), ...
    [BRAPH2.STR ':Eccentricity:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Eccentricity');
m_inside_g.set('RULE', 'subgraphs');
assert(isequal(m_inside_g.get('M'), known_eccentricity), ...
    [BRAPH2.STR ':Eccentricity:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])