%% ¡header!
PathLengthInAv < PathLengthIn (m, average in-path length) is the graph Average In-Path Length.

%%% ¡description!
The Average In-Path Length (PathLengthInAv) of a graph is the average of the sum of the in-path lengths within each layer. 

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
PathLengthInAv.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
PathLengthInAv.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
PathLengthInAv.RULE
%%%% ¡title!
In-Path Length rule

%%% ¡prop!
%%%% ¡id!
PathLengthInAv.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
PathLengthInAv.M
%%%% ¡title!
Average In-Path Length

%%% ¡prop!
%%%% ¡id!
PathLengthInAv.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
PathLengthInAv.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
PathLengthInAv.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graph

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Average In-Path Length.
%%%% ¡default!
'PathLengthInAv'

%%% ¡prop!
NAME (constant, string) is the name of the Average In-Path Length.
%%%% ¡default!
'Average In-Path Length'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the Average In-Path Length.
%%%% ¡default!
'The Average In-Path Length (PathLengthInAv) of a graph is the average of the sum of the in-path lengths within each layer.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Average In-Path Length.
%%%% ¡settings!
'PathLengthInAv'

%%% ¡prop!
ID (data, string) is a few-letter code of the Average In-Path Length.
%%%% ¡default!
'PathLengthInAv ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Average In-Path Length.
%%%% ¡default!
'Average In-Path Length label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the Average In-Path Length.
%%%% ¡default!
'Average In-Path Length notes'

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
M (result, cell) is the cell containing the Average In-Path Length.
%%%% ¡calculate!
g = m.get('G');  % graph from measure class
L = g.get('LAYERNUMBER');

in_path_length = calculateValue@PathLengthIn(m, prop);
in_path_length_av = cell(L, 1);
path_length_rule = m.get('RULE');

warning('off', 'MATLAB:remoteparfor:ParforWorkerAborted')
parfor li = 1:1:length(in_path_length_av)
    switch lower(path_length_rule)
        case {'subgraphs'}
            player = in_path_length{li};
            in_path_length_av(li) = {mean(player(player~=Inf))};
        case {'mean'}
            in_path_length_av(li) = {mean(in_path_length{li})};
        otherwise  % 'harmonic' 'default'
            in_path_length_av(li) = {harmmean(in_path_length{li})};
    end
end
warning('on', 'MATLAB:remoteparfor:ParforWorkerAborted')

value = in_path_length_av;

%% ¡tests!

%%% ¡excluded_props!
[PathLengthInAv.PFM]

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

known_in_path_length_av = {harmmean([1.3333 1.3333 2 1.6000 Inf])};

g = GraphBD('B', B);

m_outside_g = PathLengthInAv('G', g);
pl_answer = cellfun(@(x) round(x, 3), m_outside_g.get('M'), 'UniformOutput', false);
known_in_path_length_av_round = cellfun(@(x) round(x, 3), known_in_path_length_av, 'UniformOutput', false);
assert(isequal(pl_answer, known_in_path_length_av_round), ...
    [BRAPH2.STR ':PathLengthInAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'PathLengthInAv');
pl_answer = cellfun(@(x) round(x, 3), m_inside_g.get('M'), 'UniformOutput', false);
assert(isequal(pl_answer, known_in_path_length_av_round), ...
    [BRAPH2.STR ':PathLengthInAv:' BRAPH2.FAIL_TEST], ...
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
  
known_in_path_length_av = {
    harmmean([1.3333 1.3333 2 1.6000 Inf])
    harmmean([1.3333 1.3333 2 1.6000 Inf])
    };

g = MultiplexBD('B', B);

m_outside_g = PathLengthInAv('G', g);
pl_answer = cellfun(@(x) round(x, 3), m_outside_g.get('M'), 'UniformOutput', false);
known_in_path_length_av_round = cellfun(@(x) round(x, 3), known_in_path_length_av, 'UniformOutput', false);
assert(isequal(pl_answer, known_in_path_length_av_round), ...
    [BRAPH2.STR ':PathLengthInAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'PathLengthInAv');
pl_answer = cellfun(@(x) round(x, 3), m_inside_g.get('M'), 'UniformOutput', false);
assert(isequal(pl_answer, known_in_path_length_av_round), ...
    [BRAPH2.STR ':PathLengthInAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
OrdMlBD
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
B12 = rand(size(B11,1),size(B22,2));
B21 = B12';
B = {B11 B12;
     B21 B22};

known_in_path_length_av = {
    harmmean([1.3333 1.3333 2 1.6000 Inf])
    harmmean([1.3333 1.3333 2 1.6000 Inf])
    };

g = OrdMlBD('B', B);

m_outside_g = PathLengthInAv('G', g);
pl_answer = cellfun(@(x) round(x, 3), m_outside_g.get('M'), 'UniformOutput', false);
known_in_path_length_av_round = cellfun(@(x) round(x, 3), known_in_path_length_av, 'UniformOutput', false);
assert(isequal(pl_answer, known_in_path_length_av_round), ...
    [BRAPH2.STR ':PathLengthInAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'PathLengthInAv');
pl_answer = cellfun(@(x) round(x, 3), m_inside_g.get('M'), 'UniformOutput', false);
assert(isequal(pl_answer, known_in_path_length_av_round), ...
    [BRAPH2.STR ':PathLengthInAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])