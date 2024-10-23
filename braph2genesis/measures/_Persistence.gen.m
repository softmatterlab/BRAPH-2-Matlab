%% ¡header!
Persistence < MultilayerCommunity  (m, persistence) is the graph Persistence.

%%% ¡description!
The Persistence (Persistence) of a multilayer network is calculated as the normalized 
sum of the number of nodes that do not change community assignments. It 
varies between 0 and 1. 
In categorical multilayer networks, it is the sum over all pairs of layers 
of the number of nodes that do not change community assignments, whereas 
in ordinal multilayer networks (e.g. temporal), it is the number of nodes 
that do not change community assignments between consecutive layers.

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
Persistence.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
Persistence.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
Persistence.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
Persistence.M
%%%% ¡title!
Persistence

%%% ¡prop!
%%%% ¡id!
Persistence.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
Persistence.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
Persistence.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs
  
%% ¡layout!

%%% ¡prop!
%%%% ¡id!
Persistence.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
Persistence.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
Persistence.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
Persistence.M
%%%% ¡title!
Persistence

%%% ¡prop!
%%%% ¡id!
Persistence.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
Persistence.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
Persistence.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Persistence.
%%%% ¡default!
'Persistence'

%%% ¡prop!
NAME (constant, string) is the name of the Persistence.
%%%% ¡default!
'Persistence'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the Persistence.
%%%% ¡default!
'The Persistence (Persistence) of a multilayer network is calculated as the normalized sum of the number of nodes that do not change community assignments. It varies between 0 and 1. In categorical multilayer networks, it is the sum over all pairs of layers of the number of nodes that do not change community assignments, whereas in ordinal multilayer networks (e.g. temporal), it is the number of nodes that do not change community assignments between consecutive layers.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Persistence.
%%%% ¡settings!
'Persistence'

%%% ¡prop!
ID (data, string) is a few-letter code of the Persistence.
%%%% ¡default!
'Persistence ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Persistence.
%%%% ¡default!
'Persistence label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the Persistence.
%%%% ¡default!
'Persistence notes'

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
{'MultiplexWU' 'MultiplexWD' 'OrdMxWU' 'MultiplexBU' 'MultiplexBD' 'MultiplexBUT' 'MultiplexBUD' 'MultilayerBU' 'MultilayerWU' 'OrdMlWU'};

%%% ¡prop!
M (result, cell) is the categorical Persistence.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
L = g.get('LAYERNUMBER');
N = g.get('NODENUMBER');
graph_type = g.get('GRAPH_TYPE');
if isempty(N)
    N(1) = 1;
end
N = N(1);
%S = MultilayerCommunity('G', g).get('M');
S = calculateValue@MultilayerCommunity(m, prop);
S = cell2mat(S');
S = {S};
persistence = zeros(length(S), 1); 

if graph_type == Graph.MULTIPLEX || graph_type == Graph.MULTILAYER
    % categorical  
    all2all = N*[(-L+1):-1,1:(L-1)];
    A = spdiags(ones(N*L, 2*L-2), all2all, N*L, N*L);
    for i = 1:length(S)
        G = sparse(1:length(S{i}(:)), S{i}(:), 1);
        persistence(i) = trace(G'*A*G)/(N*L*(L-1));
    end
  
elseif graph_type== Graph.ORDERED_MULTIPLEX|| graph_type== Graph.ORDERED_MULTILAYER
    % ordinal
    for i = 1:length(S)
        persistence(i) = sum(sum(S{i}(:,1:end-1)==S{i}(:,2:end)))/(N*(L-1));
    end 
end
value = {persistence};

%% ¡tests!

%%% ¡excluded_props!
[Persistence.PFM]

%%% ¡test!
%%%% ¡name!
MultiplexBU
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
      0 1 1 1;
      1 0 1 0;
      1 1 0 1;
      1 0 1 0
      ];

B22 = [
      0 1 1 1;
      1 0 1 0;
      1 1 0 1;
      1 0 1 0
      ];
B = {B11 B22};

known_persistence = {1};   

g = MultiplexBU('B', B);

m_outside_g = Persistence('G', g);
assert(isequal(m_outside_g.get('M'), known_persistence), ...
    [BRAPH2.STR ':Persistence:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Persistence');
assert(isequal(m_inside_g.get('M'), known_persistence), ...
    [BRAPH2.STR ':Persistence:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
OrdMlWU
%%%% ¡code!
A11 = [
      0  1 1 .5;
      1  0 1 0;
      1  1 0 1;
      .1 0 1 0
      ];
A22 = [
      0  1 1 .5;
      1  0 1 0;
      1  1 0 1;
      .1 0 1 0
      ];
A12 = rand(size(A11,1),size(A22,2));
A21 = A12';
A = {A11 A12;
     A21 A22};
 
known_persistence = {1};  

g = OrdMlWU('B', A);

m_outside_g = Persistence('G', g);
assert(isequal(m_outside_g.get('M'), known_persistence), ...
    [BRAPH2.STR ':Persistence:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Persistence');
assert(isequal(m_inside_g.get('M'), known_persistence), ...
    [BRAPH2.STR ':Persistence:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])