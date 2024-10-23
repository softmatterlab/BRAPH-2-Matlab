%% ¡header!
Flexibility < MultilayerCommunity (m, flexibility) is the graph Flexibility.

%%% ¡description!
The Flexibility (Flexibility) of each node in a multilayer network is calculated 
as the number of times that it changes community assignment, 
normalized by the total possible number of changes. In ordered 
multilayer networks (e.g. temporal, changes are possible only between 
adjacent layers, whereas in categorical multilayer networks, 
community assignment changes are possible between any pairs of layers.

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
Flexibility.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
Flexibility.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
Flexibility.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
Flexibility.M
%%%% ¡title!
Flexibility

%%% ¡prop!
%%%% ¡id!
Flexibility.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
Flexibility.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
Flexibility.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Flexibility.
%%%% ¡default!
'Flexibility'

%%% ¡prop!
NAME (constant, string) is the name of the Flexibility.
%%%% ¡default!
'Flexibility'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the Flexibility.
%%%% ¡default!
'The Flexibility (Flexibility) of each node in a multilayer network is calculated as the number of times that it changes community assignment, normalized by the total possible number of changes. In ordered multilayer networks (e.g. temporal, changes are possible only between adjacent layers, whereas in categorical multilayer networks, community assignment changes are possible between any pairs of layers.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Flexibility.
%%%% ¡settings!
'Flexibility'

%%% ¡prop!
ID (data, string) is a few-letter code of the Flexibility.
%%%% ¡default!
'Flexibility ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Flexibility.
%%%% ¡default!
'Flexibility label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the Flexibility.
%%%% ¡default!
'Flexibility notes'

%%% ¡prop!
SHAPE (constant, scalar) is the measure shape __Measure.NODAL__.
%%%% ¡default!
Measure.NODAL

%%% ¡prop!
SCOPE (constant, scalar) is the measure scope __Measure.SUPERGLOBAL__.
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
M (result, cell) is the Flexibility.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
L = g.get('LAYERNUMBER');
N = g.get('NODENUMBER');
if isempty(N)
    N(1) = 1;
end
N = N(1);
S = calculateValue@MultilayerCommunity(m, prop);
S = cell2mat(S');
flexibility = zeros(N, 1);

if g.get('GRAPH_TYPE') == 4 || g.get('GRAPH_TYPE') ==6
    % categorical 
    for i=1:L
        otherlayers = 1:L;
        otherlayers = otherlayers(otherlayers~=i); % all layers except the current one
        flexibility = flexibility + sum(repmat(S(:,i),1, (L-1)) ~= S(:,otherlayers), 2);
    end    
    flexibility = flexibility/(L*(L-1));
elseif g.get('GRAPH_TYPE') == 3 || g.get('GRAPH_TYPE') ==5
    % ordinal 
    for i=1:L-1
        flexibility = flexibility + S(:, i) ~= S(:, i+1);
    end
    flexibility = flexibility/(L-1);
end

value = {flexibility};

%% ¡tests!

%%% ¡excluded_props!
[Flexibility.PFM]

%%% ¡test!
%%%% ¡name!
MultiplexBU
%%%% ¡probability!
.01
%%%% ¡code!
A11 = [
      0 1 1 1;
      1 0 1 0;
      1 1 0 1;
      1 0 1 0
      ];

A22 = [
      0 1 1 1;
      1 0 1 0;
      1 1 0 1;
      1 0 1 0
      ];
B = {A11 A22};
 
known_flexibility = {[0 0 0 0]'}; 

g = MultiplexBU('B', B);

m_outside_g = Flexibility('G', g);
assert(isequal(m_outside_g.get('M'), known_flexibility), ...
    [BRAPH2.STR ':Flexibility:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Flexibility');
assert(isequal(m_inside_g.get('M'), known_flexibility), ...
    [BRAPH2.STR ':Flexibility:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultilayerWU
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
 
known_flexibility = {[0 0 0 0]'};  

g = MultilayerWU('B', A);

m_outside_g = Flexibility('G', g);
assert(isequal(m_outside_g.get('M'), known_flexibility), ...
    [BRAPH2.STR ':Flexibility:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Flexibility');
assert(isequal(m_inside_g.get('M'), known_flexibility), ...
    [BRAPH2.STR ':Flexibility:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

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
 
known_flexibility = {[0 0 0 0]'};  

g = OrdMlWU('B', A);

m_outside_g = Flexibility('G', g);
assert(isequal(m_outside_g.get('M'), known_flexibility), ...
    [BRAPH2.STR ':Flexibility:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Flexibility');
assert(isequal(m_inside_g.get('M'), known_flexibility), ...
    [BRAPH2.STR ':Flexibility:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])