%% ¡header!
MultiplexClAv < MultiplexCl (m, average multiplex clustering) is the graph Average Multiplex Clustering.

%%% ¡description!
The Average Multiplex Clustering coefficient (MultiplexClAv) of a multilayer graph is 
  the average of the two-multiplex clustering coefficients of all nodes. 

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
MultiplexClAv.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
MultiplexClAv.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
MultiplexClAv.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
MultiplexClAv.M
%%%% ¡title!
Average Multiplex Clustering

%%% ¡prop!
%%%% ¡id!
MultiplexClAv.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
MultiplexClAv.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
MultiplexClAv.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Average Multiplex Clustering.
%%%% ¡default!
'MultiplexClAv'

%%% ¡prop!
NAME (constant, string) is the name of the Average Multiplex Clustering.
%%%% ¡default!
'Average Multiplex Clustering'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the Average Multiplex Clustering.
%%%% ¡default!
'The Average Multiplex Clustering coefficient (MultiplexClAv) of a multilayer graph is the average of the two-multiplex clustering coefficients of all nodes.'
%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Average Multiplex Clustering.
%%%% ¡settings!
'MultiplexClAv'

%%% ¡prop!
ID (data, string) is a few-letter code of the Average Multiplex Clustering.
%%%% ¡default!
'MultiplexClAv ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Average Multiplex Clustering.
%%%% ¡default!
'Average Multiplex Clustering label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the Average Multiplex Clustering.
%%%% ¡default!
'Average Multiplex Clustering notes'

%%% ¡prop!
SHAPE (constant, scalar) is the measure shape __Measure.NODAL__.
%%%% ¡default!
Measure.GLOBAL

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
M (result, cell) is the Average Multiplex Clustering.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
l = g.get('LAYERNUMBER');
ls = g.get('PARTITIONS');

if l == 0
    value = {};
else
    multiplex_clustering = calculateValue@MultiplexCl(m, prop);
    multiplex_clustering_av = cell(length(ls), 1);

    for i=1:length(ls)
        multiplex_clustering_av(i) = {mean(multiplex_clustering{i})};
    end
    value = multiplex_clustering_av;
end

%% ¡tests!

%%% ¡excluded_props!
[MultiplexClAv.PFM]

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
    mean(known_multiplex_clustering)
    };

g = MultiplexWU('B', B);
m_outside_g = MultiplexClAv('G', g);

assert(isequal(m_outside_g.get('M'), known_multiplex_clustering), ...
    [BRAPH2.STR ':MultiplexClAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'MultiplexClAv');
assert(isequal(m_inside_g.get('M'), known_multiplex_clustering), ...
    [BRAPH2.STR ':MultiplexClAv:' BRAPH2.FAIL_TEST], ...
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
                 mean(known_multiplex_clustering)
                 };   

g = MultiplexBU('B', B);
m_outside_g = MultiplexClAv('G', g);

assert(isequal(m_outside_g.get('M'), known_multiplex_clustering), ...
    [BRAPH2.STR ':MultiplexClAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'MultiplexClAv');
assert(isequal(m_inside_g.get('M'), known_multiplex_clustering), ...
    [BRAPH2.STR ':MultiplexClAv:' BRAPH2.FAIL_TEST], ...
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

known_multiplex_clustering = [5 1 1 5]'./ [12, 2, 2, 6]';
known_multiplex_clustering(isnan(known_multiplex_clustering)) = 0;
known_multiplex_clustering = {
                 mean(known_multiplex_clustering)
                 0
                 };    
g = MultiplexBUT('B', B, 'THRESHOLDS', [0 1]);
m_outside_g = MultiplexClAv('G', g);

assert(isequal(m_outside_g.get('M'), known_multiplex_clustering), ...
    [BRAPH2.STR ':MultiplexClAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'MultiplexClAv');
assert(isequal(m_inside_g.get('M'), known_multiplex_clustering), ...
    [BRAPH2.STR ':MultiplexClAv:' BRAPH2.FAIL_TEST], ...
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
known_multiplex_clustering_Av = {
    mean(known_multiplex_clustering)
    };

g = OrdMxWU('B', B);
m_outside_g = MultiplexClAv('G', g);

assert(isequal(m_outside_g.get('M'), known_multiplex_clustering_Av), ...
    [BRAPH2.STR ':MultiplexClAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'MultiplexClAv');
assert(isequal(m_inside_g.get('M'), known_multiplex_clustering_Av), ...
    [BRAPH2.STR ':MultiplexClAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])