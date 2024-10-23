function create_data_ST_MP_TXT(data_dir, random_seed)
%CREATE_DATA_ST_MP_TXT creates structural data
%
% CREATE_DATA_ST_MP_TXT() creates structural data in default folder 'Example
%  data ST MP TXT'.
%
% CREATE_DATA_ST_MP_TXT(DATA_DIR) creates structural data in DATA_DIR folder.
%
% CREATE_DATA_ST_MP_TXT(DATA_DIR, RANDOM_SEED) cretes structural data in DATA_DIR
%  folder with a specified RANDOM_SEED.
%
% See also create_data_st_mp_xls.

if nargin < 1
    data_dir = [fileparts(which('SubjectST_MP')) filesep 'Example data ST_MP TXT'];
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

    N_subjects = 50;

    sex_options = {'Female' 'Male'};

    % Group 1
    K11 = 4; % degree (mean node degree is 2K) - group 1 layer 1
    K12 = 5; % degree (mean node degree is 2K) - group 1 layer 2
    beta1 = 0.08; % Rewiring probability - group 1

    % Create the graphs
    h11 = WattsStrogatz(N, K11, beta1);
    h12 = WattsStrogatz(N, K12, beta1);
    % figure(1)
    % plot(h11, 'NodeColor',[1 0 0], 'EdgeColor',[0 0 0], 'EdgeAlpha',0.1, 'Layout','circle');
    % title(['Group 1: Graph with $N = $ ' num2str(N_nodes) ...
    %     ' nodes, $K = $ ' num2str(K11) ', and $\beta = $ ' num2str(beta1)], ...
    %     'Interpreter','latex')
    % axis equal
    % 
    % figure(2)
    % plot(h12, 'NodeColor',[1 0 0], 'EdgeColor',[0 0 0], 'EdgeAlpha',0.1, 'Layout','circle');
    % title(['Group 1: Graph with $N = $ ' num2str(N_nodes) ...
    %     ' nodes, $K = $ ' num2str(K12) ', and $\beta = $ ' num2str(beta1)], ...
    %     'Interpreter','latex')
    % axis equal

    % Extract the adjacency matrices
    A11 = full(adjacency(h11));
    A12 = full(adjacency(h12));
    A11(1:length(A11)+1:numel(A11)) = 1;
    A12(1:length(A12)+1:numel(A12)) = 1;

    % this is needed to make the matrices positive definite
    A11 = A11*transpose(A11);
    A12 = A12*transpose(A12);
    % figure(1)
    % imshow(A11)
    % figure(2)
    % imshow(A12)

    % These matrices will be covariance matrices
    % Specify the mean
    mu_gr11 = ones(1, length(A11));
    mu_gr12 = ones(1, length(A12));

    % Create time series
    R11 = mvnrnd(mu_gr11, A11, N_subjects);
    R12 = mvnrnd(mu_gr12, A12, N_subjects);

    % % Normalize the time series
    % mean_R11 = mean(R11);
    % std_R11 = std(R11);
    % R11 = (R11 - mean(R11)) ./ std(R11);
    % 
    % mean_R12 = mean(R12);
    % std_R12 = std(R12);
    % R12 = (R12 - mean(R12)) ./ std(R12);

    % We need only positive values
    R11 = R11 + abs(min(min(R11)));
    R12 = R12 + abs(min(min(R12)));

    % The subjects will be saved in a table - Specify row and column names
    % row
    sub_Tags1 = strings(size(R11,1), 1);
    for i_sub = 1:1:length(sub_Tags1)
        sub_Tags1(i_sub) = string(['sub_' num2str(i_sub)]);
    end
    label_Tags1 = strings(size(R11,1), 1);
    for i_sub = 1:1:length(label_Tags1)
        label_Tags1(i_sub) = string(['Label ' num2str(i_sub)]);
    end
    note_Tags1 = strings(size(R11,1), 1);
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
    gr1_dir = [data_dir filesep() 'ST_MP_Group_1_TXT'];
    mkdir(gr1_dir)
    writetable(T_group11, [gr1_dir filesep() 'ST_MP_Group_1_TXT.1.txt'], 'Delimiter', '\t', 'WriteRowNames', true)
    writetable(T_group12, [gr1_dir filesep() 'ST_MP_Group_1_TXT.2.txt'], 'Delimiter', '\t', 'WriteRowNames', true)

    % variables of interest
    vois1 = [
        {{'Subject ID'} {'Age'} {'Sex'}}
        {{} {} {['{' sprintf(' ''%s'' ', sex_options{:}) '}']}}
        ];
    for i = 1:1:N_subjects
        vois1 = [vois1; {sub_Tags1{i}, randi(90), sex_options(randi(2))}];
    end
    writetable(table(vois1), [data_dir filesep() 'ST_MP_Group_1_TXT.vois.txt'], 'Delimiter', '\t', 'WriteVariableNames', false)

    % Group 2
    K21 = K11; % degree (mean node degree is 2K) - group 2 layer 1
    K22 = 2; % degree (mean node degree is 2K) - group 2 layer 2
    beta2 = 0.9; % Rewiring probability - group 2

    % Create the graphs
    h21 = WattsStrogatz(N, K21, beta2);
    h22 = WattsStrogatz(N, K22, beta2);
    % figure(3)
    % plot(h21, 'NodeColor',[1 0 0], 'EdgeColor',[0 0 0], 'EdgeAlpha',0.1, 'Layout','circle');
    % title(['Group 2: Graph with $N = $ ' num2str(N_nodes) ...
    %     ' nodes, $K = $ ' num2str(K21) ', and $\beta = $ ' num2str(beta2)], ...
    %     'Interpreter','latex')
    % axis equal
    % 
    % figure(4)
    % plot(h22, 'NodeColor',[1 0 0], 'EdgeColor',[0 0 0], 'EdgeAlpha',0.1, 'Layout','circle');
    % title(['Group 2: Graph with $N = $ ' num2str(N_nodes) ...
    %     ' nodes, $K = $ ' num2str(K22) ', and $\beta = $ ' num2str(beta2)], ...
    %     'Interpreter','latex')
    % axis equal

    % Extract the adjacency matrices 
    A21 = full(adjacency(h21));
    A22 = full(adjacency(h22));
    A21(1:length(A21)+1:numel(A21)) = 1;
    A22(1:length(A22)+1:numel(A22)) = 1;

    % this is needed to make the matrices positive definite
    A21 = A21*transpose(A21);
    A22 = A22*transpose(A22);
    % figure(3)
    % imshow(A21)
    % figure(4)
    % imshow(A22)

    % These matrices will be covariance matrices
    % Specify the mean
    mu_gr21 = ones(1, length(A21));
    mu_gr22 = ones(1, length(A22));

    % Create time series
    R21 = mvnrnd(mu_gr21, A21, N_subjects);
    R22 = mvnrnd(mu_gr22, A22, N_subjects);

    % % Normalize the time series
    % mean_R21 = mean(R21);
    % std_R21 = std(R21);
    % R21 = (R21 - mean(R21)) ./ std(R21);
    % 
    % mean_R22 = mean(R22);
    % std_R22 = std(R22);
    % R22 = (R22 - mean(R22)) ./ std(R22);

    % We need only positive values
    R21 = R21 + abs(min(min(R21)));
    R22 = R22 + abs(min(min(R22)));

    % row
    sub_Tags2 = strings(size(R21, 1), 1);
    for i_sub = 1:1:length(sub_Tags2)
        sub_Tags2(i_sub) = string(['sub_' num2str(i_sub + N_subjects)]);
    end
    label_Tags2 = strings(size(R21, 1), 1);
    for i_sub = 1:1:length(label_Tags2)
        label_Tags2(i_sub) = string(['Label ' num2str(i_sub + N_subjects)]);
    end
    note_Tags2 = strings(size(R21, 1), 1);
    for i_sub = 1:1:length(note_Tags2)
        note_Tags2(i_sub) = string(['Note ' num2str(i_sub + N_subjects)]);
    end

    % Create the table - Group 2
    R21 = [cellstr(sub_Tags2) cellstr(label_Tags2) cellstr(note_Tags2) num2cell(R21)];
    T_group21 = array2table(R21, 'VariableNames', reg_Tags);

    R22 = [cellstr(sub_Tags2) cellstr(label_Tags2) cellstr(note_Tags2) num2cell(R22)];
    T_group22 = array2table(R22, 'VariableNames', reg_Tags);

    % create the table
    gr2_dir = [data_dir filesep() 'ST_MP_Group_2_TXT'];
    mkdir(gr2_dir)
    writetable(T_group21, [gr2_dir filesep() 'ST_MP_Group_2_TXT.1.txt'], 'Delimiter', '\t', 'WriteRowNames', true)
    writetable(T_group22, [gr2_dir filesep() 'ST_MP_Group_2_TXT.2.txt'], 'Delimiter', '\t', 'WriteRowNames', true)

    % variables of interest
    vois2 = [
        {{'Subject ID'} {'Age'} {'Sex'}}
        {{} {} {['{' sprintf(' ''%s'' ', sex_options{:}) '}']}}
        ];
    for i = 1:1:N_subjects
        vois2 = [vois2; {sub_Tags2{i}, randi(90), sex_options(randi(2))}];
    end
    writetable(table(vois2), [data_dir filesep() 'ST_MP_Group_2_TXT.vois.txt'], 'Delimiter', '\t', 'WriteVariableNames', false)

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
