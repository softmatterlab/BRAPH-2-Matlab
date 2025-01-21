function [target_dir, source_dir] = genesis(target_dir, source_dir, run_number, rollcall)
%GENESIS generates BRAPH2.
%
% [TARGET_DIR, SOURCE_DIR] = GENESIS() generates BRAPH2 from the default
%  SOURCE_DIR (the directory that contains braph2genesis) to the default
%  TARGET_DIR (the directory 'braph2' in the superdirectory of SOURCE_DIR).
%
% GENESIS(TARGET_DIR) generates BRAPH2 in TARGET_DIR from the default
%  SOURCE_DIR.
%
% GENESIS(TARGET_DIR, SOURCE_DIR) generates BRAPH2 in TARGET_DIR from
%  SOURCE_DIR.
%
% GENESIS(TARGET_DIR, SOURCE_DIR, RUN_NUMBER) runs the creation scripts
%  RUN_NUMBER times. RUN_NUMBER = 2 (default) improves the computational
%  efficiency of the code  mainly by hardcoding some intermediate values.
%
% GENESIS([], [], [], ROLLCALL) excludes or includes folders and
%  elements based on the ROLLCALL cell array of strings, whose elements
%  can be:
%   '-folder'                  the folder and its elements will be excluded
%
%   '+folder'                  the folder is included, but not its elements
%       '+_ElementName.gen.m'  the element is included,
%                              if the folder is included
%
%   '+folder*'                 the folder and its elements are included
%       '-_ElementName.gen.m'  the element is excluded,
%                              if the folder and its elements are included
%   (by default, the folders are included as '+folder*')
%
% See also braph2genesis, create_Element, create_layout,
%  create_test_Element, hard_code_constants.

fp = filesep();

if nargin < 4
    rollcall = {'+ds_examples', '+gui_examples', '-sandbox'};
end

if nargin < 3 || isempty(run_number)
    run_number = 1;
end

if nargin < 2 || isempty(source_dir)
    source_dir = fileparts(which('braph2genesis'));
end

if nargin < 1 || isempty(target_dir)
    target_dir = [fileparts(source_dir) fp 'braph2'];
end

disp('¡ BRAPH 2 Genesis')
disp(['¡ source dir: ' source_dir])
disp(['¡ target dir: ' target_dir])
disp(' ')

%% ROLLCALL FUNCTIONS
    function bool = compile_dir(dir)
        bool = any(ismember({['+' dir], ['+' dir '*']}, rollcall)) ...
            || ~any(ismember({['-' dir], ['-' dir '*']}, rollcall));
    end
    function bool = compile_el(dir, el)
        if any(ismember(['-' dir], rollcall))
            bool = false;
        elseif any(ismember(['-' el], rollcall))
            bool = false;
        elseif any(ismember(['+' dir], rollcall)) ...
                && ~any(ismember(['+' el], rollcall))
            bool = false;
        else
            bool = true;
        end
    end
    function bool = compile_pip_dir(pip_dir)
        if any(ismember('-pipelines', rollcall))
            bool = false;
        elseif any(ismember(['-' pip_dir], rollcall))
            bool = false;
        elseif any(ismember('+pipelines', rollcall)) ...
                && ~any(ismember({['+' pip_dir], ['+' pip_dir '*']}, rollcall))
            bool = false;
        else
            bool = true;
        end
    end
    function bool = compile_pip_el(pip_dir, pip_el)
        if any(ismember('-pipelines', rollcall))
            bool = false;
        elseif any(ismember(['-' pip_dir], rollcall))
            bool = false;
        elseif any(ismember(['-' pip_el], rollcall))
            bool = false;
        elseif any(ismember(['+' pip_dir], rollcall)) ...
                && ~any(ismember(['+' pip_el], rollcall))
            bool = false;
        else
            bool = true;
        end
    end

%% CREATE DIR STRUCTURE
% braph2
mkdir(target_dir)

disp('¡! created target dir')

% src
if compile_dir('util')
    mkdir([target_dir fp 'src' fp 'util'])
end
if compile_dir('ds')
    mkdir([target_dir fp 'src' fp 'ds'])
    if compile_dir('ds_examples')
        mkdir([target_dir fp 'src' fp 'ds' fp 'ds_examples'])
    end
end
if compile_dir('atlas')
    mkdir([target_dir fp 'src' fp 'atlas'])
end
if compile_dir('gt')
    mkdir([target_dir fp 'src' fp 'gt'])
end
if compile_dir('cohort')
    mkdir([target_dir fp 'src' fp 'cohort'])
end
if compile_dir('analysis')
    mkdir([target_dir fp 'src' fp 'analysis'])
end
if compile_dir('nn')
    mkdir([target_dir fp 'src' fp 'nn'])
end
if compile_dir('gui')
    mkdir([target_dir fp 'src' fp 'gui'])
    mkdir([target_dir fp 'src' fp 'gui' fp 'layouts'])
    if compile_dir('gui_examples')
        mkdir([target_dir fp 'src' fp 'gui' fp 'gui_examples'])
    end
end

disp('¡! created dir structure - SRC')

% brainsurfs
if compile_dir('brainsurfs')
    mkdir([target_dir fp 'brainsurfs'])
end

disp('¡! created dir structure - BRAINSURFS')

% atlases
if compile_dir('atlases')
    mkdir([target_dir fp 'atlases'])
end

disp('¡! created dir structure - ATLASES')

% graphs
if compile_dir('graphs')
    mkdir([target_dir fp 'graphs'])
end

disp('¡! created dir structure - GRAPHS')

% measures
if compile_dir('measures')
    mkdir([target_dir fp 'measures'])
end

disp('¡! created dir structure - MEASURES')

% neural networks
if compile_dir('neuralnetworks')
    mkdir([target_dir fp 'neuralnetworks'])
end

disp('¡! created dir structure - NEURALNETWORKS')

% pipelines
if compile_dir('pipelines')
    mkdir([target_dir fp 'pipelines'])

    pipelines_contents = dir([source_dir fp 'pipelines']);  % get the folder contents
    pipelines_dir_list = pipelines_contents([pipelines_contents(:).isdir] == 1);  % remove all files (isdir property is 0)
    pipelines_dir_list = pipelines_dir_list(~ismember({pipelines_dir_list(:).name}, {'.', '..'}));  % remove '.' and '..'
    for i = 1:1:length(pipelines_dir_list)
        pipeline_dir_name = pipelines_dir_list(i).name;
        if compile_pip_dir(pipeline_dir_name)
            mkdir([target_dir fp 'pipelines' fp pipeline_dir_name])
        end
    end
    disp('¡! copied ready files - pipelines')
    disp(' ')
end

disp('¡! created dir structure - PIPELINES')

% test
if compile_dir('test')
    mkdir([target_dir fp 'test'])
end

disp('¡! created dir structure - TEST')

% sandbox
if compile_dir('sandbox')
    mkdir([target_dir fp 'sandbox'])
end

disp('¡! created dir structure - SANDBOX')

disp(' ')

%% COPY READY FILES
% braph2.m and license.rtf
copyfile([source_dir fp '_braph2' fp 'braph2.m'], [target_dir fp 'braph2.m'])
copyfile([source_dir fp 'braph2license.rtf'], [target_dir fp 'braph2license.rtf'])
disp('¡! copied ready files - braph2')
disp(' ')

% src
if compile_dir('util')
    copydir([source_dir fp 'src' fp 'util'], [target_dir fp 'src' fp 'util'])
    disp('¡! copied ready files - src/util')
end
if compile_dir('ds')
    copydir([source_dir fp 'src' fp 'ds'], [target_dir fp 'src' fp 'ds'])
    disp('¡! copied ready files - src/ds')
    if compile_dir('ds_examples')
        copydir([source_dir fp 'src' fp 'ds' fp 'ds_examples'], [target_dir fp 'src' fp 'ds' fp 'ds_examples'])
        disp('¡! copied ready files - ds/ds_examples')
    end
end
if compile_dir('atlas')
    copydir([source_dir fp 'src' fp 'atlas'], [target_dir fp 'src' fp 'atlas'])
    disp('¡! copied ready files - src/atlas')
end
if compile_dir('gt')
    copydir([source_dir fp 'src' fp 'gt'], [target_dir fp 'src' fp 'gt'])
    disp('¡! copied ready files - src/gt')
end
if compile_dir('cohort')
    copydir([source_dir fp 'src' fp 'cohort'], [target_dir fp 'src' fp 'cohort'])
    disp('¡! copied ready files - src/cohort')
end
if compile_dir('analysis')
    copydir([source_dir fp 'src' fp 'analysis'], [target_dir fp 'src' fp 'analysis'])
    disp('¡! copied ready files - src/analysis')
end
if compile_dir('nn')
    copydir([source_dir fp 'src' fp 'nn'], [target_dir fp 'src' fp 'nn'])
    disp('¡! copied ready files - src/nn')
end
if compile_dir('gui')
    copydir([source_dir fp 'src' fp 'gui'], [target_dir fp 'src' fp 'gui'])
    disp('¡! copied ready files - src/gui')
    copydir([source_dir fp 'src' fp 'gui' fp 'layouts'], [target_dir fp 'src' fp 'gui' fp 'layouts'])
    disp('¡! copied ready files - src/gui/layouts')
    if compile_dir('gui_examples')
        copydir([source_dir fp 'src' fp 'gui' fp 'gui_examples'], [target_dir fp 'src' fp 'gui' fp 'gui_examples'])
        disp('¡! copied ready files - src/gui/gui_examples')
    end
end
disp(' ')

% brainsurfs
if compile_dir('brainsurfs')
    copydir([source_dir fp 'brainsurfs'], [target_dir fp 'brainsurfs'], Inf)
    disp('¡! copied ready files - brainsurf')
    disp(' ')
end

% atlases
if compile_dir('atlases')
    copydir([source_dir fp 'atlases'], [target_dir fp 'atlases'], Inf)
    disp('¡! copied ready files - atlases')
    disp(' ')
end

% graphs
if compile_dir('graphs')
    copydir([source_dir fp 'graphs'], [target_dir fp 'graphs'], Inf)
    disp('¡! copied ready files - graphs')
    disp(' ')
end

% measures
if compile_dir('measures')
    copydir([source_dir fp 'measures'], [target_dir fp 'measures'], Inf)
    disp('¡! copied ready files - measures')
    disp(' ')
end

% neuralnetworks
if compile_dir('neuralnetworks')
    copydir([source_dir fp 'neuralnetworks'], [target_dir fp 'neuralnetworks'], Inf)
    disp('¡! copied ready files - neuralnetworks')
    disp(' ')
end

% pipelines
if compile_dir('pipelines')
    copydir([source_dir fp 'pipelines'], [target_dir fp 'pipelines'])

    pipelines_contents = dir([source_dir fp 'pipelines']);  % get the folder contents
    pipelines_dir_list = pipelines_contents([pipelines_contents(:).isdir] == 1);  % remove all files (isdir property is 0)
    pipelines_dir_list = pipelines_dir_list(~ismember({pipelines_dir_list(:).name}, {'.', '..'}));  % remove '.' and '..'
    for i = 1:1:length(pipelines_dir_list)
        pipeline_dir_name = pipelines_dir_list(i).name;
        if compile_pip_dir(pipeline_dir_name)
            copydir([source_dir fp 'pipelines' fp pipeline_dir_name], [target_dir fp 'pipelines' fp pipeline_dir_name], Inf)
        end
    end
    disp('¡! copied ready files - pipelines')
    disp(' ')
end

% test
if compile_dir('test')
    copydir([source_dir fp 'test'], [target_dir fp 'test'], Inf)
    disp('¡! copied ready files - test')
    disp(' ')
end

% sandbox
if compile_dir('sandbox')
    copydir([source_dir fp 'sandbox'], [target_dir fp 'sandbox'], Inf)
    disp('¡! copied ready files - sandbox')
    disp(' ')
end

%% CREATE ELEMENTS
for run = 1:1:run_number

    disp(['¡! started run number ' int2str(run)])
    disp(' ')

    % src
    if compile_dir('util')
        util_gen_list = getGenerators([source_dir fp 'src' fp 'util']);
        for i = 1:1:numel(util_gen_list)
            if compile_el('util', util_gen_list{i})
                create_Element([source_dir fp 'src' fp 'util' fp util_gen_list{i}], [target_dir fp 'src' fp 'util'])
            end
        end
    end

    if compile_dir('ds')
        if exist('Category', 'class') == 8 && run_number == 2, hard_code_constants([target_dir fp 'src' fp 'ds' fp 'Category.m']), end % % % TO BE CHECKED
        if exist('Format', 'class') == 8 && run_number == 2, hard_code_constants([target_dir fp 'src' fp 'ds' fp 'Format.m']), end % % % TO BE CHECKED
	    if exist('Element', 'class') == 8 && run_number == 2, hard_code_constants([target_dir fp 'src' fp 'ds' fp 'Element.m']), end % % % TO BE CHECKED
	    ds_gen_list = getGenerators([source_dir fp 'src' fp 'ds']);
        for i = 1:1:numel(ds_gen_list)
            if compile_el('ds', ds_gen_list{i})
                create_Element([source_dir fp 'src' fp 'ds' fp ds_gen_list{i}], [target_dir fp 'src' fp 'ds'])
            end
        end

        if compile_dir('ds_examples')
            ds_examples_gen_list = getGenerators([source_dir fp 'src' fp 'ds' fp 'ds_examples']);
            for i = 1:1:numel(ds_examples_gen_list)
                if compile_el('ds_examples', ds_examples_gen_list{i})
                    create_Element([source_dir fp 'src' fp 'ds' fp 'ds_examples' fp ds_examples_gen_list{i}], [target_dir fp 'src' fp 'ds' fp 'ds_examples'])
                end
            end
        end
    end
    
    if compile_dir('atlas')
        atlas_gen_list = getGenerators([source_dir fp 'src' fp 'atlas']);
        for i = 1:numel(atlas_gen_list)
            if compile_el('atlas', atlas_gen_list{i})
                create_Element([source_dir fp 'src' fp 'atlas' fp atlas_gen_list{i}], [target_dir fp 'src' fp 'atlas'])
            end
        end
    end

    if compile_dir('gt')
        gt_gen_list = getGenerators([source_dir fp 'src' fp 'gt']);
        for i = 1:numel(gt_gen_list)
            if compile_el('gt', gt_gen_list{i})
                create_Element([source_dir fp 'src' fp 'gt' fp gt_gen_list{i}], [target_dir fp 'src' fp 'gt'])
            end
        end
    end

    if compile_dir('cohort')
        cohort_gen_list = getGenerators([source_dir fp 'src' fp 'cohort']);
        for i = 1:numel(cohort_gen_list)
            if compile_el('cohort', cohort_gen_list{i})
                create_Element([source_dir fp 'src' fp 'cohort' fp cohort_gen_list{i}], [target_dir fp 'src' fp 'cohort'])
            end
        end
    end

    if compile_dir('analysis')
        analysis_gen_list = getGenerators([source_dir fp 'src' fp 'analysis']);
        for i = 1:numel(analysis_gen_list)
            if compile_el('analysis', analysis_gen_list{i})
                create_Element([source_dir fp 'src' fp 'analysis' fp analysis_gen_list{i}], [target_dir fp 'src' fp 'analysis'])
            end
        end
    end
    
    % nn
    if compile_dir('nn')
        nn_gen_list = getGenerators([source_dir fp 'src' fp 'nn']);
        for i = 1:numel(nn_gen_list)
            if compile_el('nn', nn_gen_list{i})
                create_Element([source_dir fp 'src' fp 'nn' fp nn_gen_list{i}], [target_dir fp 'src' fp 'nn'])
            end
        end
    end

    % graphs
    if compile_dir('graphs')
        graphs_gen_list = getGenerators([source_dir fp 'graphs']);
        for i = 1:numel(graphs_gen_list)
            if compile_el('graphs', graphs_gen_list{i})
                create_Element([source_dir fp 'graphs' fp graphs_gen_list{i}], [target_dir fp 'graphs'])
            end
        end
    end

    % measures
    if compile_dir('measures')
        measures_gen_list = getGenerators([source_dir fp 'measures']);
        for i = 1:numel(measures_gen_list)
            if compile_el('measures', measures_gen_list{i})
                create_Element([source_dir fp 'measures' fp measures_gen_list{i}], [target_dir fp 'measures'])
            end
        end
    end

    % neural networks
    if compile_dir('neuralnetworks')
        neuralnetworks_gen_list = getGenerators([source_dir fp 'neuralnetworks']);
        for i = 1:numel(neuralnetworks_gen_list)
            if compile_el('neuralnetworks', neuralnetworks_gen_list{i})
                create_Element([source_dir fp 'neuralnetworks' fp neuralnetworks_gen_list{i}], [target_dir fp 'neuralnetworks'])
            end
        end
    end

    % gui
    if compile_dir('gui')
        gui_gen_list = getGenerators([source_dir fp 'src' fp 'gui']);
        for i = 1:numel(gui_gen_list)
            if compile_el('gui', gui_gen_list{i})
                create_Element([source_dir fp 'src' fp 'gui' fp gui_gen_list{i}], [target_dir fp 'src' fp 'gui'])
            end
        end

        if compile_dir('gui_examples')
            gui_examples_gen_list = getGenerators([source_dir fp 'src' fp 'gui' fp 'gui_examples']);
            for i = 1:numel(gui_examples_gen_list)
                if compile_el('gui_examples', gui_examples_gen_list{i})
                    create_Element([source_dir fp 'src' fp 'gui' fp 'gui_examples' fp gui_examples_gen_list{i}], [target_dir fp 'src' fp 'gui' fp 'gui_examples'])
                end
            end
        end
    end

    % pipelines
    if compile_dir('pipelines')
        pipelines_contents = dir([source_dir fp 'pipelines']);  % get the folder contents
        pipelines_dir_list = pipelines_contents([pipelines_contents(:).isdir] == 1);  % remove all files (isdir property is 0)
        pipelines_dir_list = pipelines_dir_list(~ismember({pipelines_dir_list(:).name}, {'.', '..'}));  % remove '.' and '..'
        for i = 1:1:length(pipelines_dir_list)
            pipeline_dir_name = pipelines_dir_list(i).name;
            if compile_pip_dir(pipeline_dir_name)
                pipeline_gen_list = getGenerators([source_dir fp 'pipelines' fp pipeline_dir_name]);
                for j = 1:numel(pipeline_gen_list)
                    if compile_pip_el(pipeline_dir_name, pipeline_gen_list{j})
                        create_Element([source_dir fp 'pipelines' fp pipeline_dir_name fp pipeline_gen_list{j}], [target_dir fp 'pipelines' fp pipeline_dir_name])
                    end
                end
            end
        end
    end

    % sandbox
    if compile_dir('sandbox')
        sandbox_gen_list = getGenerators([source_dir fp 'sandbox']);
        for i = 1:numel(sandbox_gen_list)
            if compile_el('sandbox', sandbox_gen_list{i})
                create_Element([source_dir fp 'sandbox' fp sandbox_gen_list{i}], [target_dir fp 'sandbox'])
            end
        end
    end
    
    % LOAD BRAPH2
    addpath(target_dir)
    braph2(false, 'warning')

    disp('¡! loaded BRAPH2')
    disp(' ')
    
    disp(['¡! completed run number ' int2str(run)])
    disp(' ')
end

%% CREATE LAYOUTS
% src
if compile_dir('util')
    util_gen_list = getGenerators([source_dir fp 'src' fp 'util']);
    for i = 1:numel(util_gen_list)
        if compile_el('util', util_gen_list{i})
            create_layout([source_dir fp 'src' fp 'util' fp util_gen_list{i}], [target_dir fp 'src' fp 'gui' fp 'layouts'])
        end
    end
end

if compile_dir('ds')
    ds_gen_list = getGenerators([source_dir fp 'src' fp 'ds']);
    for i = 1:numel(ds_gen_list)
        if compile_el('ds', ds_gen_list{i})
            create_layout([source_dir fp 'src' fp 'ds' fp ds_gen_list{i}], [target_dir fp 'src' fp 'gui' fp 'layouts'])
        end
    end

    if compile_dir('ds_examples')
        ds_examples_gen_list = getGenerators([source_dir fp 'src' fp 'ds' fp 'ds_examples']);
        for i = 1:numel(ds_examples_gen_list)
            if compile_el('ds_examples', ds_examples_gen_list{i})
                create_layout([source_dir fp 'src' fp 'ds' fp 'ds_examples' fp ds_examples_gen_list{i}], [target_dir fp 'src' fp 'gui' fp 'layouts'])
            end
        end
    end
end

if compile_dir('atlas')
    atlas_gen_list = getGenerators([source_dir fp 'src' fp 'atlas']);
    for i = 1:numel(atlas_gen_list)
        if compile_el('atlas', atlas_gen_list{i})
            create_layout([source_dir fp 'src' fp 'atlas' fp atlas_gen_list{i}], [target_dir fp 'src' fp 'gui' fp 'layouts'])
        end
    end
end

if compile_dir('gt')
    gt_gen_list = getGenerators([source_dir fp 'src' fp 'gt']);
    for i = 1:numel(gt_gen_list)
        if compile_el('gt', gt_gen_list{i})
            create_layout([source_dir fp 'src' fp 'gt' fp gt_gen_list{i}], [target_dir fp 'src' fp 'gui' fp 'layouts'])
        end
    end
end

if compile_dir('cohort')
    cohort_gen_list = getGenerators([source_dir fp 'src' fp 'cohort']);
    for i = 1:numel(cohort_gen_list)
        if compile_el('cohort', cohort_gen_list{i})
            create_layout([source_dir fp 'src' fp 'cohort' fp cohort_gen_list{i}], [target_dir fp 'src' fp 'gui' fp 'layouts'])
        end
    end
end

if compile_dir('analysis')
    analysis_gen_list = getGenerators([source_dir fp 'src' fp 'analysis']);
    for i = 1:numel(analysis_gen_list)
        if ~any(strcmp('analysis', analysis_gen_list{i}))
            create_layout([source_dir fp 'src' fp 'analysis' fp analysis_gen_list{i}], [target_dir fp 'src' fp 'gui' fp 'layouts'])
        end
    end
end

% nn
if compile_dir('nn')
    nn_gen_list = getGenerators([source_dir fp 'src' fp 'nn']);
    for i = 1:numel(nn_gen_list)
        if compile_el('nn', nn_gen_list{i})
            create_layout([source_dir fp 'src' fp 'nn' fp nn_gen_list{i}], [target_dir fp 'src' fp 'gui' fp 'layouts'])
        end
    end
end

% gui
if compile_dir('gui')
    gui_gen_list = getGenerators([source_dir fp 'src' fp 'gui']);
    for i = 1:numel(gui_gen_list)
        if compile_el('gui', gui_gen_list{i})
            create_layout([source_dir fp 'src' fp 'gui' fp gui_gen_list{i}], [target_dir fp 'src' fp 'gui' fp 'layouts'])
        end
    end

    if compile_dir('ds_examples')
        gui_examples_gen_list = getGenerators([source_dir fp 'src' fp 'gui' fp 'ds_examples']);
        for i = 1:numel(gui_examples_gen_list)
            if compile_el('', gui_examples_gen_list{i})
                create_layout([source_dir fp 'src' fp 'gui' fp 'ds_examples' fp gui_examples_gen_list{i}], [target_dir fp 'src' fp 'gui' fp 'layouts'])
            end
        end
    end    
end

% graphs
if compile_dir('graphs')
    graphs_gen_list = getGenerators([source_dir fp 'graphs']);
    for i = 1:numel(graphs_gen_list)
        if compile_el('graphs', graphs_gen_list{i})
            create_layout([source_dir fp 'graphs' fp graphs_gen_list{i}], [target_dir fp 'src' fp 'gui' fp 'layouts'])
        end
    end
end

% measures
if compile_dir('measures')
    measures_gen_list = getGenerators([source_dir fp 'measures']);
    for i = 1:numel(measures_gen_list)
        if compile_el('measures', measures_gen_list{i})
            create_layout([source_dir fp 'measures' fp measures_gen_list{i}], [target_dir fp 'src' fp 'gui' fp 'layouts'])
        end
    end
end

% neuralnetworks
if compile_dir('neuralnetworks')
    neuralnetworks_gen_list = getGenerators([source_dir fp 'neuralnetworks']);
    for i = 1:numel(neuralnetworks_gen_list)
        if compile_el('neuralnetworks', neuralnetworks_gen_list{i})
            create_layout([source_dir fp 'neuralnetworks' fp neuralnetworks_gen_list{i}], [target_dir fp 'src' fp 'gui' fp 'layouts'])
        end
    end 
end

% pipelines
if compile_dir('pipelines')
    pipelines_contents = dir([source_dir fp 'pipelines']);  % get the folder contents
    pipelines_dir_list = pipelines_contents([pipelines_contents(:).isdir] == 1);  % remove all files (isdir property is 0)
    pipelines_dir_list = pipelines_dir_list(~ismember({pipelines_dir_list(:).name}, {'.', '..'}));  % remove '.' and '..'
    for i = 1:1:length(pipelines_dir_list)
        pipeline_dir_name = pipelines_dir_list(i).name;
        if compile_pip_dir(pipeline_dir_name)
            pipeline_gen_list = getGenerators([source_dir fp 'pipelines' fp pipeline_dir_name]);
            for j = 1:numel(pipeline_gen_list)
                if compile_pip_el(pipeline_dir_name, pipeline_gen_list{j})
                    create_layout([source_dir fp 'pipelines' fp pipeline_dir_name fp pipeline_gen_list{j}], [target_dir fp 'src' fp 'gui' fp 'layouts'])
                end
            end
        end
    end
end

% sandbox
if compile_dir('sandbox')
    sandbox_gen_list = getGenerators([source_dir fp 'sandbox']);
    for i = 1:numel(sandbox_gen_list)
        if compile_el('sandbox', sandbox_gen_list{i})
            create_layout([source_dir fp 'sandbox' fp sandbox_gen_list{i}], [target_dir fp 'src' fp 'gui' fp 'layouts'])
        end
    end
end

%% CREATE TEST
% src
if compile_dir('util')
    util_gen_list = getGenerators([source_dir fp 'src' fp 'util']);
    for i = 1:numel(util_gen_list)
        if compile_el('util', util_gen_list{i})
            create_test_Element([source_dir fp 'src' fp 'util' fp util_gen_list{i}], [target_dir fp 'src' fp 'util'])
        end
    end
end

if compile_dir('ds')
    ds_gen_list = getGenerators([source_dir fp 'src' fp 'ds']);
    for i = 1:numel(ds_gen_list)
        if compile_el('ds', ds_gen_list{i})
            create_test_Element([source_dir fp 'src' fp 'ds' fp ds_gen_list{i}], [target_dir fp 'src' fp 'ds'])
        end
    end

    if compile_dir('ds_examples')
        ds_examples_gen_list = getGenerators([source_dir fp 'src' fp 'ds' fp 'ds_examples']);
        for i = 1:numel(ds_examples_gen_list)
            if compile_el('ds_examples', ds_examples_gen_list{i})
                create_test_Element([source_dir fp 'src' fp 'ds' fp 'ds_examples' fp ds_examples_gen_list{i}], [target_dir fp 'src' fp 'ds' fp 'ds_examples'])
            end
        end
    end
end


if compile_dir('atlas')
    atlas_gen_list = getGenerators([source_dir fp 'src' fp 'atlas']);
    for i = 1:numel(atlas_gen_list)
        if compile_el('atals', atlas_gen_list{i})
            create_test_Element([source_dir fp 'src' fp 'atlas' fp atlas_gen_list{i}], [target_dir fp 'src' fp 'atlas'])
        end
    end
end

if compile_dir('gt')
    gt_gen_list = getGenerators([source_dir fp 'src' fp 'gt']);
    for i = 1:numel(gt_gen_list)
        if compile_el('gt', gt_gen_list{i})
            create_test_Element([source_dir fp 'src' fp 'gt' fp gt_gen_list{i}], [target_dir fp 'src' fp 'gt'])
        end
    end
end

if compile_dir('cohort')
    cohort_gen_list = getGenerators([source_dir fp 'src' fp 'cohort']);
    for i = 1:numel(cohort_gen_list)
        if compile_el('cohort', cohort_gen_list{i})
            create_test_Element([source_dir fp 'src' fp 'cohort' fp cohort_gen_list{i}], [target_dir fp 'src' fp 'cohort'])
        end
    end
end

if compile_dir('analysis')
    analysis_gen_list = getGenerators([source_dir fp 'src' fp 'analysis']);
    for i = 1:numel(analysis_gen_list)
        if compile_el('analysis', analysis_gen_list{i})
            create_test_Element([source_dir fp 'src' fp 'analysis' fp analysis_gen_list{i}], [target_dir fp 'src' fp 'analysis'])
        end
    end
end

% nn
if compile_dir('nn')
    nn_gen_list = getGenerators([source_dir fp 'src' fp 'nn']);
    for i = 1:numel(nn_gen_list)
        if compile_el('nn', nn_gen_list{i})
            create_test_Element([source_dir fp 'src' fp 'nn' fp nn_gen_list{i}], [target_dir fp 'src' fp 'nn'])
        end
    end
end

% gui
if compile_dir('gui')
    gui_gen_list = getGenerators([source_dir fp 'src' fp 'gui']);
    for i = 1:numel(gui_gen_list)
        if compile_el('gui', gui_gen_list{i})
            create_test_Element([source_dir fp 'src' fp 'gui' fp gui_gen_list{i}], [target_dir fp 'src' fp 'gui'])
        end
    end

    if compile_dir('gui_examples')
        gui_examples_gen_list = getGenerators([source_dir fp 'src' fp 'gui' fp 'gui_examples']);
        for i = 1:numel(gui_examples_gen_list)
            if compile_el('gui_examples', gui_examples_gen_list{i})
                create_test_Element([source_dir fp 'src' fp 'gui' fp 'gui_examples' fp gui_examples_gen_list{i}], [target_dir fp 'src' fp 'gui' fp 'gui_examples'])
            end
        end
    end
end

% graphs
if compile_dir('graphs')
    graphs_gen_list = getGenerators([source_dir fp 'graphs']);
    for i = 1:numel(graphs_gen_list)
        if compile_el('graphs', graphs_gen_list{i})
            create_test_Element([source_dir fp 'graphs' fp graphs_gen_list{i}], [target_dir fp 'graphs'])
        end
    end
end

% measures
if compile_dir('measures')
    measures_gen_list = getGenerators([source_dir fp 'measures']);
    for i = 1:numel(measures_gen_list)
        if compile_el('measures', measures_gen_list{i})
            create_test_Element([source_dir fp 'measures' fp measures_gen_list{i}], [target_dir fp 'measures'])
        end
    end
end

% neuralnetworks
if compile_dir('neuralnetworks')
    neuralnetworks_gen_list = getGenerators([source_dir fp 'neuralnetworks']);
    for i = 1:numel(neuralnetworks_gen_list)
        if compile_el('neuralnetworks', neuralnetworks_gen_list{i})
            create_test_Element([source_dir fp 'neuralnetworks' fp neuralnetworks_gen_list{i}], [target_dir fp 'neuralnetworks'])
        end
    end
end

% pipelines
if compile_dir('pipelines')
    pipelines_contents = dir([source_dir fp 'pipelines']);  % get the folder contents
    pipelines_dir_list = pipelines_contents([pipelines_contents(:).isdir] == 1);  % remove all files (isdir property is 0)
    pipelines_dir_list = pipelines_dir_list(~ismember({pipelines_dir_list(:).name}, {'.', '..'}));  % remove '.' and '..'
    for i = 1:1:length(pipelines_dir_list)
        pipeline_dir_name = pipelines_dir_list(i).name;
        if compile_pip_dir(pipeline_dir_name)
            pipeline_gen_list = getGenerators([source_dir fp 'pipelines' fp pipeline_dir_name]);
            for j = 1:numel(pipeline_gen_list)
                if compile_pip_el(pipeline_dir_name, pipeline_gen_list{j})
                    create_test_Element([source_dir fp 'pipelines' fp pipeline_dir_name fp pipeline_gen_list{j}], [target_dir fp 'pipelines' fp pipeline_dir_name])
                end
            end
        end
    end
end

% sandbox
if compile_dir('sandbox')
    sandbox_gen_list = getGenerators([source_dir fp 'sandbox']);
    for i = 1:numel(sandbox_gen_list)
        if compile_el('sandbox', sandbox_gen_list{i})
            create_test_Element([source_dir fp 'sandbox' fp sandbox_gen_list{i}], [target_dir fp 'sandbox'])
        end
    end
end

%% LOG ELEMENT BUILD
build_log{1, 1} = 'BRAPH2';
build_log{1, 2} = BRAPH2.BUILD;
el_list = Element.getSubclasses();
for i = 1:numel(el_list)
    el = el_list{i};
    build_log{1 + i, 1} = el;
    build_log{1 + i, 2} = Element.getBuild(el);
end

save([target_dir filesep() 'build_log.mat'], 'build_log', 'run_number', 'rollcall')
writecell(build_log, [target_dir filesep() 'build_log.txt'])

end