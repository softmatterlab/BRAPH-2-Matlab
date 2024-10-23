%% ¡header!
CommunityStructure < Measure (m, community structure) is the graph Community Structure.

%%% ¡description!
The Community Structure (CommunityStructure) of a graph is a subdivision of the network into 
non-overlapping groups of nodes which maximizes the number of within group 
edges, and minimizes the number of between group edges.

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
CommunityStructure.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
CommunityStructure.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
CommunityStructure.RULE
%%%% ¡title!
Community Structure algorithm (louvain, newman, fixed)

%%% ¡prop!
%%%% ¡id!
CommunityStructure.GAMMA
%%%% ¡title!
Gamma (resolution) parameter

%%% ¡prop!
%%%% ¡id!
CommunityStructure.M0
%%%% ¡title!
Initial community affiliation vector (optional).

%%% ¡prop!
%%%% ¡id!
CommunityStructure.LOUVAIN_OM
%%%% ¡title!
Custom objective matrix (Louvain, optional)

%%% ¡prop!
%%%% ¡id!
CommunityStructure.OM_TYPE
%%%% ¡title!
The objective-function type algorithm (Louvain)

%%% ¡prop!
%%%% ¡id!
CommunityStructure.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
CommunityStructure.M
%%%% ¡title!
CommunityStructure

%%% ¡prop!
%%%% ¡id!
CommunityStructure.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
CommunityStructure.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
CommunityStructure.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Community Structure.
%%%% ¡default!
'CommunityStructure'

%%% ¡prop!
NAME (constant, string) is the name of the Community Structure.
%%%% ¡default!
'Community Structure'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the Community Structure.
%%%% ¡default!
'The Community Structure (CommunityStructure) of a graph is a subdivision of the network into non-overlapping groups of nodes which maximizes the number of within group edges, and minimizes the number of between group edges.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Community Structure.
%%%% ¡settings!
'CommunityStructure'

%%% ¡prop!
ID (data, string) is a few-letter code of the Community Structure.
%%%% ¡default!
'CommunityStructure ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the community structure.
%%%% ¡default!
'Community Structure label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the Community Structure.
%%%% ¡default!
'Community Structure notes'

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
{'GraphWU' 'GraphWD' 'GraphBU' 'GraphBD' 'MultigraphBUD' 'MultigraphBUT'} ;

%%% ¡prop!
M (result, cell) is the Community Structure.
%%%% ¡calculate!
g = m.get('G');  % graph from measure class
A = g.get('A');
L = g.get('LAYERNUMBER');
N = g.get('NODENUMBER');
community_structure = cell(L, 1);
gamma = m.get('GAMMA');
community_structure_algorithm = m.get('RULE');

q_function = {};
for li = 1:1:L
    Aii = A{li, li};
    [community_structure(li), q_function{li}] =  community(m, Aii, N(li), gamma, community_structure_algorithm);
end
m.set('QUALITY_FUNCTION', q_function);
value = community_structure;

%%%% ¡calculate_callbacks!
function [comm_str, quality_function] = community(m, A, N, gamma, community_structure_algorithm)
A = A;
N = N;
gamma = gamma;
community_structure_algorithm = community_structure_algorithm;
    switch lower(community_structure_algorithm)
        case {'fixed'}
            M0 = m.get('M0');
            assert(isequal(size(M0, 2), size(1:N, 2)), ...
                    [BRAPH2.STR ':CommunityStructure:' BRAPH2.WRONG_INPUT], ...
                    ['M0 initial community affiliation vector must have the same length than the number of nodes' ...
                    '(' tostring(size(1:N, 2)) ') while its length is ' tostring(size(M0, 2))])
            community_structure = {M0'};
            quality_function = 1;

        case {'newman'}  % Newman algorithm
            directionality_type = g.get('DIRECTIONALITY_TYPE', g.get('LAYERNUMBER'));
            if directionality_type(1, 1) == Graph.UNDIRECTED  % directed graphs
                n_perm = randperm(N);  % randomly permute order of nodes
                A = A(n_perm, n_perm);  % DB: use permuted matrix for subsequent analysis
                Ki = sum(A, 1);  % in-degree
                Ko = sum(A, 2);  % out-degree
                mo = sum(Ki);  % number of edges
                b = A - gamma*(Ko*Ki).'/mo;
                B = b+b.';  % directed modularity matrix
                Ci = ones(N,1);  % community indices
                cn = 1;  % number of communities
                U = [1 0];  % array of unexamined communites

                ind = 1:N;
                Bg = B;
                Ng = N;

                while U(1)  % examine community U(1)
                    [V, D] = eig(Bg);
                    [d1, i1] = max(real(diag(D)));  % most positive eigenvalue of Bg
                    v1 = V(:,i1);  % corresponding eigenvector
                    S = ones(Ng,1);
                    S(v1 < 0) = -1;
                    q = S.' * Bg * S;  % contribution to modularity

                    if q > 1e-10  % contribution positive: U(1) is divisible
                        qmax = q;  % maximal contribution to modularity
                        Bg(logical(eye(Ng))) = 0;  % Bg is modified, to enable fine-tuning
                        indg = ones(Ng, 1);  % array of unmoved indices
                        Sit = S;
                        while any(indg)  % iterative fine-tuning
                            Qit = qmax - 4*Sit.*(Bg*Sit);  % this line is equivalent to:
                            qmax = max(Qit.*indg);  % for i=1:Ng
                            imax = (Qit==qmax);  % Sit(i)=-Sit(i);
                            Sit(imax) = -Sit(imax);  % Qit(i)=Sit.'*Bg*Sit;
                            indg(imax) = nan;  % Sit(i)=-Sit(i);
                            if qmax > q  % end
                                q = qmax;
                                S = Sit;
                            end
                        end

                        if abs(sum(S)) == Ng  % unsuccessful splitting of U(1)
                            U(1) = [];
                        else
                            cn = cn + 1;
                            Ci(ind(S == 1)) = U(1);  % split old U(1) into new U(1) and into cn
                            Ci(ind(S == -1)) = cn;
                            U = [cn, U];
                        end
                    else  % contribution nonpositive: U(1) is indivisible
                        U(1) = [];
                    end

                    ind = find(Ci==U(1));  % indices of unexamined community U(1)
                    bg = B(ind, ind);
                    Bg = bg - diag(sum(bg));  % modularity matrix for U(1)
                    Ng = length(ind);  % number of vertices in U(1)
                end

                s = Ci(:, ones(1, N));  % compute modularity
                Q =~ (s-s.').*B/(2*mo);
                Q = sum(Q(:));
                Ci_corrected = zeros(N, 1);  % initialize Ci_corrected
                Ci_corrected(n_perm) = Ci;  % return order of nodes to the order used at the input stage.
                Ci = Ci_corrected;  % output corrected community assignments

                quality_function = Q;   % save normalized quality function/modularity
                community_structure = {Ci};

            else  % undirected graphs
                n_perm = randperm(N);  % randomly permute order of nodes
                A = A(n_perm, n_perm);  % DB: use permuted matrix for subsequent analysis
                K = sum(A);  % degree
                mo = sum(K);  % number of edges (each undirected edge is counted twice)
                B = A - gamma*(K.'*K)/mo;  % modularity matrix
                Ci = ones(N, 1);  % community indices
                cn = 1;  % number of communities
                U = [1 0];  % array of unexamined communites

                ind = 1:N;
                Bg = B;
                Ng = N;

                while U(1)  % examine community U(1)
                    [V, D] = eig(Bg);
                    [d1, i1] = max(real(diag(D)));  % maximal positive (real part of) eigenvalue of Bg
                    v1 = V(:,i1);  % corresponding eigenvector

                    S = ones(Ng,1);
                    S(v1<0) = -1;
                    q = S.'*Bg*S;  % contribution to modularity

                    if q > 1e-10  % contribution positive: U(1) is divisible
                        qmax = q;  % maximal contribution to modularity
                        Bg(logical(eye(Ng))) = 0;  % Bg is modified, to enable fine-tuning
                        indg = ones(Ng, 1);  % array of unmoved indices
                        Sit = S;
                        while any(indg)  % iterative fine-tuning
                            Qit = qmax-  4*Sit.*(Bg*Sit);  % this line is equivalent to:
                            qmax = max(Qit.*indg);  % for i=1:Ng
                            imax = (Qit == qmax);  % Sit(i)=-Sit(i);
                            Sit(imax) = -Sit(imax);  % Qit(i)=Sit.'*Bg*Sit;
                            indg(imax) = nan;  % Sit(i)=-Sit(i);
                            if qmax > q  % end
                                q = qmax;
                                S = Sit;
                            end
                        end

                        if abs(sum(S)) == Ng  % unsuccessful splitting of U(1)
                            U(1) = [];
                        else
                            cn = cn + 1;
                            Ci(ind(S==1)) = U(1);  % split old U(1) into new U(1) and into cn
                            Ci(ind(S==-1)) = cn;
                            U = [cn, U];
                        end
                    else  % contribution nonpositive: U(1) is indivisible
                        U(1) = [];
                    end

                    ind = find(Ci==U(1));  % indices of unexamined community U(1)
                    bg = B(ind, ind);
                    Bg = bg-diag(sum(bg));  % modularity matrix for U(1)
                    Ng = length(ind);  % number of vertices in U(1)
                end

                s = Ci(:,ones(1, N));  % compute modularity
                Q =~ (s-s.').*B/mo;
                Q = sum(Q(:));
                Ci_corrected = zeros(N, 1);  % initialize Ci_corrected
                Ci_corrected(n_perm) = Ci;  % return order of nodes to the order used at the input stage.
                Ci = Ci_corrected;  % output corrected community assignments

                quality_function = Q; % save normalized quality function/modularity
                community_structure = {Ci};
            end

        otherwise  % {'Louvain'}  % Louvain algorithm

            M0 = m.get('M0');  % initial community affiliation vector
            OM = m.get('LOUVAIN_OM');  % custom objective matrix
            type_OM =  m.get('OM_TYPE');  % objective-function type
            W = double(A);  % convert to double format
            s = sum(sum(W));  % get sum of edges

            if isempty(M0)
                M0 = 1:N;
            else
                assert(isequal(size(M0, 2), size(1:N, 2)), ...
                    [BRAPH2.STR ':CommunityStructure:' BRAPH2.WRONG_INPUT], ...
                    ['M0 initial community affiliation vector must have the same length than the number of nodes' ...
                    '(' tostring(size(1:N, 2)) ') while its length is ' tostring(size(M0, 2))])
            end
            [~,~,Mb] = unique(M0);
            M = Mb;

            if isempty(OM)
                % calculate OM according to type_B

                switch lower(type_OM)
                    case {'potts'}
                        assert(all(all(W == logical(W))), ...
                            [BRAPH2.STR ':CommunityStructure:' BRAPH2.WRONG_INPUT], ...
                            ['Potts-model Hamiltonian requires a binary adjacency matrix' ...
                            'while it is ' tostring(W)])
                        OM =  W - gamma*(~W);
                    otherwise  % {'modularity'} default
                        OM = W - gamma*(sum(W, 2)*sum(W, 1))/s;
                end
            else  % OM matrix exists
                assert(isequal(size(W), size(OM)), ...
                    [BRAPH2.STR ':CommunityStructure:' BRAPH2.WRONG_INPUT], ...
                    ['OM matrix must have the same size than the adjacency matrix' ...
                    '(' tostring(size(W)) ') while its size is ' tostring(size(OM))])
            end

            OM = (OM+OM.')/2;  % symmetrize modularity matrix
            Hnm = zeros(N, N);  % node-to-module degree
            for mo = 1:max(Mb)  % loop over modules
                Hnm(:, mo) = sum(OM(:, Mb== mo), 2);
            end
            H = sum(Hnm, 2);  % node degree
            Hm = sum(Hnm, 1);  % module degree

            Q0 = -inf;
            Q = sum(OM(bsxfun(@eq, M0, M0.')))/s;  % compute modularity
            first_iteration = true;
            n = N;
            while Q-Q0 > 1e-10
                flag = true;  % flag for within-hierarchy search
                while flag
                    flag = false;
                    for u = randperm(n)  % loop over all nodes in random order
                        ma = Mb(u);  % current module of u
                        dQ = Hnm(u, :)- Hnm(u,ma) + OM(u, u);
                        dQ(ma) = 0;  % (line above) algorithm condition

                        [max_dQ, mb] = max(dQ);  % maximal increase in modularity and corresponding module
                        if max_dQ > 1e-10  % if maximal increase is positive
                            flag = true;
                            Mb(u) = mb;  % reassign module

                            Hnm(:,mb) = Hnm(:,mb) + OM(:,u);  % change node-to-module strengths
                            Hnm(:,ma) = Hnm(:,ma) - OM(:,u);
                            Hm(mb) = Hm(mb) + H(u);  % change module strengths
                            Hm(ma) = Hm(ma) - H(u);
                        end
                    end
                end
                [~,~,Mb] = unique(Mb);  % new module assignments

                M0 = M;
                if first_iteration
                    M = Mb;
                    first_iteration = false;
                else
                    for u = 1:n  % loop through initial module assignments
                        M(M0==u) = Mb(u);  % assign new modules
                    end
                end

                n = max(Mb);  % new number of modules
                B1 = zeros(n);  % new weighted matrix
                for u = 1:n
                    for v = u:n
                        bm = sum(sum(OM(Mb==u,Mb==v)));  % pool weights of nodes in same module
                        B1(u,v) = bm;
                        B1(v,u) = bm;
                    end
                end
                OM = B1;

                Mb = 1:n;  % initial module assignments
                Hnm = OM;  % node-to-module strength
                H = sum(OM);  % node strength
                Hm = H;  % module strength

                Q0 = Q;
                Q = trace(OM)/s;  % compute modularity
            end
            quality_function = Q;  % save normalized quality function/modularity
            community_structure = {M};
    end
    comm_str = community_structure;
end


%% ¡props!

%%% ¡prop! 
RULE (parameter, option)
%%%% ¡settings!
{ 'louvain' 'newman' 'fixed'}
%%%% ¡default!
'louvain'

%%% ¡prop! 
GAMMA (parameter, SCALAR) is the resolution parameter.
%%%% ¡default!
1

%%% ¡prop! 
M0 (data, rvector) is the initial community affiliation vector.
%%%% ¡default!
[]

%%% ¡prop! 
LOUVAIN_OM (data, MATRIX) is the custom objective matrix (Louvain).
%%%% ¡default!
[]

%%% ¡prop! 
OM_TYPE (data, OPTION) is the objective-function type algorithm (Louvain).
%%%% ¡settings!
{'modularity' 'potts' 'negative_sym' 'negative_asym'}
%%%% ¡default!
'modularity'

%%% ¡prop! 
QUALITY_FUNCTION (metadata, CELL)

%% ¡tests!

%%% ¡excluded_props!
[CommunityStructure.PFM]

%%% ¡test!
%%%% ¡name!
GraphBU
%%%% ¡probability!
.01
%%%% ¡code!

B = [1 0 1 1
     0 0 0 0
     1 0 1 0
     1 0 0 1];

g = GraphBU('B', B);

m_outside_g = CommunityStructure('G', g);
m_outside_g_M = m_outside_g.get('M');
assert(iscell(m_outside_g_M) && size(m_outside_g_M{1}, 1) == 4, ...
    [BRAPH2.STR ':CommunityStructure:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'CommunityStructure');
m_inside_g_M = m_inside_g.get('M');
assert(iscell(m_inside_g_M) && size(m_inside_g_M{1}, 1) == 4, ...
    [BRAPH2.STR ':CommunityStructure:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
GraphBU fixed input
%%%% ¡probability!
.01
%%%% ¡code!

B = [1 0 1 1
     0 0 0 0
     1 0 1 0
     1 0 0 1];

 g = GraphBU('B', B);

m_outside_g = CommunityStructure('G', g);
m_outside_g.set('RULE', 'fixed', 'M0', [1 0 1 1]);
m_outside_g_M = m_outside_g.get('M');
assert(iscell(m_outside_g_M) && size(m_outside_g_M{1}, 1) == 4, ...
    [BRAPH2.STR ':CommunityStructure:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'CommunityStructure');
m_inside_g.set('RULE', 'fixed', 'M0', [1 0 1 1]);
m_inside_g_M = m_inside_g.get('M');
assert(iscell(m_inside_g_M) && size(m_inside_g_M{1}, 1) == 4, ...
    [BRAPH2.STR ':CommunityStructure:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])