function braph2lite_genesis(pipelineFolders, ref, ver, rollcall, compiledFolderName)
%BRAPH2LITE_GENESIS Generate a lightweight BRAPH2 distribution for selected pipeline(s).
%
% BRAPH2LITE_GENESIS(PIPELINEFOLDERS, REF, VER, ROLLCALL) generates a 
% minimal "lite" BRAPH2 distribution for the user-specified pipeline folder(s).
%
%   - PIPELINEFOLDERS: string or cell of strings to the pipeline folder(s) 
%       containing the pseudo-code. Example: 'memorycapacity' or {'memorycapacity','myOtherPipeline'}.
%
%   - REF:   'tags'   for stable versions, or 'heads' for branches.
%   - VER:   a specific tag (e.g., '2.0.0') or branch name (e.g., 'develop').
%
%   - ROLLCALL: cell array controlling which folders/elements to include/exclude.
%
% BRAPH2LITE_GENESIS(..., COMPILEDFOLDERNAME) uses a custom output folder name
% instead of the default logic that creates 'braph2<pipelineName>' or 'braph2lite'.
%
% EXAMPLE:
%   pipelineFolders = 'memorycapacity';
%   ref = 'tags';
%   ver = '2.0.0';
%   rollcall = {...}; % Your cell array of includes/excludes
%   braph2lite_genesis(pipelineFolders, ref, ver, rollcall);

    % ---------------------------
    % 1. Handle input defaults
    % ---------------------------
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
        rollcall = {}; %%%YW add command here
    end
    
    % Ensure pipelineFolders is a cell array
    if ischar(pipelineFolders)
        pipelineFolders = {pipelineFolders};
    end
    
    % If user does not provide compiledFolderName, default to 'braph2<firstPipelineName>'
    if ~exist('compiledFolderName','var') || isempty(compiledFolderName)
        pipelineNameOnly = 'lite';
        compiledFolderName = ['braph2' pipelineNameOnly];
    end
    
    % For clarity in the code, let's store these in local vars
    pipelineGenesisDir = [compiledFolderName '_genesis'];  % analogous to memorycapacity_genesis
    braph2genesisDir   = 'braph2genesis';                  % local copy of braph2genesis
    zipTmpDir          = 'tmp_unzip';
    
    % ---------------------------
    % 2. Download braph2genesis (if needed)
    % ---------------------------
    if ~exist(braph2genesisDir, 'dir')
        repoName = 'BRAPH-2'; % main BRAPH2 repo
        % Build the URL to download the correct archive
        repo = ['https://github.com/braph-software/' repoName '/archive/refs/' ref '/' ver '.zip'];
        zipfile = [repoName '-' ref '-' ver '.zip'];
        
        disp(['Downloading ' repoName ' (' ref ': ' ver ')...']);
        disp(['From: ' repo]);
        disp(['To: ' zipfile]);
        websave(zipfile, repo);
        disp('Download complete.');
        
        % unzip
        mkdir(zipTmpDir);
        mkdir(braph2genesisDir);        
        unzip(zipfile, zipTmpDir);
        
        % The unzipped folder might be "BRAPH-2-2.0.0" or "BRAPH-2-develop", etc.
        % We'll copy from that subfolder's braph2genesis/ to our braph2genesisDir
        subFolder = dir(zipTmpDir);
        % Typically, the first valid subfolder ignoring '.' or '..' is the relevant one
        subFolder = subFolder(~ismember({subFolder.name},{'.','..'}));
        
        if isempty(subFolder)
            error('Downloaded ZIP did not contain the expected folder structure.');
        end
        
        copyfile(...
            fullfile(zipTmpDir, subFolder(1).name, braph2genesisDir), ...
            braph2genesisDir ...
        );
        
        % clean up
        rmdir(zipTmpDir, 's');
        delete(zipfile);
    end
    
    % Add path to the local braph2genesis code
    addpath(braph2genesisDir);
    addpath(fullfile(braph2genesisDir, 'genesis'));
    
    % ---------------------------
    % 3. Copy pipeline folder(s) into braph2genesis/pipelines
    % ---------------------------
    for i = 1:numel(pipelineFolders)
        folderToCopy = pipelineFolders{i};
        [~, pipelineNameOnly, ~] = fileparts(folderToCopy);
        
        copyDest = fullfile(braph2genesisDir, 'pipelines', pipelineNameOnly);
        copyfile(folderToCopy, copyDest);
        fprintf('Copied pipeline "%s" to "%s"\n', folderToCopy, copyDest);
    end
    
    % ---------------------------
    % 4. Print rollcall (optional ASCII)
    % ---------------------------
    fprintf('\n------------------------------------\n');
    fprintf('Included/Excluded ROLLCALL elements:\n');
    fprintf('------------------------------------\n');
    for c = 1:numel(rollcall)
        fprintf('  %s\n', rollcall{c});
    end
    fprintf('------------------------------------\n\n');
    
    % ---------------------------
    % 5. Compile (genesis) with rollcall
    % ---------------------------
    targetDir = fullfile(fileparts(which(mfilename)), compiledFolderName);

    if exist(targetDir, 'dir')
        userInput = input([ ...
            'The target directory already exists:\n' ...
            targetDir '\n'...
            'It will be erased with all its content.\n' ...
            'Proceed anyways? (y/n)\n' ...
            ], 's');
        if strcmpi(userInput, 'y')
            backupWarning = warning('off','MATLAB:RMDIR:RemovedFromPath');
            rmdir(targetDir, 's');
            warning(backupWarning);
        else
            disp('Compilation interrupted by user.');
            return
        end
    end
    
    if ~exist(targetDir, 'dir')
        timeStart = tic();
        
        % genesis(...) is the main call from braph2genesis
        [~, sourceDir] = genesis(targetDir, [], 2, rollcall);
        
        % Optionally, remove example pipelines you don’t want
        % e.g., if you want to remove connectivity or any other pipeline .braph2 files, do it here.
        % For example:
        %  delete(fullfile(fileparts(which('braph2')), 'pipelines', 'connectivity', 'pipeline_connectivity_analysis_wu.braph2'))
        %
        % ... (Your custom cleanup code here)
        
        % Retrieve the newly generated elements (if you want to run tests)
        newElementGenList = getGenerators(fullfile(fileparts(which(mfilename)), pipelineGenesisDir, pipelineNameOnly));
        
        % Finally, remove braph2genesis to keep things "light"
        rmdir(braph2genesisDir, 's');
        
        timeEnd = toc(timeStart);
        
        fprintf('BRAPH 2 (%s) is now fully compiled and ready to be used.\n', compiledFolderName);
        fprintf('Compilation took %.2fs\n', timeEnd);
        disp(' ');
        
        % Optionally launch or initialize BRAPH2
        braph2(false);
        
        % OPTIONAL: test newly generated elements
        % for i = 1:numel(newElementGenList)
        %     testName = ['test_' char(extractBetween(newElementGenList{i}, '_', '.gen'))];
        %     eval(testName); % runs the test
        % end
    end
    
end