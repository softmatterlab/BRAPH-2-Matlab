function create_data_NN_REG_ST_XLS(data_dir, random_seed)
%CREATE_DATA_NN_REG_ST_XLS creates strucutural data for neural network regression analysis
%
% CREATE_DATA_NN_REG_ST_XLS() creates strucutural data in default folder 'Example
%  data NN REG ST XLS'.
%
% CREATE_DATA_NN_REG_ST_XLS(DATA_DIR) creates strucutural data in DATA_DIR folder.
%
% CREATE_DATA_NN_REG_ST_XLS(DATA_DIR, RANDOM_SEED) cretes strucutural data in
%  DATA_DIR folder with a specified RANDOM_SEED.
%
% See also create_data_nn_reg_st_txt.

if nargin < 1
    data_dir = [fileparts(which('NNDataPoint_ST_REG')) filesep 'Example data NN REG ST XLS'];
end

if nargin < 2
    random_seed = 'default';
end

if ~isdir(data_dir)
    mkdir(data_dir);

    % Brain Atlas
    im_ba = ImporterBrainAtlasXLS('FILE', 'desikan_atlas.xlsx');
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
    N_subjects = 50;
    K1 = 4; % degree (mean node degree is 2K) - group 1
    beta1 = 0.08; % Rewiring probability - group 1

    h1 = WattsStrogatz(N, K1, beta1); % create graph
    % figure(1)
    % plot(h1, 'NodeColor',[1 0 0], 'EdgeColor',[0 0 0], 'EdgeAlpha',0.1, 'Layout','circle');
    % title(['Group 1: Graph with $N = $ ' num2str(N) ...
    %     ' nodes, $K = $ ' num2str(K1) ', and $\beta = $ ' num2str(beta1)], ...
    %     'Interpreter','latex')
    % axis equal

    A1 = full(adjacency(h1)); A1(1:length(A1)+1:numel(A1)) = 1; % Extract the adjacency matrix
    A1 = A1*transpose(A1); % this is needed to make the matrices positive definite
    % imshow(A1)

    % These matrices will be covariance matrices for the two groups
    mu_gr1 = ones(1, length(A1)); % Specify the mean
    R1 = mvnrnd(mu_gr1, A1, N_subjects); % Create time series for the two groups
    mean_R1 = mean(R1); std_R1 = std(R1); R1 = (R1 - mean(R1)) ./ std(R1); % Normalize the time series
    R1 = R1 + abs(min(min(R1))); % We need only positive values

    % row
    sub_Tags1 = strings(size(R1, 1), 1);
    for i_sub = 1:1:length(sub_Tags1)
        sub_Tags1(i_sub) = string(['sub_' num2str(i_sub)]);
    end
    label_Tags1 = strings(size(R1, 1), 1);
    for i_sub = 1:1:length(label_Tags1)
        label_Tags1(i_sub) = string(['Label ' num2str(i_sub)]);
    end
    note_Tags1 = strings(size(R1, 1), 1);
    for i_sub = 1:1:length(note_Tags1)
        note_Tags1(i_sub) = string(['Note ' num2str(i_sub)]);
    end

    % column
    reg_Tags = strings(1, size(R1,2) + 3);
    reg_Tags(1, 1) = 'ID';
    reg_Tags(1, 2) = 'Label';
    reg_Tags(1, 3) = 'Notes';
    for i_reg = 4:1:length(reg_Tags)
        reg_Tags(1, i_reg) = string(['Region_' num2str(i_reg - 3)]);
    end

    % create the table
    writetable(array2table([cellstr(sub_Tags1) cellstr(label_Tags1) cellstr(note_Tags1) num2cell(R1)], 'VariableNames', reg_Tags), [data_dir filesep() 'ST_Group_1.xlsx'], 'WriteRowNames', true)

    % variables of interest
    vois1 = [
        {{'Subject ID'} {'Age'} {'Sex'}}
        {{} {} cell2str(sex_options)}
        ];
    for i = 1:1:N_subjects
        vois1 = [vois1; {sub_Tags1{i}, randi(90), sex_options(randi(2))}];
    end
    writetable(table(vois1), [data_dir filesep() 'ST_Group_1.vois.xlsx'], 'WriteVariableNames', false)
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
