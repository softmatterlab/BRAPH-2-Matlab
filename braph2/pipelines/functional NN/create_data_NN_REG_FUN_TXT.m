function create_data_NN_REG_FUN_TXT(data_dir, random_seed)
%CREATE_DATA_NN_REG_FUN_TXT creates functional data for neural network regression analysis
%
% CREATE_DATA_NN_REG_FUN_TXT() creates functional data in default folder 'Example
%  data NN REG FUN TXT'.
%
% CREATE_DATA_NN_REG_FUN_TXT(DATA_DIR) creates functional data in DATA_DIR folder.
%
% CREATE_DATA_NN_REG_FUN_TXT(DATA_DIR, RANDOM_SEED) cretes functional data in
%  DATA_DIR folder with a specified RANDOM_SEED.
%
% See also create_data_nn_reg_fun_xls.

if nargin < 1
    data_dir = [fileparts(which('NNDataPoint_FUN_REG')) filesep 'Example data NN REG FUN TXT'];
end

if nargin < 2
    random_seed = 'default';
end

if ~isdir(data_dir)
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

    sex_options = {'Female' 'Male'};

    %% Specify the network parameters
    N_nodes = 90; % AAL atlas
    
    %% Specify length of time series 
    N_tslength = 200;
    
    %% Specify number of subjects
    N_groups = 20;
    
    % Group 
    K = 2; % degree (mean node degree is 2K)
    gr_name = 'FUN_Group_TXT';
    gr_dir = [data_dir filesep() gr_name];
    mkdir(gr_dir);
    vois = [
        {{'Subject ID'} {'Age'} {'Sex'}}
        {{} {} {['{' sprintf(' ''%s'' ', sex_options{:}) '}']}}
        ];
    %% Group properties
    % random N modules
    gr_ts = cell(1, N_groups);
    beta_age = 0.3; % Rewiring probability

    for i_gr = 1:1:N_groups % subject number
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
        gr_ts{1, i_gr} = R;
        
        writetable(array2table(R), [gr_dir filesep() sub_id '.txt'], 'Delimiter', '\t', 'WriteVariableNames', false)

        % variables of interest
        beta_age(i_gr) = rand(1);
        age_upperBound = 80;
        age_lowerBound = 50;
        age = age_lowerBound + beta_age(i_gr) *(age_upperBound - age_lowerBound);
        vois = [vois; {sub_id, age, sex_options(randi(2))}];
    end
    writetable(table(vois), [data_dir filesep() gr_name '.vois.txt'], 'Delimiter', '\t', 'WriteVariableNames', false)

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
