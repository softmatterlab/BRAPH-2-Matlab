%% ¡header!
PathLengthOutAv < PathLengthOut (m, average out-path length) is the graph Average Out-Path Length.

%%% ¡description!
The Average Out-Path Length (PathLengthOutAv) is the average shortest out-path lengths of one node to all other nodes within a layer.

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
PathLengthOutAv.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
PathLengthOutAv.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
PathLengthOutAv.RULE
%%%% ¡title!
Out-Path Length rule

%%% ¡prop!
%%%% ¡id!
PathLengthOutAv.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
PathLengthOutAv.M
%%%% ¡title!
Average Out-Path Length

%%% ¡prop!
%%%% ¡id!
PathLengthOutAv.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
PathLengthOutAv.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
PathLengthOutAv.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graph

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Average Out-Path Length.
%%%% ¡default!
'PathLengthOutAv'

%%% ¡prop!
NAME (constant, string) is the name of the Average Out-Path Length.
%%%% ¡default!
'Average Out-Path Length'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the Average Out-Path Length.
%%%% ¡default!
'The Average Out-Path Length (PathLengthOutAv) is the average shortest out-path lengths of one node to all other nodes within a layer.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Average Out-Path Length.
%%%% ¡settings!
'PathLengthOutAv'

%%% ¡prop!
ID (data, string) is a few-letter code of the Average Out-Path Length.
%%%% ¡default!
'PathLengthOutAv ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Average Out-Path Length.
%%%% ¡default!
'Average Out-Path Length label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the Average Out-Path Length.
%%%% ¡default!
'Average Out-Path Length notes'

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
{'GraphBD' 'GraphWD' 'MultiplexBD' 'MultiplexWD' 'MultilayerBD' 'OrdMlBD'}

%%% ¡prop!
M (result, cell) is the cell containing the Average Out-Path Length.
%%%% ¡calculate!
g = m.get('G');  % graph from measure class
L = g.get('LAYERNUMBER');

out_path_length = calculateValue@PathLengthOut(m, prop);
out_path_length_av = cell(L, 1);
path_length_rule = m.get('RULE');

warning('off', 'MATLAB:remoteparfor:ParforWorkerAborted')
parfor li = 1:1:length(out_path_length_av)
    switch lower(path_length_rule)
        case {'subgraphs'}
            player = out_path_length{li};
            out_path_length_av(li) = {mean(player(player~=Inf))};
        case {'mean'}
            out_path_length_av(li) = {mean(out_path_length{li})};
        otherwise  % 'harmonic' 'default'
            out_path_length_av(li) = {harmmean(out_path_length{li})};
    end
end
warning('on', 'MATLAB:remoteparfor:ParforWorkerAborted')

value = out_path_length_av;

%% ¡tests!

%%% ¡excluded_props!
[PathLengthOutAv.PFM]

%%% ¡test!
%%%% ¡name!
GraphBD
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0  1  1  1  0;
    1  0  0  0  0;
    1  1  0  1  0;
    1  1  0  0  0;
    0  0  0  0  0
    ];

known_out_path_length_av = {harmmean([1.3333 2 1.3333 1.6000 Inf])};

g = GraphBD('B', B);

m_outside_g = PathLengthOutAv('G', g);
pl_answer = cellfun(@(x) round(x, 3), m_outside_g.get('M'), 'UniformOutput', false);
known_out_path_length_av_round = cellfun(@(x) round(x, 3), known_out_path_length_av, 'UniformOutput', false);
assert(isequal(pl_answer, known_out_path_length_av_round), ...
    [BRAPH2.STR ':PathLengthOutAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'PathLengthOutAv');
pl_answer = cellfun(@(x) round(x, 3), m_inside_g.get('M'), 'UniformOutput', false);
assert(isequal(pl_answer, known_out_path_length_av_round), ...
    [BRAPH2.STR ':PathLengthOutAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBD
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
      0  1  1  1  0;
      1  0  0  0  0;
      1  1  0  1  0;
      1  1  0  0  0;
      0  0  0  0  0
      ];

B22 = [
      0  1  1  1  0;
      1  0  0  0  0;
      1  1  0  1  0;
      1  1  0  0  0;
      0  0  0  0  0
       ];
B = {B11 B22};

known_out_path_length_av = {
    harmmean([1.3333 2 1.3333 1.6000 Inf])
    harmmean([1.3333 2 1.3333 1.6000 Inf])
    };

g = MultiplexBD('B', B);

m_outside_g = PathLengthOutAv('G', g);
pl_answer = cellfun(@(x) round(x, 3), m_outside_g.get('M'), 'UniformOutput', false);
known_out_path_length_av_round = cellfun(@(x) round(x, 3), known_out_path_length_av, 'UniformOutput', false);
assert(isequal(pl_answer, known_out_path_length_av_round), ...
    [BRAPH2.STR ':PathLengthOutAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'PathLengthOutAv');
pl_answer = cellfun(@(x) round(x, 3), m_inside_g.get('M'), 'UniformOutput', false);
assert(isequal(pl_answer, known_out_path_length_av_round), ...
    [BRAPH2.STR ':PathLengthOutAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
OrdMxBD
%%%% ¡probability!
.01
%%%% ¡code!
A11 = [
      0  1  1  1  0;
      1  0  0  0  0;
      1  1  0  1  0;
      1  1  0  0  0;
      0  0  0  0  0
      ];

A22 = [
      0  1  1  1  0;
      1  0  0  0  0;
      1  1  0  1  0;
      1  1  0  0  0;
      0  0  0  0  0
      ];
A = {A11  A22};

known_out_path_length_av = {
    harmmean([1.3333 2 1.3333 1.6000 Inf])
    harmmean([1.3333 2 1.3333 1.6000 Inf])
    };

g = OrdMxBD('B', A);
m_outside_g = PathLengthOutAv('G', g);
pl_answer = cellfun(@(x) round(x, 3), m_outside_g.get('M'), 'UniformOutput', false);
known_out_path_length_av_round = cellfun(@(x) round(x, 3), known_out_path_length_av, 'UniformOutput', false);
assert(isequal(pl_answer, known_out_path_length_av_round), ...
    [BRAPH2.STR ':PathLengthOutAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'PathLengthOutAv');
pl_answer = cellfun(@(x) round(x, 3), m_inside_g.get('M'), 'UniformOutput', false);
assert(isequal(pl_answer, known_out_path_length_av_round), ...
    [BRAPH2.STR ':PathLengthOutAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])