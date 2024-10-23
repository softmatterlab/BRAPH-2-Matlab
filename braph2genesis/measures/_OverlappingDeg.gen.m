%% ¡header!
OverlappingDeg < Degree (m, ovrlapdeg) is the graph Overlapping Degree.

%%% ¡description!
The Overlapping Degree (OverlappingDeg) of a graph is the sum of the 
 degrees of a node in all layers.

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
OverlappingDeg.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
OverlappingDeg.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
OverlappingDeg.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
OverlappingDeg.M
%%%% ¡title!
Overlapping Degree

%%% ¡prop!
%%%% ¡id!
OverlappingDeg.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
OverlappingDeg.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
OverlappingDeg.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Overlapping Degree.
%%%% ¡default!
'OverlappingDeg'

%%% ¡prop!
NAME (constant, string) is the name of the Overlapping Degree.
%%%% ¡default!
'Overlapping Degree'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the Overlapping Degree.
%%%% ¡default!
'The Overlapping Degree (OverlappingDeg) of a graph is the sum of the degrees of a node in all layers.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Overlapping Degree.
%%%% ¡settings!
'OverlappingDeg'

%%% ¡prop!
ID (data, string) is a few-letter code of the Overlapping Degree.
%%%% ¡default!
'OverlappingDeg ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Overlapping Degree.
%%%% ¡default!
'Overlapping Degree label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the Overlapping Degree.
%%%% ¡default!
'Overlapping Degree notes'

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
{'MultiplexWU' 'OrdMxWU' 'MultiplexBU' 'MultiplexBUD' 'MultiplexBUT' 'MultilayerWU' 'OrdMlWU' 'MultilayerBU'};

%%% ¡prop!
M (result, cell) is the Overlapping Degree.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
l = g.get('LAYERNUMBER');
ls = g.get('PARTITIONS');

if l == 0
    value = {};
else

    N = g.get('NODENUMBER');
    degree = calculateValue@Degree(m, prop);
    overlapping_degree = cell(length(ls), 1);
    
    count = 1;
    for i = 1:1:length(ls)
        overlapping_degree_partition = zeros(N(1), 1);
        for li = count:1:ls(i) + count - 1
            overlapping_degree_partition = overlapping_degree_partition + degree{li};
        end
        count = count + ls(i);
        overlapping_degree(i) = {overlapping_degree_partition};
    end
    value = overlapping_degree;
    if contains(class(g),'Multilayer') | contains(class(g),'OrdMl')
     value = {[sum(cell2mat(overlapping_degree'),2)]};
    end 
end

%% ¡tests!

%%% ¡excluded_props!
[OverlappingDeg.PFM]

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

known_overlapping_degree = {[3, 3, 2]'};

g = MultiplexWU('B', B);
m_outside_g = OverlappingDeg('G', g);
assert(isequal(m_outside_g.get('M'), known_overlapping_degree), ...
    [BRAPH2.STR ':OverlappingDeg:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'OverlappingDeg');
assert(isequal(m_inside_g.get('M'), known_overlapping_degree), ...
    [BRAPH2.STR ':OverlappingDeg:' BRAPH2.FAIL_TEST], ...
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

known_overlapping_degree = {[3, 3, 2]'};

g = MultiplexBU('B', B);
m_outside_g = OverlappingDeg('G', g);
assert(isequal(m_outside_g.get('M'), known_overlapping_degree), ...
    [BRAPH2.STR ':OverlappingDeg:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'OverlappingDeg');
assert(isequal(m_inside_g.get('M'), known_overlapping_degree), ...
    [BRAPH2.STR ':OverlappingDeg:' BRAPH2.FAIL_TEST], ...
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

known_overlapping_degree = { ...
    [3, 3, 2]'
    [0, 0, 0]'
    };

g = MultiplexBUT('B', B, 'THRESHOLDS', [0 1]);

m_outside_g = OverlappingDeg('G', g);
assert(isequal(m_outside_g.get('M'), known_overlapping_degree), ...
    [BRAPH2.STR ':OverlappingDeg:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'OverlappingDeg');
assert(isequal(m_inside_g.get('M'), known_overlapping_degree), ...
    [BRAPH2.STR ':OverlappingDeg:' BRAPH2.FAIL_TEST], ...
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
    [0, 0, 0]'
    [4, 4, 4]'
    };

g = MultiplexBUD('B', B, 'DENSITIES', [0 100]);

m_outside_g = OverlappingDeg('G', g);
assert(isequal(m_outside_g.get('M'), known_overlapping_degree), ...
    [BRAPH2.STR ':OverlappingDeg:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'OverlappingDeg');
assert(isequal(m_inside_g.get('M'), known_overlapping_degree), ...
    [BRAPH2.STR ':OverlappingDeg:' BRAPH2.FAIL_TEST], ...
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

known_overlapping_degree = {[3, 3, 2]'};

g = MultilayerWU('B', B);
m_outside_g = OverlappingDeg('G', g);
assert(isequal(m_outside_g.get('M'), known_overlapping_degree), ...
    [BRAPH2.STR ':OverlappingDeg:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'OverlappingDeg');
assert(isequal(m_inside_g.get('M'), known_overlapping_degree), ...
    [BRAPH2.STR ':OverlappingDeg:' BRAPH2.FAIL_TEST], ...
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

known_overlapping_degree = {[3, 3, 2]'};

g = OrdMlWU('B', B);
m_outside_g = OverlappingDeg('G', g);
assert(isequal(m_outside_g.get('M'), known_overlapping_degree), ...
    [BRAPH2.STR ':OverlappingDeg:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'OverlappingDeg');
assert(isequal(m_inside_g.get('M'), known_overlapping_degree), ...
    [BRAPH2.STR ':OverlappingDeg:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])