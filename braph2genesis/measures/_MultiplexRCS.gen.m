%% ¡header!
MultiplexRCS < RCS (m, multi rich-club strength) is the graph Multiplex Rich-Club Strength.

%%% ¡description!
The Multiplex Rich-Club Strength (MultiplexRCS) of a node at level s is the sum of the 
 weighted edges that connect nodes of strength s or higher in all layers. 
The relevance of each layer is controlled by the coefficients c that are 
 between 0 and 1; the default coefficients are (1/layernumber).

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
MultiplexRCS.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
MultiplexRCS.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
MultiplexRCS.WEIGHTED_MULTIRICHCLUB_COEFFICIENTS
%%%% ¡title!
Multiplex Rich-Club Strength coefficients

%%% ¡prop!
%%%% ¡id!
MultiplexRCS.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
MultiplexRCS.M
%%%% ¡title!
Multiplex Rich-Club Strength

%%% ¡prop!
%%%% ¡id!
MultiplexRCS.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
MultiplexRCS.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
MultiplexRCS.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Multiplex Rich-Club Strength.
%%%% ¡default!
'MultiplexRCS'

%%% ¡prop!
NAME (constant, string) is the name of the Multiplex Rich-Club Strength.
%%%% ¡default!
'Multiplex Rich-Club Strength'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the Multiplex Rich-Club Strength.
%%%% ¡default!
'The Multiplex Rich-Club Strength (MultiplexRCS) of a node at level s is the sum of the weighted edges that connect nodes of strength s or higher in all layers. The relevance of each layer is controlled by the coefficients c that are between 0 and 1; the default coefficients are (1/layernumber).'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Multiplex Rich-Club Strength.
%%%% ¡settings!
'MultiplexRCS'

%%% ¡prop!
ID (data, string) is a few-letter code of the Multiplex Rich-Club Strength.
%%%% ¡default!
'MultiplexRCS ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Multiplex Rich-Club Strength.
%%%% ¡default!
'Multiplex Rich-Club Strength label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the Multiplex Rich-Club Strength.
%%%% ¡default!
'Multiplex Rich-Club Strength notes'

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
{'MultiplexWU' 'MultiplexWD' 'OrdMxWU'};

%%% ¡prop!
M (result, cell) is the Multiplex Rich-Club Strength.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
l = g.get('LAYERNUMBER');
ls = g.get('PARTITIONS');

rich_club_strength = calculateValue@RCS(m, prop);   

if l == 0
    value = {};
else
    N = g.get('NODENUMBER');
    weighted_rich_club_threshold = m.get('PARAMETRIC_VALUE');
    s_levels = abs(weighted_rich_club_threshold);

    weighted_multi_rich_club_coefficients = m.get('WEIGHTED_MULTIRICHCLUB_COEFFICIENTS');
    assert(length(weighted_multi_rich_club_coefficients) == l || all(weighted_multi_rich_club_coefficients == 0), ...
        [BRAPH2.STR ':WeightedMultiRichClubCoefficients:' BRAPH2.WRONG_INPUT], ...
        ['WeightedMultiRichClubCoefficients coefficients must have the same length than the ' ...
        'number of layers (' tostring(l) ') while its length is ' tostring(length(weighted_multi_rich_club_coefficients))])
    
    if length(weighted_multi_rich_club_coefficients) == l
        assert(all(weighted_multi_rich_club_coefficients <= 1) && all(weighted_multi_rich_club_coefficients >= 0), ...
            [BRAPH2.STR ':WeightedMultiRichClubCoefficients:' BRAPH2.WRONG_INPUT], ...
            ['WeightedMultiRichClubCoefficients coefficients must be between 0 and 1 ' ...
            'while they are ' tostring(weighted_multi_rich_club_coefficients)])
        c = weighted_multi_rich_club_coefficients;
    else  % same relevance for each layer
        c = ones(1, l)/l;
    end
    
    multi_rich_club_strength = zeros(N(1), 1, length(s_levels));
    for li = 1:1:l
        wrich = rich_club_strength{li};
        % loop over the 3rd dimension of richness (s_level)
        for s = 1:1:length(s_levels)
            multi_rich_club_strength(:, :, s) = multi_rich_club_strength(:, :, s) + c(li)*wrich(:, :, s);
        end
    end
    value = {multi_rich_club_strength};
end

%% ¡props!

%%% ¡prop! 
WEIGHTED_MULTIRICHCLUB_COEFFICIENTS (parameter, RVECTOR) is the multi rich-club strength coefficients
%%%% ¡default!
[0]

%% ¡tests!

%%% ¡excluded_props!
[MultiplexRCS.PFM]

%%% ¡test!
%%%% ¡name!
MultiplexWU
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0   .1  1  0; 
    .1  0   1  .8; 
    1   1   0  0;
    0   .8  0  0
    ];
B22 = [
    0   .1  1  1; 
    .1  0   1  .8; 
    1   1   0  0;
    1   .8  0  0
    ];
B = {B11 B22};

known_multi_rich_club_strength = {[5.4/4 5.2/4 2 1.8/4]'};   

g = MultiplexWU('B', B);
m_outside_g = MultiplexRCS('G', g, 'PARAMETRIC_VALUE', 1, 'WEIGHTED_MULTIRICHCLUB_COEFFICIENTS', [3/4, 1/4]);

assert(isequal(m_outside_g.get('M'), known_multi_rich_club_strength), ...
    [BRAPH2.STR ':MultiplexRCS:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'MultiplexRCS');
m_inside_g.set('PARAMETRIC_VALUE', 1, 'WEIGHTED_MULTIRICHCLUB_COEFFICIENTS', [3/4, 1/4]);
assert(isequal(m_inside_g.get('M'), known_multi_rich_club_strength), ...
    [BRAPH2.STR ':MultiplexRCS:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexWD
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0   1   1  .1; 
    .2  0   1  1; 
    1   1   0  0;
    0   .3  0  0
    ];
B22 = [
    0   1   1   .1; 
    .2  0   1   1; 
    1   1   0   0;
    0   .3  .7  0
    ];
B = {B11 B22};


wmultirich(:, 1, 1) = [1.6 1.6 2 0]';
wmultirich(:, 1, 2) = [0 .5 .5 0]';
known_multi_rich_club_strength = {wmultirich};

g = MultiplexWD('B', B);
m_outside_g = MultiplexRCS('G', g, 'PARAMETRIC_VALUE', [1.5, 2]);

assert(isequal(m_outside_g.get('M'), known_multi_rich_club_strength), ...
    [BRAPH2.STR ':MultiplexRCS:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'MultiplexRCS');
m_inside_g.set('PARAMETRIC_VALUE', [1.5, 2]);
assert(isequal(m_inside_g.get('M'), known_multi_rich_club_strength), ...
    [BRAPH2.STR ':MultiplexRCS:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])