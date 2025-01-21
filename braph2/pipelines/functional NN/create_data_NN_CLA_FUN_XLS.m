function create_data_NN_CLA_FUN_XLS(data_dir, random_seed)
%CREATE_DATA_NN_CLA_FUN_XLS creates functional data for neural network classification analysis
%
% CREATE_DATA_NN_CLA_FUN_XLS() creates functional data in default folder 'Example
%  data NN CLA FUN XLS'.
%
% CREATE_DATA_NN_CLA_FUN_XLS(DATA_DIR) creates functional data in DATA_DIR folder.
%
% CREATE_DATA_NN_CLA_FUN_XLS(DATA_DIR, RANDOM_SEED) cretes functional data in
%  DATA_DIR folder with a specified RANDOM_SEED.
%
% See also create_data_nn_cla_fun_txt.

if nargin < 1
    data_dir = [fileparts(which('NNDataPoint_FUN_CLA')) filesep 'Example data NN CLA FUN XLS'];
end

if nargin < 2
    random_seed = 'default';
end

if ~isdir(data_dir)
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

    %% Specify the network parameters for the two groups
    N_nodes = 90; % AAL atlas
    
    %% Specify length of time series 
    N_tslength = 200;
    
    %% Specify number of subjects
    N_groups = 10;
    
    %% Group 1
    gr1_ts = cell(1, N_groups);
    gr1_name = 'FUN_Group_1_XLS';
    gr1_dir = [data_dir filesep() gr1_name];
    mkdir(gr1_dir);
    vois1 = [
    {{'Subject ID'} {'Age'} {'Sex'}}
    {{} {} cell2str(sex_options)}
    ];
    for i_gr = 1:1:10 % subject number
        sub_id = ['SubjectFUN_' num2str(i_gr)];
        % create WS graphs with random beta
            % initialize values for the WS model
        N_module = randi([1 8], 1);
        %N_module = 8;
        num_module(i_gr) = N_module;
        K_temp = 1:1:1+N_module-1;
        K = K_temp(randperm(N_module));
        beta = rand([1 N_module]);
        
        % initialize the indices where the matrices will be placed
        L_indice = floor(N_nodes/N_module);
        for j  = 1:1:N_module
            if j ~= N_module
                indices{j} = 1+(j-1)*L_indice:1+(j-1)*L_indice+L_indice-1;
            else
                indices{j} = 1+(j-1)*L_indice:N_nodes;
            end
        end
    
        % initialize matrix for the subject
        A_full = zeros(N_nodes);
    
        % loop over each module
        for i_mod = 1:1:N_module
            A_full(indices{i_mod},indices{i_mod}) = full(adjacency(WattsStrogatz(length(indices{i_mod}), K(i_mod), beta(i_mod))));
        end
        A_full(1:length(A_full)+1:numel(A_full)) = 1;
    
        % this is needed to make the matrices positive definite
        A_full = A_full*transpose(A_full);
    
        % This matrix will be covariance matrices for the group
        % Specify the mean
        mu_gr = ones(1, length(A_full));
    
        % calculate time series
        R = mvnrnd(mu_gr, A_full, N_tslength);
    
        % Normalize the time series
        mean_R = mean(R);
        std_R = std(R);
        R = (R - mean(R)) ./ std(R);
    
        % place in the array
        gr1_ts{1, i_gr} = R;
        
        writetable(array2table(R), [gr1_dir filesep() sub_id '.xlsx'], 'WriteVariableNames', false)

        % variables of interest
        vois1 = [vois1; {sub_id, randi(90), sex_options(randi(2))}];

    end
    writetable(table(vois1), [data_dir filesep() gr1_name '.vois.xlsx'], 'WriteVariableNames', false)

    %% Group 2
    gr2_ts = cell(1, N_groups);
    gr2_name = 'FUN_Group_2_XLS';
    gr2_dir = [data_dir filesep() gr2_name];
    mkdir(gr2_dir);
    vois2 = [
    {{'Subject ID'} {'Age'} {'Sex'}}
    {{} {} cell2str(sex_options)}
    ];
    for i_gr = 11:1:20 % subject number
        sub_id = ['SubjectFUN_' num2str(i_gr)];
        % create WS graphs with random beta
            % initialize values for the WS model
        N_module = randi([1 8], 1);
        %N_module = 8;
        num_module(i_gr) = N_module;
        K_temp = 1:1:1+N_module-1;
        K = K_temp(randperm(N_module));
        beta = rand([1 N_module]);
        
        % initialize the indices where the matrices will be placed
        L_indice = floor(N_nodes/N_module);
        for j  = 1:1:N_module
            if j ~= N_module
                indices{j} = 1+(j-1)*L_indice:1+(j-1)*L_indice+L_indice-1;
            else
                indices{j} = 1+(j-1)*L_indice:N_nodes;
            end
        end
    
        % initialize matrix for the subject
        A_full = zeros(N_nodes);
    
        % loop over each module
        for i_mod = 1:1:N_module
            A_full(indices{i_mod},indices{i_mod}) = full(adjacency(WattsStrogatz(length(indices{i_mod}), K(i_mod), beta(i_mod))));
        end
        A_full(1:length(A_full)+1:numel(A_full)) = 1;
    
        % this is needed to make the matrices positive definite
        A_full = A_full*transpose(A_full);
    
        % This matrix will be covariance matrices for the group
        % Specify the mean
        mu_gr = ones(1, length(A_full));
    
        % calculate time series
        R = mvnrnd(mu_gr, A_full, N_tslength);
    
        % Normalize the time series
        mean_R = mean(R);
        std_R = std(R);
        R = (R - mean(R)) ./ std(R);
    
        % place in the array
        gr2_ts{1, i_gr} = R;
        
        writetable(array2table(R), [gr2_dir filesep() sub_id '.xlsx'], 'WriteVariableNames', false)

        % variables of interest
        vois2 = [vois2; {sub_id, randi(90), sex_options(randi(2))}];

    end
    writetable(table(vois2), [data_dir filesep() gr2_name '.vois.xlsx'], 'WriteVariableNames', false)

    %% Group 3
    gr3_ts = cell(1, N_groups);
    gr3_name = 'FUN_Group_3_XLS';
    gr3_dir = [data_dir filesep() gr3_name];
    mkdir(gr3_dir);
    vois3 = [
    {{'Subject ID'} {'Age'} {'Sex'}}
    {{} {} cell2str(sex_options)}
    ];
    for i_gr = 21:1:30  % subject number
        sub_id = ['SubjectFUN_' num2str(i_gr)];
        % create WS graphs with random beta
            % initialize values for the WS model
        N_module = randi([1 8], 1);
        %N_module = 8;
        num_module(i_gr) = N_module;
        K_temp = 1:1:1+N_module-1;
        K = K_temp(randperm(N_module));
        beta = rand([1 N_module]);
        
        % initialize the indices where the matrices will be placed
        L_indice = floor(N_nodes/N_module);
        for j  = 1:1:N_module
            if j ~= N_module
                indices{j} = 1+(j-1)*L_indice:1+(j-1)*L_indice+L_indice-1;
            else
                indices{j} = 1+(j-1)*L_indice:N_nodes;
            end
        end
    
        % initialize matrix for the subject
        A_full = zeros(N_nodes);
    
        % loop over each module
        for i_mod = 1:1:N_module
            A_full(indices{i_mod},indices{i_mod}) = full(adjacency(WattsStrogatz(length(indices{i_mod}), K(i_mod), beta(i_mod))));
        end
        A_full(1:length(A_full)+1:numel(A_full)) = 1;
    
        % this is needed to make the matrices positive definite
        A_full = A_full*transpose(A_full);
    
        % This matrix will be covariance matrices for the group
        % Specify the mean
        mu_gr = ones(1, length(A_full));
    
        % calculate time series
        R = mvnrnd(mu_gr, A_full, N_tslength);
    
        % Normalize the time series
        mean_R = mean(R);
        std_R = std(R);
        R = (R - mean(R)) ./ std(R);
    
        % place in the array
        gr3_ts{1, i_gr} = R;
        
        writetable(array2table(R), [gr3_dir filesep() sub_id '.xlsx'], 'WriteVariableNames', false)

        % variables of interest
        vois3 = [vois3; {sub_id, randi(90), sex_options(randi(2))}];

    end
    writetable(table(vois3), [data_dir filesep() gr3_name '.vois.xlsx'], 'WriteVariableNames', false)

    % reset RNG
    rng(rng_settings_)
end
end

%%% ¡test_functions!
function h = WattsStrogatz(N, K, beta)
% H = WattsStrogatz(N,K,beta) returns a Watts-Strogatz model graph with N
% nodes, N*K edges, mean node degree 2*K, and rewiring probability beta.
%
% beta = 0 is a ring lattice, and beta = 1 is a random graph.

% Connect each node to its K next and previous neighbors. This constructs
% indices for a ring lattice.
    s = repelem((1:N)', 1, K);
    t = s + repmat(1:K, N, 1);
    t = mod(t - 1, N) + 1;
    
    % Rewire the target node of each edge with probability beta
    for source = 1:N
        switchEdge = rand(K, 1) < beta;
        
        newTargets = rand(N, 1);
        newTargets(source) = 0;
        newTargets(s(t == source)) = 0;
        newTargets(t(source, ~switchEdge)) = 0;
        
        [~, ind] = sort(newTargets, 'descend');
        t(source, switchEdge) = ind(1:nnz(switchEdge));
    end
    
    h = graph(s,t);
end
