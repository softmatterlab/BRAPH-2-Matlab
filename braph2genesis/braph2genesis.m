function braph2genesis(genesis_config_file)
% BRAPH2GENESIS generates and tests a BRAPH 2 distribution.
%
% BRAPH2GENESIS() compiles the standard BRAPH 2 distribution, which
%  includes these standard packages:
%  <a href="matlab:help genesis         ">genesis</a>        - code to generate BRAPH2
%  <a href="matlab:help braph2          ">braph2</a>         - BRAPH2 loader
%  <a href="matlab:help src             ">src</a>            - BRAPH2 core
%  <a href="matlab:help brainsurfs      ">brainsurfs</a>     - BRAPH2 brainsurfs
%  <a href="matlab:help graphs          ">graphs</a>         - BRAPH2 graphs
%  <a href="matlab:help measures        ">measures</a>       - BRAPH2 measures
%  <a href="matlab:help neuralnetworks  ">neuralnetworks</a> - BRAPH2 neural networks
%  <a href="matlab:help pipelines       ">pipelines</a>      - BRAPH2 pipelines
%  <a href="matlab:help test            ">test</a>           - BRAPH2 unit testing
%
%
% BRAPH2GENESIS(GENESIS_CONFIG_FILE) reads the configuration file 
%  GENESIS_CONFIG_FILE and compiles a customized BRAPH 2 distribution 
%  with user-defined elements alongside built-in components.
%
% The configuration file GENESIS_CONFIG_FILE is a MatLab script (*.m file)
%  with the following variables (other variables will be ingnored):
%
%  <strong>distribution_name</strong>
%   A string specifying the name of the distribution
%   (e.g., 'Hello, World!').
%  <strong>distribution_moniker</strong>
%   A short identifier used in launcher functions and filenames. It should
%   only contain letters, numbers, and underscores.
%   (e.g., 'helloworld').
%  <strong>pipeline_folders</strong>
%   A cell array listing folders containing user-prepared pipelines.
%  <strong>braph2_version</strong>
%   A string specifying the BRAPH2 version to fetch from Github
%   (e.g., 'tags/2.0.1' or 'heads/develop').
%   The build number should be 7 or larger (version 2.0.1 or subsequent).
%  <strong>rollcall</strong>
%   A cell array defining which standard elements to include or exclude.
%
%   Add here all included and excluded folders and elements
%   '-folder'                 the folder and its elements will be excluded
%
%  '+folder'                 the folder is included, but not its elements
%    '+_ElementName.gen.m'   the element is included,
%                            if the folder is included
%
%  '+folder*'                the folder and its elements are included
%    '-_ElementName.gen.m'   the element is excluded,
%                            if the folder and its elements are included
%  (by default, the folders are included as '+folder*')
%   
%  <strong>files_to_delete</strong>
%   A cell array specifying files to remove after compilation.
%
% If GENESIS_CONFIG_FILE is not provided, the function generates the 
%  standard BRAPH2 distribution with all built-in elements.
%
% Example usage:
%  braph2genesis('braph2helloworld_config.m') 
% This command generates a custom distribution named "Hello, World!",
%  see the GitHub repository <a href="https://github.com/braph-software/hello-world">https://github.com/braph-software/hello-world</a>

%% Clean up enviroment
delete(findall(0, 'type', 'figure'))
close all
clearvars -except genesis_config_file 
clc

%% Read the genesis config file
if nargin > 0
    if isfile(genesis_config_file)
        run(genesis_config_file)
        directory = fileparts(genesis_config_file);
    else
        fprintf('The input file ''%s'' does not exist. \n', genesis_config_file);
        disp('Compilation interrupted.');
        return
    end
else
    directory = fileparts(mfilename);
end
if isempty(directory)
    directory = '.'; % reflecting the current level of the working directory
end

clearvars -except directory genesis_config_file distribution_name ...
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

%% Verify there is no BRAPH2 installation in the MATLAB search path
folder_names = {'braph2', launcher}; % List of folder names to check
path_dirs = strsplit(path, pathsep);

% Find folders that match but ignore 'braph2genesis'
found = cellfun(@(f) find(contains(path_dirs, f, 'IgnoreCase', true) & ~contains(path_dirs, 'braph2genesis', 'IgnoreCase', true), 1, 'first'), folder_names, 'UniformOutput', false);
found = [folder_names(~cellfun(@isempty, found)); path_dirs([found{:}])];

if ~isempty(found)
    fprintf('The following folders already exist in the MATLAB search path:\n');
    fprintf('- %s (found in: %s)\n', found{:});
    disp('Compilation interrupted.');
    return
end

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
braph2genesis_directory = [directory filesep() 'braph2genesis'];
flag_erase_braph2genesis_dir = true; % a flag for deciding whether to erase braph2genesis at the end
if exist(braph2genesis_directory, 'dir')
    if input([ ...
        'The braph2genesis directory already exists:\n' ...
        'Press ‘y’ to erase it, or\n' ...
        'press ‘n’ to proceed with the existing one.\n'
        ], 's') == 'y'

        backup_warning_state = warning('off', 'MATLAB:RMDIR:RemovedFromPath');
        rmdir(braph2genesis_directory, 's')
        warning(backup_warning_state)
    else
        flag_erase_braph2genesis_dir = false; % to keep the existing braph2genesis directory
    end
end

if ~exist(braph2genesis_directory, 'dir')
    repo = 'BRAPH-2';
    prefix_branch = strsplit(braph2_version, '/');
    prefix = prefix_branch{1};
    branch = prefix_branch{2};

    % Download zip file with BRAPH2
    disp(['Downloading ' repo ' (' prefix '/' branch ') ...']);
    url = ['https://github.com/braph-software/BRAPH-2/archive/refs/' prefix '/' branch '.zip'];
    zipfile = [directory filesep() repo '-' prefix '-' branch '.zip'];
    websave(zipfile, url);

    % Unzip BRAPH2
    disp(['Unzipping ' zipfile ' ...']);
    tmp_directory = [directory filesep() repo '-' branch];
    unzip(zipfile, directory);

    % Extract BRAPH2GENESIS
    disp('Copying BRAPH2GENESIS ...');
    copyfile(fullfile(tmp_directory, 'braph2genesis'), braph2genesis_directory);

    % Clean BRAPH2 directoy and zip file
    disp('Cleaning up ...');
    rmdir(tmp_directory, 's');
    delete(zipfile);
end

disp(' ')

%% Check that build number >= 7 (version 2.0.1 or subsequent).
addpath([braph2genesis_directory filesep() 'src' filesep() 'util']); % temporarily add path for genesis util dir
genesis_full_path = what(braph2genesis_directory).path; expected_BRAPH2_path = [genesis_full_path filesep() 'src' filesep() 'util' filesep() 'BRAPH2.m'];

if isequal(which('BRAPH2'), expected_BRAPH2_path)
    build_number = BRAPH2.BUILD; % e.g., 7 or 8
    version_str = BRAPH2.VERSION; % e.g., '2.0.1'
    ver_parts = regexp(version_str, '\.', 'split'); % e.g., {2}, {0}, {1}, split it into major, minor, and patch
    
    % check build number
    if build_number < 7 % the build number should be greater or equal to 7
        fprintf('BRAPH2 build number is %d, but must be >= 7.\n', build_number);
        fprintf('Compilation interrupted.\n');
        rmpath(fullfile(braph2genesis_directory, 'src', 'util'));
        return
    end
    
    % check version
    if (numel(ver_parts) < 3 || ... % the version format should be x.y.z
        str2num(ver_parts{1}) < 2) % the major version should be greater or equal to 2
        fprintf('BRAPH2 version is %s, but must be >= 2.0.1.\n', version_str);
        fprintf('Compilation interrupted.\n');
        rmpath(fullfile(braph2genesis_directory, 'src', 'util'));
        return
    end
else
    fprintf('Another braph2genesis/braph2 folder already exists in the MATLAB search path:\n');
    fprintf('- %s (found in: %s)\n', which('BRAPH2'));
    disp('Compilation interrupted.');
    rmpath([braph2genesis_directory filesep() 'src' filesep() 'util']); % remove genesis util dir from search path
    return
end
rmpath([braph2genesis_directory filesep() 'src' filesep() 'util']); % remove genesis util dir from search path

%% Copy pipeline folders into braph2genesis/pipelines
for i = 1:1:numel(pipeline_folders)
    pipeline_folder = pipeline_folders{i};
    target_folder = fullfile(braph2genesis_directory, 'pipelines', pipeline_folder);

    fprintf(['Copying pipeline "' pipeline_folder '" to "' target_folder '"\n']);
    copyfile([directory filesep() pipeline_folder], target_folder);
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

%% Change name of BRAPH2 launcher
braph2distr_launcher = [braph2genesis_directory filesep() '_braph2' filesep() launcher '.m'];
braph2_launcher = [braph2genesis_directory filesep() '_braph2' filesep() 'braph2.m'];
if ~exist(braph2distr_launcher, 'file')
    movefile(braph2_launcher, braph2distr_launcher);
end

%% Modify BRAPH2 constants
braph2constants_file = fullfile(braph2genesis_directory, 'src', 'util', 'BRAPH2.m'); % Define the file path

% Read file content
fid = fopen(braph2constants_file, 'r'); file_content = textscan(fid, '%s', 'Delimiter', '\n', 'Whitespace', ''); fclose(fid);
file_content = file_content{1}; 

% Define properties the new values to modify
properties = {'DISTRIBUTION', 'LAUNCHER'}; new_values = {distribution_name, launcher};

% Modify the file content
for i = 1:length(file_content)
    for j = 1:numel(properties)
        if contains(file_content{i}, [properties{j}, ' =']) && startsWith(strtrim(file_content{i}), properties{j})
            file_content{i} = sprintf('        %s = ''%s'';', properties{j}, new_values{j});
        end
    end
end

% Write back the modified content
fid = fopen(braph2constants_file, 'w');
fprintf(fid, '%s\n', file_content{:});
fclose(fid);

%% Compile BRAPH2
addpath([braph2genesis_directory filesep() 'genesis'])

target_dir = [directory filesep() 'braph2' distribution_moniker];
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
        rmpath([braph2genesis_directory filesep() 'genesis'])
        disp('Compilation interrupted.')
        return
    end
end
if ~exist(target_dir, 'dir') 
    time_start = tic;

    [target_dir, source_dir] = genesis(target_dir, braph2genesis_directory, 2, rollcall); %#ok<ASGLU> 

    addpath(target_dir)

    time_end = toc(time_start);

    disp(['BRAPH 2 ' distribution_name ' is now fully compiled and ready to be used.'])
    disp(['Its compilation has taken ' int2str(time_end) '.' int2str(mod(time_end, 1) * 10) 's'])
    disp('')
end
rmpath([braph2genesis_directory filesep() 'genesis'])

%% Remove files to be deleted
for i = 1:numel(files_to_delete)
    file_to_delete = [target_dir filesep() files_to_delete{i}];
    if exist(file_to_delete, 'file')
        delete(file_to_delete);
        fprintf('Deleted: %s\n', file_to_delete);
    else
        warning('File not found: %s', file_to_delete);
    end
end

disp(' ')

%% Erase braph2genesis dir
if flag_erase_braph2genesis_dir
    rmdir(braph2genesis_directory, 's');
end

%% Launch BRAPH2 distribution
eval([launcher '(false)'])

%% Test compiled BRAPH2 distribution
test_braph2
