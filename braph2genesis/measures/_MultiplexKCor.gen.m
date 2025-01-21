%% ¡header!
MultiplexKCor < Measure (m,  multiplex k-core) is the graph Multiplex K-Core.

%%% ¡description!
The Multiplex K-Core (MultiplexKCor) of a graph is the largest subnetwork comprising nodes of overlapping degree k or higher. 
k is set by the user; the default value is equal to 1.

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
MultiplexKCor.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
MultiplexKCor.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
MultiplexKCor.MULTIPLEXKCORETHRESHOLD
%%%% ¡title!
Multiplex k-core threshold

%%% ¡prop!
%%%% ¡id!
MultiplexKCor.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
MultiplexKCor.M
%%%% ¡title!
Multiplex K-Core

%%% ¡prop!
%%%% ¡id!
MultiplexKCor.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
MultiplexKCor.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
MultiplexKCor.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Multiplex K-Core.
%%%% ¡default!
'MultiplexKCor'

%%% ¡prop!
NAME (constant, string) is the name of the Multiplex K-Core.
%%%% ¡default!
'Multiplex K-Core'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the Multiplex K-Core.
%%%% ¡default!
'The Multiplex K-Core (MultiplexKCor) of a graph is the largest subnetwork comprising nodes of overlapping degree k or higher. k is set by the user; the default value is equal to 1.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Multiplex K-Core.
%%%% ¡settings!
'MultiplexKCor'

%%% ¡prop!
ID (data, string) is a few-letter code of the Multiplex K-Core.
%%%% ¡default!
'MultiplexKCor ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Multiplex K-Core.
%%%% ¡default!
'Multiplex K-Core label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the Multiplex K-Core.
%%%% ¡default!
'Multiplex K-Core notes'

%%% ¡prop!
SHAPE (constant, scalar) is the measure shape __Measure.NODAL__.
%%%% ¡default!
Measure.BINODAL

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
{'MultiplexWU' 'MultiplexWD' 'MultiplexBU' 'MultiplexBD' 'OrdMxWU' 'OrdMxBU'};

%%% ¡prop!
M (result, cell) is the Multiplex K-Core.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
l = g.get('LAYERNUMBER');
ls = g.get('PARTITIONS');  

if l == 0
    value = {};
else
    N = g.get('NODENUMBER');
    multiplex_kcore_threshold = m.get('MULTIPLEXKCORETHRESHOLD');
    assert(mod(multiplex_kcore_threshold, 1) == 0, ...
        [BRAPH2.STR ':MultiplexKCore:' BRAPH2.WRONG_INPUT], ...
        ['MultiplexKCore threshold must be an integer value ' ...
        'while it is ' tostring(multiplex_kcore_threshold)])
    
    directionality_layer = g.get('DIRECTIONALITY_TYPE', l);
    multiplex_k_core = cell(length(ls), 1);
    for i = 1:1:length(ls)
        A_sum = zeros(N(1), N(1));
        for j = 1:1:length(l)
            A_sum = A_sum + A{j, j};
        end
        iter = 0;
        subAii = binarize(A_sum);
        while 1
            if directionality_layer == Graph.UNDIRECTED  % undirected graphs
                ovdeg = sum(subAii, 1)';   % ov. degree undirected 
            else
                ovdeg = (sum(subAii, 1)' + sum(subAii, 2));  % ov. degree directed
            end
         
            % find nodes with degree < k
            low_k_nodes = find((ovdeg < multiplex_kcore_threshold) & (ovdeg > 0));

            % if none found -> stop
            if (isempty(low_k_nodes)) break; end; %#ok<SEPEX>

            % peel away found nodes
            iter = iter + 1;
            subAii(low_k_nodes, :) = 0;
            subAii(:, low_k_nodes) = 0;
        end
        multiplex_k_core(i) = {subAii};  % add multiplex k-core 
    end
    value = multiplex_k_core;
end

%% ¡props!

%%% ¡prop! 
MULTIPLEXKCORETHRESHOLD (parameter, scalar) is the multiplex k-core threshold.
%%%% ¡default!
1


%% ¡tests!

%%% ¡excluded_props!
[MultiplexKCor.PFM]

%%% ¡test!
%%%% ¡name!
MultiplexWU
%%%% ¡probability!
.01
%%%% ¡code!
A11 = [
    0   .1  1  0; 
    .1  0   1  .8; 
    1   1   0  0;
    0   .8  0  0
    ];

A22 = [
    0   .1  1  0; 
    .1  0   1  .8; 
    1   1   0  0;
    0   .8  0  0
    ];
A = {A11 A22};
             
known_mkcore = {[
    0  1  1  0;
    1  0  1  0;
    1  1  0  0;
    0  0  0  0
    ]};

g = MultiplexWU('B', A);
m_outside_g = MultiplexKCor('G', g, 'MULTIPLEXKCORETHRESHOLD', 2);

assert(isequal(m_outside_g.get('M'), known_mkcore), ...
    [BRAPH2.STR ':MultiplexKCor:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'MultiplexKCor');
m_inside_g.set('MULTIPLEXKCORETHRESHOLD', 2);
assert(isequal(m_inside_g.get('M'), known_mkcore), ...
    [BRAPH2.STR ':MultiplexKCor:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexWD
%%%% ¡probability!
.01
%%%% ¡code!
A11 = [
    0   1   1  .1; 
    .2  0   1  1; 
    1   1   0  0;
    0   .3  .5  0
    ];

A22 = [
    0   1   1   .1; 
    .2  0   1   1; 
    1   1   0   0;
    0   .3  .7  0
    ];
A = {A11 A22};

known_mkcore = {[
    0  1  1  1;
    1  0  1  1;
    1  1  0  0;
    0  1  1  0
    ]};

g = MultiplexWD('B', A);
m_outside_g = MultiplexKCor('G', g, 'MULTIPLEXKCORETHRESHOLD', 4);

assert(isequal(m_outside_g.get('M'), known_mkcore), ...
    [BRAPH2.STR ':MultiplexKCor:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'MultiplexKCor');
m_inside_g.set('MULTIPLEXKCORETHRESHOLD', 4);
assert(isequal(m_inside_g.get('M'), known_mkcore), ...
    [BRAPH2.STR ':MultiplexKCor:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
OrdMxWU
%%%% ¡probability!
.01
%%%% ¡code!
A11 = [
    0   .1  1  0; 
    .1  0   1  .8; 
    1   1   0  0;
    0   .8  0  0
    ];

A22 = [
    0   .1  1  0; 
    .1  0   1  .8; 
    1   1   0  0;
    0   .8  0  0
    ];
A = {A11 A22};
             
known_mkcore = {[
    0  1  1  0;
    1  0  1  0;
    1  1  0  0;
    0  0  0  0
    ]};

g = OrdMxWU('B', A);
m_outside_g = MultiplexKCor('G', g, 'MULTIPLEXKCORETHRESHOLD', 2);

assert(isequal(m_outside_g.get('M'), known_mkcore), ...
    [BRAPH2.STR ':MultiplexKCor:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'MultiplexKCor');
m_inside_g.set('MULTIPLEXKCORETHRESHOLD', 2);
assert(isequal(m_inside_g.get('M'), known_mkcore), ...
    [BRAPH2.STR ':MultiplexKCor:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])