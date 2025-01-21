function create_data_NN_REG_CON_FUN_MP_XLS(data_dir, random_seed)
%CREATE_DATA_CON_FUN_MP_NN_XLS creates connectivity-functional data for neural network regression analysis
%
% CREATE_DATA_CON_FUN_MP_NN_XLS() creates connectivity-functional data in default folder 'Example
%  data NN CLA CON FUN MP XLS'.
%
% CREATE_DATA_CON_FUN_MP_XLS(DATA_DIR) creates connectivity-functional data in DATA_DIR folder.
%
% CREATE_DATA_CON_FUN_MP_XLS(DATA_DIR, RANDOM_SEED) cretes connectivity-functional data in
%  DATA_DIR folder with a specified RANDOM_SEED.
%
% See also create_data_nn_reg_con_fun_mp_txt.

if nargin < 1
    data_dir = [fileparts(which('NNDataPoint_CON_FUN_MP_REG')) filesep 'Example data NN REG CON_FUN_MP XLS'];
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

    % Group 
    N_subjects = 20;
    N_tslength = 200;
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
    gr1_ts1 = cell(1, N_subjects); % layer 1
    gr1_ts2 = cell(1, N_subjects); % layer 2
    gr_name = 'CON_FUN_MP_Group_XLS';

    vois = [
        {{'Subject ID'} {'Age'} {'Sex'}}
        {{} {} cell2str(sex_options)}
        ];
    sub_id = cell(1, N_subjects);
    for i = 1:1:N_subjects % subject number
        sub_id(i) = {['SubjectCON_FUN_MP_' num2str(i)]};

        % randomize the parameters
        K_temp = K1(randperm(length(K1)));
        beta_temp = beta1(randperm(length(beta1)));
        % initialize matrix for the subject
        A_full1 = zeros(N);
        % loop over each module
        for i_mod = 1:1:5
            A_full1(indices{i_mod},indices{i_mod}) = full(adjacency(WattsStrogatz(18, K_temp(i_mod), beta_temp(i_mod))));
        end
        A_full1(1:length(A_full1)+1:numel(A_full1)) = 1;
        
        % this is needed to make the matrices positive definite
        A_full1 = A_full1*transpose(A_full1);
        % 10% of connections kept
        density = 10;
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
        % This matrix will be covariance matrices for the two groups
        % Specify the mean
        mu_gr11 = ones(1, length(A_full1));
        % calculate time series
        R11 = mvnrnd(mu_gr11, A_full1, N_tslength);
        % Normalize the time series
        mean_R11 = mean(R11);
        std_R11 = std(R11);
        R11 = (R11 - mean_R11) ./ std_R11;
        % place in the array
        gr1_ts1{1, i} = R11;
        gr1_ts2{1, i} = A_full2;

        % variables of interest
        age_upperBound = 80;
        age_lowerBound = 50;
        age = age_lowerBound + beta_temp(2)*(age_upperBound - age_lowerBound);
        vois = [vois; {sub_id{i}, age, sex_options(randi(2))}];   
    end
    
    % Create the tables - functional layer
    tables_gr11 = cell(size(gr1_ts1));
    mkdir([data_dir filesep() 'Functional' filesep() gr_name]);
    for i_tab = 1:1:N_subjects
        T_gr11 = array2table(gr1_ts1{i_tab});
        tables_gr11{i_tab} = T_gr11;
        file_name = [data_dir filesep() 'Functional' filesep() gr_name filesep() sub_id{i_tab} '.xlsx'];
        writetable(T_gr11, file_name, 'WriteRowNames', false, 'WriteVariableNames', false)
    end
    
    % Create the tables - connectivity-functional layer
    tables_gr12 = cell(size(gr1_ts2));
    mkdir([data_dir filesep() 'Connectivity' filesep() gr_name]);
    for i_tab = 1:1:N_subjects
        T_gr12 = array2table(gr1_ts2{i_tab});
        tables_gr12{i_tab} = T_gr12;
        file_name = [data_dir filesep() 'Connectivity' filesep() gr_name filesep() sub_id{i_tab} '.xlsx'];
        writetable(T_gr12, file_name, 'WriteRowNames', false, 'WriteVariableNames', false)
    end
    
    writetable(table(vois), [data_dir filesep() 'Connectivity' filesep() gr_name '.vois.xlsx'], 'WriteVariableNames', false)
    writetable(table(vois), [data_dir filesep() 'Functional' filesep() gr_name '.vois.xlsx'], 'WriteVariableNames', false)
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
