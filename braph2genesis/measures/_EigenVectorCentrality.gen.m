%% ¡header!
EigenVectorCentrality < Measure (m, eigenvector centrality) is the graph Eigenvector Centrality.

%%% ¡description!
The Eigenvector Centrality (EigenVectorCentrality) of a node is the ith element in the eigenvector corresponding 
to the largest eigenvalue of the largest eigenvalue of the graphs adjacency matrix.

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
EigenVectorCentrality.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
EigenVectorCentrality.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
EigenVectorCentrality.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
EigenVectorCentrality.M
%%%% ¡title!
Eigen Vector Centrality

%%% ¡prop!
%%%% ¡id!
EigenVectorCentrality.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
EigenVectorCentrality.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
EigenVectorCentrality.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Eigenvector Centrality.
%%%% ¡default!
'EigenVectorCentrality'

%%% ¡prop!
NAME (constant, string) is the name of the Eigenvector Centrality.
%%%% ¡default!
'Eigenvector Centrality'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the Eigenvector Centrality.
%%%% ¡default!
'The Eigenvector Centrality (EigenVectorCentrality) of a node is the ith element in the eigenvector corresponding to the largest eigenvalue of the largest eigenvalue of the graphs adjacency matrix.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Eigenvector Centrality.
%%%% ¡settings!
'EigenVectorCentrality'

%%% ¡prop!
ID (data, string) is a few-letter code of the Eigenvector Centrality.
%%%% ¡default!
'EigenVectorCentrality ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Eigenvector Centrality.
%%%% ¡default!
'Eigenvector Centrality label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the Eigenvector Centrality.
%%%% ¡default!
'Eigenvector Centrality notes'

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
{'GraphWU' 'GraphBU' 'MultigraphBUD' 'MultigraphBUT' 'MultiplexWU' 'MultiplexBU' 'MultiplexBUD' 'MultiplexBUT'} ;

%%% ¡prop!
M (result, cell) is the Eigenvector Centrality.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
L = g.get('LAYERNUMBER');
N = g.get('NODENUMBER');
eigenvector_centrality = cell(L, 1);

warning('off', 'MATLAB:remoteparfor:ParforWorkerAborted')
parfor li = 1:L
    Aii = A{li, li};   
    
    if N(li) < 1000
        [V, D] = eig(Aii);
    else
        [V, D] = eigs(sparse(Aii));
    end
    
    [~, idx] = max(diag(D));
    ec = abs(V(:, idx));
    eigenvector_centrality(li) = {reshape(ec, length(ec), 1)};
end
warning('on', 'MATLAB:remoteparfor:ParforWorkerAborted')

value = eigenvector_centrality; 

%% ¡tests!

%%% ¡excluded_props!
[EigenVectorCentrality.PFM]

%%% ¡test!
%%%% ¡name!
GraphWU
%%%% ¡probability!
.01
%%%% ¡code!
B =  [
    0   .5  .5  0
    .5  0   0   .5 
    .5  0   0   .5
    0   .5  .5  0
    ];

known_eigenvector_centrality = {[1/2 1/2 1/2 1/2]'};


g = GraphWU('B', B);

m_outside_g = EigenVectorCentrality('G', g);
assert(isequal(round(cell2mat(m_outside_g.get('M')), 6), round(cell2mat(known_eigenvector_centrality), 6)), ...
    [BRAPH2.STR ':EigenVectorCentrality:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'EigenVectorCentrality');
assert(isequal(round(cell2mat(m_inside_g.get('M')), 6), round(cell2mat(known_eigenvector_centrality), 6)), ...
    [BRAPH2.STR ':EigenVectorCentrality:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
GraphBU
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0 1 1 0 
    1 0 0 1 
    1 0 0 1
    0 1 1 0
    ];

known_eigenvector_centrality = {[1/2 1/2 1/2 1/2]'};

g = GraphBU('B', B);

m_outside_g = EigenVectorCentrality('G', g);
assert(isequal(round(cell2mat(m_outside_g.get('M')), 6), round(cell2mat(known_eigenvector_centrality), 6)), ...
    [BRAPH2.STR ':EigenVectorCentrality:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'EigenVectorCentrality');
assert(isequal(round(cell2mat(m_inside_g.get('M')), 6), round(cell2mat(known_eigenvector_centrality), 6)), ...
    [BRAPH2.STR ':EigenVectorCentrality:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBU
%%%% ¡probability!
.01
%%%% ¡code!
A11 = [
    0 1 1 0
    1 0 0 1
    1 0 0 1
    0 1 1 0
    ];

A22 = [
    0 1 1 0
    1 0 0 1
    1 0 0 1
    0 1 1 0
    ];
A = {A11 A22};

known_eigenvector_centrality = {
    [1/2 1/2 1/2 1/2]'
    [1/2 1/2 1/2 1/2]'
    };

g = MultiplexBU('B', A);

m_outside_g = EigenVectorCentrality('G', g);
assert(isequal(round(cell2mat(m_outside_g.get('M')), 6), round(cell2mat(known_eigenvector_centrality), 6)), ...
    [BRAPH2.STR ':EigenVectorCentrality:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'EigenVectorCentrality');
assert(isequal(round(cell2mat(m_inside_g.get('M')), 6), round(cell2mat(known_eigenvector_centrality), 6)), ...
    [BRAPH2.STR ':EigenVectorCentrality:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])
