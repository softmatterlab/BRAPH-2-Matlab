%% ¡header!
OverlappingDegAv < OverlappingDeg (m, average overlapping-degree) is the graph Average Overlapping Degree.

%%% ¡description!
The Average Overlapping Degree (OverlappingDegAv) of a graph is the average of the sum of the 
degrees of a node in all layers. 

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
OverlappingDegAv.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
OverlappingDegAv.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
OverlappingDegAv.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
OverlappingDegAv.M
%%%% ¡title!
Average Overlapping Degree

%%% ¡prop!
%%%% ¡id!
OverlappingDegAv.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
OverlappingDegAv.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
OverlappingDegAv.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Average Overlapping Degree.
%%%% ¡default!
'OverlappingDegAv'

%%% ¡prop!
NAME (constant, string) is the name of the Average Overlapping Degree.
%%%% ¡default!
'Average Overlapping Degree'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the average overlapping degree.
%%%% ¡default!
'The Average Overlapping Degree (OverlappingDegAv) of a graph is the average of the sum of the degrees of a node in all layers.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Average Overlapping Degree.
%%%% ¡settings!
'OverlappingDegAv'

%%% ¡prop!
ID (data, string) is a few-letter code of the Average Overlapping Degree.
%%%% ¡default!
'OverlappingDegAv ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Average Overlapping Degree.
%%%% ¡default!
'Average Overlapping Degree label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the Average Overlapping Degree.
%%%% ¡default!
'Average Overlapping Degree notes'

%%% ¡prop!
SHAPE (constant, scalar) is the measure shape __Measure.GLOBAL__.
%%%% ¡default!
Measure.GLOBAL

%%% ¡prop!
SCOPE (constant, scalar) is the measure scope __Measure.SUPERGLOBAL__.
%%%% ¡default!
Measure.SUPERGLOBAL

%%% ¡prop!
PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.
%%%% ¡default!
Measure.NONPARAMETRIC

%%% ¡prop!
COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
%%%% ¡default!
{'MultiplexWU' 'MultiplexBU' 'MultiplexBUD' 'MultiplexBUT' 'OrdMxWU' 'MultilayerWU' 'OrdMlWU' 'MultilayerBU'};

%%% ¡prop!
M (result, cell) is the Average Overlapping Degree.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
l = g.get('LAYERNUMBER');
ls = g.get('PARTITIONS');

if l == 0
    value = {};
else
    overlapping_degree = calculateValue@OverlappingDeg(m, prop);
    overlapping_degree_av = cell(length(l), 1);

    for i=1:length(ls)
        overlapping_degree_av(i) = {mean(overlapping_degree{i})};
    end
    value = overlapping_degree_av;
end

%% ¡tests!

%%% ¡excluded_props!
[OverlappingDegAv.PFM]

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
B = {B11 B22};

known_overlapping_degree = {mean([3, 3, 2]')};

g = MultiplexWU('B', B);
m_outside_g = OverlappingDegAv('G', g);
assert(isequal(m_outside_g.get('M'), known_overlapping_degree), ...
    [BRAPH2.STR ':OverlappingDegAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'OverlappingDegAv');
assert(isequal(m_inside_g.get('M'), known_overlapping_degree), ...
    [BRAPH2.STR ':OverlappingDegAv:' BRAPH2.FAIL_TEST], ...
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

known_overlapping_degree = {mean([3, 3, 2]')};

g = MultiplexBU('B', B);
m_outside_g = OverlappingDegAv('G', g);
assert(isequal(m_outside_g.get('M'), known_overlapping_degree), ...
    [BRAPH2.STR ':OverlappingDegAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'OverlappingDegAv');
assert(isequal(m_inside_g.get('M'), known_overlapping_degree), ...
    [BRAPH2.STR ':OverlappingDegAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBUT
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

known_overlapping_degree_av = { ...
                            mean([3, 3, 2])
                            0
                            }';

g = MultiplexBUT('B', B, 'THRESHOLDS', [0 1]);

m_outside_g = OverlappingDegAv('G', g);
assert(isequal(m_outside_g.get('M'), known_overlapping_degree_av), ...
    [BRAPH2.STR ':OverlappingDegAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'OverlappingDegAv');
assert(isequal(m_inside_g.get('M'), known_overlapping_degree_av), ...
    [BRAPH2.STR ':OverlappingDegAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBUD
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

known_overlapping_degree = { ...
    0
    mean([4, 4, 4]')
    }';

g = MultiplexBUD('B', B, 'DENSITIES', [0 100]);

m_outside_g = OverlappingDegAv('G', g);
assert(isequal(m_outside_g.get('M'), known_overlapping_degree), ...
    [BRAPH2.STR ':OverlappingDegAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'OverlappingDegAv');
assert(isequal(m_inside_g.get('M'), known_overlapping_degree), ...
    [BRAPH2.STR ':OverlappingDegAv:' BRAPH2.FAIL_TEST], ...
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
B = {B11 B22};

known_overlapping_degree = {mean([3, 3, 2]')};

g = OrdMxWU('B', B);
m_outside_g = OverlappingDegAv('G', g);
assert(isequal(m_outside_g.get('M'), known_overlapping_degree), ...
    [BRAPH2.STR ':OverlappingDegAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'OverlappingDegAv');
assert(isequal(m_inside_g.get('M'), known_overlapping_degree), ...
    [BRAPH2.STR ':OverlappingDegAv:' BRAPH2.FAIL_TEST], ...
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
    0   1   0
    1   0   .3
    0   .3  0
    ];
B12 = rand(size(B11,1),size(B22,2));
B21 = B12';
B = {B11 B12;
     B21 B22};

known_overlapping_degree = {mean([3, 3, 2]')};
g = MultilayerWU('B', B);
m_outside_g = OverlappingDegAv('G', g);
assert(isequal(m_outside_g.get('M'), known_overlapping_degree), ...
    [BRAPH2.STR ':OverlappingDegAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'OverlappingDegAv');
assert(isequal(m_inside_g.get('M'), known_overlapping_degree), ...
    [BRAPH2.STR ':OverlappingDegAv:' BRAPH2.FAIL_TEST], ...
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
    0   1   0
    1   0   .3
    0   .3  0
    ];
B12 = rand(size(B11,1),size(B22,2));
B21 = B12';
B = {B11 B12;
     B21 B22};

known_overlapping_degree = {mean([3, 3, 2]')};
g = OrdMlWU('B', B);
m_outside_g = OverlappingDegAv('G', g);
assert(isequal(m_outside_g.get('M'), known_overlapping_degree), ...
    [BRAPH2.STR ':OverlappingDegAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'OverlappingDegAv');
assert(isequal(m_inside_g.get('M'), known_overlapping_degree), ...
    [BRAPH2.STR ':OverlappingDegAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])