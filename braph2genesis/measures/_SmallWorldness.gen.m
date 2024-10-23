%% ¡header!
SmallWorldness < PathLengthAv (m, small-worldness) is the graph Small-Worldness.

%%% ¡description!
The Small-Worldness (SmallWorldness) coefficient is the fraction of the clustering coefficient 
  and average path length of each layer and the clustering coefficient and 
  average path length of 100 random graphs.

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
SmallWorldness.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
SmallWorldness.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
SmallWorldness.RULE
%%%% ¡title!
PathLength rule

%%% ¡prop!
%%%% ¡id!
SmallWorldness.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
SmallWorldness.M
%%%% ¡title!
Small-Worldness

%%% ¡prop!
%%%% ¡id!
SmallWorldness.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
SmallWorldness.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
SmallWorldness.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Small-Worldness.
%%%% ¡default!
'SmallWorldness'

%%% ¡prop!
NAME (constant, string) is the name of the Small-Worldness.
%%%% ¡default!
'Small-Worldness'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the Small-Worldness.
%%%% ¡default!
'The Small-Worldness (SmallWorldness) coefficient is the fraction of the clustering coefficient and average path length of each layer and the clustering coefficient and average path length of 100 random graphs.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Small-Worldness.
%%%% ¡settings!
'SmallWorldness'

%%% ¡prop!
ID (data, string) is a few-letter code of the Small-Worldness.
%%%% ¡default!
'SmallWorldness ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Small-Worldness.
%%%% ¡default!
'Small-Worldness label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the Small-Worldness.
%%%% ¡default!
'Small-Worldness notes'

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
%%% ¡default!
{'GraphWU' 'GraphBU' 'MultigraphBUD' 'MultigraphBUT' 'MultiplexWU' 'MultiplexBU' 'MultiplexBUD' 'MultiplexBUT'};

%%% ¡prop!
M (result, cell) is the Small-Worldness.
%%%% ¡calculate!
g = m.get('G');  % graph from measure class
if isempty(g.get('A'))
    value = {};
    return;
end
L = g.get('LAYERNUMBER');
path_length_rule = m.get('RULE');
clustering_av = ClusteringAv('G', g).get('M');
path_length_av = calculateValue@PathLengthAv(m, prop);

M = 100;  % number of random graphs
clustering_av_random = cell(1, M);
path_length_av_random = cell(1, M);
for r = 1:1:M
    tmp_b = g.get('B'); %#ok<NASGU>
    g_random = eval([g.getClass() '(''B'', tmp_b, ''TEMPLATE'', g)']);
    g_random.set('RANDOMIZE', true);

    clustering_av_random(r) = {ClusteringAv('G', g_random).get('M')};
    path_length_av_random(r) = {PathLengthAv('G', g_random, 'RULE', path_length_rule).get('M')}; 
    
end
path_length_av_random = cellfun(@(x) cell2mat(x), path_length_av_random, 'UniformOutput', false);
clustering_av_random = cellfun(@(x) cell2mat(x), clustering_av_random, 'UniformOutput', false);
path_length_av_random = cell2mat(path_length_av_random);
clustering_av_random = cell2mat(clustering_av_random);
path_length_av_random = mean(path_length_av_random, 2);
clustering_av_random = mean(clustering_av_random, 2);

small_worldness = cell(L, 1);
for li = 1:1:L
    small_worldness_layer = (clustering_av{li}/clustering_av_random(li)) / (path_length_av{li}/ path_length_av_random(li));
    small_worldness_layer(isnan(small_worldness_layer)) = 0;  % node NaN corresponds to 0/0 or Inf/Inf from path length (disconnected nodes)
    small_worldness(li) = {small_worldness_layer};
end

value = small_worldness;

%% ¡tests!

%%% ¡excluded_props!
[SmallWorldness.PFM]

%%% ¡test!
%%%% ¡name!
GraphWU
%%%% ¡probability!
.01
%%%% ¡code!
small_sample = testBraph2WattsStrogatz(20,5,0.1);

g = GraphWU('B', adjacency(small_sample));

m_outside_g = SmallWorldness('G', g);
tmp_val = m_outside_g.get('M');
assert(tmp_val{1} > 1, ...
    [BRAPH2.STR ':SmallWorldness:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'SmallWorldness');
tmp_val = m_inside_g.get('M');
assert(tmp_val{1} > 1, ...
    [BRAPH2.STR ':SmallWorldness:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
GraphBU
%%%% ¡probability!
.01
%%%% ¡code!
small_sample = testBraph2WattsStrogatz(20, 5, 0.1);

g = GraphBU('B', adjacency(small_sample));

m_outside_g = SmallWorldness('G', g);
tmp_val = m_outside_g.get('M');
assert(tmp_val{1} > 1, ...
    [BRAPH2.STR ':SmallWorldness:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'SmallWorldness');
tmp_val = m_inside_g.get('M');
assert(tmp_val{1} > 1, ...
    [BRAPH2.STR ':SmallWorldness:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultigraphBUD
%%%% ¡probability!
.01
%%%% ¡code!
small_sample = testBraph2WattsStrogatz(20, 5, 0.1);

densities = [1 90];

g = MultigraphBUD('B', adjacency(small_sample), 'DENSITIES', densities);

m_outside_g = SmallWorldness('G', g);
tmp_val = m_outside_g.get('M');
assert(tmp_val{2} > 1, ...
    [BRAPH2.STR ':SmallWorldness:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'SmallWorldness');
tmp_val = m_inside_g.get('M');
assert(tmp_val{2} > 1, ...
    [BRAPH2.STR ':SmallWorldness:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultigraphBUT
%%%% ¡code!
thresholds = [0.2 1];
small_sample = testBraph2WattsStrogatz(20, 5, 0.1);

g = MultigraphBUT('B', adjacency(small_sample), 'THRESHOLDS', thresholds);

m_outside_g = SmallWorldness('G', g);
tmp_val = m_outside_g.get('M');
assert(tmp_val{1} > 1, ...
    [BRAPH2.STR ':SmallWorldness:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'SmallWorldness');
tmp_val = m_inside_g.get('M');
assert(tmp_val{1} > 1, ...
    [BRAPH2.STR ':SmallWorldness:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexWU
%%%% ¡probability!
.01
%%%% ¡code!
B11 = adjacency(testBraph2WattsStrogatz(20, 5, 0.1));
B22 = adjacency(testBraph2WattsStrogatz(20, 5, 0.1));

B = {B11 B22};

g = MultiplexWU('B', B);

m_outside_g = SmallWorldness('G', g);
tmp_val = m_outside_g.get('M');
assert(tmp_val{2} > 1, ...
    [BRAPH2.STR ':SmallWorldness:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'SmallWorldness');
tmp_val = m_inside_g.get('M');
assert(tmp_val{2} > 1, ...
    [BRAPH2.STR ':SmallWorldness:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
GraphBU
%%%% ¡probability!
.01
%%%% ¡code!
B11 = adjacency(testBraph2WattsStrogatz(20, 5, 0.1));
B22 = adjacency(testBraph2WattsStrogatz(20, 5, 0.1));

B = {B11 B22};

g = MultiplexBU('B', B);

m_outside_g = SmallWorldness('G', g);
tmp_val = m_outside_g.get('M');
assert(tmp_val{2} > 1, ...
    [BRAPH2.STR ':SmallWorldness:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'SmallWorldness');
tmp_val = m_inside_g.get('M');
assert(tmp_val{2} > 1, ...
    [BRAPH2.STR ':SmallWorldness:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test_functions!
function h = testBraph2WattsStrogatz(N,K,beta)
    % H = WattsStrogatz(N,K,beta) returns a Watts-Strogatz model graph with N
    % nodes, N*K edges, mean node degree 2*K, and rewiring probability beta.
    %
    % beta = 0 is a ring lattice, and beta = 1 is a random graph.
    
    % Connect each node to its K next and previous neighbors. This constructs
    % indices for a ring lattice.
    s = repelem((1:N)',1,K);
    t = s + repmat(1:K,N,1);
    t = mod(t-1,N)+1;
    
    % Rewire the target node of each edge with probability beta
    for source=1:N    
        switchEdge = rand(K, 1) < beta;
        
        newTargets = rand(N, 1);
        newTargets(source) = 0;
        newTargets(s(t==source)) = 0;
        newTargets(t(source, ~switchEdge)) = 0;
        
        [~, ind] = sort(newTargets, 'descend');
        t(source, switchEdge) = ind(1:nnz(switchEdge));
    end
    
    h = graph(s,t);
end