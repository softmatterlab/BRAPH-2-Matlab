%% ¡header!
DegreeOverlap < EdgeOverlap (m, degree overlap) is the graph Degree Overlap.

%%% ¡description!
The Degree Overlap (DegreeOverlap) is the number of edges connected to a node in all layers. 
Connection weights are ignored in calculations.

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
DegreeOverlap.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
DegreeOverlap.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
DegreeOverlap.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
DegreeOverlap.M
%%%% ¡title!
Degree Overlap

%%% ¡prop!
%%%% ¡id!
DegreeOverlap.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
DegreeOverlap.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
DegreeOverlap.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Degree Overlap.
%%%% ¡default!
'DegreeOverlap'

%%% ¡prop!
NAME (constant, string) is the name of the Degree Overlap.
%%%% ¡default!
'Degree Overlap'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the Degree Overlap.
%%%% ¡default!
'The Degree Overlap (DegreeOverlap) is the number of edges connected to a node in all layers. Connection weights are ignored in calculations.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Degree Overlap.
%%%% ¡settings!
'DegreeOverlap'

%%% ¡prop!
ID (data, string) is a few-letter code of the Degree Overlap.
%%%% ¡default!
'DegreeOverlap ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Degree Overlap.
%%%% ¡default!
'Degree Overlap label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the Degree Overlap.
%%%% ¡default!
'Degree Overlap notes'

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
{'MultiplexWU' 'MultiplexBU' 'MultiplexBUD' 'MultiplexBUT' 'OrdMxWU' 'OrdMxBU' 'MultilayerWU' 'MultilayerBU' 'MultilayerBUD' 'MultilayerBUT' 'OrdMlBU' 'OrdMlWU'};

%%% ¡prop!
M (result, cell) is the Degree Overlap.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
l = g.get('LAYERNUMBER');
ls = g.get('PARTITIONS');

if l == 0
    value = {};
else
    edge_overlap = calculateValue@EdgeOverlap(m, prop);
    degree_overlap = cell(length(ls), 1);
    
    for i=1:length(ls)
        edge_overlap_partition = edge_overlap{i};
        degree_overlap(i) = {sum(edge_overlap_partition == 1, 2)};
    end
    value = degree_overlap;
end

%% ¡tests!

%%% ¡excluded_props!
[DegreeOverlap.PFM]

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

known_degree_overlap = {[1 1 0]'};

g = MultiplexWU('B', B);
m_outside_g = DegreeOverlap('G', g);
assert(isequal(m_outside_g.get('M'), known_degree_overlap), ...
    [BRAPH2.STR ':DegreeOverlap:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'DegreeOverlap');
assert(isequal(m_inside_g.get('M'), known_degree_overlap), ...
    [BRAPH2.STR ':DegreeOverlap:' BRAPH2.FAIL_TEST], ...
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

known_degree_overlap = {[1 1 0]'};

g = MultiplexBU('B', B);
m_outside_g = DegreeOverlap('G', g);
assert(isequal(m_outside_g.get('M'), known_degree_overlap), ...
    [BRAPH2.STR ':DegreeOverlap:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'DegreeOverlap');
assert(isequal(m_inside_g.get('M'), known_degree_overlap), ...
    [BRAPH2.STR ':DegreeOverlap:' BRAPH2.FAIL_TEST], ...
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

known_degree_overlap = {
    [1 1 0]'
    [0 0 0]'};

g = MultiplexBUT('B', B, 'THRESHOLDS', [0 1]);

m_outside_g = DegreeOverlap('G', g);
assert(isequal(m_outside_g.get('M'), known_degree_overlap), ...
    [BRAPH2.STR ':DegreeOverlap:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'DegreeOverlap');
assert(isequal(m_inside_g.get('M'), known_degree_overlap), ...
    [BRAPH2.STR ':DegreeOverlap:' BRAPH2.FAIL_TEST], ...
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
    0   1   0
    1   0   1
    0   1   0
    ];
B12 = rand(size(B11,1),size(B22,2));
B21 = B12';
B = {B11 B12;
    B21 B22};

known_degree_overlap = {[1 1 0]'};

g = MultilayerBU('B', B);
m_outside_g = DegreeOverlap('G', g);
assert(isequal(m_outside_g.get('M'), known_degree_overlap), ...
    [BRAPH2.STR ':DegreeOverlap:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'DegreeOverlap');
assert(isequal(m_inside_g.get('M'), known_degree_overlap), ...
    [BRAPH2.STR ':DegreeOverlap:' BRAPH2.FAIL_TEST], ...
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
    0   1   0
    1   0   1
    0   1   0
    ];
B12 = rand(size(B11,1),size(B22,2));
B21 = B12';
B = {B11 B12;
    B21 B22};

known_degree_overlap = {[1 1 0]'};

g = OrdMlBU('B', B);
m_outside_g = DegreeOverlap('G', g);
assert(isequal(m_outside_g.get('M'), known_degree_overlap), ...
    [BRAPH2.STR ':DegreeOverlap:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'DegreeOverlap');
assert(isequal(m_inside_g.get('M'), known_degree_overlap), ...
    [BRAPH2.STR ':DegreeOverlap:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])