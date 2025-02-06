function get_braph2distribution(inputSource, ref, ver, rollcall, launcher, distrName, filesToDelete)
%GET_BRAPH2DISTRIBUTION generates a BRAPH 2 distribution for selected pipeline(s).
%
% This function can take:
%   (1) A text file containing the input variables (e.g., 'config.txt')
%   (2) Direct MATLAB variables (pipelineFolders, ref, ver, rollcall, compiledFolderName).
%
% Example usage with a configuration file:
%   braph2genesis_for_distr('config.txt');
%
% Example usage with direct inputs:
%   pipelineFolders = 'memorycapacity';
%   ref = 'tags'; % 'tags' for stable versions, 'heads' for branches like 'develop'
%   ver = '2.0.0';
%   rollcall = {...}; % Your rollcall structure
%   launcher = 'braph2memorycapacity';
%   distrName = 'Memory Capacity';
%   filesToDelete = {...}; % List of files to delete
%   get_braph2distribution(pipelineFolders, ref, ver, rollcall, compiledFolderName, distrName, filesToDelete);

    %% Check if input is a text file, read variables from it
    if ischar(inputSource) && exist(inputSource, 'file')
        run(inputSource)
        parentDir = fileparts(inputSource);
        % % % vars = readConfigFile(inputSource);
        % % % distrName = vars.distrName;
        % % % pipelineFolders = vars.pipelineFolders;
        % % % ref = vars.ref;
        % % % ver = vars.ver;
        % % % rollcall = vars.rollcall;
        % % % compiledFolderName = vars.compiledFolderName;
        % % % filesToDelete = vars.filesToDelete;
    else
        % If not a file, assume it's direct variable input
        pipelineFolders = inputSource;
        parentDir = fileparts(pipelineFolders);
    end

    %% Handle input defaults
    if ~exist('pipelineFolders','var') || isempty(pipelineFolders)
        error('You must specify at least one pipeline folder.');
    end
    if ~exist('ref','var') || isempty(ref)
        ref = 'tags';  % default to stable tags
    end
    if ~exist('ver','var') || isempty(ver)
        ver = '2.0.0'; % default version
    end
    if ~exist('rollcall','var') || isempty(rollcall)
        rollcall = {}; 
    end
    if ~exist('filesToDelete','var') || isempty(filesToDelete)
        filesToDelete = {}; % Default to empty if no files specified
    end
    
    % Ensure pipelineFolders is a cell array
    if ischar(pipelineFolders)
        pipelineFolders = {pipelineFolders};
    end
    
    % Default output folder name
    if ~exist('launcher', 'var') || isempty(launcher)
        pipelineNameOnly = 'distr';
        launcher = ['braph2' pipelineNameOnly];
    end
    
    % Define necessary directories 
    braph2genesisDir = [parentDir filesep 'braph2genesis'];  
    braph2DistrDir = [parentDir filesep launcher]; 

    %% Download BRAPH 2 genesis if needed
    if ~exist(braph2genesisDir, 'dir')
        repoName = 'BRAPH-2'; 
        repo = ['https://github.com/braph-software/' repoName '/archive/refs/' ref '/' ver '.zip'];
        zipfile = [parentDir filesep repoName '-' ref '-' ver '.zip'];
        
        disp(['Downloading ' repoName ' (' ref ': ' ver ')...']);
        websave(zipfile, repo);
        
        zipTmpDir = [parentDir filesep 'tmp_unzip'];
        mkdir(zipTmpDir);
        mkdir(braph2genesisDir);        
        unzip(zipfile, zipTmpDir);
        
        subFolder = dir(zipTmpDir);
        subFolder = subFolder(~ismember({subFolder.name},{'.','..'}));
        
        if isempty(subFolder)
            error('Downloaded ZIP did not contain the expected folder structure.');
        end
        
        copyfile(fullfile(zipTmpDir, subFolder(1).name, 'braph2genesis'), braph2genesisDir);
        rmdir(zipTmpDir, 's');
        delete(zipfile);
    end
    
    % Add paths
    addpath(braph2genesisDir);
    addpath(fullfile(braph2genesisDir, 'genesis'));
    
    %% Copy pipeline folders into braph2genesis/pipelines
    for i = 1:numel(pipelineFolders)
        folderToCopy = [parentDir filesep pipelineFolders{i}];
        [~, pipelineNameOnly, ~] = fileparts(folderToCopy);
        
        copyDest = fullfile(braph2genesisDir, 'pipelines', pipelineNameOnly);
        copyfile(folderToCopy, copyDest);
        fprintf('Copied pipeline "%s" to "%s"\n', folderToCopy, copyDest);
    end
    
    % Display rollcall elements
    fprintf('\n------------------------------------\n');
    fprintf('Included/Excluded ROLLCALL elements:\n');
    fprintf('------------------------------------\n');
    for c = 1:numel(rollcall)
        fprintf('  %s\n', rollcall{c});
    end
    fprintf('------------------------------------\n\n');
    
    %% Compile (genesis) with rollcall
    if exist(braph2DistrDir, 'dir')
        userInput = input(['The target directory already exists:\n' braph2DistrDir '\nProceed anyways? (y/n)\n'], 's');
        if strcmpi(userInput, 'y')
            rmdir(braph2DistrDir, 's');
        else
            disp('Compilation interrupted by user.');
            return
        end
    end
    
    if ~exist(braph2DistrDir, 'dir')
        timeStart = tic();
        
        [~, sourceDir] = genesis(braph2DistrDir, [], 2, rollcall);
        
        % Distribution-specific customization
        braph2constant_file = [braph2DistrDir filesep 'src' filesep 'util' filesep 'BRAPH2.m'];
        ModifyBRAPH2Constant(braph2constant_file, braph2constant_file, 'DISTRIBUTION', distrName)
        ModifyBRAPH2Constant(braph2constant_file, braph2constant_file, 'LAUNCHER', launcher)
        
        braph2_launcher = [braph2DistrDir filesep 'braph2.m'];
        braph2distr_launcher = [braph2DistrDir filesep launcher '.m'];
        movefile(braph2_launcher, braph2distr_launcher);

        % Remove specified files
        deleteSpecifiedFiles(filesToDelete);

        % Remove braph2genesis
        rmdir(braph2genesisDir, 's');
        
        timeEnd = toc(timeStart);
        
        fprintf('BRAPH 2 (%s) is now fully compiled and ready to be used.\n', launcher);
        fprintf('Compilation took %.2fs\n', timeEnd);
        
        % test BRAPH 2 Distribution
        test_braph2;

        % Launch BRAPH 2 Distribution
        run(BRAPH2.LAUNCHER)
    end
end

%% Function to Remove Specified Files
function deleteSpecifiedFiles(filesToDelete)
    for i = 1:numel(filesToDelete)
        fileToDelete = filesToDelete{i};
        if exist(fileToDelete, 'file')
            delete(fileToDelete);
            fprintf('Deleted: %s\n', fileToDelete);
        else
            warning('File not found: %s', fileToDelete);
        end
    end
end

%% Function to Modify BRAPH2 Constant
function ModifyBRAPH2Constant(inputFile, outputFile, propertyName, newValue)
    % ModifyBRAPH2Constant updates a specified property definition in a BRAPH2 class file.
    %
    % Syntax:
    %   ModifyBRAPH2Constant('BRAPH2.m', 'BRAPH2_out.m', 'DISTRIBUTION', 'Memory Capacity')
    %
    % This function reads the specified BRAPH2 class file, searches for the given 
    % property name (e.g., 'DISTRIBUTION') within the 'Constant' properties section, 
    % updates its value to newValue, and writes the modified content to a new file.

    % Read the content of the input file
    fid = fopen(inputFile, 'r');
    if fid == -1
        error('Could not open %s for reading.', inputFile);
    end
    fileContent = textscan(fid, '%s', 'Delimiter', '\n', 'Whitespace', '');
    fclose(fid);
    fileContent = fileContent{1}; % Extract cell array of lines
    
    % Define the exact property search string
    searchString = sprintf('%s =', propertyName);
    
    % Format the new property definition with the updated value
    newLine = sprintf('        %s = ''%s'';', propertyName, newValue);
    
    % Iterate through the file and find the matching property line
    modified = false;
    for i = 1:length(fileContent)
        % Check if the line starts with the property name
        if contains(fileContent{i}, searchString) && startsWith(strtrim(fileContent{i}), propertyName)
            fileContent{i} = newLine; % Replace with the new value
            modified = true;
            break;
        end
    end
    
    % If the property was not found, display a warning
    if ~modified
        warning('Property "%s" not found in %s.', propertyName, inputFile);
    else
        fprintf('Updated "%s" property in "%s" -> "%s"\n', propertyName, inputFile, outputFile);
    end
    
    % Write the modified content to the output file
    fid = fopen(outputFile, 'w');
    if fid == -1
        error('Could not open %s for writing.', outputFile);
    end
    fprintf(fid, '%s\n', fileContent{:});
    fclose(fid);
end