%% ¡header!
AssortInOut < Measure (m, in-out-assortativity) is the graph In-Out-Assortativity.

%%% ¡description!
The In-Out-Assortativity coefficient (AssortInOut) of a graph is the correlation coefficient between 
  the inward and outward degrees/strengths of all nodes on two opposite ends of an edge within a layer. 
The corresponding coefficient for directed and weighted networks is calculated by 
  using the weighted and directed variants of out-degree/out-strength.

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
AssortInOut.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
AssortInOut.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
AssortInOut.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
AssortInOut.M
%%%% ¡title!
In-Out-Assortativity

%%% ¡prop!
%%%% ¡id!
AssortInOut.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
AssortInOut.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
AssortInOut.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the In-Out-Assortativity.
%%%% ¡default!
'AssortInOut'

%%% ¡prop!
NAME (constant, string) is the name of the In-Out-Assortativity.
%%%% ¡default!
'In-Out-Assortativity'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the In-Out-Assortativity.
%%%% ¡default!
'The In-Out-Assortativity coefficient (AssortInOut) of a graph is the correlation coefficient between the inward and outward degrees/strengths of all nodes on two opposite ends of an edge within a layer. The corresponding coefficient for directed and weighted networks is calculated by using the weighted and directed variants of out-degree/out-strength.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the In-Out-Assortativity.
%%%% ¡settings!
'AssortInOut'

%%% ¡prop!
ID (data, string) is a few-letter code of the In-Out-Assortativity.
%%%% ¡default!
'AssortInOut ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the In-Out-Assortativity.
%%%% ¡default!
'In-Out-Assortativity label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the In-Out-Assortativity.
%%%% ¡default!
'In-Out-Assortativity notes'

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
{'GraphBD' 'GraphWD' 'MultiplexWD' 'MultiplexBD' 'MultilayerWD' 'OrdMlWD'};

%%% ¡prop!
M (result, cell) is the In-Out-Assortativity.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
L = g.get('LAYERNUMBER');
N = g.get('NODENUMBER');
in_in_assortativity = cell(L, 1);
connectivity_types = g.get('CONNECTIVITY_TYPE', L);  
parfor li = 1:L
    Aii = A{li, li};
    connectivity_type = connectivity_types(li, li);
    [i, j] = find(Aii ~= 0);  % nodes [i, j]
    M = length(i);  % Number of edges
    k_i = zeros(M, L);
    k_j = zeros(length(j), L);
    
    if connectivity_type == Graph.WEIGHTED  % weighted graphs
        in_strength = StrengthIn('G', g).get('M');
        out_strength = StrengthOut('G', g).get('M');
        d_in = in_strength{li};
        d_out = out_strength{li};
    else  % binary graphs
        in_degree = DegreeIn('G', g).get('M');
        out_degree = DegreeOut('G', g).get('M');
        d_in = in_degree{li};
        d_out = out_degree{li};
    end
    
    k_i(:, li) = d_in(i);  % in-degree/in-strength node i
    k_j(:, li) = d_out(j);  % out-degree/out-strength node j
    % compute assortativity
    assortativity_layer = (sum(k_i(:, li) .* k_j(:, li)) / M - (sum(0.5 * (k_i(:, li) + k_j(:, li))) / M)^2)...
        / (sum(0.5 * (k_i(:, li).^2 + k_j(:, li).^2)) / M - (sum(0.5 * (k_i(:, li) + k_j(:, li))) / M)^2);
    assortativity_layer(isnan(assortativity_layer)) = 0;  % Should return zeros, not NaN
    in_in_assortativity(li) = {assortativity_layer};
end

value = in_in_assortativity;

%% ¡tests!

%%% ¡excluded_props!
[AssortInOut.PFM]

%%% ¡test!
%%%% ¡name!
GraphBD
%%%% ¡probability!
.01
%%%% ¡code!
A = [
    0  1  0  0  0;
    0  0  1  0  0;
    0  0  0  1  0;
    0  1  0  0  1;
    1  0  0  1  0
    ];

known_in_out_assortativity = {(2-100/49)/(16/7-100/49)};
g = GraphBD('B', A);
in_in_assortativity = AssortInOut('G', g).get('M');

m_outside_g = AssortInOut('G', g);
assert(isequal(m_outside_g.get('M'), known_in_out_assortativity), ...
    [BRAPH2.STR ':AssortInOut:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'AssortInOut');
assert(isequal(m_inside_g.get('M'), known_in_out_assortativity), ...
    [BRAPH2.STR ':AssortInOut:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
GraphWD
%%%% ¡code!
A = [
    0  2  0  0  0;
    0  0  3  0  0;
    0  0  0  1  0;
    0  2  0  0  2;
    1  0  0  2  0
    ];

known_in_out_assortativity = {(2-100/49)/(16/7-100/49)};

g = GraphWD('B', A);
m_outside_g = AssortInOut('G', g);
assert(isequal(m_outside_g.get('M'), known_in_out_assortativity), ...
    [BRAPH2.STR ':Degree:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'AssortInOut');
assert(isequal(m_inside_g.get('M'), known_in_out_assortativity), ...
    [BRAPH2.STR ':AssortInOut:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBD
%%%% ¡code!
A11 = [
      0  1  0  0  0;
      0  0  1  0  0;
      0  0  0  1  0;
      0  1  0  0  1;
      1  0  0  1  0
    ];

A22 = [
      0  1  0  0  0;
      0  0  1  0  0;
      0  0  0  1  0;
      0  1  0  0  1;
      1  0  0  1  0
    ];
A = {A11 A22};
             
known_in_out_assortativity = {
    (2-100/49)/(16/7-100/49)
    (2-100/49)/(16/7-100/49)
    };

g = MultiplexBD('B', A);

m_outside_g = AssortInOut('G', g);
assert(isequal(m_outside_g.get('M'), known_in_out_assortativity), ...
    [BRAPH2.STR ':AssortInOut:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'AssortInOut');
assert(isequal(m_inside_g.get('M'), known_in_out_assortativity), ...
    [BRAPH2.STR ':AssortInOut:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexWD
%%%% ¡code!
A11 = [
       0  2  0  0  0;
       0  0  3  0  0;
       0  0  0  1  0;
       0  2  0  0  2;
       1  0  0  2  0
    ];
A22 = [
       0  2  0  0  0;
       0  0  3  0  0;
       0  0  0  1  0;
       0  2  0  0  2;
       1  0  0  2  0
    ];
A = {A11 A22};

known_in_out_assortativity = {
                    (2-100/49)/(16/7-100/49)
                    (2-100/49)/(16/7-100/49)
                    };    

g = MultiplexWD('B', A);

m_outside_g = AssortInOut('G', g);
assert(isequal(m_outside_g.get('M'), known_in_out_assortativity), ...
    [BRAPH2.STR ':AssortInOut:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'AssortInOut');
assert(isequal(m_inside_g.get('M'), known_in_out_assortativity), ...
    [BRAPH2.STR ':AssortInOut:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
OrdMlWD
%%%% ¡code!
B11 = [
       0  2  0  0  0;
       0  0  3  0  0;
       0  0  0  1  0;
       0  2  0  0  2;
       1  0  0  2  0
    ];
B22 = [
       0  2  0  0  0;
       0  0  3  0  0;
       0  0  0  1  0;
       0  2  0  0  2;
       1  0  0  2  0
    ];
B12 = rand(size(B11,1),size(B22,2));
B21 = B12';


B= {B11 B12;
    B21 B22;};

known_in_out_assortativity = {
                    (2-100/49)/(16/7-100/49)
                    (2-100/49)/(16/7-100/49)
                    };    

g = OrdMlWD('B', B);

m_outside_g = AssortInOut('G', g);
assert(isequal(m_outside_g.get('M'), known_in_out_assortativity), ...
    [BRAPH2.STR ':AssortInOut:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'AssortInOut');
assert(isequal(m_inside_g.get('M'), known_in_out_assortativity), ...
    [BRAPH2.STR ':AssortInOut:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])