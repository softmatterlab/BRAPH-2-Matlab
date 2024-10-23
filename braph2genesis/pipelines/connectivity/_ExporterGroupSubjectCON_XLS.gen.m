%% ¡header!
ExporterGroupSubjectCON_XLS < Exporter (ex, exporter of CON subject group in XLSX) exports a group of subjects with connectivity data to a series of XLSX file.

%%% ¡description!
ExporterGroupSubjectCON_XLS exports a group of subjects with connectivity 
 data to a series of XLSX files contained in a folder named "GROUP_ID". 
 All these files are saved in the same folder. Each file contains a table 
 of values corresponding to the adjacency matrix.
The variables of interest (if existing) are saved in another XLSX file 
 named "GROUP_ID.vois.xlsx" consisting of the following columns: 
 Subject ID (column 1), covariates (subsequent columns). 
 The 1st row contains the headers, the 2nd row a string with the categorical
 variables of interest, and each subsequent row the values for each subject.

%%% ¡seealso!
Group, SunbjectCON, ImporterGroupSubjectCON_XLS

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the CON subject group exporter in XLSX.
%%%% ¡default!
'ExporterGroupSubjectCON_XLS'

%%% ¡prop!
NAME (constant, string) is the name of the CON subject group exporter in XLSX.
%%%% ¡default!
'Connectivity Subject Group XLS Exporter'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the CON subject group exporter in XLSX.
%%%% ¡default!
'ExporterGroupSubjectCON_XLS exports a group of subjects with connectivity data to a series of XLSX files. The variables of interest (if existing) are saved in another XLSX file.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the CON subject group exporter in XLSX.
%%%% ¡settings!
'ExporterGroupSubjectCON_XLS'

%%% ¡prop!
ID (data, string) is a few-letter code for the CON subject group exporter in XLSX.
%%%% ¡default!
'ExporterGroupSubjectCON_XLS ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the CON subject group exporter in XLSX.
%%%% ¡default!
'ExporterGroupSubjectCON_XLS label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the CON subject group exporter in XLSX.
%%%% ¡default!
'ExporterGroupSubjectCON_XLS notes'

%% ¡props!

%%% ¡prop!
GR (data, item) is a group of subjects with connectivity data.
%%%% ¡settings!
'Group'
%%%% ¡check_value!
check = any(strcmp(value.get(Group.SUB_CLASS_TAG), subclasses('SubjectCON', [], [], true))); % Format.checkFormat(Format.ITEM, value, 'Group') already checked
%%%% ¡default!
Group('SUB_CLASS', 'SubjectCON', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON'))

%%% ¡prop!
DIRECTORY (data, string) is the directory name where to save the group of subjects with connectivity data.
%%%% ¡default!
[fileparts(which('test_braph2')) filesep 'default_group_subjects_CON_most_likely_to_be_erased']

%%% ¡prop!
PUT_DIR (query, item) opens a dialog box to set the directory where to save the group of subjects with connectivity data.
%%%% ¡settings!
'ExporterGroupSubjectCON_XLS'
%%%% ¡calculate!
directory = uigetdir('Select directory');
if ischar(directory) && isfolder(directory)
    ex.set('DIRECTORY', directory);
end
value = ex;

%%% ¡prop!
SAVE (result, empty) saves the group of subjects with connectivity data in XLSX files in the selected directory.
%%%% ¡calculate!
directory = ex.get('DIRECTORY');

if isfolder(directory)
    wb = braph2waitbar(ex.get('WAITBAR'), 0, 'Retrieving path ...');
    
    gr = ex.get('GR');

    gr_directory = [directory filesep() gr.get('ID')];
    if ~exist(gr_directory, 'dir')
        mkdir(gr_directory)
    end
    
	braph2waitbar(wb, .15, 'Organizing info ...')
    
    sub_dict = gr.get('SUB_DICT');
    sub_number = sub_dict.get('LENGTH');

    for i = 1:1:sub_number
        braph2waitbar(wb, .15 + .85 * i / sub_number, ['Saving subject ' num2str(i) ' of ' num2str(sub_number) ' ...'])
        
        sub = sub_dict.get('IT', i);
        sub_id = sub.get('ID');
        sub_CON = sub.get('CON');
        
        tab = table(sub_CON);

        sub_file = [gr_directory filesep() sub_id '.xlsx'];

        % save file
        writetable(tab, sub_file, 'WriteVariableNames', false);
    end
    
    % variables of interest
    voi_ids = {};
    for i = 1:1:sub_number
        sub = sub_dict.get('IT', i);
        voi_ids = unique([voi_ids, sub.get('VOI_DICT').get('KEYS')]);
    end
    if ~isempty(voi_ids)
        vois = cell(2 + sub_number, 1 + length(voi_ids));
        vois{1, 1} = 'Subject ID';
        vois(1, 2:end) = voi_ids;
        for i = 1:1:sub_number
            sub = sub_dict.get('IT', i);
            vois{2 + i, 1} = sub.get('ID');
            
            voi_dict = sub.get('VOI_DICT');
            for v = 1:1:voi_dict.get('LENGTH')
                voi = voi_dict.get('IT', v);
                voi_id = voi.get('ID');
                if isa(voi, 'VOINumeric') % Numeric
                    vois{2 + i, 1 + find(strcmp(voi_id, voi_ids))} = voi.get('V');
                elseif isa(voi, 'VOICategoric') % Categoric
                    categories = voi.get('CATEGORIES');
                    vois{2, 1 + find(strcmp(voi_id, voi_ids))} = cell2str(categories);
                    vois{2 + i, 1 + find(strcmp(voi_id, voi_ids))} = categories{voi.get('V')};
                end
            end
        end
        writetable(table(vois), [gr_directory '.vois.xlsx'], 'WriteVariableNames', false)
    end

    braph2waitbar(wb, 'close')
end

% sets value to empty
value = [];

%% ¡tests!

%%% ¡excluded_props!
[ExporterGroupSubjectCON_XLS.PUT_DIR]

%%% ¡test!
%%%% ¡name!
Delete directory TBE
%%%% ¡probability!
1
%%%% ¡code!
warning('off', 'MATLAB:DELETE:FileNotFound')
dir_to_be_erased = ExporterGroupSubjectCON_XLS.getPropDefault('DIRECTORY');
if isfolder(dir_to_be_erased)
    rmdir(dir_to_be_erased, 's')
end
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

sub1 = SubjectCON( ...
    'ID', 'SUB CON 1', ...
    'LABEL', 'Subejct CON 1', ...
    'NOTES', 'Notes on subject CON 1', ...
    'BA', ba, ...
    'CON', rand(ba.get('BR_DICT').get('LENGTH')) ...
    );
sub1.memorize('VOI_DICT').get('ADD', VOINumeric('ID', 'Age', 'V', 75))
sub1.memorize('VOI_DICT').get('ADD', VOICategoric('ID', 'Sex', 'CATEGORIES', {'Female', 'Male'}, 'V', find(strcmp('Female', {'Female', 'Male'}))))

sub2 = SubjectCON( ...
    'ID', 'SUB CON 2', ...
    'LABEL', 'Subejct CON 2', ...
    'NOTES', 'Notes on subject CON 2', ...
    'BA', ba, ...
    'CON', rand(ba.get('BR_DICT').get('LENGTH')) ...
    );
sub2.memorize('VOI_DICT').get('ADD', VOINumeric('ID', 'Age', 'V', 70))
sub2.memorize('VOI_DICT').get('ADD', VOICategoric('ID', 'Sex', 'CATEGORIES', {'Female', 'Male'}, 'V', find(strcmp('Male', {'Female', 'Male'}))))

sub3 = SubjectCON( ...
    'ID', 'SUB CON 3', ...
    'LABEL', 'Subejct CON 3', ...
    'NOTES', 'Notes on subject CON 3', ...
    'BA', ba, ...
    'CON', rand(ba.get('BR_DICT').get('LENGTH')) ...
    );
sub3.memorize('VOI_DICT').get('ADD', VOINumeric('ID', 'Age', 'V', 50))
sub3.memorize('VOI_DICT').get('ADD', VOICategoric('ID', 'Sex', 'CATEGORIES', {'Female', 'Male'}, 'V', find(strcmp('Female', {'Female', 'Male'}))))

gr = Group( ...
    'ID', 'GR CON', ...
    'LABEL', 'Group label', ...
    'NOTES', 'Group notes', ...
    'SUB_CLASS', 'SubjectCON', ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON', 'IT_LIST', {sub1, sub2, sub3}) ...
    );

directory = [fileparts(which('test_braph2')) filesep 'trial_group_subjects_CON_to_be_erased'];
if ~exist(directory, 'dir')
    mkdir(directory)
end

ex = ExporterGroupSubjectCON_XLS( ...
    'DIRECTORY', directory, ...
    'GR', gr ...
    );
ex.get('SAVE');

% import with same brain atlas
im1 = ImporterGroupSubjectCON_XLS( ...
    'DIRECTORY', [directory filesep() gr.get(Group.ID)], ...
    'BA', ba ...
    );
gr_loaded1 = im1.get('GR');

assert(gr.get('SUB_DICT').get('LENGTH') == gr_loaded1.get('SUB_DICT').get('LENGTH'), ...
	[BRAPH2.STR ':ExporterGroupSubjectCON_XLS:' BRAPH2.FAIL_TEST], ...
    'Problems saving or loading a group.')
for i = 1:1:max(gr.get('SUB_DICT').get('LENGTH'), gr_loaded1.get('SUB_DICT').get('LENGTH'))
    sub = gr.get('SUB_DICT').get('IT', i);
    sub_loaded = gr_loaded1.get('SUB_DICT').get('IT', i);    
    assert( ...
        isequal(sub.get('ID'), sub_loaded.get('ID')) & ...
        isequal(sub.get('BA'), sub_loaded.get('BA')) & ... 
        isequal(sub.get('VOI_DICT').get('IT', 'Age').get('V'), sub_loaded.get('VOI_DICT').get('IT', 'Age').get('V')) & ... 
        isequal(sub.get('VOI_DICT').get('IT', 'Sex').get('V'), sub_loaded.get('VOI_DICT').get('IT', 'Sex').get('V')) & ...
        isequal(sub.get('CON'), sub_loaded.get('CON')), ...
        [BRAPH2.STR ':ExporterGroupSubjectCON_XLS:' BRAPH2.FAIL_TEST], ...
        'Problems saving or loading a group.')    
end

% import with new brain atlas
im2 = ImporterGroupSubjectCON_XLS( ...
    'DIRECTORY', [directory filesep() gr.get(Group.ID)] ...
    );
gr_loaded2 = im2.get('GR');

assert(gr.get('SUB_DICT').get('LENGTH') == gr_loaded2.get('SUB_DICT').get('LENGTH'), ...
	[BRAPH2.STR ':ExporterGroupSubjectCON_XLS:' BRAPH2.FAIL_TEST], ...
    'Problems saving or loading a group.')
for i = 1:1:max(gr.get('SUB_DICT').get('LENGTH'), gr_loaded2.get('SUB_DICT').get('LENGTH'))
    sub = gr.get('SUB_DICT').get('IT', i);
    sub_loaded = gr_loaded2.get('SUB_DICT').get('IT', i);    
    assert( ...
        isequal(sub.get('ID'), sub_loaded.get('ID')) & ...
        ~isequal(sub.get('BA').get('ID'), sub_loaded.get('BA').get('ID')) & ...
        isequal(sub.get('VOI_DICT').get('IT', 'Age').get('V'), sub_loaded.get('VOI_DICT').get('IT', 'Age').get('V')) & ... 
        isequal(sub.get('VOI_DICT').get('IT', 'Sex').get('V'), sub_loaded.get('VOI_DICT').get('IT', 'Sex').get('V')) & ...
        isequal(sub.get('CON'), sub_loaded.get('CON')), ...
        [BRAPH2.STR ':ExporterGroupSubjectCON_XLS:' BRAPH2.FAIL_TEST], ...
        'Problems saving or loading a group.')    
end

rmdir(directory, 's')