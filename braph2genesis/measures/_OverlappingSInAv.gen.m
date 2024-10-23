%% ¡header!
OverlappingSInAv < OverlappingSIn (m, average overlapping in-strength) is the graph Average Overlapping In-Strength.

%%% ¡description!
The Average Overlapping In-Strength (OverlappingSInAv) of a graph is the average of the sum of the 
 in-strengths of a node in all layers. 

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
OverlappingSInAv.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
OverlappingSInAv.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
OverlappingSInAv.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
OverlappingSInAv.M
%%%% ¡title!
Average Overlapping In-Strength

%%% ¡prop!
%%%% ¡id!
OverlappingSInAv.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
OverlappingSInAv.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
OverlappingSInAv.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Average Overlapping In-Strength.
%%%% ¡default!
'OverlappingSInAv'

%%% ¡prop!
NAME (constant, string) is the name of the Average Overlapping In-Strength.
%%%% ¡default!
'Average Overlapping In-Strength'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the Average Overlapping In-Strength.
%%%% ¡default!
'The Average Overlapping In-Strength (OverlappingSInAv) of a graph is the average of the sum of the in-strengths of a node in all layers.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Average Overlapping In-Strength.
%%%% ¡settings!
'OverlappingSInAv'

%%% ¡prop!
ID (data, string) is a few-letter code of the Average Overlapping In-Strength.
%%%% ¡default!
'OverlappingSInAv ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Average Overlapping In-Strength.
%%%% ¡default!
'Average Overlapping In-Strength label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the Average Overlapping In-Strength.
%%%% ¡default!
'Average Overlapping In-Strength notes'

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
{'MultiplexWD' 'MultilayerWD' 'OrdMlWD' 'OrdMxWD'};

%%% ¡prop!
M (result, cell) is the Average Overlapping In-Strength.
%%%% ¡calculate!
g = m.get('G');  % graph from measure class
overlapping_in_strength = calculateValue@OverlappingSIn(m, prop);
l = g.get('LAYERNUMBER');

if l == 0
    value = {};
else
    value = {mean(cell2mat(overlapping_in_strength))};
end

%% ¡tests!

%%% ¡excluded_props!
[OverlappingSInAv.PFM]

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
    0   1   .4
    1   0   0
    .7  .3  0
    ];
B = {B11 B22};

known_overlapping_in_strength = {mean([3 1.5 1.5])};

g = MultiplexWD('B', B);
m_outside_g = OverlappingSInAv('G', g);
assert(isequal(m_outside_g.get('M'), known_overlapping_in_strength), ...
    [BRAPH2.STR ':OverlappingSInAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'OverlappingSInAv');
assert(isequal(m_inside_g.get('M'), known_overlapping_in_strength), ...
    [BRAPH2.STR ':OverlappingSInAv:' BRAPH2.FAIL_TEST], ...
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
    0   1   .4
    1   0   0
    .7  .3  0
    ];
B12 = rand(size(B11,1),size(B22,2));
B21 = B12';
B = {B11 B12;
     B21 B22};

known_overlapping_in_degree = {mean([3, 1.5, 1.5]')};

g = MultilayerWD('B', B);
m_outside_g = OverlappingSInAv('G', g);
assert(isequal(m_outside_g.get('M'), known_overlapping_in_degree), ...
    [BRAPH2.STR ':OverlappingSInAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'OverlappingSInAv');
assert(isequal(m_inside_g.get('M'), known_overlapping_in_degree), ...
    [BRAPH2.STR ':OverlappingSInAv:' BRAPH2.FAIL_TEST], ...
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
    0   1   .4
    1   0   0
    .7  .3  0
    ];
B12 = rand(size(B11,1),size(B22,2));
B21 = B12';
B = {B11 B12;
     B21 B22};

known_overlapping_in_degree = {mean([3, 1.5, 1.5]')};

g = OrdMlWD('B', B);
m_outside_g = OverlappingSInAv('G', g);
assert(isequal(m_outside_g.get('M'), known_overlapping_in_degree), ...
    [BRAPH2.STR ':OverlappingSInAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'OverlappingSInAv');
assert(isequal(m_inside_g.get('M'), known_overlapping_in_degree), ...
    [BRAPH2.STR ':OverlappingSInAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])