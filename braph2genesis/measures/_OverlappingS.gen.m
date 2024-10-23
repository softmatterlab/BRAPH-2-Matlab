%% ¡header!
OverlappingS < Strength (m, overlapping strength) is the graph Overlapping Strength.

%%% ¡description!
The Overlapping Strength (OverlappingS) of a graph is the sum of the strengths of a node in 
all layers. 

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
OverlappingS.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
OverlappingS.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
OverlappingS.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
OverlappingS.M
%%%% ¡title!
Overlapping Strength

%%% ¡prop!
%%%% ¡id!
OverlappingS.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
OverlappingS.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
OverlappingS.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Overlapping Strength.
%%%% ¡default!
'OverlappingS'

%%% ¡prop!
NAME (constant, string) is the name of the Overlapping Strength.
%%%% ¡default!
'Overlapping Strength'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the Overlapping Strength.
%%%% ¡default!
'The Overlapping Strength (OverlappingS) of a graph is the sum of the strengths of a node in all layers.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Overlapping Strength.
%%%% ¡settings!
'OverlappingS'

%%% ¡prop!
ID (data, string) is a few-letter code of the Overlapping Strength.
%%%% ¡default!
'OverlappingS ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Overlapping Strength.
%%%% ¡default!
'Overlapping Strength label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the Overlapping Strength.
%%%% ¡default!
'Overlapping Strength notes'

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
{'MultiplexWU' 'OrdMxWU' 'MultilayerWU' 'OrdMlWU'}

%%% ¡prop!
M (result, cell) is the Overlapping Strength.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
l = g.get('LAYERNUMBER');

if l == 0
    value = {};
else
    N = g.get('NODENUMBER');
    strength = calculateValue@Strength(m, prop);	
    overlapping_strength = zeros(N(1), 1);
    for li = 1:l 
        overlapping_strength = overlapping_strength + strength{li};
    end
    value = {overlapping_strength};
end

%% ¡tests!

%%% ¡excluded_props!
[OverlappingS.PFM]

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

known_overlapping_strength = {[2.2 1.5 1.3]'};

g = MultiplexWU('B', B);
m_outside_g = OverlappingS('G', g);
assert(isequal(m_outside_g.get('M'), known_overlapping_strength), ...
    [BRAPH2.STR ':OverlappingS:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'OverlappingS');
assert(isequal(m_inside_g.get('M'), known_overlapping_strength), ...
    [BRAPH2.STR ':OverlappingS:' BRAPH2.FAIL_TEST], ...
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

known_overlapping_strength = {[2.2 1.5 1.3]'};

g = OrdMxWU('B', B);
m_outside_g = OverlappingS('G', g);
assert(isequal(m_outside_g.get('M'), known_overlapping_strength), ...
    [BRAPH2.STR ':OverlappingS:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'OverlappingS');
assert(isequal(m_inside_g.get('M'), known_overlapping_strength), ...
    [BRAPH2.STR ':OverlappingS:' BRAPH2.FAIL_TEST], ...
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

known_overlapping_strength = {[2.2 1.5 1.3]'};

g = MultilayerWU('B', B);
m_outside_g = OverlappingS('G', g);
assert(isequal(m_outside_g.get('M'), known_overlapping_strength), ...
    [BRAPH2.STR ':OverlappingS:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'OverlappingS');
assert(isequal(m_inside_g.get('M'), known_overlapping_strength), ...
    [BRAPH2.STR ':OverlappingS:' BRAPH2.FAIL_TEST], ...
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

known_overlapping_strength = {[2.2 1.5 1.3]'};

g = OrdMlWU('B', B);
m_outside_g = OverlappingS('G', g);
assert(isequal(m_outside_g.get('M'), known_overlapping_strength), ...
    [BRAPH2.STR ':OverlappingS:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'OverlappingS');
assert(isequal(m_inside_g.get('M'), known_overlapping_strength), ...
    [BRAPH2.STR ':OverlappingS:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])