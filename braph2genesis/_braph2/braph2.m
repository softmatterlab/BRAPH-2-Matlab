function braph2(gui, ewm)
%BRAPH2 loads BRAPH 2.
%
% BRAPH2 loads all packages that are necessary to use 
%  BRAPH 2 - BRrain Analysis using graPH theory version 2.0.
%
% BRAPH2(true(default)|false) determines whether to open the BRAPH2GUI. 
%
% BRAPH2([], 'msgbox'(default)|'warning'|'error') throws a warning if 
%  the MatLab version is not sufficiently new, 
%  or some necessary addons are not installed.
%
% BRAPH2 uses the following addons:
%  - ST: "Statistics and Machine Learning Toolbox"
%  - DM: "Parallel Computing Toolbox"
%  - NN: "Deep Learning Toolbox"
%
% BRAPH2 packages:
%  <a href="matlab:help src             ">src</a>            - software core
%  <a href="matlab:help brainsurfs      ">brainsurfs</a>     - brain surfaces
%  <a href="matlab:help atlases         ">atlases</a>        - brain atlases
%  <a href="matlab:help graphs          ">graphs</a>         - graphs
%  <a href="matlab:help measures        ">measures</a>       - measures
%  <a href="matlab:help neuralnetworks  ">neuralnetworks</a> - neural networks
%  <a href="matlab:help pipelines       ">pipelines</a>      - pipelines
%  <a href="matlab:help test            ">test</a>           - unit testing
%  <a href="matlab:help sandbox         ">sandbox</a>        - sandbox
%
% See also BRAPH2GUI.

    function add_dir(dir)
        if exist(dir, 'dir')
            addpath(dir)
        end
    end

braph2_dir = fileparts(which(mfilename()));
addpath(braph2_dir)

src_dir = [braph2_dir filesep 'src'];
add_dir(src_dir)
add_dir([src_dir filesep 'util'])
add_dir([src_dir filesep 'ds'])
add_dir([src_dir filesep 'ds' filesep 'ds_examples'])
add_dir([src_dir filesep 'atlas'])
add_dir([src_dir filesep 'gt'])
add_dir([src_dir filesep 'cohort'])
add_dir([src_dir filesep 'analysis'])
add_dir([src_dir filesep 'nn'])
add_dir([src_dir filesep 'gui'])
add_dir([src_dir filesep 'gui' filesep 'gui_examples'])

brainsurfs_dir = [braph2_dir filesep 'brainsurfs'];
add_dir(brainsurfs_dir)

brainsurfs_dir = [braph2_dir filesep 'atlases'];
add_dir(brainsurfs_dir)

graphs_dir = [braph2_dir filesep 'graphs'];
add_dir(graphs_dir)

measures_dir = [braph2_dir filesep 'measures'];
add_dir(measures_dir)

neuralnetworks_dir = [braph2_dir filesep 'neuralnetworks'];
add_dir(neuralnetworks_dir)

test_dir = [braph2_dir filesep 'test'];
add_dir(test_dir)

pipelines_dir = [braph2_dir filesep 'pipelines'];
add_dir(pipelines_dir)
pipelines_dir_list = dir(pipelines_dir); % get the folder contents
pipelines_dir_list = pipelines_dir_list([pipelines_dir_list(:).isdir] == 1); % remove all files (isdir property is 0)
pipelines_dir_list = pipelines_dir_list(~ismember({pipelines_dir_list(:).name}, {'.', '..'})); % remove '.' and '..'
for i = 1:1:length(pipelines_dir_list)
    add_dir([pipelines_dir filesep pipelines_dir_list(i).name])
end

sandbox_dir = [braph2_dir filesep 'sandbox'];
add_dir(sandbox_dir)

if nargin < 2
    ewm = 'msgbox';
end
BRAPH2.checkMatLab(ewm)
BRAPH2.installed('ST', ewm)
BRAPH2.installed('DM', ewm)
BRAPH2.installed('NN', ewm)

if nargin < 1 || isempty(gui) || gui
    BRAPH2GUI()
end

if ispc
    fprintf([ ...
        '\n' ...
        '<strong>@@@@   @@@@    @@@   @@@@   @   @     ####   ####\n</strong>' ...
        '<strong>@   @  @   @  @   @  @   @  @   @        #   #  #\n</strong>' ...
        '<strong>@   @  @   @  @   @  @   @  @   @        #   #  #\n</strong>' ...
        '<strong>@@@@   @@@@   @@@@@  @@@@   @@@@@     ####   #  #\n</strong>' ...
        '<strong>@   @  @  @   @   @  @      @   @     #      #  #\n</strong>' ...
        '<strong>@   @  @  @   @   @  @      @   @     #      #  #\n</strong>' ...
        '<strong>@@@@   @   @  @   @  @      @   @     #### # ####\n</strong>' ...
        '\n' ...
        BRAPH2.DISTRIBUTION '\n' ...
        '\n' ...
        ]);
else
    fprintf([ ...
        '\n' ...
	    ' ████   ████    ███   ████   █   █     ▓▓▓▓▓   ▓▓▓▓▓\n' ...
	    ' █   █  █   █  █   █  █   █  █   █         ▓   ▓   ▓\n' ...
	    ' █   █  █   █  █   █  █   █  █   █         ▓   ▓   ▓\n' ...
	    ' ████   ████   █████  ████   █████     ▓▓▓▓▓   ▓   ▓\n' ...
	    ' █   █  █ █    █   █  █      █   █     ▓       ▓   ▓\n' ...
	    ' █   █  █  █   █   █  █      █   █     ▓       ▓   ▓\n' ...
	    ' ████   █   █  █   █  █      █   █     ▓▓▓▓▓ ▓ ▓▓▓▓▓\n' ...
        '\n' ...
        BRAPH2.DISTRIBUTION '\n' ...
        '\n' ...
        ]);
end
fprintf([ ...
    ' <a href="matlab:BRAPH2GUI()">' BRAPH2.NAME ' ' BRAPH2.DISTRIBUTION '</a>' ...
    ' <a href="matlab:BRAPH2.credits()">CREDITS</a>' ...
    ' <a href="matlab:BRAPH2.license()">LICENSE</a>' ...
    ' <a href="matlab:BRAPH2.web()">' upper(BRAPH2.WEB) '</a>\n' ...
    ' version ' BRAPH2.VERSION ' build ' int2str(BRAPH2.BUILD) '\n' ...
    ' released on ' BRAPH2.RELEASE ...
    ' ' BRAPH2.COPYRIGHT '\n' ...
    '\n' ...
    ]);

end