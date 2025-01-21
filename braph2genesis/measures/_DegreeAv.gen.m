%% ¡header!
DegreeAv < Degree (m, average degree) is the graph Average Degree.

%%% ¡description!
The Average Degree (DegreeAv) of a graph is the average of all number of edges 
connected to a node within a layer. 
Connection weights are ignored in calculations.

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
DegreeAv.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
DegreeAv.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
DegreeAv.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
DegreeAv.M
%%%% ¡title!
Average Degree

%%% ¡prop!
%%%% ¡id!
DegreeAv.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
DegreeAv.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
DegreeAv.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Average Degree.
%%%% ¡default!
'DegreeAv'

%%% ¡prop!
NAME (constant, string) is the name of the Average Degree.
%%%% ¡default!
'Average Degree'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the Average Degree.
%%%% ¡default!
'The Average Degree (DegreeAv) of a graph is the average of all number of edges connected to a node within a layer. Connection weights are ignored in calculations.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Average Degree.
%%%% ¡settings!
'DegreeAv'

%%% ¡prop!
ID (data, string) is a few-letter code of the Average Degree.
%%%% ¡default!
'DegreeAv ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Average Degree.
%%%% ¡default!
'Average Degree label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the Average Degree.
%%%% ¡default!
'Average Degree notes'

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
%%% ¡default!
{'GraphWU' 'GraphBU' 'MultigraphBUD' 'MultigraphBUT' 'MultiplexWU' 'MultiplexBU' 'MultiplexBUD' 'MultiplexBUT' 'OrdMxWU' 'OrdMxBU' 'OrdMxBUT' 'OrdMxBUD' 'MultilayerWU' 'OrdMlWU' 'MultilayerBUT' 'MultilayerBU' 'MultilayerBUD' 'OrdMlBU' 'OrdMlBUD' 'OrdMlBUT'};

%%% ¡prop!
M (result, cell) is the Average Degree.
%%%% ¡calculate!
degree = calculateValue@Degree(m, prop);

g = m.get('G');  % graph from measure class

degree_av = cell(g.get('LAYERNUMBER'), 1);

warning('off', 'MATLAB:remoteparfor:ParforWorkerAborted')
parfor li = 1:1:g.get('LAYERNUMBER')
    degree_av(li) = {mean(degree{li})};
end
warning('on', 'MATLAB:remoteparfor:ParforWorkerAborted')

value = degree_av;

%% ¡tests!

%%% ¡excluded_props!
[DegreeAv.PFM]

%%% ¡test!
%%%% ¡name!
GraphWU
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0   .6  1
    .6  0   0
    1   0   0
    ];

known_degree_av = {mean([2 1 1])};

g = GraphWU('B', B);

m_outside_g = DegreeAv('G', g);
assert(isequal(m_outside_g.get('M'), known_degree_av), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'DegreeAv');
assert(isequal(m_inside_g.get('M'), known_degree_av), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
GraphBU
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0   1   1
    1   0   0
    1   0   0
    ];

known_degree_av = {mean([2 1 1])};

g = GraphBU('B', B);

m_outside_g = DegreeAv('G', g);
assert(isequal(m_outside_g.get('M'), known_degree_av), ...
    [BRAPH2.STR ':Degree:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'DegreeAv');
assert(isequal(m_inside_g.get('M'), known_degree_av), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.FAIL_TEST], ...
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

known_degree = { ...
    mean([0 0 0])
    mean([1 0 1])
    mean([2 1 1])
    mean([2 2 2])
    };

g = MultigraphBUD('B', B, 'DENSITIES', densities);

m_outside_g = DegreeAv('G', g);
assert(isequal(m_outside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'DegreeAv');
assert(isequal(m_inside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultigraphBUT
%%%% ¡code!
B = [
    0   .2   .7
    .2   0   0
    .7   0   0
    ];

thresholds = [0 .5 1];

known_degree = { ...
    mean([2 1 1])
    mean([1 0 1])
    mean([0 0 0])
    };

g = MultigraphBUT('B', B, 'THRESHOLDS', thresholds);

m_outside_g = DegreeAv('G', g);
assert(isequal(m_outside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'DegreeAv');
assert(isequal(m_inside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexWU
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0   .2  1
    .2  0   0
    1   0   0
    ];
B22 = [
    0   1   0
    1   0   .3
    0   .3  0
    ];
B= {B11 B22};

known_degree = {
    mean([2 1 1])
    mean([1 2 1])
    };

g = MultiplexWU('B', B);

m_outside_g = DegreeAv('G', g);
assert(isequal(m_outside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'DegreeAv');
assert(isequal(m_inside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBU
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

known_degree = {
    mean([2 1 1])
    mean([1 2 1])
    };

g = MultiplexBU('B', B);

m_outside_g = DegreeAv('G', g);
assert(isequal(m_outside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'DegreeAv');
assert(isequal(m_inside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.FAIL_TEST], ...
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

known_degree = { ...
    mean([0 0 0])
    mean([0 0 0])
    mean([0 0 0])
    mean([1 0 1])
    mean([1 0 1])
    mean([1 0 1])
    mean([2 1 1])
    mean([2 1 1])
    mean([2 1 1])
    mean([2 2 2])
    mean([2 2 2])
    mean([2 2 2])
    };

g = MultiplexBUD('B', {B B B}, 'DENSITIES', densities);

m_outside_g = DegreeAv('G', g);
assert(isequal(m_outside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'DegreeAv');
assert(isequal(m_inside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBUT
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0   .2   .7
    .2   0   0
    .7   0   0
    ];

thresholds = [0 .5 1];

known_degree = { ...
    mean([2 1 1])
    mean([2 1 1])
    mean([2 1 1])
    mean([1 0 1])
    mean([1 0 1])
    mean([1 0 1])
    mean([0 0 0])
    mean([0 0 0])
    mean([0 0 0])
    };

g = MultiplexBUT('B', {B B B}, 'THRESHOLDS', thresholds);

m_outside_g = DegreeAv('G', g);
assert(isequal(m_outside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'DegreeAv');
assert(isequal(m_inside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
OrdMxWU
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0   .2  1
    .2  0   0
    1   0   0
    ];
B22 = [
    0   1   0
    1   0   .3
    0   .3  0
    ];
B= {B11 B22};

known_degree = {
    mean([2 1 1])
    mean([1 2 1])
    };

g = OrdMxWU('B', B);

m_outside_g = DegreeAv('G', g);
assert(isequal(m_outside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'DegreeAv');
assert(isequal(m_inside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.FAIL_TEST], ...
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

known_degree = {
    mean([2 1 1])
    mean([1 2 1])
    };

g = OrdMxBU('B', B);

m_outside_g = DegreeAv('G', g);
assert(isequal(m_outside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'DegreeAv');
assert(isequal(m_inside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.FAIL_TEST], ...
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

known_degree = { ...
    mean([2 1 1])
    mean([2 1 1])
    mean([2 1 1])
    mean([1 0 1])
    mean([1 0 1])
    mean([1 0 1])
    mean([0 0 0])
    mean([0 0 0])
    mean([0 0 0])
    };

g = OrdMxBUT('B', {B B B}, 'THRESHOLDS', thresholds);

m_outside_g = DegreeAv('G', g);
assert(isequal(m_outside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'DegreeAv');
assert(isequal(m_inside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.FAIL_TEST], ...
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

known_degree = { ...
    mean([0 0 0])
    mean([0 0 0])
    mean([0 0 0])
    mean([1 0 1])
    mean([1 0 1])
    mean([1 0 1])
    mean([2 1 1])
    mean([2 1 1])
    mean([2 1 1])
    mean([2 2 2])
    mean([2 2 2])
    mean([2 2 2])
    };

g = OrdMxBUD('B', {B B B}, 'DENSITIES', densities);

m_outside_g = DegreeAv('G', g);
assert(isequal(m_outside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'DegreeAv');
assert(isequal(m_inside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultilayerWU
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0   .2  1
    .2  0   0
    1   0   0
    ];
B22 = [
    0   1   0  .2  
    1   0   .3  .1
    0  .3   0   0
   .2  .1   0   0
    ];
B12 = rand(size(B11,1),size(B22,2));
B21 = B12';
B= {B11 B12;
    B21 B22};

known_degree = {
    mean([2 1 1])
    mean([2 3 1 2])
    };

g = MultilayerWU('B', B);

m_outside_g = DegreeAv('G', g);
assert(isequal(m_outside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'DegreeAv');
assert(isequal(m_inside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
OrdMlWU
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0   .2  1
    .2  0   0
    1   0   0
    ];
B22 = [
    0   1   0  .2  
    1   0   .3  .1
    0  .3   0   0
   .2  .1   0   0
    ];
B12 = rand(size(B11, 1),size(B22, 2));
B21 = B12';
B= {B11 B12;
    B21 B22};

known_degree = {
    mean([2 1 1])
    mean([2 3 1 2])
    };

g = OrdMlWU('B', B);

m_outside_g = DegreeAv('G', g);
assert(isequal(m_outside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'DegreeAv');
assert(isequal(m_inside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
%%% ¡test!
%%%% ¡name!
MultilayerBUT
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0    0.6
    0.6  0
    ];
B22 = [
    0   .2   .7
    .2   0   0
    .7   0   0
    ];
B33 = [
    0   1   0  .2  
    1   0   .3  .1
    0  .3   0   0
   .2  .1   0   0
    ];

thresholds = [0 .5 .8];

known_degree = { ...
    mean([1 1])
    mean([2 1 1])
    mean([2 3 1 2])
    mean([1 1])
    mean([1 0 1])
    mean([1 1 0 0])
    mean([0 0])
    mean([0 0 0])
    mean([1 1 0 0])
    };

B12 = rand(size(B11,1),size(B22,2));
B13 = rand(size(B11,1),size(B33,2));
B23 = rand(size(B22,1),size(B33,2));
B21 = B12';
B32 = B23';
B31 = B13';

B= {B11 B12 B13;
    B21 B22 B23;
    B31 B32 B33};

g = MultilayerBUT('B', B, 'THRESHOLDS', thresholds);

m_outside_g = DegreeAv('G', g);
assert(isequal(m_outside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'DegreeAv');
assert(isequal(m_inside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultilayerBU
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0   1   1
    1   0   0
    1   0   0
    ];
B22 = [
    0   1   0	1
    1   0   1	1
    0   1   0	0
    1   1   0	0
    ];
B12 = rand(size(B11,1),size(B22,2));
B21 = B12';
B= {B11 B12;
    B21 B22};

known_degree = {
    mean([2 1 1])
    mean([2 3 1 2])
    };


g = MultilayerBU('B', B);

m_outside_g = DegreeAv('G', g);
assert(isequal(m_outside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'DegreeAv');
assert(isequal(m_inside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultilayerBUD
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0   .2   .7
    .2   0   .1
    .7  .1   0
    ];

B22 = [    
    0   .2   .7 .5
    .2   0   .1 .5
    .7  .1   0  .5
    .5  .5  .5  0
    ];
B12 = rand(size(B11,1),size(B22,2));
B21 = B12';
B= {B11 B12;
    B21 B22};

densities = [0 33 67 100];

known_degree = { ...
    mean([0 0 0])
    mean([0 0 0 0])
    mean([1 0 1])
    mean([1 0 1 0])
    mean([2 1 1])
    mean([2 1 2 3])
    mean([2 2 2])
    mean([3 3 3 3])
    };

g = MultilayerBUD('B', B, 'DENSITIES', densities);

m_outside_g = DegreeAv('G', g);
assert(isequal(m_outside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'DegreeAv');
assert(isequal(m_inside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
OrdMlBU
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0   1   1
    1   0   0
    1   0   0
    ];
B22 = [
    0   1   0	1
    1   0   1   1
    0   1   0   0
    1   1   0   0
    ];
B12 = rand(size(B11,1),size(B22,2));
B21 = B12';
B= {B11 B12;
    B21 B22};

known_degree = {
    mean([2 1 1])
    mean([2 3 1 2])
    };


g = OrdMlBU('B', B);

m_outside_g = DegreeAv('G', g);
assert(isequal(m_outside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'DegreeAv');
assert(isequal(m_inside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
OrdMlBUD
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0   .2   .7
    .2   0   .1
    .7  .1   0
    ];

B22 = [    
    0   .2   .7 .5
    .2   0   .1 .5
    .7  .1   0  .5
    .5  .5  .5  0
    ];
B12 = rand(size(B11,1),size(B22,2));
B21 = B12';
B= {B11 B12;
    B21 B22};

densities = [0 33 67 100];

known_degree = { ...
    mean([0 0 0])
    mean([0 0 0 0])
    mean([1 0 1])
    mean([1 0 1 0])
    mean([2 1 1])
    mean([2 1 2 3])
    mean([2 2 2])
    mean([3 3 3 3])
    };

g = OrdMlBUD('B', B, 'DENSITIES', densities);

m_outside_g = DegreeAv('G', g);
assert(isequal(m_outside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'DegreeAv');
assert(isequal(m_inside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
OrdMlBUT
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0   .2   .7
    .2   0   .1
    .7  .1   0
    ];

B22 = [    
    0   .2   .7 .5
    .2   0   .1 .5
    .7  .1   0  .5
    .5  .5  .5  0
    ];
B12 = rand(size(B11,1),size(B22,2));
B21 = B12';
B= {B11 B12;
    B21 B22};

thresholds = [0 .5 1];

known_degree = { ...
    mean([2 2 2])
    mean([3 3 3 3])
    mean([1 0 1])
    mean([1 0 1 0])
    mean([0 0 0])
    mean([0 0 0 0])
    };

g = OrdMlBUT('B', B, 'THRESHOLDS', thresholds);

m_outside_g = DegreeAv('G', g);
assert(isequal(m_outside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'DegreeAv');
assert(isequal(m_inside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])