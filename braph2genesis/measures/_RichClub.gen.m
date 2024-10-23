%% ¡header!
RichClub < Degree (m, rich-club) is the graph Rich-Club.

%%% ¡description!
The Rich-Club coefficient (RichClub) of a node at level k is the fraction of 
 the edges that connect nodes of degree k or higher out of the 
 maximum number of edges that such nodes might share within a 
 layer. k is set by the user, the default value is equal to 1.

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
RichClub.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
RichClub.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
RichClub.PARAMETRIC_VALUE
%%%% ¡title!
Rich-Club parameter (degree level)

%%% ¡prop!
%%%% ¡id!
RichClub.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
RichClub.M
%%%% ¡title!
Rich-Club

%%% ¡prop!
%%%% ¡id!
RichClub.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
RichClub.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
RichClub.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Rich-Club.
%%%% ¡default!
'RichClub'

%%% ¡prop!
NAME (constant, string) is the name of the Rich-Club.
%%%% ¡default!
'Rich-Club'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the Rich-Club.
%%%% ¡default!
'The Rich-Club coefficient (RichClub) of a node at level k is the fraction of the edges that connect nodes of degree k or higher out of the maximum number of edges that such nodes might share within a layer. k is set by the user, the default value is equal to 1.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Rich-Club.
%%%% ¡settings!
'RichClub'

%%% ¡prop!
ID (data, string) is a few-letter code of the Rich-Club.
%%%% ¡default!
'RichClub ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Rich-Club.
%%%% ¡default!
'Rich-Club label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the Rich-Club.
%%%% ¡default!
'Rich-Club notes'

%%% ¡prop!
SHAPE (constant, scalar) is the measure shape __Measure.GLOBAL__.
%%%% ¡default!
Measure.GLOBAL

%%% ¡prop!
SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.
%%%% ¡default!
Measure.UNILAYER

%%% ¡prop!
PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.PARAMETRIC__.
%%%% ¡default!
Measure.PARAMETRIC

%%% ¡prop!
COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
%%%% ¡default!
{'GraphWU' 'GraphWD' 'GraphBU' 'GraphBD' 'MultigraphBUD' 'MultigraphBUT' 'MultiplexWU' 'MultiplexWD' 'MultiplexBU' 'MultiplexBD' 'MultiplexBUD' 'MultiplexBUT'}

%%% ¡prop!
M (result, cell) is the Rich-Club.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
L = g.get('LAYERNUMBER');

rich_club = cell(L, 1);
directionality_type = g.get('DIRECTIONALITY_TYPE', L);
richclub_threshold = m.get('PARAMETRIC_VALUE');
assert(mod(richclub_threshold, 1) == 0, ...
    [BRAPH2.STR ':RichClub:' BRAPH2.WRONG_INPUT], ...
    ['RichClub threshold must be an integer value ' ...
    'while it is ' tostring(richclub_threshold)])

k_level = abs(richclub_threshold);
for li = 1:1:L
    
    Aii = A{li, li};
    directionality_layer = directionality_type(li, li);
      
    if directionality_layer == Graph.UNDIRECTED  % undirected graphs
        
        degree = calculateValue@Degree(m, prop);        
        deg = degree{li};
        
    else  % directed graphs        
        
        in_degree = DegreeIn('G', g).get('M');        
        out_degree = DegreeOut('G', g).get('M');
        deg = (in_degree{li} + out_degree{li})/2;
    end
    
    richclub_layer = zeros(1, 1, k_level);
    Nk = zeros(1, k_level);
    Ek = zeros(1, k_level);
    for k = 1:1:k_level
        low_rich_nodes = find(deg <= k);  % get lower rich nodes with degree <= k
        Aii = binarize(Aii);  % binarizes the adjacency matrix
        subAii = Aii;  % extract subnetwork of nodes >k by removing nodes <= k of Aii
        subAii(low_rich_nodes, :) = [];  % remove rows
        subAii(:, low_rich_nodes) = [];  % remove columns
        Nk(k) = size(subAii, 2);  % number of nodes with degree > k
        Ek(k) = sum(subAii(:));  % total number of connections in subgraph
        richclub_layer(1, 1, k) = Ek(k)/(Nk(k)*(Nk(k)-1));  % unweighted rich-club coefficient
    end
    richclub_layer(isnan(richclub_layer)) = 0;  % Should return zeros, since NaN happens when subAii has zero nodes with degree > k
    rich_club(li) = {richclub_layer};  % add rich club degree of layer li
end

value = rich_club;

%% ¡props!
%%% ¡prop! 
PARAMETRIC_VALUE (parameter, scalar) is the threshold (k).
%%%% ¡default!
1

%% ¡tests!

%%% ¡excluded_props!
[RichClub.PFM]

%%% ¡test!
%%%% ¡name!
GraphWU
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0   1   1  .1; 
    .2  0   1  1; 
    1   1   0  0;
    0   .3  0  0
    ];

r(1, 1, 1) = .83;
r(1, 1, 2) = 1;
r(1, 1, 3) = 0;

known_richclub = {r};

g = GraphWU('B', B);

m_outside_g = RichClub('G', g);
m_outside_g.set('PARAMETRIC_VALUE', 3);
outisde_val = cellfun(@(x) round(x, 2), m_outside_g.get('M'), 'UniformOutput', false);
assert(isequal(outisde_val, known_richclub), ...
    [BRAPH2.STR ':RichClub:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'RichClub');
m_inside_g.set('PARAMETRIC_VALUE', 3);
inside_val = cellfun(@(x) round(x, 2), m_inside_g.get('M'), 'UniformOutput', false);
assert(isequal(inside_val, known_richclub), ...
    [BRAPH2.STR ':RichClub:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
GraphWD
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0   1   1  .1; 
    .2  0   1  1; 
    1   1   0  0;
    0   .3  0  0
    ];

r(1, 1, 1) = .75;
r(1, 1, 2) = 1;
r(1, 1, 3) = 0;

known_richclub = {r};

g = GraphWD('B', B);

m_outside_g = RichClub('G', g);
m_outside_g.set('PARAMETRIC_VALUE', 3);
assert(isequal(m_outside_g.get('M'), known_richclub), ...
    [BRAPH2.STR ':RichClub:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'RichClub');
m_inside_g.set('PARAMETRIC_VALUE', 3);
assert(isequal(m_inside_g.get('M'), known_richclub), ...
    [BRAPH2.STR ':RichClub:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
GraphBU
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0  1  1  0;
    1  0  1  1;
    1  1  0  0;
    0  1  0  0
    ];

r(1, 1, 1) = 1;
r(1, 1, 2) = 0;
r(1, 1, 3) = 0;

known_richclub = {r};

g = GraphBU('B', B);

m_outside_g = RichClub('G', g, 'PARAMETRIC_VALUE', 3).get('M');
assert(isequal(m_outside_g, known_richclub), ...
    [BRAPH2.STR ':RichClub:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'RichClub');
m_inside_g.set('PARAMETRIC_VALUE', 3);
assert(isequal(m_inside_g.get('M'), known_richclub), ...
    [BRAPH2.STR ':RichClub:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
GraphBD
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0  1  1  0;
    1  0  1  1;
    1  1  0  0;
    0  1  0  0
    ];

r(1, 1, 1) = 1;
r(1, 1, 2) = 0;
r(1, 1, 3) = 0;

known_richclub = {r};

g = GraphBD('B', B);

m_outside_g = RichClub('G', g, 'PARAMETRIC_VALUE', 3).get('M');
assert(isequal(m_outside_g, known_richclub), ...
    [BRAPH2.STR ':RichClub:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'RichClub');
m_inside_g.set('PARAMETRIC_VALUE', 3);
assert(isequal(m_inside_g.get('M'), known_richclub), ...
    [BRAPH2.STR ':RichClub:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultigraphBUT
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0  1  1  0;
    1  0  1  1;
    1  1  0  0;
    0  1  0  0
    ];

r(1, 1, 1) = 1;
r(1, 1, 2) = 0;
r(1, 1, 3) = 0;

known_richclub = {r; r};
thresholds = [0.1 0.7];

g = MultigraphBUT('B', B, 'THRESHOLDS', thresholds);

m_outside_g = RichClub('G', g);
m_outside_g.set('PARAMETRIC_VALUE', 3);
assert(isequal(m_outside_g.get('M'), known_richclub), ...
    [BRAPH2.STR ':RichClub:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'RichClub');
m_inside_g.set('PARAMETRIC_VALUE', 3);
assert(isequal(m_inside_g.get('M'), known_richclub), ...
    [BRAPH2.STR ':RichClub:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultigraphBUD
%%%% ¡probability!
.01
%%%% ¡code!
B =[
    0  1  1  0;
    1  0  1  1;
    1  1  0  0;
    0  1  0  0
    ];
r(1, 1, 1) = 1;
r(1, 1, 2) = 0;
r(1, 1, 3) = 0;
l(1, 1, 1) = 0;
l(1, 1, 2) = 0;
l(1, 1, 3) = 0;

known_richclub = {l; r};
densities = [10 80];

g = MultigraphBUD('B', B, 'DENSITIES', densities);

m_outside_g = RichClub('G', g);
m_outside_g.set('PARAMETRIC_VALUE', 3);
assert(isequal(m_outside_g.get('M'), known_richclub), ...
    [BRAPH2.STR ':RichClub:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'RichClub');
m_inside_g.set('PARAMETRIC_VALUE', 3);
assert(isequal(m_inside_g.get('M'), known_richclub), ...
    [BRAPH2.STR ':RichClub:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])


%%% ¡test!
%%%% ¡name!
MultiplexWD
%%%% ¡code!
A11 = [
    0   1   1  .1; 
    .2  0   1  1; 
    1   1   0  0;
    0   .3  0  0
    ];
A22 = [
    0   1   1   .1; 
    .2  0   1   1; 
    1   1   0   0;
    0   .3  .7  0
    ];
A = {A11 A22};

richclub_l1(1, 1, 1) = 3/4;
richclub_l1(1, 1, 2) = 1;

richclub_l2(1, 1, 1) = 5/6;
richclub_l2(1, 1, 2) = 1;

known_richclub = {
                 richclub_l1
                 richclub_l2
                 };

g = MultiplexWD('B', A);

m_outside_g = RichClub('G', g);
m_outside_g.set('PARAMETRIC_VALUE', 2);
assert(isequal(m_outside_g.get('M'), known_richclub), ...
    [BRAPH2.STR ':RichClub:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'RichClub');
m_inside_g.set('PARAMETRIC_VALUE', 2);
assert(isequal(m_inside_g.get('M'), known_richclub), ...
    [BRAPH2.STR ':RichClub:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])


%%% ¡test!
%%%% ¡name!
MultiplexBU
%%%% ¡code!
A11 = [
    0  1  1  1; 
    1  0  1  1; 
    1  1  0  0;
    0  1  0  0
    ];

A22 = [
    0  1  1  1; 
    1  0  1  1; 
    1  1  0  0;
    0  1  1  0
    ];
A = {A11  A22};

richclub_l1(1, 1, 1) = 0.8333;
richclub_l1(1, 1, 2) = 1;

richclub_l2(1, 1, 1) = 1;
richclub_l2(1, 1, 2) = 1;

known_richclub = {
    richclub_l1
    richclub_l2
    };

g = MultiplexBU('B', A);

m_outside_g = RichClub('G', g);
m_outside_g.set('PARAMETRIC_VALUE', 2);
result_outside = m_outside_g.get('M');
result_outside = cellfun(@(x) round(x, 4), result_outside, 'UniformOutput', false);
assert(isequal(result_outside, known_richclub), ...
    [BRAPH2.STR ':RichClub:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])


m_inside_g = g.get('MEASURE', 'RichClub');
m_inside_g.set('PARAMETRIC_VALUE', 2);
result_inside = m_inside_g.get('M');
result_inside = cellfun(@(x) round(x, 4), result_inside, 'UniformOutput', false);
assert(isequal(result_inside, known_richclub), ...
    [BRAPH2.STR ':RichClub:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBD
%%%% ¡code!
A11 = [
    0  1  1  1; 
    1  0  1  1; 
    1  1  0  0;
    0  1  0  0
    ];

A22 = [
    0  1  1  1; 
    1  0  1  1; 
    1  1  0  0;
    0  1  1  0
    ];
A = {A11  A22};

richclub_l1(1, 1, 1) = 3/4;
richclub_l1(1, 1, 2) = 1;

richclub_l2(1, 1, 1) = 5/6;
richclub_l2(1, 1, 2) = 1;

known_richclub = {
                 richclub_l1
                 richclub_l2
                 };      

g = MultiplexBD('B', A);

m_outside_g = RichClub('G', g);
m_outside_g.set('PARAMETRIC_VALUE', 2);
assert(isequal(m_outside_g.get('M'), known_richclub), ...
    [BRAPH2.STR ':RichClub:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'RichClub');
m_inside_g.set('PARAMETRIC_VALUE', 2);
assert(isequal(m_inside_g.get('M'), known_richclub), ...
    [BRAPH2.STR ':RichClub:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])
