function create_data_NN_CLA_ST_XLS(data_dir, random_seed)
%CREATE_DATA_NN_CLA_ST_XLS creates structural data for neural network classification analysis
%
% CREATE_DATA_NN_CLA_ST_XLS() creates structural data in default folder 'Example
%  data NN CLA FUN XLS'.
%
% CREATE_DATA_NN_CLA_ST_XLS(DATA_DIR) creates structural data in DATA_DIR folder.
%
% CREATE_DATA_NN_CLA_ST_XLS(DATA_DIR, RANDOM_SEED) cretes structural data in
%  DATA_DIR folder with a specified RANDOM_SEED.
%
% See also create_data_nn_cla_st_txt.

if nargin < 1
    data_dir = [fileparts(which('NNDataPoint_ST_CLA')) filesep 'Example data NN CLA ST XLS'];
end

if nargin < 2
    random_seed = 'default';
end

if ~isdir(data_dir)
    mkdir(data_dir);

    % Brain Atlas
    im_ba = ImporterBrainAtlasXLS('FILE', 'destrieux_atlas.xlsx');
    ba = im_ba.get('BA');
    ex_ba = ExporterBrainAtlasXLS( ...
        'BA', ba, ...
        'FILE', [data_dir filesep() 'atlas.xlsx'] ...
        );
    ex_ba.get('SAVE')
    N = ba.get('BR_DICT').get('LENGTH');

    % saves RNG
    rng_settings_ = rng(); rng(random_seed)

    N_subjects = 50;

    sex_options = {'Female' 'Male'};

    % Group 1
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

    % Group 2
    K2 = K1; % degree (mean node degree is 2K) - group 2
    beta2 = 0.7; % Rewiring probability - group 2

    h2 = WattsStrogatz(N, K2, beta2);
    % figure(2)
    % plot(h2, 'NodeColor',[1 0 0], 'EdgeColor',[0 0 0], 'EdgeAlpha',0.1, 'Layout','circle');
    % title(['Group 2: Graph with $N = $ ' num2str(N) ...
    %     ' nodes, $K = $ ' num2str(K2) ', and $\beta = $ ' num2str(beta2)], ...
    %     'Interpreter','latex')
    % axis equal

    A2 = full(adjacency(h1)); A2(1:length(A2)+1:numel(A2)) = 1;
    A2 = A2*transpose(A2);
    % imshow(A2)

    mu_gr2 = ones(1, length(A2));
    R2 = mvnrnd(mu_gr2, A2, N_subjects);
    mean_R2 = mean(R2); std_R2 = std(R2); R2 = (R2 - mean(R2)) ./ std(R2);
    R2 = R2 + abs(min(min(R2)));

    % row
    sub_Tags2 = strings(size(R1, 1), 1);
    for i_sub = 1:1:length(sub_Tags2)
        sub_Tags2(i_sub) = string(['sub_' num2str(i_sub + N_subjects)]);
    end
    label_Tags2 = strings(size(R1, 1), 1);
    for i_sub = 1:1:length(label_Tags2)
        label_Tags2(i_sub) = string(['Label ' num2str(i_sub + N_subjects)]);
    end
    note_Tags2 = strings(size(R1, 1), 1);
    for i_sub = 1:1:length(note_Tags2)
        note_Tags2(i_sub) = string(['Note ' num2str(i_sub + N_subjects)]);
    end

    writetable(array2table([cellstr(sub_Tags2) cellstr(label_Tags2) cellstr(note_Tags2) num2cell(R2)], 'VariableNames', reg_Tags), [data_dir filesep() 'ST_Group_2.xlsx'], 'WriteRowNames', true)

    % variables of interest
    vois2 = [
        {{'Subject ID'} {'Age'} {'Sex'}}
        {{} {} cell2str(sex_options)}
        ];
    for i = 1:1:N_subjects
        vois2 = [vois2; {sub_Tags2{i}, randi(90), sex_options(randi(2))}];
    end
    writetable(table(vois2), [data_dir filesep() 'ST_Group_2.vois.xlsx'], 'WriteVariableNames', false)

    % Group 3
    K3 = K1; % degree (mean node degree is 2K) - group 2
    beta3 = 0.9; % Rewiring probability - group 2

    h3 = WattsStrogatz(N, K3, beta3);
    % figure(3)
    % plot(h3, 'NodeColor',[1 0 0], 'EdgeColor',[0 0 0], 'EdgeAlpha',0.1, 'Layout','circle');
    % title(['Group 3: Graph with $N = $ ' num2str(N) ...
    %     ' nodes, $K = $ ' num2str(K3) ', and $\beta = $ ' num2str(beta3)], ...
    %     'Interpreter','latex')
    % axis equal

    A3 = full(adjacency(h1)); A3(1:length(A3)+1:numel(A3)) = 1;
    A3 = A3*transpose(A3);
    % imshow(A2)

    mu_gr3 = ones(1, length(A3));
    R3 = mvnrnd(mu_gr3, A3, N_subjects);
    mean_R3 = mean(R3); std_R3 = std(R3); R3 = (R3 - mean(R3)) ./ std(R3);
    R3 = R3 + abs(min(min(R3)));

    % row
    sub_Tags3 = strings(size(R1, 1), 1);
    for i_sub = 1:1:length(sub_Tags3)
        sub_Tags3(i_sub) = string(['sub_' num2str(i_sub + 2*N_subjects)]);
    end
    label_Tags3 = strings(size(R1, 1), 1);
    for i_sub = 1:1:length(label_Tags3)
        label_Tags3(i_sub) = string(['Label ' num2str(i_sub + 2*N_subjects)]);
    end
    note_Tags3 = strings(size(R1, 1), 1);
    for i_sub = 1:1:length(note_Tags3)
        note_Tags3(i_sub) = string(['Note ' num2str(i_sub + 2*N_subjects)]);
    end

    writetable(array2table([cellstr(sub_Tags3) cellstr(label_Tags3) cellstr(note_Tags3) num2cell(R3)], 'VariableNames', reg_Tags), [data_dir filesep() 'ST_Group_3.xlsx'], 'WriteRowNames', true)

    % variables of interest
    vois3 = [
        {{'Subject ID'} {'Age'} {'Sex'}}
        {{} {} cell2str(sex_options)}
        ];
    for i = 1:1:N_subjects
        vois3 = [vois3; {sub_Tags3{i}, randi(90), sex_options(randi(2))}];
    end
    writetable(table(vois3), [data_dir filesep() 'ST_Group_3.vois.xlsx'], 'WriteVariableNames', false)

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
