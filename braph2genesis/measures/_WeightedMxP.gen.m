%% ¡header!
WeightedMxP < Measure (m, weighted multiplex participation) is the graph Weighted Multiplex Participation.

%%% ¡description!
The Weighted Multiplex Participation (WeightedMxP) of a graph is the nodal homogeneity 
 of its number of neighbors across the layers. 

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
WeightedMxP.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
WeightedMxP.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
WeightedMxP.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
WeightedMxP.M
%%%% ¡title!
Weighted Multiplex Participation

%%% ¡prop!
%%%% ¡id!
WeightedMxP.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
WeightedMxP.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
WeightedMxP.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Weighted Multiplex Participation.
%%%% ¡default!
'WeightedMxP'

%%% ¡prop!
NAME (constant, string) is the name of the Weighted Multiplex Participation.
%%%% ¡default!
'Weighted Multiplex Participation'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the Weighted Multiplex Participation.
%%%% ¡default!
'The Weighted Multiplex Participation (WeightedMxP) of a graph is the nodal homogeneity of its number of neighbors across the layers.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Weighted Multiplex Participation.
%%%% ¡settings!
'WeightedMxP'

%%% ¡prop!
ID (data, string) is a few-letter code of the Weighted Multiplex Participation.
%%%% ¡default!
'WeightedMxP ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Weighted Multiplex Participation.
%%%% ¡default!
'Weighted Multiplex Participation label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the Weighted Multiplex Participation.
%%%% ¡default!
'Weighted Multiplex Participation notes'

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
{'MultiplexWU' 'OrdMxWU' 'MultilayerWU' 'OrdMlWU'};

%%% ¡prop!
M (result, cell) is the Weighted Multiplex Participation.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
l = g.get('LAYERNUMBER');

if l == 0
    value = {};
else
    N = g.get('NODENUMBER');
    strength = Strength('G', g).get('M');
    overlapping_strength = OverlappingS('G', g).get('M');

    weighted_multiplex_participation =  zeros(N(1), 1);
    for li = 1:l
        weighted_multiplex_participation = weighted_multiplex_participation + (strength{li}./overlapping_strength{1}).^2;
    end
    weighted_multiplex_participation = l / (l - 1) * (1 - weighted_multiplex_participation);
    weighted_multiplex_participation(isnan(weighted_multiplex_participation)) = 0;  % Should return zeros, since NaN happens when strength = 0 and overlapping strength = 0 for all regions
    value = {weighted_multiplex_participation};
end

%% ¡tests!

%%% ¡excluded_props!
[WeightedMxP.PFM]

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

known_weighted_multiplex_participation = {[24/25 3/4 8/9]'};

g = MultiplexWU('B', B);
m_outside_g = WeightedMxP('G', g);

assert(isequal(m_outside_g.get('M'), known_weighted_multiplex_participation), ...
    [BRAPH2.STR ':WeightedMxP:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'WeightedMxP');
assert(isequal(m_inside_g.get('M'), known_weighted_multiplex_participation), ...
    [BRAPH2.STR ':WeightedMxP:' BRAPH2.FAIL_TEST], ...
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

known_weighted_multiplex_participation = {[24/25 3/4 8/9]'};

g = OrdMxWU('B', B);
m_outside_g = WeightedMxP('G', g);

assert(isequal(m_outside_g.get('M'), known_weighted_multiplex_participation), ...
    [BRAPH2.STR ':WeightedMxP:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'WeightedMxP');
assert(isequal(m_inside_g.get('M'), known_weighted_multiplex_participation), ...
    [BRAPH2.STR ':WeightedMxP:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])
