%% ¡header!
MultiplexP < Measure (m, mxpart) is the graph Multiplex Participation.

%%% ¡description!
The Multiplex Participation (MultiplexP) is the nodal homogeneity of the number of 
 neighbors of a node across the layers. 
It is calculated as: Pi = L/(L - 1) [1 - sum_{l=1}^{L} (ki(l)/oi)^2] 
 where L is the number of layers, ki(l) is the degree in the l-th 
 layer and oi is the overlapping degree of the node. 
Pi = 1 when the degree is the same in all layers and Pi = 0 when a 
 node has non-zero degree in only one layer.

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
MultiplexP.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
MultiplexP.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
MultiplexP.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
MultiplexP.M
%%%% ¡title!
Multiplex Participation

%%% ¡prop!
%%%% ¡id!
MultiplexP.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
MultiplexP.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
MultiplexP.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Multiplex Participation.
%%%% ¡default!
'MultiplexP'

%%% ¡prop!
NAME (constant, string) is the name of the Multiplex Participation.
%%%% ¡default!
'Multiplex Participation'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the Multiplex Participation.
%%%% ¡default!
'The Multiplex Participation (MultiplexP) is the nodal homogeneity of the number of neighbors of a node across the layers. It is calculated as: Pi = L/(L - 1) [1 - sum_{l=1}^{L} (ki(l)/oi)^2] where L is the number of layers, ki(l) is the degree in the l-th layer and oi is the overlapping degree of the node. Pi = 1 when the degree is the same in all layers and Pi = 0 when a node has non-zero degree in only one layer.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Multiplex Participation.
%%%% ¡settings!
'MultiplexP'

%%% ¡prop!
ID (data, string) is a few-letter code of the Multiplex Participation.
%%%% ¡default!
'MultiplexP ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Multiplex Participation.
%%%% ¡default!
'Multiplex Participation label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the Multiplex Participation.
%%%% ¡default!
'Multiplex Participation notes'

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
{'MultiplexWU' 'MultiplexBU' 'MultiplexBUD' 'MultiplexBUT' 'OrdMxWU'};

%%% ¡prop!
M (result, cell) is the Multiplex Participation.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
l = g.get('LAYERNUMBER');
ls = g.get('PARTITIONS');

if l == 0
    value = {};
else
    N = g.get('NODENUMBER');
    degree = Degree('G', g).get('M');
    overlapping_degree = OverlappingDeg('G', g).get('M'); 
    multiplex_participation = cell(length(ls), 1);
    
    count = 1;
    for i = 1:1:length(ls)
       multiplex_participation_partition = zeros(N(1), 1);
        for li = count:1:ls(i) + count - 1
            multiplex_participation_partition = multiplex_participation_partition + (degree{li}./overlapping_degree{i}).^2;
        end
        multiplex_participation_partition = ls(i) / (ls(i) - 1) * (1 - multiplex_participation_partition);
        multiplex_participation_partition(isnan(multiplex_participation_partition)) = 0;  % Should return zeros, since NaN happens when strength = 0 and overlapping strength = 0 for all regions
        count = count + ls(i);
        multiplex_participation(i) = {multiplex_participation_partition};
    end
    value = multiplex_participation;
end

%% ¡tests!

%%% ¡excluded_props!
[MultiplexP.PFM]

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
B = {B11  B22};
known_multiplex_participation = {[8/9 8/9 1]'};

g = MultiplexWU('B', B);
m_outside_g = MultiplexP('G', g);

assert(isequal(m_outside_g.get('M'), known_multiplex_participation), ...
    [BRAPH2.STR ':MultiplexP:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'MultiplexP');
assert(isequal(m_inside_g.get('M'), known_multiplex_participation), ...
    [BRAPH2.STR ':MultiplexP:' BRAPH2.FAIL_TEST], ...
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

known_multiplex_participation = {[15/16 15/16 3/4]'};

g = MultiplexBU('B', B);
m_outside_g = MultiplexP('G', g);
assert(isequal(m_outside_g.get('M'), known_multiplex_participation), ...
    [BRAPH2.STR ':MultiplexP:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'MultiplexP');
assert(isequal(m_inside_g.get('M'), known_multiplex_participation), ...
    [BRAPH2.STR ':MultiplexP:' BRAPH2.FAIL_TEST], ...
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

known_multiplex_participation = {...
    [15/16 15/16 3/4]'
    [0, 0, 0]'
    };

g = MultiplexBUT('B', B, 'THRESHOLDS', [0 1]);

m_outside_g = MultiplexP('G', g);
assert(isequal(m_outside_g.get('M'), known_multiplex_participation), ...
    [BRAPH2.STR ':MultiplexP:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'MultiplexP');
assert(isequal(m_inside_g.get('M'), known_multiplex_participation), ...
    [BRAPH2.STR ':MultiplexP:' BRAPH2.FAIL_TEST], ...
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
B33 = [
    0   1   0
    1   0   0
    0   0   0
    ];
B = {B11 B22 B33};

known_multiplex_participation = {...    
    [0, 0, 0]'
    [15/16 15/16 3/4]'
    };

g = MultiplexBUD('B', B, 'DENSITIES', [0 90]);

m_outside_g = MultiplexP('G', g);
assert(isequal(m_outside_g.get('M'), known_multiplex_participation), ...
    [BRAPH2.STR ':MultiplexP:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'MultiplexP');
assert(isequal(m_inside_g.get('M'), known_multiplex_participation), ...
    [BRAPH2.STR ':MultiplexP:' BRAPH2.FAIL_TEST], ...
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
B = {B11  B22};
known_multiplex_participation = {[8/9 8/9 1]'};

g = OrdMxWU('B', B);
m_outside_g = MultiplexP('G', g);

assert(isequal(m_outside_g.get('M'), known_multiplex_participation), ...
    [BRAPH2.STR ':MultiplexP:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'MultiplexP');
assert(isequal(m_inside_g.get('M'), known_multiplex_participation), ...
    [BRAPH2.STR ':MultiplexP:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])