%% ¡header!
PathLengthIn < Measure (m, in-path length) is the graph In-Path Length.

%%% ¡description!
The In-Path Length (PathLengthIn) is the average shortest in-path length of one node to all other nodes within a layer.

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
PathLengthIn.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
PathLengthIn.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
PathLengthIn.RULE
%%%% ¡title!
In-Path Length rule

%%% ¡prop!
%%%% ¡id!
PathLengthIn.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
PathLengthIn.M
%%%% ¡title!
In-Path Length

%%% ¡prop!
%%%% ¡id!
PathLengthIn.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
PathLengthIn.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
PathLengthIn.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graph

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the In-Path Length .
%%%% ¡default!
'PathLengthIn'

%%% ¡prop!
NAME (constant, string) is the name of the in-path length.
%%%% ¡default!
'In-Path Length'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the In-Path Length.
%%%% ¡default!
'The In-Path Length (PathLengthIn) is the average shortest in-path length of one node to all other nodes within a layer.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the In-Path Length.
%%%% ¡settings!
'PathLengthIn'

%%% ¡prop!
ID (data, string) is a few-letter code of the In-Path Length.
%%%% ¡default!
'PathLengthIn ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the In-Path Length.
%%%% ¡default!
'In-Path Length label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the In-Path Length.
%%%% ¡default!
'In-Path Length notes'

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
M (result, cell) is the cell containing the In-Path Length.
%%%% ¡calculate!
g = m.get('G');  % graph from measure class
A = g.get('A');  % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
N = g.get('NODENUMBER');
L = g.get('LAYERNUMBER');

in_path_length = cell(L, 1);                    
path_length_rule = m.get('RULE');

distance = Distance('G', g).get('M');

warning('off', 'MATLAB:remoteparfor:ParforWorkerAborted')
parfor li = 1:1:L
    node_number_layer = N(li);
    in_path_length_layer = zeros(node_number_layer, 1);
    distance_layer = distance{li};

    switch lower(path_length_rule)
        case {'subgraphs'}
            for u = 1:1:node_number_layer
                Du = distance_layer(:, u);
                in_path_length_layer(u) = mean(Du(Du~=Inf & Du~=0));
            end
            in_path_length_layer(isnan(in_path_length_layer)) = 0;  % node Nan corresponds to isolated nodes, pathlength is 0
        case {'mean'}
            for u = 1:1:node_number_layer
                Du = distance_layer(:, u);
                in_path_length_layer(u) = mean(Du(Du~=0));
            end
        otherwise  % 'harmonic' 'default'
            for u = 1:1:node_number_layer
                Du = distance_layer(:, u);
                in_path_length_layer(u) = harmmean(Du(Du~=0));
            end
    end
    in_path_length(li) = {in_path_length_layer};
end
warning('on', 'MATLAB:remoteparfor:ParforWorkerAborted')

value = in_path_length;

%% ¡props!

%%% ¡prop! 
RULE (parameter, option) is the PathLengthIn algorithm
%%%% ¡settings!
{'subgraphs' 'harmonic' 'mean'}
%%%% ¡default!
'harmonic'

%% ¡tests!

%%% ¡excluded_props!
[PathLengthIn.PFM]

%%% ¡test!
%%%% ¡name!
GraphBD
%%%% ¡probability!
.01
%%%% ¡code!
A = [
    0  1  1  1  0;
    1  0  0  0  0;
    1  1  0  1  0;
    1  1  0  0  0;
    0  0  0  0  0
    ];

known_in_path_length = {[1.3333 1.3333 2 1.6000 Inf]'};
known_in_path_length = cellfun(@(x) round(x, 3), known_in_path_length, 'UniformOutput', false);
g = GraphBD('B', A);

m_outside_g = PathLengthIn('G', g);
assert(isequal(cellfun(@(x) round(x, 3), m_outside_g.get('M'), 'UniformOutput', false), known_in_path_length), ...
    [BRAPH2.STR ':PathLengthIn:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'PathLengthIn');
assert(isequal(cellfun(@(x) round(x, 3), m_outside_g.get('M'), 'UniformOutput', false), known_in_path_length), ...
    [BRAPH2.STR ':PathLengthIn:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBD
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

known_in_path_length = {
                    [Inf Inf Inf Inf Inf]'
                    [Inf Inf Inf Inf Inf]'
                    };

g = MultiplexBD('B', A);

m_outside_g = PathLengthIn('G', g);
m_outside_g.set('RULE', 'mean');
assert(isequal(m_outside_g.get('M'), known_in_path_length), ...
    [BRAPH2.STR ':PathLengthIn:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'PathLengthIn');
m_inside_g.set('RULE', 'mean');
assert(isequal(m_inside_g.get('M'), known_in_path_length), ...
    [BRAPH2.STR ':PathLengthIn:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultilayerBD
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

known_in_path_length = {
                    [Inf Inf Inf Inf Inf]'
                    [Inf Inf Inf Inf Inf]'
                    };

g = MultilayerBD('B', B);

m_outside_g = PathLengthIn('G', g);
m_outside_g.set('RULE', 'mean');
assert(isequal(m_outside_g.get('M'), known_in_path_length), ...
    [BRAPH2.STR ':PathLengthIn:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'PathLengthIn');
m_inside_g.set('RULE', 'mean');
assert(isequal(m_inside_g.get('M'), known_in_path_length), ...
    [BRAPH2.STR ':PathLengthIn:' BRAPH2.FAIL_TEST], ...
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

known_in_path_length = {
                    [Inf Inf Inf Inf Inf]'
                    [Inf Inf Inf Inf Inf]'
                    };

g = OrdMlBD('B', B);

m_outside_g = PathLengthIn('G', g);
m_outside_g.set('RULE', 'mean');
assert(isequal(m_outside_g.get('M'), known_in_path_length), ...
    [BRAPH2.STR ':PathLengthIn:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'PathLengthIn');
m_inside_g.set('RULE', 'mean');
assert(isequal(m_inside_g.get('M'), known_in_path_length), ...
    [BRAPH2.STR ':PathLengthIn:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])