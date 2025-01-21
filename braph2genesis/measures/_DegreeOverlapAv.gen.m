%% ¡header!
DegreeOverlapAv < DegreeOverlap (m, average average degree overlap) is the graph Average Degree Overlap.

%%% ¡description!
The Average Degree Overlap (DegreeOverlapAv) is the average of the number of edges connected 
to a node in all layers. Connection weights are ignored in calculations.

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
DegreeOverlapAv.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
DegreeOverlapAv.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
DegreeOverlapAv.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
DegreeOverlapAv.M
%%%% ¡title!
Average Degree Overlap

%%% ¡prop!
%%%% ¡id!
DegreeOverlapAv.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
DegreeOverlapAv.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
DegreeOverlapAv.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Average Degree Overlap.
%%%% ¡default!
'DegreeOverlapAv'

%%% ¡prop!
NAME (constant, string) is the name of the Average Degree Overlap.
%%%% ¡default!
'Average Degree Overlap'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the Average Degree Overlap.
%%%% ¡default!
'The Average Degree Overlap (DegreeOverlapAv) is the average of the number of edges connected to a node in all layers. Connection weights are ignored in calculations.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Average Degree Overlap.
%%%% ¡settings!
'DegreeOverlapAv'

%%% ¡prop!
ID (data, string) is a few-letter code of the Average Degree Overlap.
%%%% ¡default!
'DegreeOverlapAv ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Average Degree Overlap.
%%%% ¡default!
'Average Degree Overlap label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the Average Degree Overlap.
%%%% ¡default!
'Average Degree Overlap notes'

%%% ¡prop!
SHAPE (constant, scalar) is the measure shape __Measure.NODAL__.
%%%% ¡default!
Measure.GLOBAL

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
M (result, cell) is the Average Degree Overlap.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
l = g.get('LAYERNUMBER');
ls = g.get('PARTITIONS');

if l == 0
    value = {};
else
    degree_overlap = calculateValue@DegreeOverlap(m, prop);
    degree_overlap_av = cell(length(ls), 1);

    for i=1:length(ls)
        degree_overlap_av(i) = {mean(degree_overlap{i})};
    end
    value = degree_overlap_av;
end

%% ¡tests!

%%% ¡excluded_props!
[DegreeOverlapAv.PFM]

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

known_degree_overlap = {mean([1 1 0]')};

g = MultiplexWU('B', B);
m_outside_g = DegreeOverlapAv('G', g);
assert(isequal(m_outside_g.get('M'), known_degree_overlap), ...
    [BRAPH2.STR ':DegreeOverlapAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'DegreeOverlapAv');
assert(isequal(m_inside_g.get('M'), known_degree_overlap), ...
    [BRAPH2.STR ':DegreeOverlapAv:' BRAPH2.FAIL_TEST], ...
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

known_degree_overlap = {mean([1 1 0]')};

g = MultiplexBU('B', B);
m_outside_g = DegreeOverlapAv('G', g);
assert(isequal(m_outside_g.get('M'), known_degree_overlap), ...
    [BRAPH2.STR ':DegreeOverlapAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'DegreeOverlapAv');
assert(isequal(m_inside_g.get('M'), known_degree_overlap), ...
    [BRAPH2.STR ':DegreeOverlapAv:' BRAPH2.FAIL_TEST], ...
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

known_degree_overlap = {
    mean([1 1 0]')
    0};

g = MultiplexBUD('B', B, 'DENSITIES', [90 10]);

m_outside_g = DegreeOverlapAv('G', g);
assert(isequal(m_outside_g.get('M'), known_degree_overlap), ...
    [BRAPH2.STR ':DegreeOverlapAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'DegreeOverlapAv');
assert(isequal(m_inside_g.get('M'), known_degree_overlap), ...
    [BRAPH2.STR ':DegreeOverlapAv:' BRAPH2.FAIL_TEST], ...
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

known_degree_overlap = {mean([1 1 0]')};

g = MultilayerBU('B', B);
m_outside_g = DegreeOverlapAv('G', g);
assert(isequal(m_outside_g.get('M'), known_degree_overlap), ...
    [BRAPH2.STR ':DegreeOverlapAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'DegreeOverlapAv');
assert(isequal(m_inside_g.get('M'), known_degree_overlap), ...
    [BRAPH2.STR ':DegreeOverlapAv:' BRAPH2.FAIL_TEST], ...
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

known_degree_overlap = {mean([1 1 0]')};

g = OrdMlBU('B', B);
m_outside_g = DegreeOverlapAv('G', g);
assert(isequal(m_outside_g.get('M'), known_degree_overlap), ...
    [BRAPH2.STR ':DegreeOverlapAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'DegreeOverlapAv');
assert(isequal(m_inside_g.get('M'), known_degree_overlap), ...
    [BRAPH2.STR ':DegreeOverlapAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])