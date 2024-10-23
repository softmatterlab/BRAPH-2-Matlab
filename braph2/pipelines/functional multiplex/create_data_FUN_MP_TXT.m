function create_data_FUN_MP_TXT(data_dir, random_seed)
%CREATE_DATA_FUN_MP_TXT creates functional data
%
% CREATE_DATA_FUN_MP_TXT() creates functional data in default folder 'Example
%  data ST TXT'.
%
% CREATE_DATA_FUN_MP_TXT(DATA_DIR) creates functional data in DATA_DIR folder.
%
% CREATE_DATA_FUN_MP_TXT(DATA_DIR, RANDOM_SEED) cretes functional data in DATA_DIR
%  folder with a specified RANDOM_SEED.
%
% See also create_data_st_mp_xls.

if nargin < 1
    data_dir = [fileparts(which('SubjectFUN_MP')) filesep 'Example data FUN_MP TXT'];
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

    % Group 1 properties
    % 5 modules of 18 nodes each
    % 4 modules: 2 of 22 nodes each and 2 of 23 nodes each
    % 3 modules of 30 nodes each

    % initialize values for the WS model
    K1 = [3 4 5 6 7];
    K2 = [3 4 5 6];
    K3 = [4 5 7];
    beta1 = [0.02 0.1 0.3 0.5 0.8];
    beta2 = [0.02 0.1 0.3 0.4];
    beta3 = [0.1 0.3 0.8];

    % initialize the indices where the matrices will be placed
    indices1 = {1:18; 19:36; 37:54; 55:72; 73:90};
    indices2 = {1:22; 23:44; 45:67; 68:90};
    indices3 = {1:30; 31:60; 61:90};

    gr1_name = 'FUN_MP_Group_1_TXT';
    gr1_dir = [data_dir filesep() gr1_name];
    mkdir(gr1_dir);
    vois1 = [
        {{'Subject ID'} {'Age'} {'Sex'}}
        {{} {} {['{' sprintf(' ''%s'' ', sex_options{:}) '}']}}
        ];
    for i = 1:1:10 % subject number
        sub_id = ['SubjectFUN_MP_' num2str(i)];

        % randomize the parameters
        K_temp = K1(randperm(length(K1)));
        beta_temp = beta1(randperm(length(beta1)));

        K_temp2 = K2(randperm(length(K2)));
        beta_temp2 = beta2(randperm(length(beta2)));

        K_temp3 = K3(randperm(length(K3)));
        beta_temp3 = beta3(randperm(length(beta3)));

        % initialize matrix for the subject
        A_full1 = zeros(N);
        A_full2 = zeros(N);
        A_full3 = zeros(N);

        % loop over each module
        % layer 1
        for i_mod = 1:1:5
            A_full1(indices1{i_mod},indices1{i_mod}) = full(adjacency(WattsStrogatz(18, K_temp(i_mod), beta_temp(i_mod))));
        end
        % layer 2
        for i_mod = 1:1:2
            A_full2(indices2{i_mod},indices2{i_mod}) = full(adjacency(WattsStrogatz(22, K_temp2(i_mod), beta_temp2(i_mod))));
        end
        for i_mod = 3:1:4
            A_full2(indices2{i_mod},indices2{i_mod}) = full(adjacency(WattsStrogatz(23, K_temp2(i_mod), beta_temp2(i_mod))));
        end
        % layer 3
        for i_mod = 1:1:3
            A_full3(indices3{i_mod},indices3{i_mod}) = full(adjacency(WattsStrogatz(30, K_temp3(i_mod), beta_temp3(i_mod))));
        end
        A_full1(1:length(A_full1)+1:numel(A_full1)) = 1;
        A_full2(1:length(A_full2)+1:numel(A_full2)) = 1;
        A_full3(1:length(A_full3)+1:numel(A_full3)) = 1;

        % this is needed to make the matrices positive definite
        A_full1 = A_full1*transpose(A_full1);
        A_full2 = A_full2*transpose(A_full2);
        A_full3 = A_full3*transpose(A_full3);

        % figure(1)
        % imshow(A_full1)
        % figure(2)
        % imshow(A_full2)
        % figure(3)
        % imshow(A_full3)

        % This matrix will be covariance matrices for the two groups
        % Specify the mean
        mu_gr11 = ones(1, length(A_full1));
        mu_gr12 = ones(1, length(A_full2));
        mu_gr13 = ones(1, length(A_full3));

        % calculate time series
        R11 = mvnrnd(mu_gr11, A_full1, T);
        R12 = mvnrnd(mu_gr12, A_full2, T);
        R13 = mvnrnd(mu_gr13, A_full3, T);

        % Normalize the time series
        R11 = (R11 - mean(R11)) ./ std(R11);
        R12 = (R12 - mean(R12)) ./ std(R12);
        R13 = (R13 - mean(R13)) ./ std(R13);

        writetable(array2table(R11), [gr1_dir filesep() sub_id '.1.txt'], 'Delimiter', '\t', 'WriteVariableNames', false)
        writetable(array2table(R12), [gr1_dir filesep() sub_id '.2.txt'], 'Delimiter', '\t', 'WriteVariableNames', false)
        writetable(array2table(R13), [gr1_dir filesep() sub_id '.3.txt'], 'Delimiter', '\t', 'WriteVariableNames', false)

        % variables of interest
        vois1 = [vois1; {sub_id, randi(90), sex_options(randi(2))}];
    end
    writetable(table(vois1), [data_dir filesep() gr1_name '.vois.txt'], 'Delimiter', '\t', 'WriteVariableNames', false)

    % Group 2
    % 2 modules of 45 nodes each

    % initialize values for the WS model
    K2 = [3 7];
    beta2 = [0.02 0.85];

    % initialize the indices where the matrices will be placed
    indices1 = 1:1:45;
    indices2 = 46:1:90;
    indices = {indices1; indices2};

    gr2_name = 'FUN_MP_Group_2_TXT';
    gr2_dir = [data_dir filesep() gr2_name];
    mkdir(gr2_dir);
    vois2 = [
        {{'Subject ID'} {'Age'} {'Sex'}}
        {{} {} {['{' sprintf(' ''%s'' ', sex_options{:}) '}']}}
        ];
    for i = 51:1:60
        sub_id = ['SubjectFUN_MP_' num2str(i)];

        % randomize the parameters
        K_temp = K2(randperm(length(K2)));
        beta_temp = beta2(randperm(length(beta2)));

        % initialize matrix for the subject
        A_full1 = zeros(N);

        % loop over each module
        for i_mod = 1:1:2
            A_full1(indices{i_mod},indices{i_mod}) = full(adjacency(WattsStrogatz(45, K_temp(i_mod), beta_temp(i_mod))));
        end
        A_full1(1:length(A_full1)+1:numel(A_full1)) = 1;

        % this is needed to make the matrices positive definite
        A_full1 = A_full1*transpose(A_full1);

        % 70% of connections kept
        density = 70;
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
        A_full2 = A_full2*transpose(A_full2);

        % 40% of connections kept
        density = 40;
        A_full3 = A_full1;
        sorted_vector = sort(A_full3(:));
        index = round(length(sorted_vector) * (100 - density) / 100);
        if index == 0
            threshold = sorted_vector(1) - eps;
        elseif index >= length(sorted_vector)
            threshold = sorted_vector(end) + eps;
        else
            threshold = sorted_vector(index);
        end
        % Calculates thresholded graph
        A_full3(A_full3 < threshold) = 0;
        A_full3 = A_full3*transpose(A_full3);

        % figure(1)
        % imshow(A_full1)
        % figure(2)
        % imshow(A_full2)
        % figure(3)
        % imshow(A_full3)

        % This matrix will be covariance matrices for the two groups
        % Specify the mean
        mu_gr21 = ones(1, length(A_full1));
        mu_gr22 = ones(1, length(A_full2));
        mu_gr23 = ones(1, length(A_full3));

        % calculate time series
        R21 = mvnrnd(mu_gr21, A_full1, T);
        R22 = mvnrnd(mu_gr22, A_full2, T);
        R23 = mvnrnd(mu_gr23, A_full3, T);

        % Normalize the time series
        R21 = (R21 - mean(R21)) ./ std(R21);
        R22 = (R22 - mean(R22)) ./ std(R22);
        R23 = (R23 - mean(R23)) ./ std(R23);

        writetable(array2table(R21), [gr2_dir filesep() sub_id '.1.txt'], 'Delimiter', '\t', 'WriteVariableNames', false)
        writetable(array2table(R22), [gr2_dir filesep() sub_id '.2.txt'], 'Delimiter', '\t', 'WriteVariableNames', false)
        writetable(array2table(R23), [gr2_dir filesep() sub_id '.3.txt'], 'Delimiter', '\t', 'WriteVariableNames', false)

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
