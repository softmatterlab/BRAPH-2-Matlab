%% ¡header!
StrengthOutAv < StrengthOut (m, average out-strength) is the graph Average Out-Strength.

%%% ¡description!
The Average Out-Strength (StrengthOutAv) of a graph is the mean of the sum of all weights of the outward edges 
connected to a node within a layer, i.e., it is the sum of the rows of 
the adjacency matrix. 

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
StrengthOutAv.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
StrengthOutAv.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
StrengthOutAv.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
StrengthOutAv.M
%%%% ¡title!
Average Out-Strength

%%% ¡prop!
%%%% ¡id!
StrengthOutAv.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
StrengthOutAv.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
StrengthOutAv.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Average Out-Strength.
%%%% ¡default!
'StrengthOutAv'

%%% ¡prop!
NAME (constant, string) is the name of the Average Out-Strength.
%%%% ¡default!
'Average Out-Strength'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the Average Out-Strength.
%%%% ¡default!
'The Average Out-Strength (StrengthOutAv) of a graph is the mean of the sum of all weights of the outward edges connected to a node within a layer, i.e., it is the sum of the rows of the adjacency matrix.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Average Out-Strength.
%%%% ¡settings!
'StrengthOutAv'

%%% ¡prop!
ID (data, string) is a few-letter code of the Average Out-Strength.
%%%% ¡default!
'StrengthOutAv ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Average Out-Strength.
%%%% ¡default!
'Average Out-Strength label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the Average Out-Strength.
%%%% ¡default!
'Average Out-Strength notes'

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
{'GraphWD' 'MultiplexWD' 'OrdMxWD' 'MultilayerWD' 'OrdMlWD'}

%%% ¡prop!
M (result, cell) is the Average Out-Strength.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
out_strength = calculateValue@StrengthOut(m, prop);
L = g.get('LAYERNUMBER');

out_strength_av = cell(L, 1);

warning('off', 'MATLAB:remoteparfor:ParforWorkerAborted')
parfor li = 1:1:L
    out_strength_av(li) = {mean(out_strength{li})};
end
warning('on', 'MATLAB:remoteparfor:ParforWorkerAborted')

value = out_strength_av;

%% ¡tests!

%%% ¡excluded_props!
[StrengthOutAv.PFM]

%%% ¡test!
%%%% ¡name!
GraphWD
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0  .2 1
    .2 0  0
    1  0  0
    ];
known_strength = {mean([1.2 0.2 1])};
g = GraphWD('B', B);
m_outside_g = StrengthOutAv('G', g);
assert(isequal(m_outside_g.get('M'), known_strength), ...
    [BRAPH2.STR ':StrengthOutAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'StrengthOutAv');
assert(isequal(m_inside_g.get('M'), known_strength), ...
    [BRAPH2.STR ':StrengthOutAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])


%%% ¡test!
%%%% ¡name!
MultiplexWD
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0  .2 1
    .2 0  0
    1  0  0
    ];
B22 = [
    0 1  0
    1 0  .4
    0 .4 0
    ];
B = {B11 B22};

known_strength = {
                 mean([1.2 .2  1])
                 mean([1   1.4 .4])
                 };
                                
g = MultiplexWD('B', B);
m_outside_g = StrengthOutAv('G', g);
assert(isequal(m_outside_g.get('M'), known_strength), ...
    [BRAPH2.STR ':StrengthOutAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'StrengthOutAv');
assert(isequal(m_inside_g.get('M'), known_strength), ...
    [BRAPH2.STR ':StrengthOutAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
OrdMxWD
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0   .3  1
    .2  0   0
    1   0   0
    ];
B22 = [
    0   0.3   0
    1   0   .3
    0   .3  0
    ];
B= {B11 B22};

known_strength = {
    mean([1.3 .2 1])
    mean([0.3 1.3 .3])
    };

g = OrdMxWD('B', B);

m_outside_g = StrengthOutAv('G', g);
assert(isequal(m_outside_g.get('M'), known_strength), ...
    [BRAPH2.STR ':StrengthOutAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'StrengthOutAv');
assert(isequal(m_inside_g.get('M'), known_strength), ...
    [BRAPH2.STR ':StrengthOutAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultilayerWD
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0   0.2   .7
    .2   0   .1
    .7  .1   0
    ];

B22 = [    
    0   .2   .7 .5
    .2   0   .1 .5
    .7  .1   0  .5
    .5  .5  .5  0
    ];
B33 = [    
    0   .2   .9 .5
    .2   0   .1 .5
    .9  .1   0  .2
    .5  .5  .2  0
    ];
B12 = rand(size(B11,1),size(B22,2));
B13 = rand(size(B11,1),size(B33,2));
B23 = rand(size(B22,1),size(B33,2));
B21 = B12';
B31 = B13';
B32 = B23';
B= {B11 B12 B13;
    B21 B22 B23;
    B31 B32 B33};

known_strength = {
    mean([0.9 0.3 0.8])
    mean([1.4 0.8 1.3 1.5])
    mean([1.6 0.8 1.2 1.2])
    };

g = MultilayerWD('B', B);

m_outside_g = StrengthOutAv('G', g);
assert(isequal(m_outside_g.get('M'), known_strength), ...
    [BRAPH2.STR ':StrengthOutAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'StrengthOutAv');
assert(isequal(m_inside_g.get('M'), known_strength), ...
    [BRAPH2.STR ':StrengthOutAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
OrdMlWD
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0   0.2   .7
    .2   0   .1
    .7  .1   0
    ];

B22 = [    
    0   .2   .7 .5
    .2   0   .1 .5
    .7  .1   0  .5
    .5  .5  .5  0
    ];
B33 = [    
     0  .2   .9 .5
    .2   0   .1 .5
    .9  .1   0  .2
    .5  .5  .2  0
    ];
B12 = rand(size(B11,1),size(B22,2));
B13 = rand(size(B11,1),size(B33,2));
B23 = rand(size(B22,1),size(B33,2));
B21 = B12';
B31 = B13';
B32 = B23';
B= {B11 B12 B13;
    B21 B22 B23;
    B31 B32 B33};

known_strength = {
    mean([0.9 0.3 0.8])
    mean([1.4 0.8 1.3 1.5])
    mean([1.6 0.8 1.2 1.2])
    };

g = OrdMlWD('B', B);
m_outside_g = StrengthOutAv('G', g);
assert(isequal(m_outside_g.get('M'), known_strength), ...
    [BRAPH2.STR ':StrengthOutAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'StrengthOutAv');
assert(isequal(m_inside_g.get('M'), known_strength), ...
    [BRAPH2.STR ':StrengthOutAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])
