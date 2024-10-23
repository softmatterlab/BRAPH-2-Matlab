%% ¡header!
LocalEfficiencyAv < LocalEfficiency (m, average local efficiency) is the graph Average Local Efficiency.

%%% ¡description!
The Average Local Efficiency (LocalEfficiencyAv) is the average of all the local efficiencies 
  within each layer.

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
LocalEfficiencyAv.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
LocalEfficiencyAv.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
LocalEfficiencyAv.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
LocalEfficiencyAv.M
%%%% ¡title!
Average Local Efficiency

%%% ¡prop!
%%%% ¡id!
LocalEfficiencyAv.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
LocalEfficiencyAv.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
LocalEfficiencyAv.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Average Local Efficiency.
%%%% ¡default!
'LocalEfficiencyAv'

%%% ¡prop!
NAME (constant, string) is the name of the Average Local Efficiency.
%%%% ¡default!
'Average Local Efficiency'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the Average Local Efficiency.
%%%% ¡default!
'The Average Local Efficiency (LocalEfficiencyAv) is the average of all the local efficiencies within each layer.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Average Local Efficiency.
%%%% ¡settings!
'LocalEfficiencyAv'

%%% ¡prop!
ID (data, string) is a few-letter code of the Average Local Efficiency.
%%%% ¡default!
'LocalEfficiencyAv ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Average Local Efficiency.
%%%% ¡default!
'Average Local Efficiency label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the Average Local Efficiency.
%%%% ¡default!
'Average Local Efficiency notes'

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
%%% ¡default!
{'GraphWU' 'GraphBU' 'MultigraphBUD' 'MultigraphBUT' 'MultiplexWU' 'MultiplexBU' 'MultiplexBUD' 'MultiplexBUT'};

%%% ¡prop!
M (result, cell) is the Average Local Efficiency.
%%%% ¡calculate!
local_efficiency = calculateValue@LocalEfficiency(m, prop);
g = m.get('G');  % graph from measure class

local_efficiency_av = cell(g.get('LAYERNUMBER'), 1);
ls = g.get('PARTITIONS');
L = g.get('LAYERNUMBER');

if L == 0
    value = {};
    return;
end

parfor li = 1:L
    local_efficiency_av(li) ={mean(local_efficiency{li})};
end

value = local_efficiency_av;

%% ¡tests!

%%% ¡excluded_props!
[LocalEfficiencyAv.PFM]

%%% ¡test!
%%%% ¡name!
GraphWU
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0   .2  .2  .1
    .2  0   .3  0
    .2  .3  0   .3
    .1  0   .3  0
    ];

known_local_efficiency = {mean(round([1/4 1/5 .1222 1/5]', 3))};

g = GraphWU('B', B);

m_outside_g = LocalEfficiencyAv('G', g);
tmp_val = m_outside_g.get('M');
assert(isequal(round(tmp_val{1}, 3), known_local_efficiency{1}), ...
    [BRAPH2.STR ':LocalEfficiencyAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'LocalEfficiencyAv');
tmp_val = m_inside_g.get('M');
assert(isequal(round(tmp_val{1}, 3), known_local_efficiency{1}), ...
    [BRAPH2.STR ':LocalEfficiencyAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
GraphBU
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0  1  1  1
    1  0  1  0
    1  1  0  1
    1  0  1  0
    ];

known_local_efficiency = {mean([5/6 1 5/6 1]')};

g = GraphBU('B', B);

m_outside_g = LocalEfficiencyAv('G', g);
assert(isequal(m_outside_g.get('M'), known_local_efficiency), ...
    [BRAPH2.STR ':LocalEfficiencyAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'LocalEfficiencyAv');
assert(isequal(m_inside_g.get('M'), known_local_efficiency), ...
    [BRAPH2.STR ':LocalEfficiencyAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultigraphBUD
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0  1  1  1
    1  0  1  0
    1  1  0  1
    1  0  1  0
    ];

known_local_efficiency = {...
    mean([0   0 0   0]')
    mean([5/6 1 5/6 1]')
    };

densities = [10 90];
g = MultigraphBUD('B', B, 'DENSITIES', densities);

m_outside_g = LocalEfficiencyAv('G', g);
assert(isequal(m_outside_g.get('M'), known_local_efficiency), ...
    [BRAPH2.STR ':LocalEfficiencyAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'LocalEfficiencyAv');
assert(isequal(m_inside_g.get('M'), known_local_efficiency), ...
    [BRAPH2.STR ':LocalEfficiencyAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultigraphBUT
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0  1  1  1
    1  0  1  0
    1  1  0  1
    1  0  1  0
    ];

known_local_efficiency = {...    
    mean([5/6 1 5/6 1]')
    mean([0   0 0   0]')
    };

thresholds = [0 1];
g = MultigraphBUT('B', B, 'THRESHOLDS', thresholds);

m_outside_g = LocalEfficiencyAv('G', g);
assert(isequal(m_outside_g.get('M'), known_local_efficiency), ...
    [BRAPH2.STR ':LocalEfficiencyAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'LocalEfficiencyAv');
assert(isequal(m_inside_g.get('M'), known_local_efficiency), ...
    [BRAPH2.STR ':LocalEfficiencyAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexWU
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0   .2  .2  .1
    .2  0   .3  0
    .2  .3  0   .3
    .1  0   .3  0
    ];
B22 = [
    0   .2  .2  .1
    .2  0   .3  0
    .2  .3  0   .3
    .1  0   .3  0
    ];
B = {B11 B22};

known_local_efficiency = {
    mean( round([1/4 1/5 .1222 1/5]', 3))
    mean( round([1/4 1/5 .1222 1/5]', 3))
    };

g = MultiplexWU('B', B);

m_outside_g = LocalEfficiencyAv('G', g);
tmp_val = m_outside_g.get('M');
tmp_val = cellfun(@(x) round(x, 3), tmp_val, 'UniformOutput', false);
assert(isequal(tmp_val, known_local_efficiency), ...
    [BRAPH2.STR ':LocalEfficiencyAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'LocalEfficiencyAv');
tmp_val = m_inside_g.get('M');
tmp_val = cellfun(@(x) round(x, 3), tmp_val, 'UniformOutput', false);
assert(isequal(tmp_val, known_local_efficiency), ...
    [BRAPH2.STR ':LocalEfficiencyAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBU
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0  1  1  1
    1  0  1  0
    1  1  0  1
    1  0  1  0
    ];

B22 = [
    0  1  1  1
    1  0  1  0
    1  1  0  1
    1  0  1  0
    ];
B = {B11 B22};

known_local_efficiency = {
    mean([5/6 1 5/6 1]')
    mean([5/6 1 5/6 1]')
    };

g = MultiplexBU('B', B);

m_outside_g = LocalEfficiencyAv('G', g);
assert(isequal(m_outside_g.get('M'), known_local_efficiency), ...
    [BRAPH2.STR ':LocalEfficiencyAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'LocalEfficiencyAv');
assert(isequal(m_inside_g.get('M'), known_local_efficiency), ...
    [BRAPH2.STR ':LocalEfficiencyAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBUD
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
       0  1  1  1
       1  0  1  0
       1  1  0  1
       1  0  1  0
      ];

B22 = [
       0  1  1  1
       1  0  1  0
       1  1  0  1
       1  0  1  0
      ];
B = {B11 B22};

known_local_efficiency = {                         
                         mean([0   0 0   0]')
                         mean([0   0 0   0]')
                         mean([5/6 1 5/6 1]')
                         mean([5/6 1 5/6 1]')
                         };

g = MultiplexBUD('B', B, 'DENSITIES', [10 90]);

m_outside_g = LocalEfficiencyAv('G', g);
assert(isequal(m_outside_g.get('M'), known_local_efficiency), ...
    [BRAPH2.STR ':LocalEfficiencyAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'LocalEfficiencyAv');
assert(isequal(m_inside_g.get('M'), known_local_efficiency), ...
    [BRAPH2.STR ':LocalEfficiencyAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBUT
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
       0  1  1  1
       1  0  1  0
       1  1  0  1
       1  0  1  0
      ];

B22 = [
       0  1  1  1
       1  0  1  0
       1  1  0  1
       1  0  1  0
      ];
B = {B11 B22};

known_local_efficiency = {
    mean([5/6 1 5/6 1]')
    mean([5/6 1 5/6 1]')
    mean([0   0 0   0]')
    mean([0   0 0   0]')
    };
thresholds = [0 1];
g = MultiplexBUT('B', B, 'THRESHOLDS', thresholds);

m_outside_g = LocalEfficiencyAv('G', g);
assert(isequal(m_outside_g.get('M'), known_local_efficiency), ...
    [BRAPH2.STR ':LocalEfficiencyAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'LocalEfficiencyAv');
assert(isequal(m_inside_g.get('M'), known_local_efficiency), ...
    [BRAPH2.STR ':LocalEfficiencyAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])