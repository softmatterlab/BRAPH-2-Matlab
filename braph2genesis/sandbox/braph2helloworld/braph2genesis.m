function braph2genesis(genesis_config_file)
% BRAPH2GENESIS generates and tests BRAPH2.
% 
% The various subfolders contain the files necessary to generate the 
%  various parts of BRAPH2.
%
% BRAPH2GENESIS standard packages:
%  <a href="matlab:help genesis         ">genesis</a>        - code to generate BRAPH2
%  <a href="matlab:help braph2          ">braph2</a>         - BRAPH2 loader
%  <a href="matlab:help src             ">src</a>            - BRAPH2 core
%  <a href="matlab:help brainsurfs      ">brainsurfs</a>     - BRAPH2 brainsurfs
%  <a href="matlab:help graphs          ">graphs</a>         - BRAPH2 graphs
%  <a href="matlab:help measures        ">measures</a>       - BRAPH2 measures
%  <a href="matlab:help neuralnetworks  ">neuralnetworks</a> - BRAPH2 neural networks
%  <a href="matlab:help pipelines       ">pipelines</a>      - BRAPH2 pipelines
%  <a href="matlab:help test            ">test</a>           - BRAPH2 unit testing

% % % TODO - document

%% Clean up enviroment
delete(findall(0, 'type', 'figure'))
close all
clearvars -except genesis_config_file 
clc

%% Check that no currently active BRAPH2 installation
% % % TODO - check that braph2 or any of its components are not in the path.

%% Read the genesis config file
if nargin > 0
    eval(genesis_config_file)
end

clearvars -except genesis_config_file distribution_name ...
    distribution_moniker pipeline_folders braph2_version ...
    rollcall files_to_delete

if ~exist('distribution_name', 'var')
    distribution_name = 'Standard Distribution';
end
if ~exist('distribution_moniker', 'var')
    distribution_moniker = '';
end
if ~exist('pipeline_folders', 'var')
    pipeline_folders = {};
end
if ~exist('braph2_version', 'var')
    braph2_version = 'heads/develop';
end
if ~exist('rollcall', 'var')
    rollcall = {'+ds_examples', '+gui_examples', '-sandbox'};
end
if ~exist('files_to_delete', 'var')
    files_to_delete = {};
end

launcher = ['braph2' distribution_moniker];

%% Print headers
if ispc
    fprintf([ ...
        '\n' ...
        '<strong>@@@@   @@@@    @@@   @@@@   @   @     ####   ####     ØØØØØ ØØØØ Ø   Ø ØØØØ  ØØØØ  Ø   ØØØØ\n</strong>' ...
        '<strong>@   @  @   @  @   @  @   @  @   @        #   #  #     Ø     Ø    ØØ  Ø Ø    Ø      Ø  Ø    \n</strong>' ...
        '<strong>@@@@   @@@@   @@@@@  @@@@   @@@@@     ####   #  #     Ø  ØØ ØØØ  Ø Ø Ø ØØØ   ØØØ   Ø   ØØØ \n</strong>' ...
        '<strong>@   @  @  @   @   @  @      @   @     #      #  #     Ø   Ø Ø    Ø  ØØ Ø        Ø  Ø      Ø\n</strong>' ...
        '<strong>@@@@   @   @  @   @  @      @   @     #### # ####     ØØØØØ ØØØØ Ø   Ø ØØØØ ØØØØ   Ø  ØØØØ \n</strong>' ...
        '\n' ...
        '                                                       ' distribution_name '\n' ...
        '\n' ...
        ]);
else
    fprintf([ ...
        '\n' ...
        ' ████   ████    ███   ████   █   █     ▓▓▓▓   ▓▓▓▓     ▒▒▒▒▒ ▒▒▒▒ ▒   ▒ ▒▒▒▒  ▒▒▒▒  ▒   ▒▒▒▒\n' ...
        ' █   █  █   █  █   █  █   █  █   █        ▓   ▓  ▓     ▒     ▒    ▒▒  ▒ ▒    ▒      ▒  ▒    \n' ...
        ' ████   ████   █████  ████   █████     ▓▓▓▓   ▓  ▓     ▒  ▒▒ ▒▒▒  ▒ ▒ ▒ ▒▒▒   ▒▒▒   ▒   ▒▒▒ \n' ...
        ' █   █  █  █   █   █  █      █   █     ▓      ▓  ▓     ▒   ▒ ▒    ▒  ▒▒ ▒        ▒  ▒      ▒\n' ...
        ' ████   █   █  █   █  █      █   █     ▓▓▓▓ ▓ ▓▓▓▓     ▒▒▒▒▒ ▒▒▒▒ ▒   ▒ ▒▒▒▒ ▒▒▒▒   ▒  ▒▒▒▒ \n' ...
        '\n' ...
        '                                                       ' distribution_name '\n' ...
        '\n' ...
        ]);
end

%% Download BRAPH 2 genesis, if needed
repo = 'BRAPH-2';
prefix_branch = strsplit(braph2_version, '/');
prefix = prefix_branch{1};
branch = prefix_branch{2};

% Download zip file with BRAPH2
disp(['Downloading ' repo ' (' prefix '/' branch ') ...']);
url = ['https://github.com/braph-software/BRAPH-2/archive/refs/' prefix '/' branch '.zip'];
zipfile = [repo '-' prefix '-' branch '.zip'];
websave(zipfile, url);

% Unzip BRAPH2
disp(['Unzipping ' zipfile ' ...']);
tmp_directory = [repo '-' branch];
unzip(zipfile);

% Extract BRAPH2GENESIS
disp('Copying BRAPH2GENESIS ...');
copyfile(fullfile(tmp_directory, 'braph2genesis'), 'braph2genesis');

% Clean BRAPH2 directoy and zip file
disp('Cleaning up ...');
rmdir(tmp_directory, 's');
delete(zipfile);

disp(' ')

%% Copy pipeline folders into braph2genesis/pipelines
for i = 1:1:numel(pipeline_folders)
    pipeline_folder = pipeline_folders{i};
    target_folder = fullfile('braph2genesis', 'pipelines', pipeline_folder);

    fprintf(['Copying pipeline "' pipeline_folder '" to "' target_folder '"\n']);
    copyfile(pipeline_folder, target_folder);
end

disp(' ')

%% Display rollcall elements
fprintf('Rollcal elements:\n');
rollcall_per_line = 5;
offset = max(cellfun(@(x) length(x), rollcall)) + 2;
for i = 1:rollcall_per_line:length(rollcall)
    cellfun(@(x) fprintf([x repmat(' ', 1, offset - length(x))]), rollcall(i:min(i + rollcall_per_line - 1, length(rollcall))))
    fprintf('\n')
end

disp(' ')

%% Modify BRAPH2 constants


%% Compile BRAPH2
addpath([fileparts(which('braph2genesis')) filesep() 'braph2genesis' filesep 'genesis'])

target_dir = [fileparts(which('braph2genesis')) filesep 'braph2' distribution_moniker];
if exist(target_dir, 'dir') 
    if input([ ...
        'The target directory already exists:\n' ...
        target_dir '\n'...
        'It will be erased with all its content.\n' ...
        'Proceed anyways? (y/n)\n'
        ], 's') == 'y'
    
        backup_warning_state = warning('off', 'MATLAB:RMDIR:RemovedFromPath');
        rmdir(target_dir, 's')
        warning(backup_warning_state)
    else
        disp('Compilation interrupted.')
    end
end
if ~exist(target_dir, 'dir') 
    time_start = tic;

    [target_dir, source_dir] = genesis(target_dir, [], 2, rollcall); %#ok<ASGLU> 

    addpath(target_dir)

    time_end = toc(time_start);

    disp(['BRAPH 2 ' distribution_name ' is now fully compiled and ready to be used.'])
    disp(['Its compilation has taken ' int2str(time_end) '.' int2str(mod(time_end, 1) * 10) 's'])
    disp('')
end

%% Change name of BRAPH2 launcher
% % % TODO

%% Remove files to be deleted
% % % TODO

%% Erase 
% % % TODO

%% Launch BRAPH2 distribution
eval(['braph2' distribution '(false)'])

%% Test compiled BRAPH2 distribution
test_braph2
