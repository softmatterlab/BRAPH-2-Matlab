function create_data_CON_TXT(data_dir, random_seed)
%CREATE_DATA_CON_TXT creates connectivity data
%
% CREATE_DATA_CON_TXT() creates connectivity data in default folder 'Example
%  data CON TXT'.
%
% CREATE_DATA_CON_TXT(DATA_DIR) creates connectivity data in DATA_DIR folder.
%
% CREATE_DATA_CON_TXT(DATA_DIR, RANDOM_SEED) cretes connectivity data in
%  DATA_DIR folder with a specified RANDOM_SEED.
%
% See also create_data_con_xls.

if nargin < 1
    data_dir = [fileparts(which('SubjectCON')) filesep 'Example data CON TXT'];
end

if nargin < 2
    random_seed = 'default';
end

if ~isfolder(data_dir)
    mkdir(data_dir);

    % Brain Atlas
    im_ba = ImporterBrainAtlasTXT('FILE', 'desikan_atlas.txt');
    ba = im_ba.get('BA');
    ex_ba = ExporterBrainAtlasTXT( ...
        'BA', ba, ...
        'FILE', [data_dir filesep() 'atlas.txt'] ...
        );
    ex_ba.get('SAVE')
    N = ba.get('BR_DICT').get('LENGTH');

    % saves RNG
    rng_settings_ = rng(); rng(random_seed)

    sex_options = {'Female' 'Male'};

    % Group 1
    K1 = 2; % degree (mean node degree is 2K) - group 1
    beta1 = 0.3; % Rewiring probability - group 1
    gr1_name = 'CON_Group_1_TXT';
    gr1_dir = [data_dir filesep() gr1_name];
    mkdir(gr1_dir);
    vois1 = [
        {{'Subject ID'} {'Age'} {'Sex'}}
        {{} {} {['{' sprintf(' ''%s'' ', sex_options{:}) '}']}}
        ];
    for i = 1:1:25 % subject number
        sub_id = ['SubjectCON_' num2str(i)];

        h1 = WattsStrogatz(N, K1, beta1); % create two WS graph
        % figure(1) % Plot the two graphs to double-check
        % plot(h1, 'NodeColor',[1 0 0], 'EdgeColor',[0 0 0], 'EdgeAlpha',0.1, 'Layout','circle');
        % title(['Group 1: Graph with $N = $ ' num2str(N_nodes) ...
        %     ' nodes, $K = $ ' num2str(K1) ', and $\beta = $ ' num2str(beta1)], ...
        %     'Interpreter','latex')
        % axis equal

        A1 = full(adjacency(h1)); A1(1:length(A1)+1:numel(A1)) = 0; % extract the adjacency matrix
        r = 0 + (0.5 - 0)*rand(size(A1)); diffA = A1 - r; A1(A1 ~= 0) = diffA(A1 ~= 0); % make the adjacency matrix weighted
        A1 = max(A1, transpose(A1)); % make the adjacency matrix symmetric

        writetable(array2table(A1), [gr1_dir filesep() sub_id '.txt'], 'Delimiter', '\t', 'WriteVariableNames', false)

        % variables of interest
        vois1 = [vois1; {sub_id, randi(90), sex_options(randi(2))}];
    end
    writetable(table(vois1), [data_dir filesep() gr1_name '.vois.txt'], 'Delimiter', '\t', 'WriteVariableNames', false)

    % Group 2
    K2 = 2; % degree (mean node degree is 2K) - group 2
    beta2 = 0.85; % Rewiring probability - group 2
    gr2_name = 'CON_Group_2_TXT';
    gr2_dir = [data_dir filesep() gr2_name];
    mkdir(gr2_dir);
    vois2 = [
        {{'Subject ID'} {'Age'} {'Sex'}}
        {{} {} {['{' sprintf(' ''%s'' ', sex_options{:}) '}']}}
        ];
    for i = 26:1:50
        sub_id = ['SubjectCON_' num2str(i)];

        h2 = WattsStrogatz(N, K2, beta2);
        % figure(2)
        % plot(h2, 'NodeColor',[1 0 0], 'EdgeColor',[0 0 0], 'EdgeAlpha',0.1, 'Layout','circle');
        % title(['Group 2: Graph with $N = $ ' num2str(N_nodes) ...
        %     ' nodes, $K = $ ' num2str(K2) ', and $\beta = $ ' num2str(beta2)], ...
        %     'Interpreter','latex')
        % axis equal

        A2 = full(adjacency(h2)); A2(1:length(A2)+1:numel(A2)) = 0;
        r = 0 + (0.5 - 0)*rand(size(A2)); diffA = A2 - r; A2(A2 ~= 0) = diffA(A2 ~= 0);
        A2 = max(A2, transpose(A2)); % make the adjacency matrix symmetric       

        writetable(array2table(A2), [gr2_dir filesep() 'SubjectCON_' num2str(i) '.txt'], 'Delimiter', '\t', 'WriteVariableNames', false)

        % variables of interest
        vois2 = [vois2; {sub_id, randi(90), sex_options(randi(2))}];
    end
    writetable(table(vois2), [data_dir filesep() gr2_name '.vois.txt'], 'Delimiter', '\t', 'WriteVariableNames', false)

    % reset RNG
    rng(rng_settings_)
end
end

function h = WattsStrogatz(N,K,beta)
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
