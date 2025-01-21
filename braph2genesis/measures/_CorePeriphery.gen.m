%% ¡header!
CorePeriphery < Richness (m, core-periphery) is the graph Core-Periphery.

%%% ¡description!
The Core-Periphery (CorePeriphery) of a node is the value of the rank corresponding 
to the maximum richness nodes. It returns 1 for a node belonging to the 
core and zero otherwise. 

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
CorePeriphery.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
CorePeriphery.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
CorePeriphery.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
CorePeriphery.M
%%%% ¡title!
Core-Periphery

%%% ¡prop!
%%%% ¡id!
CorePeriphery.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
CorePeriphery.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
CorePeriphery.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Core-Periphery.
%%%% ¡default!
'CorePeriphery'

%%% ¡prop!
NAME (constant, string) is the name of the Core-Periphery.
%%%% ¡default!
'Core-Periphery'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the Core-Periphery.
%%%% ¡default!
'The Core-Periphery (CorePeriphery) of a node is the value of the rank corresponding to the maximum richness nodes. It returns 1 for a node belonging to the core and zero otherwise.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Core-Periphery.
%%%% ¡settings!
'CorePeriphery'

%%% ¡prop!
ID (data, string) is a few-letter code of the Core-Periphery.
%%%% ¡default!
'CorePeriphery ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Core-Periphery.
%%%% ¡default!
'Core-Periphery label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the Core-Periphery.
%%%% ¡default!
'Core-Periphery notes'

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
{'GraphWU' 'GraphWD' 'GraphBU' 'GraphBD' 'MultigraphBUD' 'MultigraphBUT' 'MultiplexWU' 'MultiplexWD' 'MultiplexBU' 'MultiplexBD' 'MultiplexBUD' 'MultiplexBUT' 'MultilayerWD' 'OrdMlWD'} ;

%%% ¡prop!
M (result, cell) is the Core-Periphery.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
richness = calculateValue@Richness(m, prop);
L = g.get('LAYERNUMBER');
N = g.get('NODENUMBER');

if L == 0
    value = {};
else
    directionality_layer =  g.get('DIRECTIONALITY_TYPE', L);
    connectivity_layer =  g.get('CONNECTIVITY_TYPE', L);
    core_periphery = cell(L, 1);
    
    for li = 1:1:L
        core_periphery_partition = zeros(N(1), 1);
        
        if connectivity_layer == Graph.WEIGHTED  % weighted graphs
            if directionality_layer == Graph.UNDIRECTED  % undirected graphs
                
                strength = Strength('G', g).get('M');
                deg = strength{li};
                
            else  % directed graphs
                
                in_strength = StrengthIn('G', g).get('M');
                out_strength = StrengthOut('G', g).get('M');
                deg = (in_strength{li} + out_strength{li})/2;
            end
            
        else  % binary graphs
            if directionality_layer == Graph.UNDIRECTED  % undirected graphs
                
                degree = Degree('G', g).get('M');
                deg = degree{li};
                
            else  % directed graphs
                
                in_degree = DegreeIn('G', g).get('M');
                out_degree = DegreeOut('G', g).get('M');
                deg = (in_degree{li} + out_degree{li})/2;
            end
        end
        
        [~, rankingInd] = sort(deg, 'descend');
        richness_partition = richness{li};
        [~, rankOfMaxRichness] = max(richness_partition(rankingInd), [], 'all');  
        core_periphery_partition(rankingInd(1:rankOfMaxRichness)) = 1;
        core_periphery(li) = {core_periphery_partition};
    end
    value = core_periphery;
end

%% ¡tests!

%%% ¡excluded_props!
[CorePeriphery.PFM]

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

known_core_periphery = {[1 1 0 0]'};

g = GraphWU('B', B);

m_outside_g = CorePeriphery('G', g).get('M');

assert(isequal(m_outside_g, known_core_periphery), ...
    [BRAPH2.STR ':CorePeriphery:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'CorePeriphery');
assert(isequal(m_inside_g.get('M'), known_core_periphery), ...
    [BRAPH2.STR ':CorePeriphery:' BRAPH2.FAIL_TEST], ...
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

known_core_periphery = {[1 1 0 0]'};

g = GraphWD('B', B);

m_outside_g = CorePeriphery('G', g).get('M');

assert(isequal(m_outside_g, known_core_periphery), ...
    [BRAPH2.STR ':CorePeriphery:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'CorePeriphery');
assert(isequal(m_inside_g.get('M'), known_core_periphery), ...
    [BRAPH2.STR ':CorePeriphery:' BRAPH2.FAIL_TEST], ...
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

known_core_periphery = {[1 1 0 0]'};

g = GraphBU('B', B);

m_outside_g = CorePeriphery('G', g).get('M');

assert(isequal(m_outside_g, known_core_periphery), ...
    [BRAPH2.STR ':CorePeriphery:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'CorePeriphery');
assert(isequal(m_inside_g.get('M'), known_core_periphery), ...
    [BRAPH2.STR ':CorePeriphery:' BRAPH2.FAIL_TEST], ...
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

known_core_periphery = {[1 1 0 0]'};

g = GraphBD('B', B);

m_outside_g = CorePeriphery('G', g).get('M');

assert(isequal(m_outside_g, known_core_periphery), ...
    [BRAPH2.STR ':CorePeriphery:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'CorePeriphery');
assert(isequal(m_inside_g.get('M'), known_core_periphery), ...
    [BRAPH2.STR ':CorePeriphery:' BRAPH2.FAIL_TEST], ...
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

known_core_periphery = {
    [1 0 0 0]'
    [1 1 0 0]'
    };

g = MultigraphBUD('B', B, 'DENSITIES', [10 90]);

m_outside_g = CorePeriphery('G', g).get('M');

assert(isequal(m_outside_g, known_core_periphery), ...
    [BRAPH2.STR ':CorePeriphery:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'CorePeriphery');
assert(isequal(m_inside_g.get('M'), known_core_periphery), ...
    [BRAPH2.STR ':CorePeriphery:' BRAPH2.FAIL_TEST], ...
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

known_core_periphery = {
                 [1 1 0 0]'
                 [1 0 0 0]'};

g = MultigraphBUT('B', B, 'THRESHOLDS', [0 1]);

m_outside_g = CorePeriphery('G', g).get('M');

assert(isequal(m_outside_g, known_core_periphery), ...
    [BRAPH2.STR ':CorePeriphery:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'CorePeriphery');
assert(isequal(m_inside_g.get('M'), known_core_periphery), ...
    [BRAPH2.STR ':CorePeriphery:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexWU
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

known_core_periphery = {
                     [1 1 0 0]'
                     [1 1 1 0]'};     

g = MultiplexWU('B', B);
core_periphery = CorePeriphery('G', g).get('M');

m_outside_g = CorePeriphery('G', g).get('M');

assert(isequal(m_outside_g, known_core_periphery), ...
    [BRAPH2.STR ':CorePeriphery:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'CorePeriphery');
assert(isequal(m_inside_g.get('M'), known_core_periphery), ...
    [BRAPH2.STR ':CorePeriphery:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexWD
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

known_core_periphery = {
                     [1 1 0 0]'
                     [1 1 1 0]'};     

g = MultiplexWD('B', B);
core_periphery = CorePeriphery('G', g).get('M');

m_outside_g = CorePeriphery('G', g).get('M');

assert(isequal(m_outside_g, known_core_periphery), ...
    [BRAPH2.STR ':CorePeriphery:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'CorePeriphery');
assert(isequal(m_inside_g.get('M'), known_core_periphery), ...
    [BRAPH2.STR ':CorePeriphery:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBU
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

known_core_periphery = {
                     [1 1 0 0]'
                     [1 1 1 0]'};     

g = MultiplexBU('B', B);
core_periphery = CorePeriphery('G', g).get('M');

m_outside_g = CorePeriphery('G', g).get('M');

assert(isequal(m_outside_g, known_core_periphery), ...
    [BRAPH2.STR ':CorePeriphery:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'CorePeriphery');
assert(isequal(m_inside_g.get('M'), known_core_periphery), ...
    [BRAPH2.STR ':CorePeriphery:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBD
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

known_core_periphery = {
                     [1 1 0 0]'
                     [1 1 1 0]'};     

g = MultiplexBD('B', B);
core_periphery = CorePeriphery('G', g).get('M');

m_outside_g = CorePeriphery('G', g).get('M');

assert(isequal(m_outside_g, known_core_periphery), ...
    [BRAPH2.STR ':CorePeriphery:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'CorePeriphery');
assert(isequal(m_inside_g.get('M'), known_core_periphery), ...
    [BRAPH2.STR ':CorePeriphery:' BRAPH2.FAIL_TEST], ...
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

known_core_periphery = {
    [1 0 0 0]'
    [1 0 0 0]'
    [1 1 0 0]'
    [1 1 0 0]'
    };

g = MultiplexBUD('B', B, 'DENSITIES', [10 90]);

m_outside_g = CorePeriphery('G', g).get('M');

assert(isequal(m_outside_g, known_core_periphery), ...
    [BRAPH2.STR ':CorePeriphery:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'CorePeriphery');
assert(isequal(m_inside_g.get('M'), known_core_periphery), ...
    [BRAPH2.STR ':CorePeriphery:' BRAPH2.FAIL_TEST], ...
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

known_core_periphery = {
                 [1 1 0 0]'
                 [1 1 0 0]'
                 [1 0 0 0]'
                 [1 0 0 0]'};

g = MultiplexBUT('B', B, 'THRESHOLDS', [0 1]);

m_outside_g = CorePeriphery('G', g).get('M');

assert(isequal(m_outside_g, known_core_periphery), ...
    [BRAPH2.STR ':CorePeriphery:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'CorePeriphery');
assert(isequal(m_inside_g.get('M'), known_core_periphery), ...
    [BRAPH2.STR ':CorePeriphery:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])
