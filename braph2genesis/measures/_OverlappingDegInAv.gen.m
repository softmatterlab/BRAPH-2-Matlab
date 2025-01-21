%% ¡header!
OverlappingDegInAv < OverlappingDegIn (m, average overlapping in-degree) is the graph Average Overlapping In-Degree.

%%% ¡description!
The Average Overlapping In-Degree (OverlappingDegInAv) of a graph is the average of the sum of the 
in-degrees of a node in all layers.  

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
OverlappingDegInAv.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
OverlappingDegInAv.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
OverlappingDegInAv.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
OverlappingDegInAv.M
%%%% ¡title!
Average Overlapping In-Degree

%%% ¡prop!
%%%% ¡id!
OverlappingDegInAv.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
OverlappingDegInAv.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
OverlappingDegInAv.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Average Overlapping In-Degree.
%%%% ¡default!
'OverlappingDegInAv'

%%% ¡prop!
NAME (constant, string) is the name of the Average Overlapping In-Degree.
%%%% ¡default!
'Average Overlapping In-Degree'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the Average Overlapping In-Degree.
%%%% ¡default!
'The Average Overlapping In-Degree (OverlappingDegInAv) of a graph is the average of the sum of the in-degrees of a node in all layers.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Average Overlapping In-Degree.
%%%% ¡settings!
'OverlappingDegInAv'

%%% ¡prop!
ID (data, string) is a few-letter code of the Average Overlapping In-Degree.
%%%% ¡default!
'OverlappingDegInAv ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Average Overlapping In-Degree.
%%%% ¡default!
'Average Overlapping In-Degree label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the Average Overlapping In-Degree.
%%%% ¡default!
'Average Overlapping In-Degree notes'

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
{'MultiplexWD' 'MultiplexBD' 'MultilayerWD' 'MultilayerBD' 'OrdMxBD' 'OrdMxWD' 'OrdMlBD' 'OrdMlWD'};

%%% ¡prop!
M (result, cell) is the Average Overlapping In-Degree.
%%%% ¡calculate!
g = m.get('G');  % graph from measure class
overlapping_in_degree_av = calculateValue@OverlappingDegIn(m, prop);

l = g.get('LAYERNUMBER');

if l == 0
    value = {};
    return;
end

value = {mean(cell2mat(overlapping_in_degree_av))};


%% ¡tests!

%%% ¡excluded_props!
[OverlappingDegInAv.PFM]

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

known_overlapping_in_degree = {mean([3, 2, 1]')};

g = MultiplexBD('B', B);
m_outside_g = OverlappingDegInAv('G', g);
assert(isequal(m_outside_g.get('M'), known_overlapping_in_degree), ...
    [BRAPH2.STR ':OverlappingDegInAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'OverlappingDegInAv');
assert(isequal(m_inside_g.get('M'), known_overlapping_in_degree), ...
    [BRAPH2.STR ':OverlappingDegInAv:' BRAPH2.FAIL_TEST], ...
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

known_overlapping_in_degree = {mean([2, 3, 1]')};

g = MultiplexWD('B', B);
m_outside_g = OverlappingDegInAv('G', g);
assert(isequal(m_outside_g.get('M'), known_overlapping_in_degree), ...
    [BRAPH2.STR ':OverlappingDegInAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'OverlappingDegInAv');
assert(isequal(m_inside_g.get('M'), known_overlapping_in_degree), ...
    [BRAPH2.STR ':OverlappingDegInAv:' BRAPH2.FAIL_TEST], ...
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

known_overlapping_in_degree = {mean([3, 2, 1]')};

g = MultilayerBD('B', B);
m_outside_g = OverlappingDegInAv('G', g);
assert(isequal(m_outside_g.get('M'), known_overlapping_in_degree), ...
    [BRAPH2.STR ':OverlappingDegInAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'OverlappingDegInAv');
assert(isequal(m_inside_g.get('M'), known_overlapping_in_degree), ...
    [BRAPH2.STR ':OverlappingDegInAv:' BRAPH2.FAIL_TEST], ...
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

known_overlapping_in_degree = {mean([3, 2, 1]')};

g = OrdMlBD('B', B);
m_outside_g = OverlappingDegInAv('G', g);
assert(isequal(m_outside_g.get('M'), known_overlapping_in_degree), ...
    [BRAPH2.STR ':OverlappingDegInAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'OverlappingDegInAv');
assert(isequal(m_inside_g.get('M'), known_overlapping_in_degree), ...
    [BRAPH2.STR ':OverlappingDegInAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])