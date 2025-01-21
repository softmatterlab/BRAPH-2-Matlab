%% ¡header!
ExporterGroupSubjectST_XLS < Exporter (ex, exporter of ST subject group in XLSX) exports a group of subjects with structural data to an XLSX file.

%%% ¡description!
ExporterGroupSubjectST_XLS exports a group of subjects with connectivity 
 data to an XLSX file with name "GROUP_ID.xlsx". This file contains a table 
 with the following columns: Subject ID (column 1), Subject LABEL (column 2), 
 Subject NOTES (column 3) and BrainRegions (columns 4-end; one brain region 
 value per column). The first row contains the headers and each subsequent 
 row the values for each subject.
The variables of interest (if existing) are saved in another XLSX file 
 named "GROUP_ID.vois.xlsx" consisting of the following columns: 
 Subject ID (column 1), covariates (subsequent columns). 
 The 1st row contains the headers, the 2nd row a string with the categorical
 variables of interest, and each subsequent row the values for each subject.

%%% ¡seealso!
Group, SubjectST, ImporterGroupSubjectST_XLS

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the ST subject group exporter in XLSX.
%%%% ¡default!
'ExporterGroupSubjectST_XLS'

%%% ¡prop!
NAME (constant, string) is the name of the ST subject group exporter in XLSX.
%%%% ¡default!
'Structural Subject Group XLS Exporter'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the ST subject group exporter in XLSX.
%%%% ¡default!
'ExporterGroupSubjectST_XLS exports a group of subjects with structural data and their covariates (if existing) to another XLSX file.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the ST subject group exporter in XLSX.
%%%% ¡settings!
'ExporterGroupSubjectST_XLS'

%%% ¡prop!
ID (data, string) is a few-letter code for the ST subject group exporter in XLSX.
%%%% ¡default!
'ExporterGroupSubjectST_XLS ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the ST subject group exporter in XLSX.
%%%% ¡default!
'ExporterGroupSubjectST_XLS label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the ST subject group exporter in XLSX.
%%%% ¡default!
'ExporterGroupSubjectST_XLS notes'

%% ¡props!

%%% ¡prop!
GR (data, item) is a group of subjects with structural data.
%%%% ¡settings!
'Group'
%%%% ¡check_value!
check = any(strcmp(value.get(Group.SUB_CLASS_TAG), subclasses('SubjectST', [], [], true))); % Format.checkFormat(Format.ITEM, value, 'Group') already checked
%%%% ¡default!
Group('SUB_CLASS', 'SubjectST', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectST'))

%%% ¡prop!
FILE (data, string) is the XLSX file name where to save the group of subjects with structural data.
%%%% ¡default!
[fileparts(which('test_braph2')) filesep 'default_xls_file_to_save_group_ST_most_likely_to_be_erased.xlsx']

%%% ¡prop!
PUT_FILE (query, item) opens a dialog box to set the XLSX file where to save the group of subjects with structural data.
%%%% ¡settings!
'ExporterGroupSubjectST_XLS'
%%%% ¡calculate!
[filename, filepath, filterindex] = uiputfile({'*.xlsx';'*.xls'}, 'Select Excel file');
if filterindex
    file = [filepath filename];
    ex.set('FILE', file);
end
value = ex;

%%% ¡prop!
SAVE (result, empty) saves the group of subjects with structural data in the selected XLSX file.
%%%% ¡calculate!
file = ex.get('FILE');

if isfolder(fileparts(file))
    wb = braph2waitbar(ex.get('WAITBAR'), 0, 'Retrieving path ...');
    
    gr = ex.get('GR');
    sub_dict = gr.get('SUB_DICT');
    sub_number = sub_dict.get('LENGTH');
    
	braph2waitbar(wb, .15, 'Organizing info ...')
    
    if sub_number == 0
        tab = {'ID', 'Label', 'Notes'};
    else
        sub = sub_dict.get('IT', 1);
        ba = sub.get('BA');
        br_list = cellfun(@(i) ba.get('BR_DICT').get('IT', i), ...
            num2cell([1:1:ba.get('BR_DICT').get('LENGTH')]), 'UniformOutput', false);
        br_labels = cellfun(@(br) br.get('ID'), br_list, 'UniformOutput', false);
        
        tab = cell(1 + sub_number, 3 + numel(br_labels));
        tab{1, 1} = 'ID';
        tab{1, 2} = 'Label';
        tab{1, 3} = 'Notes';
        for j = 1:1:length(br_labels)
            tab{1, 3 + j} = br_labels{j};
        end

        for i = 1:1:sub_number
            sub = sub_dict.get('IT', i);

            tab{1 + i, 1} = sub.get('ID');
            tab{1 + i, 2} = sub.get('LABEL');
            tab{1 + i, 3} = sub.get('NOTES');
            
            sub_ST = sub.get('ST');
            for j = 1:1:length(sub_ST)
                tab{1 + i, 3 + j} = sub_ST(j);
            end
        end
    end
    
    % save
	braph2waitbar(wb, 1, 'Finalizing ...')
        
    writetable(table(tab), file, 'WriteVariableNames', false);

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
        [dir, name, ext] = fileparts(file);
        writetable(table(vois), [dir filesep() name '.vois.xlsx'], 'WriteVariableNames', false)
    end
    
    braph2waitbar(wb, 'close')
end

% sets value to empty
value = [];

%% ¡tests!

%%% ¡excluded_props!
[ExporterGroupSubjectST_XLS.PUT_FILE]

%%% ¡test!
%%%% ¡name!
Delete file TBE
%%%% ¡probability!
1
%%%% ¡code!
warning('off', 'MATLAB:DELETE:FileNotFound')
delete([fileparts(which('test_braph2')) filesep 'default_xls_file_to_save_group_ST_most_likely_to_be_erased.xlsx'])
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

sub1 = SubjectST( ...
    'ID', 'SUB ST 1', ...
    'LABEL', 'Subejct ST 1', ...
    'NOTES', 'Notes on subject ST 1', ...
    'BA', ba, ...
    'ST', rand(ba.get('BR_DICT').get('LENGTH'), 1) ...
    );
sub1.memorize('VOI_DICT').get('ADD', VOINumeric('ID', 'Age', 'V', 75))
sub1.memorize('VOI_DICT').get('ADD', VOICategoric('ID', 'Sex', 'CATEGORIES', {'Female', 'Male'}, 'V', find(strcmp('Female', {'Female', 'Male'}))))

sub2 = SubjectST( ...
    'ID', 'SUB ST 2', ...
    'LABEL', 'Subejct ST 2', ...
    'NOTES', 'Notes on subject ST 2', ...
    'BA', ba, ...
    'ST', rand(ba.get('BR_DICT').get('LENGTH'), 1) ...
    );
sub2.memorize('VOI_DICT').get('ADD', VOINumeric('ID', 'Age', 'V', 70))
sub2.memorize('VOI_DICT').get('ADD', VOICategoric('ID', 'Sex', 'CATEGORIES', {'Female', 'Male'}, 'V', find(strcmp('Male', {'Female', 'Male'}))))

sub3 = SubjectST( ...
    'ID', 'SUB ST 3', ...
    'LABEL', 'Subejct ST 3', ...
    'NOTES', 'Notes on subject ST 3', ...
    'BA', ba, ...
    'ST', rand(ba.get('BR_DICT').get('LENGTH'), 1) ...
    );
sub3.memorize('VOI_DICT').get('ADD', VOINumeric('ID', 'Age', 'V', 50))
sub3.memorize('VOI_DICT').get('ADD', VOICategoric('ID', 'Sex', 'CATEGORIES', {'Female', 'Male'}, 'V', find(strcmp('Female', {'Female', 'Male'}))))

gr = Group( ...
    'ID', 'GR ST', ...
    'LABEL', 'Group label', ...
    'NOTES', 'Group notes', ...
    'SUB_CLASS', 'SubjectST', ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectST', 'IT_LIST', {sub1, sub2, sub3}) ...
    );

file = [fileparts(which('test_braph2')) filesep 'trial_group_subjects_ST_to_be_erased.xlsx'];

ex = ExporterGroupSubjectST_XLS( ...
    'FILE', file, ...
    'GR', gr ...
    );
ex.get('SAVE');

% import with same brain atlas
im1 = ImporterGroupSubjectST_XLS( ...
    'FILE', file, ...
    'BA', ba ...
    );
gr_loaded1 = im1.get('GR');

assert(gr.get('SUB_DICT').get('LENGTH') == gr_loaded1.get('SUB_DICT').get('LENGTH'), ...
	[BRAPH2.STR ':ExporterGroupSubjectST_XLS:' BRAPH2.FAIL_TEST], ...
    'Problems saving or loading a group.')
for i = 1:1:max(gr.get('SUB_DICT').get('LENGTH'), gr_loaded1.get('SUB_DICT').get('LENGTH'))
    sub = gr.get('SUB_DICT').get('IT', i);
    sub_loaded = gr_loaded1.get('SUB_DICT').get('IT', i);    
    assert( ...
        isequal(sub.get('ID'), sub_loaded.get('ID')) & ...
        isequal(sub.get('LABEL'), sub_loaded.get('LABEL')) & ...
        isequal(sub.get('NOTES'), sub_loaded.get('NOTES')) & ...
        isequal(sub.get('BA'), sub_loaded.get('BA')) & ...
        isequal(sub.get('VOI_DICT').get('IT', 'Age').get('V'), sub_loaded.get('VOI_DICT').get('IT', 'Age').get('V')) & ... 
        isequal(sub.get('VOI_DICT').get('IT', 'Sex').get('V'), sub_loaded.get('VOI_DICT').get('IT', 'Sex').get('V')) & ...
        isequal(sub.get('ST'), sub_loaded.get('ST')), ...
        [BRAPH2.STR ':ExporterGroupSubjectST_XLS:' BRAPH2.FAIL_TEST], ...
        'Problems saving or loading a group.')    
end

% import with new brain atlas
im2 = ImporterGroupSubjectST_XLS( ...
    'FILE', file ...
    );
gr_loaded2 = im2.get('GR');

assert(gr.get('SUB_DICT').get('LENGTH') == gr_loaded2.get('SUB_DICT').get('LENGTH'), ...
	[BRAPH2.STR ':ExporterGroupSubjectST_XLS:' BRAPH2.FAIL_TEST], ...
    'Problems saving or loading a group.')
for i = 1:1:max(gr.get('SUB_DICT').get('LENGTH'), gr_loaded2.get('SUB_DICT').get('LENGTH'))
    sub = gr.get('SUB_DICT').get('IT', i);
    sub_loaded = gr_loaded2.get('SUB_DICT').get('IT', i);    
    assert( ...
        isequal(sub.get('ID'), sub_loaded.get('ID')) & ...
        isequal(sub.get('LABEL'), sub_loaded.get('LABEL')) & ...
        isequal(sub.get('NOTES'), sub_loaded.get('NOTES')) & ...
        ~isequal(sub.get('BA').get('ID'), sub_loaded.get('BA').get('ID')) & ...
        isequal(sub.get('VOI_DICT').get('IT', 'Age').get('V'), sub_loaded.get('VOI_DICT').get('IT', 'Age').get('V')) & ... 
        isequal(sub.get('VOI_DICT').get('IT', 'Sex').get('V'), sub_loaded.get('VOI_DICT').get('IT', 'Sex').get('V')) & ...
        isequal(sub.get('ST'), sub_loaded.get('ST')), ...
        [BRAPH2.STR ':ExporterGroupSubjectST_XLS:' BRAPH2.FAIL_TEST], ...
        'Problems saving or loading a group.')    
end

delete(file)
delete([file(1:end-5) '.vois.xlsx'])