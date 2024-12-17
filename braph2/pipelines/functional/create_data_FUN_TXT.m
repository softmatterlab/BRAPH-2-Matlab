function create_data_FUN_TXT(data_dir, random_seed)
%CREATE_DATA_FUN_TXT creates functional data
%
% CREATE_DATA_FUN_TXT() creates functional data in default folder 'Example
%  data ST XLS'.
%
% CREATE_DATA_FUN_TXT(DATA_DIR) creates functional data in DATA_DIR folder.
%
% CREATE_DATA_FUN_TXT(DATA_DIR, RANDOM_SEED) cretes functional data in DATA_DIR
%  folder with a specified RANDOM_SEED.
%
% See also create_data_st_xls.

if nargin < 1
    data_dir = [fileparts(which('SubjectFUN')) filesep 'Example data FUN TXT'];
end

if nargin < 2
    random_seed = 'default';
end

if ~isfolder(data_dir)
    mkdir(data_dir);

    % Brain Atlas
    im_ba = ImporterBrainAtlasTXT('FILE', 'aal90_atlas.txt');
    ba = im_ba.get('BA');
    ex_ba = ExporterBrainAtlasTXT( ...
        'BA', ba, ...
        'FILE', [data_dir filesep() 'atlas.txt'] ...
        );
    ex_ba.get('SAVE')
    N = ba.get('BR_DICT').get('LENGTH');

    % saves RNG
    rng_settings_ = rng(); rng(random_seed)

    T = 200; % Length of the time series

    sex_options = {'Female' 'Male'};

    % Group 1 - 5 modules of 18 nodes each
    % initialize values for the WS model
    K1 = [3 4 5 6 7];
    beta1 = [0.02 0.1 0.3 0.5 0.8];
    % initialize the indices where the matrices will be placed
    indices1 = 1:1:18;
    indices2 = 19:1:36;
    indices3 = 37:1:54;
    indices4 = 55:1:72;
    indices5 = 73:1:90;
    indices = {indices1; indices2; indices3; indices4; indices5};
    gr1_name = 'FUN_Group_1_TXT';
    gr1_dir = [data_dir filesep() gr1_name];
    mkdir(gr1_dir);
    vois1 = [
        {{'Subject ID'} {'Age'} {'Sex'}}
        {{} {} {['{' sprintf(' ''%s'' ', sex_options{:}) '}']}}
        ];
    for i = 1:1:25 % subject number
        sub_id = ['SubjectFUN_' num2str(i)];

        % randomize the parameters
        K_temp = K1(randperm(length(K1)));
        beta_temp = beta1(randperm(length(beta1)));

        % initialize matrix for the subject
        A_full = zeros(N);

        % loop over each module
        for i_mod = 1:1:5
            A_full(indices{i_mod}, indices{i_mod}) = full(adjacency(WattsStrogatz(18, K_temp(i_mod), beta_temp(i_mod))));
        end
        A_full(1:length(A_full)+1:numel(A_full)) = 1;

        % this is needed to make the matrices positive definite
        A_full = A_full * transpose(A_full);
        % figure(1)
        % imshow(A_full)

        % This matrix will be covariance matrices for the two groups
        % Specify the mean
        mu_gr1 = ones(1, length(A_full));
        % calculate time series
        R1 = mvnrnd(mu_gr1, A_full, T);
        % Normalize the time series
        mean_R1 = mean(R1);
        std_R1 = std(R1);
        R1 = (R1 - mean(R1)) ./ std(R1);

        writetable(array2table(R1), [gr1_dir filesep() sub_id '.txt'], 'Delimiter', '\t', 'WriteVariableNames', false)

        % variables of interest
        vois1 = [vois1; {sub_id, randi(90), sex_options(randi(2))}];
    end
    writetable(table(vois1), [data_dir filesep() gr1_name '.vois.txt'], 'Delimiter', '\t', 'WriteVariableNames', false)

    % Group 2 - 2 modules of 45 nodes each
    % initialize values for the WS model
    K2 = [3 7];
    beta2 = [0.02 0.85];
    % initialize the indices where the matrices will be placed
    indices1 = 1:1:45;
    indices2 = 46:1:90;
    indices = {indices1; indices2};
    gr2_name = 'FUN_Group_2_TXT';
    gr2_dir = [data_dir filesep() gr2_name];
    mkdir(gr2_dir);
    vois2 = [
        {{'Subject ID'} {'Age'} {'Sex'}}
        {{} {} {['{' sprintf(' ''%s'' ', sex_options{:}) '}']}}
        ];
    for i = 26:1:50
        sub_id = ['SubjectFUN_' num2str(i)];

        % randomize the parameters
        K_temp = K2(randperm(length(K2)));
        beta_temp = beta2(randperm(length(beta2)));

        % initialize matrix for the subject
        A_full = zeros(N);

        % loop over each module
        for i_mod = 1:1:2
        A_full(indices{i_mod},indices{i_mod}) = full(adjacency(WattsStrogatz(45, K_temp(i_mod), beta_temp(i_mod))));
        end
        A_full(1:length(A_full)+1:numel(A_full)) = 1;

        % this is needed to make the matrices positive definite
        A_full = A_full * transpose(A_full);
        % figure(2)
        % imshow(A_full)

        % This matrix will be covariance matrices for the two groups
        % Specify the mean
        mu_gr2 = ones(1, length(A_full));

        % calculate time series
        R2 = mvnrnd(mu_gr2, A_full, T);

        % Normalize the time series
        mean_R2 = mean(R2);
        std_R2 = std(R2);
        R2 = (R2 - mean(R2)) ./ std(R2);

        writetable(array2table(R2), [gr2_dir filesep() 'SubjectFUN_' num2str(i) '.txt'], 'Delimiter', '\t', 'WriteVariableNames', false)

        % variables of interest
        vois2 = [vois2; {sub_id, randi(90), sex_options(randi(2))}];
    end
    writetable(table(vois2), [data_dir filesep() gr2_name '.vois.txt'], 'Delimiter', '\t', 'WriteVariableNames', false)

    % reset RNG
    rng(rng_settings_)
end
end

%%% ¡test_functions!
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
