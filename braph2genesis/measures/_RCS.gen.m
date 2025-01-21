%% ¡header!
RCS < Strength (m, rich-club strength) is the graph Rich-Club Strength.

%%% ¡description!
The Rich-Club Strength (RCS) of a node at level PARAMETRIC_VALUE is the sum of the weighted edges 
 that connect nodes of strength s or higher within a layer. 
 PARAMETRIC_VALUE is set by the user and it can be a vector containing all the strength thresholds 
 the default value is equal to 1.

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
RCS.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
RCS.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
RCS.PARAMETRIC_VALUE
%%%% ¡title!
Rich-Club Strength parameter (strength level)

%%% ¡prop!
%%%% ¡id!
RCS.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
RCS.M
%%%% ¡title!
Rich-Club Strength

%%% ¡prop!
%%%% ¡id!
RCS.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
RCS.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
RCS.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs
  
%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Rich-Club Strength.
%%%% ¡default!
'RCS'

%%% ¡prop!
NAME (constant, string) is the name of the Rich-Club Strength.
%%%% ¡default!
'Rich-Club Strength'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the Rich-Club Strength.
%%%% ¡default!
'The Rich-Club Strength (RCS) of a node at level PARAMETRIC_VALUE is the sum of the weighted edges that connect nodes of strength s or higher within a layer. PARAMETRIC_VALUE is set by the user and it can be a vector containing all the strength thresholds the default value is equal to 1.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Rich-Club Strength.
%%%% ¡settings!
'RCS'

%%% ¡prop!
ID (data, string) is a few-letter code of the Rich-Club Strength.
%%%% ¡default!
'RCS ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Rich-Club Strength.
%%%% ¡default!
'Rich-Club Strength label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the Rich-Club Strength.
%%%% ¡default!
'Rich-Club Strength notes'

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
{'GraphWU' 'GraphWD' 'MultiplexWU' 'MultiplexWD'};

%%% ¡prop!
M (result, cell) is the Rich-Club Strength.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
L = g.get('LAYERNUMBER');
N = g.get('NODENUMBER');

rich_club_strength = cell(L, 1); 
directionality_type = g.get('DIRECTIONALITY_TYPE', L);
richclub_threshold = m.get('PARAMETRIC_VALUE');
assert(isnumeric(richclub_threshold) == 1, ...
    [BRAPH2.STR ':RCS:' BRAPH2.WRONG_INPUT], ...
    ['RCS threshold must be an integer value ' ...
    'while it is ' tostring(richclub_threshold)])

s_levels = abs(richclub_threshold);
for li = 1:1:L
    
    Aii = A{li, li};
    directionality_layer = directionality_type(li, li);

    if directionality_layer == Graph.UNDIRECTED  % undirected graphs
       
        strength = calculateValue@Strength(m, prop);
        st = strength{li};

    else  % directed graphs
      
        in_strength = StrengthIn('G', g).get('M');        
        out_strength = StrengthOut('G', g).get('M');       

        st = (in_strength{li}' + out_strength{li})/2;
    end

    rich_club_strength_layer = zeros(N(1), 1, length(s_levels));
    count = 1;
    for s = s_levels
        low_rich_nodes = find(st <= s);  % get lower rich nodes with strength <= s
        subAii = Aii;  % extract subnetwork of nodes >s by removing nodes <=s of Aii
        subAii(low_rich_nodes, :) = 0;  % remove rows
        subAii(:, low_rich_nodes) = 0;  % remove columns
        
        if directionality_layer == Graph.UNDIRECTED  % undirected graphs
            rich_club_strength_layer(:, :, count) = round(sum(subAii, 1), 6)';  % strength of high rich nodes
        else
            rich_club_strength_layer(:, :, count) = round((sum(subAii, 1)' + sum(subAii, 2)), 6)/2;  % strength of high rich nodes
        end
        count = count + 1;
    end
    rich_club_strength(li) = {rich_club_strength_layer};  %#ok<SAGROW> % add rich club strength of layer li
end

value = rich_club_strength;

%% ¡props!

%%% ¡prop! 
PARAMETRIC_VALUE (parameter, RVECTOR) is the strength level.
%%%% ¡default!
1

%% ¡tests!

%%% ¡excluded_props!
[RCS.PFM]

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


known_rich_club_strength = {[1.1 1.1 2 0]'};

g = GraphWU('B', B);

m_outside_g = RCS('G', g);
assert(isequal(m_outside_g.get('M'), known_rich_club_strength), ...
    [BRAPH2.STR ':RCS:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'RCS');
assert(isequal(m_inside_g.get('M'), known_rich_club_strength), ...
    [BRAPH2.STR ':RCS:' BRAPH2.FAIL_TEST], ...
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

wrich(:, 1, 1) = [1.6 1.6 2 0]';
wrich(:, 1, 2) = [0 0 0 0]';
known_rich_club_strength = {wrich};

g = GraphWD('B', B);

m_outside_g = RCS('G', g);
m_outside_g.set('PARAMETRIC_VALUE', [1.5, 2]);
assert(isequal(m_outside_g.get('M'), known_rich_club_strength), ...
    [BRAPH2.STR ':RCS:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'RCS');
m_inside_g.set('PARAMETRIC_VALUE', [1.5, 2]);
assert(isequal(m_inside_g.get('M'), known_rich_club_strength), ...
    [BRAPH2.STR ':RCS:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexWU
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

w_richness_l1(:, 1, 1) = [2 2 2 0]';
w_richness_l1(:, 1, 2) = [1 1 0 0]';

w_richness_l2(:, 1, 1) = [2.1 3 2.7 1.8]';
w_richness_l2(:, 1, 2) = [2 2 2 0]';

known_rich_club_strength = {
    w_richness_l1
    w_richness_l2
    };

g = MultiplexWU('B', A);
m_outside_g = RCS('G', g, 'PARAMETRIC_VALUE', [1.5, 2]);
assert(isequal(m_outside_g.get('M'), known_rich_club_strength), ...
    [BRAPH2.STR ':RCS:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'RCS');
m_inside_g.set('PARAMETRIC_VALUE', [1.5, 2]);
assert(isequal(m_inside_g.get('M'), known_rich_club_strength), ...
    [BRAPH2.STR ':RCS:' BRAPH2.FAIL_TEST], ...
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

w_richness_l1(:, 1, 1) = [1.6 1.6 2 0]';
w_richness_l1(:, 1, 2) = [0 0 0 0]';

w_richness_l2(:, 1, 1) = [1.6 1.6 2 0]';
w_richness_l2(:, 1, 2) = [0 1 1 0]';

known_rich_club_strength = {
    w_richness_l1
    w_richness_l2
    };

g = MultiplexWD('B', A);
m_outside_g = RCS('G', g, 'PARAMETRIC_VALUE', [1.5, 2]);
assert(isequal(m_outside_g.get('M'), known_rich_club_strength), ...
    [BRAPH2.STR ':RCS:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'RCS');
m_inside_g.set('PARAMETRIC_VALUE', [1.5, 2]);
assert(isequal(m_inside_g.get('M'), known_rich_club_strength), ...
    [BRAPH2.STR ':RCS:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

