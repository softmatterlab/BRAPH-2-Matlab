%% ¡header!
ImporterBrainSurfaceNV < Importer (im, brain surface importer from NV) imports a brain surface from a NV file.

%%% ¡description!
A Brain Surface Importer from NV Files (ImporterBrainSurfaceNV) imports a brain surface from a NV file.

%%% ¡seealso!
BrainSurface

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the brain surface importer from NV.
%%%% ¡default!
'ImporterBrainSurfaceNV'

%%% ¡prop!
NAME (constant, string) is the name of the brain surface importer from NV.
%%%% ¡default!
'Brain Surface Importer from NV Files'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the brain surface importer from NV.
%%%% ¡default!
'A Brain Surface Importer from NV Files (ImporterBrainSurfaceNV) imports a brain surface from a NV file.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the importe of the brain surface from NVr.
%%%% ¡settings!
'ImporterBrainSurfaceNV'

%%% ¡prop!
ID (data, string) is a few-letter code for the brain surface importer from NV.
%%%% ¡default!
'ImporterBrainSurfaceNV ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the brain surface importer from NV.
%%%% ¡default!
'ImporterBrainSurfaceNV label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the brain surface importer from NV.
%%%% ¡default!
'ImporterBrainSurfaceNV notes'

%% ¡props!

%%% ¡prop!
FILE (data, string) is the NV file from where to load the brain atlas.
%%%% ¡default!
'human_ICBM152.nv'

%%% ¡prop!
GET_FILE (query, item) opens a dialog box to set the NV file where to save the brain atlas.
%%%% ¡settings!
'ImporterBrainSurfaceNV'
%%%% ¡calculate!
[filename, filepath, filterindex] = uigetfile('*.nv', 'Select NV file');
if filterindex
    file = [filepath filename];
    im.set('FILE', file);
end
value = im;

%%% ¡prop!
SURF (result, item) is a brain surface.
%%%% ¡settings!
'BrainSurface'
%%%% ¡calculate!
% creates empty BrainSurface
bs = BrainSurface();

% analyzes file
file = im.get('FILE');
if ~isfile(file)
    file = [fileparts(which('braph2')) filesep 'brainsurfs' filesep file];
end

if isfile(file)
	wb = braph2waitbar(im.get('WAITBAR'), .15, 'Reading brain surface file ...');
    
    fid = fopen(file);
    vertex_number = fscanf(fid, '%f', 1);
    coord = fscanf(fid, '%f', [3, vertex_number])';
    tri_number = fscanf(fid, '%f', 1);
    tri = fscanf(fid, '%d', [3, tri_number])';
    fclose(fid);
    
    splits = split(file, filesep);
    name = splits{end};
    
    bs.set('ID', name)
    bs.set('VERTEX_NUMBER', vertex_number);
    bs.set('COORDINATES', coord);
    bs.set('TRIANGLES_NUMBER', tri_number);
    bs.set('TRIANGLES', tri);
    
	braph2waitbar(wb, 'close')
else
    error([BRAPH2.STR ':ImporterBrainSurfaceNV:' BRAPH2.CANCEL_IO], ...
        [BRAPH2.STR ':ImporterBrainSurfaceNV:' BRAPH2.CANCEL_IO '\\n' ...
        'The prop FILE must be an existing file, but it is ''' file '''.'] ...
        );    
end

value = bs;

%% ¡tests!

%%% ¡excluded_props!
[ImporterBrainSurfaceNV.GET_FILE]