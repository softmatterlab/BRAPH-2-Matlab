%% ¡header!
ExporterGroupSubjectCON_FUN_MP_TXT < Exporter (ex, exporter of CON and FUN subject groups in TXT) exports a group of subjects with connectivity data and functional data to a series of TXT files.

%%% ¡description!
ExporterGroupSubjectCON_FUN_MP_TXT exports a group of subjects with connectivity data and functional data to a series of TXT file and their covariates age and sex (if existing) to another TXT file.
All these files are saved in the same folder.
Each file contains a table of values corresponding to the adjacency matrix.
The TXT file containing the covariates consists of the following columns:
Subject ID (column 1), Subject AGE (column 2), and, Subject SEX (column 3).
The first row contains the headers and each subsequent row the values for each subject.

%%% ¡seealso!
Element, Exporter, ImporterGroupSubjectCON_TXT

%% ¡props!

%%% ¡prop!
GR (data, item) is a group of subjects with connectivity data and functional data.
%%%% ¡settings!
'Group'
%%%% ¡check_value!
check = any(strcmp(value.get(Group.SUB_CLASS_TAG), subclasses('SubjectCON_FUN_MP', [], [], true))); % Format.checkFormat(Format.ITEM, value, 'Group') already checked
%%%% ¡default!
Group('SUB_CLASS', 'SubjectCON_FUN_MP', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON_FUN_MP'))

%%% ¡prop!
DIRECTORY_CON (data, string) is the directory name where to save the group of subjects with connectivity data.
%%%% ¡default!
fileparts(which('test_braph2'))

%%% ¡prop!
DIRECTORY_FUN (data, string) is the directory name where to save the group of subjects with functional data.
%%%% ¡default!
fileparts(which('test_braph2'))

%%% ¡prop!
SAVE (result, empty) saves the group of subjects with connectivity data and functional data in TXT files in the selected directories.
%%%% ¡calculate!

directory_con = ex.get('DIRECTORY_CON');
gr = ex.get('GR');
grs_obj = SepareteGroupsCON_FUN( ...
    'GRP_CON_FUN_MP', gr);

grs = grs_obj.get('GRS');

if isfolder(directory_con) && length(grs) > 0
    if ex.get('WAITBAR')
        wb = waitbar(0, 'Calling first exporter path ...', 'Name', BRAPH2.NAME);
        set_braph2_icon(wb)
    end

    gr_directory = [directory_con filesep() gr.get('ID') '_CON'];
    if ~exist(gr_directory, 'dir')
        mkdir(gr_directory)
    end
    
    ex_con = ExporterGroupSubjectCON_TXT( ...
        'DIRECTORY', directory_con, ...
        'GR', grs{1} ...
        );
    ex_con.get('SAVE');    
    
    % sets value to empty
    value = [];
    
    if ex.get('WAITBAR')
        close(wb)
    end
else
    value = [];
end

directory_fun = ex.get('DIRECTORY_FUN');
if isfolder(directory_fun) && length(grs) > 0
    if ex.get('WAITBAR')
        wb = waitbar(0, 'Calling second exporter path ...', 'Name', BRAPH2.NAME);
        set_braph2_icon(wb)
    end

    gr_directory = [directory_fun filesep() gr.get('ID') '_FUN'];
    if ~exist(gr_directory, 'dir')
        mkdir(gr_directory)
    end
    
    ex_con = ExporterGroupSubjectFUN_TXT( ...
        'DIRECTORY', directory_fun, ...
        'GR', grs{2} ...
        );
    ex_con.get('SAVE');    
    
    % sets value to empty
    value = [];
    
    if ex.get('WAITBAR')
        close(wb)
    end
else
    value = [];
end

%% ¡methods!
function uigetdir(ex)
    % UIGETDIR opens a dialog box to set the directory where to save the group of subjects with connectivity data.
    
    directory = uigetdir('Select directory');
    if ischar(directory) && isfolder(directory)
        ex.set('DIRECTORY', directory);
    end
end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
export and import
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
    'BR_DICT', IndexedDictionary('IT_CLASS', 'BrainRegion', 'IT_KEY', 1, 'IT_LIST', {br1, br2, br3, br4, br5}) ...
    );
%con
sub1 = SubjectCON( ...
    'ID', 'SUB CON 1', ...
    'LABEL', 'Subject CON 1', ...
    'NOTES', 'Notes on subject CON 1', ...
    'BA', ba, ...
    'age', 75, ...
    'sex', 'female', ...
    'CON', rand(ba.get('BR_DICT').length()) ...
    );
sub2 = SubjectCON( ...
    'ID', 'SUB CON 2', ...
    'LABEL', 'Subject CON 2', ...
    'NOTES', 'Notes on subject CON 2', ...
    'BA', ba, ...
    'age', 70, ...
    'sex', 'male', ...
    'CON', rand(ba.get('BR_DICT').length()) ...
    );
sub3 = SubjectCON( ...
    'ID', 'SUB CON 3', ...
    'LABEL', 'Subject CON 3', ...
    'NOTES', 'Notes on subject CON 3', ...
    'BA', ba, ...
    'age', 50, ...
    'sex', 'female', ...
    'CON', rand(ba.get('BR_DICT').length()) ...
    );

gr_con = Group( ...
    'ID', 'GR CON', ...
    'LABEL', 'Group label', ...
    'NOTES', 'Group notes', ...
    'SUB_CLASS', 'SubjectCON', ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON', 'IT_KEY', 1, 'IT_LIST', {sub1, sub2, sub3}) ...
    );

% fun
sub1_fun = SubjectFUN( ...
    'ID', 'SUB FUN 1', ...
    'LABEL', 'Subject FUN 1', ...
    'NOTES', 'Notes on subject FUN 1', ...
    'BA', ba, ...
    'age', 75, ...
    'sex', 'female', ...
    'FUN', rand(10, ba.get('BR_DICT').length()) ...
    );

sub2_fun = SubjectFUN( ...
    'ID', 'SUB FUN 2', ...
    'LABEL', 'Subject FUN 2', ...
    'NOTES', 'Notes on subject FUN 2', ...
    'BA', ba, ...
    'age', 70, ...
    'sex', 'male', ...
    'FUN', rand(10, ba.get('BR_DICT').length()) ...
    );
sub3_fun = SubjectFUN( ...
    'ID', 'SUB FUN 3', ...
    'LABEL', 'Subject FUN 3', ...
    'NOTES', 'Notes on subject FUN 3', ...
    'BA', ba, ...
    'age', 50, ...
    'sex', 'female', ...
    'FUN', rand(10, ba.get('BR_DICT').length()) ...
    );

gr_fun = Group( ...
    'ID', 'GR FUN', ...
    'LABEL', 'Group label', ...
    'NOTES', 'Group notes', ...
    'SUB_CLASS', 'SubjectFUN', ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectFUN', 'IT_KEY', 1, 'IT_LIST', {sub1_fun, sub2_fun, sub3_fun}) ...
    );

% mix

co_gr1 = CombineGroups_CON_FUN( ...
    'GR1', gr_con, ...
    'GR2', gr_fun, ...
    'WAITBAR', true ...
    );


directory_con = [fileparts(which('test_braph2')) filesep 'trial_group_subjects_CON_to_be_erased'];
if ~exist(directory_con, 'dir')
    mkdir(directory_con)
end

directory_fun = [fileparts(which('test_braph2')) filesep 'trial_group_subjects_FUN_to_be_erased'];
if ~exist(directory_fun, 'dir')
    mkdir(directory_fun)
end

mixed_gr = co_gr1.get('GR');
ex = ExporterGroupSubjectCON_FUN_MP_TXT( ...
    'DIRECTORY_CON', directory_con, ...
    'DIRECTORY_FUN', directory_fun, ...
    'GR', mixed_gr ...
    );
ex.get('SAVE');

% import with same brain atlas
im1 = ImporterGroupSubjectCON_FUN_MP_TXT( ...
    'DIRECTORY_CON', directory_con, ...
    'DIRECTORY_FUN', directory_fun, ...
    'BA', ba ...
    );
gr_loaded1 = im1.get('GR');

assert(gr_con.get('SUB_DICT').length() == gr_loaded1.get('SUB_DICT').length(), ...
	[BRAPH2.STR ':ExporterGroupSubjectCON_FUN_MP_TXT:' BRAPH2.BUG_IO], ...
    'Problems saving or loading a group.')
for i = 1:1:max(gr_con.get('SUB_DICT').length(), gr_loaded1.get('SUB_DICT').length())
    sub_con = gr_con.get('SUB_DICT').getItem(i);
    sub_fun = gr_fun.get('SUB_DICT');getItem(i);
    sub_loaded = gr_loaded1.get('SUB_DICT').getItem(i);   
    data_cell = sub_loaded.get('CON_FUN_MP');
    assert( ...        
        isequal(sub.get('BA'), sub_loaded.get('BA')) & ...
        isequal(sub.get('AGE'), sub_loaded.get('AGE')) & ...
        isequal(sub.get('SEX'), sub_loaded.get('SEX')) & ...
        isequal(round(sub_con.get('CON'), 10), round(data_cell{1}, 10)), ...
        isequal(round(sub_fun.get('FUN'), 10), round(data_cell{2}, 10)), ...
        [BRAPH2.STR ':ExporterGroupSubjectCON_FUN_MP_TXT:' BRAPH2.BUG_IO], ...
        'Problems saving or loading a group.')    
end
rmdir(directory_con, 's')
rmdir(directory_fun, 's')