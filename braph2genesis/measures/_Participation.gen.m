%% ¡header!
Participation < Measure (m, participation) is the graph Participation.

%%% ¡description!
The Participation (Participation) of a node is the ratio of edges that a node forms within 
 a single layer community to the total number of edges that forms within the whole single layer graph.

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
Participation.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
Participation.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
Participation.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
Participation.M
%%%% ¡title!
Participation

%%% ¡prop!
%%%% ¡id!
Participation.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
Participation.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
Participation.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Participation.
%%%% ¡default!
'Participation'

%%% ¡prop!
NAME (constant, string) is the name of the Participation.
%%%% ¡default!
'Participation'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the Participation.
%%%% ¡default!
'The Participation (Participation) of a node is the ratio of edges that a node forms within a single layer community to the total number of edges that forms within the whole single layer graph.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Participation.
%%%% ¡settings!
'Participation'

%%% ¡prop!
ID (data, string) is a few-letter code of the Participation.
%%%% ¡default!
'Participation ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Participation.
%%%% ¡default!
'Participation label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the Participation.
%%%% ¡default!
'Participation notes'

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
{'GraphWU' 'GraphWD' 'GraphBD' 'GraphBU' 'MultigraphBUT' 'MultigraphBUD' 'MultiplexWU' 'MultiplexWD' 'MultiplexBU' 'MultiplexBD' 'MultiplexBUT' 'MultiplexBUD'};

%%% ¡prop!
M (result, cell) is the Participation.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
L = g.get('LAYERNUMBER');
N = g.get('NODENUMBER');
ls = g.get('PARTITIONS');
directed_participation_rule = m.get('RULE');
participation = cell(L, 1);
directionality_type =   g.get('DIRECTIONALITY_TYPE', L);
connectivity_type =  g.get('CONNECTIVITY_TYPE', L);
if ls == 1
    S = CommunityStructure('G', g).get('M');
else
    S = MultilayerCommunity('G', g).get('M');
end

for li = 1:1:L
    connectivity_layer = connectivity_type(li, li);
    directionality_layer = directionality_type(li, li);
    Aii = A{li, li};
    if ~isequal(m.get('CI'), cell2mat(S))
        m.set('CI', cell2mat(S));
    end
   
    if connectivity_layer == Graph.WEIGHTED  % weighted graphs
        if directionality_layer == Graph.UNDIRECTED  % undirected graphs
            ko = Strength('G', g).get('M');
        else  % directed graphs
            directed_participation_rule = m.get('rule');
            switch lower(directed_participation_rule)
                case {'in'}  % in-strength rule                   
                    ko = InStrength('G', g).get('M');                   
                otherwise  % {'out'}  % out-strength rule
                    ko = OutStrength('G', g).get('M');
            end
        end
    else  % binary graphs
        if directionality_layer == Graph.UNDIRECTED  % undirected graphs
            ko = Degree('G', g).get('M');
        else  % directed graphs
            directed_participation_rule = m.get('RULE');
            switch lower(directed_participation_rule)
                case {'in'}  % in-degree rule
                    ko = DegreeIn('G', g).get('M');
                otherwise  % {'out'}  % out-degree rule
                    ko = DegreeOut('G', g).get('M');
            end
        end
    end

    Gc = (Aii~=0)*diag(S{li});  % neighbor community affiliation
    Kc2 = zeros(N(1), 1);  % community-specific neighbors
    for i=1:max(S{li})
        Kc2 = Kc2 + (sum(Aii.*(Gc==i), 2).^2);
    end
    participation_layer = ones(N(1), 1) - Kc2./(ko{li}.^2);
    participation_layer(~ko{li}) = 0;  % participation = 0 if for nodes with no (out)neighbors
    participation(li) = {participation_layer};
end
value = participation;

%% ¡props!

%%% ¡prop! 
CI (parameter, MATRIX) 
%%%% ¡default!
1

%%% ¡prop! 
RULE (parameter, option)
%%%% ¡settings!
{'in', 'out'}
%%%% ¡default!
'out'

%% ¡tests!

%%% ¡excluded_props!
[Participation.PFM]

%%% ¡test!
%%%% ¡name!
GraphBU
%%%% ¡probability!
.01
%%%% ¡code!

A = [
    0 1 1 1 0 0 0 0;
    0 0 1 0 1 0 0 0;
    0 0 0 0 1 0 0 0;
    0 0 1 0 1 0 0 0;
    0 0 0 0 0 1 1 0;
    0 0 0 0 0 0 0 1;
    0 0 0 0 0 0 0 1;
    0 0 0 0 0 0 0 0
    ];

known_participation = {[0 4/9 3/8 4/9 12/25 0 0 0]'};
g = GraphBU('B', A);

m_outside_g = Participation('G', g);
assert(isequal(m_outside_g.get('M'), known_participation), ...
    [BRAPH2.STR ':Participation:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Participation');
assert(isequal(m_inside_g.get('M'), known_participation), ...
    [BRAPH2.STR ':Participation:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultigraphBUT
%%%% ¡probability!
.01
%%%% ¡code!

A = [
    0 1 1 1 0 0 0 0;
    0 0 1 0 1 0 0 0;
    0 0 0 0 1 0 0 0;
    0 0 1 0 1 0 0 0;
    0 0 0 0 0 1 1 0;
    0 0 0 0 0 0 0 1;
    0 0 0 0 0 0 0 1;
    0 0 0 0 0 0 0 0
    ];

known_participation = {...
	    [1-1/3 1-1/3 3/4 1-1/3 4/5 1/2 1/2 1/2]'
	    [0 0 0 0 0 0 0 0]'};

g = MultigraphBUT('B', A, 'THRESHOLDS', [0 1]);

m_outside_g = Participation('G', g);
assert(isequal(m_outside_g.get('M'), known_participation), ...
    [BRAPH2.STR ':Participation:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Participation');
assert(isequal(m_inside_g.get('M'), known_participation), ...
    [BRAPH2.STR ':Participation:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
GraphBD
%%%% ¡probability!
.01
%%%% ¡code!
A = [
    0 1 1 1 0 0 0 0;
    0 0 1 0 1 0 0 0;
    0 0 0 0 1 0 0 0;
    0 0 1 0 1 0 0 0;
    0 0 0 0 0 1 1 0;
    0 0 0 0 0 0 0 1;
    0 0 0 0 0 0 0 1;
    0 0 0 0 0 0 0 0
    ];

% out rule - default
known_participation = {[0 1/2 0 1/2 0 0 0 0]'};

g = GraphBD('B', A);

m_outside_g = Participation('G', g);
assert(isequal(m_outside_g.get('M'), known_participation), ...
    [BRAPH2.STR ':Participation:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Participation');
assert(isequal(m_inside_g.get('M'), known_participation), ...
    [BRAPH2.STR ':Participation:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

% in rule 
known_participation = {[0 -1 8/9 -1 5/9 0 0 1]'};

g = GraphBD('B', A);

m_outside_g = Participation('G', g);
m_outside_g.set('RULE', 'in');
assert(isequal(m_outside_g.get('M'), known_participation), ...
    [BRAPH2.STR ':Participation:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Participation');
m_inside_g.set('RULE', 'in');
assert(isequal(m_inside_g.get('M'), known_participation), ...
    [BRAPH2.STR ':Participation:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

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
A = {A11 A22};
 
known_participation = {
                 [0 0 0 0]'
                 [0 0 0 0]'
                 };   
 
g = MultiplexBU('B', A);

m_outside_g = Participation('G', g);
assert(isequal(m_outside_g.get('M'), known_participation), ...
    [BRAPH2.STR ':Participation:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Participation');
assert(isequal(m_inside_g.get('M'), known_participation), ...
    [BRAPH2.STR ':Participation:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])