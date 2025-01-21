function create_data_CON_MP_XLS(data_dir, random_seed)
%CREATE_DATA_CON_MP_XLS creates connectivity data
%
% CREATE_DATA_CON_MP_XLS() creates connectivity data in default folder 'Example
%  data CON MP XLS'.
%
% CREATE_DATA_CON_MP_XLS(DATA_DIR) creates connectivity data in DATA_DIR folder.
%
% CREATE_DATA_CON_MP_XLS(DATA_DIR, RANDOM_SEED) cretes connectivity data in
%  DATA_DIR folder with a specified RANDOM_SEED.
%
% See also create_data_con_mp_txt.

if nargin < 1
    data_dir = [fileparts(which('SubjectCON_MP')) filesep 'Example data CON_MP XLS'];
end

if nargin < 2
    random_seed = 'default';
end

if ~isfolder(data_dir)
    mkdir(data_dir);

    % Brain Atlas
    im_ba = ImporterBrainAtlasXLS('FILE', 'aal90_atlas.xlsx');
    ba = im_ba.get('BA');
    ex_ba = ExporterBrainAtlasXLS( ...
        'BA', ba, ...
        'FILE', [data_dir filesep() 'atlas.xlsx'] ...
        );
    ex_ba.get('SAVE')
    N = ba.get('BR_DICT').get('LENGTH');

    % saves RNG
    rng_settings_ = rng(); rng(random_seed)

    sex_options = {'Female' 'Male'};

    % Group 1
    % 5 modules of 18 nodes each
    % 3 modules of 30 nodes each

    % initialize values for the WS model
    K1 = [3 4 5 6 7];
    K2 = [4 5 7];
    beta1 = [0.02 0.1 0.3 0.5 0.8];
    beta2 = [0.1 0.3 0.8];

    % initialize the indices where the matrices will be placed
    indices1 = {1:18; 19:36; 37:54; 55:72; 73:90};
    indices2 = {1:30; 31:60; 61:90};

    gr1_name = 'CON_MP_Group_1_XLS';
    gr1_dir = [data_dir filesep() gr1_name];
    mkdir(gr1_dir);
    vois1 = [
        {{'Subject ID'} {'Age'} {'Sex'}}
        {{} {} cell2str(sex_options)}
        ];
    for i = 1:1:25 % subject number
        sub_id = ['SubjectCON_MP_' num2str(i)];

        % randomize the parameters
        K_temp = K1(randperm(length(K1)));
        beta_temp = beta1(randperm(length(beta1)));

        K_temp2 = K2(randperm(length(K2)));
        beta_temp2 = beta2(randperm(length(beta2)));

        % initialize matrix for the subject
        A_full1 = zeros(N);
        A_full2 = zeros(N);

        % loop over each module
        % layer 1
        for i_mod = 1:1:5
            A_full1(indices1{i_mod},indices1{i_mod}) = full(adjacency(WattsStrogatz(18, K_temp(i_mod), beta_temp(i_mod))));
        end
        % layer 2
        for i_mod = 1:1:3
            A_full2(indices2{i_mod},indices2{i_mod}) = full(adjacency(WattsStrogatz(30, K_temp2(i_mod), beta_temp2(i_mod))));
        end
        A_full1(1:length(A_full1)+1:numel(A_full1)) = 0;
        A_full2(1:length(A_full2)+1:numel(A_full2)) = 0;

        % make the adjacency matrix weighted
        r = 0 + (0.5 - 0) * rand(size(A_full1));
        diffA = A_full1 - r;
        A_full1(A_full1 ~= 0) = diffA(A_full1 ~= 0);
        r = 0 + (0.5 - 0) * rand(size(A_full2));
        diffA = A_full2 - r;
        A_full2(A_full2 ~= 0) = diffA(A_full2 ~= 0);

        % figure(1)
        % imshow(A_full1)
        % figure(2)
        % imshow(A_full2)

        writetable(array2table(A_full1), [gr1_dir filesep() sub_id '.1.xlsx'], 'WriteVariableNames', false)
        writetable(array2table(A_full2), [gr1_dir filesep() sub_id '.2.xlsx'], 'WriteVariableNames', false)

        % variables of interest
        vois1 = [vois1; {sub_id, randi(90), sex_options(randi(2))}];
    end
    writetable(table(vois1), [data_dir filesep() gr1_name '.vois.xlsx'], 'WriteVariableNames', false)

    % Group 2
    % 2 modules of 45 nodes each

    % initialize values for the WS model
    K1 = [3 7];
    beta1 = [0.02 0.85];

    % initialize the indices where the matrices will be placed
    indices1 = 1:1:45;
    indices2 = 46:1:90;
    indices = {indices1; indices2};

    gr2_name = 'CON_MP_Group_2_XLS';
    gr2_dir = [data_dir filesep() gr2_name];
    mkdir(gr2_dir);
    vois2 = [
        {{'Subject ID'} {'Age'} {'Sex'}}
        {{} {} cell2str(sex_options)}
        ];
    for i = 26:1:50
        sub_id = ['SubjectCON_MP_' num2str(i)];

        % randomize the parameters
        K_temp = K1(randperm(length(K1)));
        beta_temp = beta1(randperm(length(beta1)));

        % initialize matrix for the subject
        A_full1 = zeros(N);

        % loop over each module
        for i_mod = 1:1:2
            A_full1(indices{i_mod},indices{i_mod}) = full(adjacency(WattsStrogatz(45, K_temp(i_mod), beta_temp(i_mod))));
        end

        A_full1(1:length(A_full1)+1:numel(A_full1)) = 0;

        % make the adjacency matrix weighted
        r = 0 + (0.5 - 0)*rand(size(A_full1));
        diffA = A_full1 - r;
        A_full1(A_full1 ~= 0) = diffA(A_full1 ~= 0);

        % 40% of connections kept
        density = 40;
        A_full2 = A_full1;
        sorted_vector = sort(A_full2(:));
        index = round(length(sorted_vector) * (100 - density) / 100);
        if index == 0
            threshold = sorted_vector(1) - eps;
        elseif index >= length(sorted_vector)
            threshold = sorted_vector(end) + eps;
        else
            threshold = sorted_vector(index);
        end

        % Calculates thresholded graph
        A_full2(A_full2 < threshold) = 0;

        % figure(1)
        % imshow(A_full1)
        % figure(2)
        % imshow(A_full2)

        writetable(array2table(A_full1), [gr2_dir filesep() sub_id '.1.xlsx'], 'WriteVariableNames', false)
        writetable(array2table(A_full2), [gr2_dir filesep() sub_id '.2.xlsx'], 'WriteVariableNames', false)

        % variables of interest
        vois2 = [vois2; {sub_id, randi(90), sex_options(randi(2))}];
    end
    writetable(table(vois2), [data_dir filesep() gr2_name '.vois.xlsx'], 'WriteVariableNames', false)

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