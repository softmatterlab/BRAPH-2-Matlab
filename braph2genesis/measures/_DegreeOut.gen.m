%% ¡header!
DegreeOut < Measure (m, out-degree) is the graph Out-Degree.

%%% ¡description!
The Out-Degree (DegreeOut) of a node is the number of outward edges connected to a node within a layer. 
Connection weights are ignored in calculations.

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
DegreeOut.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
DegreeOut.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
DegreeOut.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
DegreeOut.M
%%%% ¡title!
Out-Degree

%%% ¡prop!
%%%% ¡id!
DegreeOut.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
DegreeOut.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
DegreeOut.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Out-Degree.
%%%% ¡default!
'DegreeOut'

%%% ¡prop!
NAME (constant, string) is the name of the Out-Degree.
%%%% ¡default!
'Out-Degree'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the Out-Degree.
%%%% ¡default!
'The Out-Degree (DegreeOut) of a node is the number of outward edges connected to a node within a layer. Connection weights are ignored in calculations.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Out-Degree.
%%%% ¡settings!
'DegreeOut'

%%% ¡prop!
ID (data, string) is a few-letter code of the Out-Degree.
%%%% ¡default!
'DegreeOut ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Out-Degree.
%%%% ¡default!
'Out-Degree label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the Out-Degree.
%%%% ¡default!
'Out-Degree notes'

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
{'GraphWD' 'GraphBD' 'MultiplexWD' 'MultiplexBD' 'OrdMxWD' 'OrdMxBD' 'OrdMlWD'};

%%% ¡prop!
M (result, cell) is the cell containing the Out-Degree value.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
L = g.get('LAYERNUMBER');
out_degree = cell(L, 1);

warning('off', 'MATLAB:remoteparfor:ParforWorkerAborted')
parfor li = 1:1:L
    Aii = A{li, li};
    Aii = binarize(Aii);  % binarizes the adjacency matrix
    out_degree(li) = {sum(Aii, 2)};  % calculates the out-degree of a node for layer li
end
warning('on', 'MATLAB:remoteparfor:ParforWorkerAborted')

value = out_degree;

%% ¡tests!

%%% ¡excluded_props!
[DegreeOut.PFM]

%%% ¡test!
%%%% ¡name!
GraphWD
%%%% ¡code!
B = [
    0   .2  1
    0   0   .8
    1   0   0
    ];

know_out_degree = {[2 1 1]'};

g = GraphWD('B', B);

m_outside_g = DegreeOut('G', g);
assert(isequal(m_outside_g.get('M'), know_out_degree), ...
   [BRAPH2.STR ':DegreeOut:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'DegreeOut');
assert(isequal(m_inside_g.get('M'), know_out_degree), ...
    [BRAPH2.STR ':DegreeOut:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
GraphBD
%%%% ¡code!
B = [
    0   1   1
    0   0   0
    1   0   0
    ];

know_out_degree = {[2 0 1]'};

g = GraphBD('B', B);

m_outside_g = DegreeOut('G', g);
assert(isequal(m_outside_g.get('M'), know_out_degree), ...
   [BRAPH2.STR ':DegreeOut:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'DegreeOut');
assert(isequal(m_inside_g.get('M'), know_out_degree), ...
    [BRAPH2.STR ':DegreeOut:' BRAPH2.FAIL_TEST], ...
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

know_out_degree = {
                  [2 1 1]'
                  [2 2 1]'
                  };

g = MultiplexWD('B', B);

m_outside_g = DegreeOut('G', g);
assert(isequal(m_outside_g.get('M'), know_out_degree), ...
   [BRAPH2.STR ':DegreeOut:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'DegreeOut');
assert(isequal(m_inside_g.get('M'), know_out_degree), ...
    [BRAPH2.STR ':DegreeOut:' BRAPH2.FAIL_TEST], ...
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

know_out_degree = { 
                  [2 0 1]'
                  [1 2 2]'
                  };

g = MultiplexBD('B', B);

m_outside_g = DegreeOut('G', g);
assert(isequal(m_outside_g.get('M'), know_out_degree), ...
   [BRAPH2.STR ':DegreeOut:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'DegreeOut');
assert(isequal(m_inside_g.get('M'), know_out_degree), ...
    [BRAPH2.STR ':DegreeOut:' BRAPH2.FAIL_TEST], ...
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

know_out_degree = { 
                  [2 0 1]'
                  [1 2 2]'
                  };

g = OrdMxWD('B', B);

m_outside_g = DegreeOut('G', g);
assert(isequal(m_outside_g.get('M'), know_out_degree), ...
   [BRAPH2.STR ':DegreeOut:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'DegreeOut');
assert(isequal(m_inside_g.get('M'), know_out_degree), ...
    [BRAPH2.STR ':DegreeOut:' BRAPH2.FAIL_TEST], ...
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

know_out_degree = {
                  [2 1 1]'
                  [2 2 1]'
                  };


g = OrdMxBD('B', B);

m_outside_g = DegreeOut('G', g);
assert(isequal(m_outside_g.get('M'), know_out_degree), ...
   [BRAPH2.STR ':DegreeOut:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'DegreeOut');
assert(isequal(m_inside_g.get('M'), know_out_degree), ...
    [BRAPH2.STR ':DegreeOut:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
OrdMlWD
%%%% ¡code!
B11 = [
    0   .2   .7
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

g = OrdMlWD('B', B);

BUT_graph = g.get('A');

known_out_degree = {
                  [2 2 2]'
                  [3 3 3 3]'
                  [3 3 3 3]'};

m_outside_g = DegreeOut('G', g);
assert(isequal(m_outside_g.get('M'), known_out_degree), ...
   [BRAPH2.STR ':DegreeOut:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'DegreeOut');
assert(isequal(m_inside_g.get('M'), known_out_degree), ...
    [BRAPH2.STR ':DegreeOut:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])