%% ¡header!
GlobalEfficiencyIn < Distance (m, in-global efficiency) is the graph In-Global Efficiency.

%%% ¡description!
The In-Global Efficiency (GlobalEfficiencyIn) is the average inverse shortest in-path length within each layer. 
It is inversely related to the characteristic in-path length.

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
GlobalEfficiencyIn.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
GlobalEfficiencyIn.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
GlobalEfficiencyIn.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
GlobalEfficiencyIn.M
%%%% ¡title!
In-Global Efficiency

%%% ¡prop!
%%%% ¡id!
GlobalEfficiencyIn.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
GlobalEfficiencyIn.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
GlobalEfficiencyIn.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the In-Global Efficiency.
%%%% ¡default!
'GlobalEfficiencyIn'

%%% ¡prop!
NAME (constant, string) is the name of the In-Global Efficiency.
%%%% ¡default!
'In-Global Efficiency'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the In-Global Efficiency.
%%%% ¡default!
'The In-Global Efficiency (GlobalEfficiencyIn) is the average inverse shortest in-path length within each layer. It is inversely related to the characteristic in-path length.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the In-Global Efficiency.
%%%% ¡settings!
'GlobalEfficiencyIn'

%%% ¡prop!
ID (data, string) is a few-letter code of the In-Global Efficiency.
%%%% ¡default!
'GlobalEfficiencyIn ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the In-Global Efficiency.
%%%% ¡default!
'In-Global Efficiency label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the In-Global Efficiency.
%%%% ¡default!
'In-Global Efficiency notes'

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
{'GraphWD' 'GraphBD' 'MultiplexWD' 'MultiplexBD' 'OrdMxBD' 'OrdMxWD'};

%%% ¡prop!
M (result, cell) is the In-Global Efficiency.
%%%% ¡calculate!
g = m.get('G');  % graph from measure class
A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
L = g.get('LAYERNUMBER');
N = g.get('NODENUMBER');

distance = calculateValue@Distance(m, prop);

in_global_efficiency = cell(L, 1);
parfor li = 1:1:L
    inverse_distance = distance{li}.^-1;  % inverse distance
    inverse_distance(1:N(li)+1:end) = 0;
    global_efficiency_layer = (sum(inverse_distance, 1) / (N(li)-1));
    in_global_efficiency(li) = {global_efficiency_layer};
end
value = in_global_efficiency;

%% ¡tests!

%%% ¡excluded_props!
[GlobalEfficiencyIn.PFM]

%%% ¡test!
%%%% ¡name!
GraphBD
%%%% ¡code!
B = [
    0   .1  0   0   0
    .2  0   0   0   0
    0   0   0   .2  0
    0   0   .1  0   0
    0   0   0   0   0
    ];

known_in_global_efficiency = {[1/4 1/4 1/4 1/4 0]};

g = GraphBD('B', B);

m_outside_g = GlobalEfficiencyIn('G', g);
assert(isequal(m_outside_g.get('M'), known_in_global_efficiency), ...
   [BRAPH2.STR ':GlobalEfficiencyIn:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'GlobalEfficiencyIn');
assert(isequal(m_inside_g.get('M'), known_in_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiencyIn:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
GraphWD
%%%% ¡code!
B = [
    0   .1  0   0   0
    .2  0   0   0   0
    0   0   0   .2  0
    0   0   .1  0   0
    0   0   0   0   0
    ];

known_in_global_efficiency = {[.2/4 .1/4 .1/4 .2/4 0]};

g = GraphWD('B', B);

m_outside_g = GlobalEfficiencyIn('G', g);
assert(isequal(m_outside_g.get('M'), known_in_global_efficiency), ...
   [BRAPH2.STR ':GlobalEfficiencyIn:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'GlobalEfficiencyIn');
assert(isequal(m_inside_g.get('M'), known_in_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiencyIn:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexWD
%%%% ¡code!
B11 = [
      0   .1  0   0   0
      .2  0   0   0   0
      0   0   0   .2  0
      0   0   .1  0   0
      0   0   0   0   0
      ];

B22 = [
      0   .1  0   0   0
      .2  0   0   0   0
      0   0   0   .2  0
      0   0   .1  0   0
      0   0   0   0   0
      ];
B = {B11  B22};

known_in_global_efficiency = {
                        [.2/4 .1/4 .1/4 .2/4 0]
                        [.2/4 .1/4 .1/4 .2/4 0]
                        };

g = MultiplexWD('B', B);

m_outside_g = GlobalEfficiencyIn('G', g);
assert(isequal(m_outside_g.get('M'), known_in_global_efficiency), ...
   [BRAPH2.STR ':GlobalEfficiencyIn:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'GlobalEfficiencyIn');
assert(isequal(m_inside_g.get('M'), known_in_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiencyIn:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBD
%%%% ¡code!
B11 = [
      0   .1  0   0   0
      .2  0   0   0   0
      0   0   0   .2  0
      0   0   .1  0   0
      0   0   0   0   0
      ];

B22 = [
      0   .1  0   0   0
      .2  0   0   0   0
      0   0   0   .2  0
      0   0   .1  0   0
      0   0   0   0   0
      ];
B = {B11  B22};

known_in_global_efficiency = {
                        [1/4 1/4 1/4 1/4 0]
                        [1/4 1/4 1/4 1/4 0]
                        };

g = MultiplexBD('B', B);

m_outside_g = GlobalEfficiencyIn('G', g);
assert(isequal(m_outside_g.get('M'), known_in_global_efficiency), ...
   [BRAPH2.STR ':GlobalEfficiencyIn:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'GlobalEfficiencyIn');
assert(isequal(m_inside_g.get('M'), known_in_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiencyIn:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
OrdMxWD
%%%% ¡code!
B11 = [
      0   .1  0   0   0
      .2  0   0   0   0
      0   0   0   .2  0
      0   0   .1  0   0
      0   0   0   0   0
      ];

B22 = [
      0   .1  0   0   0
      .2  0   0   0   0
      0   0   0   .2  0
      0   0   .1  0   0
      0   0   0   0   0
      ];
B = {B11  B22};

known_in_global_efficiency = {
                        [.2/4 .1/4 .1/4 .2/4 0]
                        [.2/4 .1/4 .1/4 .2/4 0]
                        };

g = OrdMxWD('B', B);

m_outside_g = GlobalEfficiencyIn('G', g);
assert(isequal(m_outside_g.get('M'), known_in_global_efficiency), ...
   [BRAPH2.STR ':GlobalEfficiencyIn:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'GlobalEfficiencyIn');
assert(isequal(m_inside_g.get('M'), known_in_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiencyIn:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
OrdMxBD
%%%% ¡code!
B11 = [
      0   .1  0   0   0
      .2  0   0   0   0
      0   0   0   .2  0
      0   0   .1  0   0
      0   0   0   0   0
      ];

B22 = [
      0   .1  0   0   0
      .2  0   0   0   0
      0   0   0   .2  0
      0   0   .1  0   0
      0   0   0   0   0
      ];
B = {B11  B22};

known_in_global_efficiency = {
                        [1/4 1/4 1/4 1/4 0]
                        [1/4 1/4 1/4 1/4 0]
                        };

g = OrdMxBD('B', B);

m_outside_g = GlobalEfficiencyIn('G', g);
assert(isequal(m_outside_g.get('M'), known_in_global_efficiency), ...
   [BRAPH2.STR ':GlobalEfficiencyIn:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'GlobalEfficiencyIn');
assert(isequal(m_inside_g.get('M'), known_in_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiencyIn:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])
