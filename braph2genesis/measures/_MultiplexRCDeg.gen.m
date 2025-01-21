%% ¡header!
MultiplexRCDeg < RCDeg (m, multi rich-club degree) is the graph Multiplex Rich-Club Degree.

%%% ¡description!
The Multiplex Rich-Club Degree (MultiplexRCDeg) of a node at level k is the sum of 
 the edges that connect nodes of degree k or higher in all layers. 
The relevance of each layer is controlled by the coefficients c that are 
 between 0 and 1; the default coefficients are (1/layernumber).

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
MultiplexRCDeg.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
MultiplexRCDeg.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
MultiplexRCDeg.MULTIRICHCLUB_COEFFICIENTS
%%%% ¡title!
Multiplex Rich-Club Degree coefficients

%%% ¡prop!
%%%% ¡id!
MultiplexRCDeg.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
MultiplexRCDeg.M
%%%% ¡title!
Multiplex Rich-Club Degree

%%% ¡prop!
%%%% ¡id!
MultiplexRCDeg.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
MultiplexRCDeg.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
MultiplexRCDeg.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Multiplex Rich-Club Degree.
%%%% ¡default!
'MultiplexRCDeg'

%%% ¡prop!
NAME (constant, string) is the name of the Multiplex Rich-Club Degree.
%%%% ¡default!
'Multiplex Rich-Club Degree'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the Multiplex Rich-Club Degree.
%%%% ¡default!
'The Multiplex Rich-Club Degree (MultiplexRCDeg) of a node at level k is the sum of the edges that connect nodes of degree k or higher in all layers. The relevance of each layer is controlled by the coefficients c that are between 0 and 1; the default coefficients are (1/layernumber).'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Multiplex Rich-Club Degree.
%%%% ¡settings!
'MultiplexRCDeg'

%%% ¡prop!
ID (data, string) is a few-letter code of the Multiplex Rich-Club Degree.
%%%% ¡default!
'MultiplexRCDeg ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Multiplex Rich-Club Degree.
%%%% ¡default!
'Multiplex Rich-Club Degree label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the multiplex rich-club degree.
%%%% ¡default!
'Multiplex Rich-Club Degree notes'

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
{'MultiplexWU' 'MultiplexWD' 'MultiplexBU' 'MultiplexBD' 'MultiplexBUD' 'MultiplexBUT' 'OrdMxWU' 'OrdMxBU' 'OrdMxBUD' 'OrdMxBUT'};

%%% ¡prop!
M (result, cell) is the Multiplex Rich-Club Degree.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
l = g.get('LAYERNUMBER');
ls = g.get('PARTITIONS');

rich_club_degree = calculateValue@RCDeg(m, prop);

if l == 0
    value = {};
else
    N = g.get('NODENUMBER');
    richclub_threshold = m.get('PARAMETRIC_VALUE'); % klevel

    multirichclub_coefficients = m.get('MULTIRICHCLUB_COEFFICIENTS');
    if length(multirichclub_coefficients) == ls(1)
        assert(all(multirichclub_coefficients <= 1) && all(multirichclub_coefficients >= 0), ...
            [BRAPH2.STR ':MultiRichClubDegree:' BRAPH2.WRONG_INPUT], ...
            ['MultiRichClubDegree coefficients must be between 0 and 1 ' ...
            'while they are ' tostring(multirichclub_coefficients)])
        c = multirichclub_coefficients;

    else  % same relevance for each layer
        c = ones(1, l)/ls(1);
    end

    multi_rich_club_degree = cell(length(ls), 1);
    count = 1;
    for i = 1:1:length(ls)
        multi_rich_club_degree_partition = zeros(N(1), 1, richclub_threshold);
        for li = count:1:ls(i) + count - 1
            ri = rich_club_degree{li};  % to fix when making this measure also parametric
            % loop over the 3rd dimension of rich club degree (k_level)
            for k = 1:1:richclub_threshold
                multi_rich_club_degree_partition(:, :, k) = multi_rich_club_degree_partition(:, :, k) + c(li)*ri(:, :, k);
            end
        end
        count = count + ls(i);
        multi_rich_club_degree(i) = {multi_rich_club_degree_partition};
    end
    value = multi_rich_club_degree;
end

%% ¡props!

%%% ¡prop! 
MULTIRICHCLUB_COEFFICIENTS (parameter, RVECTOR) is the multi rich-club degree coefficients
%%%% ¡default!
[0]

%% ¡tests!

%%% ¡excluded_props!
[MultiplexRCDeg.PFM]

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

known_multi_rich_club_degree = {[9/4 9/4 2 1/2]'};

g = MultiplexWU('B', B);
m_outside_g = MultiplexRCDeg('G', g, 'MULTIRICHCLUB_COEFFICIENTS', [3/4, 1/4]);

assert(isequal(m_outside_g.get('M'), known_multi_rich_club_degree), ...
    [BRAPH2.STR ':MultiplexRCDeg:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'MultiplexRCDeg');
m_inside_g.set('MULTIRICHCLUB_COEFFICIENTS', [3/4, 1/4]);
assert(isequal(m_inside_g.get('M'), known_multi_rich_club_degree), ...
    [BRAPH2.STR ':MultiplexRCDeg:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBU
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0  1  1  0; 
    1  0  1  1; 
    1  1  0  0;
    0  1  0  0
    ];
B22 = [
    0  1  1  1; 
    1  0  1  1; 
    1  1  0  0;
    1  1  0  0
    ];
B = {B11 B22};

known_multi_rich_club_degree = {[5/2 5/2 2 1]'};  

g = MultiplexBU('B', B);
m_outside_g = MultiplexRCDeg('G', g);

assert(isequal(m_outside_g.get('M'), known_multi_rich_club_degree), ...
    [BRAPH2.STR ':MultiplexRCDeg:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'MultiplexRCDeg');
assert(isequal(m_inside_g.get('M'), known_multi_rich_club_degree), ...
    [BRAPH2.STR ':MultiplexRCDeg:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBUT
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0  1  1  0; 
    1  0  1  1; 
    1  1  0  0;
    0  1  0  0
    ];
B22 = [
    0  1  1  1; 
    1  0  1  1; 
    1  1  0  0;
    1  1  0  0
    ];
B = {B11 B22};

known_multi_rich_club_degree = {
                                [5/2 5/2  2  1]'
                                [0   0    0  0]'};

g = MultiplexBUT('B', B, 'THRESHOLDS', [0 1]);
m_outside_g = MultiplexRCDeg('G', g);

assert(isequal(m_outside_g.get('M'), known_multi_rich_club_degree), ...
    [BRAPH2.STR ':MultiplexRCDeg:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'MultiplexRCDeg');
assert(isequal(m_inside_g.get('M'), known_multi_rich_club_degree), ...
    [BRAPH2.STR ':MultiplexRCDeg:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBUD
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0  1  1  0; 
    1  0  1  1; 
    1  1  0  0;
    0  1  0  0
    ];
B22 = [
    0  1  1  1; 
    1  0  1  1; 
    1  1  0  0;
    1  1  0  0
    ];
B = {B11 B22};

known_multi_rich_club_degree = {
    [0   0    0  0]'
    [5/2 5/2  2  1]'};

g = MultiplexBUD('B', B, 'DENSITIES', [10 90]);
m_outside_g = MultiplexRCDeg('G', g);

assert(isequal(m_outside_g.get('M'), known_multi_rich_club_degree), ...
    [BRAPH2.STR ':MultiplexRCDeg:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'MultiplexRCDeg');
assert(isequal(m_inside_g.get('M'), known_multi_rich_club_degree), ...
    [BRAPH2.STR ':MultiplexRCDeg:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

