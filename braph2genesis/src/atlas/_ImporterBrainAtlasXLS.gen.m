%% ¡header!
ImporterBrainAtlasXLS < Importer (im, brain atlas importer from XLS/XLSX) imports a brain atlas from an XLS/XLSX file.

%%% ¡description!
A Brain Atlas Importer from XLS/XLSX Files (ImporterBrainAtlasXLS) imports a 
 brain atlas from an XLS/XLSX file.
The XLS file consists of 6 columns and many rows. The first 4 rows: 
 BrainAtlas ID (row 1, column 1), BrainAtlas LABEL (row 2, column 1), 
 BrainAtlas NOTES (row 3, column 1), BrainSurface Name (row 4, column 1).
 And from row 5 to the end, the following columns: BrainRegion ID (column 1),
 BrainRegion LABEL (column 2), BrainRegions (column 3 to column 5; 
 coordinates x, y, z, one per column), and BrainRegion NOTES (column 6).

%%% ¡seealso!
BrainAtlas, ExporterBrainAtlasXLS

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the brain atlas importer from XLS/XLSX.
%%%% ¡default!
'ImporterBrainAtlasXLS'

%%% ¡prop!
NAME (constant, string) is the name of the brain atlas importer from XLS/XLSX.
%%%% ¡default!
'Brain Atlas Importer from XLS/XLSX Files'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the brain atlas importer from XLS/XLSX.
%%%% ¡default!
'A Brain Atlas Importer from XLS/XLSX Files (ImporterBrainAtlasXLS) imports a brain atlas from an XLS/XLSX file. The XLS file consists of 6 columns and many rows. The first 4 rows: BrainAtlas ID (row 1, column 1), BrainAtlas LABEL (row 2, column 1), BrainAtlas NOTES (row 3, column 1), BrainSurface Name (row 4, column 1). And from row 5 to the end, the following columns: BrainRegion ID (column 1), BrainRegion LABEL (column 2), BrainRegions (column 3 to column 5; coordinates x, y, z, one per column), and BrainRegion NOTES (column 6).'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the brain atlas importer from XLS/XLSX.
%%%% ¡settings!
'ImporterBrainAtlasXLS'

%%% ¡prop!
ID (data, string) is a few-letter code for the brain atlas importer from XLS/XLSX.
%%%% ¡default!
'ImporterBrainAtlasXLS ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the brain atlas importer from XLS/XLSX.
%%%% ¡default!
'ImporterBrainAtlasXLS label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the brain atlas importer from XLS/XLSX.
%%%% ¡default!
'ImporterBrainAtlasXLS notes'

%% ¡props!

%%% ¡prop!
FILE (data, string) is the XLS/XLSX file from where to load the brain atlas.
%%%% ¡default!
'desikan_atlas.xlsx'

%%% ¡prop!
GET_FILE (query, item) opens a dialog box to get the XLS/XLSX file from where to load the brain atlas.
%%%% ¡settings!
'ImporterBrainAtlasXLS'
%%%% ¡calculate!
[filename, filepath, filterindex] = uigetfile({'*.xlsx';'*.xls'}, 'Select Excel file');
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
    file = [fileparts(which(BRAPH2.LAUNCHER)) filesep 'atlases' filesep file];
end

if isfile(file)
	wb = braph2waitbar(im.get('WAITBAR'), 0, 'Reading File ...');

    try
        [~, ~, raw] = xlsread(file);
        
        % adds props
        braph2waitbar(wb, .15, 'Loading brain atlas file ...');
        
        ba.set( ...
            'ID', raw{1, 1}, ...
            'LABEL', raw{2, 1}, ...
            'NOTES', raw{3, 1} ...
            );
        
        idict = ba.get('BR_DICT');
        
        % adds brain regions
        braph2waitbar(wb, .25, 'Extracting brain regions ...')
        
        for i = 5:1:size(raw, 1)
            braph2waitbar(wb, .25 + .75 * (i - 4) / (size(raw, 1) - 4), ['Loading brain region ' num2str(i - 4) ' of ' num2str(size(raw, 1) - 4) ' ...'])
            
            br = BrainRegion( ...
                'ID', raw{i, 1}, ...
                'LABEL', raw{i, 2}, ...
                'X', raw{i, 3}, ...
                'Y', raw{i, 4}, ...
                'Z', raw{i, 5}, ...
                'NOTES', raw{i, 6} ...
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
[ImporterBrainAtlasXLS.GET_FILE]