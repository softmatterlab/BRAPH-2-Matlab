%% ¡header!
MultilayerCommunity < Measure (m, multilayer community structure) is the graph Multilayer Community Structure.

%%% ¡description!
The Multilayer Community Structure (MultilayerCommunity) of a multilayer graph is a subdivision of 
 the network into non-overlapping groups of nodes which maximizes the number 
 of within group edges, and minimizes the number of between group edges.

%%% ¡build!
1

%% ¡layout!
    
%%% ¡prop!
%%%% ¡id!
MultilayerCommunity.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
MultilayerCommunity.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
MultilayerCommunity.GAMMA
%%%% ¡title!
Gamma (resolution) parameter

%%% ¡prop!
%%%% ¡id!
MultilayerCommunity.OMEGA
%%%% ¡title!
Omega (inter-layer coupling) parameter

%%% ¡prop!
%%%% ¡id!
MultilayerCommunity.S0
%%%% ¡title!
Initial partition for the multilayer modularity matrix (optional).

%%% ¡prop!
%%%% ¡id!
MultilayerCommunity.OM
%%%% ¡title!
Multilayer modularity matrix (optional).

%%% ¡prop!
%%%% ¡id!
MultilayerCommunity.LIMIT
%%%% ¡title!
Maximum size of multilayer modularity matrix.

%%% ¡prop!
%%%% ¡id!
MultilayerCommunity.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
MultilayerCommunity.M
%%%% ¡title!
MultilayerCommunity

%%% ¡prop!
%%%% ¡id!
MultilayerCommunity.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
MultilayerCommunity.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
MultilayerCommunity.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Multilayer Community Structure.
%%%% ¡default!
'MultilayerCommunity'

%%% ¡prop!
NAME (constant, string) is the name of the Multilayer Community Structure.
%%%% ¡default!
'Multilayer Community Structure'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the Multilayer Community Structure.
%%%% ¡default!
'The Multilayer Community Structure (MultilayerCommunity) of a multilayer graph is a subdivision of the network into non-overlapping groups of nodes which maximizes the number of within group edges, and minimizes the number of between group edges.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Multilayer Community Structure.
%%%% ¡settings!
'MultilayerCommunity'

%%% ¡prop!
ID (data, string) is a few-letter code of the Multilayer Community Structure.
%%%% ¡default!
'MultilayerCommunity ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Multilayer Community Structure.
%%%% ¡default!
'Multilayer Community Structure label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the Multilayer Community Structure.
%%%% ¡default!
'Multilayer Community Structure notes'

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
{'MultiplexWU' 'MultiplexWD' 'OrdMxWU' 'MultiplexBU' 'MultiplexBD' 'MultiplexBUT' 'MultiplexBUD' 'MultilayerBU' 'MultilayerWU' 'OrdMlWU'};

%%% ¡prop!
M (result, cell) is the Multilayer Community Structure.
%%%% ¡calculate!
g = m.get('G');  % graph from measure class
L = g.get('LAYERNUMBER');
N = g.get('NODENUMBER');
graph_type = g.get('GRAPH_TYPE');
limit = m.get('LIMIT');  % set default for maximum size of multilayer modularity matrix
randord = m.get('RANDORD');  % set randperm
randmove = m.get('RANDMOVE');  % set move function
gamma = m.get('GAMMA');
omega = m.get('OMEGA');
S0 = m.get('S0');
OM = m.get('OM');

if L == 0  % no value case
    value = {};
    return;
end
% set randperm- v. index-ordered
if randord
    myord = @(n) randperm(n);
else
    myord = @(n) 1:n;
end

% set move function (maximal (original Louvain) or random improvement)
if randmove
    if ischar(randmove)
        if any(strcmp(randmove,{'move','moverand','moverandw'}))
            movefunction = randmove;
        else
            error('unknown value for ''randmove''');
        end
    else
        % backwards compatibility: randmove=true
        movefunction = 'moverand';
    end
else
    movefunction = 'move';
end

if isempty(OM)
    directionality_type =  g.get('DIRECTIONALITY_TYPE', L);
    directionality_firstlayer = directionality_type(1, 1);
    A = cell(L, 1);
    A_hold = g.get('A');
    for i=1:L
        A(i) = {A_hold{i, i}};
    end
    if graph_type == Graph.MULTIPLEX || graph_type == Graph.MULTILAYER
        if directionality_firstlayer == Graph.UNDIRECTED  % undirected
            [OM, twom] = multicat_undirected(m, A, gamma, omega, N(1), L);
        else  % directed
            [OM, twom] = multicat_directed(m, A, gamma, omega, N(1), L);
        end
    elseif graph_type== Graph.ORDERED_MULTIPLEX || graph_type== Graph.ORDERED_MULTILAYER
        if directionality_firstlayer == Graph.UNDIRECTED  % undirected
            [OM, twom] = multiord_undirected(m, A, gamma, omega, N(1), L);
        else  % directed
            [OM, twom] = multiord_directed(m, A, gamma, omega, N(1), L);
        end
    end
end

% initialise variables and do symmetry check
if isa(OM,'function_handle')
    n = length(OM(1));
    S = (1:n)';
    
    if isempty(S0)
        S0 = (1:n)';
    else
        if numel(S0) == n
            group_handler('assign', S0);
            S0 = group_handler('return'); % tidy config
        else
            error([BRAPH2.STR ':MultilayerCommunity:' BRAPH2.WRONG_INPUT], ...
                ['Initial partition size for the modularity matrix should be equal to %i,' ...
                ' while it is ' tostring(numel(S0))], n)
        end
    end
    
    % symmetry check (only checks symmetry of a small part of the matrix)
    M = OM;
    it(:,1) = M(1);
    ii = find(it(2:end)>0,3) + 1;
    ii = [1,ii'];
    for i=2:length(ii)
        it(:,i)=M(ii(i));
    end
    it = it(ii,:);
%     if norm(full(it-it')) > 2*eps
%         error([BRAPH2.STR ':MultilayerCommunity:' BRAPH2.WRONG_INPUT], ...
%             'Function handle does not correspond to a symmetric matrix. Deviation: %i', norm(full(it-it')))
%     end
else
    n = length(OM);
    S = (1:n)';
    if isempty(S0)
        S0 = (1:n)';
    else
        if numel(S0)==n
            % clean input partition
            group_handler('assign', S0);
            S0 = group_handler('return');
        else
            error([BRAPH2.STR ':MultilayerCommunity:' BRAPH2.WRONG_INPUT], ...
                ['Initial partition size for the modularity matrix should be equal to %i,' ...
                ' while it is ' tostring(numel(S0))], n)
        end
    end
    %symmetry check and fix if not symmetric
    if nnz(OM-OM')
        OM = (OM+OM')/2;
        %                     disp('WARNING: Forced symmetric OM matrix')
    end
    M = OM;
end

dtot = eps;  % keeps track of total change in modularity
y = S0;
% Run using function handle, if provided
while (isa(M,'function_handle'))  % loop around each "pass" (in language of Blondel et al) with OM function handle
    Sb = S;
    yb = [];
    while ~isequal(yb,y)
        dstep = 1;  % keeps track of change in modularity in pass
        yb = [];
        while (~isequal(yb,y)) && (dstep/dtot>2*eps) && (dstep>10*eps)  % This is the loop around Blondel et al's "first phase"
            yb = y;
            dstep = 0;
            group_handler('assign',y);
            for i = myord(length(M(1)))
                di = group_handler(movefunction, i, M(i));
                dstep = dstep + di;
            end
            
            dtot = dtot + dstep;
            y = group_handler('return');
        end
        yb = y;
    end
    
    % update partition
    S = y(S);  % group_handler implements tidyconfig
    y = unique(y);  % unique also puts elements in ascending order
    
    % calculate modularity and return if converged
    if isequal(Sb,S)
        Q = 0;
        P = sparse(y,1:length(y),1);
        for i=1:length(M(1))
            Q = Q + (P*M(i))'*P(:,i);
        end
        Q = full(Q);
        clear('group_handler');
        clear('metanetwork_reduce');
        m.set('QUALITY_FUNCTION', Q/twom)  % save normalized quality function
        S = reshape(S, N(1), L);
        multilayer_community_structure = cell(L, 1);
        for li = 1:1:L
            multilayer_community_structure(li) = {S(:, li)};
        end
        return
    end
    
    % check wether #groups < limit
    t = length(unique(S));
    if (t > limit)
        metanetwork_reduce('assign', S);  % inputs group information to metanetwork_reduce
        M = @(i) metanetwork_i(m,OM,i);  % use function handle if #groups > limit
    else
        metanetwork_reduce('assign', S);
        J = zeros(t);  % convert to matrix if #groups small enough
        for c=1:t
            J(:,c) = metanetwork_i(m,OM,c);
        end
        OM = J;
        M = OM;
    end
end

% Run using matrix OM (old B)
S2 = (1:length(OM))';
Sb = [];
while ~isequal(Sb, S2)  % loop around each "pass" (in language of Blondel et al) with B matrix
    Sb = S2;
    yb = [];
    while ~isequal(yb,y)
        dstep = 1;
        while (~isequal(yb,y)) && (dstep/dtot > 2*eps) && (dstep > 10*eps)  % This is the loop around Blondel et al's "first phase"
            yb = y;
            dstep = 0;
            group_handler('assign',y);
            for i = myord(length(M))
                di = group_handler(movefunction,i,M(:,i));
                dstep = dstep+di;
            end
            dtot = dtot + dstep;
            y = group_handler('return');
        end
        yb = y;
    end
    
    % update partition
    S = y(S);
    S2 = y(S2);
    
    if isequal(Sb,S2)
        P = sparse(y,1:length(y),1);
        Q = full(sum(sum((P*M).*P)));
        m.set('QUALITY_FUNCTION', Q/twom);  % save normalized quality function
        S = reshape(S, N(1), L);
        multilayer_community_structure = cell(L, 1);
        for li = 1:1:L
            multilayer_community_structure(li) = {S(:, li)};
        end
        value = multilayer_community_structure;
        return
    end
    
    M = metanetwork(m, OM, S2);
    y = unique(S2);  % unique also puts elements in ascending order
end
m.set('QUALITY_FUNCTION', Q/twom);  % save normalized quality function
S = reshape(S, N(1), L);
multilayer_community_structure = cell(L, 1);
for li = 1:1:L
    multilayer_community_structure(li) = {S(:, li)};
end

value = multilayer_community_structure;

%%%% ¡calculate_callbacks!
function [OM, twom] = multiord_undirected(m, A, gamma, omega, N, T)
% MULTIORDUNDIRECTED returns the multilayer modularity matrix for ordered undirected networks
%
% [B, twom] = MULTIORDUNDIRECTED(A, GAMMA, OMEGA, N, T) returns the multilayer
% Newman-Girvan modularity matrix for ordered undirected networks.
%
%   Input: A: Cell array of NxN adjacency matrices for each layer of an
%          ordered undirected multilayer network
%          gamma: intralayer resolution parameter
%          omega: interlayer coupling strength
%
%   Output: B: function handle where B(i) returns the ith column of
%          [NxT]x[NxT] flattened modularity tensor for the
%           multilayer network with uniform ordinal coupling (T is
%           the number of layers of the network)
%           twom: normalisation constant
%
%   Example of usage: [B,twom]=multiord_f(A,gamma,omega);
%          [S,Q]= genlouvain(B); % see iterated_genlouvain.m and
%          postprocess_ordinal_multilayer.m for how to improve output
%          multilayer partition
%          Q=Q/twom;
%          S=reshape(S,N,T);
%
%   [B,twom] = MULTIORD_F(A,GAMMA, OMEGA) with A a cell array of square
%   symmetric matrices of equal size each representing an undirected network
%   "layer" computes the multilayer Newman-Girvan modularity matrix using
%   the quality function described in Mucha et al. 2010, with intralayer
%   resolution parameter GAMMA, and with interlayer coupling OMEGA connecting
%   nearest-neighbor ordered layers.  The null model used for the quality
%   function is the Newman-Girvan null model (see e.g. Bazzi et al. for other
%   possible null models). Once the mulilayer modularity matrix is computed,
%   optimization can be performed by the generalized Louvain code GENLOUVAIN
%   or ITERATED_GENLOUVAIN. The output B can be used with other heuristics,
%   provided the same mapping is used to go from the multilayer tensor to
%   the multilayer flattened matrix. That is, the node-layer tuple (i,s)
%   is mapped to i + (s-1)*N. [Note that we can define a mapping between a
%   multilayer partition S_m stored as an N by T matrix and the corresponding
%   flattened partition S stored as an NT by 1 vector. In particular
%   S_m = reshape(S,N,T) and S = S_m(:).]
%
%
%   See also
%       genlouvain heuristics:      GENLOUVAIN, ITERATED_GENLOUVAIN
%       multilayer wrappers:        MULTICAT, MULTICATF, MULTIORD
%       other heuristics:           SPECTRAL23
%       Kernighan-Lin improvement:  KLNB
%
%   Notes:
%     The matrices in the cell array A are assumed to be square,
%     symmetric, and of equal size.  These assumptions are not checked here.
%
%     For smaller systems, it is potentially more efficient (and easier) to
%     directly use the sparse quality/modularity matrix B in MULTIORD. For
%     large systems with directed layer networks, use MULTIORDDIR_F.
%
%     This code serves as a template and can be modified for situations
%     with other wrinkles (e.g., different intralayer null models,
%     different numbers of nodes from layer-to-layer, or systems which are
%     both multiplex and longitudinal).  That is, this code is only a
%     starting point; it is by no means exhaustive.
%
%     By using this code, the user implicitly acknowledges that the authors
%     accept no liability associated with that use.  (What are you doing
%     with it anyway that might cause there to be a potential liability?!?)

if nargin < 2 || isempty(gamma)
    gamma = 1;
end

if nargin < 3
    omega = 1;
end

if length(gamma) == 1
    gamma = repmat(gamma, T, 1);
end

ii=[]; jj=[]; vv=[];
ki=[]; kj=[]; kv=[];
twom = 0;
for s=1:T
    indx = (1:N)' + (s-1)*N;
    [i, j, v] = find(A{s});
    ii = [ii; indx(i)];
    jj = [jj; indx(j)];
    vv = [vv; v];
    k = sum(A{s});
    mm = sum(k);
    twom = twom + mm;
    ki = [ki; indx];
    kj = [kj; ones(N,1)*s];
    kv = [kv; k(:)./mm];
end
AA = sparse(ii, jj, vv, N*T, N*T);
K = sparse(ki, kj, kv, N*T, T);
clear ii jj vv ki kj kv
kvec = full(sum(AA));
AA = AA + omega*spdiags(ones(N*T,2),[-N,N],N*T,N*T);
OM = @(i) AA(:,i) - gamma(ceil(i/(N+eps)))*K(:,ceil(i/(N+eps)))*kvec(i);
twom = twom + 2*N*(T-1)*omega;
end
function [OM, twom] = multiord_directed(m, A, gamma, omega, N, T)
% MULTIORDDIRECTED returns the multilayer modularity matrix for ordered directed networks
%
% [B, twom] = MULTIORDDIRECTED(A, GAMMA, OMEGA, N, T) returns the multilayer
% Leicht-Newman modularity matrix for ordered directed networks.
%
%   Input: A: Cell array of NxN adjacency matrices for each layer of an
%          ordered directed multilayer network
%          gamma: intralayer resolution parameter
%          omega: interlayer coupling strength
%
%   Output: B: function handle where B(i) returns the ith column of
%          [NxT]x[NxT] flattened modularity tensor for the
%           multilayer network with uniform ordinal coupling (T is
%           the number of layers of the network)
%           twom: normalisation constant
%
%   Example of usage: [B,twom]=multiorddir_f(A,gamma,omega);
%          [S,Q]= genlouvain(B); % see iterated_genlouvain.m and
%          postprocess_ordinal_multilayer.m for how to improve output
%          multilayer partition
%          Q=Q/twom;
%          S=reshape(S,N,T);
%
%   [B,twom] = MULTIORDDIR_F(A,GAMMA, OMEGA) with A a cell array of square
%   matrices of equal size each representing an directed network "layer"
%   computes the Leicht-Newman multilayer modularity matrix Susing the
%   quality function described in Mucha et al. 2010, with intralayer
%   resolution parameter GAMMA, and with interlayer coupling OMEGA
%   connecting nearest-neighbor ordered layers. Once the mulilayer modularity
%   matrix is computed, optimization can be performed by the generalized
%   Louvain code GENLOUVAIN or ITERATED_GENLOUVAIN. The output B can be used
%   with other heuristics, provided the same mapping is used to go from the
%   multilayer tensor to the multilayer flattened matrix. That is, the
%   node-layer tuple (i,s) is mapped to i + (s-1)*N. [Note that we can
%   define a mapping between a multilayer partition S_m stored as an N by T
%   matrix and the corresponding flattened partition S stored as an NT by 1
%   vector. In particular S_m = reshape(S,N,T) and S = S_m(:).]
%
%   See also
%       genlouvain heuristics:      GENLOUVAIN, ITERATED_GENLOUVAIN
%       multilayer wrappers:        MULTICAT, MULTICATF, MULTIORD
%       other heuristics:           SPECTRAL23
%       Kernighan-Lin improvement:  KLNB
%
%   Notes:
%     The matrices in the cell array A are assumed to be square,
%     and of equal size.  These assumptions are not checked here.
%
%     For smaller systems, it is potentially more efficient (and easier) to
%     directly use the sparse quality/modularity matrix B in MULTIORD. For
%     large systems with undirected layer networks, use MULTIORD_F.
%
%     This code serves as a template and can be modified for situations
%     with other wrinkles (e.g., different intralayer null models,
%     different numbers of nodes from layer-to-layer, or systems which are
%     both multiplex and longitudinal).  That is, this code is only a
%     starting point; it is by no means exhaustive.
%
%     By using this code, the user implicitly acknowledges that the authors
%     accept no liability associated with that use.  (What are you doing
%     with it anyway that might cause there to be a potential liability?!?)

if nargin < 2 || isempty(gamma)
    gamma = 1;
end

if nargin < 3 || isempty(omega)
    omega = 1;
end

if length(gamma) == 1
    gamma = repmat(gamma,T,1);
end
m = zeros(T,1);
for i=1:T
    m(i) = sum(A{i}(:));
end
A = blkdiag(A{:});
kout = sum(A,1);
koutmat = sparse(1:(N*T), kron(1:T, ones(1,N)), kout);
kin = sum(A,2);
kinmat = sparse(1:(N*T), kron(1:T, ones(1,N)), kin);
A = (A+A')./2;
A = A + omega*spdiags(ones(N*T,2), [-N,N], N*T, N*T);

OM = @(i) A(:,i) - gamma(ceil(i./(N+eps))).*(kout(i).*kinmat(:,ceil(i./(N+eps)))+kin(i).*koutmat(:,ceil(i./(N+eps))))./(2*m(ceil(i./(N+eps))));
twom = sum(m) + omega*2*N*(T-1);
end
function [OM, twom] = multicat_undirected(m, A, gamma, omega, N, T)
% MULTICATUNDIRECTED returns the multilayer modularity matrix for unordered undirected networks
%
% [B, twom] = MULTICATUNDIRECTED(A, GAMMA, OMEGA, N, T) returns the multilayer
% Newman-Girvan modularity matrix for unordered undirected networks.
%
%   Input: A: Cell array of NxN adjacency matrices for each layer of an
%          unordered multilayer undirected network
%          gamma: intralayer resolution parameter
%          omega: interlayer coupling strength
%
%   Output: B: [NxT]x[NxT] function handle where B(i) returns the ith column
%           of the flattened modularity tensor for the
%           multilayer network with uniform categorical coupling (T is
%           the number of layers of the network)
%           twom: normalisation constant
%
%   Example of usage: [B,twom]=multicat_f(A,gamma,omega);
%          [S,Q]= genlouvain(B); % see iterated_genlouvain.m and
%          postprocess_categorical_multilayer.m for how to improve output
%          multilayer partition
%          Q=Q/twom;
%          S=reshape(S,N,T);
%
%   [B,twom] = MULTICAT(A,GAMMA, OMEGA) with A a cell array of square
%   symmetric matrices of equal size each representing an undirected network
%   "layer" computes the multilayer modularity matrix using the quality
%   function described in Mucha et al. 2010, with intralayer resolution
%   parameter GAMMA, and with interlayer coupling OMEGA connecting
%   all-to-all categorical layers. Once the mulilayer modularity matrix is
%   computed, optimization can be performed by the generalized Louvain code
%   GENLOUVAIN or ITERATED_GENLOUVAIN. The output B can be used with other
%   heuristics, provided the same mapping is used to go from the multilayer
%   tensor to the multilayer flattened matrix. That is, the node-layer tuple
%   (i,s) is mapped to i + (s-1)*N. [Note that we can define a mapping between
%   a multilayer partition S_m stored as an N by T matrix and the corresponding
%   flattened partition S stored as an NT by 1 vector. In particular
%   S_m = reshape(S,N,T) and S = S_m(:).]
%
%   Notes:
%     The matrices in the cell array A are assumed to be symmetric, square,
%     and of equal size.  These assumptions are not checked here.
%
%     For smaller systems, it is potentially more efficient (and easier) to
%     directly use the sparse quality/modularity matrix B, as in MULTICAT.
%
%     This code serves as a template and can be modified for situations
%     with other wrinkles (e.g., different intralayer null models,
%     different numbers of nodes from layer-to-layer, or systems which are
%     both multiplex and longitudinal).  That is, this code is only a
%     starting point; it is by no means exhaustive.
%
%     By using this code, the user implicitly acknowledges that the authors
%     accept no liability associated with that use.  (What are you doing
%     with it anyway that might cause there to be a potential liability?!?)

if nargin < 2 || isempty(gamma)
    gamma = 1;
end

if nargin < 3 || isempty(omega)
    omega = 1;
end

if length(gamma) == 1
    gamma = repmat(gamma, T, 1);
end

ii = []; jj = []; vv = [];
ki = []; kj = []; kv = [];
twom = 0;
for s=1:T
    indx = [1:N]' + (s-1)*N;
    [i, j, v] = find(A{s});
    ii = [ii; indx(i)];
    jj = [jj; indx(j)];
    vv = [vv; v];
    k = sum(A{s});
    mm = sum(k);
    ki = [ki; indx];
    kj = [kj; ones(N,1)*s];
    kv = [kv; k(:)./mm];
    twom = twom + sum(k);
end
AA = sparse(ii,jj,vv,N*T,N*T);
K=sparse(ki,kj,kv,N*T,T);
clear ii jj vv ki kj kv
kvec = full(sum(AA));
all2all = N*[(-T+1):-1,1:(T-1)];
AA = AA + omega*spdiags(ones(N*T, 2*T-2), all2all, N*T, N*T);
OM = @(i) AA(:,i) - gamma(ceil(i/(N+eps)))*K(:, ceil(i/(N+eps)))*kvec(i);
twom = twom + 2*N*(T-1)*T*omega;
end
function [OM, twom] = multicat_directed(m, A, gamma, omega, N, T)
% MULTICATDIRECTED returns the multilayer modularity matrix for unordered directed networks
%
% [B, twom] = MULTICATDIRECTED(A, GAMMA, OMEGA, N, T) returns the multilayer
% Leicht-Newman modularity matrix for unordered directed networks.
%
%   Input: A: Cell array of NxN adjacency matrices for each layer of a
%          categorical directed multilayer network
%          gamma: intralayer resolution parameter
%          omega: interlayer coupling strength
%
%   Output: B: function handle where B(i) returns the ith column of
%          [NxT]x[NxT] flattened modularity tensor for the
%           multilayer network with uniform ordinal coupling (T is
%           the number of layers of the network)
%           twom: normalisation constant
%
%   Example of usage: [B,twom]=multicatdir_f(A,gamma,omega);
%          [S,Q]= genlouvain(B); % see iterated_genlouvain.m and
%          postprocess_categorical_multilayer.m for how to improve output
%          multilayer partition
%          Q=Q/twom;
%          S=reshape(S,N,T);
%
%   [B,twom] = MULTICATDIR_F(A,GAMMA, OMEGA) with A a cell array of square
%   matrices of equal size each representing an directed network "layer"
%   computes the Leicht-Newman multilayer modularity matrix B using the
%   quality function described in Mucha et al. 2010, with intralayer
%   resolution parameter GAMMA, and with interlayer coupling OMEGA
%   connecting all-to-all categorical layers. Once the mulilayer modularity
%   matrix is computed, optimization can be performed by the generalized
%   Louvain code GENLOUVAIN or ITERATED_GENLOUVAIN. The output B can be used
%   with other heuristics, provided the same mapping is used to go from the
%   multilayer tensor to the multilayer flattened matrix. That is, the
%   node-layer tuple (i,s) is mapped to i + (s-1)*N. [Note that we can
%   define a mapping between a multilayer partition S_m stored as an N by T
%   matrix and the corresponding flattened partition S stored as an NT by 1
%   vector. In particular S_m = reshape(S,N,T) and S = S_m(:).]
%
%   Notes:
%     The matrices in the cell array A are assumed to be square,
%     and of equal size.  These assumptions are not checked here.
%
%     For smaller systems, it is potentially more efficient (and easier) to
%     directly use the sparse quality/modularity matrix B in MULTICAT. For
%     large systems with undirected layer networks, use MULTICAT_F.
%
%     This code serves as a template and can be modified for situations
%     with other wrinkles (e.g., different intralayer null models,
%     different numbers of nodes from layer-to-layer, or systems which are
%     both multiplex and longitudinal).  That is, this code is only a
%     starting point; it is by no means exhaustive.
%
%     By using this code, the user implicitly acknowledges that the authors
%     accept no liability associated with that use.  (What are you doing
%     with it anyway that might cause there to be a potential liability?!?)

if nargin < 2 || isempty(gamma)
    gamma = 1;
end

if nargin < 3 || isempty(omega)
    omega = 1;
end

if length(gamma) == 1
    gamma = repmat(gamma, T, 1);
end

m = zeros(T, 1);
for i=1:T
    m(i) = sum(A{i}(:));
end
A = blkdiag(A{:});
kout = sum(A,1);
koutmat = sparse(1:(N*T), kron(1:T, ones(1,N)), kout);
kin = sum(A,2);
kinmat = sparse(1:(N*T), kron(1:T, ones(1,N)), kin);
A = (A+A')./2;
all2all = N*[(-T+1):-1,1:(T-1)];
A = A + omega*spdiags(ones(N*T, 2*T-2), all2all, N*T, N*T);

OM = @(i) A(:,i) - gamma(ceil(i./(N+eps))).*(kout(i).*kinmat(:,ceil(i./(N+eps))) + kin(i).*koutmat(:, ceil(i./(N+eps))))./(2*m(ceil(i./(N+eps))));
twom = sum(m) + omega*2*N*(T-1);
end
function M = metanetwork(m, J, S)
% METANETWORK returns the new aggregated network (communities --> nodes)
%
% [B, twom] = METANETWORK(J, S) returns the new aggregated
% network (communities --> nodes)

PP = sparse(1:length(S), S, 1);
M = PP'*J*PP;
end
function Mi = metanetwork_i(m, J, i)
% METANETWORKI returns the ith column of the metanetwork
%
% [B, twom] = METANETWORKI(J, S) returns the ith column of
% the metanetwork. J is a function handle

ind = metanetwork_reduce('nodes',i);
for j=ind(:)'
    metanetwork_reduce('reduce',J(j));
end
Mi = metanetwork_reduce('return');
end

%% ¡props!

%%% ¡prop! 
LIMIT (parameter, SCALAR) is the maximum size of multilayer modularity matrix.
%%%% ¡default!
10000

%%% ¡prop! 
RANDORD (parameter, LOGICAL) is used to set randperm.
%%%% ¡default!
true

%%% ¡prop! 
RANDMOVE (parameter, LOGICAL) is the move function.
%%%% ¡default!
true

%%% ¡prop! 
GAMMA (parameter, SCALAR) is the resolution parameter.
%%%% ¡default!
1

%%% ¡prop! 
OMEGA (parameter, SCALAR) is the inter-layer coupling parameter.
%%%% ¡default!
1

%%% ¡prop! 
S0 (data, cvector) is the initial partition size of the multilayer modularity matrix.
%%%% ¡default!
[]

%%% ¡prop! 
OM (data, MATRIX) is the multilayer modularity matrix.
%%%% ¡default!
[]

%%% ¡prop! 
QUALITY_FUNCTION (data, MATRIX) is the multilayer modularity quality function.
%%%% ¡default!
[]

%% ¡tests!

%%% ¡excluded_props!
[MultilayerCommunity.PFM]

%%% ¡test!
%%%% ¡name!
MultiplexBU
%%%% ¡probability!
.01
%%%% ¡code!
A = rand(5, 5);
B = {A A};
g = MultiplexBU('B', B);

m_outside_g = MultilayerCommunity('G', g);
assert(~isempty(m_outside_g.get('M')), ...
    [BRAPH2.STR ':MultilayerCommunity:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'MultilayerCommunity');
assert(~isempty(m_inside_g.get('M')), ...
    [BRAPH2.STR ':MultilayerCommunity:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBUT
%%%% ¡probability!
.01
%%%% ¡code!
A = rand(5, 5);
B = {A A};
g = MultiplexBUT('B', B, 'THRESHOLDS', [0 1]);

m_outside_g = MultilayerCommunity('G', g);
assert(~isempty(m_outside_g.get('M')), ...
    [BRAPH2.STR ':MultilayerCommunity:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'MultilayerCommunity');
assert(~isempty(m_inside_g.get('M')), ...
    [BRAPH2.STR ':MultilayerCommunity:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultilayerBU
%%%% ¡probability!
.01
%%%% ¡code!
A11 = rand(5, 5);
A22 = rand(5, 5);
A12 = rand(size(A11, 1),size(A22, 2));
A21 = A12';
A = {A11 A12;
    A21 A22};
g = MultilayerBU('B', A);

m_outside_g = MultilayerCommunity('G', g);
assert(~isempty(m_outside_g.get('M')), ...
    [BRAPH2.STR ':MultilayerCommunity:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'MultilayerCommunity');
assert(~isempty(m_inside_g.get('M')), ...
    [BRAPH2.STR ':MultilayerCommunity:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])