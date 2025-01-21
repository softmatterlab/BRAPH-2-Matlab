%% ¡header!
RCDeg < Degree (m, rich-club degree) is the graph Rich-Club Degree.

%%% ¡description!
The Rich-Club Degree (RCDeg) of a node at level k is the sum of 
 the edges that connect nodes of degree k or higher within a layer. 
 k is set by the user; the default value is equal to 1. 

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
RCDeg.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
RCDeg.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
RCDeg.PARAMETRIC_VALUE
%%%% ¡title!
Rich-Club Degree parameter (degree level)

%%% ¡prop!
%%%% ¡id!
RCDeg.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
RCDeg.M
%%%% ¡title!
Rich-Club Degree

%%% ¡prop!
%%%% ¡id!
RCDeg.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
RCDeg.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
RCDeg.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs
  
%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Rich-Club Degree.
%%%% ¡default!
'RCDeg'

%%% ¡prop!
NAME (constant, string) is the name of the Rich-Club Degree.
%%%% ¡default!
'Rich-Club Degree'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the Rich-Club Degree.
%%%% ¡default!
'The Rich-Club Degree (RCDeg) of a node at level k is the sum of the edges that connect nodes of degree k or higher within a layer. k is set by the user; the default value is equal to 1.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Rich-Club Degree.
%%%% ¡settings!
'RCDeg'

%%% ¡prop!
ID (data, string) is a few-letter code of the Rich-Club Degree.
%%%% ¡default!
'RCDeg ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Rich-Club Degree.
%%%% ¡default!
'Rich-Club Degree label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the Rich-Club Degree.
%%%% ¡default!
'Rich-Club Degree notes'

%%% ¡prop!
SHAPE (constant, scalar) is the measure shape __Measure.NODAL__.
%%%% ¡default!
Measure.NODAL

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
{'GraphWU' 'GraphWD' 'GraphBU' 'GraphBD' 'MultigraphBUD' 'MultigraphBUT' 'MultiplexWU' 'MultiplexWD' 'MultiplexBU' 'MultiplexBD' 'MultiplexBUD' 'MultiplexBUT' 'OrdMxWU'};

%%% ¡prop!
M (result, cell) is the Rich-Club Degree.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
L = g.get('LAYERNUMBER');
N = g.get('NODENUMBER');

rich_club_degree = cell(L, 1); 
directionality_type = g.get('DIRECTIONALITY_TYPE', L);
richclub_threshold = m.get('PARAMETRIC_VALUE');
assert(mod(richclub_threshold, 1) == 0, ...
    [BRAPH2.STR ':RCDeg:' BRAPH2.WRONG_INPUT], ...
    ['RCDeg threshold must be an integer value ' ...
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

    richclub_layer = zeros(N(1), 1, k_level);
    for k = 1:1:k_level
        low_rich_nodes = find(deg <= k);  % get lower rich nodes with degree <= k
        Aii = binarize(Aii);  % binarizes the adjacency matrix
        subAii = Aii;  % extract subnetwork of nodes >k by removing nodes <= k of Aii
        subAii(low_rich_nodes, :) = 0;  % remove rows
        subAii(:, low_rich_nodes) = 0;  % remove columns

        if directionality_layer == Graph.UNDIRECTED  % undirected graphs
            richclub_layer(:, :, k) = sum(subAii, 1)';  % degree of high rich nodes
        else
            richclub_layer(:, :, k) = (sum(subAii, 1)' + sum(subAii, 2))/2;  % degree of high rich nodes
        end

    end
    rich_club_degree(li) = {richclub_layer};  % add rich club degree of layer li          
end

value = rich_club_degree;

%% ¡props!
%%% ¡prop! 
PARAMETRIC_VALUE (parameter, SCALAR) 
%%%% ¡default!
1

%% ¡tests!

%%% ¡excluded_props!
[RCDeg.PFM]

%%% ¡test!
%%%% ¡name!
GraphWU
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0   .1  1  0; 
    .1  0   1  .8; 
    1   1   0  0;
    0   .8  0  0
    ];


known_richclubdegree = {[2 2 2 0]'};

g = GraphWU('B', B);

m_outside_g = RCDeg('G', g);
assert(isequal(m_outside_g.get('M'), known_richclubdegree), ...
    [BRAPH2.STR ':RCDeg:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'RCDeg');
assert(isequal(m_inside_g.get('M'), known_richclubdegree), ...
    [BRAPH2.STR ':RCDeg:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
GraphWD
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0   .1  1  0; 
    .1  0   1  .8; 
    1   1   0  0;
    0   .8  0  0
    ];

known_richclubdegree = {[2 2 2 0]'};

g = GraphWD('B', B);

m_outside_g = RCDeg('G', g);
assert(isequal(m_outside_g.get('M'), known_richclubdegree), ...
    [BRAPH2.STR ':RCDeg:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'RCDeg');
assert(isequal(m_inside_g.get('M'), known_richclubdegree), ...
    [BRAPH2.STR ':RCDeg:' BRAPH2.FAIL_TEST], ...
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

known_richclubdegree = {[2 2 2 0]'};

g = GraphBU('B', B);

m_outside_g = RCDeg('G', g);
assert(isequal(m_outside_g.get('M'), known_richclubdegree), ...
    [BRAPH2.STR ':RCDeg:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'RCDeg');
assert(isequal(m_inside_g.get('M'), known_richclubdegree), ...
    [BRAPH2.STR ':RCDeg:' BRAPH2.FAIL_TEST], ...
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

known_richclubdegree = {[2 2 2 0]'};

g = GraphBD('B', B);

m_outside_g = RCDeg('G', g);
assert(isequal(m_outside_g.get('M'), known_richclubdegree), ...
    [BRAPH2.STR ':RCDeg:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'RCDeg');
assert(isequal(m_inside_g.get('M'), known_richclubdegree), ...
    [BRAPH2.STR ':RCDeg:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultigraphBUT
%%%% ¡code!
B = [
     0  1  1  0; 
    1  0  1  1; 
    1  1  0  0;
    0  1  0  0
    ];

known_richclubdegree = {
                        [2 2 2 0]'
                        [0 0 0 0]'};

g = MultigraphBUT('B', B, 'THRESHOLDS', [0 1]);
m_outside_g = RCDeg('G', g);
assert(isequal(m_outside_g.get('M'), known_richclubdegree), ...
    [BRAPH2.STR ':RCDeg:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'RCDeg');
assert(isequal(m_inside_g.get('M'), known_richclubdegree), ...
    [BRAPH2.STR ':RCDeg:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultigraphBUD
%%%% ¡code!
B = [
     0  1  1  0; 
    1  0  1  1; 
    1  1  0  0;
    0  1  0  0
    ];

known_richclubdegree = {
    [0 0 0 0]'
    [2 2 2 0]'};

g = MultigraphBUD('B', B, 'DENSITIES', [10 90]);
m_outside_g = RCDeg('G', g);
assert(isequal(m_outside_g.get('M'), known_richclubdegree), ...
    [BRAPH2.STR ':RCDeg:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'RCDeg');
assert(isequal(m_inside_g.get('M'), known_richclubdegree), ...
    [BRAPH2.STR ':RCDeg:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexWU
%%%% ¡code!

A11 = [
    0   .1  1  0; 
    .1  0   1  .8; 
    1   1   0  0;
    0   .8  0  0
    ];

A22 = [
    0   .1  1  1; 
    .1  0   1  .8; 
    1   1   0  0;
    1   .8  0  0
    ];
A = {A11 A22};


known_richclubdegree = {
    [2 2 2 0]'
    [3 3 2 2]'
    };

g = MultiplexWU('B', A);
m_outside_g = RCDeg('G', g);
assert(isequal(m_outside_g.get('M'), known_richclubdegree), ...
    [BRAPH2.STR ':RCDeg:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'RCDeg');
assert(isequal(m_inside_g.get('M'), known_richclubdegree), ...
    [BRAPH2.STR ':RCDeg:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexWD
%%%% ¡code!

A11 = [
    0   .1  1  0; 
    .1  0   1  .8; 
    1   1   0  0;
    0   .8  0  0
    ];

A22 = [
    0   .1  1  1; 
    .1  0   1  .8; 
    1   1   0  0;
    1   .8  0  0
    ];
A = {A11 A22};


known_richclubdegree = {
    [2 2 2 0]'
    [3 3 2 2]'
    };

g = MultiplexWD('B', A);
m_outside_g = RCDeg('G', g);
assert(isequal(m_outside_g.get('M'), known_richclubdegree), ...
    [BRAPH2.STR ':RCDeg:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'RCDeg');
assert(isequal(m_inside_g.get('M'), known_richclubdegree), ...
    [BRAPH2.STR ':RCDeg:' BRAPH2.FAIL_TEST], ...
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
A = {A11 A22};

clear richclub_l1;
clear richclub_l2;
richclub_l1(:, 1, 1) = [3 3 2 2]';
richclub_l1(:, 1, 2) = [1 1 0 0]';

richclub_l2(:, 1, 1) = [3 3 3 3]';
richclub_l2(:, 1, 2) = [3 3 3 3]';
known_richclubdegree = {
                 richclub_l1
                 richclub_l2
                 };

g = MultiplexBU('B', A);
m_outside_g = RCDeg('G', g, 'PARAMETRIC_VALUE', 2);
tmp_val = m_outside_g.get('M');
assert(isequal(tmp_val{1}, known_richclubdegree{1}), ...
    [BRAPH2.STR ':RCDeg:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'RCDeg');
m_inside_g.set('PARAMETRIC_VALUE', 2);
tmp_val = m_inside_g.get('M');
assert(isequal(tmp_val{2}, known_richclubdegree{2}), ...
    [BRAPH2.STR ':RCDeg:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

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
A = {A11 A22};

clear richclub_l1;
clear richclub_l2;
richclub_l1(:, 1, 1) = [5/2 3 2 3/2]';
richclub_l1(:, 1, 2) = [1 1 0 0]';

richclub_l2(:, 1, 1) = [5/2 3 5/2 2]';
richclub_l2(:, 1, 2) = [2 2 2 0]';
known_richclubdegree = {
                 richclub_l1
                 richclub_l2
                 };

g = MultiplexBD('B', A);
m_outside_g = RCDeg('G', g, 'PARAMETRIC_VALUE', 2);	
tmp_val = m_outside_g.get('M');
assert(isequal(tmp_val{1}, known_richclubdegree{1}), ...
    [BRAPH2.STR ':RCDeg:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'RCDeg');
m_inside_g.set('PARAMETRIC_VALUE', 2);
tmp_val = m_inside_g.get('M');
assert(isequal(tmp_val{2}, known_richclubdegree{2}), ...
    [BRAPH2.STR ':RCDeg:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])