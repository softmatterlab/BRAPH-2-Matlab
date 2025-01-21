%% ¡header!
AssortOutOut < Measure (m, out-out-assortativity) is the graph Out-Out-Assortativity.

%%% ¡description!
The Out-Out-Assortativity coefficient (AssortOutOut) of a graph is the correlation coefficient between 
  the outward degrees/strengths of all nodes on two opposite ends of an edge within a layer. 
The corresponding coefficient for directed and weighted networks is calculated by using 
  the weighted and directed variants of out-degree/out-strength.

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
AssortOutOut.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
AssortOutOut.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
AssortOutOut.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
AssortOutOut.M
%%%% ¡title!
Out-Out-Assortativity

%%% ¡prop!
%%%% ¡id!
AssortOutOut.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
AssortOutOut.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
AssortOutOut.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Out-Out-Assortativity.
%%%% ¡default!
'AssortOutOut'

%%% ¡prop!
NAME (constant, string) is the name of the Out-Out-Assortativity.
%%%% ¡default!
'Out-Out-Assortativity'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the Out-Out-Assortativity.
%%%% ¡default!
'The Out-Out-Assortativity coefficient (AssortOutOut) of a graph is the correlation coefficient between the outward degrees/strengths of all nodes on two opposite ends of an edge within a layer. The corresponding coefficient for directed and weighted networks is calculated by using the weighted and directed variants of out-degree/out-strength.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Out-Out-Assortativity.
%%%% ¡settings!
'AssortOutOut'

%%% ¡prop!
ID (data, string) is a few-letter code of the Out-Out-Assortativity.
%%%% ¡default!
'AssortOutOut ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Out-Out-Assortativity.
%%%% ¡default!
'Out-Out-Assortativity label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the Out-Out-Assortativity.
%%%% ¡default!
'Out-Out-Assortativity notes'

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
{'GraphBD' 'GraphWD' 'MultiplexWD' 'MultiplexBD'};

%%% ¡prop!
M (result, cell) is the Out-Out-Assortativity.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
L = g.get('LAYERNUMBER');
N = g.get('NODENUMBER');
out_out_assortativity = cell(L, 1);
connectivity_types = g.get('CONNECTIVITY_TYPE', L);  

warning('off', 'MATLAB:remoteparfor:ParforWorkerAborted')
parfor li = 1:L
    Aii = A{li, li};
    connectivity_type = connectivity_types(li, li);
    [i, j] = find(Aii ~= 0);  % nodes [i, j]
    M = length(i);  % Number of edges
    k_i = zeros(M, L);
    k_j = zeros(length(j), L);
    
    if connectivity_type == Graph.WEIGHTED  % weighted graphs
        out_strength = StrengthOut('G', g).get('M');
        d = out_strength{li};
    else  % binary graphs
        out_degree = DegreeOut('G', g).get('M');
        d= out_degree{li};
    end
    
    k_i(:, li) = d(i);  % in-degree/in-strength node i
    k_j(:, li) = d(j);  % in-degree/in-strength node j
    % compute assortativity
    assortativity_layer = (sum(k_i(:, li) .* k_j(:, li)) / M - (sum(0.5 * (k_i(:, li) + k_j(:, li))) / M)^2)...
        / (sum(0.5 * (k_i(:, li).^2 + k_j(:, li).^2)) / M - (sum(0.5 * (k_i(:, li) + k_j(:, li))) / M)^2);
    assortativity_layer(isnan(assortativity_layer)) = 0;  % Should return zeros, not NaN    
    out_out_assortativity(li) = {assortativity_layer};
end
warning('on', 'MATLAB:remoteparfor:ParforWorkerAborted')

value = out_out_assortativity;

%% ¡tests!

%%% ¡excluded_props!
[AssortOutOut.PFM]

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
known_out_out_assortativity = {(16/7-(21/14)^2)/(35/14-(21/14)^2)};

g = GraphBD('B', A);
out_out_assortativity = AssortOutOut('G', g).get('M');

m_outside_g = AssortOutOut('G', g);
assert(isequal(m_outside_g.get('M'), known_out_out_assortativity), ...
    [BRAPH2.STR ':AssortOutOut:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'AssortOutOut');
assert(isequal(m_inside_g.get('M'), known_out_out_assortativity), ...
    [BRAPH2.STR ':AssortOutOut:' BRAPH2.FAIL_TEST], ...
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

known_out_out_assortativity = {(16/7-(21/14)^2)/(35/14-(21/14)^2)};

g = GraphWD('B', A);
m_outside_g = AssortOutOut('G', g);
assert(isequal(m_outside_g.get('M'), known_out_out_assortativity), ...
    [BRAPH2.STR ':Degree:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'AssortOutOut');
assert(isequal(m_inside_g.get('M'), known_out_out_assortativity), ...
    [BRAPH2.STR ':AssortOutOut:' BRAPH2.FAIL_TEST], ...
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
             
known_out_out_assortativity = {
                    (16/7-(21/14)^2)/(35/14-(21/14)^2)
                    (16/7-(21/14)^2)/(35/14-(21/14)^2)
                    };
   
g = MultiplexBD('B', A);

m_outside_g = AssortOutOut('G', g);
assert(isequal(m_outside_g.get('M'), known_out_out_assortativity), ...
    [BRAPH2.STR ':AssortOutOut:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'AssortOutOut');
assert(isequal(m_inside_g.get('M'), known_out_out_assortativity), ...
    [BRAPH2.STR ':AssortOutOut:' BRAPH2.FAIL_TEST], ...
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

known_out_out_assortativity = {
                    (16/7-(21/14)^2)/(35/14-(21/14)^2)
                    (16/7-(21/14)^2)/(35/14-(21/14)^2)
                    };  

g = MultiplexWD('B', A);

m_outside_g = AssortOutOut('G', g);
assert(isequal(m_outside_g.get('M'), known_out_out_assortativity), ...
    [BRAPH2.STR ':AssortOutOut:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'AssortOutOut');
assert(isequal(m_inside_g.get('M'), known_out_out_assortativity), ...
    [BRAPH2.STR ':AssortOutOut:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])