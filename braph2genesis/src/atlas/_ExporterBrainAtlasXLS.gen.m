%% ¡header!
ExporterBrainAtlasXLS < Exporter (ex, brain atlas exporter in XLS) exports a brain atlas to an XLS/XLSX file.

%%% ¡description!
A Brain Atlas Exporter in XLS Files (ExporterBrainAtlasXLS) exports a brain atlas to an XLS/XLSX file.

%%% ¡seealso!
BrainAtlas, ImporterBrainAtlasXLS

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the brain atlas exporter in XLS.
%%%% ¡default!
'ExporterBrainAtlasXLS'

%%% ¡prop!
NAME (constant, string) is the name of the brain atlas exporter in XLS.
%%%% ¡default!
'Brain Atlas Exporter in XLS Files'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the brain atlas exporter in XLS.
%%%% ¡default!
'A Brain Atlas Exporter in XLS Files (ExporterBrainAtlasXLS) exports a brain atlas to an XLS/XLSX file.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the brain atlas exporter in XLS.
%%%% ¡settings!
'ExporterBrainAtlasXLS'

%%% ¡prop!
ID (data, string) is a few-letter code for the brain atlas exporter in XLS.
%%%% ¡default!
'ExporterBrainAtlasXLS ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the brain atlas exporter in XLS.
%%%% ¡default!
'ExporterBrainAtlasXLS label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the brain atlas exporter in XLS.
%%%% ¡default!
'ExporterBrainAtlasXLS notes'

%% ¡props!

%%% ¡prop!
BA (data, item) is a brain atlas.
%%%% ¡settings!
'BrainAtlas'

%%% ¡prop!
FILE (data, string) is the XLS/XLSX file where to save the brain atlas.
%%%% ¡default!
[fileparts(which('test_braph2')) filesep 'default_xls_file_to_save_brain_atlas_most_likely_to_be_erased.xlsx']

%%% ¡prop!
PUT_FILE (query, item) opens a dialog box to set the XLS/XLSX file where to save the brain atlas.
%%%% ¡settings!
'ExporterBrainAtlasXLS'
%%%% ¡calculate!
[filename, filepath, filterindex] = uiputfile({'*.xlsx';'*.xls'}, 'Select Excel file');
if filterindex
    file = [filepath filename];
    ex.set('FILE', file);
end
value = ex;

%%% ¡prop!
SAVE (result, empty) saves the brain atlas in the selected XLS/XLSX file.
%%%% ¡calculate!
file = ex.get('FILE');

if isfolder(fileparts(file))
	wb = braph2waitbar(ex.get('WAITBAR'), 0, 'Retrieving path ...');
    
    ba = ex.get('BA');
    ba_id = ba.get('ID');
    if ~isempty(ba.get('LABEL'))
        ba_label = ba.get('LABEL');
    else
        ba_label = ' ';
    end
    if ~isempty(ba.get('NOTES'))
        ba_notes = ba.get('NOTES');
    else
        ba_notes = ' ';
    end

    % gets brain region data
	braph2waitbar(wb, .15, 'Organizing info ...')
    
    br_dict = ba.get('BR_DICT');
    br_ids = cell(br_dict.get('LENGTH'), 1);
    br_labels = cell(br_dict.get('LENGTH'), 1);
    br_notes = cell(br_dict.get('LENGTH'), 1);
    br_x = cell(br_dict.get('LENGTH'), 1);
    br_y = cell(br_dict.get('LENGTH'), 1);
    br_z = cell(br_dict.get('LENGTH'), 1);
    for i = 1:1:br_dict.get('LENGTH')
        braph2waitbar(wb, .25 + .75 * i / br_dict.get('LENGTH'), ['Saving brain region ' num2str(i) ' of ' num2str(br_dict.get('LENGTH'))])
        
        br = br_dict.get('IT', i);
        br_ids{i} = br.get('ID');
        if ~isempty(br.get('LABEL'))
            br_labels{i} = br.get('LABEL');
        else
            br_labels{i} = ' ';
        end
        if ~isempty(br.get('NOTES'))
            br_notes{i} = br.get('NOTES');
        else
            br_notes{i} = ' ';
        end
        br_x{i} = br.get('X');
        br_y{i} = br.get('Y');
        br_z{i} = br.get('Z');
    end

    % creates table
    tab = [
        {ba_id, {}, {}, {}, {}, {}};
        {ba_label, {}, {}, {}, {}, {}};
        {ba_notes, {}, {}, {}, {}, {}};
        {{}, {}, {}, {}, {}, {}};
        table(br_ids, br_labels, br_x, br_y, br_z, br_notes)
        ];

    % save
    braph2waitbar(wb, 1, 'Finalizing ...')
    
    writetable(tab, file, 'Sheet', 1, 'WriteVariableNames', false);

    braph2waitbar(wb, 'close')
end

% sets value to empty    
value = [];

%% ¡tests!

%%% ¡excluded_props!
[ExporterBrainAtlasXLS.PUT_FILE]

%%% ¡test!
%%%% ¡name!
Delete file TBE
%%%% ¡probability!
1
%%%% ¡code!
warning('off', 'MATLAB:DELETE:FileNotFound')
delete([fileparts(which('test_braph2')) filesep 'default_xls_file_to_save_brain_atlas_most_likely_to_be_erased.xlsx'])
warning('on', 'MATLAB:DELETE:FileNotFound')

%%% ¡test!
%%%% ¡name!
Export and import
%%%% ¡probability!
.01
%%%% ¡code!
br1 = BrainRegion( ...
    'ID', 'ISF', ...
    'LABEL', 'superiorfrontal', ...
    'NOTES', 'notes1', ...
    'X', -12.6, ...
    'Y', 22.9, ...
    'Z', 42.4 ...
    );
br2 = BrainRegion( ...
    'ID', 'lFP', ...
    'LABEL', 'frontalpole', ...
    'NOTES', 'notes2', ...
    'X', -8.6, ...
    'Y', 61.7, ...
    'Z', -8.7 ...
    );
br3 = BrainRegion( ...
    'ID', 'lRMF', ...
    'LABEL', 'rostralmiddlefrontal', ...
    'NOTES', 'notes3', ...
    'X', -31.3, ...
    'Y', 41.2, ...
    'Z', 16.5 ...
    );
br4 = BrainRegion( ...
    'ID', 'lCMF', ...
    'LABEL', 'caudalmiddlefrontal', ...
    'NOTES', 'notes4', ...
    'X', -34.6, ...
    'Y', 10.2, ...
    'Z', 42.8 ...
    );
br5 = BrainRegion( ...
    'ID', 'lPOB', ...
    'LABEL', 'parsorbitalis', ...
    'NOTES', 'notes5', ...
    'X', -41, ...
    'Y', 38.8, ...
    'Z', -11.1 ...
    );
ba = BrainAtlas( ...
    'ID', 'TestToSaveCoolID', ...
    'LABEL', 'Brain Atlas', ...
    'NOTES', 'Brain atlas notes', ...
    'BR_DICT', IndexedDictionary('IT_CLASS', 'BrainRegion', 'IT_LIST', {br1, br2, br3, br4, br5}) ...
    );

file = [fileparts(which('test_braph2')) filesep 'trial_atlas_to_be_erased.xlsx'];

ex = ExporterBrainAtlasXLS( ...
    'FILE', file, ...
    'BA', ba ...
    );
ex.get('SAVE');

im = ImporterBrainAtlasXLS( ...
    'FILE', file ...
    );
ba_loaded = im.get('BA');

assert(isequal(ba.get('ID'), ba_loaded.get('ID')), ...
	[BRAPH2.STR ':ImporterBrainAtlasXLS:' BRAPH2.FAIL_TEST], ...
    'Problems saving or loading a brain atlas.')
assert(ba.get('BR_DICT').get('LENGTH') == ba_loaded.get('BR_DICT').get('LENGTH'), ...
	[BRAPH2.STR ':ImporterBrainAtlasXLS:' BRAPH2.FAIL_TEST], ...
    'Problems saving or loading a brain atlas.')
for i = 1:1:max(ba.get('BR_DICT').get('LENGTH'), ba_loaded.get('BR_DICT').get('LENGTH'))
    br = ba.get('BR_DICT').get('IT', i);
    br_loaded = ba_loaded.get('BR_DICT').get('IT', i);    
    assert( ...
        isequal(br.get('ID'), br_loaded.get('ID')) & ...
        isequal(br.get('LABEL'), br_loaded.get('LABEL')) & ...
        isequal(br.get('NOTES'), br_loaded.get('NOTES')) & ...
        isequal(br.get('X'), br_loaded.get('X')) & ...
        isequal(br.get('Y'), br_loaded.get('Y')) & ...
        isequal(br.get('Z'), br_loaded.get('Z')), ...
        [BRAPH2.STR ':ImporterBrainAtlasXLS:' BRAPH2.FAIL_TEST], ...
        'Problems saving or loading a brain atlas.')    
end

delete(file)