%% ¡header!
GlobalEfficiencyAv < GlobalEfficiency (m, average global efficiency) is the graph Average Global Efficiency.

%%% ¡description!
The Average Global Efficiency (GlobalEfficiencyAv) is the average of the 
global efficiency within each layer.

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
GlobalEfficiencyAv.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
GlobalEfficiencyAv.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
GlobalEfficiencyAv.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
GlobalEfficiencyAv.M
%%%% ¡title!
Average Global Efficiency

%%% ¡prop!
%%%% ¡id!
GlobalEfficiencyAv.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
GlobalEfficiencyAv.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
GlobalEfficiencyAv.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Average Global Efficiency.
%%%% ¡default!
'GlobalEfficiencyAv'

%%% ¡prop!
NAME (constant, string) is the name of the Average Global Efficiency.
%%%% ¡default!
'Average Global Efficiency'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the Average Global Efficiency.
%%%% ¡default!
'The Average Global Efficiency (GlobalEfficiencyAv) is the average of the global efficiency within each layer.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Average Global Efficiency.
%%%% ¡settings!
'GlobalEfficiencyAv'

%%% ¡prop!
ID (data, string) is a few-letter code of the Average Global Efficiency.
%%%% ¡default!
'GlobalEfficiencyAv ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Average Global Efficiency.
%%%% ¡default!
'Average Global Efficiency label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the Average Global Efficiency.
%%%% ¡default!
'Average Global Efficiency notes'

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
{'GraphWU' 'GraphBU' 'MultigraphBUD' 'MultigraphBUT' 'MultiplexWU' 'MultiplexBU' 'MultiplexBUD' 'MultiplexBUT' 'OrdMxWU' 'OrdMxBU' 'OrdMxBUT' 'OrdMxBUD' 'MultilayerWU' 'OrdMlWU' 'MultilayerBUT' 'MultilayerBU' 'MultilayerBUD' 'OrdMlBU' 'OrdMlBUD' 'OrdMlBUT'}


%%% ¡prop!
M (result, cell) is the Average Global Efficiency.
%%%% ¡calculate!
global_efficiency = calculateValue@GlobalEfficiency(m, prop);
g = m.get('G');  % graph from measure class
A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
L = g.get('LAYERNUMBER');

global_efficiency_av = cell(L, 1);
parfor li = 1:1:L
    global_efficiency_av(li) = {mean(global_efficiency{li})};
end
value = global_efficiency_av;

%% ¡tests!

%%% ¡excluded_props!
[GlobalEfficiencyAv.PFM]

%%% ¡test!
%%%% ¡name!
GraphWU
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0   .1  0   0   0
    .2  0   0   0   0
    0   0   0   .2  0
    0   0   .1  0   0
    0   0   0   0   0
    ];

known_global_efficiency_av = {mean([1/20 1/20 1/20 1/20 0])};

g = GraphWU('B', B);

m_outside_g = GlobalEfficiencyAv('G', g);
assert(isequal(m_outside_g.get('M'), known_global_efficiency_av), ...
    [BRAPH2.STR ':GlobalEfficiencyAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'GlobalEfficiencyAv');
assert(isequal(m_inside_g.get('M'), known_global_efficiency_av), ...
    [BRAPH2.STR ':GlobalEfficiencyAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
GraphBU
%%%% ¡probability!
.01
%%%% ¡code!

B = [
    0   .1  0   0   0
    .2  0   0   0   0
    0   0   0   .2  0
    0   0   .1  0   0
    0   0   0   0   0
    ];

known_global_efficiency_av = {mean([1/4 1/4 1/4 1/4 0])};

g = GraphBU('B', B);

m_outside_g = GlobalEfficiencyAv('G', g);
assert(isequal(m_outside_g.get('M'), known_global_efficiency_av), ...
    [BRAPH2.STR ':GlobalEfficiencyAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'GlobalEfficiencyAv');
assert(isequal(m_inside_g.get('M'), known_global_efficiency_av), ...
    [BRAPH2.STR ':GlobalEfficiencyAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultigraphBUD
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0   .2   .7
    .2   0   .1
    .7  .1   0
    ];

densities = [0 33 67 100];

known_global_efficiency_av = { ...
    mean([0 0 0])
    mean([1/2 0 1/2])
    mean([1 3/4 3/4])
    mean([1 1 1])
    };

g = MultigraphBUD('B', B, 'DENSITIES', densities);

m_outside_g = GlobalEfficiencyAv('G', g);
assert(isequal(m_outside_g.get('M'), known_global_efficiency_av), ...
    [BRAPH2.STR ':GlobalEfficiencyAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'GlobalEfficiencyAv');
assert(isequal(m_inside_g.get('M'), known_global_efficiency_av), ...
    [BRAPH2.STR ':GlobalEfficiencyAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultigraphBUT
%%%% ¡probability!
.01
%%%% ¡code!

B = [
    0   .2   .7
    .2   0   0
    .7   0   0
    ];

thresholds = [0 .5 1];

known_global_efficiency_av = { ...
    mean([1 3/4 3/4])
    mean([1/2 0 1/2])
    mean([0 0 0])
    };

g = MultigraphBUT('B', B, 'THRESHOLDS', thresholds);

m_outside_g = GlobalEfficiencyAv('G', g);
assert(isequal(m_outside_g.get('M'), known_global_efficiency_av), ...
    [BRAPH2.STR ':GlobalEfficiencyAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'GlobalEfficiencyAv');
assert(isequal(m_inside_g.get('M'), known_global_efficiency_av), ...
    [BRAPH2.STR ':GlobalEfficiencyAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexWU
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
      0   .1  0   0   0
      .2  0   0   0   0
      0   0   0   .2  0
      0   0   .1  0   0
      0   0   0   0   0
      ];

B22 = [
      0   .1  0   0   0
      .2  0   0   0   0
      0   0   0   .2  0
      0   0   .1  0   0
      0   0   0   0   0
      ];
B33 = [
      0   .1  0   0   0
      .2  0   0   0   0
      0   0   0   .2  0
      0   0   .1  0   0
      0   0   0   0   0
      ];
B = {B11  B22  B33};

known_global_efficiency_av = {
                        mean([1/20 1/20 1/20 1/20 0])
                        mean([1/20 1/20 1/20 1/20 0])
                        mean([1/20 1/20 1/20 1/20 0])
                        };


g = MultiplexWU('B', B);


m_outside_g = GlobalEfficiencyAv('G', g);
assert(isequal(m_outside_g.get('M'), known_global_efficiency_av), ...
    [BRAPH2.STR ':GlobalEfficiencyAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'GlobalEfficiencyAv');
assert(isequal(m_inside_g.get('M'), known_global_efficiency_av), ...
    [BRAPH2.STR ':GlobalEfficiencyAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBU
%%%% ¡probability!
.01
%%%% ¡code!
%% Test 17: MultiplexBU

B11 = [
      0   .1  0   0   0
      .2  0   0   0   0
      0   0   0   .2  0
      0   0   .1  0   0
      0   0   0   0   0
      ];

B22 = [
      0   .1  0   0   0
      .2  0   0   0   0
      0   0   0   .2  0
      0   0   .1  0   0
      0   0   0   0   0
      ];
B33 = [
      0   .1  0   0   0
      .2  0   0   0   0
      0   0   0   .2  0
      0   0   .1  0   0
      0   0   0   0   0
      ];
B = {B11  B22  B33};

known_global_efficiency_av = {
                        mean([1/4 1/4 1/4 1/4 0])
                        mean([1/4 1/4 1/4 1/4 0])
                        mean([1/4 1/4 1/4 1/4 0])
                        };


g = MultiplexBU('B', B);


m_outside_g = GlobalEfficiencyAv('G', g);
assert(isequal(m_outside_g.get('M'), known_global_efficiency_av), ...
    [BRAPH2.STR ':GlobalEfficiencyAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'GlobalEfficiencyAv');
assert(isequal(m_inside_g.get('M'), known_global_efficiency_av), ...
    [BRAPH2.STR ':GlobalEfficiencyAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBUD
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0   .2   .7
    .2   0   .1
    .7  .1   0
    ];

densities = [0 33 67 100];

known_global_efficiency_av = { ...
    mean([0 0 0])
    mean([0 0 0])
    mean([0 0 0])
    mean([1/2 0 1/2])
    mean([1/2 0 1/2])
    mean([1/2 0 1/2])
    mean([1 3/4 3/4])
    mean([1 3/4 3/4])
    mean([1 3/4 3/4])
    mean([1 1 1])
    mean([1 1 1])
    mean([1 1 1])
    };

g = MultiplexBUD('B', {B B B}, 'DENSITIES', densities);

m_outside_g = GlobalEfficiencyAv('G', g);
assert(isequal(m_outside_g.get('M'), known_global_efficiency_av), ...
    [BRAPH2.STR ':GlobalEfficiencyAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'GlobalEfficiencyAv');
assert(isequal(m_inside_g.get('M'), known_global_efficiency_av), ...
    [BRAPH2.STR ':GlobalEfficiencyAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBUT
%%%% ¡probability!
.01
%%%% ¡code!
%% Test 19: MultiplexBUT
B = [
    0   .2   .7
    .2   0   0
    .7   0   0
    ];

thresholds = [0 .5 1];

known_global_efficiency_av = { ...
    mean([1 3/4 3/4])
    mean([1 3/4 3/4])
    mean([1 3/4 3/4])
    mean([1/2 0 1/2])
    mean([1/2 0 1/2])
    mean([1/2 0 1/2])
    mean([0 0 0])
    mean([0 0 0])
    mean([0 0 0])
    };

g = MultiplexBUT('B', {B B B}, 'THRESHOLDS', thresholds);

m_outside_g = GlobalEfficiencyAv('G', g);
assert(isequal(m_outside_g.get('M'), known_global_efficiency_av), ...
    [BRAPH2.STR ':GlobalEfficiencyAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'GlobalEfficiencyAv');
assert(isequal(m_inside_g.get('M'), known_global_efficiency_av), ...
    [BRAPH2.STR ':GlobalEfficiencyAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
OrdMxBU
%%%% ¡probability!
.01
%%%% ¡code!

B11 = [
    0   1   1
    1   0   0
    1   0   0
    ];
B22 = [
    0   1   0
    1   0   1
    0   1   0
    ];
B = {B11 B22};

known_global_efficiency_av = {
    mean([1 3/4 3/4])
    mean([3/4 1 3/4])
    };

g = OrdMxBU('B', B);

m_outside_g = GlobalEfficiencyAv('G', g);
assert(isequal(m_outside_g.get('M'), known_global_efficiency_av), ...
    [BRAPH2.STR ':GlobalEfficiencyAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'GlobalEfficiencyAv');
assert(isequal(m_inside_g.get('M'), known_global_efficiency_av), ...
    [BRAPH2.STR ':GlobalEfficiencyAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
OrdMxBUT
%%%% ¡probability!
.01
%%%% ¡code!

B = [
    0   .2   .7
    .2   0   0
    .7   0   0
    ];

thresholds = [0 .5 1];

known_global_efficiency_av = { ...
    mean([1 3/4 3/4])
    mean([1 3/4 3/4])
    mean([1 3/4 3/4])
    mean([1/2 0 1/2])
    mean([1/2 0 1/2])
    mean([1/2 0 1/2])
    mean([0 0 0])
    mean([0 0 0])
    mean([0 0 0])
    };

g = OrdMxBUT('B', {B B B}, 'THRESHOLDS', thresholds);

m_outside_g = GlobalEfficiencyAv('G', g);
assert(isequal(m_outside_g.get('M'), known_global_efficiency_av), ...
    [BRAPH2.STR ':GlobalEfficiencyAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'GlobalEfficiencyAv');
assert(isequal(m_inside_g.get('M'), known_global_efficiency_av), ...
    [BRAPH2.STR ':GlobalEfficiencyAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
OrdMxBUD
%%%% ¡probability!
.01
%%%% ¡code!

B = [
    0   .2   .7
    .2   0   .1
    .7  .1   0
    ];

densities = [0 33 67 100];

known_global_efficiency_av = { ...
    mean([0 0 0])
    mean([0 0 0])
    mean([0 0 0])
    mean([1/2 0 1/2])
    mean([1/2 0 1/2])
    mean([1/2 0 1/2])
    mean([1 3/4 3/4])
    mean([1 3/4 3/4])
    mean([1 3/4 3/4])
    mean([1 1 1])
    mean([1 1 1])
    mean([1 1 1])
    };

g = OrdMxBUD('B', {B B B}, 'DENSITIES', densities);

m_outside_g = GlobalEfficiencyAv('G', g);
assert(isequal(m_outside_g.get('M'), known_global_efficiency_av), ...
    [BRAPH2.STR ':GlobalEfficiencyAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'GlobalEfficiencyAv');
assert(isequal(m_inside_g.get('M'), known_global_efficiency_av), ...
    [BRAPH2.STR ':GlobalEfficiencyAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])
