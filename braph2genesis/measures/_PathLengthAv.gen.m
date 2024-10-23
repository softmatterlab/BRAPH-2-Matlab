%% ¡header!
PathLengthAv < PathLength (m, average path length) is the graph Average Path Length.

%%% ¡description!
The Average Path Length (PathLengthAv) of a graph is the average of the sum of 
 the path lengths within each layer.

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
PathLengthAv.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
PathLengthAv.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
PathLengthAv.RULE
%%%% ¡title!
Path Length rule

%%% ¡prop!
%%%% ¡id!
PathLengthAv.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
PathLengthAv.M
%%%% ¡title!
Average Path Length

%%% ¡prop!
%%%% ¡id!
PathLengthAv.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
PathLengthAv.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
PathLengthAv.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graph

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Average Path Length.
%%%% ¡default!
'PathLengthAv'

%%% ¡prop!
NAME (constant, string) is the name of the Average Path Length.
%%%% ¡default!
'Average Path Length'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the Average Path Length.
%%%% ¡default!
'The Average Path Length (PathLengthAv) of a graph is the average of the sum of the path lengths within each layer.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the average path length.
%%%% ¡settings!
'PathLengthAv'

%%% ¡prop!
ID (data, string) is a few-letter code of the average path length.
%%%% ¡default!
'PathLengthAv ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the average path length.
%%%% ¡default!
'PathLengthAv label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the average path length.
%%%% ¡default!
'PathLengthAv notes'

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
{'GraphWU' 'GraphBU' 'MultigraphBUD' 'MultigraphBUT' 'MultiplexWU' 'MultiplexBU' 'MultiplexBUD' 'MultiplexBUT' 'OrdMlBUT' 'MultilayerWU'}

%%% ¡prop!
M (result, cell) is the cell containing the average path length.
%%%% ¡calculate!
g = m.get('G');  % graph from measure class

path_length = calculateValue@PathLength(m, prop);
L = g.get('LAYERNUMBER');
path_length_av = cell(L, 1);
path_length_rule = m.get('RULE');
parfor li = 1:1:length(path_length_av)
    switch lower(path_length_rule)
        case {'subgraphs'}
            player = path_length{li};
            path_length_av(li) = {mean(player(player~=Inf))};
        case {'mean'}
            path_length_av(li) = {mean(path_length{li})};
        otherwise  % 'harmonic' 'default'
            path_length_av(li) = {harmmean(path_length{li})};
    end
end
value = path_length_av;

%% ¡tests!

%%% ¡excluded_props!
[DegreeAv.PFM]


%%% ¡test!
%%%% ¡name!
GraphWU
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0   .1  0   0
    .1  0   0  0
    0   0  0   .1
    0   0   .1  0
    ];

known_path_length = {mean([30 30 30 30]')};

g = GraphWU('B', B);

m_outside_g = PathLengthAv('G', g);
assert(isequal(m_outside_g.get('M'), known_path_length), ...
    [BRAPH2.STR ':PathLengthAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'PathLengthAv');
assert(isequal(m_inside_g.get('M'), known_path_length), ...
    [BRAPH2.STR ':PathLengthAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
GraphBU
%%%% ¡code!
B = [
    0   .1  0   0
    .2  0   .1  0
    0   .1  0   .2
    0   0   .1  0
    ];

known_path_length = {harmmean([18/11 18/15 18/15 18/11]')};

g = GraphBU('B', B);
path_length = PathLengthAv('G', g).get('M');

m_outside_g = PathLengthAv('G', g);
assert(isequal(m_outside_g.get('M'), known_path_length), ...
    [BRAPH2.STR ':PathLengthAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'PathLengthAv');
assert(isequal(m_inside_g.get('M'), known_path_length), ...
    [BRAPH2.STR ':PathLengthAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultigraphBUD
%%%% ¡probability!
.01
%%%% ¡code!
B = [
     0   .1  0   0
    .2  0   .1  0
    0   .1  0   .2
    0   0   .1  0
    ];

densities = [33 67 100];

known_path_length = { ...
    mean([3   3   3   3]')
    1.38
    mean([1 1 1 1]')
    };

g = MultigraphBUD('B', B, 'DENSITIES', densities);

m_outside_g = PathLengthAv('G', g);
pl_answer = cellfun(@(x) round(x, 2), m_outside_g.get('M'), 'UniformOutput', false);
assert(isequal(pl_answer, known_path_length), ...
    [BRAPH2.STR ':PathLengthAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'PathLengthAv');
pl_answer = cellfun(@(x) round(x, 2), m_inside_g.get('M'), 'UniformOutput', false);
assert(isequal(pl_answer, known_path_length), ...
    [BRAPH2.STR ':PathLengthAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultigraphBUT
%%%% ¡probability!
.01
%%%% ¡code!
B = [
     0   .1  0   0
    .2  0   .1  0
    0   .1  0   .2
    0   0   .1  0
    ];

thresholds = [0 1];

known_path_length = { ...
    harmmean([18/11 18/15 18/15 18/11]')
    Inf
    };

g = MultigraphBUT('B', B, 'THRESHOLDS', thresholds);

m_outside_g = PathLengthAv('G', g);
assert(isequal(m_outside_g.get('M'), known_path_length), ...
    [BRAPH2.STR ':PathLengthAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'PathLengthAv');
assert(isequal(m_inside_g.get('M'), known_path_length), ...
    [BRAPH2.STR ':PathLengthAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexWU
%%%% ¡probability!
.01
%%%% ¡code!
A11 = [
    0   .1  0   0
    .1  0   0  0
    0   0  0   .1
    0   0   .1  0
    ];

A22 = [
    0   .1  0   0
    .1  0   0  0
    0   0  0   .1
    0   0   .1  0
    ];

B = {A11  A22};

known_path_length = {
    mean([30 30 30 30]')
    mean([30 30 30 30]')
    };

g = MultiplexWU('B', B);

m_outside_g = PathLengthAv('G', g);
assert(isequal(m_outside_g.get('M'), known_path_length), ...
    [BRAPH2.STR ':PathLengthAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'PathLengthAv');
assert(isequal(m_inside_g.get('M'), known_path_length), ...
    [BRAPH2.STR ':PathLengthAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBU
%%%% ¡probability!
.01
%%%% ¡code!
A11 = [
      0   .1  0   0
      .2  0   .1  0
      0   .1  0   .2
      0   0   .1  0
      ];

A22 = [
      0   .1  0   0
      .2  0   .1  0
      0   .1  0   .2
      0   0   .1  0
      ];
B = { A11  A22};

known_path_length = {
    harmmean([18/11 18/15 18/15 18/11]')
    harmmean([18/11 18/15 18/15 18/11]')
    };

g = MultiplexBU('B', B);

m_outside_g = PathLengthAv('G', g);
assert(isequal(m_outside_g.get('M'), known_path_length), ...
    [BRAPH2.STR ':PathLengthAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'PathLengthAv');
assert(isequal(m_inside_g.get('M'), known_path_length), ...
    [BRAPH2.STR ':PathLengthAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBUD
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0   .1  0   0
    .2  0   .1  0
    0   .1  0   .2
    0   0   .1  0
    ];

densities = [33 67 100];

known_path_length = { ...
    mean([3   3   3   3]')
    mean([3   3   3   3]')
    mean([3   3   3   3]')
    1.38
    1.38
    1.38
    mean([1 1 1 1]')
    mean([1 1 1 1]')
    mean([1 1 1 1]')
    };

g = MultiplexBUD('B', {B B B}, 'DENSITIES', densities);

m_outside_g = PathLengthAv('G', g);
pl_answer = cellfun(@(x) round(x, 2), m_outside_g.get('M'), 'UniformOutput', false);
assert(isequal(pl_answer, known_path_length), ...
    [BRAPH2.STR ':PathLengthAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'PathLengthAv');
pl_answer = cellfun(@(x) round(x, 2), m_inside_g.get('M'), 'UniformOutput', false);
assert(isequal(pl_answer, known_path_length), ...
    [BRAPH2.STR ':PathLengthAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBUT
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0   .1  0   0
    .2  0   .1  0
    0   .1  0   .2
    0   0   .1  0
    ];

thresholds = [0 1];

known_path_length = { ...
    1.38
    1.38
    1.38
    Inf
    Inf
    Inf
    };

g = MultiplexBUT('B', {B B B}, 'THRESHOLDS', thresholds);

m_outside_g = PathLengthAv('G', g);
pl_answer = cellfun(@(x) round(x, 2), m_outside_g.get('M'), 'UniformOutput', false);
assert(isequal(pl_answer, known_path_length), ...
    [BRAPH2.STR ':PathLengthAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'PathLengthAv');
pl_answer = cellfun(@(x) round(x, 2), m_inside_g.get('M'), 'UniformOutput', false);
assert(isequal(pl_answer, known_path_length), ...
    [BRAPH2.STR ':PathLengthAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])
