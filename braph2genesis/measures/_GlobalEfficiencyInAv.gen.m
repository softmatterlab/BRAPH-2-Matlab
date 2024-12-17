%% ¡header!
GlobalEfficiencyInAv < GlobalEfficiencyIn (m, average in-global efficiency) is the graph Average In-Global Efficiency.

%%% ¡description!
The Average In-Global Efficiency (GlobalEfficiencyInAv) is the average inverse shortest in-path length within each layer. 

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
GlobalEfficiencyInAv.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
GlobalEfficiencyInAv.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
GlobalEfficiencyInAv.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
GlobalEfficiencyInAv.M
%%%% ¡title!
Average In-Global Efficiency

%%% ¡prop!
%%%% ¡id!
GlobalEfficiencyInAv.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
GlobalEfficiencyInAv.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
GlobalEfficiencyInAv.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the graph Average In-Global Efficiency.
%%%% ¡default!
'GlobalEfficiencyInAv'

%%% ¡prop!
NAME (constant, string) is the name of the graph Average In-Global Efficiency.
%%%% ¡default!
'Average In-Global Efficiency'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the graph Average In-Global Efficiency.
%%%% ¡default!
'The Average In-Global Efficiency (GlobalEfficiencyInAv) is the average inverse shortest in-path length within each layer.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the graph Average In-Global Efficiency.
%%%% ¡settings!
'GlobalEfficiencyInAv'

%%% ¡prop!
ID (data, string) is a few-letter code of the graph Average In-Global Efficiency.
%%%% ¡default!
'GlobalEfficiencyInAv ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the graph Average In-Global Efficiency.
%%%% ¡default!
'Average In-Global Efficiency label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the graph Average In-Global Efficiency.
%%%% ¡default!
'Average In-Global Efficiency notes'

%%% ¡prop!
SHAPE (constant, scalar) is the measure shape __Measure.GLOBAL__.
%%%% ¡default!
Measure.GLOBAL

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
M (result, cell) is the Average In-Global Efficiency.
%%%% ¡calculate!
g = m.get('G');  % graph from measure class
L = g.get('LAYERNUMBER');

in_global_efficiency = calculateValue@GlobalEfficiencyIn(m, prop);

in_global_efficiency_av = cell(L, 1);

warning('off', 'MATLAB:remoteparfor:ParforWorkerAborted')
parfor li = 1:1:L
    in_global_efficiency_av(li) = {mean(in_global_efficiency{li})};
end
warning('on', 'MATLAB:remoteparfor:ParforWorkerAborted')

value = in_global_efficiency_av;

%% ¡tests!

%%% ¡excluded_props!
[GlobalEfficiencyInAv.PFM]

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

known_in_global_efficiency = {mean([1/4 1/4 1/4 1/4 0])};

g = GraphBD('B', B);

m_outside_g = GlobalEfficiencyInAv('G', g);
assert(isequal(m_outside_g.get('M'), known_in_global_efficiency), ...
   [BRAPH2.STR ':GlobalEfficiencyInAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'GlobalEfficiencyInAv');
assert(isequal(m_inside_g.get('M'), known_in_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiencyInAv:' BRAPH2.FAIL_TEST], ...
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

known_in_global_efficiency = {mean([.2/4 .1/4 .1/4 .2/4 0])};

g = GraphWD('B', B);

m_outside_g = GlobalEfficiencyInAv('G', g);
assert(isequal(m_outside_g.get('M'), known_in_global_efficiency), ...
   [BRAPH2.STR ':GlobalEfficiencyInAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'GlobalEfficiencyInAv');
assert(isequal(m_inside_g.get('M'), known_in_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiencyInAv:' BRAPH2.FAIL_TEST], ...
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
                        mean([.2/4 .1/4 .1/4 .2/4 0])
                        mean([.2/4 .1/4 .1/4 .2/4 0])
                        };

g = MultiplexWD('B', B);

m_outside_g = GlobalEfficiencyInAv('G', g);
assert(isequal(m_outside_g.get('M'), known_in_global_efficiency), ...
   [BRAPH2.STR ':GlobalEfficiencyInAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'GlobalEfficiencyInAv');
assert(isequal(m_inside_g.get('M'), known_in_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiencyInAv:' BRAPH2.FAIL_TEST], ...
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
                        mean([1/4 1/4 1/4 1/4 0])
                        mean([1/4 1/4 1/4 1/4 0])
                        };

g = MultiplexBD('B', B);

m_outside_g = GlobalEfficiencyInAv('G', g);
assert(isequal(m_outside_g.get('M'), known_in_global_efficiency), ...
   [BRAPH2.STR ':GlobalEfficiencyInAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'GlobalEfficiencyInAv');
assert(isequal(m_inside_g.get('M'), known_in_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiencyInAv:' BRAPH2.FAIL_TEST], ...
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
                        mean([.2/4 .1/4 .1/4 .2/4 0])
                        mean([.2/4 .1/4 .1/4 .2/4 0])
                        };

g = OrdMxWD('B', B);

m_outside_g = GlobalEfficiencyInAv('G', g);
assert(isequal(m_outside_g.get('M'), known_in_global_efficiency), ...
   [BRAPH2.STR ':GlobalEfficiencyInAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'GlobalEfficiencyInAv');
assert(isequal(m_inside_g.get('M'), known_in_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiencyInAv:' BRAPH2.FAIL_TEST], ...
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
                        mean([1/4 1/4 1/4 1/4 0])
                        mean([1/4 1/4 1/4 1/4 0])
                        };

g = OrdMxBD('B', B);

m_outside_g = GlobalEfficiencyInAv('G', g);
assert(isequal(m_outside_g.get('M'), known_in_global_efficiency), ...
   [BRAPH2.STR ':GlobalEfficiencyInAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'GlobalEfficiencyInAv');
assert(isequal(m_inside_g.get('M'), known_in_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiencyInAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])
