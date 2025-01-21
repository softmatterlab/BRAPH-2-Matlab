%% ¡header!
DegreeOutAv < DegreeOut (m, average out-degree) is the graph Average Out-Degree.

%%% ¡description!
The Average Out-Degree (DegreeOutAv) of a graph is the average of all number of outward edges connected to a node within a layer. 

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
DegreeOutAv.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
DegreeOutAv.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
DegreeOutAv.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
DegreeOutAv.M
%%%% ¡title!
Average Out-Degree

%%% ¡prop!
%%%% ¡id!
DegreeOutAv.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
DegreeOutAv.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
DegreeOutAv.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Average Out-Degree.
%%%% ¡default!
'DegreeOutAv'

%%% ¡prop!
NAME (constant, string) is the name of the Average Out-Degree.
%%%% ¡default!
'Average Out-Degree'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the Average Out-Degree.
%%%% ¡default!
'The Average Out-Degree (DegreeOutAv) of a graph is the average of all number of outward edges connected to a node within a layer.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Average Out-Degree.
%%%% ¡settings!
'DegreeOutAv'

%%% ¡prop!
ID (data, string) is a few-letter code of the average out-degree.
%%%% ¡default!
'DegreeOutAv ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Average Out-Degree.
%%%% ¡default!
'Average Out-Degree label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the Average Out-Degree.
%%%% ¡default!
'Average Out-Degree notes'

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
{'GraphWD' 'GraphBD' 'MultiplexWD' 'MultiplexBD' 'OrdMxWD' 'OrdMxBD' 'OrdMlWD'};

%%% ¡prop!
M (result, cell) is the cell containing the Average Out-Degree.
%%%% ¡calculate!
out_degree = calculateValue@DegreeOut(m, prop);	
g = m.get('G'); % graph from measure class
L = g.get('LAYERNUMBER');
degree_out_av = cell(L, 1);

warning('off', 'MATLAB:remoteparfor:ParforWorkerAborted')
parfor li = 1:1:L
    degree_out_av(li) = {mean(out_degree{li})};
end
warning('on', 'MATLAB:remoteparfor:ParforWorkerAborted')

value = degree_out_av;

%% ¡tests!

%%% ¡excluded_props!
[DegreeOutAv.PFM]

%%% ¡test!
%%%% ¡name!
GraphWD
%%%% ¡code!
B = [
    0   .2  1
    0   0   .8
    1   0   0
    ];

know_out_degree_av = {mean([2 1 1])};

g = GraphWD('B', B);

m_outside_g = DegreeOutAv('G', g);
assert(isequal(m_outside_g.get('M'), know_out_degree_av), ...
   [BRAPH2.STR ':DegreeOutAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'DegreeOutAv');
assert(isequal(m_inside_g.get('M'), know_out_degree_av), ...
    [BRAPH2.STR ':DegreeOutAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
GraphBD
%%%% ¡code!
B = [
    0   1  1
    0   0   1
    1   0   0
    ];

know_out_degree_av = {mean([2 1 1])};

g = GraphBD('B', B);

m_outside_g = DegreeOutAv('G', g);
assert(isequal(m_outside_g.get('M'), know_out_degree_av), ...
   [BRAPH2.STR ':DegreeOutAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'DegreeOutAv');
assert(isequal(m_inside_g.get('M'), know_out_degree_av), ...
    [BRAPH2.STR ':DegreeOutAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexWD
%%%% ¡code!
B11 = [
      0   .2  1
      0   0   .8
      1   0   0
      ];
B22 = [
      0  1   .6
      1  0   .4
      0  .4  0
      ];
B = {B11 B22};

known_out_degree_av = {
                      mean([2 1 1]')
                      mean([2 2 1]')
                      };

g = MultiplexWD('B', B);

m_outside_g = DegreeOutAv('G', g);
assert(isequal(m_outside_g.get('M'), known_out_degree_av), ...
   [BRAPH2.STR ':DegreeOutAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'DegreeOutAv');
assert(isequal(m_inside_g.get('M'), known_out_degree_av), ...
    [BRAPH2.STR ':DegreeOutAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBD
%%%% ¡code!
B11 = [
      0  1  1
      0  0  0
      1  0  0
      ];
B22 = [
       0  1  0
       1  0  1
       1  1  0
       ];
B = {B11 B22};

known_out_degreeAv = { 
                  mean([2 0 1]')
                  mean([1 2 2]')
                  };

g = MultiplexBD('B', B);

m_outside_g = DegreeOutAv('G', g);
assert(isequal(m_outside_g.get('M'), known_out_degreeAv), ...
   [BRAPH2.STR ':DegreeOutAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'DegreeOutAv');
assert(isequal(m_inside_g.get('M'), known_out_degreeAv), ...
    [BRAPH2.STR ':DegreeOutAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
OrdMxWD
%%%% ¡code!
B11 = [
      0  1  1
      0  0  0
      1  0  0
      ];
B22 = [
       0  1  0
       1  0  1
       1  1  0
       ];
B = {B11 B22};

known_out_degreeAv = { 
                  mean([2 0 1])'
                  mean([1 2 2])'
                  };

g = OrdMxWD('B', B);

m_outside_g = DegreeOutAv('G', g);
assert(isequal(m_outside_g.get('M'), known_out_degreeAv), ...
   [BRAPH2.STR ':DegreeOutAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'DegreeOutAv');
assert(isequal(m_inside_g.get('M'), known_out_degreeAv), ...
    [BRAPH2.STR ':DegreeOutAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
OrdMxBD
%%%% ¡code!
B11 = [
      0   .2  1
      0   0   .8
      1   0   0
      ];
B22 = [
      0  1   .6
      1  0   .4
      0  .4  0
      ];
B = {B11 B22};

known_out_degreeAv = {
                  mean([2 1 1])'
                  mean([2 2 1])'
                  };


g = OrdMxBD('B', B);

m_outside_g = DegreeOutAv('G', g);
assert(isequal(m_outside_g.get('M'), known_out_degreeAv), ...
   [BRAPH2.STR ':DegreeOutAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'DegreeOutAv');
assert(isequal(m_inside_g.get('M'), known_out_degreeAv), ...
    [BRAPH2.STR ':DegreeOutAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
OrdMlWD
%%%% ¡code!
B11 = [
    0   .2   .4
    .2   0   .1
    .7  .1   0
    ];

B22 = [    
    0   .2   .4 .5
    .2   0   .1 .5
    .7  .1   0  .5
    .5  .5  .5  0
    ];
B33 = [    
    0   .2   .4 .5
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

g = OrdMlWD('B', B);

BUT_graph = g.get('A');

known_out_degreeAv = {
                  mean([2 2 2])'
                  mean([3 3 3 3])'
                  mean([3 3 3 3])'};

m_outside_g = DegreeOutAv('G', g);
assert(isequal(m_outside_g.get('M'), known_out_degreeAv), ...
   [BRAPH2.STR ':DegreeOutAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'DegreeOutAv');
assert(isequal(m_inside_g.get('M'), known_out_degreeAv), ...
    [BRAPH2.STR ':DegreeOutAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])