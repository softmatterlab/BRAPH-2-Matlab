%% ¡header!
PathLengthOut < Measure (m, out-path length) is the graph Out-Path Length.

%%% ¡description!
The Out-Path Length (PathLengthOut) is the average shortest out-path lengths of one node to all other nodes without a layer.

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
PathLengthOut.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
PathLengthOut.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
PathLengthOut.RULE
%%%% ¡title!
Out-Path Length rule

%%% ¡prop!
%%%% ¡id!
PathLengthOut.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
PathLengthOut.M
%%%% ¡title!
Out-Path Length

%%% ¡prop!
%%%% ¡id!
PathLengthOut.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
PathLengthOut.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
PathLengthOut.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graph

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Out-Path Length.
%%%% ¡default!
'PathLengthOut'

%%% ¡prop!
NAME (constant, string) is the name of the Out-Path Length.
%%%% ¡default!
'Out-Path Length'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the Out-Path Length.
%%%% ¡default!
'The Out-Path Length (PathLengthOut) is the average shortest out-path lengths of one node to all other nodes without a layer.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Out-Path Length.
%%%% ¡settings!
'PathLengthOut'

%%% ¡prop!
ID (data, string) is a few-letter code of the Out-Path Length.
%%%% ¡default!
'PathLengthOut ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Out-Path Length.
%%%% ¡default!
'Out-Path Length label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the Out-Path Length.
%%%% ¡default!
'Out-Path Length notes'

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
{'GraphBD' 'GraphWD' 'MultiplexBD' 'MultiplexWD' 'MultilayerBD' 'OrdMxBD'}

%%% ¡prop!
M (result, cell) is the cell containing the Out-Path Length.
%%%% ¡calculate!
g = m.get('G');  % graph from measure class
A = g.get('A');  % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
N = g.get('NODENUMBER');
L = g.get('LAYERNUMBER');

out_path_length = cell(L, 1);                    
path_length_rule = m.get('RULE');

distance = Distance('G', g).get('M');

parfor li = 1:1:L
    node_number_layer = N(li);
    out_path_length_layer = zeros(node_number_layer, 1);
    distance_layer = distance{li};

    switch lower(path_length_rule)
        case {'subgraphs'}
            for u = 1:1:node_number_layer
                Du = distance_layer(u, :);
                out_path_length_layer(u) = mean(Du(Du~=Inf & Du~=0));
            end
            out_path_length_layer(isnan(out_path_length_layer)) = 0;  % node Nan corresponds to isolated nodes, pathlength is 0
        case {'mean'}
            for u = 1:1:node_number_layer
                Du = distance_layer(u, :);
                out_path_length_layer(u) = mean(Du(Du~=0));
            end
        otherwise  % 'harmonic' 'default'
            for u = 1:1:node_number_layer
                Du = distance_layer(u, :);
                out_path_length_layer(u) = harmmean(Du(Du~=0));
            end
    end
    out_path_length(li) = {out_path_length_layer};
end
value = out_path_length;

%% ¡props!

%%% ¡prop! 
RULE (parameter, option) is the PathLengthOut algorithm
%%%% ¡settings!
{'subgraphs' 'harmonic' 'mean'}
%%%% ¡default!
'harmonic'

%% ¡tests!

%%% ¡excluded_props!
[PathLengthOut.PFM]

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

known_out_path_length = {[1.3333 2 1.3333 1.6000 Inf]'};
known_out_path_length = cellfun(@(x) round(x, 3), known_out_path_length, 'UniformOutput', false);
g = GraphBD('B', B);

m_outside_g = PathLengthOut('G', g);
assert(isequal(cellfun(@(x) round(x, 3), m_outside_g.get('M'), 'UniformOutput', false), known_out_path_length), ...
    [BRAPH2.STR ':PathLengthOut:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'PathLengthOut');
assert(isequal(cellfun(@(x) round(x, 3), m_outside_g.get('M'), 'UniformOutput', false), known_out_path_length), ...
    [BRAPH2.STR ':PathLengthOut:' BRAPH2.FAIL_TEST], ...
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

known_out_path_length = {
                    [Inf Inf Inf Inf Inf]'
                    [Inf Inf Inf Inf Inf]'
                    };

g = MultiplexBD('B', A);
m_outside_g = PathLengthOut('G', g);
m_outside_g.set('RULE', 'mean');
assert(isequal(m_outside_g.get('M'), known_out_path_length), ...
    [BRAPH2.STR ':PathLengthOut:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'PathLengthOut');
m_inside_g.set('RULE', 'mean');
assert(isequal(m_inside_g.get('M'), known_out_path_length), ...
    [BRAPH2.STR ':PathLengthOut:' BRAPH2.FAIL_TEST], ...
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

known_out_path_length = {
                    [Inf Inf Inf Inf Inf]'
                    [Inf Inf Inf Inf Inf]'
                    };

g = OrdMxBD('B', A);

m_outside_g = PathLengthOut('G', g);
m_outside_g.set('RULE', 'mean');
assert(isequal(m_outside_g.get('M'), known_out_path_length), ...
    [BRAPH2.STR ':PathLengthOut:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'PathLengthOut');
m_inside_g.set('RULE', 'mean');
assert(isequal(m_inside_g.get('M'), known_out_path_length), ...
    [BRAPH2.STR ':PathLengthOut:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])