%% ¡header!
Graph < ConcreteElement (g, graph) is a graph.

%%% ¡description!
A Graph provides the methods necessary for all graphs.
 Instances of this class should not be created. 
 Use one of its subclasses instead.

The kinds of graphs are:
 
 Graph.GRAPH. <strong>€Graph.GRAPH_NAME€</strong>: €Graph.GRAPH_DESCRIPTION€

 Graph.MULTIGRAPH. <strong>€Graph.MULTIGRAPH_NAME€</strong>: €Graph.MULTIGRAPH_DESCRIPTION€
 
 Graph.ORDERED_MULTIPLEX. <strong>€Graph.ORDERED_MULTIPLEX_NAME€</strong>: €Graph.ORDERED_MULTIPLEX_DESCRIPTION€

 Graph.MULTIPLEX. <strong>€Graph.MULTIPLEX_NAME€</strong>: €Graph.MULTIPLEX_DESCRIPTION€

 Graph.ORDERED_MULTILAYER. <strong>€Graph.ORDERED_MULTILAYER_NAME€</strong>: €Graph.ORDERED_MULTILAYER_DESCRIPTION€

 Graph.MULTILAYER. <strong>€Graph.MULTILAYER_NAME€</strong>: €Graph.MULTILAYER_DESCRIPTION€
 
%%% ¡seealso! 
Measure

%%% ¡build!
1

%% ¡constants!
% Graph types
GRAPH = 1
GRAPH_NAME = 'Graph'
GRAPH_DESCRIPTION = 'A graph consists of a single layer.'

MULTIGRAPH = 2
MULTIGRAPH_NAME = 'Multigraph'
MULTIGRAPH_DESCRIPTION = 'A multigraph consists of multiple unconnected layers.'

ORDERED_MULTIPLEX = 3
ORDERED_MULTIPLEX_NAME = 'Ordered Multipex'
ORDERED_MULTIPLEX_DESCRIPTION = ['An ordered multiplex consists of ' ...
    'a sequence of layers with ordinal connections' ...
    'between corresponding nodes in subsequent layers.']

MULTIPLEX = 4
MULTIPLEX_NAME = 'Multiplex'
MULTIPLEX_DESCRIPTION = ['A multiplex consists of ' ...
    'multiple layers with categorical connections ' ...
    'between corresponding nodes in different layers.']

ORDERED_MULTILAYER = 5
ORDERED_MULTILAYER_NAME = 'Ordered Multilayer'
ORDERED_MULTILAYER_DESCRIPTION = ['An ordered multilayer consists of ' ...
    'multiple layers with ordinal connections between any nodes.']

MULTILAYER = 6
MULTILAYER_NAME = 'Multilayer'
MULTILAYER_DESCRIPTION = ['A multilayer consists of ' ...
    'multiple layers with categorical between any nodes.']

TYPE_NUMBER = 6

TYPE_NAME = {
    Graph.GRAPH_NAME
    Graph.MULTIGRAPH_NAME
    Graph.ORDERED_MULTIPLEX_NAME
    Graph.MULTIPLEX_NAME
    Graph.ORDERED_MULTILAYER_NAME
    Graph.MULTILAYER_NAME
    }

TYPE_DESCRIPTION = {
    Graph.GRAPH_DESCRIPTION
    Graph.MULTIGRAPH_DESCRIPTION
    Graph.ORDERED_MULTIPLEX_DESCRIPTION
    Graph.MULTIPLEX_DESCRIPTION
    Graph.ORDERED_MULTILAYER_DESCRIPTION
    Graph.MULTILAYER_DESCRIPTION
    }

% Connectivity types
WEIGHTED = 1
WEIGHTED_NAME = 'Weighted'
WEIGHTED_DESCRIPTION = 'Graph with weighted connections.'

BINARY = 2
BINARY_NAME = 'Binary'
BINARY_DESCRIPTION = 'Graph with binary (0 or 1) connections.'

CONNECTIVITY_TYPE_NUMBER = 2

CONNECTIVITY_TYPE_NAME = {
    Graph.WEIGHTED_NAME
    Graph.BINARY_NAME
    }

CONNECTIVITY_TYPE_DESCRIPTION = {
    Graph.WEIGHTED_DESCRIPTION
    Graph.BINARY_DESCRIPTION
    }

% Directionality types
DIRECTED = 1
DIRECTED_NAME = 'Directed'
DIRECTED_DESCRIPTION = 'Graph with directed edges.'

UNDIRECTED = 2
UNDIRECTED_NAME = 'Undirected'
UNDIRECTED_DESCRIPTION = 'Graph with undirected edges.'

DIRECTIONALITY_TYPE_NUMBER = 2

DIRECTIONALITY_TYPE_NAME = {
    Graph.DIRECTED_NAME
    Graph.UNDIRECTED_NAME
    }

DIRECTIONALITY_TYPE_DESCRIPTION = {
    Graph.DIRECTED_DESCRIPTION
    Graph.UNDIRECTED_DESCRIPTION
    }

% Selfconnectedness types
NONSELFCONNECTED = 1
NONSELFCONNECTED_NAME = 'Non-self-connected'
NONSELFCONNECTED_DESCRIPTION = 'Graph without self-connections.';

SELFCONNECTED = 2
SELFCONNECTED_NAME = 'Self-connected'
SELFCONNECTED_DESCRIPTION = 'Graph with self-connections.';

SELFCONNECTIVITY_TYPE_NUMBER = 2

SELFCONNECTIVITY_TYPE_NAME = {
    Graph.NONSELFCONNECTED_NAME
    Graph.SELFCONNECTED_NAME
    }

SELFCONNECTIVITY_TYPE_DESCRIPTION = {
    Graph.NONSELFCONNECTED_DESCRIPTION
    Graph.SELFCONNECTED_DESCRIPTION
    }

% Negativity
NONNEGATIVE = 1
NONNEGATIVE_NAME = 'Non-negative';
NONNEGATIVE_DESCRIPTION = 'Graph without negative edges.';

NEGATIVE = 2
NEGATIVE_NAME = 'Negative';
NEGATIVE_DESCRIPTION = 'Graph allowing negative edges.';

NEGATIVITY_TYPE_NUMBER = 2

NEGATIVITY_TYPE_NAME = {
    Graph.NONNEGATIVE_NAME
    Graph.NEGATIVE_NAME
    }

NEGATIVITY_TYPE_DESCRIPTION = {
    Graph.NONNEGATIVE_DESCRIPTION
    Graph.NEGATIVE_DESCRIPTION
    }

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
Graph.ID
%%%% ¡title!
Graph ID

%%% ¡prop!
%%%% ¡id!
Graph.LABEL
%%%% ¡title!
Graph NAME

%%% ¡prop!
%%%% ¡id!
Graph.LAYERNUMBER
%%%% ¡title!
LAYERS number

%%% ¡prop!
%%%% ¡id!
Graph.PARTITIONS
%%%% ¡title!
LAYERS partitions

%%% ¡prop!
%%%% ¡id!
Graph.LAYERTICKS
%%%% ¡title!
LAYERS ticks

%%% ¡prop!
%%%% ¡id!
Graph.LAYERLABELS
%%%% ¡title!
LAYERS labels

%%% ¡prop!
%%%% ¡id!
Graph.PARTITIONLABELS
%%%% ¡title!
LAYERS labels

%%% ¡prop!
%%%% ¡id!
Graph.NODENUMBER
%%%% ¡title!
NODES number

%%% ¡prop!
%%%% ¡id!
Graph.NODELABELS
%%%% ¡title!
NODES labels

%%% ¡prop!
%%%% ¡id!
Graph.RANDOMIZE
%%%% ¡title!
RANDOMIZE ON/OFF

%%% ¡prop!
%%%% ¡id!
Graph.RANDOM_SEED
%%%% ¡title!
RANDOMIZATION SEED

%%% ¡prop!
%%%% ¡id!
Graph.A
%%%% ¡title!
ADJACENCY MATRIX

%%% ¡prop!
%%%% ¡id!
Graph.PFGA
%%%% ¡title!
Adjacency Matrix Plot

%%% ¡prop!
%%%% ¡id!
Graph.PFGH
%%%% ¡title!
Graph Histogram

%%% ¡prop!
%%%% ¡id!
Graph.M_DICT
%%%% ¡title!
Graph MEASURES

%%% ¡prop!
%%%% ¡id!
Graph.NOTES
%%%% ¡title!
Graph NOTES

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the graph (Graph).
%%%% ¡default!
'Graph'

%%% ¡prop!
NAME (constant, string) is the name of the graph.
%%%% ¡default!
'Graph'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the graph.
%%%% ¡default!
'A Graph provides the methods necessary for all graphs. Instances of this class should not be created. Use one of its subclasses instead.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the graph.
%%% ¡settings!
'Graph'

%%% ¡prop!
ID (data, string) is a few-letter code for the graph.
%%%% ¡default!
'Graph ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the graph.
%%%% ¡default!
'Graph label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the graph.
%%%% ¡default!
'Graph notes'

%% ¡props!

%%% ¡prop!
GRAPH_TYPE (constant, scalar) is the graph type.
%%%% ¡default!
Graph.GRAPH
 
%%% ¡prop!
CONNECTIVITY_TYPE (query, smatrix) is the connectivity type of the graph.
%%%% ¡calculate!
value = Graph.WEIGHTED;
 
%%% ¡prop!
DIRECTIONALITY_TYPE (query, smatrix) is the directionality type of the graph.
%%%% ¡calculate!
value = Graph.DIRECTED;

%%% ¡prop!
SELFCONNECTIVITY_TYPE (query, smatrix) is the self-connectivity type of the graph.
%%%% ¡calculate!
value = Graph.SELFCONNECTED;

%%% ¡prop!
NEGATIVITY_TYPE (query, scalar) is the negativity type of the graph.
%%%% ¡calculate!
value = Graph.NEGATIVE;

%%% ¡prop!
LAYERTICKS (metadata, rvector) are the layer tick values.
%%%% ¡gui!
pr = PanelPropRVectorSmart('EL', g, 'PROP', Graph.LAYERTICKS, varargin{:});

%%% ¡prop!
ALAYERTICKS (query, rvector) returns the layer tick values.
%%%% ¡calculate!
alayerticks = g.get('LAYERTICKS');
if isempty(alayerticks) && ~isa(g.getr('A'), 'NoValue') % ensures that it's not unecessarily calculated
    alayerticks = [1:1:g.get('LAYERNUMBER')];
end
value = alayerticks;

%%% ¡prop!
LAYERLABELS (metadata, stringlist) are the layer labels provided by the user.

%%% ¡prop!
ALAYERLABELS (query, stringlist) returns the layer labels for A.
%%%% ¡calculate!
value = g.get('LAYERLABELS');

%%% ¡prop!
PARTITIONTICKS (metadata, rvector) are the partition tick values.
%%%% ¡gui!
pr = PanelPropRVectorSmart('EL', g, 'PROP', Graph.PARTITIONTICKS, varargin{:});

%%% ¡prop!
APARTITIONTICKS (query, rvector) returns the partition tick values.
%%%% ¡calculate!
value = g.get('PARTITIONTICKS');

%%% ¡prop!
PARTITIONLABELS (metadata, stringlist) are the partition labels provided by the user.

%%% ¡prop!
APARTITIONLABELS (query, stringlist) returns the partition labels for A.
%%%% ¡calculate!
value = g.get('PARTITIONLABELS');

%%% ¡prop!
NODELABELS (metadata, stringlist) are the node labels provided by the user.
%%%% ¡default!
{'numbered'}
%%%% ¡conditioning!
if isa(value, 'BrainAtlas')
    value = value.get('BR_DICT').get('KEYS');
end

%%% ¡prop!
ANODELABELS (query, stringlist) returns the node labels for each layer.
%%%% ¡calculate!
value = g.get('NODELABELS');

%%% ¡prop!
RANDOMIZE (parameter, logical) determines whether to randomize the graph.

%%% ¡prop!
RANDOM_SEED (parameter, scalar) is the randomization seed.

%%% ¡prop!
A (result, cell) is the graph adjacency matrix. 
%%%% ¡calculate!
value = {};

%%% ¡prop!
A_CHECK (query, logical) checks the format of the adjacency matrix.
%%%% ¡calculate!
A = g.get('A');
checkA(g.get('GRAPH_TYPE'), A);  % performs all necessary checks on A
checkConnectivity(g.get('CONNECTIVITY_TYPE', length(A)), A);
checkDirectionality(g.get('DIRECTIONALITY_TYPE', length(A)), A);
checkSelfConnectivity(g.get('SELFCONNECTIVITY_TYPE', length(A)), A);
checkNegativity(g.get('NEGATIVITY_TYPE', length(A)), A);
value = true; % only if no error is thrown by the previous code!
%%%% ¡calculate_callbacks!
function checkA(graph_type, A)
    %CHECKA checks whether adjacency matrix A is correct for the type of graph.
    %
    % CHECKA(GRAPH_TYPE, A) checks if adjacency matrix A is correct for the
    %  GRAPH_TYPE.
    %
    % See also checkConnectivity, checkDirectionality, checkNegativity,
    % checkSelfConnectivity.

    % Basic checks
    % square cell array of matrices
    if ~iscell(A) || ~ismatrix(A) || size(A, 1) ~= size(A, 2)
        error([BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
            [BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT '\\n' ...
            'A must be a superadjacency matrix (square cell array of matrices).'])
    end
    % all submatrices in the diagonal are square
    if any(cellfun(@(a) size(a, 1) ~= size(a, 2), A(1:length(A)+1:end)))
        error([BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
            [BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT '\\n' ...
            'All submatrices in the cell diagonal must be square.'])
    end

    % Additional checks
    switch graph_type
        case Graph.GRAPH % __Graph.GRAPH__
            % no additional checks

        case  Graph.MULTIGRAPH % __Graph.MULTIGRAPH__
            % no additional checks

        case Graph.ORDERED_MULTIPLEX % __Graph.ORDERED_MULTIPLEX__
            if ~isempty(A) && any(cellfun(@(a) size(a, 1), A(1:length(A)+1:end)) ~= cellfun(@(a) size(a, 1), A(1, 1)))
                error([BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
                    [BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT '\\n' ...
                    'In a sequence, submatrices in the cell diagonal must have the same dimensions.'])
            end
            if ~isempty(A) && any(cellfun(@(a) size(a, 1), A(2:length(A)+1:end)) ~= cellfun(@(a) size(a, 1), A(1, 1)))
                erro([BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
                    [BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT '\\n' ...
                    'In a sequence, submatrices in the cell sub-diagonal must have the same dimensions.'])
            end
            if ~isempty(A) && any(cellfun(@(a) size(a, 1), A(length(A)+1:length(A)+1:end)) ~= cellfun(@(a) size(a, 1), A(1, 1)))
                erro([BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
                    [BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT
                    'In a sequence, submatrices in the cell super-diagonal must have the same dimensions.'])
            end

        case Graph.MULTIPLEX % __Graph.MULTIPLEX__
            % all submatrices must be square.
            if any(cellfun(@(a) size(a, 1) ~= size(a, 2), A(:)))
                error([BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
                    [BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT '\\n' ...
                    'In a multiplex, all submatrices must be square.'])
            end
            % all submatrices have same dimensions.
            if ~isempty(A) && any(cellfun(@(a) size(a, 1), A(:)) ~= cellfun(@(a) size(a, 1), A(1, 1)))
                error([BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
                    [BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT '\\n' ...
                    'In a multiplex, all submatrices must have the same dimensions.'])
            end

        case Graph.ORDERED_MULTILAYER % __Graph.ORDERED_MULTILAYER__
            if any(cellfun(@(a) size(a, 1), A(2:length(A)+1:end)) ~= cellfun(@(a) size(a, 1), A(length(A)+2:length(A)+1:end)))
                error([BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
                    [BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT '\\n' ...
                    'Sub-diagonal submatrices in the same row must have the same number of rows.'])
            end
            if any(cellfun(@(a) size(a, 2), A(2:length(A)+1:end)) ~= cellfun(@(a) size(a, 2), A(1:length(A)+1:end-1)))
                error([BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
                    [BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT '\\n' ...
                    'Sub-diagonal submatrices in the same column must have the same number of columns.'])
            end
            if any(cellfun(@(a) size(a, 1), A(length(A)+1:length(A)+1:end)) ~= cellfun(@(a) size(a, 1), A(1:length(A)+1:end-1)))
                error([BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
                    [BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT '\\n' ...
                    'Super-diagonal submatrices in the same row must have the same number of rows.'])
            end
            if any(cellfun(@(a) size(a, 2), A(length(A)+1:length(A)+1:end)) ~= cellfun(@(a) size(a, 2), A(length(A)+2:length(A)+1:end)))
                error([BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
                    [BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT '\\n' ...
                    'Super-diagonal submatrices in the same column must have the same number of columns.'])
            end

        case Graph.MULTILAYER % __Graph.MULTILAYER__
            if any(any(cellfun(@(a) size(a, 1), A) ~= cellfun(@(a) size(a, 1), A(:, 1))))
                error([BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
                    [BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT '\\n' ...
                    'All submatrices in the same row must have the same number of rows.'])
            end
            if any(any(cellfun(@(a) size(a, 2), A) ~= cellfun(@(a) size(a, 2), A(1, :))))
                error([BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
                    [BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT '\\n' ...
                    'All submatrices in the same column must have the same number of columns.'])
            end
    end
end
function checkConnectivity(connectivity_type, A)
    %CHECKCONNECTIVITY checks if adjacency matrix A is correct for the connectivity type.
    %
    % CHECKCONNECTIVITY(CONNECTIVITY_TYPE, A) checks if adjacency matrix A is
    %  correct for the CONNECTIVITY_TYPE of the graph.
    %  This check assumes that checkA has already been passed.
    %
    % See also checkA, checkDirectionality, checkNegativity, checkSelfConnectivity.

    if isnumeric(A)  % A is a matrix
        switch connectivity_type
            case Graph.BINARY % __Graph.BINARY__
                if any(any(A ~= 0 & A ~= 1))
                    error([BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
                        [BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT '\\n' ...
                        'For connectivity type __Graph.BINARY__ (%i), A must be binary (0s and 1s),' ...
                        ' while it is ' mat2str(A)], ...
                        Graph.BINARY)
                end

            case Graph.WEIGHTED % __Graph.WEIGHTED__
                % no further check needed

            otherwise
                error([BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
                    ['Connectivity type must be __Graph.BINARY__ (%i) or __Graph.WEIGHTED__ (%i),' ...
                    ' while it is ' mat2str(connectivity_type)], ...
                    Graph.BINARY, Graph.WEIGHTED)
        end
    else  % A is 2D cell array

        if numel(connectivity_type) == 1
            connectivity_type = connectivity_type * ones(size(A));
        end

        for i = 1:1:size(A, 1)
            for j = 1:1:size(A, 2)
                checkConnectivity(connectivity_type(i, j), A{i, j});
            end
        end
    end
end
function checkDirectionality(directionality_type, A, At)
    %CHECKDIRECTIONALITY checks if adjacency matrix A is correct for the directionality type.
    %
    % CHECKDIRECTIONALITY(DIRECTIONALITY_TYPE, A) checks if adjacency matrix A
    %  is correct for the DIRECTIONALITY_TYPE of the graph.
    %  This check assumes that checkA has already been passed.
    %
    % See also checkA, checkConnectivity, checkNegativity, checkSelfConnectivity.

    if nargin < 3
        At = A';
    end

    if isnumeric(A)  % A is a matrix
        switch directionality_type
            case Graph.UNDIRECTED % __Graph.UNDIRECTED__
                assert(all(all(A == At)), ...
                    [BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
                    ['For directionality type _Graph.UNDIRECTED_ (%i), A must equal to At,' ...
                    ' while it is A = ' mat2str(A) ...
                    ' and At = ' mat2str(At)], ...
                    Graph.UNDIRECTED)

            case Graph.DIRECTED % __Graph.DIRECTED__
                % no further check needed

            otherwise
                error([BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
                    ['Directionality type must be __Graph.DIRECTED__ (%i) or __Graph.UNDIRECTED__ (%i),' ...
                    ' while it is ' mat2str(directionality_type)], ...
                    Graph.DIRECTED, Graph.UNDIRECTED)
        end
    else  % A is 2D cell array

        if numel(directionality_type) == 1
            directionality_type = directionality_type * ones(size(A));
        end
        assert(all(all(directionality_type == directionality_type')), ...
            [BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
            ['The directionality type must be symmetric,' ...
            ' while it is ' mat2str(directionality_type)])

        for i = 1:1:size(A, 1)
            for j = 1:1:size(A, 2)
                checkDirectionality(directionality_type(i, j), A{i, j}, A{j, i}');
            end
        end
    end
end
function checkSelfConnectivity(selfconnectivity_type, A)
    %CHECKSELFCONNECTIVITY checks if adjacency matrix A is correct for the self-connectivity type.
    %
    % CHECKSELFCONNECTIVITY(SELFCONNECTIVITY_TYPE, A) checks if adjacency
    %  matrix A is correct for the SELFCONNECTIVITY_TYPE of the graph.
    %  This check assumes that checkA has already been passed.
    %
    % See also checkA, checkConnectivity, checkDirectionality, checkNegativity.

    if isnumeric(A)  % A is a matrix
        switch selfconnectivity_type
            case Graph.NONSELFCONNECTED % __Graph.NONSELFCONNECTED__
                if any(any(A(1:length(A)+1:end) ~= 0))
                    error([BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
                        [BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT '\\n' ...
                        'For self-connectivity type __Graph.NONSELFCONNECTED__ (%i), A must have' ...
                        ' 0 values along the diagonal while it is ' mat2str(A)], ...
                        Graph.NONSELFCONNECTED)
                end

            case Graph.SELFCONNECTED % __Graph.SELFCONNECTED__
                % no further check needed

            otherwise
                error([BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
                    ['Self-connectivity type must be __Graph.SELFCONNECTED__ (%i) or' ...
                    ' __Graph.NONSELFCONNECTED__ (%i), while it is ' mat2str(selfconnectivity_type)], ...
                    Graph.SELFCONNECTED, Graph.NONSELFCONNECTED)
        end
    else  % A is 2D cell array

        if numel(selfconnectivity_type) == 1
            selfconnectivity_type = selfconnectivity_type * ones(size(A));
        end

        for i = 1:1:size(A, 1)
            checkSelfConnectivity(selfconnectivity_type(i, i), A{i, i});
        end
    end
end
function checkNegativity(negativity_type, A)
    %CHECKNEGATIVITY checks if adjacency matrix A is correct for the negativity type.
    %
    % CHECKNEGATIVITY(NEGATIVITY_TYPE, A) checks if adjacency matrix A is
    %  correct for the NEGATIVITY_TYPE of the graph.
    %  This check assumes that checkA has already been passed.
    %
    % See also checkA, checkConnectivity, checkDirectionality, checkSelfConnectivity.

    if isnumeric(A)  % A is a matrix
        switch negativity_type
            case Graph.NONNEGATIVE % __Graph.NONNEGATIVE__
                if any(any(A < 0))
                    error([BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
                        [BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT '\\n' ...
                        'For negativity type __Graph.NONNEGATIVE__ (%i), A must have' ...
                        ' non-negative values, while it is ' mat2str(A)], ...
                        Graph.NONNEGATIVE)
                end
                
            case Graph.NEGATIVE % __Graph.NEGATIVE__
                % no further check needed

            otherwise
                error([BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
                    ['Negativity type must be __Graph.NEGATIVE__ (%i) or' ...
                    ' __Graph.NONNEGATIVE__ (%i), while it is ' mat2str(negativity_type)], ...
                    Graph.NEGATIVE, Graph.NONNEGATIVE)
        end
    else  % A is 2D cell array

        if numel(negativity_type) == 1
            negativity_type = negativity_type * ones(size(A));
        end

        for i = 1:1:size(A, 1)
            for j = 1:1:size(A, 2)
                checkNegativity(negativity_type(i, j), A{i, j});
            end
        end
    end
end

%%% ¡prop!
NODENUMBER (result, rvector) returns the number of nodes in the graph; for non single layer graphs it returns an array with the number of nodes in each layer.
%%%% ¡calculate!
A = g.get('A');
value = cellfun(@(a) length(a), A(1:length(A)+1:end)); % vector with number of nodes per layer

%%% ¡prop!
LAYERNUMBER (result, scalar) returns the number of layers in the graph.
%%%% ¡calculate!
value = length(g.get('A')); % number of layers

%%% ¡prop!
PARTITIONS (result, rvector) returns the number of layers in the partitions of the graph.
%%%% ¡calculate!
value = g.get('LAYERNUMBER'); % by default, there is a single partition

%%% ¡prop!
M_DICT (result, idict) contains the calculated measures of the graph.
%%%% ¡settings!
'Measure'
%%%% ¡calculate!
value = IndexedDictionary('IT_CLASS', 'Measure', 'IT_KEY', Measure.ELCLASS);
%%%% ¡gui!
pr = GraphPP_MDict('EL', g, 'PROP', Graph.M_DICT, varargin{:});

%%% ¡prop!
COMPATIBLE_MEASURES (constant, classlist) is the list of compatible measures.
%%%% ¡settings!
'Measure'

%%% ¡prop!
MEASURE (query, item) returns a measure.
%%%% ¡settings!
'Measure'
%%%% ¡calculate!
% M = g.get('MEASURE', MEASURE_CLASS) checks whether the measure exists in the
%  property M_DICT. If not, it creates a new measure M of class MEASURE_CLASS
%  with properties defined by the graph settings. The user must call
%  getValue() for the new measure M to retrieve the value of measure M.
if isempty(varargin)
    value = Measure();
    
    % % Warning commented because it most likely will lead to an error anyways
    % warning( ...
    %     [BRAPH2.STR ':' class(g)], ...
    %     [BRAPH2.STR ':' class(g) '\\n' ...
    %     'Missing argument MEASURE_CLASS when using Graph.get(''MEASURE'', MEASURE_CLASS).'] ...
    %     )
    
    return
end
measure_class = varargin{1};

m_list = g.get('COMPATIBLE_MEASURES');
if ~contains(measure_class, m_list)
    error(...
        [BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
        [BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT ' \\n' ...
        measure_class ' is not a compatible Measure with ' g.getClass() '. \\n' ...
        'Use ' g.getClass() '().get(''COMPATIBLE_MEASURES'') for a list of compatible measures.'])
end

m_dict = g.memorize('M_DICT');
if m_dict.get('CONTAINS_KEY', measure_class)
    m = m_dict.get('IT', measure_class);
else
    if isa(g.getr('TEMPLATE'), 'NoValue')
        m = eval([measure_class '(''ID'', measure_class, ''G'', g)']);
    else % the graph has a template
        m_template = g.get('TEMPLATE').get('MEASURE', measure_class); %#ok<NASGU>
        
        m = eval([measure_class '(''ID'', measure_class, ''G'', g, ''TEMPLATE'', m_template)']);
    end

    m_dict.get('ADD', m);
end

value = m;

%%% ¡prop!
PFGA (gui, item) contains the panel figure of the graph adjacency matrix.
%%%% ¡settings!
'GraphAdjPF'
%%%% ¡postprocessing!
if isa(g.getr('PFGA'), 'NoValue')
    g.memorize('PFGA').set('G', g)
end
%%%% ¡gui!
pr = PanelPropItem('EL', g, 'PROP', Graph.PFGA, ...
    'GUICLASS', 'GUIFig', ...
    'BUTTON_TEXT', 'Plot Adjacency Matrix', ...
    varargin{:});

%%% ¡prop!
PFGH (gui, item) contains the panel figure of the graph histogram.
%%%% ¡settings!
'GraphHistPF'
%%%% ¡postprocessing!
if isa(g.getr('PFGH'), 'NoValue')
    g.memorize('PFGH').set('G', g)
end
%%%% ¡gui!
pr = PanelPropItem('EL', g, 'PROP', Graph.PFGH, ...
    'GUICLASS', 'GUIFig', ...
    'BUTTON_TEXT', 'Plot Histogram', ...
    varargin{:});

%% ¡tests!

%%% ¡excluded_props!
[Graph.TEMPLATE Graph.PFGA Graph.PFGH]
