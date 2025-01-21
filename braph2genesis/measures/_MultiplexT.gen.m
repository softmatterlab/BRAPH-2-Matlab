%% ¡header!
MultiplexT < Measure (m, multiplex triangles) is the graph Multiplex Triangles.

%%% ¡description!
The Multiplex Triangles (MultiplexT) are calculated as the number of neighbors of a node 
 that are also neighbors of each other between each pair of layers. 
In weighted graphs, the multiplex triangles are calculated as geometric mean 
 of the weights of the edges forming the multiplex triangle.

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
MultiplexT.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
MultiplexT.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
MultiplexT.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
MultiplexT.M
%%%% ¡title!
Multiplex Triangles

%%% ¡prop!
%%%% ¡id!
MultiplexT.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
MultiplexT.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
MultiplexT.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Multiplex Triangles.
%%%% ¡default!
'MultiplexT'

%%% ¡prop!
NAME (constant, string) is the name of the Multiplex Triangles.
%%%% ¡default!
'Multiplex Triangles'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the Multiplex Triangles.
%%%% ¡default!
'The Multiplex Triangles (MultiplexT) are calculated as the number of neighbors of a node that are also neighbors of each other between each pair of layers. In weighted graphs, the multiplex triangles are calculated as geometric mean of the weights of the edges forming the multiplex triangle.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Multiplex Triangles.
%%%% ¡settings!
'MultiplexT'

%%% ¡prop!
ID (data, string) is a few-letter code of the Multiplex Triangles.
%%%% ¡default!
'MultiplexT ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Multiplex Triangles.
%%%% ¡default!
'Multiplex Triangles label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the Multiplex Triangles.
%%%% ¡default!
'Multiplex Triangles notes'

%%% ¡prop!
SHAPE (constant, scalar) is the measure shape __Measure.NODAL__.
%%%% ¡default!
Measure.NODAL

%%% ¡prop!
SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.
%%%% ¡default!
Measure.SUPERGLOBAL

%%% ¡prop!
PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.
%%%% ¡default!
Measure.NONPARAMETRIC

%%% ¡prop!
COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
%%%% ¡default!
{'MultiplexWU' 'MultiplexBU' 'MultiplexBUD' 'MultiplexBUT' 'OrdMxWU' 'OrdMxBU' 'OrdMxBUD' 'OrdMxBUT'};

%%% ¡prop!
M (result, cell) is the Multiplex Triangles.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
l = g.get('LAYERNUMBER');
ls = g.get('PARTITIONS');
N = g.get('NODENUMBER');

if l == 0
    value = {};
else
    multiplex_triangles = cell(length(ls), 1);
    count = 1;
    for p = 1:1:length(ls) % for each density
        multiplex_triangles_partition = zeros(N(1), 1);
         % loop thorugh pairs of layers
        for i = count:1:ls(p) + count - 2
            B11 = A{i, i};
            for j = i+1:1:ls(p) + count - 1
                B22 = A{j, j};
                multiplex_triangles_partition = multiplex_triangles_partition + diag(B11.^(1/3)*B22.^(1/3)*B11.^(1/3) + B22.^(1/3)*B11.^(1/3)*B22.^(1/3));
            end
        end
        count = count + ls(p);
        multiplex_triangles(p) = {multiplex_triangles_partition};
    end
    value = multiplex_triangles;
end

%% ¡tests!

%%% ¡excluded_props!
[MultiplexT.PFM]

%%% ¡test!
%%%% ¡name!
MultiplexWU
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
      0   .2  1   1;
      .2  0   1  0;
      1   1  0   0;
      1   0   0   0
      ];
B22 = [
      0   .2  1  .7;
      .2  0   0  0;
      1   0   0  0;
      .7  0   0  0
      ];
B = {B11 B22};

known_multiplex_triangles = {
    diag(B11.^(1/3)*B22.^(1/3)*B11.^(1/3) + B22.^(1/3)*B11.^(1/3)*B22.^(1/3))
    };

g = MultiplexWU('B', B);
m_outside_g = MultiplexT('G', g);

assert(isequal(m_outside_g.get('M'), known_multiplex_triangles), ...
    [BRAPH2.STR ':MultiplexT:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'MultiplexT');
assert(isequal(m_inside_g.get('M'), known_multiplex_triangles), ...
    [BRAPH2.STR ':MultiplexT:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBU
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
      0 1 1 1;
      1 0 1 0;
      1 1 0 0;
      1 0 0 0
      ];
B22 = [
      0 1 1 1;
      1 0 0 0;
      1 0 0 0;
      1 0 0 0
      ];  
B33 = [
      0 0 0 1;
      0 0 0 1;
      0 0 0 1;
      1 1 1 0
      ]; 
B = {B11 B22 B33};

known_multiplex_triangles = {
    [10 2 2 10]'
    };


g = MultiplexBU('B', B);
m_outside_g = MultiplexT('G', g);

assert(isequal(m_outside_g.get('M'), known_multiplex_triangles), ...
    [BRAPH2.STR ':MultiplexT:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'MultiplexT');
assert(isequal(m_inside_g.get('M'), known_multiplex_triangles), ...
    [BRAPH2.STR ':MultiplexT:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBUT
%%%% ¡code!
B11 = [
      0 1 1 1;
      1 0 1 0;
      1 1 0 0;
      1 0 0 0
      ];
B22 = [
      0 1 1 1;
      1 0 0 0;
      1 0 0 0;
      1 0 0 0
      ];  
B33 = [
      0 0 0 1;
      0 0 0 1;
      0 0 0 1;
      1 1 1 0
      ]; 
B = {B11 B22 B33};

known_multiplex_triangles = {
                 [10 2 2 10]'
                 [0 0 0 0]'
                 };      

g = MultiplexBUT('B', B, 'THRESHOLDS', [0 1]);
m_outside_g = MultiplexT('G', g);

assert(isequal(m_outside_g.get('M'), known_multiplex_triangles), ...
    [BRAPH2.STR ':MultiplexT:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'MultiplexT');
assert(isequal(m_inside_g.get('M'), known_multiplex_triangles), ...
    [BRAPH2.STR ':MultiplexT:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBUD
%%%% ¡code!
B11 = [
      0 1 1 1;
      1 0 1 0;
      1 1 0 0;
      1 0 0 0
      ];
B22 = [
      0 1 1 1;
      1 0 0 0;
      1 0 0 0;
      1 0 0 0
      ];  
B33 = [
      0 0 0 1;
      0 0 0 1;
      0 0 0 1;
      1 1 1 0
      ]; 
B = {B11 B22 B33};

known_multiplex_triangles = {                 
                 [0 0 0 0]'
                 [10 2 2 10]'
                 };      

g = MultiplexBUD('B', B, 'DENSITIES', [10 90]);
m_outside_g = MultiplexT('G', g);

assert(isequal(m_outside_g.get('M'), known_multiplex_triangles), ...
    [BRAPH2.STR ':MultiplexT:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'MultiplexT');
assert(isequal(m_inside_g.get('M'), known_multiplex_triangles), ...
    [BRAPH2.STR ':MultiplexT:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

