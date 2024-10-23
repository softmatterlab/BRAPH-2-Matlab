%% ¡header!
Richness < Degree (m, richness) is the graph Richness.

%%% ¡description!
The Richness (Richness) of a node is the sum of the edges that connect nodes 
of higher degree within a layer.

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
Richness.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
Richness.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
Richness.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
Richness.M
%%%% ¡title!
Richness

%%% ¡prop!
%%%% ¡id!
Richness.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
Richness.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
Richness.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Richness.
%%%% ¡default!
'Richness'

%%% ¡prop!
NAME (constant, string) is the name of the Richness.
%%%% ¡default!
'Richness'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the Richness.
%%%% ¡default!
'The Richness (Richness) of a node is the sum of the edges that connect nodes of higher degree within a layer.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Richness.
%%%% ¡settings!
'Richness'

%%% ¡prop!
ID (data, string) is a few-letter code of the Richness.
%%%% ¡default!
'Richness ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Richness.
%%%% ¡default!
'Richness label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the Richness.
%%%% ¡default!
'Richness notes'

%%% ¡prop!
SHAPE (constant, scalar) is the measure shape __Measure.NODAL__.
%%%% ¡default!
Measure.NODAL

%%% ¡prop!
SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.
%%%% ¡default!
Measure.UNILAYER

%%% ¡prop!
PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.
%%%% ¡default!
Measure.NONPARAMETRIC

%%% ¡prop!
COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
%%%% ¡default!
{'GraphWU' 'GraphWD' 'GraphBU' 'GraphBD' 'MultigraphBUD' 'MultigraphBUT' 'MultiplexWU' 'MultiplexWD' 'MultiplexBU' 'MultiplexBD' 'MultiplexBUD' 'MultiplexBUT' 'OrdMxWU'} ;

%%% ¡prop!
M (result, cell) is the Richness.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
L = g.get('LAYERNUMBER');
N = g.get('NODENUMBER');

richness = cell(L, 1);
directionality_type = g.get('DIRECTIONALITY_TYPE', L); 

for li = 1:1:L
    
    Aii = A{li, li};
    directionality_layer = directionality_type(li, li);

    if directionality_layer == Graph.UNDIRECTED  % undirected graphs
        
        degree = calculateValue@Degree(m, prop);    
        k = degree{li};
        
    else  % directed graphs
                
        in_degree = DegreeIn('G', g).get('M');        
        out_degree = DegreeOut('G', g).get('M');        
        
        k = in_degree{li} + out_degree{li};
    end
    
    kMinus = zeros(size(k));
    kPlus = zeros(size(k));
    
    for i = 1:N(li)
        lrInd = k <= k(i); % Indices of nodes with Lower Richness (LR)
        hrInd = k > k(i); % Indices of nodes with Higher Richness (HR)
        lrA = Aii;
        lrA(i, hrInd) = 0;
        lrA(hrInd, i) = 0;
        hrA = Aii;
        hrA(i, lrInd) = 0;
        hrA(lrInd, i) = 0;
        
        if directionality_layer == Graph.UNDIRECTED  % undirected graphs
            kMinusForI = sum(lrA, 1)';
            kPlusForI = sum(hrA, 1)';
        else
            kMinusForI = (sum(lrA, 1)' + sum(lrA, 2))/2;
            kPlusForI = (sum(hrA, 1)' + sum(hrA, 2))/2;
        end
        kMinus(i) = kMinusForI(i);
        kPlus(i) = kPlusForI(i);
    end
    richness(li) = {kPlus};  % add richness of layer li
end

value = richness;

%% ¡tests!

%%% ¡excluded_props!
[Richness.PFM]

%%% ¡test!
%%%% ¡name!
GraphWU
%%%% ¡code!
B = [
    0  1  1  0; 
    1  0  1  1; 
    1  1  0  0;
    0  1  0  0
    ];

known_richness = {[1 0 1 1]'};

g = GraphWU('B', B);

m_outside_g = Richness('G', g).get('M');

assert(isequal(m_outside_g, known_richness), ...
    [BRAPH2.STR ':Richness:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Richness');
assert(isequal(m_inside_g.get('M'), known_richness), ...
    [BRAPH2.STR ':Richness:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
GraphWD
%%%% ¡code!
B = [
    0  1  1  0; 
    1  0  1  1; 
    1  1  0  0;
    0  1  0  0
    ];

known_richness = {[1 0 1 1]'};

g = GraphWD('B', B);

m_outside_g = Richness('G', g).get('M');

assert(isequal(m_outside_g, known_richness), ...
    [BRAPH2.STR ':Richness:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Richness');
assert(isequal(m_inside_g.get('M'), known_richness), ...
    [BRAPH2.STR ':Richness:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])


%%% ¡test!
%%%% ¡name!
GraphBU
%%%% ¡code!
B = [
    0  1  1  0; 
    1  0  1  1; 
    1  1  0  0;
    0  1  0  0
    ];

known_richness = {[1 0 1 1]'};

g = GraphBU('B', B);

m_outside_g = Richness('G', g).get('M');

assert(isequal(m_outside_g, known_richness), ...
    [BRAPH2.STR ':Richness:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Richness');
assert(isequal(m_inside_g.get('M'), known_richness), ...
    [BRAPH2.STR ':Richness:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
GraphBD
%%%% ¡code!
B = [
    0  1  1  0; 
    1  0  1  1; 
    1  1  0  0;
    0  1  0  0
    ];

known_richness = {[1 0 1 1]'};

g = GraphBD('B', B);

m_outside_g = Richness('G', g).get('M');

assert(isequal(m_outside_g, known_richness), ...
    [BRAPH2.STR ':Richness:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Richness');
assert(isequal(m_inside_g.get('M'), known_richness), ...
    [BRAPH2.STR ':Richness:' BRAPH2.FAIL_TEST], ...
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

known_richness = {                 
                 [0 0 0 0]'
                 [1 0 1 1]'
                 };

g = MultigraphBUD('B', B, 'DENSITIES', [10 90]);
m_outside_g = Richness('G', g).get('M');

assert(isequal(m_outside_g, known_richness), ...
    [BRAPH2.STR ':Richness:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Richness');
assert(isequal(m_inside_g.get('M'), known_richness), ...
    [BRAPH2.STR ':Richness:' BRAPH2.FAIL_TEST], ...
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

known_richness = {
                 [1 0 1 1]'
                 [0 0 0 0]'};

g = MultigraphBUT('B', B, 'THRESHOLDS', [0 1]);
m_outside_g = Richness('G', g).get('M');

assert(isequal(m_outside_g, known_richness), ...
    [BRAPH2.STR ':Richness:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Richness');
assert(isequal(m_inside_g.get('M'), known_richness), ...
    [BRAPH2.STR ':Richness:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexWU
%%%% ¡code!
A11 = [
    0  1  1  0; 
    1  0  1  1; 
    1  1  0  0;
    0  1  0  0
    ];
A22 = [
    0  1  1  0; 
    1  0  1  1; 
    1  1  0  0;
    0  1  0  0
    ];
A = {A11 A22};

known_richness = {
                 [1 0 1 1]'
                 [1 0 1 1]'
                 };   

g = MultiplexWD('B', A);
m_outside_g = Richness('G', g).get('M');
m_outside_g = cellfun(@(s) round(s, 4), m_outside_g, 'UniformOutput', false);

assert(isequal(m_outside_g, known_richness), ...
    [BRAPH2.STR ':Richness:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Richness');
assert(isequal(m_inside_g.get('M'), known_richness), ...
    [BRAPH2.STR ':Richness:' BRAPH2.FAIL_TEST], ...
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

known_richness = {
                 [.6 0 2 .7]'
                 [.6 0 1 21/20]'
                 };   

g = MultiplexWD('B', A);
m_outside_g = Richness('G', g).get('M');
m_outside_g = cellfun(@(s) round(s, 4), m_outside_g, 'UniformOutput', false);

assert(isequal(m_outside_g, known_richness), ...
    [BRAPH2.STR ':Richness:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Richness').get('M');
 m_inside_g = cellfun(@(x) round(x, 3), m_inside_g, 'UniformOutput', false);
assert(isequal(m_inside_g, known_richness), ...
    [BRAPH2.STR ':Richness:' BRAPH2.FAIL_TEST], ...
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
             
known_richness = {
    [0 0 2 2]'
    [0 0 0 0]'
    };

g = MultiplexBU('B', A);
m_outside_g = Richness('G', g).get('M');
m_outside_g = cellfun(@(x) round(x, 3), m_outside_g, 'UniformOutput', false);

assert(isequal(m_outside_g, known_richness), ...
    [BRAPH2.STR ':Richness:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Richness').get('M');
m_inside_g = cellfun(@(x) round(x, 3), m_inside_g, 'UniformOutput', false);
assert(isequal(m_inside_g, known_richness), ...
    [BRAPH2.STR ':Richness:' BRAPH2.FAIL_TEST], ...
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
             
known_richness = {
                 [1 0 2 3/2]'
                 [1 0 1 2]'
                 };    

g = MultiplexBD('B', A);
m_outside_g = Richness('G', g).get('M');

assert(isequal(m_outside_g, known_richness), ...
    [BRAPH2.STR ':Richness:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Richness');
assert(isequal(m_inside_g.get('M'), known_richness), ...
    [BRAPH2.STR ':Richness:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])
%%% ¡test!
%%%% ¡name!
MultiplexBUD
%%%% ¡code!
B1 = [
    0  1  1  0; 
    1  0  1  1; 
    1  1  0  0;
    0  1  0  0
    ];
B2 = [
    0  1  1  0; 
    1  0  1  1; 
    1  1  0  0;
    0  1  0  0
    ];

B = {B1 B2};

known_richness = {                 
                 [0 0 0 0]'
                 [0 0 0 0]'
                 [1 0 1 1]'                 
                 [1 0 1 1]'
                 };

g = MultiplexBUD('B', B, 'DENSITIES', [10 90]);
m_outside_g = Richness('G', g).get('M');

assert(isequal(m_outside_g, known_richness), ...
    [BRAPH2.STR ':Richness:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Richness');
assert(isequal(m_inside_g.get('M'), known_richness), ...
    [BRAPH2.STR ':Richness:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBUT
%%%% ¡code!
B1 = [
    0  1  1  0; 
    1  0  1  1; 
    1  1  0  0;
    0  1  0  0
    ];
B2 = [
    0  1  1  0; 
    1  0  1  1; 
    1  1  0  0;
    0  1  0  0
    ];

B = {B1 B2};

known_richness = {
                 [1 0 1 1]'
                 [1 0 1 1]'
                 [0 0 0 0]'
                 [0 0 0 0]'
                 };

g = MultiplexBUT('B', B, 'THRESHOLDS', [0 1]);
m_outside_g = Richness('G', g).get('M');

assert(isequal(m_outside_g, known_richness), ...
    [BRAPH2.STR ':Richness:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Richness');
assert(isequal(m_inside_g.get('M'), known_richness), ...
    [BRAPH2.STR ':Richness:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

