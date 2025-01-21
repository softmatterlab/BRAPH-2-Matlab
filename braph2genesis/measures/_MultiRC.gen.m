%% ¡header!
MultiRC < Richness (m, multirichness) is the graph Multirichness.

%%% ¡description!
The Multirichness (MultiRC) of a node is the sum of the edges that connect nodes 
 of degree k or higher in all layers. The relevance of each layer is 
 controlled by the coefficients c that are between 0 and 1; 
 the default coefficients are (1/layernumber).

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
MultiRC.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
MultiRC.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
MultiRC.MULTIRICHNESS_COEFFICIENTS
%%%% ¡title!
Multirichness coefficients

%%% ¡prop!
%%%% ¡id!
MultiRC.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
MultiRC.M
%%%% ¡title!
Multirichness

%%% ¡prop!
%%%% ¡id!
MultiRC.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
MultiRC.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
MultiRC.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Multirichness.
%%%% ¡default!
'MultiRC'

%%% ¡prop!
NAME (constant, string) is the name of the Multirichness.
%%%% ¡default!
'Multirichness'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the Multirichness.
%%%% ¡default!
'The Multirichness (MultiRC) of a node is the sum of the edges that connect nodes of degree k or higher in all layers. The relevance of each layer is controlled by the coefficients c that are between 0 and 1; the default coefficients are (1/layernumber).'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the multirichness.
%%%% ¡settings!
'MultiRC'

%%% ¡prop!
ID (data, string) is a few-letter code of the Multirichness.
%%%% ¡default!
'MultiRC ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Multirichness.
%%%% ¡default!
'Multirichness label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the Multirichness.
%%%% ¡default!
'Multirichness notes'

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
{'MultiplexWU' 'MultiplexWD' 'MultiplexBU' 'MultiplexBD' 'MultiplexBUD' 'MultiplexBUT' 'OrdMxWU'};

%%% ¡prop!
M (result, cell) is the Multirichness.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
l = g.get('LAYERNUMBER');
ls = g.get('PARTITIONS');

richness = calculateValue@Richness(m, prop);

if l == 0
    value = {};
else
    N = g.get('NODENUMBER');
    multirichness_coefficients = m.get('MULTIRICHNESS_COEFFICIENTS');
    assert(length(multirichness_coefficients) == ls(1) || all(multirichness_coefficients == 0), ...
        [BRAPH2.STR ':Multirichness:' BRAPH2.WRONG_INPUT], ...
        ['Multirichness coefficients must have the same length than the ' ...
        'number of layers (' tostring(ls(1)) ') while its length is ' tostring(length(multirichness_coefficients))])

    if length(multirichness_coefficients) == ls(1)
        assert(all(multirichness_coefficients <= 1) && all(multirichness_coefficients >= 0), ...
            [BRAPH2.STR ':Multirichness:' BRAPH2.WRONG_INPUT], ...
            ['Multirichness coefficients must be between 0 and 1 ' ...
            'while they are ' tostring(multirichness_coefficients)])
        c = multirichness_coefficients;

    else  % same relevance for each layer
        c = ones(1, l)/ls(1);
    end
    multirichness = cell(length(ls), 1);
    count = 1;
    for i = 1:1:length(ls)
        multirichness_partition = zeros(N(1), 1);
        for li = count:1:ls(i) + count - 1
            multirichness_partition = multirichness_partition + c(li)*richness{li};
        end
        count = count + ls(i);
        multirichness(i) = {multirichness_partition};
    end
    value = multirichness;
end

%% ¡props!

%%% ¡prop! 
MULTIRICHNESS_COEFFICIENTS (parameter, RVECTOR) are the coefficients c that are between 0 and 1 that control the relevance of each layer, the default coefficients are (1/layernumber).
%%%% ¡default!
[0]

%% ¡tests!

%%% ¡excluded_props!
[MultiRC.PFM]

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

known_multirichness = {[3/40 0 5/4 21/20]'};  

g = MultiplexWU('B', B);
m_outside_g = MultiRC('G', g, 'MULTIRICHNESS_COEFFICIENTS', [3/4, 1/4]);
ans = m_outside_g.get('M');
assert(isequal(round(ans{1}, 2), round(known_multirichness{1}, 2)), ...
    [BRAPH2.STR ':MultiRC:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'MultiRC');
m_inside_g.set('MULTIRICHNESS_COEFFICIENTS', [3/4, 1/4]);
ans = m_inside_g.get('M');
assert(isequal(round(ans{1}, 2), round(known_multirichness{1}, 2)), ...
    [BRAPH2.STR ':MultiRC:' BRAPH2.FAIL_TEST], ...
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

known_multirichness = {[3/5 0 3/2 7/8]'};

g = MultiplexWD('B', B);
m_outside_g = MultiRC('G', g);

assert(isequal(m_outside_g.get('M'), known_multirichness), ...
    [BRAPH2.STR ':MultiRC:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'MultiRC');
assert(isequal(m_inside_g.get('M'), known_multirichness), ...
    [BRAPH2.STR ':MultiRC:' BRAPH2.FAIL_TEST], ...
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

known_multirichness = {[1/2 0 3/2 3/2]'};  

g = MultiplexBU('B', B);
m_outside_g = MultiRC('G', g);

assert(isequal(m_outside_g.get('M'), known_multirichness), ...
    [BRAPH2.STR ':MultiRC:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'MultiRC');
assert(isequal(m_inside_g.get('M'), known_multirichness), ...
    [BRAPH2.STR ':MultiRC:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBD
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0  1  1  1; 
    1  0  1  1; 
    1  1  0  0;
    0  1  0  0
    ];

B22 = [
    0  1  1  1; 
    1  0  1  1; 
    1  1  0  0;
    0  1  1  0
    ];
B = {B11 B22};
       
known_multirichness = {[1 0 5/3 5/3]'}; 

g = MultiplexBD('B', B);
m_outside_g = MultiRC('G', g, 'MULTIRICHNESS_COEFFICIENTS', [2/3, 1/3]);

ans = m_outside_g.get('M');
assert(isequal(round(ans{1}, 2), round(known_multirichness{1}, 2)), ...
    [BRAPH2.STR ':MultiRC:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'MultiRC');
m_inside_g.set('MULTIRICHNESS_COEFFICIENTS', [2/3, 1/3]);
ans = m_inside_g.get('M');
assert(isequal(round(ans{1}, 2), round(known_multirichness{1}, 2)), ...
    [BRAPH2.STR ':MultiRC:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBUT
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

known_multirichness = {
    [1/2  0   3/2  3/2]'
    [0    0   0    0]'
    };

g = MultiplexBUT('B', B, 'THRESHOLDS', [0 1]);
m_outside_g = MultiRC('G', g);

assert(isequal(m_outside_g.get('M'), known_multirichness), ...
    [BRAPH2.STR ':MultiRC:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'MultiRC');
assert(isequal(m_inside_g.get('M'), known_multirichness), ...
    [BRAPH2.STR ':MultiRC:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBUD
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

known_multirichness = {
    [0    0   0    0]'
    [1/2  0   3/2  3/2]'
    };

g = MultiplexBUD('B', B, 'DENSITIES', [10 90]);
m_outside_g = MultiRC('G', g);

assert(isequal(m_outside_g.get('M'), known_multirichness), ...
    [BRAPH2.STR ':MultiRC:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'MultiRC');
assert(isequal(m_inside_g.get('M'), known_multirichness), ...
    [BRAPH2.STR ':MultiRC:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

