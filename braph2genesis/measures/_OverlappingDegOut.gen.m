%% ¡header!
OverlappingDegOut < DegreeOut (m, overlapping out-degree) is the graph Overlapping Out-Degree.

%%% ¡description!
The Overlapping Out-Degree (OverlappingDegOut) of a graph is the sum of the out-degrees of a node 
in all layers. 

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
OverlappingDegOut.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
OverlappingDegOut.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
OverlappingDegOut.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
OverlappingDegOut.M
%%%% ¡title!
Overlapping Out-Degree

%%% ¡prop!
%%%% ¡id!
OverlappingDegOut.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
OverlappingDegOut.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
OverlappingDegOut.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Overlapping Out-Degree.
%%%% ¡default!
'OverlappingDegOut'

%%% ¡prop!
NAME (constant, string) is the name of the Overlapping Out-Degree.
%%%% ¡default!
'Overlapping Out-Degree'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the Overlapping Out-Degree.
%%%% ¡default!
'The Overlapping Out-Degree (OverlappingDegOut) of a graph is the sum of the out-degrees of a node in all layers.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Overlapping Out-Degree.
%%%% ¡settings!
'OverlappingDegOut'

%%% ¡prop!
ID (data, string) is a few-letter code of the Overlapping Out-Degree.
%%%% ¡default!
'OverlappingDegOut ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Overlapping Out-Degree.
%%%% ¡default!
'Overlapping Out-Degree label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the Overlapping Out-Degree.
%%%% ¡default!
'Overlapping Out-Degree notes'

%%% ¡prop!
SHAPE (constant, scalar) is the measure shape __Measure.NODAL__.
%%%% ¡default!
Measure.NODAL

%%% ¡prop!
SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.
%%%% ¡default!
Measure.SUPERGLOBAL

%%% ¡prop!
PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.
%%%% ¡default!
Measure.NONPARAMETRIC

%%% ¡prop!
COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
%%%% ¡default!
{'MultiplexWD' 'MultiplexBD' 'MultilayerWD' 'MultilayerBD' 'OrdMxBD' 'OrdMxWD' 'OrdMlBD' 'OrdMlWD'};

%%% ¡prop!
M (result, cell) is the Overlapping Out-Degree.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
l = g.get('LAYERNUMBER');
ls = g.get('PARTITIONS');

if l == 0
    value = {};
else
    N = g.get('NODENUMBER');
    out_degree = calculateValue@DegreeOut(m, prop);
    overlapping_out_degree = zeros(N(1), 1);

    for li = 1:l 
        overlapping_out_degree = overlapping_out_degree + out_degree{li};
    end
    value = {overlapping_out_degree};
end

%% ¡tests!

%%% ¡excluded_props!
[OverlappingDegOut.PFM]

%%% ¡test!
%%%% ¡name!
MultiplexBD
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0   1   0
    1   0   0
    1   0   0
    ];
B22 = [
    0   1   0
    1   0   1
    0   0   0
    ];
B = {B11 B22};

known_overlapping_out_degree = {[2, 3, 1]'};

g = MultiplexBD('B', B);
m_outside_g = OverlappingDegOut('G', g);
assert(isequal(m_outside_g.get('M'), known_overlapping_out_degree), ...
    [BRAPH2.STR ':OverlappingDegOut:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'OverlappingDegOut');
assert(isequal(m_inside_g.get('M'), known_overlapping_out_degree), ...
    [BRAPH2.STR ':OverlappingDegOut:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexWD
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0   .4  1
    0   0   0
    1   0   0
    ];
B22 = [
    0   1   0
    1   0   0
    0   .3  0
    ];
B = {B11 B22};

known_overlapping_out_degree = {[3, 1, 2]'};

g = MultiplexWD('B', B);
m_outside_g = OverlappingDegOut('G', g);
assert(isequal(m_outside_g.get('M'), known_overlapping_out_degree), ...
    [BRAPH2.STR ':OverlappingDegOut:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'OverlappingDegOut');
assert(isequal(m_inside_g.get('M'), known_overlapping_out_degree), ...
    [BRAPH2.STR ':OverlappingDegOut:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultilayerBD
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0   1   0
    1   0   0
    1   0   0
    ];
B22 = [
    0   1   0
    1   0   1
    0   0   0
    ];
B12 = rand(size(B11,1),size(B22,2));
B21 = B12';
B = {B11 B12;
     B21 B22};

known_overlapping_out_degree = {[2, 3, 1]'};

g = MultilayerBD('B', B);
m_outside_g = OverlappingDegOut('G', g);
assert(isequal(m_outside_g.get('M'), known_overlapping_out_degree), ...
    [BRAPH2.STR ':OverlappingDegOut:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'OverlappingDegOut');
assert(isequal(m_inside_g.get('M'), known_overlapping_out_degree), ...
    [BRAPH2.STR ':OverlappingDegOut:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
OrdMlBD
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0   1   0
    1   0   0
    1   0   0
    ];
B22 = [
    0   1   0
    1   0   1
    0   0   0
    ];
B12 = rand(size(B11,1),size(B22,2));
B21 = B12';
B = {B11 B12;
     B21 B22};

known_overlapping_out_degree = {[2, 3, 1]'};

g = OrdMlBD('B', B);
m_outside_g = OverlappingDegOut('G', g);
assert(isequal(m_outside_g.get('M'), known_overlapping_out_degree), ...
    [BRAPH2.STR ':OverlappingDegOut:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'OverlappingDegOut');
assert(isequal(m_inside_g.get('M'), known_overlapping_out_degree), ...
    [BRAPH2.STR ':OverlappingDegOut:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])