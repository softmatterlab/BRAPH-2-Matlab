%% ¡header!
WeightedRC < Strength (m, weighted rich-club) is the graph Weighted Rich-Club.

%%% ¡description!
The Weighted Rich-Club (WeightedRC) coefficient of a node at level s is the fraction of the 
 edges weights that connect nodes of strength s or higher out of the 
 maximum number of edges weights that such nodes might share within a layer. 
 Parameter s is set by the user and it can be a vector containing all the 
 strength thresholds; the default value is equal to 1.

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
WeightedRC.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
WeightedRC.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
WeightedRC.PARAMETRIC_VALUE
%%%% ¡title!
Weighted Rich-Club parameter (strength level)

%%% ¡prop!
%%%% ¡id!
WeightedRC.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
WeightedRC.M
%%%% ¡title!
Weighted Rich-Club

%%% ¡prop!
%%%% ¡id!
WeightedRC.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
WeightedRC.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
WeightedRC.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Weighted Rich-Club.
%%%% ¡default!
'WeightedRC'

%%% ¡prop!
NAME (constant, string) is the name of the Weighted Rich-Club.
%%%% ¡default!
'Weighted Rich-Club'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the Weighted Rich-Club.
%%%% ¡default!
'The Weighted Rich-Club (WeightedRC) coefficient of a node at level s is the fraction of the edges weights that connect nodes of strength s or higher out of the maximum number of edges weights that such nodes might share within a layer. Parameter s is set by the user and it can be a vector containing all the strength thresholds; the default value is equal to 1.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Weighted Rich-Club.
%%%% ¡settings!
'WeightedRC'

%%% ¡prop!
ID (data, string) is a few-letter code of the Weighted Rich-Club.
%%%% ¡default!
'WeightedRC ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Weighted Rich-Club.
%%%% ¡default!
'Weighted Rich-Club label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the Weighted Rich-Club.
%%%% ¡default!
'Weighted Rich-Club notes'

%%% ¡prop!
SHAPE (constant, scalar) is the measure shape __Measure.NODAL__.
%%%% ¡default!
Measure.NODAL

%%% ¡prop!
SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.
%%%% ¡default!
Measure.SUPERGLOBAL

%%% ¡prop!
PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.PARAMETRIC__.
%%%% ¡default!
Measure.PARAMETRIC

%%% ¡prop!
COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
%%%% ¡default!
{'GraphWU' 'MultiplexWU'};

%%% ¡prop!
M (result, cell) is the Weighted Rich-Club.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
l = g.get('LAYERNUMBER');

weighted_rich_club = cell(l, 1);
directionality_layer = g.get('DIRECTIONALITY_TYPE', l);
weighted_rich_club_threshold = m.get('PARAMETRIC_VALUE');
assert(isnumeric(weighted_rich_club_threshold) == 1, ...
    [BRAPH2.STR ':WeightedRichClub:' BRAPH2.WRONG_INPUT], ...
    ['WeightedRichClub threshold must be a positive number ' ...
    'while it is ' tostring(weighted_rich_club_threshold)])

s_levels = abs(weighted_rich_club_threshold);
directionality_type = g.get('DIRECTIONALITY_TYPE', l);
    
for li = 1:1:l
    
    Aii = A{li, li};
    directionality_layer = directionality_type(li, li);
   
    if directionality_layer == Graph.UNDIRECTED  % undirected graphs

        strength = calculateValue@Strength(m, prop);
        st = strength{li};

    else  % directed graphs

        in_strength = StrengthIn('G', g).get('M');
        out_strength = StrengthOut('G', g).get('M');

        st = (in_strength{li} + out_strength{li})/2;
    end

    weighted_rich_club_layer = zeros(1, 1, length(s_levels));
    wrank = sort(Aii(:), 'descend');  % wrank contains the ranked weights of the network, with strongest connections on top
    count = 1;
    
    for s = s_levels
        low_rich_nodes = find(st < s);  % get lower rich nodes with strength < s
        subAii = Aii;  % extract subnetwork of nodes >=s by removing nodes < s of Aii
        subAii(low_rich_nodes, :) = [];  % remove rows
        subAii(:, low_rich_nodes) = [];  % remove columns

        Wr = sum(subAii(:));  % total weight of connections in subgraph > s
        Er = length(find(subAii~=0));  % total number of connections in subgraph
        wrank_r = wrank(1:1:Er);  % E>r number of connections with max weight in network
        % Calculate weighted rich-club coefficient
        weighted_rich_club_layer(1, 1, count) = Wr / sum(wrank_r);
        count = count + 1;
    end
    weighted_rich_club_layer(isnan(weighted_rich_club_layer)) = 0;  % Should return zeros, since NaN happens when subAii has zero nodes with strength > s
    weighted_rich_club(li) = {weighted_rich_club_layer};  % add rich club strength of layer li
end
value = weighted_rich_club;
%% ¡props!

%%% ¡prop! 
PARAMETRIC_VALUE (parameter, RVECTOR) is the threshold (s).
%%%% ¡default!
1

%% ¡tests!

%%% ¡excluded_props!
[WeightedRC.PFM]

%%% ¡test!
%%%% ¡name!
GraphWU
%%%% ¡probability!
.01
%%%% ¡code!
A = [
    0   .1  1  0; 
    .1  0   1  .8; 
    1   1   0  0;
    0   .8  0  0
    ];

r(1, 1, 1) = 3/4;
r(1, 1, 2) = 1;
r(1, 1, 3) = 0;
known_weighted_rich_club = {r};  

g = GraphWU('B', A);
m_outside_g = WeightedRC('G', g, 'PARAMETRIC_VALUE', [1, 1.5, 2]);

ansWRD = m_outside_g.get('M');
assert(isequal(round(ansWRD{1}, 3), round(known_weighted_rich_club{1}, 3)), ...
    [BRAPH2.STR ':WeightedRC:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'WeightedRC');
m_inside_g.set('PARAMETRIC_VALUE', [1, 1.5, 2]);
ansWRD = m_inside_g.get('M');
assert(isequal(round(ansWRD{1}, 3), round(known_weighted_rich_club{1}, 3)), ...
    [BRAPH2.STR ':WeightedRC:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexWU
%%%% ¡probability!
.01
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

known_weighted_rich_club = {
    3/4
    1
    };

g = MultiplexWU('B', A);
m_outside_g = WeightedRC('G', g);
ans = m_outside_g.get('M');

assert(isequal(round(ans{1}, 2), round(known_weighted_rich_club{1}, 2)), ...
    [BRAPH2.STR ':WeightedRC:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'WeightedRC');
ans = m_inside_g.get('M');
assert(isequal(round(ans{1}, 2), round(known_weighted_rich_club{1}, 2)), ...
    [BRAPH2.STR ':WeightedRC:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])