%% ¡header!
WeightedMxPAv < WeightedMxP (m, average weighted multiplex participation) is the graph Average Weighted Multiplex Participation.

%%% ¡description!
The Average Weighted Multiplex Participation (WeightedMxPAv) of a graph is the average homogeneity 
 of its number of neighbors across the layers.

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
WeightedMxPAv.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
WeightedMxPAv.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
WeightedMxPAv.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
WeightedMxPAv.M
%%%% ¡title!
Average Weighted Multiplex Participation

%%% ¡prop!
%%%% ¡id!
WeightedMxPAv.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
WeightedMxPAv.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
WeightedMxPAv.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Average Weighted Multiplex Participation.
%%%% ¡default!
'WeightedMxPAv'

%%% ¡prop!
NAME (constant, string) is the name of the Average Weighted Multiplex Participation.
%%%% ¡default!
'Average Weighted Multiplex Participation'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the Average Weighted Multiplex Participation.
%%%% ¡default!
'The Average Weighted Multiplex Participation (WeightedMxPAv) of a graph is the average homogeneity of its number of neighbors across the layers.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Average Weighted Multiplex Participation.
%%%% ¡settings!
'WeightedMxPAv'

%%% ¡prop!
ID (data, string) is a few-letter code of the Average Weighted Multiplex Participation.
%%%% ¡default!
'WeightedMxPAv ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Average Weighted Multiplex Participation.
%%%% ¡default!
'Average Weighted Multiplex Participation label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the Average Weighted Multiplex Participation.
%%%% ¡default!
'Average Weighted Multiplex Participation notes'

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
{'MultiplexWU' 'OrdMxWU' 'MultilayerWU' 'OrdMlWU'};

%%% ¡prop!
M (result, cell) is the Average Weighted Multiplex Participation.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
l = g.get('LAYERNUMBER');

if l == 0
    value = {};
else
    weighted_multiplex_participation = calculateValue@WeightedMxP(m, prop);
    value = {mean(cell2mat(weighted_multiplex_participation))};
end
%% ¡tests!

%%% ¡excluded_props!
[WeightedMxPAv.PFM]

%%% ¡test!
%%%% ¡name!
MultiplexWU
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0   .5  1
    .5  0   0
    1   0   0
    ];
B22 = [
    0   1   0
    1   0   0
    0   .5  0
    ];
B = {B11  B22};

known_weighted_multiplex_participation = {mean([24/25 3/4 8/9])};

g = MultiplexWU('B', B);
m_outside_g = WeightedMxPAv('G', g);

assert(isequal(m_outside_g.get('M'), known_weighted_multiplex_participation), ...
    [BRAPH2.STR ':WeightedMxPAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'WeightedMxPAv');
assert(isequal(m_inside_g.get('M'), known_weighted_multiplex_participation), ...
    [BRAPH2.STR ':WeightedMxPAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
OrdMxWU
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0   .5  1
    .5  0   0
    1   0   0
    ];
B22 = [
    0   1   0
    1   0   0
    0   .5  0
    ];
B = {B11  B22};

known_weighted_multiplex_participation = {mean([24/25 3/4 8/9]')};

g = OrdMxWU('B', B);
m_outside_g = WeightedMxPAv('G', g);

assert(isequal(m_outside_g.get('M'), known_weighted_multiplex_participation), ...
    [BRAPH2.STR ':WeightedMxPAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'WeightedMxPAv');
assert(isequal(m_inside_g.get('M'), known_weighted_multiplex_participation), ...
    [BRAPH2.STR ':WeightedMxPAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])
