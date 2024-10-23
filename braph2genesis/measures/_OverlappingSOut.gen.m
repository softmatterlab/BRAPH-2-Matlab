%% ¡header!
OverlappingSOut < StrengthOut (m, overlapping out-strength) is the graph Overlapping Out-Strength.

%%% ¡description!
The Overlapping Out-Strength (OverlappingSOut) of a graph is the sum of the out-strengths of a 
 node in all layers. 

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
OverlappingSOut.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
OverlappingSOut.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
OverlappingSOut.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
OverlappingSOut.M
%%%% ¡title!
Overlapping Out-Strength

%%% ¡prop!
%%%% ¡id!
OverlappingSOut.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
OverlappingSOut.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
OverlappingSOut.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Overlapping Out-Strength.
%%%% ¡default!
'OverlappingSOut'

%%% ¡prop!
NAME (constant, string) is the name of the Overlapping Out-Strength.
%%%% ¡default!
'Overlapping Out-Strength'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the Overlapping Out-Strength.
%%%% ¡default!
'The Overlapping Out-Strength (OverlappingSOut) of a graph is the sum of the out-strengths of a node in all layers.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Overlapping Out-Strength.
%%%% ¡settings!
'OverlappingSOut'

%%% ¡prop!
ID (data, string) is a few-letter code of the Overlapping Out-Strength.
%%%% ¡default!
'OverlappingSOut ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Overlapping Out-Strength.
%%%% ¡default!
'Overlapping Out-Strength label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the Overlapping Out-Strength.
%%%% ¡default!
'Overlapping Out-Strength notes'

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
{'MultiplexWD' 'MultilayerWD' 'OrdMxWD' 'OrdMlWD'};

%%% ¡prop!
M (result, cell) is the Overlapping Out-Strength.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
l = g.get('LAYERNUMBER');

if l == 0
    value = {};
else
    N = g.get('NODENUMBER');
    strength = calculateValue@StrengthOut(m, prop);	
    overlapping_strength = zeros(N(1), 1);
    for li = 1:l  
        overlapping_strength = overlapping_strength + strength{li};
    end
    value = {overlapping_strength};
end

%% ¡tests!

%%% ¡excluded_props!
[OverlappingSOut.PFM]

%%% ¡test!
%%%% ¡name!
MultiplexWD
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0   .2  1
    .3  0   .1
    1   0   0
    ];
B22 = [
    0   1   0
    1   0   0
    .7  .3  0
    ];
B = {B11 B22};

known_overlapping_in_strength = {[2.2 1.4 2]'};

g = MultiplexWD('B', B);
m_outside_g = OverlappingSOut('G', g);
assert(isequal(m_outside_g.get('M'), known_overlapping_in_strength), ...
    [BRAPH2.STR ':OverlappingSOut:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'OverlappingSOut');
assert(isequal(m_inside_g.get('M'), known_overlapping_in_strength), ...
    [BRAPH2.STR ':OverlappingSOut:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultilayerWD
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0   .2  1
    .3  0   .1
    1   0   0
    ];
B22 = [
    0   1   0
    1   0   0
    .7  .3  0
    ];
B12 = rand(size(B11,1),size(B22,2));
B21 = B12';
B = {B11 B12;
     B21 B22};

known_overlapping_in_strength = {[2.2 1.4 2]'};

g = MultilayerWD('B', B);
m_outside_g = OverlappingSOut('G', g);
assert(isequal(m_outside_g.get('M'), known_overlapping_in_strength), ...
    [BRAPH2.STR ':OverlappingSOut:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'OverlappingSOut');
assert(isequal(m_inside_g.get('M'), known_overlapping_in_strength), ...
    [BRAPH2.STR ':OverlappingSOut:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
OrdMlWD
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0   .2  1
    .3  0   .1
    1   0   0
    ];
B22 = [
    0   1   0
    1   0   0
    .7  .3  0
    ];
B12 = rand(size(B11,1),size(B22,2));
B21 = B12';
B = {B11 B12;
     B21 B22};

known_overlapping_in_strength = {[2.2 1.4 2]'};

g = OrdMlWD('B', B);
m_outside_g = OverlappingSOut('G', g);
assert(isequal(m_outside_g.get('M'), known_overlapping_in_strength), ...
    [BRAPH2.STR ':OverlappingSOut:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'OverlappingSOut');
assert(isequal(m_inside_g.get('M'), known_overlapping_in_strength), ...
    [BRAPH2.STR ':OverlappingSOut:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])