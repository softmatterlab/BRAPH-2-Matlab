%% ¡header!
ImporterBrainAtlasTXT < Importer (im, brain atlas importer from TXT) imports a brain atlas from a TXT file.

%%% ¡description!
A Brain Atlas Importer from TXT Files (ImporterBrainAtlasTXT) imports a 
 brain atlas from a TXT file.
The TXT file consists of 6 columns and many rows. The first 4 rows: 
 BrainAtlas ID (row 1, column 1), BrainAtlas LABEL (row 2, column 1), 
 BrainAtlas NOTES (row 3, column 1), BrainSurface Name (row 4, column 1).
 And from row 5 to the end, the following columns: BrainRegion ID (column 1),
 BrainRegion LABEL (column 2), BrainRegions (column 3 to column 5; 
 coordinates x, y, z, one per column), and BrainRegion NOTES (column 6).

%%% ¡seealso!
BrainAtlas, ExporterBrainAtlasTXT

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the brain atlas importer from TXT.
%%%% ¡default!
'ImporterBrainAtlasTXT'

%%% ¡prop!
NAME (constant, string) is the name of the brain atlas importer from TXT.
%%%% ¡default!
'Brain Atlas Importer from TXT Files'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the brain atlas importer from TXT.
%%%% ¡default!
'A Brain Atlas Importer from TXT Files (ImporterBrainAtlasTXT) imports a brain atlas from a TXT file. The TXT file consists of 6 columns and many rows. The first 4 rows: BrainAtlas ID (row 1, column 1), BrainAtlas LABEL (row 2, column 1), BrainAtlas NOTES (row 3, column 1), BrainSurface Name (row 4, column 1). And from row 5 to the end, the following columns: BrainRegion ID (column 1), BrainRegion LABEL (column 2), BrainRegions (column 3 to column 5; coordinates x, y, z, one per column), and BrainRegion NOTES (column 6).'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the brain atlas importer from TXT.
%%%% ¡settings!
'ImporterBrainAtlasTXT'

%%% ¡prop!
ID (data, string) is a few-letter code for the brain atlas importer from TXT.
%%%% ¡default!
'ImporterBrainAtlasTXT ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the brain atlas importer from TXT.
%%%% ¡default!
'ImporterBrainAtlasTXT label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the brain atlas importer from TXT.
%%%% ¡default!
'ImporterBrainAtlasTXT notes'

%% ¡props!

%%% ¡prop!
FILE (data, string) is the TXT file from where to load the brain atlas.
%%%% ¡default!
'desikan_atlas.txt'

%%% ¡prop!
GET_FILE (query, item) opens a dialog box to get the TXT file from where to load the brain atlas.
%%%% ¡settings!
'ImporterBrainAtlasTXT'
%%%% ¡calculate!
[filename, filepath, filterindex] = uigetfile('*.txt', 'Select TXT file');
if filterindex
    file = [filepath filename];
    im.set('FILE', file);
end
value = im;

%%% ¡prop!
BA (result, item) is a brain atlas.
%%%% ¡settings!
'BrainAtlas'
%%%% ¡default!
BrainAtlas()
%%%% ¡calculate!
% creates empty BrainAtlas
ba = BrainAtlas();

% analyzes file
file = im.get('FILE');
if ~isfile(file)
    file = [fileparts(which('braph2')) filesep 'atlases' filesep file];
end

if isfile(file)
	wb = braph2waitbar(im.get('WAITBAR'), 0, 'Reading brain atlas file ...');

    try
        raw = textread(file, '%s', 'delimiter', '\t', 'whitespace', '');
        raw = raw(~cellfun('isempty', raw));  % remove empty cells
        
        % adds props
        braph2waitbar(wb, .15, 'Loading brain atlas file ...')
        
        ba.set( ...
            'ID', raw{1, 1}, ...
            'LABEL', raw{2, 1}, ...
            'NOTES', raw{3, 1} ...
            );
        
        idict = ba.get('BR_DICT');
        
        % adds brain regions
        braph2waitbar(wb, .25, 'Extracting brain regions ...')
        
        for i = 4:6:size(raw, 1)
            braph2waitbar(wb, .25 + .75 * i / size(raw, 1), ['Loading brain region ' num2str((i - 4) / 6 + 1) ' of ' num2str((size(raw, 1) - 3) / 6) ' ...'])
            
            br = BrainRegion( ...
                'ID', char(raw{i, 1}), ...
                'LABEL', char(raw{i+1, 1}), ...
                'X', str2double(raw{i+2, 1}), ...
                'Y', str2double(raw{i+3, 1}), ...
                'Z', str2double(raw{i+4, 1}), ...
                'NOTES', char(raw{i+5, 1}) ...
                );
            idict.get('ADD', br);
        end
        ba.set('BR_DICT', idict);
    catch e
	braph2waitbar(wb, 'close')
        
        rethrow(e)
    end
    
    braph2waitbar(wb, 'close')
else
    error([BRAPH2.STR ':ImporterBrainAtlasXLS:' BRAPH2.CANCEL_IO], ...
        [BRAPH2.STR ':ImporterBrainAtlasXLS:' BRAPH2.CANCEL_IO '\\n' ...
        'The prop FILE must be an existing file, but it is ''' file '''.'] ...
        );
end

value = ba;

%% ¡tests!

%%% ¡excluded_props!
[ImporterBrainAtlasTXT.GET_FILE]