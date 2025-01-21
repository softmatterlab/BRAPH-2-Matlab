%% ¡header!
Assortativity < Measure (m, assortativity) is the graph Assortativity.

%%% ¡description!
The Assortativity coefficient (Assortativity) of a graph is the correlation coefficient 
 between the degrees/strengths of all nodes on two opposite ends of an edge 
 within a layer.
The corresponding coefficient for directed and weighted networks is 
 calculated by using the weighted and directed variants of degree/strength.

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
Assortativity.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
Assortativity.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
Assortativity.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
Assortativity.M
%%%% ¡title!
Assortativity

%%% ¡prop!
%%%% ¡id!
Assortativity.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
Assortativity.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
Assortativity.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Assortativity.
%%%% ¡default!
'Assortativity'

%%% ¡prop!
NAME (constant, string) is the name of the Assortativity.
%%%% ¡default!
'Assortativity'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the Assortativity.
%%%% ¡default!
'The Assortativity coefficient (Assortativity) of a graph is the correlation coefficient between the degrees/strengths of all nodes on two opposite ends of an edge within a layer. The corresponding coefficient for directed and weighted networks is calculated by using the weighted and directed variants of degree/strength.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Assortativity.
%%%% ¡settings!
'Assortativity'

%%% ¡prop!
ID (data, string) is a few-letter code of the Assortativity.
%%%% ¡default!
'Assortativity ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Assortativity.
%%%% ¡default!
'Assortativity label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the Assortativity.
%%%% ¡default!
'Assortativity notes'

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
{'GraphBU' 'GraphWU' 'MultigraphBUD' 'MultigraphBUT' 'MultiplexBU' 'MultiplexWU' 'MultiplexBUD' 'MultiplexBUT' 'MultilayerWU'}

%%% ¡prop!
M (result, cell) is the cell containing the assortativity value.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
L = g.get('LAYERNUMBER');

assortativity = cell(L, 1);
connectivity_layer =  g.get('CONNECTIVITY_TYPE', g.get('LAYERNUMBER'));
for li = 1:1:L
    Aii = A{li, li};
    [i, j] = find(triu(Aii) ~= 0);  % nodes [i, j]
    M = length(i);  % Number of edges
    k_i = zeros(M, L);
    k_j = zeros(length(j), L);
    
    if connectivity_layer == Graph.BINARY 
        
        degree = Degree('G', g).get('M');        
        d = degree{li};
        
    elseif connectivity_layer == Graph.WEIGHTED 
        
        strength = Strength('G', g).get('M');        
        d = strength{li};
    end
    k_i(:, li) = d(i);  % degree/strength node i
    k_j(:, li) = d(j);  % degree/strength node j
    % compute assortativity
    assortativity_layer = (sum(k_i(:, li) .* k_j(:, li)) / M - (sum(0.5 * (k_i(:, li) + k_j(:, li))) / M)^2)...
        / (sum(0.5 * (k_i(:, li).^2 + k_j(:, li).^2)) / M - (sum(0.5 * (k_i(:, li) + k_j(:, li))) / M)^2);
    assortativity_layer(isnan(assortativity_layer)) = 0;  % Should return zeros, not NaN
    assortativity(li) = {assortativity_layer};
end

value = assortativity;

%% ¡tests!

%%% ¡excluded_props!
[Assortativity.PFM]

%%% ¡test!
%%%% ¡name!
GraphWU
%%%% ¡probability!
.01
%%%% ¡code!
B_WU = [
    .1 .2 0 0 .1;
    .2 .1 .3 .2 0;
    0 .3 .1 .1 0;
    0 .2 .1 .1 .2;
    .1 0 0 .2 .1];

assortativity_WU = (14.222222/6-(9.333333/6)^2)/(16.111111/6-(9.333333/6)^2);

g = GraphWU('B', B_WU);

m_outside_g = Assortativity('G', g).get('M');
assert(round(m_outside_g{1},3) == round(assortativity_WU,3), ...
    [BRAPH2.STR ':Assortativity:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Assortativity').get('M');
assert(round(m_inside_g{1}, 3) == round(assortativity_WU,3), ...
    [BRAPH2.STR ':Assortativity:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
GraphBU
%%%% ¡probability!
.01
%%%% ¡code!
B_BU = [
    1 1 0 0 1;
    1 1 1 1 0;
    0 1 1 1 0;
    0 1 1 1 1;
    1 0 0 1 0];
assortativity_BU = (37/6-(15/6)^2)/(39/6-(15/6)^2);

g = GraphBU('B', B_BU);

m_outside_g = Assortativity('G', g).get('M');
assert(isequal(round(m_outside_g{1}, 2), round(assortativity_BU, 2)), ...
    [BRAPH2.STR ':Assortativity:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Assortativity').get('M');
assert(isequal(round(m_inside_g{1}, 2), round(assortativity_BU, 2)), ...
    [BRAPH2.STR ':Assortativity:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultigraphBUD
%%%% ¡probability!
.01
%%%% ¡code!
B_BU = [
    1 1 0 0 1;
    1 1 1 1 0;
    0 1 1 1 0;
    0 1 1 1 1;
    1 0 0 1 0];

densities = [10 90];

known_assortativity = { ...
    0
    round((37/6-(15/6)^2)/(39/6-(15/6)^2), 2)
    };

g = MultigraphBUD('B', B_BU, 'DENSITIES', densities);

m_outside_g = Assortativity('G', g).get('M');
m_outside_g= cellfun(@(x) round(x, 2), m_outside_g, 'UniformOutput', false);
assert(isequal(m_outside_g, known_assortativity), ...
    [BRAPH2.STR ':Assortativity:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Assortativity').get('M');
m_inside_g = cellfun(@(x) round(x, 2), m_inside_g, 'UniformOutput', false);
assert(isequal(m_inside_g, known_assortativity), ...
    [BRAPH2.STR ':Assortativity:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultigraphBUT
%%%% ¡probability!
.01
%%%% ¡code!
B_BU = [
    1 1 0 0 1;
    1 1 1 1 0;
    0 1 1 1 0;
    0 1 1 1 1;
    1 0 0 1 0];

thresholds = [0 1];

known_assortativity = { ...
    round((37/6-(15/6)^2)/(39/6-(15/6)^2), 2)
    0
    };

g = MultigraphBUT('B', B_BU, 'THRESHOLDS', thresholds);

m_outside_g = Assortativity('G', g).get('M');
m_outside_g= cellfun(@(x) round(x, 2), m_outside_g, 'UniformOutput', false);

assert(isequal( m_outside_g, known_assortativity), ...
    [BRAPH2.STR ':Assortativity:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Assortativity').get('M');
m_inside_g = cellfun(@(x) round(x, 2), m_inside_g, 'UniformOutput', false);
assert(isequal(m_inside_g, known_assortativity), ...
    [BRAPH2.STR ':Assortativity:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBU
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
      1  1  0  0  1;
      1  1  1  1  0;
      0  1  1  1  0;
      0  1  1  1  1;
      1  0  0  1  0];
B22 = [
      1  1  0  0  1;
      1  1  1  1  0;
      0  1  1  1  0;
      0  1  1  1  1;
      1  0  0  1  0];
B = {B11 B22};

known_assortativity = {
                    (37/6-(15/6)^2)/(39/6-(15/6)^2)
                    (37/6-(15/6)^2)/(39/6-(15/6)^2)
                    };

g = MultiplexBU('B', B);

assortativity = Assortativity('G', g);
m_outside_g = Assortativity('G', g);
assert(isequal(m_outside_g.get('M'), known_assortativity), ...
    [BRAPH2.STR ':Assortativity:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Assortativity');
assert(isequal(m_inside_g.get('M'), known_assortativity), ...
    [BRAPH2.STR ':Assortativity:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexWU
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
       1  2  0  0  1;
       2  1  3  2  0;
       0  3  1  1  0;
       0  2  1  1  2;
       1  0  0  2  1];
B22 = [
       1  2  0  0  1;
       2  1  3  2  0;
       0  3  1  1  0;
       0  2  1  1  2;
       1  0  0  2  1];
B = {B11 B22};

known_assortativity = {
    round((37/6-(15/6)^2)/(39/6-(15/6)^2), 2)
    round((37/6-(15/6)^2)/(39/6-(15/6)^2), 2)
    };

g = MultiplexWU('B', B);
assortativity = Assortativity('G', g);

m_outside_g = Assortativity('G', g).get('M');
m_outside_g = cellfun(@(x) round(x, 2), m_outside_g, 'UniformOutput', false);
assert(isequal(m_outside_g, known_assortativity), ...
    [BRAPH2.STR ':Assortativity:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Assortativity').get('M');
m_inside_g = cellfun(@(x) round(x, 2), m_inside_g, 'UniformOutput', false);
assert(isequal(m_inside_g, known_assortativity), ...
    [BRAPH2.STR ':Assortativity:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])


%%% ¡test!
%%%% ¡name!
MultiplexBUD
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
      1  1  0  0  1;
      1  1  1  1  0;
      0  1  1  1  0;
      0  1  1  1  1;
      1  0  0  1  0];
B22 = [
      1  1  0  0  1;
      1  1  1  1  0;
      0  1  1  1  0;
      0  1  1  1  1;
      1  0  0  1  0];

B_BU = {B11 B22};

densities = [10 95];

known_assortativity = { ...
    0
    0
    round((37/6-(15/6)^2)/(39/6-(15/6)^2), 2)
    round((37/6-(15/6)^2)/(39/6-(15/6)^2), 2)
    };

g = MultiplexBUD('B', B_BU, 'DENSITIES', densities);

m_outside_g = Assortativity('G', g).get('M');
m_outside_g = cellfun(@(x) round(x, 2), m_outside_g, 'UniformOutput', false);
assert(isequal(m_outside_g, known_assortativity), ...
    [BRAPH2.STR ':Assortativity:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Assortativity').get('M');
m_inside_g = cellfun(@(x) round(x, 2), m_inside_g, 'UniformOutput', false);
assert(isequal(m_inside_g, known_assortativity), ...
    [BRAPH2.STR ':Assortativity:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBUT
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
      1  1  0  0  1;
      1  1  1  1  0;
      0  1  1  1  0;
      0  1  1  1  1;
      1  0  0  1  0];
B22 = [
      1  1  0  0  1;
      1  1  1  1  0;
      0  1  1  1  0;
      0  1  1  1  1;
      1  0  0  1  0];
B = {B11 B22};

known_assortativity = {
    round((37/6-(15/6)^2)/(39/6-(15/6)^2), 2)
    round((37/6-(15/6)^2)/(39/6-(15/6)^2), 2)
    0
    0
    };

g = MultiplexBUT('B', B, 'THRESHOLDS', [0 1]);
m_outside_g = Assortativity('G', g).get('M');
m_outside_g = cellfun(@(x) round(x, 2), m_outside_g, 'UniformOutput', false);
assert(isequal(m_outside_g, known_assortativity), ...
    [BRAPH2.STR ':Assortativity:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Assortativity').get('M');
m_inside_g = cellfun(@(x) round(x, 2), m_inside_g, 'UniformOutput', false);
assert(isequal(m_inside_g, known_assortativity), ...
    [BRAPH2.STR ':Assortativity:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])
