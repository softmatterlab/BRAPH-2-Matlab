function create_data_NN_REG_ST_MM_TXT(data_dir, random_seed)
%CREATE_DATA_NN_REG_ST_MM_TXT creates multi-modality structural data for neural network regression analysis
%
% CREATE_DATA_NN_REG_ST_MM_TXT() creates multi-modality structural data in default folder 'Example
%  data NN REG ST TXT'.
%
% CREATE_DATA_NN_REG_ST_MM_TXT(DATA_DIR) creates multi-modality structural data in DATA_DIR folder.
%
% CREATE_DATA_NN_REG_ST_MM_TXT(DATA_DIR, RANDOM_SEED) cretes multi-modality structural data in
%  DATA_DIR folder with a specified RANDOM_SEED.
%
% See also create_data_nn_reg_st_mm_txt.

if nargin < 1
    data_dir = [fileparts(which('NNDataPoint_ST_MM_REG')) filesep 'Example data NN REG ST_MM TXT'];
end

if nargin < 2
    random_seed = 'default';
end

if ~isdir(data_dir)
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
    gr_name = 'ST_MM_Group_TXT';
    
    % Group 1
    N_subjects = 50;
    K11 = 4; % degree (mean node degree is 2K) - group 1 layer 1
    K12 = 5; % degree (mean node degree is 2K) - group 1 layer 2
    beta1 = 0.08; % Rewiring probability - group 1

    % Create the graphs
    h11 = WattsStrogatz(N, K11, beta1);
    h12 = WattsStrogatz(N, K12, beta1);

    % Extract the adjacency matrices
    A11 = full(adjacency(h11));
    A12 = full(adjacency(h12));
    A11(1:length(A11)+1:numel(A11)) = 1;
    A12(1:length(A12)+1:numel(A12)) = 1;

    % this is needed to make the matrices positive definite
    A11 = A11*transpose(A11);
    A12 = A12*transpose(A12);

    % These matrices will be covariance matrices
    % Specify the mean
    mu_gr11 = ones(1, length(A11));
    mu_gr12 = ones(1, length(A12));

    % Create time series
    R11 = mvnrnd(mu_gr11, A11, N_subjects);
    R12 = mvnrnd(mu_gr12, A12, N_subjects);

    % We need only positive values
    R11 = R11 + abs(min(min(R11)));
    R12 = R12 + abs(min(min(R12)));

    % The subjects will be saved in a table - Specify row and column names
    % row
    sub_Tags1 = strings(size(R11, 1), 1);
    for i_sub = 1:1:length(sub_Tags1)
        sub_Tags1(i_sub) = string(['sub_' num2str(i_sub)]);
    end
    label_Tags1 = strings(size(R11, 1), 1);
    for i_sub = 1:1:length(label_Tags1)
        label_Tags1(i_sub) = string(['Label ' num2str(i_sub)]);
    end
    note_Tags1 = strings(size(R11, 1), 1);
    for i_sub = 1:1:length(note_Tags1)
        note_Tags1(i_sub) = string(['Note ' num2str(i_sub)]);
    end

    % column
    reg_Tags = strings(1, size(R11,2) + 3);
    reg_Tags(1, 1) = 'ID';
    reg_Tags(1, 2) = 'Label';
    reg_Tags(1, 3) = 'Notes';
    for i_reg = 4:1:length(reg_Tags)
        reg_Tags(1, i_reg) = string(['Region_' num2str(i_reg-3)]);
    end

    % Create the table - Group 1
    R11 = [cellstr(sub_Tags1) cellstr(label_Tags1) cellstr(note_Tags1) num2cell(R11)];
    T_group11 = array2table(R11, 'VariableNames', reg_Tags);

    R12 = [cellstr(sub_Tags1) cellstr(label_Tags1) cellstr(note_Tags1) num2cell(R12)];
    T_group12 = array2table(R12, 'VariableNames', reg_Tags);

    % create the table
    gr_dir = [data_dir filesep() gr_name];
    mkdir(gr_dir)
    writetable(T_group11, [gr_dir filesep() 'ST_MM_Group_TXT.1.txt'], 'Delimiter', '	', 'WriteRowNames', true)
    writetable(T_group12, [gr_dir filesep() 'ST_MM_Group_TXT.2.txt'], 'Delimiter', '	', 'WriteRowNames', true)

    % variables of interest
    vois = [
        {{'Subject ID'} {'Age'} {'Sex'}}
        {{} {} {['{' sprintf(' ''%s'' ', sex_options{:}) '}']}}
        ];
    for i = 1:1:N_subjects
        vois = [vois; {sub_Tags1{i}, randi(90), sex_options(randi(2))}];
    end
    writetable(table(vois), [data_dir filesep() gr_name '.vois.txt'], 'Delimiter', '	', 'WriteVariableNames', false)

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