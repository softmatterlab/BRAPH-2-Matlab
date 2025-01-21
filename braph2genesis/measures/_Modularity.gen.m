%% ¡header!
Modularity < CommunityStructure (m, modularity) is the graph Modularity.

%%% ¡description!
The Modularity (Modularity) of a graph is the quality function Q of the resulting partition of the network.

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
Modularity.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
Modularity.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
Modularity.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
Modularity.M
%%%% ¡title!
Modularity

%%% ¡prop!
%%%% ¡id!
Modularity.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
Modularity.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
Modularity.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Modularity.
%%%% ¡default!
'Modularity'

%%% ¡prop!
NAME (constant, string) is the name of the Modularity.
%%%% ¡default!
'Modularity'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the Modularity.
%%%% ¡default!
'The Modularity (Modularity) of a graph is the quality function Q of the resulting partition of the network.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Modularity.
%%%% ¡settings!
'Modularity'

%%% ¡prop!
ID (data, string) is a few-letter code of the Modularity.
%%%% ¡default!
'Modularity ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Modularity.
%%%% ¡default!
'Modularity label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the Modularity.
%%%% ¡default!
'Modularity notes'

%%% ¡prop!
SHAPE (constant, scalar) is the measure shape __Measure.NODAL__.
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
{'GraphWU' 'GraphWD' 'GraphBU' 'GraphBD' 'MultigraphBUT' 'MultigraphBUD'};

%%% ¡prop!
M (result, cell) is the Modularity.
%%%% ¡calculate!
community_structure = calculateValue@CommunityStructure(m, prop);
Q = {0};
if ~isempty(community_structure)
    Q = m.get('QUALITY_FUNCTION');
end
modularity = Q;  % assign normalized quality function
value = modularity;

%% ¡tests!

%%% ¡excluded_props!
[Modularity.PFM]

%%% ¡test!
%%%% ¡name!
GraphBU
%%%% ¡probability!
.01
%%%% ¡code!
b = rand(10);
g = GraphBU('B', b);

m_outside_g = Modularity('G', g);
assert(~isempty(m_outside_g.get('M')), ...
    [BRAPH2.STR ':Modularity:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Modularity');
assert(~isempty(m_inside_g.get('M')), ...
    [BRAPH2.STR ':Modularity:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultigraphBUT
%%%% ¡probability!
.01
%%%% ¡code!
b = rand(10);
thresholds = [0 1];
g = MultigraphBUT('B', b, 'THRESHOLDS', thresholds);

m_outside_g = Modularity('G', g);
assert(~isempty(m_outside_g.get('M')), ...
    [BRAPH2.STR ':Modularity:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Modularity');
assert(~isempty(m_inside_g.get('M')), ...
    [BRAPH2.STR ':Modularity:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])