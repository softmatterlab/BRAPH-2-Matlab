%% ¡header!
EdgeOverlap < Measure (m, edge overlap) is the graph Edge Overlap.

%%% ¡description!
The Edge Overlap (EdgeOverlap) of a graph is the fraction of layers in which an edge between 
a pair of nodes exists. Connection weights are ignored in calculations.

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
EdgeOverlap.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
EdgeOverlap.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
EdgeOverlap.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
EdgeOverlap.M
%%%% ¡title!
Edge Overlap

%%% ¡prop!
%%%% ¡id!
EdgeOverlap.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
EdgeOverlap.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
EdgeOverlap.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Edge Overlap.
%%%% ¡default!
'EdgeOverlap'

%%% ¡prop!
NAME (constant, string) is the name of the Edge Overlap.
%%%% ¡default!
'Edge Overlap'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the Edge Overlap.
%%%% ¡default!
'The Edge Overlap (EdgeOverlap) of a graph is the fraction of layers in which an edge between a pair of nodes exists. Connection weights are ignored in calculations.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Edge Overlap.
%%%% ¡settings!
'EdgeOverlap'

%%% ¡prop!
ID (data, string) is a few-letter code of the Edge Overlap.
%%%% ¡default!
'EdgeOverlap ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Edge Overlap.
%%%% ¡default!
'Edge Overlap label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the Edge Overlap.
%%%% ¡default!
'Edge Overlap notes'

%%% ¡prop!
SHAPE (constant, scalar) is the measure shape __Measure.NODAL__.
%%%% ¡default!
Measure.BINODAL

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
{'MultiplexWU' 'MultiplexWD' 'MultiplexBU' 'MultiplexBD' 'OrdMxWU' 'OrdMxBU' 'OrdMxBUD' 'OrdMxBUT' 'MultiplexBUD' 'MultiplexBUT' 'MultilayerBUT' 'MultilayerBU' 'MultilayerBUD' 'OrdMlWU' 'OrdMlBU' 'OrdMlBUT' 'OrdMlBUD'};

%%% ¡prop!
M (result, cell) is the Edge Overlap.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
l = g.get('LAYERNUMBER');
ls = g.get('PARTITIONS');

if l == 0
    value = {};
else
   edge_overlap = cell(length(ls), 1);   
    count = 1;
    for i = 1:1:length(ls)
        N = g.get('NODENUMBER');
        edge_overlap_partition = zeros(N(1));
        for li = count:1:ls(i) + count - 1
            Aii = A{li, li};
            Aii = binarize(Aii);  % binarizes the adjacency matrix
            edge_overlap_partition = edge_overlap_partition + Aii;
        end
        count = count + ls(i);
        edge_overlap(i) = {edge_overlap_partition / ls(i)};
    end
    value = edge_overlap;
end

%% ¡tests!

%%% ¡excluded_props!
[EdgeOverlap.PFM]

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

known_edge_overlap = {[
    0   1   .5
    1   0   .5
    .5  .5  0
    ]};

g = MultiplexWU('B', B);
m_outside_g = EdgeOverlap('G', g);
assert(isequal(m_outside_g.get('M'), known_edge_overlap), ...
    [BRAPH2.STR ':EdgeOverlap:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'EdgeOverlap');
assert(isequal(m_inside_g.get('M'), known_edge_overlap), ...
    [BRAPH2.STR ':EdgeOverlap:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexWD
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0   .2  0
    .2  0   0
    1   0   0
    ];
B22 = [
    0   1   0
    1   0   .3
    0   .3  0
    ];
B = {B11 B22};

known_edge_overlap = {[
    0   1   0
    1   0   .5
    .5  .5  0
    ]};

g = MultiplexWD('B', B);
m_outside_g = EdgeOverlap('G', g);
assert(isequal(m_outside_g.get('M'), known_edge_overlap), ...
    [BRAPH2.STR ':EdgeOverlap:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'EdgeOverlap');
assert(isequal(m_inside_g.get('M'), known_edge_overlap), ...
    [BRAPH2.STR ':EdgeOverlap:' BRAPH2.FAIL_TEST], ...
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
B33 = [
    0   1   0
    1   0   0
    0   0   0
    ];
B = {B11 B22 B33};

known_edge_overlap = {[
    0    1    1/3
    1    0    1/3
    1/3  1/3  0
    ]};

g = MultiplexBU('B', B);
m_outside_g = EdgeOverlap('G', g);
assert(isequal(m_outside_g.get('M'), known_edge_overlap), ...
    [BRAPH2.STR ':EdgeOverlap:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'EdgeOverlap');
assert(isequal(m_inside_g.get('M'), known_edge_overlap), ...
    [BRAPH2.STR ':EdgeOverlap:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

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
    0   1   0
    ];
B = {B11 B22};

known_edge_overlap = {[
    0   1   0
    1   0   .5
    .5  .5  0
    ]};

g = MultiplexBD('B', B);
m_outside_g = EdgeOverlap('G', g);
assert(isequal(m_outside_g.get('M'), known_edge_overlap), ...
    [BRAPH2.STR ':EdgeOverlap:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'EdgeOverlap');
assert(isequal(m_inside_g.get('M'), known_edge_overlap), ...
    [BRAPH2.STR ':EdgeOverlap:' BRAPH2.FAIL_TEST], ...
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
B33 = [
    0   1   0
    1   0   0
    0   0   0
    ];
B = {B11 B22 B33};

known_edge_overlap_1 = [
    0    1    1/3
    1    0    1/3
    1/3  1/3  0
    ];
known_edge_overlap = {
                      known_edge_overlap_1
                      zeros(3)
                      };

g = MultiplexBUT('B', B, 'THRESHOLDS', [0 1]);

m_outside_g = EdgeOverlap('G', g);
assert(isequal(m_outside_g.get('M'), known_edge_overlap), ...
    [BRAPH2.STR ':EdgeOverlap:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'EdgeOverlap');
assert(isequal(m_inside_g.get('M'), known_edge_overlap), ...
    [BRAPH2.STR ':EdgeOverlap:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultilayerBUD
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
B33 = [
    0   1   0
    1   0   0
    0   0   0
    ];
B12 = rand(size(B11,1),size(B22,2));
B21 = B12';
B13 = rand(size(B11,1),size(B33,2));
B31 = B13';
B23 = rand(size(B22,1),size(B33,2));
B32 = B23';

B = {B11 B12 B13;
     B21 B22 B23;
     B31 B32 B33};

known_edge_overlap_1 = [
    0    1    1/3
    1    0    1/3
    1/3  1/3  0
    ];
known_edge_overlap = {
                      known_edge_overlap_1
                      zeros(3)
                      };

g = MultilayerBUD('B', B, 'DENSITIES', [90 10]);

m_outside_g = EdgeOverlap('G', g);
assert(isequal(m_outside_g.get('M'), known_edge_overlap), ...
    [BRAPH2.STR ':EdgeOverlap:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'EdgeOverlap');
assert(isequal(m_inside_g.get('M'), known_edge_overlap), ...
    [BRAPH2.STR ':EdgeOverlap:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])