%% ¡header!
ExporterGroupSubjectCON_MP_TXT < Exporter (ex, exporter of CON MP subject group in TXT) exports a group of subjects with connectivity multiplex data to a series of TXT file.

%%% ¡description!
ExporterGroupSubjectCON_MP_TXT exports a group of subjects with connectivity 
 multiplex data to a series of tab-separated TXT files contained in a folder 
 named "GROUP_ID". All these files are saved in the same folder. Each file 
 contains a table of values corresponding to the adjacency matrix. Files 
 should be labeled with the layer number indicated as, e.g., 
 "SUBJECT_ID.1.txt" and "SUBJECT_ID.2.txt".
The variables of interest (if existing) are saved in another tab-separated 
 TXT file named "GROUP_ID.vois.txt" consisting of the following columns: 
 Subject ID (column 1), covariates (subsequent columns). 
 The 1st row contains the headers, the 2nd row a string with the categorical
 variables of interest, and each subsequent row the values for each subject.

%%% ¡seealso!
Group, SunbjectCON_MP, ImporterGroupSubjectCON_MP_TXT

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the CON MP subject group exporter in TXT.
%%%% ¡default!
'ExporterGroupSubjectCON_MP_TXT'

%%% ¡prop!
NAME (constant, string) is the name of the CON MP subject group exporter in TXT.
%%%% ¡default!
'Multiplex Connectivity Subject Group TXT Exporter'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the CON MP subject group exporter in TXT.
%%%% ¡default!
'ExporterGroupSubjectCON_MP_TXT exports a group of subjects with connectivity multiplex data to a series of TXT file and their covariates age and sex (if existing) to another TXT file.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the CON MP subject group exporter in TXT.
%%%% ¡settings!
'ExporterGroupSubjectCON_MP_TXT'

%%% ¡prop!
ID (data, string) is a few-letter code for the CON MP subject group exporter in TXT.
%%%% ¡default!
'ExporterGroupSubjectCON_MP_TXT ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the CON MP subject group exporter in TXT.
%%%% ¡default!
'ExporterGroupSubjectCON_MP_TXT label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the CON MP subject group exporter in TXT.
%%%% ¡default!
'ExporterGroupSubjectCON_MP_TXT notes'

%% ¡props!

%%% ¡prop!
GR (data, item) is a group of subjects with connectivity multiplex data.
%%%% ¡settings!
'Group'
%%%% ¡check_prop!
check = any(strcmp(value.get(Group.SUB_CLASS_TAG), subclasses('SubjectCON_MP', [], [], true))); 
%%%% ¡default!
Group('SUB_CLASS', 'SubjectCON_MP', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON_MP'))

%%% ¡prop!
DIRECTORY (data, string) is the directory name where to save the group of subjects with connectivity multiplex data.
%%%% ¡default!
[fileparts(which('test_braph2')) filesep 'default_group_subjects_CON_MP_most_likely_to_be_erased']

%%% ¡prop!
PUT_DIR (query, item) opens a dialog box to set the directory where to save the group of subjects with connectivity multiplex data.
%%%% ¡settings!
'ExporterGroupSubjectCON_MP_TXT'
%%%% ¡calculate!
directory = uigetdir('Select directory');
if ischar(directory) && isfolder(directory)
    ex.set('DIRECTORY', directory);
end
value = ex;

%%% ¡prop!
SAVE (result, empty) saves the group of subjects with connectivity multiplex data in TXT files in the selected directory.
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

        L = sub_dict.get('IT', 1).get('L');
        
        sub = sub_dict.get('IT', i);
        sub_id = sub.get('ID');
        sub_CON_MP = sub.get('CON_MP');
        
        for l = 1:1:L
            tab = table(sub_CON_MP{l});
            
            sub_file = [gr_directory filesep() sub_id '.' int2str(l) '.txt'];
            
            % save file
            writetable(tab, sub_file, 'Delimiter', '\t', 'WriteVariableNames', false);
        end
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
                    vois{2, 1 + find(strcmp(voi_id, voi_ids))} = {['{' sprintf(' ''%s'' ', categories{:}) '}']};
                    vois{2 + i, 1 + find(strcmp(voi_id, voi_ids))} = categories{voi.get('V')};
                end
            end
        end
        writetable(table(vois), [gr_directory '.vois.txt'], 'Delimiter', '\t', 'WriteVariableNames', false)
    end
    
    braph2waitbar(wb, 'close')
end

% sets value to empty
value = [];

%% ¡tests!

%%% ¡excluded_props!
[ExporterGroupSubjectCON_MP_TXT.PUT_DIR]

%%% ¡test!
%%%% ¡name!
Delete directory TBE
%%%% ¡probability!
1
%%%% ¡code!
warning('off', 'MATLAB:DELETE:FileNotFound')
dir_to_be_erased = ExporterGroupSubjectCON_MP_TXT.getPropDefault('DIRECTORY');
if isfolder(dir_to_be_erased)
    rmdir(dir_to_be_erased, 's')
end
warning('on', 'MATLAB:DELETE:FileNotFound')

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
    'BR_DICT', IndexedDictionary('IT_CLASS', 'BrainRegion', 'IT_LIST', {br1, br2, br3, br4, br5}) ...
    );

sub1 = SubjectCON_MP( ...
    'ID', 'SUB CON_MP 1', ...
    'LABEL', 'Subejct CON_MP 1', ...
    'NOTES', 'Notes on subject CON_MP 1', ...
    'BA', ba, ...
    'L', 2, ...
    'CON_MP', {rand(ba.get('BR_DICT').get('LENGTH'), ba.get('BR_DICT').get('LENGTH')), rand(ba.get('BR_DICT').get('LENGTH'), ba.get('BR_DICT').get('LENGTH'))} ...
    );
sub1.memorize('VOI_DICT').get('ADD', VOINumeric('ID', 'Age', 'V', 75))
sub1.memorize('VOI_DICT').get('ADD', VOICategoric('ID', 'Sex', 'CATEGORIES', {'Female', 'Male'}, 'V', find(strcmp('Female', {'Female', 'Male'}))))

sub2 = SubjectCON_MP( ...
    'ID', 'SUB CON_MP 2', ...
    'LABEL', 'Subejct CON_MP 2', ...
    'NOTES', 'Notes on subject CON_MP 2', ...
    'BA', ba, ...
    'L', 2, ...
    'CON_MP', {rand(ba.get('BR_DICT').get('LENGTH'), ba.get('BR_DICT').get('LENGTH')), rand(ba.get('BR_DICT').get('LENGTH'), ba.get('BR_DICT').get('LENGTH'))} ...
    );
sub2.memorize('VOI_DICT').get('ADD', VOINumeric('ID', 'Age', 'V', 70))
sub2.memorize('VOI_DICT').get('ADD', VOICategoric('ID', 'Sex', 'CATEGORIES', {'Female', 'Male'}, 'V', find(strcmp('Male', {'Female', 'Male'}))))

sub3 = SubjectCON_MP( ...
    'ID', 'SUB CON_MP 3', ...
    'LABEL', 'Subejct CON_MP 3', ...
    'NOTES', 'Notes on subject CON_MP 3', ...
    'BA', ba, ...
    'L', 2, ...
    'CON_MP', {rand(ba.get('BR_DICT').get('LENGTH'), ba.get('BR_DICT').get('LENGTH')), rand(ba.get('BR_DICT').get('LENGTH'), ba.get('BR_DICT').get('LENGTH'))} ...
    );
sub3.memorize('VOI_DICT').get('ADD', VOINumeric('ID', 'Age', 'V', 50))
sub3.memorize('VOI_DICT').get('ADD', VOICategoric('ID', 'Sex', 'CATEGORIES', {'Female', 'Male'}, 'V', find(strcmp('Female', {'Female', 'Male'}))))

gr = Group( ...
    'ID', 'GR CON', ...
    'LABEL', 'Group label', ...
    'NOTES', 'Group notes', ...
    'SUB_CLASS', 'SubjectCON_MP', ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON_MP', 'IT_LIST', {sub1, sub2, sub3}) ...
    );

directory = [fileparts(which('test_braph2')) filesep 'trial_group_subjects_CON_MP_to_be_erased'];
if ~exist(directory, 'dir')
    mkdir(directory)
end

ex = ExporterGroupSubjectCON_MP_TXT( ...
    'DIRECTORY', directory, ...
    'GR', gr ...
    );
ex.get('SAVE');

% import with same brain atlas
im1 = ImporterGroupSubjectCON_MP_TXT( ...
    'DIRECTORY', [directory filesep() gr.get(Group.ID)], ...
    'BA', ba ...
    );
gr_loaded1 = im1.get('GR');

assert(gr.get('SUB_DICT').get('LENGTH') == gr_loaded1.get('SUB_DICT').get('LENGTH'), ...
	[BRAPH2.STR ':ExporterGroupSubjectCON_MP_TXT:' BRAPH2.FAIL_TEST], ...
    'Problems saving or loading a group.')
for i = 1:1:max(gr.get('SUB_DICT').get('LENGTH'), gr_loaded1.get('SUB_DICT').get('LENGTH'))
    sub = gr.get('SUB_DICT').get('IT', i);
    sub_loaded = gr_loaded1.get('SUB_DICT').get('IT', i);    
    assert( ...
        isequal(sub.get('ID'), sub_loaded.get('ID')) & ...
        isequal(sub.get('BA'), sub_loaded.get('BA')) & ...
        isequal(sub.get('VOI_DICT').get('IT', 'Age').get('V'), sub_loaded.get('VOI_DICT').get('IT', 'Age').get('V')) & ... 
        isequal(sub.get('VOI_DICT').get('IT', 'Sex').get('V'), sub_loaded.get('VOI_DICT').get('IT', 'Sex').get('V')) & ...
        isequal(sub.get('L'), sub_loaded.get('L')) & ...
        isequal(cellfun(@(v) round(v, 10), sub.get('CON_MP'), 'UniformOutput', false), cellfun(@(v) round(v, 10), sub_loaded.get('CON_MP'), 'UniformOutput', false)), ...
        [BRAPH2.STR ':ExporterGroupSubjectCON_MP_TXT:' BRAPH2.FAIL_TEST], ...
        'Problems saving or loading a group.')    
end

% import with new brain atlas
im2 = ImporterGroupSubjectCON_MP_TXT( ...
    'DIRECTORY', [directory filesep() gr.get(Group.ID)] ...
    );
gr_loaded2 = im2.get('GR');

assert(gr.get('SUB_DICT').get('LENGTH') == gr_loaded2.get('SUB_DICT').get('LENGTH'), ...
	[BRAPH2.STR ':ExporterGroupSubjectCON_MP_TXT:' BRAPH2.FAIL_TEST], ...
    'Problems saving or loading a group.')
for i = 1:1:max(gr.get('SUB_DICT').get('LENGTH'), gr_loaded2.get('SUB_DICT').get('LENGTH'))
    sub = gr.get('SUB_DICT').get('IT', i);
    sub_loaded = gr_loaded2.get('SUB_DICT').get('IT', i);
    assert( ...
        isequal(sub.get('ID'), sub_loaded.get('ID')) & ...
        ~isequal(sub.get('BA').get('ID'), sub_loaded.get('BA').get('ID')) & ...
        isequal(sub.get('VOI_DICT').get('IT', 'Age').get('V'), sub_loaded.get('VOI_DICT').get('IT', 'Age').get('V')) & ... 
        isequal(sub.get('VOI_DICT').get('IT', 'Sex').get('V'), sub_loaded.get('VOI_DICT').get('IT', 'Sex').get('V')) & ...
        isequal(sub.get('L'), sub_loaded.get('L')) & ...
        isequal(cellfun(@(v) round(v, 10), sub.get('CON_MP'), 'UniformOutput', false), cellfun(@(v) round(v, 10), sub_loaded.get('CON_MP'), 'UniformOutput', false)), ...
        [BRAPH2.STR ':ExporterGroupSubjectCON_MP_TXT:' BRAPH2.FAIL_TEST], ...
        'Problems saving or loading a group.')     
end

rmdir(directory, 's')