%% ¡header!
ImporterGroupSubjectST_XLS < Importer (im, importer of ST subject group from XLS/XLSX) imports a group of subjects with structural data from an XLS/XLSX file.

%%% ¡description!
ImporterGroupSubjectST_XLS imports a group of subjects with structural data 
 from an XLS/XLSX file named "GROUP_ID.xlsx". This file contains the 
 following columns: Subject ID (column 1), Subject LABEL (column 2), 
 Subject NOTES (column 3) and BrainRegions (columns 4-end; one brain region 
 value per column). The first row contains the headers and each subsequent 
 row the values for each subject.
The variables of interest are from another XLS/XLSX file named "GROUP_ID.vois.xlsx" 
 (if existing) consisting of the following columns: 
 Subject ID (column 1), covariates (subsequent columns). 
 The 1st row contains the headers, the 2nd row a string with the categorical
 variables of interest, and each subsequent row the values for each subject.

%%% ¡seealso!
Group, SubjectST, ExporterGroupSubjectST_XLS

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the ST subject group importer from XLS/XLSX.
%%%% ¡default!
'ImporterGroupSubjectST_XLS'

%%% ¡prop!
NAME (constant, string) is the name of the ST subject group importer from XLS/XLSX.
%%%% ¡default!
'Structural Subject Group XLS Importer'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the ST subject group importer from XLS/XLSX.
%%%% ¡default!
'ImporterGroupSubjectST_XLS imports a group of subjects with structural data and their covariates (optional) from another XLS/XLSX file.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the ST subject group importer from XLS/XLSX.
%%%% ¡settings!
'ImporterGroupSubjectST_XLS'

%%% ¡prop!
ID (data, string) is a few-letter code for the ST subject group importer from XLS/XLSX.
%%%% ¡default!
'ImporterGroupSubjectST_XLS ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the ST subject group importer from XLS/XLSX.
%%%% ¡default!
'ImporterGroupSubjectST_XLS label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the ST subject group importer from XLS/XLSX.
%%%% ¡default!
'ImporterGroupSubjectST_XLS notes'

%% ¡props!

%%% ¡prop!
FILE (data, string) is the XLS/XLSX file from where to load the ST subject group.
%%%% ¡default!
''

%%% ¡prop!
GET_FILE (query, item) opens a dialog box to set the XLS/XLSX file from where to load the ST subject group.
%%%% ¡settings!
'ImporterGroupSubjectST_XLS'
%%%% ¡calculate!
[filename, filepath, filterindex] = uigetfile({'*.xlsx';'*.xls'}, 'Select Excel file');
if filterindex
    file = [filepath filename];
    im.set('FILE', file);
end
value = im;

%%% ¡prop!
BA (data, item) is a brain atlas.
%%%% ¡settings!
'BrainAtlas'

%%% ¡prop!
GR (result, item) is a group of subjects with structural data.
%%%% ¡settings!
'Group'
%%%% ¡check_value!
check = any(strcmp(value.get(Group.SUB_CLASS_TAG), subclasses('SubjectST', [], [], true))); % Format.checkFormat(Format.ITEM, value, 'Group') already checked
%%%% ¡default!
Group('SUB_CLASS', 'SubjectST', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectST'))
%%%% ¡calculate!
% creates empty Group
gr = Group( ...
    'SUB_CLASS', 'SubjectST', ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectST') ...
    );

gr.lock('SUB_CLASS');

% analyzes file
file = im.get('FILE');
if isfile(file)
    wb = braph2waitbar(im.get('WAITBAR'), 0, 'Reading Directory ...');
    
    [~, ~, raw] = xlsread(file);
        
    try
        braph2waitbar(wb, .15, 'Loading subject group ...')
        
        [~, name, ext] = fileparts(file);
        gr.set( ...
            'ID', name, ...
            'LABEL', [name ext], ...
            'NOTES', ['Group loaded from ' file] ...
            );
        
        % brain atlas
        braph2waitbar(wb, .25, 'Loading brain atlas ...')
        ba = im.get('BA');
        br_number = size(raw, 2) - 3;
        if ba.get('BR_DICT').get('LENGTH') == 0
            % adds the number of regions of the first file to the brain atlas
            ba = BrainAtlas();
            br_dict = ba.memorize('BR_DICT');
            for j = 4:1:length(raw)
                br_id = raw{1, j};
                br = BrainRegion('ID', br_id);
                br_dict.get('ADD', br)
            end
        end
        if br_number ~= ba.get('BR_DICT').get('LENGTH')
            error( ...
                [BRAPH2.STR ':' class(im) ':' BRAPH2.ERR_IO], ...
                [BRAPH2.STR ':' class(im) ':' BRAPH2.ERR_IO '\\n' ...
                'The file ' name '.' ext ' should contain a matrix with ' int2str(ba.get('BR_DICT').get('LENGTH')) ' columns corresponding to the brain regions, ' ...
                'while it contains ' int2str(br_number) ' columns.'] ...
                )
        end
                
        % adds subjects
        sub_dict = gr.memorize('SUB_DICT');
        for i = 2:1:size(raw, 1)
            braph2waitbar(wb, .25 + .75 * (i - 1) / size(raw, 1), ['Loading subject ' num2str(i - 1) ' of ' num2str(size(raw, 1) - 1) ' ...'])
            
            ST = zeros(br_number, 1);
            for j = 1:1:length(ST)
                ST(j) = raw{i, 3 + j};
            end
            sub = SubjectST( ...
                'ID', num2str(raw{i, 1}), ...
                'LABEL', num2str(raw{i, 2}), ...
                'NOTES', num2str(raw{i, 3}), ...
                'BA', ba, ...
                'ST', ST ...
                );
            sub_dict.get('ADD', sub);
        end
        
        % variables of interest
        vois = [];
        if isfile([fileparts(file) filesep() name '.vois.xls'])
            [~, ~, vois] = xlsread([fileparts(file) filesep() name '.vois.xls']);
        elseif isfile([fileparts(file) filesep() name '.vois.xlsx'])
            [~, ~, vois] = xlsread([fileparts(file) filesep() name '.vois.xlsx']);
        end
        if ~isempty(vois)
            for i = 3:1:size(vois, 1)
                sub_id = vois{i, 1};
                sub = sub_dict.get('IT', sub_id);
                for v = 2:1:size(vois, 2)
                    voi_id = vois{1, v};
                    if isnumeric(vois{2, v}) % VOINumeric
                        sub.memorize('VOI_DICT').get('ADD', ...
                            VOINumeric( ...
                                'ID', voi_id, ...
                                'V', vois{i, v} ...
                                ) ...
                            );
                    elseif ischar(vois{2, v}) % VOICategoric
                        sub.memorize('VOI_DICT').get('ADD', ...
                            VOICategoric( ...
                                'ID', voi_id, ...
                                'CATEGORIES', str2cell(vois{2, v}), ...
                                'V', find(strcmp(vois{i, v}, str2cell(vois{2, v}))) ...
                                ) ...
                            );
                    end                        
                end
            end
        end
    catch e
        braph2waitbar(wb, 'close')

        rethrow(e)
    end
    
    braph2waitbar(wb, 'close')
elseif ~isempty(file)
    error([BRAPH2.STR ':ImporterGroupSubjectST_XLS:' BRAPH2.ERR_IO], ...
        [BRAPH2.STR ':ImporterGroupSubjectST_XLS:' BRAPH2.ERR_IO '\\n' ...
        'The prop FILE must be an existing file, but it is ''' file '''.'] ...
        );
end

value = gr;

%% ¡tests!

%%% ¡excluded_props!
[ImporterGroupSubjectST_XLS.GET_FILE]

%%% ¡test!
%%%% ¡name!
Create example files
%%%% ¡code!
create_data_ST_XLS() % only creates files if the example folder doesn't already exist

%%% ¡test!
%%%% ¡name!
GUI
%%%% ¡probability!
.01
%%%% ¡code!
im_ba = ImporterBrainAtlasXLS('FILE', [fileparts(which('SubjectST')) filesep 'Example data ST XLS' filesep 'atlas.xlsx']);
ba = im_ba.get('BA');

im_gr = ImporterGroupSubjectST_XLS( ...
    'FILE', [fileparts(which('SubjectST')) filesep 'Example data ST XLS' filesep 'ST_Group_1.xlsx'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );
gr = im_gr.get('GR');

gui = GUIElement('PE', gr, 'CLOSEREQ', false);
gui.get('DRAW')
gui.get('SHOW')

gui.get('CLOSE')