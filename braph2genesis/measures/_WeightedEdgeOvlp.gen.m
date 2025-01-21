%% ¡header!
WeightedEdgeOvlp < Measure (m, weighted edge overlap) is the graph Weighted Edge Overlap.

%%% ¡description!
The Weighted Edge Overlap (WeightedEdgeOvlp) of a graph is the average weight of an edge 
across all layers.

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
WeightedEdgeOvlp.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
WeightedEdgeOvlp.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
WeightedEdgeOvlp.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
WeightedEdgeOvlp.M
%%%% ¡title!
Weighted Edge Overlap

%%% ¡prop!
%%%% ¡id!
WeightedEdgeOvlp.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
WeightedEdgeOvlp.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
WeightedEdgeOvlp.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Weighted Edge Overlap.
%%%% ¡default!
'WeightedEdgeOvlp'

%%% ¡prop!
NAME (constant, string) is the name of the Weighted Edge Overlap.
%%%% ¡default!
'Weighted Edge Overlap'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the Weighted Edge Overlap.
%%%% ¡default!
'The Weighted Edge Overlap (WeightedEdgeOvlp) of a graph is the average weight of an edge across all layers.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Weighted Edge Overlap.
%%%% ¡settings!
'WeightedEdgeOvlp'

%%% ¡prop!
ID (data, string) is a few-letter code of the Weighted Edge Overlap.
%%%% ¡default!
'WeightedEdgeOvlp ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Weighted Edge Overlap.
%%%% ¡default!
'Weighted Edge Overlap label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the Weighted Edge Overlap.
%%%% ¡default!
'Weighted Edge Overlap notes'

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
{'MultiplexWU' 'MultiplexWD' 'OrdMxWU' 'OrdMxWD' 'MultilayerWU' 'MultilayerWD' 'OrdMxWU' 'OrdMxWD'};

%%% ¡prop!
M (result, cell) is the Weighted Edge Overlap.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
l = g.get('LAYERNUMBER');

if l == 0
    value = {};
else
    N = g.get('NODENUMBER');
   weighted_edge_overlap = zeros(N(1));

    for li = 1:l
        Aii = A{li, li};
        weighted_edge_overlap = weighted_edge_overlap + Aii;
    end
    value = {weighted_edge_overlap / l};
end

%% ¡tests!

%%% ¡excluded_props!
[WeightedEdgeOvlp.PFM]

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
    1   0   .4
    0   .4  0
    ];
B = {B11 B22};

known_weighted_edge_overlap = {[
    0   .6  0.5
    .6   0  .2
    .5  .2  0
    ]};

g = MultiplexWU('B', B);
m_outside_g = WeightedEdgeOvlp('G', g);
assert(isequal(m_outside_g.get('M'), known_weighted_edge_overlap), ...
    [BRAPH2.STR ':WeightedEdgeOvlp:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'WeightedEdgeOvlp');
assert(isequal(m_inside_g.get('M'), known_weighted_edge_overlap), ...
    [BRAPH2.STR ':WeightedEdgeOvlp:' BRAPH2.FAIL_TEST], ...
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
    1   0   .4
    0   .4  0
    ];
B = {B11 B22};

known_weighted_edge_overlap = {[
    0   .6  0
    .6  0   .2
    .5  .2  0
    ]};

g = MultiplexWD('B', B);
m_outside_g = WeightedEdgeOvlp('G', g);
assert(isequal(m_outside_g.get('M'), known_weighted_edge_overlap), ...
    [BRAPH2.STR ':WeightedEdgeOvlp:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'WeightedEdgeOvlp');
assert(isequal(m_inside_g.get('M'), known_weighted_edge_overlap), ...
    [BRAPH2.STR ':WeightedEdgeOvlp:' BRAPH2.FAIL_TEST], ...
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
    1   0   .4
    0   .4  0
    ];
B = {B11 B22};

known_weighted_edge_overlap = {[
    0   .6  0.5
    .6   0  .2
    .5  .2  0
    ]};

g = OrdMxWU('B', B);
m_outside_g = WeightedEdgeOvlp('G', g);
assert(isequal(m_outside_g.get('M'), known_weighted_edge_overlap), ...
    [BRAPH2.STR ':WeightedEdgeOvlp:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'WeightedEdgeOvlp');
assert(isequal(m_inside_g.get('M'), known_weighted_edge_overlap), ...
    [BRAPH2.STR ':WeightedEdgeOvlp:' BRAPH2.FAIL_TEST], ...
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
    1   0   .4
    0   .4  0
    ];
B12 = rand(size(B11,1),size(B22,2));
B21 = B12';
B = {B11 B12;
     B21 B22};

known_weighted_edge_overlap = {[
    0   .6  0.5
    .6   0  .2
    .5  .2  0
    ]};

g = MultilayerWU('B', B);
m_outside_g = WeightedEdgeOvlp('G', g);
assert(isequal(m_outside_g.get('M'), known_weighted_edge_overlap), ...
    [BRAPH2.STR ':WeightedEdgeOvlp:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'WeightedEdgeOvlp');
assert(isequal(m_inside_g.get('M'), known_weighted_edge_overlap), ...
    [BRAPH2.STR ':WeightedEdgeOvlp:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])