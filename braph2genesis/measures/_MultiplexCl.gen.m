%% ¡header!
MultiplexCl < MultiplexT (m, multiplex clustering) is the graph Multiplex Clustering.

%%% ¡description!
The two-Multiplex Clustering coefficient (MultiplexCl) of a node i is the fraction 
 of two-multiplex triangles (triangles which use edges from two different 
 layers) with a vertex in node i and the number of one-triads centered in i.

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
MultiplexCl.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
MultiplexCl.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
MultiplexCl.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
MultiplexCl.M
%%%% ¡title!
Multiplex Clustering

%%% ¡prop!
%%%% ¡id!
MultiplexCl.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
MultiplexCl.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
MultiplexCl.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Multiplex Clustering.
%%%% ¡default!
'MultiplexCl'

%%% ¡prop!
NAME (constant, string) is the name of the Multiplex Clustering.
%%%% ¡default!
'Multiplex Clustering'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the Multiplex Clustering.
%%%% ¡default!
'The two-Multiplex Clustering coefficient (MultiplexCl) of a node i is the fraction of two-multiplex triangles (triangles which use edges from two different layers) with a vertex in node i and the number of one-triads centered in i.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Multiplex Clustering.
%%%% ¡settings!
'MultiplexCl'

%%% ¡prop!
ID (data, string) is a few-letter code of the Multiplex Clustering.
%%%% ¡default!
'MultiplexCl ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Multiplex Clustering.
%%%% ¡default!
'Multiplex Clustering label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the Multiplex Clustering.
%%%% ¡default!
'Multiplex Clustering notes'

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
{'MultiplexWU' 'MultiplexBU' 'MultiplexBUD' 'MultiplexBUT' 'OrdMxWU'};

%%% ¡prop!
M (result, cell) is the Multiplex Clustering.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
l = g.get('LAYERNUMBER');
ls = g.get('PARTITIONS');

if l == 0
    value = {};
else
    N = g.get('NODENUMBER');
    multiplex_triangles = calculateValue@MultiplexT(m, prop);
    degree = Degree('G', g).get('M');

    multiplex_clustering = cell(length(ls), 1);
    count = 1;
    for p = 1:1:length(ls)
        multiplex_clustering_degree = zeros(N(1), 1);
        for i = count:1:ls(p) + count - 1
            k = degree{i};
            multiplex_clustering_degree = multiplex_clustering_degree + (k .* (k - 1));
        end
        multiplex_clustering_partition = multiplex_triangles{p}./ ((ls(p)-1)*multiplex_clustering_degree);
        multiplex_clustering_partition(isnan(multiplex_clustering_partition)) = 0;  % Should return zeros, not NaN
        count = count + ls(p);
        multiplex_clustering(p) = {multiplex_clustering_partition};
    end
    value = multiplex_clustering;
end

%% ¡tests!

%%% ¡excluded_props!
[MultiplexCl.PFM]

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

known_multiplex_clustering = diag(B11.^(1/3)*B22.^(1/3)*B11.^(1/3) + B22.^(1/3)*B11.^(1/3)*B22.^(1/3)) ./ ([12, 2, 2, 0]');
known_multiplex_clustering(isnan(known_multiplex_clustering)) = 0;
known_multiplex_clustering = {
    known_multiplex_clustering
    };

g = MultiplexWU('B', B);
m_outside_g = MultiplexCl('G', g);

assert(isequal(m_outside_g.get('M'), known_multiplex_clustering), ...
    [BRAPH2.STR ':MultiplexCl:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'MultiplexCl');
assert(isequal(m_inside_g.get('M'), known_multiplex_clustering), ...
    [BRAPH2.STR ':MultiplexCl:' BRAPH2.FAIL_TEST], ...
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

known_multiplex_clustering = [5 1 1 5]'./ [12, 2, 2, 6]';
known_multiplex_clustering(isnan(known_multiplex_clustering)) = 0;
known_multiplex_clustering = {
                 known_multiplex_clustering
                 };   

g = MultiplexBU('B', B);
m_outside_g = MultiplexCl('G', g);

assert(isequal(m_outside_g.get('M'), known_multiplex_clustering), ...
    [BRAPH2.STR ':MultiplexCl:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'MultiplexCl');
assert(isequal(m_inside_g.get('M'), known_multiplex_clustering), ...
    [BRAPH2.STR ':MultiplexCl:' BRAPH2.FAIL_TEST], ...
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

known_multiplex_clustering = [5 1 1 5]'./ [12, 2, 2, 6]';
known_multiplex_clustering(isnan(known_multiplex_clustering)) = 0;
known_multiplex_clustering = {                 
                 [0 0 0 0]'
                 known_multiplex_clustering
                 };         

g = MultiplexBUD('B', B, 'DENSITIES', [10 90]);
m_outside_g = MultiplexCl('G', g);

assert(isequal(m_outside_g.get('M'), known_multiplex_clustering), ...
    [BRAPH2.STR ':MultiplexCl:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'MultiplexCl');
assert(isequal(m_inside_g.get('M'), known_multiplex_clustering), ...
    [BRAPH2.STR ':MultiplexCl:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
OrdMxWU
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

known_multiplex_clustering = diag(B11.^(1/3)*B22.^(1/3)*B11.^(1/3) + B22.^(1/3)*B11.^(1/3)*B22.^(1/3)) ./ ([12, 2, 2, 0]');
known_multiplex_clustering(isnan(known_multiplex_clustering)) = 0;
known_multiplex_clustering = {
    known_multiplex_clustering
    };

g = OrdMxWU('B', B);
m_outside_g = MultiplexCl('G', g);

assert(isequal(m_outside_g.get('M'), known_multiplex_clustering), ...
    [BRAPH2.STR ':MultiplexCl:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'MultiplexCl');
assert(isequal(m_inside_g.get('M'), known_multiplex_clustering), ...
    [BRAPH2.STR ':MultiplexCl:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])